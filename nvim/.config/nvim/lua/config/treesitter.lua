require 'nvim-treesitter.configs'.setup {
    auto_install = true,
    highlight = {
        enable = true,
    },
    indent = {
        enable = true
    },
    sync_install = false,
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
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = '<C-space>',
            node_incremental = '<C-space>',
            scope_incremental = false,
            node_decremental = '<bs>',
        },
    },
}
