require('blame').setup {
    date_format = "%m.%d.%Y",
}

vim.keymap.set("n", "<space>i", "<Cmd>BlameToggle<CR>")
