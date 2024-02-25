vim.keymap.set("n", "<leader>p", ':lua require("nabla").toggle_virt()<CR> ')

vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "*.norg",
    command = ":lua require('nabla').enable_virt()"
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "norg",
	command = "setlocal textwidth=80 spell"
})
