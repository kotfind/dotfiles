-------------------- Options --------------------
local o = vim.opt

o.hlsearch = true
o.incsearch = true
o.ignorecase = true

o.scrolloff = 5

o.undofile = true

o.tabstop = 4
o.shiftwidth = 4

o.number = true
o.relativenumber = true
o.cursorline = true

o.wrap = false

o.expandtab = true

o.wildmenu = true
o.wildmode = 'longest:full,full'

-------------------- Keymaps --------------------
vim.opt.langmap = 'ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz'

vim.keymap.set('n', '<Space>', '', {})
vim.g.mapleader = ' '

function map(mode, lhs, rhs)
    vim.keymap.set(mode, lhs, rhs, { noremap = true })
end

-- nohl
map('n', '<leader><esc>', ':nohlsearch<cr>')

-- escape
map('i', 'jk', '<esc>')
map('i', 'Jk', '<esc>')
map('i', 'jK', '<esc>')
map('i', 'JK', '<esc>')

-- remain in visual after indenting
map('v', '<', '<gv', op)
map('v', '>', '>gv', op)

-- terminal normal mode
map('t', '<esc><esc>', '<c-\\><c-n>')

-- ./run
map('n', '<F5>', ':vsp term://./run<CR>G')
map('n', '<F6>', ':e term://./run<CR>G')
map('n', '<F7>', ':!./run<CR>')

map({'n', 'x'}, '<leader>p', '"+p')
map({'n', 'x'}, '<leader>P', '"+P')
map({'n', 'x'}, '<leader>y', '"+y')
map('n', '<leader>yy', '"+yy')

-------------------- Plugins --------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require'lazy'.setup({
    {
        'vladdoster/remember.nvim',
        config = function()
            require 'remember'
        end
    },
 
    ---------- Interface ----------
    {
        'nvim-lualine/lualine.nvim',
        opts = {
            options = {
                theme = 'auto',
            },
            sections = {
              lualine_a = {'mode'},
              lualine_b = {},
              lualine_c = {{'filename', path = 1}},
              lualine_x = {'encoding', 'filetype'},
              lualine_y = {'progress'},
              lualine_z = {'location'}
            },
          inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = {{'filename', path = 1}},
            lualine_x = {'location'},
            lualine_y = {},
            lualine_z = {}
          },
        }
    },

    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.5',
        dependencies = {
            'nvim-lua/plenary.nvim'
        },
        config = function()
            local builtin = require 'telescope.builtin'
            local themes = require 'telescope.themes'

            map('n', '<leader>f', builtin.find_files)
            map('n', '<leader>s', builtin.lsp_document_symbols)
            map('n', '<leader>S', builtin.lsp_workspace_symbols)
            map('n', '<leader>d', builtin.diagnostics)

            require 'telescope'.setup({
                defaults = {
                    sorting_strategy = 'ascending',
                    layout_strategy = 'horizontal',
                    layout_config = {
                        width = 0.8,
                        prompt_position = 'top',
                        preview_width = 0.5,
                    },
                    mappings = {
                        i = {
                            ['<Tab>'] = 'move_selection_next',
                            ['<S-Tab>'] = 'move_selection_previous',
                            ['<esc>'] = 'close'
                        }
                    },
                }
            })
        end
    },
 
    ---------- Bindings ----------
    {'m4xshen/autoclose.nvim', opts = {}}, -- close brackets
    'alvan/vim-closetag', -- close HTML tabgs
    {'kylechui/nvim-surround', opts = {}},
 
    ---------- Languages ----------
    'pest-parser/pest.vim',
    {
        'kaarmu/typst.vim',
        ft = 'typst',
        lazy = false,
    },
 
    ---------- TreeSitter ----------
    'nvim-treesitter/nvim-treesitter',

    ---------- LSP ----------
    'neovim/nvim-lspconfig',

    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',

    -- {
    --   "ray-x/lsp_signature.nvim",
    --   event = "VeryLazy",
    --   opts = {},
    --   config = function(_, opts) require'lsp_signature'.setup(opts) end
    -- },
})

-------------------- LSP General --------------------
local lsp = vim.lsp

lsp.handlers["textDocument/publishDiagnostics"] = function() end -- disable diagnostics

map('n', '<leader>r', lsp.buf.rename)
map('n', '<leader>a', lsp.buf.code_action)
map('n', 'K', lsp.buf.hover)
map('n', 'gd', lsp.buf.definition)
map('n', 'gD', lsp.buf.declaration)

local capabilities = require 'cmp_nvim_lsp'.default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = false -- disable snippets

local lspconfig = require 'lspconfig'

local cmp = require 'cmp'

cmp.setup {
    snippet = {},
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),

        ['<CR>'] = cmp.mapping.confirm({select = true}),

        ['<Tab>'] = cmp.mapping(function(fallback)
            local col = vim.fn.col('.') - 1

            if cmp.visible() then
                cmp.select_next_item(select_opts)
            elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
                fallback()
            else
                cmp.complete()
            end
        end, {'i', 's'}),

        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item(select_opts)
            else
                fallback()
            end
        end, {'i', 's'}),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'buffer' },
    })
}

-------------------- LSP Servers --------------------
lspconfig.pyright.setup { capabilities = capabilities, }

lspconfig.clangd.setup { capabilities = capabilities, }

lspconfig.texlab.setup { capabilities = capabilities, }

lspconfig.rust_analyzer.setup { capabilities = capabilities, }

