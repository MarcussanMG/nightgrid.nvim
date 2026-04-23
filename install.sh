#!/usr/bin/env bash
set -Eeuo pipefail

REPO_NAME="nightgrid.nvim"
CONFIG_SRC_DIR="nvim"
NVIM_MIN_MAJOR=0
NVIM_MIN_MINOR=8

log() {
  printf '\n[+] %s\n' "$*"
}

warn() {
  printf '\n[!] %s\n' "$*" >&2
}

die() {
  printf '\n[ERROR] %s\n' "$*" >&2
  exit 1
}

have_cmd() {
  command -v "$1" >/dev/null 2>&1
}

require_linux() {
  [[ "$(uname -s)" == "Linux" ]] || die "This installer currently supports Linux only."
}

detect_package_manager() {
  if have_cmd apt-get; then
    echo "apt"
  elif have_cmd pacman; then
    echo "pacman"
  elif have_cmd dnf; then
    echo "dnf"
  else
    echo "unknown"
  fi
}

install_packages() {
  local pm
  pm="$(detect_package_manager)"

  case "$pm" in
    apt)
      log "Installing required packages with apt"
      sudo apt-get update
      sudo apt-get install -y \
        git wget curl tar unzip xz-utils ripgrep build-essential \
        fd-find nodejs npm python3 python3-pip
      ;;
    pacman)
      log "Installing required packages with pacman"
      sudo pacman -Sy --needed \
        git wget curl tar unzip xz ripgrep base-devel \
        fd nodejs npm python python-pip
      ;;
    dnf)
      log "Installing required packages with dnf"
      sudo dnf install -y \
        git wget curl tar unzip xz ripgrep gcc gcc-c++ make \
        fd-find nodejs npm python3 python3-pip
      ;;
    *)
      die "Unsupported package manager. Install manually: git wget curl tar unzip ripgrep nodejs npm python3."
      ;;
  esac
}

normalize_fd_binary() {
  if have_cmd fdfind && ! have_cmd fd; then
    local target="${HOME}/.local/bin"
    mkdir -p "$target"
    ln -sf "$(command -v fdfind)" "${target}/fd"
    case ":$PATH:" in
      *":${HOME}/.local/bin:"*) ;;
      *)
        warn "~/.local/bin is not in PATH. Add this to your shell config:"
        printf 'export PATH="$HOME/.local/bin:$PATH"\n'
        ;;
    esac
  fi
}

nvim_version_raw() {
  if have_cmd nvim; then
    nvim --version | head -n1 | sed -E 's/^NVIM v([0-9]+\.[0-9]+).*/\1/'
  else
    echo ""
  fi
}

nvim_version_ok() {
  local ver major minor
  ver="$(nvim_version_raw)"
  [[ -n "$ver" ]] || return 1

  major="${ver%%.*}"
  minor="${ver#*.}"
  minor="${minor%%.*}"

  if (( major > NVIM_MIN_MAJOR )); then
    return 0
  fi

  if (( major == NVIM_MIN_MAJOR && minor >= NVIM_MIN_MINOR )); then
    return 0
  fi

  return 1
}

install_newer_neovim() {
  local tmpdir arch url archive extracted_dir
  arch="$(uname -m)"

  case "$arch" in
    x86_64) archive="nvim-linux-x86_64.tar.gz" ;;
    aarch64|arm64) archive="nvim-linux-arm64.tar.gz" ;;
    *)
      die "Unsupported architecture: $arch"
      ;;
  esac

  url="https://github.com/neovim/neovim/releases/latest/download/${archive}"
  tmpdir="$(mktemp -d)"

  log "Installing newer Neovim from official release tarball"
  log "Downloading: $url"

  wget -O "${tmpdir}/${archive}" "$url"
  tar -xzf "${tmpdir}/${archive}" -C "$tmpdir"

  extracted_dir="$(find "$tmpdir" -maxdepth 1 -type d -name 'nvim-linux-*' | head -n1)"
  [[ -n "$extracted_dir" ]] || die "Failed to extract Neovim tarball."

  sudo rm -rf /opt/nvim
  sudo mv "$extracted_dir" /opt/nvim
  sudo ln -sf /opt/nvim/bin/nvim /usr/local/bin/nvim

  hash -r || true

  if ! /usr/local/bin/nvim --version >/dev/null 2>&1; then
    die "Installed Neovim but could not execute /usr/local/bin/nvim"
  fi

  log "Neovim installed successfully: $(/usr/local/bin/nvim --version | head -n1)"
}

ensure_neovim() {
  if nvim_version_ok; then
    log "Detected compatible Neovim: $(nvim --version | head -n1)"
  else
    warn "Neovim missing or too old. This config needs Neovim >= 0.8."
    install_newer_neovim
  fi
}

install_bash_language_server() {
  if have_cmd npm; then
    if ! have_cmd bash-language-server; then
      log "Installing bash-language-server via npm"
      sudo npm install -g bash-language-server
    else
      log "bash-language-server already installed"
    fi
  fi
}

get_script_dir() {
  cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd
}

install_config() {
  local script_dir src dest backup
  script_dir="$(get_script_dir)"
  src="${script_dir}/${CONFIG_SRC_DIR}"
  dest="${HOME}/.config/nvim"

  [[ -d "$src" ]] || die "Could not find config directory: $src"

  mkdir -p "${HOME}/.config"

  if [[ -e "$dest" && ! -L "$dest" ]]; then
    backup="${HOME}/.config/nvim.backup.$(date +%Y%m%d_%H%M%S)"
    warn "Existing Neovim config found. Backing it up to: $backup"
    mv "$dest" "$backup"
  elif [[ -L "$dest" ]]; then
    rm -f "$dest"
  fi

  log "Installing config to ${dest}"
  cp -a "$src" "$dest"

  log "Installed files:"
  find "$dest" -maxdepth 3 -type f | sort
}

post_install_notes() {
  cat <<'EOF'

[✓] Install complete.

Next steps:
  1. Run: nvim
  2. Wait for plugins to bootstrap on first launch
  3. Then inside Neovim run:
       :Lazy sync
       :Mason

Useful notes:
  - Your config will be installed in ~/.config/nvim
  - If Debian shipped an old Neovim, this script installs a newer one to /opt/nvim
  - /usr/local/bin/nvim is symlinked to the newer version

EOF
}

main() {
  require_linux
  install_packages
  normalize_fd_binary
  ensure_neovim
  install_bash_language_server
  install_config
  post_install_notes
}

main "$@"
