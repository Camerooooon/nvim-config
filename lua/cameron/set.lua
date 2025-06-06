
-- Relative line numbers
vim.opt.nu = true
vim.opt.relativenumber = true

-- Good indenting
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- No swap file but a long lasting undo system
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.updatetime = 50
vim.opt.scrolloff = 8

-- Disable ugly ~
vim.wo.fillchars='eob: '

vim.opt.title = true
-- vim.opt.cmdheight = 0
vim.opt.showmode = false

vim.api.nvim_create_autocmd("RecordingEnter", {
    callback = function()
        vim.opt.cmdheight = 1
    end,
})
vim.api.nvim_create_autocmd("RecordingLeave", {
    callback = function()
        vim.opt.cmdheight = 0
    end,
})
