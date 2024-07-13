function Map(modes, key, func)
    vim.keymap.set(modes, key, func, {
        noremap = true,
        silent = true,
    })
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
Map('n', '<leader><ESC>', ':nohlsearch<CR>')

-- Escape
Map('i', 'jk', '<ESC>')
Map('i', 'Jk', '<ESC>')
Map('i', 'jK', '<ESC>')
Map('i', 'JK', '<ESC>')

-- Terminal -> Normal
Map('t', '<ESC><ESC>', '<C-\\><C-N>')

-- Global buffer yank/ paste
Map({ 'n', 'x' }, '<leader>p', '"+p')
Map({ 'n', 'x' }, '<leader>P', '"+P')
Map({ 'n', 'x' }, '<leader>y', '"+y')
Map('n', '<leader>yy', '"+yy')

-- Select pasted
Map('n', 'gp', "V'[']")
