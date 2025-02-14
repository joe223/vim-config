local nvim_command = vim.api.nvim_command
local M = {}
local signs = { {
    name = "DiagnosticSignError",
    text = ""
}, {
    name = "DiagnosticSignWarn",
    text = ""
}, {
    name = "DiagnosticSignHint",
    text = ""
}, {
    name = "DiagnosticSignInfo",
    text = ""
} }
-- https://github.dev/savq/melange/blob/master/colors/melange.vim

for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, {
        texthl = sign.name,
        text = sign.text,
        numhl = ""
    })
end

local config = {
    -- disable virtual text
    virtual_text = true,
    -- show signs
    signs = {
        active = signs
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
        focusable = false,
        -- style = "minimal",
        border = "rounded",
        source = "if_many",
        header = "🐰 🐱 🐶 🌛",
        prefix = ""
    }
}

local function diagnostic_highlight()
    vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", {
        cterm = undercurl,
        ctermfg = 1,
        undercurl = true,
        fg = "NONE",
        sp = "#EBCB8B"
    })
    vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", {
        cterm = undercurl,
        ctermfg = 1,
        undercurl = true,
        fg = "NONE",
        sp = "#BF616A"
    })
    vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", {
        cterm = undercurl,
        ctermfg = 1,
        undercurl = true,
        fg = "NONE",
        sp = "#88C0D0"
    })
    vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", {
        cterm = undercurl,
        ctermfg = 1,
        undercurl = true,
        fg = "NONE",
        sp = "#5E81AC"
    })
    vim.api.nvim_set_hl(0, "DiagnosticWarn", {
        ctermfg = 3,
        fg = "#EBCB8B"
    })
    vim.api.nvim_set_hl(0, "DiagnosticError", {
        ctermfg = 1,
        fg = "#BF616A"
    })
    vim.api.nvim_set_hl(0, "DiagnosticInfo", {
        ctermfg = 4,
        fg = "#88C0D0"
    })
    vim.api.nvim_set_hl(0, "DiagnosticHint", {
        ctermfg = 7,
        fg = "#5E81AC"
    })
end

M.setup = function()
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        -- Use a sharp border with `FloatBorder` highlights
        border = "rounded",
        focusable = false

    })

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        -- Use a sharp border with `FloatBorder` highlights
        border = "rounded",
        focusable = false

    })

    vim.diagnostic.config(config)
    diagnostic_highlight()
    vim.api.nvim_create_autocmd("CursorHold", {
        pattern = { "*" },
        command = "lua vim.diagnostic.open_float()"
    })
    vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = { "*" },
        command = "lua vim.lsp.buf.format()"
    })
end

local function lsp_highlight_document(client)
    if client.resolved_capabilities.document_highlight then
        local status_ok, illuminate = pcall(require, "illuminate")
        if not status_ok then
            return
        end
        illuminate.on_attach(client)
    end
end

local function lsp_keymaps(bufnr)
    local opts = {
        noremap = true,
        silent = true
    }

    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl',
        '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
    vim.cmd [[ command! Format execute 'lua vim.lsp.buf.format()' ]]
end

M.on_attach = function(client, bufnr)
    --vim.notify(client.name .. " starting...")
    lsp_keymaps(bufnr)
    lsp_highlight_document(client)
    require("aerial").on_attach(client, bufnr)
    require("lsp_signature").on_attach(client, bufnr)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
    return
end

M.capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

function M.enable_format_on_save()
    vim.cmd [[
    augroup format_on_save
      autocmd!
      autocmd BufWritePre * lua vim.lsp.buf.format()
    augroup end
  ]]
    vim.notify "Enabled format on save"
end

function M.disable_format_on_save()
    M.remove_augroup "format_on_save"
    vim.notify "Disabled format on save"
end

function M.toggle_format_on_save()
    if vim.fn.exists "#format_on_save#BufWritePre" == 0 then
        M.enable_format_on_save()
    else
        M.disable_format_on_save()
    end
end

function M.remove_augroup(name)
    if vim.fn.exists("#" .. name) == 1 then
        vim.cmd("au! " .. name)
    end
end

return M
