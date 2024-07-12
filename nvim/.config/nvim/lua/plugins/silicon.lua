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
        line_pad = 1,
        output = function()
            return os.date("/tmp/TmpScreenshots/silicon-%s.png")
        end
    }

    Map({ 'n', 'x' }, '<leader>ss', silicon.shoot)
    -- TODO: shoot with selected lines
    -- Map('x', '<leader>sS', ':Silicon!<CR>')
end

return {
    {
        'michaelrommel/nvim-silicon',
        config = setup_silicon,
    }
}
