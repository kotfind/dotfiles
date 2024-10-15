local function setup_snippets()
    local luasnip = require 'luasnip'

    luasnip.setup {}

    luasnip.config.setup {
        enable_autosnippets = true,
        store_selection_keys = '<C-j>',
    }

    require 'luasnip.loaders.from_lua'.lazy_load {
        paths = './snippets'
    }
end

return {
    {
        'L3MON4D3/LuaSnip',
        build = 'make install_jsregexp',
        config = setup_snippets,
    }
}
