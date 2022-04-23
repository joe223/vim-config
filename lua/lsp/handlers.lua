local M = {}
local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
}
for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

local config = {
    -- disable virtual text
    virtual_text = true,
    -- show signs
    signs = {
      active = signs,
    },
    update_in_insert = false,
    underline = false,
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
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
       vim.lsp.handlers.hover, {
         -- Use a sharp border with `FloatBorder` highlights
         border = "rounded"
       }
    )

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
       vim.lsp.handlers.signature_help, {
         -- Use a sharp border with `FloatBorder` highlights
         border = "rounded"
       }
    )

    vim.diagnostic.config(config)
end

return M
