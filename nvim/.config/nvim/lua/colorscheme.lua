require 'cyberdream'.setup{
    italic_comments = true,
    borderless_telescope = false,
    theme = {
        highlights = {
            -- TreesitterContextBottom = { underline = true },
        },
    },
}

vim.cmd [[ colorscheme cyberdream ]]
