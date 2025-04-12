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
    mapping = {
        ["<Tab>"] = cmp.mapping(
            function(fallback)
                cmp_ultisnips_mappings.expand_or_jump_forwards(fallback)
            end,
            { "i", "s", --[[ "c" (to enable the mapping in command mode) ]] }
        ),
        ["<S-Tab>"] = cmp.mapping(
            function(fallback)
                cmp_ultisnips_mappings.jump_backwards(fallback)
            end,
            { "i", "s", --[[ "c" (to enable the mapping in command mode) ]] }
        ),
    },
})
