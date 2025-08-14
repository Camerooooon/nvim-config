mason = require('mason');

mason.setup({})

local handle = io.popen("command -v avr-gcc") -- this gets path to program on unix
local avr_gcc
if handle then
    avr_gcc = handle:read("*a"):sub(1, -2)
    handle:close()
else 
    avr_gcc = nil;
end


-- local cmp = require('cmp')
-- local cmp_ultisnips_mappings = require('cmp_nvim_ultisnips.mappings')

-- local cmp_mappings = {
-- 	['<C-p>'] = cmp.mapping.select_prev_item(),
-- 	['<C-n>'] = cmp.mapping.select_next_item(),
-- 	-- Add tab support
--     ['<tab>'] = cmp.mapping(function(fallback)
--     if cmp.visible() then
--       cmp.select_next_item()
--     else
--       cmp_ultisnips_mappings.expand_or_jump_forwards(fallback)
--     end
--     end, { 'i', 's' }),
--     ['<S-tab>'] = cmp.mapping(function(fallback)
--     if cmp.visible() then
--       cmp.select_prev_item()
--     else
--       cmp_ultisnips_mappings.jump_backwards(fallback)
--     end
--     end, { 'i', 's' }),
-- 	['<C-d>'] = cmp.mapping.scroll_docs(-4),
-- 	['<C-f>'] = cmp.mapping.scroll_docs(4),
-- 	['<C-Space>'] = cmp.mapping.complete(),
-- 	['<C-e>'] = cmp.mapping.close(),
-- 	['<CR>'] = cmp.mapping.confirm({
-- 		behavior = cmp.ConfirmBehavior.Insert,
-- 		select = true,
-- 	})
-- }

vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)
-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set('n', '<space>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        -- vim.keymap.set('n', '<space>f', function()

        -- vim.lsp.buf.format { async = true }
        -- end, opts)
    end,
})

--- lsp.on_attach(function(client, bufnr)
--- 	local opts = {buffer = bufnr, remap = false}
--- 
--- 	--- Code navigation shortcuts
--- 	vim.keymap.set("n", "tf", function() vim.lsp.buf.hover() end, opts)
--- 	vim.keymap.set("n", "ti", function() vim.lsp.buf.implementation() end, opts)
--- 	vim.keymap.set("n", "tD", function() vim.lsp.buf.type_definition() end, opts)
--- 	vim.keymap.set("n", "tr", function() vim.lsp.buf.references() end, opts)
--- 	vim.keymap.set("n", "ts", function() vim.lsp.buf.document_symbol() end, opts)
--- 	vim.keymap.set("n", "tq", function() vim.lsp.buf.workspace_symbol() end, opts)
--- 	vim.keymap.set("n", "td", function() vim.lsp.buf.definition() end, opts)
--- 	vim.keymap.set("n", "ta", function() vim.lsp.buf.code_action() end, opts)
--- 	vim.keymap.set("n", "tR", function() vim.lsp.buf.rename() end, opts)
--- 
--- 	--- Diagnostics
--- 	vim.keymap.set("n", "to", function() vim.diagnostic.open_float() end, opts)
--- 	vim.keymap.set("n", "tj", function() vim.diagnostic.goto_prev() end, opts)
--- 	vim.keymap.set("n", "tk", function() vim.diagnostic.goto_next() end, opts)
--- 
--- 
--- end)

lspconfig = require('lspconfig')

lspconfig.tinymist.setup {}

lspconfig.clangd.setup { 
     -- cmd = {"/home/cameron/.local/share/nvim/mason/bin/clangd", "--query-driver=/home/cameron/Repos/InfiniTime/eabi-gcc/gcc-arm-none-eabi-10.3-2021.10-x86_64-linux/gcc-arm-none-eabi-10.3-2021.10/bin/arm-none-eabi-gcc"},
     cmd = {"/usr/bin/clangd", "--query-driver=**", "--clang-tidy", "--enable-config", "--background-index"},
}

-- vim.lsp.enable('jedi_language_server')

vim.lsp.enable('basedpyright')

vim.lsp.config('basedpyright', {
    cmd = {"/home/cameron/.local/share/nvim/mason/bin/basedpyright-langserver", "--stdio", "--verbose"},
    basedpyright = {
        analysis = {
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
            diagnosticMode = 'openFilesOnly',
            typeCheckingMode = 'off',
        },
    },
})

-- lspconfig.pylsp.setup {
--     on_attach=on_attach,
--     filetypes = {'python'},
--     settings = {
--         configurationSources = {"flake8"},
--         formatCommand = {"black"},
--         pylsp = {
--             plugins = {
--                 -- jedi_completion = {fuzzy = true},
--                 -- jedi_completion = {eager=true},
--                 jedi_completion = {
--                     include_params = true,
--                 },
--                 jedi_signature_help = {enabled = true},
--                 jedi = {
--                     extra_paths = {'~/projects/work_odoo/odoo14', '~/projects/work_odoo/odoo14'},
--                     -- environment = {"odoo"},
--                 },
--                 pyflakes={enabled=true},
--                 -- pylint = {args = {'--ignore=E501,E231', '-'}, enabled=true, debounce=200},
--                 pylsp_mypy={enabled=false},
--                 pycodestyle={
--                     enabled=true,
--                     ignore={'E501', 'E231', 'W391', 'E305', 'E302', 'W293', 'E303'}, -- disable annoying errors
--                     maxLineLength=120},
--                 yapf={enabled=true}
--             }
--         }
--     }
-- }

