-- Mason setup
require 'mason'.setup {}

-- Lsp Servers setup
require 'mason-lspconfig'.setup {
    ensure_installed = {
        'pyright',
        'clangd',
        'rust_analyzer',
        'lua_ls',
    },
}

-- Mappings
local opts = {
    noremap = true,
    silent = true,
}

vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '<leader>D', vim.diagnostic.setloclist, opts)

local on_attach = function(client, bufnr)
    -- Disable lsp highlighting
    client.server_capabilities.semanticTokensProvider = nil

    -- Buffer Mappings
    local bufopts = {
        noremap = true,
        silent = true,
        buffer = bufnr
    }

    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)

    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'L', vim.lsp.buf.signature_help, bufopts)

    vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<leader>a', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', '<leader>R', vim.lsp.buf.references, bufopts)
end

-- Disable disagnostics
vim.diagnostic.disable()

-- Format on save
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
    callback = function()
        vim.lsp.buf.format()
    end
})

-- Server handlers setup
local lspconfig = require 'lspconfig'

require 'mason-lspconfig'.setup_handlers {
    function(server_name)
        lspconfig[server_name].setup {
            on_attach = on_attach
        }
    end,

    ['rust_analyzer'] = function()
        lspconfig.rust_analyzer.setup {
            on_attach = on_attach,
            cmd = vim.lsp.rpc.connect('127.0.0.1', 27631),
            init_options = {
                lspMux = {
                    version = '1',
                    method = 'connect',
                    server = 'rust-analyzer',
                },
            },
        }
    end,

    ['lua_ls'] = function()
        lspconfig.lua_ls.setup {
            on_attach = on_attach,
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { 'vim' },
                    },
                },
            },
        }
    end,
}
