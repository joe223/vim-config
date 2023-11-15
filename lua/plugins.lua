local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--single-branch",
        "https://github.com/folke/lazy.nvim.git",
        lazypath,
    })
end

vim.opt.runtimepath:prepend(lazypath)

local plugins = {
    -------------
    -- UI
    -------------
    "rcarriga/nvim-notify",
    "stevearc/dressing.nvim",
    "folke/which-key.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    "nvim-telescope/telescope-file-browser.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
    ----- Status line
    "feline-nvim/feline.nvim",
    ----- Scroll
    "petertriho/nvim-scrollbar",

    --------------
    -- Search
    ---------------
    { "ibhagwan/fzf-lua", branch = "main" },

    --------------
    -- Theme & UI
    --------------
    "doums/darcula",
    { "ryanoasis/vim-devicons" },
    { "kyazdani42/nvim-web-devicons" },
    "Mofiqul/vscode.nvim",
    "doums/darcula",
    "lukas-reineke/indent-blankline.nvim",

    --------------
    -- LSP
    --------------
    { "akinsho/bufferline.nvim", tag = "*", },
    "neovim/nvim-lspconfig",
    "williamboman/nvim-lsp-installer",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/nvim-cmp",
    "saadparwaiz1/cmp_luasnip",
    "L3MON4D3/LuaSnip",
    "RRethy/vim-illuminate",
    "glepnir/lspsaga.nvim",
    "folke/todo-comments.nvim",
    "ray-x/lsp_signature.nvim",
    "christoomey/vim-tmux-navigator",
    "jiangmiao/auto-pairs",
    "kien/rainbow_parentheses.vim",
    "mattn/emmet-vim",
    "maxmellon/vim-jsx-pretty",
    "mhinz/vim-startify",
    -- { "neoclide/coc.nvim", branch = "release" },
    "psliwka/vim-smoothie",

    --------------
    -- Code manage
    --------------
    -- A code outline window for skimming and quick navigation
    "stevearc/aerial.nvim",
    "sheerun/vim-polyglot",
    "scrooloose/nerdcommenter",

    --------------
    -- Version Control
    --------------
    "sindrets/diffview.nvim",
    "lewis6991/gitsigns.nvim",
    "tpope/vim-fugitive",

    --------------
    -- Project manage
    ----------------
    "rmagatti/auto-session",
    "folke/trouble.nvim",
    "brooth/far.vim",
    "ahmedkhalf/project.nvim",
    -- {"nvim-treesitter/nvim-treesitter", config = {do = ":TSUpdate"}},


    --------------
    -- File manage
    --------------
    -- { "iamcco/markdown-preview.nvim", do = "cd app && yarn install"  }
    { "akinsho/bufferline.nvim", tag = "*" },
    "kyazdani42/nvim-tree.lua",

    ---------------
    -- Editor -----
    ---------------
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim"
}
local opts = {}

require("lazy").setup(plugins, opts)
