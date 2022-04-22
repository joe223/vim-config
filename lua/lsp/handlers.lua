local M = {}

local config = {
    -- disable virtual text
    virtual_text = true,
    -- show signs
    signs = {
      active = signs,
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
}
M.setup = function ()
    vim.lsp.handlers["textDocument/hover"] = function ()
        return "hello"        
    end
    vim.lsp.handlers["textDocument/signatureHelp"] = function ()
       return "world !!" 
    end
    vim.cmd [[nnoremap <buffer><silent> <C-h> :lua vim.lsp.diagnostic.show_line_diagnostics({ border = "border" })<CR>]]
    vim.cmd [[nnoremap <buffer><silent> ]g :lua vim.lsp.diagnostic.goto_next({ popup_opts = { border = "border" }})<CR>]]
    vim.cmd [[nnoremap <buffer><silent> [g :lua vim.lsp.diagnostic.goto_prev({ popup_opts = { border = "border" }})<CR>]]

    vim.diagnostic.config(config)
end

print("LSP Hander ====")

return M
