-- ============================================================
--  init.lua  —  Neovim config by Claude
--  Black / green terminal aesthetic
--  Works on Neovim 0.8+
-- ============================================================

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Disable netrw (we use nvim-tree)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- ============================================================
--  OPTIONS
-- ============================================================
local opt = vim.opt

opt.number         = true
opt.relativenumber = true
opt.cursorline     = true
opt.termguicolors  = true
opt.signcolumn     = "yes"
opt.wrap           = false
opt.scrolloff      = 8
opt.sidescrolloff  = 8
opt.clipboard      = "unnamedplus"
opt.mouse          = "a"

opt.ignorecase     = true
opt.smartcase      = true
opt.hlsearch       = true
opt.incsearch      = true

opt.tabstop        = 4
opt.shiftwidth     = 4
opt.softtabstop    = 4
opt.expandtab      = true
opt.smartindent    = true

opt.updatetime     = 250
opt.timeoutlen     = 300
opt.splitright     = true
opt.splitbelow     = true
opt.completeopt    = { "menu", "menuone", "noselect" }
opt.pumheight      = 10
opt.conceallevel   = 0
opt.fileencoding   = "utf-8"
opt.undofile       = true  -- persistent undo!
opt.swapfile       = false
opt.backup         = false
opt.writebackup    = false

-- ============================================================
--  BOOTSTRAP LAZY.NVIM
-- ============================================================
local uv       = vim.uv or vim.loop
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not uv.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

-- ============================================================
--  COLOUR PALETTE  (used in theme + highlights)
-- ============================================================
local C = {
    bg        = "#05070a",
    bg_soft   = "#090e0c",
    bg_panel  = "#0d1410",
    bg_float  = "#070b09",
    green     = "#22c55e",
    green_hi  = "#4ade80",
    green_dim = "#166534",
    green_sel = "#133320",
    fg        = "#d1fae5",
    fg_dim    = "#86efac",
    gray      = "#4b5e54",
    gray_hi   = "#7c8b84",
    red       = "#f87171",
    yellow    = "#fbbf24",
    blue      = "#60a5fa",
    cyan      = "#34d399",
}

