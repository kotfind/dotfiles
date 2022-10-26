-- Install plugins
require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use 'nvim-lualine/lualine.nvim'

    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-nvim-lsp'

    use 'saadparwaiz1/cmp_luasnip'
    use 'rafamadriz/friendly-snippets'
    use 'L3MON4D3/LuaSnip'

    use 'alvan/vim-closetag'

    use 'vladdoster/remember.nvim'
end)

---------- Lualine ----------
require('lualine').setup({
    options = {
        theme = 'auto'
    }
})
