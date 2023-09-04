local lsp = require('lsp-zero').preset({})

lsp.preset("recommended")

lsp.ensure_installed({
	'rust_analyzer',
})

local cmp = require('cmp')
local cmp_ultisnips_mappings = require('cmp_nvim_ultisnips.mappings')
local cmp_mappings = lsp.defaults.cmp_mappings({
	['<C-p>'] = cmp.mapping.select_prev_item(),
	['<C-n>'] = cmp.mapping.select_next_item(),
	-- Add tab support
    ['<tab>'] = cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_next_item()
    else
      cmp_ultisnips_mappings.expand_or_jump_forwards(fallback)
    end
    end, { 'i', 's' }),
    ['<S-tab>'] = cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_prev_item()
    else
      cmp_ultisnips_mappings.jump_backwards(fallback)
    end
    end, { 'i', 's' }),
	['<C-d>'] = cmp.mapping.scroll_docs(-4),
	['<C-f>'] = cmp.mapping.scroll_docs(4),
	['<C-Space>'] = cmp.mapping.complete(),
	['<C-e>'] = cmp.mapping.close(),
	['<CR>'] = cmp.mapping.confirm({
		behavior = cmp.ConfirmBehavior.Insert,
		select = true,
	})
})

lsp.setup_nvim_cmp({
	mapping = cmp_mappings
})

lsp.on_attach(function(client, bufnr)
	local opts = {buffer = bufnr, remap = false}

	--- Code navigation shortcuts
	vim.keymap.set("n", "tf", function() vim.lsp.buf.hover() end, opts)
	vim.keymap.set("n", "ti", function() vim.lsp.buf.implementation() end, opts)
	vim.keymap.set("n", "tD", function() vim.lsp.buf.type_definition() end, opts)
	vim.keymap.set("n", "tr", function() vim.lsp.buf.references() end, opts)
	vim.keymap.set("n", "ts", function() vim.lsp.buf.document_symbol() end, opts)
	vim.keymap.set("n", "tq", function() vim.lsp.buf.workspace_symbol() end, opts)
	vim.keymap.set("n", "td", function() vim.lsp.buf.definition() end, opts)
	vim.keymap.set("n", "ta", function() vim.lsp.buf.code_action() end, opts)
	vim.keymap.set("n", "tR", function() vim.lsp.buf.rename() end, opts)

	--- Diagnostics
	vim.keymap.set("n", "to", function() vim.diagnostic.open_float() end, opts)
	vim.keymap.set("n", "tj", function() vim.diagnostic.goto_prev() end, opts)
	vim.keymap.set("n", "tk", function() vim.diagnostic.goto_next() end, opts)


end)

lsp.setup()
