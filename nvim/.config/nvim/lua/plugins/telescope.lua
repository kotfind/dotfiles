local function setup_telescope()
    local builtin = require 'telescope.builtin'
    local actions = require 'telescope.actions'
    local previewers = require 'telescope.previewers'
    local telescope = require 'telescope'

    telescope.setup {
        defaults = {
            mappings = {
                i = {
                    ['<Tab>'] = actions.move_selection_next,
                    ['<S-Tab>'] = actions.move_selection_previous,
                    ['<c-j>'] = actions.move_selection_next,
                    ['<c-k>'] = actions.move_selection_previous,
                    ['<esc>'] = actions.close
                }
            },

            sorting_strategy = 'ascending',
            layout_strategy = 'horizontal',
            layout_config = {
                width = 0.8,
                prompt_position = 'top',
            },
        }
    }
    telescope.load_extension 'undo'

    Map('n', '<leader>ff', builtin.find_files)
    Map('n', '<leader>fg', builtin.live_grep)
    Map('n', '<leader>f*', builtin.grep_string)
    Map('n', '<leader>f/', builtin.current_buffer_fuzzy_find)
    Map('n', '<leader>fb', builtin.buffers)
    Map('n', '<leader>fu', '<cmd>Telescope undo<cr>')
    Map('n', '<leader>fs', builtin.lsp_document_symbols)
    Map('n', '<leader>fS', builtin.lsp_workspace_symbols)
    Map('n', '<leader>fe', function() builtin.diagnostics { bufnr = 0, severity_limit = "WARN" } end)
    Map('n', '<leader>fE', function() builtin.diagnostics { severity_limit = "WARN" } end)
end

return {
    'nvim-telescope/telescope.nvim',
    config = setup_telescope,
    dependencies = {
        'nvim-lua/popup.nvim',
        'nvim-lua/plenary.nvim',
        'kyazdani42/nvim-web-devicons',
        'nvim-telescope/telescope-symbols.nvim',
        'debugloop/telescope-undo.nvim',
    },
}
