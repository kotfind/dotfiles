function Map(modes, key, func, opts)
    if opts == nil then
        opts = {
            noremap = true,
            silent = true,
        }
    end

    vim.keymap.set(modes, key, func, opts)
end

function Feed(keys)
    vim.fn.feedkeys(vim.api.nvim_replace_termcodes(keys, true, true, true), true)
end

-- Langmap
vim.opt.langmap =
'ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz'

-- Set leader
vim.g.mapleader = ' '
Map('n', '<space>', '')

-- Move between windows
Map({ 'n', 't' }, '<C-h>', '<C-w>h')
Map({ 'n', 't' }, '<C-j>', '<C-w>j')
Map({ 'n', 't' }, '<C-k>', '<C-w>k')
Map({ 'n', 't' }, '<C-l>', '<C-w>l')

-- Reselect on shift
Map('v', '<', '<gv')
Map('v', '>', '>gv')

-- Move on wrapped lines
Map({ 'n', 'x' }, 'j', 'gj')
Map({ 'n', 'x' }, 'k', 'gk')
Map({ 'n', 'x' }, '^', 'g^')
Map({ 'n', 'x' }, '$', 'g$')

Map({ 'n', 'x' }, 'gj', 'j')
Map({ 'n', 'x' }, 'gk', 'k')
Map({ 'n', 'x' }, 'g^', '^')
Map({ 'n', 'x' }, 'g$', '$')

-- No highlight
Map('n', '<leader><esc>', ':nohlsearch<CR>')

-- escape
Map('i', 'jk', '<esc>')
Map('i', 'Jk', '<esc>')
Map('i', 'jK', '<esc>')
Map('i', 'JK', '<esc>')

-- Terminal -> Normal
Map('t', '<esc><esc>', '<C-\\><C-N>')

-- Run ./run
Map('n', '<F5>', ':vsp term://./run<CR>')
Map('n', '<F6>', ':e term://./run<CR>')
Map('n', '<F7>', ':!./run<CR>')

-- Global buffer yank/ paste
Map({ 'n', 'x' }, '<leader>p', '"+p')
Map({ 'n', 'x' }, '<leader>P', '"+P')
Map({ 'n', 'x' }, '<leader>y', '"+y')
Map('n', '<leader>yy', '"+yy')

-- Select pasted
Map('n', 'gp', "V'[']")
