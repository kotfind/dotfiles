local function selection_and_insert(_, snip)
    local selection = {}
    for _, line in ipairs(snip.env.LS_SELECT_RAW) do
        table.insert(selection, line)
    end

    local res = {}
    if next(selection) ~= nil then
        table.insert(res, t(selection))
    end
    table.insert(res, i(1))

    return sn(nil, res)
end

return {
    -------------------- Funcs --------------------
    s('fn', fmta([[
        fn <name>(<args>)<ret_arrow><ret> {
            <body>
        }
    ]], {
        name = i(1, 'func'),
        args = i(2),
        ret_arrow = f(function(args)
            if args[1][1] == '' then
                return ''
            else
                return ' -> '
            end
        end, { 3 }),
        ret = i(3, 'type'),
        body = d(4, selection_and_insert),
    })),
}
