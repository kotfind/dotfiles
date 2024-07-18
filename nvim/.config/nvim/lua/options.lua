-- Mouse
vim.opt.mouse = 'a'

-- Tab
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

-- UI
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true

vim.opt.termguicolors = true
vim.opt.showmode = false

vim.opt.scrolloff = 5

-- Split
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Search
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true

-- Undo file
vim.opt.undofile = true

-- Wrap
vim.opt.wrap = true
vim.opt.linebreak = true

-- Preserve cursor position
vim.api.nvim_create_autocmd({ 'BufWinEnter' }, {
    command = [[ silent! normal! g`"zv' ]]
})

-- Languages
vim.opt.spell = true
vim.opt.spelllang = { 'en', 'ru' }
