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

    use 'nvim-treesitter/nvim-treesitter'

    -- use 'lukas-reineke/indent-blankline.nvim'

    use 'm4xshen/autoclose.nvim'
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

---------- TreeSitter --------------------

require('nvim-treesitter.configs').setup({
    ensure_installed = {
        "python",
        "bash",
        "c",
        "cpp",
        "latex",
    },

    -- Install languages synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- List of parsers to ignore installing
    ignore_install = { "" },

    highlight = {
        -- `false` will disable the whole extension
        enable = true,

        -- list of language that will be disabled
        disable = { "" },
    },

    indent = {
        -- dont enable this, messes up python indentation
        enable = false,
        disable = {},
    },
})

vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'

-- ---------- Blankline ----------
-- require("indent_blankline").setup {
--     -- for example, context is off by default, use this to turn it on
--     show_current_context = true,
--     show_current_context_start = true,
-- }

---------- Autoclose ----------
require("autoclose").setup()
