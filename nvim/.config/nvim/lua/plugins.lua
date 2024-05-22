local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable',
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require 'lazy'.setup {
    -- Colorscheme
    "scottmckendry/cyberdream.nvim",

    -- Lualine
    {
        'nvim-lualine/lualine.nvim',
        config = function ()
            require 'config.lualine'
        end
    },

    -- Pairs
    {
        'echasnovski/mini.pairs',
        opts = {},
	},

    {
        'windwp/nvim-ts-autotag',
        opts = {},
    },

    {
        'echasnovski/mini.surround',
        opts = {
            mappings = {
                add = 'gsa',
                delete = 'gsd',
                find = 'gsf',
                find_left = 'gsF',
                highlight = 'gsh',
                replace = 'gsr',
                update_n_lines = 'gsn',
            },
        },
    },

	-- Auto-completion engine
	{
		'hrsh7th/nvim-cmp',
		dependencies = {
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-buffer',
			'hrsh7th/cmp-path',
			'hrsh7th/cmp-cmdline',
		},
		config = function()
			require 'config.nvim-cmp'
		end,
	},

    -- LSP
	'williamboman/mason.nvim',
	'williamboman/mason-lspconfig.nvim',
	'neovim/nvim-lspconfig',

    -- Treesitter
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = function()
            require 'config.treesitter'
        end
    },

    {
        'nvim-treesitter/nvim-treesitter-context',
        opts = {},
    },

    -- Higlighth TODO, FIX, etc
    {
        'folke/todo-comments.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = {
            signs = false,
        },
    },

    -- Motions
    {
        'ggandor/flit.nvim',
        dependencies = {
            'ggandor/leap.nvim',
            'tpope/vim-repeat',
        },
        opts = {},
    },

    {
        'ggandor/leap.nvim',
        dependencies = {
            'tpope/vim-repeat',
        },
        config = function ()
            vim.keymap.set({'n', 'x', 'o'}, 's',  '<Plug>(leap-forward)')
            vim.keymap.set({'n', 'x', 'o'}, 'S',  '<Plug>(leap-backward)')
        end,
    },

    -- Telescope
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
        },
        config = function ()
            require 'config.telescope'
        end
    }
}
