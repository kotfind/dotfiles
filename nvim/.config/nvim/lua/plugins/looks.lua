return {
    {
        'scottmckendry/cyberdream.nvim',
        config = function()
            require 'cyberdream'.setup {
                italic_comments = true,
                borderless_telescope = false,
                theme = {
                    highlights = {
                        -- TreesitterContextBottom = { underline = true },
                    },
                },
            }

            vim.cmd [[ colorscheme cyberdream ]]

            -- toggle theme
            Map('n', '<leader>T', ':CyberdreamToggleMode<CR>')
        end
    },

    {
        'mhinz/vim-signify',
        config = function()
            vim.o.signcolumn = 'yes:1'
            vim.o.updatetime = 10
        end
    },
}
