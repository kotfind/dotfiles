local function setup_normal()
    local cmp = require 'cmp'

    cmp.setup {
        snippet = {},

        mapping = cmp.mapping.preset.insert {
            ['<CR>'] = cmp.mapping.confirm({ select = true }),

            ['<Tab>'] = cmp.mapping(function(fallback)
                local col = vim.fn.col('.') - 1

                if cmp.visible() then
                    cmp.select_next_item()
                elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
                    fallback()
                else
                    cmp.complete()
                end
            end, { 'i', 's' }),

            ['<S-Tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                else
                    fallback()
                end
            end, { 'i', 's' }),
        },

        formatting = {
            fields = { 'abbr', 'menu' },

            format = function(entry, vim_item)
                vim_item.menu = ({
                    nvim_lsp = '[Lsp]',
                    buffer = '[File]',
                    path = '[Path]',
                })[entry.source.name]
                return vim_item
            end,
        },

        sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'buffer' },
            { name = 'path' },
            { name = 'nvim-cmp-ts-tag-close' },
        }),
    }
end

local function setup_cmdline()
    local cmp = require 'cmp'

    cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
            { name = 'path' }
        }, {
            {
                name = 'cmdline',
                option = {
                    ignore_cmds = { 'Man', '!' }
                }
            }
        })
    })
end

local function setup_searchline()
    local cmp = require 'cmp'

    cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
            { name = 'buffer' },
        },
    })
end

local function setup_cmp()
    setup_normal()
    setup_cmdline()
    setup_searchline()
end

return {
    {
        'hrsh7th/nvim-cmp',
        config = setup_cmp,
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'windwp/nvim-ts-autotag',
        },
    },

    { 'windwp/nvim-ts-autotag', opts = {} },
}
