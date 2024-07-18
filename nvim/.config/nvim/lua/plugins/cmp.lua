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
                    buffer = '[Files]',
                    path = '[Path]',
                    calc = '[Calc]',
                    luasnip = '[Snip]',
                    spell = '[Spell]',
                })[entry.source.name]
                return vim_item
            end,
        },

        sources = cmp.config.sources({
            { name = 'calc' },
            { name = 'luasnip' },
            { name = 'nvim_lsp' },
            {
                name = 'buffer',
                option = {
                    get_bufnrs = function()
                        return vim.api.nvim_list_bufs()
                    end
                }
            },
            { name = 'path' },
            {
                name = 'spell',
                option = {
                    enable_in_context = function(params)
                        return require 'cmp.config.context'.in_treesitter_capture('spell')
                    end,
                }
            },
        }),
    }
end

local function setup_cmdline()
    local cmp = require 'cmp'

    cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),

        formatting = {
            fields = { 'abbr', 'menu' },

            format = function(entry, vim_item)
                vim_item.menu = ({
                    buffer = '[Files]',
                    path = '[Path]',
                    cmdline = '[Cmd]',
                })[entry.source.name]
                return vim_item
            end,
        },

        sources = cmp.config.sources({
            { name = 'path' },
            {
                name = 'buffer',
                option = {
                    get_bufnrs = function()
                        return vim.api.nvim_list_bufs()
                    end
                }
            },
            { name = 'cmdline', },
        })
    })
end

local function setup_searchline()
    local cmp = require 'cmp'

    cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),

        formatting = {
            fields = { 'abbr', 'menu' },

            format = function(entry, vim_item)
                vim_item.menu = ({
                    buffer = '[Files]',
                })[entry.source.name]
                return vim_item
            end,
        },

        sources = {
            {
                name = 'buffer',
                option = {
                    get_bufnrs = function()
                        return vim.api.nvim_list_bufs()
                    end
                }
            },
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
            'hrsh7th/cmp-calc',
            'f3fora/cmp-spell',
        },
    },

    {
        'L3MON4D3/LuaSnip',
        build = 'make install_jsregexp'
    },
}
