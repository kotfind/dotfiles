require 'mason'.setup {}

require 'mason-lspconfig'.setup {
    ensure_installed = { 'pyright', 'clangd', 'rust_analyzer', 'lua_ls' },
}

local lspconfig = require 'lspconfig'

local opts = {
    noremap = true,
    silent = true,
}

vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '<leader>D', vim.diagnostic.setloclist, opts)

local on_attach = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

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

require 'mason-lspconfig'.setup_handlers {
    function (server_name)
        require 'lspconfig'[server_name].setup {
            on_attach = on_attach
        }
    end,
}

vim.diagnostic.disable()
