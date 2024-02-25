-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.2',
		-- or                            , branch = '0.1.x',
		requires = { {'nvim-lua/plenary.nvim'} }
	}
	use 'navarasu/onedark.nvim'
	use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
	use('ThePrimeagen/harpoon')
	use('mbbill/undotree')
	use({
		"kdheepak/lazygit.nvim",
		-- optional for floating window border decoration
		requires = {
			"nvim-lua/plenary.nvim",
		},
	})
    use('kyazdani42/nvim-web-devicons')
    use('kyazdani42/nvim-tree.lua')
    use { "zbirenbaum/copilot.lua" }
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},             -- Required
            {                                      -- Optional
            'williamboman/mason.nvim',
            run = function()
                pcall(vim.cmd, 'MasonUpdate')
            end,
            },
            {'williamboman/mason-lspconfig.nvim'}, -- Optional

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},     -- Required
            {'hrsh7th/cmp-nvim-lsp'}, -- Required
        }
    }
    use {"Camerooooon/vim-pandoc",
        branch = 'compiler-window'
        }
    use ("vim-pandoc/vim-pandoc-syntax")
    use ('skywind3000/asyncrun.vim')
    use ('SirVer/ultisnips')
    use ('lervag/vimtex')
    use("quangnguyen30192/cmp-nvim-ultisnips")
    use { "catppuccin/nvim", as = "catppuccin" }
    use 'shaunsingh/nord.nvim'
    use ('simrat39/rust-tools.nvim')
    use ('nvim-lua/lsp-status.nvim')
    use {'folke/zen-mode.nvim'}
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }
    use {'folke/twilight.nvim'}
    use {'rcarriga/nvim-notify'}
    use ('ThePrimeagen/vim-be-good')
    use {'nvim-telescope/telescope-ui-select.nvim'}
    use({
        "neanias/everforest-nvim",
        -- Optional; default configuration will be used if setup isn't called.
        config = function()
            require("everforest").setup()
        end,
    })
    use ('AlexvZyl/nordic.nvim')
    use {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    }
    use {
        "nvim-neorg/neorg",
        run = ":Neorg sync-parsers",
        requires = "nvim-lua/plenary.nvim",
    }
    use 'jbyuki/nabla.nvim'
    use '3rd/image.nvim'
    use 'nvim-neorg/tree-sitter-norg'
end)
