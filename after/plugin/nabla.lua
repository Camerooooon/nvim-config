vim.keymap.set("n", "<leader>p", ':lua require("nabla").toggle_virt()<CR> ')

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.norg",
    command = ":lua require('nabla').enable_virt()"
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "norg",
	command = "setlocal textwidth=80 spell"
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "norg",
	command = ":lua require('nabla').enable_virt()"
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "norg",
	command = "set concealcursor=n"
})
vim.api.nvim_create_autocmd("FileType", {
	pattern = "norg",
	command = "set laststatus=0"
})
vim.api.nvim_create_autocmd("FileType", {
	pattern = "norg",
	command = ":setlocal nonumber norelativenumber"
})
vim.api.nvim_create_autocmd("InsertEnter", {
	pattern = "*.norg",
	command = "set concealcursor=v"
})
vim.api.nvim_create_autocmd("InsertEnter", {
	pattern = "*.norg",
	command = "set laststatus=2"
})
vim.api.nvim_create_autocmd("InsertEnter", {
	pattern = "*.norg",
	command = "setlocal relativenumber"
})
