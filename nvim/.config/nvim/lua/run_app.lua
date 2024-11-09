-- Each trigger should have a `run` field (command that would be executed if triggered)
-- and either `file` or `ft` field.
--
-- If `file` is specified, than function check if this directory or one of it's parents have this file.
-- Function will `cd` in this directory before executing command.
--
-- If `ft` is specified, than function will check if `ft` and type of current file are the same.
--
-- Triggers are checked in specified order.
local function get_triggers()
    local file = vim.api.nvim_buf_get_name(0)
    local tmpfile = vim.fn.tempname();
    local cflags = '-Wall -Wextra -Wpedantic -fsanitize=undefined,address -fanalyzer -g3 -O0'
    local cxxflags = cflags

    return {
        { file = 'run',     run = './run' },
        { ft = 'python',    run = 'python3 ' .. file },
        { file = 'main.rs', run = 'RUST_LOG=info cargo run' },
        { file = 'lib.rs',  run = 'RUST_LOG=info cargo test' },
        {
            file = 'CMakeLists.txt',
            run = [[
                set -e
                cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=true -DCMAKE_BUILD_TYPE=Debug .
                cmake --build . -- -j4
                cmake --build . --target run
            ]],
        },
        { file = 'Makefile', run = 'make -j4 && make run', },
        { ft = 'c',          run = string.format('gcc %s %s -o %s && %s', file, cflags, tmpfile, tmpfile), },
        { ft = 'cpp',        run = string.format('g++ %s %s -o %s && %s', file, cxxflags, tmpfile, tmpfile), },
        { ft = 'typst',      run = string.format('typst compile %s %s.pdf && zathura %s.pdf', file, tmpfile, tmpfile), },
    }
end

local function run_bash_in_dir(bash_code, dir, cmd_pref)
    -- Create tmpfile
    local tmpfilename = vim.fn.tempname()
    local tmpfile = io.open(tmpfilename, 'w')
    if tmpfile == nil then
        error 'failed to open tmpfile'
        return
    end

    -- Write tmpfile
    if dir ~= nil and dir ~= '' then
        tmpfile:write('cd ' .. dir .. '\n')
    end
    tmpfile:write(bash_code)
    tmpfile:write('\n' .. 'rm ' .. tmpfilename .. '\n') -- make script delete itself
    tmpfile:close()

    -- Execute tmpfile
    if cmd_pref == nil then
        cmd_pref = '!'
    end
    vim.fn.execute(cmd_pref .. ' bash ' .. tmpfilename, '')
end

-- Returns true if trigger worked.
local function try_file_trigger(trigger, cmd_pref)
    if vim.bo.buftype == 'terminal' then
        -- XXX: temporary solution
        -- Better to navigate to last non-terminal buffer
        return false
    end

    local dir = vim.fn.expand('%:p:h')
    while true do
        if vim.fn.filereadable(dir .. '/' .. trigger.file) == 1 then
            run_bash_in_dir(trigger.run, dir, cmd_pref)
            return true
        end

        if dir == '/' then
            break
        else
            dir = vim.fn.fnamemodify(dir, ':h')
        end
    end
    return false
end

-- Returns true if trigger worked.
local function try_ft_trigger(trigger, cmd_pref)
    if vim.bo.filetype == trigger.ft then
        run_bash_in_dir(trigger.run, nil, cmd_pref)
        return true
    else
        return false
    end
end

-- Returns true if trigger worked.
local function try_trigger(trigger, cmd_pref)
    if trigger.file ~= nil and trigger.ft ~= nil then
        error 'both ft and file fileds should not be specified'
    elseif trigger.file ~= nil then
        return try_file_trigger(trigger, cmd_pref)
    elseif trigger.ft ~= nil then
        return try_ft_trigger(trigger, cmd_pref)
    else
        error 'either ft or file filed should be specified'
    end
end

local function run_app(cmd_pref)
    local triggers = get_triggers()
    for _, trigger in ipairs(triggers) do
        if try_trigger(trigger, cmd_pref) then
            return
        end
    end

    error('failed to run: no triggers worked')
end

Map('n', '<F5>', function()
    run_app 'vert term'
end)

Map('n', '<F6>', function()
    run_app 'term'
end)

Map('n', '<F7>', function()
    run_app()
end)
