# 🌙 nightgrid.nvim

> Modern Neovim configuration with a **black / green workstation aesthetic**, built for developers, Linux users, cybersecurity workflows, and terminal-first productivity.

---

![Dashboard](assets/README.gif)

---

# ✨ Features

## 🎨 UI / Theme

- Custom black + green visual style
- Startup dashboard
- Clean statusline
- Better file icons
- Smooth floating windows
- Telescope themed search UI

## ⚡ Productivity

- Fast fuzzy file search
- Global text search
- File explorer
- Split window management
- Floating terminal
- Git integration
- Which-key shortcuts menu

## 🧠 Coding Features

- LSP (Language Server Protocol)
- Autocomplete
- Snippets
- Diagnostics / errors / warnings
- Go to definition
- Find references
- Rename symbols
- Code actions
- Treesitter syntax highlighting

## 🐍 Supported Languages

- Python
- Bash
- Lua
- JSON
- YAML
- HTML
- CSS
- JavaScript
- TypeScript
- Markdown
- Vimscript

---

# 📦 Included Plugins

| Plugin | Purpose |
|--------|---------|
| lazy.nvim | Plugin manager |
| Telescope | File / text search |
| nvim-tree | File explorer |
| Treesitter | Better syntax highlighting |
| Mason | LSP installer |
| nvim-lspconfig | Language servers |
| nvim-cmp | Autocomplete |
| LuaSnip | Snippets |
| Gitsigns | Git diff signs |
| ToggleTerm | Terminal inside Neovim |
| Lualine | Statusline |
| Which-key | Keybinding helper |
| Dashboard | Startup screen |
| Comment.nvim | Easy comments |

---

# 🚀 Installation

## Clone the Repository

```bash
git clone git@github.com:MarcussanMG/nightgrid.nvim.git
cd nightgrid.nvim
```

## Run Installer

```bash
bash install.sh
```

## What the Installer Does

The installer automatically:

- Installs required packages
- Checks Neovim version
- Upgrades Neovim if too old
- Installs Node/npm tools
- Installs Bash language server
- Copies config into:

```bash
~/.config/nvim
```

---

# 🧰 Packages Installed by Script

## Core Tools

- git
- wget
- curl
- tar
- unzip
- ripgrep
- fd / fdfind
- build-essential / base-devel

## Development Tools

- nodejs
- npm
- python3
- python3-pip

## Extra Tools

- bash-language-server

---

# ▶ First Launch

Run:

```bash
nvim
```

Then inside Neovim:

```vim
:Lazy sync
:Mason
```

---

# ⌨ Keybindings

## Leader Key

```text
Space
```

## Files

| Key | Action |
|-----|--------|
| Space e | Toggle file explorer |
| Space ff | Find files |
| Space fg | Search text |
| Space fb | Buffers |
| Space fr | Recent files |

## Windows

| Key | Action |
|-----|--------|
| Space wv | Vertical split |
| Space wh | Horizontal split |
| Ctrl+h/j/k/l | Move windows |

## Save / Quit

| Key | Action |
|-----|--------|
| Space w | Save |
| Space q | Quit |
| Space Q | Force quit |

## Terminal

| Key | Action |
|-----|--------|
| Space t | Floating terminal |
| Ctrl+t | Toggle terminal |

## LSP

| Key | Action |
|-----|--------|
| gd | Go to definition |
| gr | References |
| K | Hover docs |
| Space rn | Rename |
| Space ca | Code action |

---

# 📁 Repo Structure

```text
nightgrid.nvim/
├── install.sh
├── README.md
└── nvim/
    ├── init.lua
    └── lazy-lock.json
```

---

# 🔄 Updating

```bash
cd nightgrid.nvim
git pull
bash install.sh
```

Inside Neovim:

```vim
:Lazy update
:MasonUpdate
```

---

# 🛠 Troubleshooting

## Check Health

```vim
:checkhealth
```

## Reinstall Plugins

```vim
:Lazy clean
:Lazy sync
```

## Check Version

```bash
nvim --version
```

---

# 👤 Author

**Marc Martin Gil**

GitHub: https://github.com/MarcussanMG  
Portfolio: https://marcmartingil.com/
