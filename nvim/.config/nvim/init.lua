-- Require some files
require 'keymaps'
require 'options'

-- Some global functions
function map(modes, key, func)
    vim.keymap.set(modes, key, func, {
        noremap = true,
        silent = true,
    })
end

-- Init lazy
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable',
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require 'lazy'.setup('plugins', {
    change_detection = {
        enabled = false,
    },
})
