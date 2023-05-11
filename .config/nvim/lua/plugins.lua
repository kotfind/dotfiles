-- Install plugins
require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use 'nvim-lualine/lualine.nvim'

    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'Issafalcon/lsp-overloads.nvim'

    use 'saadparwaiz1/cmp_luasnip'
    use 'rafamadriz/friendly-snippets'
    use 'L3MON4D3/LuaSnip'

    use 'alvan/vim-closetag'

    use({ 'vladdoster/remember.nvim', config = [[ require('remember') ]] })

    -- use 'lepture/vim-jinja'

    use 'tikhomirov/vim-glsl'

    use 'aklt/plantuml-syntax'
end)

---------- Lualine ----------

require('lualine').setup({
    options = {
        theme = 'auto',
    },
    sections = {
      lualine_a = {'mode'},
      lualine_b = {},
      lualine_c = {'filename'},
      lualine_x = {'encoding', 'filetype'},
      lualine_y = {'progress'},
      lualine_z = {'location'}
    },
})
