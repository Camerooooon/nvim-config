local cmp = require'cmp'
cmp.setup({
  -- Enable LSP snippets
  snippet = {
    expand = function(args)
        vim.fn["UltiSnips#Anon"](args.body)
    end,
  },
  -- Installed sources
  sources = {
    { name = 'nvim_lsp' },
    { name = 'neorg' },
    { name = 'ultisnips' },
    { name = 'path' },
    { name = 'buffer' },
  },
})