-- ============================================================
--  PLUGINS
-- ============================================================
require("lazy").setup({

    -- --------------------------------------------------------
    --  COLORSCHEME  (custom overrides for black/green look)
    -- --------------------------------------------------------
    {
        "rebelot/kanagawa.nvim",
        priority = 1000,
        lazy = false,
        config = function()
            require("kanagawa").setup({
                compile = false,
                undercurl = true,
                commentStyle = { italic = true },
                keywordStyle = { italic = false, bold = true },
                transparent = false,
                dimInactive = false,
                terminalColors = true,
                colors = {
                    theme = {
                        all = {
                            ui = {
                                bg            = C.bg,
                                bg_gutter     = C.bg,
                                bg_m1         = C.bg_soft,
                                bg_m2         = C.bg_panel,
                                bg_m3         = C.bg_float,
                                bg_p1         = C.bg_soft,
                                bg_p2         = C.bg_panel,
                                fg            = C.fg,
                                fg_dim        = C.fg_dim,
                                special       = C.green,
                            },
                        },
                    },
                    palette = {
                        surimiOrange = C.yellow,
                        crystalBlue  = C.green_hi,
                        springGreen  = C.green,
                        autumnGreen  = C.green_hi,
                        waveAqua1    = C.cyan,
                        waveAqua2    = C.cyan,
                    },
                },
                overrides = function(colors)
                    local theme = colors.theme
                    return {
                        Normal          = { fg = C.fg,       bg = C.bg },
                        NormalFloat     = { fg = C.fg,       bg = C.bg_float },
                        FloatBorder     = { fg = C.green,    bg = C.bg_float },
                        FloatTitle      = { fg = C.green_hi, bg = C.bg_float, bold = true },
                        CursorLine      = { bg = C.bg_soft },
                        CursorLineNr    = { fg = C.green_hi, bold = true },
                        LineNr          = { fg = C.green_dim },
                        Visual          = { bg = C.green_sel },
                        VertSplit       = { fg = C.green_dim },
                        WinSeparator    = { fg = C.green_dim },
                        Pmenu           = { fg = C.fg,       bg = C.bg_float },
                        PmenuSel        = { fg = C.bg,       bg = C.green_hi, bold = true },
                        PmenuBorder     = { fg = C.green,    bg = C.bg_float },
                        Search          = { fg = C.bg,       bg = C.green },
                        IncSearch       = { fg = C.bg,       bg = C.green_hi },
                        StatusLine      = { fg = C.fg,       bg = C.bg_panel },
                        StatusLineNC    = { fg = C.gray_hi,  bg = C.bg_soft },
                        EndOfBuffer     = { fg = C.bg },
                        Comment         = { fg = C.gray_hi,  italic = true },
                        -- Telescope
                        TelescopeBorder          = { fg = C.green,    bg = C.bg_float },
                        TelescopePromptBorder    = { fg = C.green_hi, bg = C.bg_float },
                        TelescopeResultsBorder   = { fg = C.green,    bg = C.bg_float },
                        TelescopePreviewBorder   = { fg = C.green,    bg = C.bg_float },
                        TelescopeSelection       = { bg = C.green_sel },
                        TelescopeMatching        = { fg = C.green_hi, bold = true },
                        -- nvim-tree
                        NvimTreeNormal           = { fg = C.fg,       bg = C.bg },
                        NvimTreeNormalNC         = { bg = C.bg },
                        NvimTreeRootFolder       = { fg = C.green_hi, bold = true },
                        NvimTreeFolderName       = { fg = C.green },
                        NvimTreeOpenedFolderName = { fg = C.green_hi, bold = true },
                        NvimTreeEmptyFolderName  = { fg = C.gray_hi },
                        NvimTreeIndentMarker     = { fg = C.green_dim },
                        NvimTreeGitNew           = { fg = C.cyan },
                        NvimTreeGitDirty         = { fg = C.yellow },
                        -- Diagnostics
                        DiagnosticError          = { fg = C.red },
                        DiagnosticWarn           = { fg = C.yellow },
                        DiagnosticInfo           = { fg = C.cyan },
                        DiagnosticHint           = { fg = C.green },
                    }
                end,
            })
            vim.cmd.colorscheme("kanagawa-wave")
        end,
    },

    -- --------------------------------------------------------
    --  ICONS
    -- --------------------------------------------------------
    {
        "nvim-tree/nvim-web-devicons",
        lazy = true,
        config = function()
            require("nvim-web-devicons").setup({
                override_by_extension = {
                    py  = { icon = "󰌠", color = C.green_hi,  name = "Python" },
                    lua = { icon = "󰢱", color = C.green,     name = "Lua" },
                    sh  = { icon = "",  color = C.green_hi,  name = "Shell" },
                    md  = { icon = "󰍔", color = C.fg_dim,    name = "Markdown" },
                    rs  = { icon = "󱘗", color = C.yellow,    name = "Rust" },
                    js  = { icon = "󰌞", color = C.yellow,    name = "JS" },
                    ts  = { icon = "󰛦", color = C.blue,      name = "TS" },
                    json= { icon = "󰘦", color = C.fg_dim,    name = "JSON" },
                    yml = { icon = "󱁿", color = C.cyan,      name = "YAML" },
                    yaml= { icon = "󱁿", color = C.cyan,      name = "YAML" },
                    toml= { icon = "", color = C.gray_hi,   name = "TOML" },
                    txt = { icon = "󰈙", color = C.gray_hi,   name = "Text" },
                    html= { icon = "󰌝", color = C.red,       name = "HTML" },
                    css = { icon = "󰌜", color = C.blue,      name = "CSS" },
                    vim = { icon = "", color = C.green,     name = "Vim" },
                    go  = { icon = "󰟓", color = C.cyan,      name = "Go" },
                    c   = { icon = "", color = C.blue,      name = "C" },
                    cpp = { icon = "", color = C.blue,      name = "Cpp" },
                },
                default = true,
            })
        end,
    },

    -- --------------------------------------------------------
    --  DASHBOARD
    -- --------------------------------------------------------
    {
        "nvimdev/dashboard-nvim",
        event = "VimEnter",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("dashboard").setup({
                theme = "doom",
                config = {
                    header = {
                        "",
                        "",
                        "  ██████╗ ██╗   ██╗    ██████╗ ██╗      ██████╗  ██████╗██╗  ██╗",
                        "  ██╔══██╗╚██╗ ██╔╝    ██╔══██╗██║     ██╔═══██╗██╔════╝██║ ██╔╝",
                        "  ██████╔╝ ╚████╔╝     ██████╔╝██║     ██║   ██║██║     █████╔╝ ",
                        "  ██╔══██╗  ╚██╔╝      ██╔══██╗██║     ██║   ██║██║     ██╔═██╗ ",
                        "  ██████╔╝   ██║        ██████╔╝███████╗╚██████╔╝╚██████╗██║  ██╗",
                        "  ╚═════╝    ╚═╝        ╚═════╝ ╚══════╝ ╚═════╝  ╚═════╝╚═╝  ╚═╝",
                        "",
                        "              secure. minimal. green.  ──  neovim",
                        "",
                    },
                    center = {
                        {
                            icon = "  ",
                            icon_hl = "Title",
                            desc = "New File           ",
                            desc_hl = "String",
                            key = "e",
                            key_hl = "Number",
                            action = "ene | startinsert",
                        },
                        {
                            icon = "  ",
                            icon_hl = "Title",
                            desc = "Find File          ",
                            desc_hl = "String",
                            key = "f",
                            key_hl = "Number",
                            action = "Telescope find_files",
                        },
                        {
                            icon = "󰈬  ",
                            icon_hl = "Title",
                            desc = "Live Grep          ",
                            desc_hl = "String",
                            key = "g",
                            key_hl = "Number",
                            action = "Telescope live_grep",
                        },
                        {
                            icon = "  ",
                            icon_hl = "Title",
                            desc = "Recent Files       ",
                            desc_hl = "String",
                            key = "r",
                            key_hl = "Number",
                            action = "Telescope oldfiles",
                        },
                        {
                            icon = "  ",
                            icon_hl = "Title",
                            desc = "File Explorer      ",
                            desc_hl = "String",
                            key = "t",
                            key_hl = "Number",
                            action = "NvimTreeToggle",
                        },
                        {
                            icon = "  ",
                            icon_hl = "Title",
                            desc = "Edit Config        ",
                            desc_hl = "String",
                            key = "c",
                            key_hl = "Number",
                            action = "e ~/.config/nvim/init.lua",
                        },
                        {
                            icon = "  ",
                            icon_hl = "Title",
                            desc = "Quit               ",
                            desc_hl = "String",
                            key = "q",
                            key_hl = "Number",
                            action = "qa",
                        },
                    },
                    footer = {
                        "",
                        "  black / green workstation  ⬤  neovim ready",
                        "",
                    },
                },
            })
            -- Dashboard highlight overrides
            vim.api.nvim_set_hl(0, "DashboardHeader",  { fg = C.green,    bold = true })
            vim.api.nvim_set_hl(0, "DashboardCenter",  { fg = C.fg })
            vim.api.nvim_set_hl(0, "DashboardShortcut",{ fg = C.green_hi, bold = true })
            vim.api.nvim_set_hl(0, "DashboardFooter",  { fg = C.gray_hi,  italic = true })
        end,
    },

    -- --------------------------------------------------------
    --  FILE TREE
    -- --------------------------------------------------------
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("nvim-tree").setup({
                hijack_cursor = true,
                sync_root_with_cwd = true,
                respect_buf_cwd = true,
                view = {
                    width = 32,
                    side = "left",
                    preserve_window_proportions = true,
                },
                renderer = {
                    group_empty = true,
                    highlight_git = true,
                    highlight_opened_files = "name",
                    root_folder_label = false,
                    indent_markers = {
                        enable = true,
                        icons = { corner = "└", edge = "│", item = "│", none = " " },
                    },
                    icons = {
                        glyphs = {
                            default = "󰈙",
                            symlink = "",
                            bookmark = "󰆤",
                            folder = {
                                arrow_closed = "",
                                arrow_open   = "",
                                default      = "󰉋",
                                open         = "󰝰",
                                empty        = "󰉖",
                                empty_open   = "󰷏",
                                symlink      = "",
                                symlink_open = "",
                            },
                            git = {
                                unstaged  = "✗",
                                staged    = "✓",
                                unmerged  = "",
                                renamed   = "➜",
                                untracked = "★",
                                deleted   = "",
                                ignored   = "◌",
                            },
                        },
                    },
                },
                filters = { dotfiles = false },
                git = { enable = true, ignore = false },
                actions = {
                    open_file = {
                        quit_on_open = false,
                        window_picker = { enable = true },
                    },
                },
            })
        end,
    },

    -- --------------------------------------------------------
    --  TELESCOPE
    -- --------------------------------------------------------
    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        },
        config = function()
            local telescope = require("telescope")
            local actions   = require("telescope.actions")
            telescope.setup({
                defaults = {
                    prompt_prefix    = "   ",
                    selection_caret  = " ",
                    entry_prefix     = "  ",
                    sorting_strategy = "ascending",
                    layout_strategy  = "horizontal",
                    layout_config    = {
                        prompt_position = "top",
                        preview_width   = 0.55,
                        width           = 0.85,
                        height          = 0.80,
                    },
                    file_ignore_patterns = {
                        "node_modules", ".git/", "__pycache__", ".pyc",
                        "%.o", "%.a", "%.class",
                    },
                    mappings = {
                        i = {
                            ["<C-k>"]  = actions.move_selection_previous,
                            ["<C-j>"]  = actions.move_selection_next,
                            ["<C-q>"]  = actions.send_selected_to_qflist + actions.open_qflist,
                            ["<Esc>"]  = actions.close,
                        },
                    },
                },
                pickers = {
                    find_files    = { hidden = true },
                    live_grep     = { additional_args = { "--hidden" } },
                },
            })
            pcall(telescope.load_extension, "fzf")
        end,
    },

    -- --------------------------------------------------------
    --  LSP  (Language Server Protocol)
    -- --------------------------------------------------------
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
            { "j-hui/fidget.nvim", opts = {} },
        },
        config = function()
            require("mason").setup({
                ui = {
                    border = "rounded",
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗",
                    },
                },
            })

            require("mason-lspconfig").setup({
                ensure_installed = {
                    "pyright",
                    "lua_ls",
                    "bashls",
                    "jsonls",
                    "yamlls",
                    "html",
                    "cssls",
                    "ts_ls",
                },
                automatic_installation = true,
            })

            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            local on_attach = function(_, bufnr)
                local map = function(keys, func, desc)
                    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
                end

                local tb = require("telescope.builtin")
                map("gd", tb.lsp_definitions, "Goto Definition")
                map("gr", tb.lsp_references, "Goto References")
                map("gI", tb.lsp_implementations, "Goto Implementation")
                map("gy", tb.lsp_type_definitions, "Goto Type Definition")
                map("K", vim.lsp.buf.hover, "Hover Docs")
                map("<leader>rn", vim.lsp.buf.rename, "Rename Symbol")
                map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
                map("<leader>ds", tb.lsp_document_symbols, "Document Symbols")
                map("<leader>ws", tb.lsp_workspace_symbols, "Workspace Symbols")
                map("[d", vim.diagnostic.goto_prev, "Prev Diagnostic")
                map("]d", vim.diagnostic.goto_next, "Next Diagnostic")
                map("<leader>dl", tb.diagnostics, "List Diagnostics")
            end

            local servers = {
                pyright = {
                    settings = {
                        python = {
                            analysis = {
                                typeCheckingMode = "basic",
                                autoImportCompletions = true,
                                useLibraryCodeForTypes = true,
                            },
                        },
                    },
                },
                lua_ls = {
                    settings = {
                        Lua = {
                            runtime = { version = "LuaJIT" },
                            workspace = { checkThirdParty = false },
                            telemetry = { enable = false },
                            diagnostics = { globals = { "vim" } },
                        },
                    },
                },
                bashls = {},
                jsonls = {},
                yamlls = {},
                html = {},
                cssls = {},
                ts_ls = {},
            }

            if vim.lsp and vim.lsp.config and vim.lsp.enable then
                for server, opts in pairs(servers) do
                    opts.capabilities = capabilities
                    opts.on_attach = on_attach
                    vim.lsp.config(server, opts)
                    vim.lsp.enable(server)
                end
            else
                local lspconfig = require("lspconfig")
                for server, opts in pairs(servers) do
                    opts.capabilities = capabilities
                    opts.on_attach = on_attach
                    if lspconfig[server] then
                        lspconfig[server].setup(opts)
                    end
                end
            end

            vim.diagnostic.config({
                virtual_text = {
                    prefix = "●",
                    spacing = 4,
                },
                signs = true,
                underline = true,
                update_in_insert = false,
                severity_sort = true,
                float = {
                    border = "rounded",
                    source = "always",
                },
            })

            local signs = { Error = " ", Warn = " ", Hint = "󰌵 ", Info = " " }
            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
            end
        end,
    },

    -- --------------------------------------------------------
    --  AUTOCOMPLETION
    -- --------------------------------------------------------
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets",  -- snippet collection
            "onsails/lspkind.nvim",           -- icons in completion menu
        },
        config = function()
            local cmp     = require("cmp")
            local luasnip = require("luasnip")
            local lspkind = require("lspkind")

            require("luasnip.loaders.from_vscode").lazy_load()

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                window = {
                    completion    = cmp.config.window.bordered({
                        border      = "rounded",
                        winhighlight = "Normal:Pmenu,FloatBorder:PmenuBorder,CursorLine:PmenuSel",
                    }),
                    documentation = cmp.config.window.bordered({
                        border      = "rounded",
                        winhighlight = "Normal:Pmenu,FloatBorder:PmenuBorder",
                    }),
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-j>"]     = cmp.mapping.select_next_item(),
                    ["<C-k>"]     = cmp.mapping.select_prev_item(),
                    ["<C-b>"]     = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"]     = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"]     = cmp.mapping.abort(),
                    ["<Tab>"]     = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"]   = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<CR>"]      = cmp.mapping.confirm({ select = true }),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp", priority = 1000 },
                    { name = "luasnip",  priority = 750 },
                    { name = "buffer",   priority = 500, keyword_length = 3 },
                    { name = "path",     priority = 250 },
                }),
                formatting = {
                    format = lspkind.cmp_format({
                        mode            = "symbol_text",
                        maxwidth        = 50,
                        ellipsis_char   = "…",
                        symbol_map      = {
                            Text          = "󰉿",
                            Method        = "󰆧",
                            Function      = "󰊕",
                            Constructor   = "",
                            Field         = "󰜢",
                            Variable      = "󰀫",
                            Class         = "󰠱",
                            Interface     = "",
                            Module        = "",
                            Property      = "󰜢",
                            Unit          = "",
                            Value         = "󰎠",
                            Enum          = "",
                            Keyword       = "󰌋",
                            Snippet       = "",
                            Color         = "󰏘",
                            File          = "󰈙",
                            Reference     = "󰈇",
                            Folder        = "󰉋",
                            EnumMember    = "",
                            Constant      = "󰏿",
                            Struct        = "󰙅",
                            Event         = "",
                            Operator      = "󰆕",
                            TypeParameter = "󰊄",
                        },
                    }),
                },
            })

            -- Cmdline completions
            cmp.setup.cmdline({ "/", "?" }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = { { name = "buffer" } },
            })
            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources(
                    { { name = "path" } },
                    { { name = "cmdline" } }
                ),
            })
        end,
    },

    -- --------------------------------------------------------
    --  TERMINAL
    -- --------------------------------------------------------
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        keys = { "<leader>t", "<leader>T", "<C-t>" },
        config = function()
            require("toggleterm").setup({
                size = function(term)
                    if term.direction == "horizontal" then return 15
                    elseif term.direction == "vertical" then return vim.o.columns * 0.4
                    end
                end,
                open_mapping  = [[<C-t>]],
                hide_numbers  = true,
                direction     = "float",
                close_on_exit = true,
                shell         = vim.o.shell,
                float_opts    = {
                    border   = "curved",
                    winblend = 5,
                },
            })

            -- Dedicated terminals for common tools
            local Terminal = require("toggleterm.terminal").Terminal
            local lazygit  = Terminal:new({
                cmd = "lazygit",
                hidden = true,
                direction = "float",
                float_opts = { border = "curved" },
            })
            vim.keymap.set("n", "<leader>gg", function() lazygit:toggle() end,
                { desc = "Lazygit" })
        end,
    },

    -- --------------------------------------------------------
    --  GIT SIGNS
    -- --------------------------------------------------------
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require("gitsigns").setup({
                signs = {
                    add          = { text = "▎" },
                    change       = { text = "▎" },
                    delete       = { text = "" },
                    topdelete    = { text = "" },
                    changedelete = { text = "▎" },
                    untracked    = { text = "▎" },
                },
                on_attach = function(bufnr)
                    local gs = package.loaded.gitsigns
                    local map = function(mode, l, r, desc)
                        vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
                    end
                    map("n", "]h", gs.next_hunk,        "Next Hunk")
                    map("n", "[h", gs.prev_hunk,        "Prev Hunk")
                    map("n", "<leader>hs", gs.stage_hunk,   "Stage Hunk")
                    map("n", "<leader>hr", gs.reset_hunk,   "Reset Hunk")
                    map("n", "<leader>hp", gs.preview_hunk, "Preview Hunk")
                    map("n", "<leader>hb", gs.blame_line,   "Blame Line")
                    map("n", "<leader>hd", gs.diffthis,     "Diff This")
                end,
            })
        end,
    },

    -- --------------------------------------------------------
    --  STATUSLINE
    -- --------------------------------------------------------
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        event = "VeryLazy",
        config = function()
            local function lsp_active()
                local clients = vim.lsp.get_clients({ bufnr = 0 })
                if #clients == 0 then return "" end
                local names = {}
                for _, c in ipairs(clients) do
                    table.insert(names, c.name)
                end
                return "  " .. table.concat(names, " ")
            end

            require("lualine").setup({
                options = {
                    theme = {
                        normal   = { a = { fg = C.bg,      bg = C.green_hi, gui = "bold" },
                                     b = { fg = C.fg,      bg = C.bg_panel },
                                     c = { fg = C.fg_dim,  bg = C.bg_soft } },
                        insert   = { a = { fg = C.bg,      bg = C.cyan,     gui = "bold" } },
                        visual   = { a = { fg = C.bg,      bg = C.yellow,   gui = "bold" } },
                        replace  = { a = { fg = C.bg,      bg = C.red,      gui = "bold" } },
                        command  = { a = { fg = C.bg,      bg = C.green,    gui = "bold" } },
                        inactive = { a = { fg = C.gray,    bg = C.bg_soft },
                                     b = { fg = C.gray,    bg = C.bg_soft },
                                     c = { fg = C.gray,    bg = C.bg_soft } },
                    },
                    component_separators = { left = "", right = "" },
                    section_separators   = { left = "", right = "" },
                    globalstatus = true,
                },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = { "branch", "diff", "diagnostics" },
                    lualine_c = { { "filename", path = 1 } },
                    lualine_x = { lsp_active, "encoding", "fileformat", "filetype" },
                    lualine_y = { "progress" },
                    lualine_z = { "location" },
                },
            })
        end,
    },

    -- --------------------------------------------------------
    --  INDENT GUIDES
    -- --------------------------------------------------------
    {
        "lukas-reineke/indent-blankline.nvim",
        main  = "ibl",
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require("ibl").setup({
                indent = { char = "│", highlight = "IndentBlanklineChar" },
                scope  = { char = "│", highlight = "IndentBlanklineContextChar", enabled = true },
            })
            vim.api.nvim_set_hl(0, "IndentBlanklineChar",        { fg = "#1a2e24" })
            vim.api.nvim_set_hl(0, "IndentBlanklineContextChar", { fg = C.green_dim })
        end,
    },

    -- --------------------------------------------------------
    --  AUTO PAIRS
    -- --------------------------------------------------------
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            local autopairs = require("nvim-autopairs")
            autopairs.setup({ check_ts = true })
            -- hook into cmp
            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            local cmp = require("cmp")
            cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
    },

    -- --------------------------------------------------------
    --  COMMENTS
    -- --------------------------------------------------------
    {
        "numToStr/Comment.nvim",
        keys = { "gc", "gb", { "gc", mode = "v" }, { "gb", mode = "v" } },
        config = function()
            require("Comment").setup()
        end,
    },

    -- --------------------------------------------------------
    --  WHICH-KEY  (shows available keybindings)
    -- --------------------------------------------------------
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        config = function()
            local wk = require("which-key")

            wk.setup({
                preset = "modern",
                win = { border = "rounded" },
            })

            wk.add({
                { "<leader>f", group = "Find" },
                { "<leader>g", group = "Git" },
                { "<leader>w", group = "Window" },
                { "<leader>d", group = "Diagnostics" },
                { "<leader>t", group = "Terminal" },
                { "<leader>h", group = "Git Hunks" },
            })
        end,
    },

    -- --------------------------------------------------------
    --  SMOOTH SCROLL
    -- --------------------------------------------------------
    {
        "karb94/neoscroll.nvim",
        event = "WinScrolled",
        config = function()
            require("neoscroll").setup({ hide_cursor = false })
        end,
    },

    -- --------------------------------------------------------
    --  BETTER NOTIFICATIONS
    -- --------------------------------------------------------
    {
        "rcarriga/nvim-notify",
        event = "VeryLazy",
        config = function()
            local notify = require("notify")
            notify.setup({
                background_colour = C.bg,
                fps               = 60,
                render            = "compact",
                stages            = "fade_in_slide_out",
                timeout           = 3000,
                top_down          = true,
            })
            vim.notify = notify
        end,
    },

}, {
    -- Lazy.nvim UI settings
    ui = {
        border = "rounded",
        icons  = {
            cmd        = " ",
            config     = "",
            event      = "",
            ft         = " ",
            init       = " ",
            import     = " ",
            keys       = " ",
            lazy       = "󰒲 ",
            loaded     = "●",
            not_loaded = "○",
            plugin     = " ",
            runtime    = " ",
            require    = "󰢱 ",
            source     = " ",
            start      = "",
            task       = "✔ ",
            list       = { "●", "➜", "★", "‒" },
        },
    },
})

