local function setup_treesitter()
    require 'nvim-treesitter.configs'.setup {
        ensure_installed = {
            'bash',
            'c',
            'cpp',
            'diff',
            'html',
            'css',
            'javascript',
            'json',
            'lua',
            'markdown',
            'markdown_inline',
            'python',
            'query',
            'toml',
            'vim',
            'vimdoc',
            'xml',
            'yaml',
            'rust',
            'nasm',
            'typst',
            'toml',
            'gitcommit',
            'comment',
        },

        auto_install = true,

        highlight = {
            enable = true,
        },

        playground = {
            enable = true,
        },
    }
end

function InTreeSitterNode(node_type)
    local ts_utils = require 'nvim-treesitter.ts_utils'
    local node = ts_utils.get_node_at_cursor()
    while node ~= nil do
        if node:type() == node_type then
            return true
        end
        node = node:parent()
    end
    return false
end

return {
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = setup_treesitter,
    },
}
