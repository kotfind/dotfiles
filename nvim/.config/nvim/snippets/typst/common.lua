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
        {pos}
    ]], {
        year = i(1, os.date("%Y")),
        month = i(2, os.date("%m")),
        day = i(3, os.date("%d")),
        year_rep = rep(1),
        month_rep = rep(2),
        day_rep = rep(3),
        pos = i(0)
    })),

    -- Def
    s('def', fmt([[
        #def[
            {body}
        ]
    ]], {
        body = i(1)
    })),

    -- DefItem
    s('di', fmt([[
        #defitem[{body}]
    ]], {
        body = i(1)
    })),

    -- BLK
    s('blk', fmt([[
        #blk[
            {body}
        ]
    ]], {
        body = i(1)
    })),

    -- PROOF
    s('proof', fmt([[
        #proof[
            {body}
        ]
    ]], {
        body = i(1)
    })),

    -- Code
    s('c', fmt([[
        `{body}`{pos}
    ]], {
        body = i(1),
        pos = i(0)
    })),

    -- Code
    s('C', fmt([[
        ```{lang}
        {pos}
        ```
    ]], {
        lang = i(1, 'lang'),
        pos = i(0)
    })),

    -- Math
    s('m', fmt([[
        ${math}${pos}
    ]], {
        math = i(1),
        pos = i(0),
    })),

    -- Math
    s('M', fmt([[
        $ {math} ${pos}
    ]], {
        math = i(1),
        pos = i(0),
    })),

    -- SUM
    s('sum', fmt([[
        sum_({i} = {from})^{to} {pos}
    ]], {
        i = i(1, 'i'),
        from = i(2, '1'),
        to = i(3, 'n'),
        pos = i(0),
    })),
}