-- ============================================================
--  KEYMAPS
-- ============================================================
local map = function(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { desc = desc, silent = true, noremap = true })
end

-- File tree
map("n", "<leader>e",  ":NvimTreeToggle<CR>",   "Toggle File Tree")
map("n", "<leader>E",  ":NvimTreeFocus<CR>",    "Focus File Tree")

-- Telescope
map("n", "<leader>ff", ":Telescope find_files<CR>",   "Find Files")
map("n", "<leader>fg", ":Telescope live_grep<CR>",    "Live Grep")
map("n", "<leader>fb", ":Telescope buffers<CR>",      "Find Buffers")
map("n", "<leader>fh", ":Telescope help_tags<CR>",    "Help Tags")
map("n", "<leader>fr", ":Telescope oldfiles<CR>",     "Recent Files")
map("n", "<leader>fc", ":Telescope colorscheme<CR>",  "Colorschemes")

-- Buffers
map("n", "<S-l>",      ":bnext<CR>",    "Next Buffer")
map("n", "<S-h>",      ":bprevious<CR>","Prev Buffer")
map("n", "<leader>bd", ":bd<CR>",       "Delete Buffer")

-- Window management
map("n", "<leader>wv", ":vsplit<CR>",   "Vertical Split")
map("n", "<leader>wh", ":split<CR>",    "Horizontal Split")
map("n", "<leader>wq", ":close<CR>",    "Close Window")
map("n", "<C-h>",      "<C-w>h",        "Move Left")
map("n", "<C-l>",      "<C-w>l",        "Move Right")
map("n", "<C-j>",      "<C-w>j",        "Move Down")
map("n", "<C-k>",      "<C-w>k",        "Move Up")
map("n", "<C-Up>",     ":resize -2<CR>",         "Resize Up")
map("n", "<C-Down>",   ":resize +2<CR>",         "Resize Down")
map("n", "<C-Left>",   ":vertical resize -2<CR>","Resize Left")
map("n", "<C-Right>",  ":vertical resize +2<CR>","Resize Right")

