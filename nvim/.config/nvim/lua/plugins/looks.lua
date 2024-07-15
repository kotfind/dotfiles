local function setup_cyberdream()
    require 'cyberdream'.setup {
        italic_comments = true,
        borderless_telescope = true,
        theme = {
            variant = 'auto',
            overrides = function(colors)
                return {
                    Comment = { fg = colors.magenta, bg = "NONE", italic = true },
                    CursorLine = { fg = "NONE", bg = colors.bgAlt },
                }
            end,
        },
    }

    vim.cmd [[ colorscheme cyberdream ]]
end

local function setup_lualine()
    require 'lualine'.setup {
        options = {
            theme = require 'lualine.themes.cyberdream',
        },
        sections = {
            lualine_a = {
                {
                    'filename',
                    newfile_status = true,
                    path = 1
                }
            },
            lualine_b = { 'branch' },
            lualine_c = {},
            lualine_x = {
                {
                    'diagnostics',
                    update_in_insert = true,
                }
            },
            lualine_y = { 'filetype' },
            lualine_z = { 'progress' },
        },

        inactive_sections = {
            lualine_a = {
                {
                    'filename',
                    newfile_status = true,
                    path = 1
                }
            },
            lualine_b = {},
            lualine_c = {},
            lualine_x = {},
            lualine_y = {},
            lualine_z = {}
        },
    }
end

return {
    {
        'scottmckendry/cyberdream.nvim',
        config = setup_cyberdream,
    },

    {
        'nvim-lualine/lualine.nvim',
        config = setup_lualine,
        dependencies = {
            'scottmckendry/cyberdream.nvim',
        },
    },

    {
        'mhinz/vim-signify',
        config = function()
            vim.o.signcolumn = 'yes:1'
            vim.o.updatetime = 10
        end
    },

    {
        'NvChad/nvim-colorizer.lua',
        opts = {},
    },
}
