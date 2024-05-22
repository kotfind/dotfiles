-- Common options
local opts = {
    noremap = true,
    silent = true,
}

-- Langmap
vim.opt.langmap = 'ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz'

-- Set leader
vim.g.mapleader = ' '
vim.keymap.set('n', '<Space>', '')

-- Move between windows
vim.keymap.set('n', '<C-h>', '<C-w>h', opts)
vim.keymap.set('n', '<C-j>', '<C-w>j', opts)
vim.keymap.set('n', '<C-k>', '<C-w>k', opts)
vim.keymap.set('n', '<C-l>', '<C-w>l', opts)

-- Reselect on shift
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)

-- Move on wrapped lines
vim.keymap.set({'n', 'x'}, 'j', 'gj', opts)
vim.keymap.set({'n', 'x'}, 'k', 'gk', opts)
vim.keymap.set({'n', 'x'}, '^', 'g^', opts)
vim.keymap.set({'n', 'x'}, '$', 'g$', opts)

vim.keymap.set({'n', 'x'}, 'gj', 'j', opts)
vim.keymap.set({'n', 'x'}, 'gk', 'k', opts)
vim.keymap.set({'n', 'x'}, 'g^', '^', opts)
vim.keymap.set({'n', 'x'}, 'g$', '$', opts)

-- No highlight
vim.keymap.set('n', '<leader><ESC>', ':nohlsearch<CR>', opts)

-- Escape
vim.keymap.set('i', 'jk', '<ESC>', opts)
vim.keymap.set('i', 'Jk', '<ESC>', opts)
vim.keymap.set('i', 'jK', '<ESC>', opts)
vim.keymap.set('i', 'JK', '<ESC>', opts)

-- Terminal -> Normal
vim.keymap.set('t', '<ESC><ESC>', '<C-\\><C-N>', opts)

-- Run ./run
vim.keymap.set('n', '<F5>', ':vsp term://./run<CR>G', opts)
vim.keymap.set('n', '<F6>', ':e term://./run<CR>G', opts)
vim.keymap.set('n', '<F7>', ':!./run<CR>', opts)

-- Global buffer yank/ paste
vim.keymap.set({'n', 'x'}, '<leader>p', '"+p', opts)
vim.keymap.set({'n', 'x'}, '<leader>P', '"+P', opts)
vim.keymap.set({'n', 'x'}, '<leader>y', '"+y', opts)
vim.keymap.set('n', '<leader>yy', '"+yy', opts)

-- Select pasted
vim.keymap.set('n', 'gp', "V'[']", opts)

-- Toggle theme
vim.keymap.set('n', '<leader>t', ':CyberdreamToggleMode<CR>', opts)