-- Terminal
map("n", "<leader>t",  ":ToggleTerm direction=float<CR>",      "Float Terminal")
map("n", "<leader>th", ":ToggleTerm direction=horizontal<CR>", "Horizontal Terminal")
map("n", "<leader>tv", ":ToggleTerm direction=vertical<CR>",   "Vertical Terminal")
-- Exit terminal mode with Esc
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Save / quit
map("n", "<leader>w",  ":w<CR>",   "Save")
map("n", "<leader>W",  ":wa<CR>",  "Save All")
map("n", "<leader>q",  ":q<CR>",   "Quit")
map("n", "<leader>Q",  ":qa!<CR>", "Force Quit All")

-- Clear search highlight
map("n", "<Esc>",      ":nohlsearch<CR>", "Clear Highlights")

-- Better indent in visual mode (keeps selection)
map("v", "<",  "<gv", "Indent Left")
map("v", ">",  ">gv", "Indent Right")

-- Move lines in visual mode
map("v", "<A-j>", ":m '>+1<CR>gv=gv", "Move Line Down")
map("v", "<A-k>", ":m '<-2<CR>gv=gv", "Move Line Up")

-- ============================================================
--  AUTOCOMMANDS
-- ============================================================

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    group    = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
    end,
})

-- Restore cursor position on file open
vim.api.nvim_create_autocmd("BufReadPost", {
    group    = vim.api.nvim_create_augroup("restore_cursor", { clear = true }),
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

-- Close certain windows with q
vim.api.nvim_create_autocmd("FileType", {
    group    = vim.api.nvim_create_augroup("close_with_q", { clear = true }),
    pattern  = { "help", "notify", "qf", "lspinfo", "mason", "lazy" },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf })
    end,
})

-- Python specific: 4-space indent always
vim.api.nvim_create_autocmd("FileType", {
    group    = vim.api.nvim_create_augroup("python_indent", { clear = true }),
    pattern  = "python",
    callback = function()
        vim.opt_local.tabstop    = 4
        vim.opt_local.shiftwidth = 4
        vim.opt_local.expandtab  = true
    end,
})

-- ============================================================
--  END
-- ============================================================
