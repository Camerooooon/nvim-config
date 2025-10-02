require("toggleterm").setup({
    shade_terminals = false,
    autochdir = true,
    float_opts = {
        winblend = 50
    }
})
local Terminal  = require('toggleterm.terminal').Terminal

local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = 'float' })
local powershell = Terminal:new({ cmd = "/bin/bash -c powershell.exe", hidden = true, direction = 'float' })
local bash = Terminal:new({ cmd = "/bin/bash", hidden = true, direction = 'horizontal' })

function _lazygit_toggle()
  lazygit:toggle()
end
function _powershell_toggle()
  powershell:toggle()
end
function _bash_toggle()
  bash:toggle()
end

function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  -- vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
end

vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
vim.api.nvim_set_keymap("n", "<leader>jg", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>jj", "<cmd>lua _bash_toggle()<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>jp", "<cmd>lua _powershell_toggle()<CR>", {noremap = true, silent = true})

