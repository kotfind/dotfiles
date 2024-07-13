local function setup_silicon()
    local silicon = require 'nvim-silicon'
    silicon.setup {
        theme = 'OneHalfDark',
        pad_horiz = 0,
        pad_vert = 0,
        no_round_corner = true,
        no_window_controls = true,
        gobble = true,
        to_clipboard = false,
        line_offset = function()
            local mode = vim.api.nvim_get_mode()['mode']
            if mode == 'n' then
                -- prints all file, no offset
                return 1
            elseif mode == 'x' then
                -- prints range, first selected line offset
                return vim.fn.getpos('v')[1]
            end
        end,
        output = function()
            return os.date("/tmp/TmpScreenshots/silicon-%s.png")
        end
    }

    Map('n', '<leader>s', silicon.shoot)
    Map('x', '<leader>s', function()
        silicon.shoot()
        Feed('<esc>')
    end)

    -- TODO: shoot with selected lines
    -- Map('x', '<leader>sS', ':Silicon!<CR>')
end

return {
    {
        'michaelrommel/nvim-silicon',
        config = setup_silicon,
    }
}
