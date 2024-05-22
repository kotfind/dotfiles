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
    {
        'scottmckendry/cyberdream.nvim',
        lazy = false,
        priority = 1000,
    },

	-- Lsp Icons
	{
		'onsails/lspkind.nvim',
		event = { 'VimEnter' },
	},

	-- Auto-completion engine
	{
		'hrsh7th/nvim-cmp',
		dependencies = {
			'lspkind.nvim',
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
}
