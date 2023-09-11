local map = vim.keymap.set

vim.opt.langmap = 'ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz'

map('n', '<Space>', '', {})
vim.g.mapleader = ' '

op = { noremap = true }

-- nohl
map('n', '<leader><esc>', ':nohlsearch<cr>', op)

-- escape
map('i', 'jk', '<esc>', op)
map('i', 'Jk', '<esc>', op)
map('i', 'jK', '<esc>', op)
map('i', 'JK', '<esc>', op)

-- global buffer
map({'n', 'x'}, 'gp', '"+p', op)
map({'n', 'x'}, 'gP', '"+P', op)
map({'n', 'x'}, 'gy', '"+y', op)

-- remain in visual after indenting
map('v', '<', '<gv', op)
map('v', '>', '>gv', op)

-- -- autoclose brackerts
-- map('i', '{<cr>', '{<CR>}<Esc>O')
-- map('i', '{;', '{<CR>};<Esc>O')

-- terminal normal mode
map('t', '<esc><space>', '<c-\\><c-n>')

-- ./run
map('n', '<F5>', ':vsp term://./run<CR>G')
map('n', '<F6>', ':e term://./run<CR>G')

