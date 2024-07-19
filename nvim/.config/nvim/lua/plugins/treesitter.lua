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

return {
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = setup_treesitter,
    },
}
