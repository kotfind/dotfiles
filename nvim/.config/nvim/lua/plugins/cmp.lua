local function setup_normal()
    local cmp = require 'cmp'
    local luasnip = require 'luasnip'

    cmp.setup {
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body)
            end
        },

        mapping = cmp.mapping.preset.insert {
            ['<CR>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    if luasnip.expandable() then
                        luasnip.expand()
                    else
                        cmp.confirm({
                            select = true,
                        })
                    end
                else
                    fallback()
                end
            end),

            ["<Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif luasnip.locally_jumpable(1) then
                    luasnip.jump(1)
                else
                    fallback()
                end
            end, { "i", "s" }),

            ["<S-Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif luasnip.locally_jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end, { "i", "s" }),
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
            { name = 'luasnip' },
        }),
    }
end

local function setup_cmdline()
    local cmp = require 'cmp'

    cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
            { name = 'path' },
            {
                name = 'cmdline',
                option = {
                    ignore_cmds = { 'Man', '!' }
                }
            },
        })
    })
end

local function setup_searchline()
    local cmp = require 'cmp'

    cmp.setup.cmdline({ '/', '?' }, {
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
            'buschco/nvim-cmp-ts-tag-close'
        },
    },

    {
        'buschco/nvim-cmp-ts-tag-close',
        opts = {}
    },

    {
        'L3MON4D3/LuaSnip',
        build = 'make install_jsregexp'
    },
}
