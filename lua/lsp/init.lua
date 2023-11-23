local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
    return
end

-- Autocomplete
require "lsp.cmp"
require "lsp.mason"
require "lsp.handlers".setup()
