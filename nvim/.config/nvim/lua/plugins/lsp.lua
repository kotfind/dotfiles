local function on_attach(client, bufnr)
    -- Disable lsp highlighting
    client.server_capabilities.semanticTokensProvider = nil

    -- Buffer Mappings
    local function bmap(modes, key, func)
        Map(modes, key, func, {
            noremap = true,
            silent = true,
            buffer = bufnr
        })
    end

    bmap('n', 'gD', vim.lsp.buf.declaration)
    bmap('n', 'gd', vim.lsp.buf.definition)
    bmap('n', 'gi', vim.lsp.buf.implementation)

    bmap('n', 'K', vim.lsp.buf.hover)
    bmap('n', 'L', vim.lsp.buf.signature_help)

    bmap('n', '<leader>lr', vim.lsp.buf.rename)
    bmap('n', '<leader>la', vim.lsp.buf.code_action)
    bmap('n', '<leader>lR', vim.lsp.buf.references)
end

local function capabilities()
    return require 'cmp_nvim_lsp'.default_capabilities()
end

local function setup_diagnostics()
    vim.diagnostic.config {
        -- disable built-in diagnostics display
        virtual_text = false,

        -- disable lsp_lines at start
        virtual_lines = false,
    }

    vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        underline = false,
        severity_sort = true,
    })

    local lsp_lines = require 'lsp_lines'
    lsp_lines.setup {}

    Map('n', '<leader>tl', lsp_lines.toggle)
end

local function setup_lsp()
    -- Mappings
    Map('n', '[d', vim.diagnostic.goto_prev)
    Map('n', ']d', vim.diagnostic.goto_next)
    Map('n', '<leader>ld', vim.diagnostic.open_float)
    Map('n', '<leader>lD', vim.diagnostic.setloclist)

    -- Format on save
    vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
        callback = function()
            if vim.bo.filetype ~= "cpp" and vim.bo.filetype ~= "c" then
                vim.lsp.buf.format()
            end
        end
    })
end

local function setup_mason_lspconfig()
    local mason_lspconfig = require 'mason-lspconfig'
    local lspconfig = require 'lspconfig'

    mason_lspconfig.setup {
        ensure_installed = {
            'pyright',
            'clangd',
            'rust_analyzer',
            'lua_ls',
            'cssls',
            'typst_lsp',
            'pest_ls',
            'bashls',
        },
    }

    mason_lspconfig.setup_handlers {
        function(server_name)
            lspconfig[server_name].setup {
                on_attach = on_attach,
                capabilities = capabilities(),
            }
        end,

        ['rust_analyzer'] = function()
            lspconfig.rust_analyzer.setup {
                on_attach = on_attach,
                capabilities = capabilities(),
                cmd = vim.lsp.rpc.connect('127.0.0.1', 27631),
                args = { '--all-targets' },
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
                capabilities = capabilities(),
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
end

return {
    {
        'neovim/nvim-lspconfig',
        config = setup_lsp,
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
        }
    },

    {
        'williamboman/mason.nvim',
        opts = {}
    },

    {
        'williamboman/mason-lspconfig.nvim',
        config = setup_mason_lspconfig,
        dependencies = {
            'williamboman/mason.nvim',
            'neovim/nvim-lspconfig',
        }
    },

    {
        'j-hui/fidget.nvim',
        opts = {},
    },

    {
        url = 'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
        config = setup_diagnostics
    },

    {
        'stevearc/dressing.nvim',
        opts = {},
    },
}
