local function isempty(s)
    return s == nil or s == ''
end

local function get_contents(start_line, end_line)
    local lines = vim.api.nvim_buf_get_lines(0, start_line, end_line, false)
    return table.concat(lines, '\n')
end

--- Creates image of code snippet with silicon.
---
--- Create image of whole file (NORMAL mode):
---     :Silicon
--- Create image of whole file with highlighted lines (VISUAL mode):
---     :'<'>Silicon!
--- Create image of selected lines (VISUAL mode):
---     :'<'>Silicon
---
--- opts = {
---     range = true,
---     bang = true,
--- }
local function silicon_cmd(opts)
    -- TODO: gobble

    -- Constants
    local OUTPUT_FMT = '/tmp/TmpScreenshots/silicon-%s.png'

    -- General options
    local flags = ''
    local function flag(name, value)
        flags = flags .. ' --' .. name .. ' ' .. value
    end

    local lang = vim.bo.filetype
    if not isempty(lang) then
        flag('language', lang)
    end

    local output_file_name = os.date(OUTPUT_FMT)
    flag('output', output_file_name)

    -- Range options
    local with_range = opts.range == 2
    local with_highlight_lines = opts.bang

    local input = ''
    if not with_range or with_highlight_lines then
        flag('window-title', vim.api.nvim_buf_get_name(0))

        input = get_contents(0, -1)
    else
        flag('line-offset', opts.line1)

        input = get_contents(opts.line1 - 1, opts.line2)
    end

    if with_highlight_lines then
        flag('highlight-lines', opts.line1 .. '-' .. opts.line2)
    end

    -- Run command
    local cmd_str = 'silicon ' .. flags
    local cmd = io.popen(cmd_str, 'w')
    if cmd ~= nil then
        cmd:write(input)
        cmd:close()
    else
        error('coludn\'t execute command ' .. cmd_str)
    end

    print('Silicon: wrote output to ' .. output_file_name)
end

vim.api.nvim_create_user_command('Silicon', silicon_cmd, { range = true, bang = true })
