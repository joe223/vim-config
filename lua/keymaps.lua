local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap


-- FileExpoler
keymap("n", "<C-n>", ":NvimTreeFindFileToggle<cr>", opts)



-- Resize with arrows
keymap("n", "<M-Up>", ":resize -2<CR>", opts)
keymap("n", "<M-Down>", ":resize +2<CR>", opts)
keymap("n", "<M-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<M-Right>", ":vertical resize +2<CR>", opts)

-- Code Actions
--keymap("n", "gh", ":lua require'lspsaga.provider'.lsp_finder()<CR>", opts)
