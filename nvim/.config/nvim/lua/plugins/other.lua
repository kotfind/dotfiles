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

local function setup_comment()
    require 'ts_context_commentstring'.setup {
        enable_autocmd = false,
    }

    require 'Comment'.setup {
        pre_hook = require 'ts_context_commentstring.integrations.comment_nvim'.create_pre_hook(),
        toggler = {
            line = '<leader>/',
            block = '<leader>?',
        },
        opleader = {
            line = '<leader>/',
            block = '<leader>?',
        },
        extra = {
            above = '<leader>/O',
            below = '<leader>/o',
            eol = '<leader>/A',
        },
    }
end

return {
    -- Surround with braces
    { 'kylechui/nvim-surround', opts = {} },
    { 'm4xshen/autoclose.nvim', opts = {} },

    -- Substitute
    {
        'cshuaimin/ssr.nvim',
        config = setup_ssr,
    },

    -- Comment
    'JoosepAlviste/nvim-ts-context-commentstring',
    {
        'numToStr/Comment.nvim',
        config = setup_comment,
        dependencies = {
            'JoosepAlviste/nvim-ts-context-commentstring'
        }
    },
}
