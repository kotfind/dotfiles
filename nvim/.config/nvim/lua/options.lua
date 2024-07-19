local o = vim.opt

-- Mouse
o.mouse = 'a'

-- Tab
o.tabstop = 4
o.expandtab = true
o.softtabstop = 4
o.shiftwidth = 4

-- UI
o.number = true
o.relativenumber = true
o.cursorline = true

o.termguicolors = true
o.showmode = false

o.scrolloff = 5

-- Split
o.splitbelow = true
o.splitright = true

-- Search
o.hlsearch = true
o.incsearch = true
o.ignorecase = true

-- Undo file
o.undofile = true

-- Wrap
o.wrap = true
o.linebreak = true
o.breakindent = true

-- Preserve cursor position
vim.api.nvim_create_autocmd({ 'BufWinEnter' }, {
    command = [[ silent! normal! g`"zv' ]]
})

-- Spell
o.spell = true
o.spelllang = { 'en', 'ru' }

-- Disable spell for terminal window
vim.api.nvim_create_autocmd({ "TermOpen" }, {
    callback = function()
        vim.opt_local.spell = false
    end
})
