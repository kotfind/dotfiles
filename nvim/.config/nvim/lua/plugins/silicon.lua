local function setup_silicon()
    local silicon = require 'nvim-silicon'
    silicon.setup {
        -- To preven conflicts with ~/silicon/.config/silicon
        disable_defaults = true,

        gobble = true,
        to_clipboard = false,

        language = function()
            return vim.bo.filetype
        end,

        output = function()
            return os.date("/tmp/TmpScreenshots/silicon-%s.png")
        end,

        line_offset = function()
            local mode = vim.api.nvim_get_mode()['mode']

            if mode == 'n' then
                return 1
            else
                return vim.fn.getpos('v')[1] + 1
            end
        end,
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
