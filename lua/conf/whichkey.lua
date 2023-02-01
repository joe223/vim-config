local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
    return
end

local setup = {
    plugins = {
        marks = false, -- shows a list of your marks on ' and `
        registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        spelling = {
            enabled = false, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
            suggestions = 20, -- how many suggestions should be shown in the list?
        },
        -- the presets plugin, adds help for a bunch of default keybindings in Neovim
        -- No actual key bindings are created
        presets = {
            operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
            motions = false, -- adds help for motions
            text_objects = false, -- help for text objects triggered after entering an operator
            windows = true, -- default bindings on <c-w>
            nav = true, -- misc bindings to work with windows
            z = false, -- bindings for folds, spelling and others prefixed with z
            g = false, -- bindings for prefixed with g
        },
    },
    -- add operators that will trigger motion and text object completion
    -- to enable all native operators, set the preset / operators plugin above
    -- operators = { gc = "Comments" },
    key_labels = {
        -- override the label used to display some keys. It doesn't effect WK in any other way.
        -- For example:
        -- ["<space>"] = "SPC",
        -- ["<cr>"] = "RET",
        -- ["<tab>"] = "TAB",
    },
    icons = {
        breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
        separator = "➜", -- symbol used between a key and it's label
        group = "+", -- symbol prepended to a group
    },
    popup_mappings = {
        scroll_down = "<c-d>", -- binding to scroll down inside the popup
        scroll_up = "<c-u>", -- binding to scroll up inside the popup
    },
    window = {
        border = "rounded", -- none, single, double, shadow
        position = "bottom", -- bottom, top
        margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
        padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
        winblend = 0,
    },
    layout = {
        height = { min = 4, max = 25 }, -- min and max height of the columns
        width = { min = 20, max = 50 }, -- min and max width of the columns
        spacing = 3, -- spacing between columns
        align = "left", -- align columns left, center or right
    },
    ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
    hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
    show_help = true, -- show help message on the command line when the popup is visible
    triggers = "auto", -- automatically setup triggers
    -- triggers = {"<leader>"} -- or specify a list manually
    triggers_blacklist = {
        -- list of mode / prefixes that should never be hooked by WhichKey
        -- this is mostly relevant for key maps that start with a native binding
        -- most people should not need to change this
        i = { "j", "k" },
        v = { "j", "k" },
    },
}

local opts = {
    mode = "n", -- NORMAL mode
    prefix = "<Space><Space>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
    ["o"] = {
        "<cmd>AerialToggle<CR>", "Outline"
    },

    ["r"] = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
    ["c"] = { "<cmd>%bd|e#<CR>", "Close Other Buffers" },
    ["f"] = {
        "<cmd>FzfLua files<cr>",
        --    "<cmd>lua require('telescope.builtin').find_files()<cr>",
        -- "<cmd>lua require('telescope').extensions.frecenncy.frecency(require('telescope.themes').get_dropdown({ previewer = false }))<cr>",
        "Find files",
    },
    ["p"] = { "<cmd>Telescope projects<cr>", "Projects" },

    G = {
        name = "Git",
        f = { "<cmd>DiffviewFileHistory %<CR>", "File History(current file)" },
        p = { "<cmd>DiffviewOpen<CR>", "Diff Project" },
        n = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
        N = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
        l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
        r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
        R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
        s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
        S = { "<cmd>lua require 'gitsigns'.stage_buffer()<cr>", "Stage Hunk" },
        u = { "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", "Undo Stage Hunk", },
        U = { "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", "Undo Stage Hunk", },
        t = { "<cmd>Gitsigns setloclist<cr>", "Open changed file" },
        o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
        b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
        c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
        d = {
            "<cmd>Gitsigns diffthis HEAD<cr>",
            "Diff",
        },
    },

    R = {
        name = "Replace Content",
        f = { "Far - Replace File Content, e.g." ..
            "[:Far foo bar **/*.py] Start Match" ..
            "[:Fardo] Replace" ..
            "[:help far.vim] For help"
        },
        --f = { "<cmd>lua require('spectre').open_file_search()<CR>", "Replace File" },
        p = { "<cmd>lua require('spectre').open()<CR>", "Replace Project" },
        s = { "<cmd>lua require('spectre').open_visual({select_word=true})<CR>", "Search In Project" },
    },

    T = {
        name = "Trouble",
        t = { "<cmd>Trouble<cr>", "ToggleTrouble" },
        d = { "<cmd>Trouble document_diagnostics<cr>", "Document Diagnostics" },
        w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace Diagnostics" },
        q = { "<cmd>Trouble quickfix<cr>", "Quick Fix" },
        u = { "<cmd>Trouble lsp_references<cr>", "Usage" },
    },

    A = {
        name = "CodeAction",

        r = { "<cmd>Lspsaga rename<CR>", "Rename Symbols" },
        c = { "<cmd>Lspsaga code_action<CR>", "Show Actions" },
    },

    W = {
        name = "Workspace",
        r = { "<cmd>Telescope projects<CR>", "Open project list" }
    }
}
which_key.register(mappings, opts)
which_key.setup(setup)
