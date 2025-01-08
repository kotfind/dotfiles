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

function InTreeSitterTopLevelNode()
    local ts_utils = require 'nvim-treesitter.ts_utils'
    local node = ts_utils.get_node_at_cursor()
    print(node:parent())
    return node:parent() == nil
end

local function setup_textobjects()
    -- Text Objects List: https://github.com/nvim-treesitter/nvim-treesitter-textobjects?tab=readme-ov-file#built-in-textobjects
    local objects = {
        { 'f', 'function' },
        { 'l', 'loop' },
        { 'm', 'conditional' }, -- m is for "match"
        { 'c', 'class' },
        { 'n', 'comment' },     -- n is for "note"
        { 'a', 'parameter' },   -- a is for "argument"
        { 's', 'statement' },
    }

    local select = {}
    local goto_next_start = {}
    local goto_next_end = {}
    local goto_previous_start = {}
    local goto_previous_end = {}

    for _i, object in ipairs(objects) do
        local letter = object[1]
        local name = object[2]

        assert(letter:match('^%l$') ~= nil, 'lowercase letter expected')

        local inner = '@' .. name .. '.inner'
        local outer = '@' .. name .. '.outer'

        select['i' .. letter] = inner
        select['a' .. letter] = outer
        goto_next_start[']' .. letter] = outer
        goto_next_end[']' .. letter:upper()] = outer
        goto_previous_start['[' .. letter] = outer
        goto_previous_end['[' .. letter:upper()] = outer
    end

    require 'nvim-treesitter.configs'.setup {
        textobjects = {
            select = {
                enable = true,
                lookahead = true,

                keymaps = select,
            },

            move = {
                enable = true,
                set_jump = true,

                goto_next_start = goto_next_start,
                goto_next_end = goto_next_end,
                goto_previous_start = goto_previous_start,
                goto_previous_end = goto_previous_end,
            },
        }
    }

    -- make moves repeatable with ; and .
    local ts_repeat_move = require 'nvim-treesitter.textobjects.repeatable_move'

    Map({ 'n', 'x', 'o' }, ';', ts_repeat_move.repeat_last_move_next)
    Map({ 'n', 'x', 'o' }, ',', ts_repeat_move.repeat_last_move_previous)

    Map({ 'n', 'x', 'o' }, 'f', ts_repeat_move.builtin_f_expr, { expr = true })
    Map({ 'n', 'x', 'o' }, 'F', ts_repeat_move.builtin_F_expr, { expr = true })
    Map({ 'n', 'x', 'o' }, 't', ts_repeat_move.builtin_t_expr, { expr = true })
    Map({ 'n', 'x', 'o' }, 'T', ts_repeat_move.builtin_T_expr, { expr = true })
end

return {
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = setup_treesitter,
    },

    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
        },
        config = setup_textobjects,
    }
}
