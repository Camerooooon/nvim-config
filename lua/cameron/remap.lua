require"cameron.figure";
vim.g.mapleader = " "
vim.keymap.set("n", "tc", "<cmd>:cclose<CR>");

-- <leader>Y to go to system clipboard
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")


vim.keymap.set("i", "<C-l>", "<c-g>u<Esc>[s1z=']a<c-g>u")
-- inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u
--
vim.api.nvim_set_keymap('n', '<C-F>', ':lua InsertFigure()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-F>', '<Esc>:lua InsertFigure()<CR>', { noremap = true, silent = true })

