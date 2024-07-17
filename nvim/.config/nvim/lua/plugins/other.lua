local function setup_ssr()
    local ssr = require 'ssr'
    ssr.setup {
        keymaps = {
            close = 'q',
            next_match = 'n',
            prev_match = 'N',
            replace_confirm = '<cr>',
            replace_all = '<leader><cr>',
        },
    }

    Map({ 'n', 'x' }, '<leader>ss', ssr.open)
end

return {
    { 'kylechui/nvim-surround', opts = {} },
    { 'm4xshen/autoclose.nvim', opts = {} },
    {
        'cshuaimin/ssr.nvim',
        config = setup_ssr,
    },
}
