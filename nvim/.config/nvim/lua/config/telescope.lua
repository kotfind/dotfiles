local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>f', builtin.find_files)
vim.keymap.set('n', '<leader>g', builtin.live_grep)
vim.keymap.set('n', '<leader>h', builtin.help_tags)
vim.keymap.set('n', '<leader>s', builtin.lsp_document_symbols)
vim.keymap.set('n', '<leader>S', builtin.lsp_workspace_symbols)

require 'telescope'.setup {
    defaults = {
        sorting_strategy = 'ascending',
        layout_strategy = 'horizontal',
        layout_config = {
            width = 0.8,
            prompt_position = 'top',
            preview_width = 0.5,
        },
        mappings = {
            i = {
                ['<Tab>'] = 'move_selection_next',
                ['<S-Tab>'] = 'move_selection_previous',
                ['<esc>'] = 'close'
            }
        },
    }
}
