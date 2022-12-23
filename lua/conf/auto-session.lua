-- https://github.com/rmagatti/auto-session
local status_ok, auto_session = pcall(require, "auto-session")
if not status_ok then
    vim.notify("autos-ession not found!")
    return
end

vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"
auto_session.setup(
    {
        auto_session_enable_last_session = true,
        pre_save_cmds = { "tabdo NvimTreeClose" }
    }
)

vim.cmd([[
    autocmd VimLeavePre * silent! :SaveSession
]])
