local function selection_or_insert(_, snip)
    local selection = {}
    for _, line in ipairs(snip.env.LS_SELECT_RAW) do
        table.insert(selection, line)
    end

    local res = {}
    if next(selection) ~= nil then
        table.insert(res, t(selection))
    else
        table.insert(res, i(1))
    end

    return sn(nil, res)
end

return {
    -- Advanced TABle
    s('atab', fmt([[
        #figure(caption: [{caption}], table(
            columns: {columns},
            table.header{header},
            {body}{print_pos}
        ))
    ]], {
        caption = i(1),
        columns = i(2),
        header = d(3, function(args)
            local col_num = tonumber(args[1][1])
            if col_num == nil or col_num <= 0 then
                return sn(nil, {})
            end

            local ans_nodes = {}
            for col_id = 1, col_num do
                local new_nodes = fmt('[*{}*]', i(col_id))

                for _, node in ipairs(new_nodes) do
                    table.insert(ans_nodes, node)
                end
            end

            return sn(nil, ans_nodes)
        end, { 2 }),
        body = d(4, function(args)
            local col_num = tonumber(args[1][1])
            if col_num == nil or col_num <= 0 then
                return sn(nil, {})
            end

            local ans_nodes = {}
            for col_id = 1, col_num do
                local new_node = t('[],' .. (col_id ~= col_num and ' ' or ''))
                table.insert(ans_nodes, new_node)
            end

            return sn(nil, ans_nodes)
        end, { 2 }),
        print_pos = i(0),
    })),

    -- TABle
    s('tab', fmt([[
        #figure(table(
            columns: {columns},
            align: center,
            {pos}
        ))
    ]], {
        columns = i(1),
        pos = i(0),
    })),

    -- Figure IMage
    s('fim', fmt([[
        #figure(
            caption: [{caption}],
            image("{source}", height: {height})
        )
    ]], {
        caption = i(1),
        source = i(2),
        height = i(3, "3cm"),
    })),

    -- DATE FILE
    s('datestamp-include', fmt([[
        #datestamp("{year}-{month}-{day}")
        #include "{year_rep}-{month_rep}-{day_rep}.typ"
    ]], {
        year = i(1, os.date("%Y")),
        month = i(2, os.date("%m")),
        day = i(3, os.date("%d")),
        year_rep = rep(1),
        month_rep = rep(2),
        day_rep = rep(3),
    })),

    -- Def
    s('def', fmt([[
        #def[
            {body}
        ]
    ]], {
        body = d(1, selection_or_insert, {})
    })),

    -- DefItem
    s('di', fmt([[
        #defitem[{body}]
    ]], {
        body = d(1, selection_or_insert, {})
    })),

    -- BLK
    s('blk', fmt([[
        #blk[
            {body}
        ]
    ]], {
        body = d(1, selection_or_insert, {})
    })),

    -- PROOF
    s('proof', fmt([[
        #proof[
            {body}
        ]
    ]], {
        body = d(1, selection_or_insert, {})
    })),

    -- Code
    s('c', fmt([[
        `{body}`
    ]], {
        body = d(1, selection_or_insert, {}),
    })),

    -- Code
    s('C', fmt([[
        ```{lang}
        {body}
        ```
    ]], {
        lang = i(1, 'lang'),
        body = d(2, selection_or_insert, {}),
    })),

    -- Math
    s('m', fmt([[
        ${math}$
    ]], {
        math = d(1, selection_or_insert, {}),
    })),

    -- Math
    s('M', fmt([[
        $ {math} $
    ]], {
        math = d(1, selection_or_insert, {}),
    })),
}
