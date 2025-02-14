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
    -----------------
    -- common deps --
    -----------------
    "nvim-lua/plenary.nvim",


    --------------
    -- Theme & UI
    --------------
    --"doums/darcula",
    "sainnhe/everforest",
    "nvim-tree/nvim-web-devicons",
    "Mofiqul/vscode.nvim",
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {
            indent = {
                char = "┆"
            }
        }
    },

    -------------
    -- UI
    -------------
    "rcarriga/nvim-notify",
    "stevearc/dressing.nvim",
    "folke/which-key.nvim",
    "nvim-telescope/telescope.nvim",
    "nvim-telescope/telescope-file-browser.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
    ----- Status line
    "feline-nvim/feline.nvim",
    ----- Scroll
    "petertriho/nvim-scrollbar",

    --{ 'kosayoda/nvim-lightbulb' },

    --------------
    -- Search
    ---------------
    { "ibhagwan/fzf-lua",        branch = "main" },
    "Marskey/telescope-sg",

    --------------
    -- LSP
    --------------

    -- For vsnip users
    'hrsh7th/cmp-vsnip',
    'hrsh7th/vim-vsnip',
    'hrsh7th/vim-vsnip-integ',
    --{ "neoclide/coc.nvim",       branch = "release" },
    { "akinsho/bufferline.nvim", tag = "*", },
    "neovim/nvim-lspconfig",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/nvim-cmp",
    "RRethy/vim-illuminate",
    "glepnir/lspsaga.nvim",
    "folke/todo-comments.nvim",
    "ray-x/lsp_signature.nvim",
    "christoomey/vim-tmux-navigator",
    "jiangmiao/auto-pairs",
    "kien/rainbow_parentheses.vim",
    "mattn/emmet-vim",
    "maxmellon/vim-jsx-pretty",
    "psliwka/vim-smoothie",
    --{
    --'ray-x/navigator.lua',
    --dependencies = {
    --{
    --'ray-x/guihua.lua',
    --build = 'cd lua/fzy && make'
    --},
    --{ 'neovim/nvim-lspconfig' }
    --}
    --},

    --- Add Tabby plugin
    "TabbyML/vim-tabby",

    --------------
    -- Code manage
    --------------
    -- A code outline window for skimming and quick navigation
    {
        'stevearc/aerial.nvim',
        opts = {},
        -- Optional dependencies
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons"
        },
    },
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
    "folke/trouble.nvim",
    "brooth/far.vim",
    "ahmedkhalf/project.nvim",
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate"
    },


    --------------
    -- File manage
    --------------
    { "akinsho/bufferline.nvim", tag = "*" },
    "kyazdani42/nvim-tree.lua",
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function() vim.fn["mkdp#util#install"]() end,
    },

    ---------------
    -- Editor -----
    ---------------
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "nvim-pack/nvim-spectre",
    {
        'goolord/alpha-nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require 'alpha'.setup(require 'alpha.themes.startify'.config)
        end
    }
}
local opts = {}

require("lazy").setup(plugins, opts)
