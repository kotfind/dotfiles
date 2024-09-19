local function setup_snippets()
    local ls = require 'luasnip'
    local s = ls.snippet
    local t = ls.text_node
    local i = ls.insert_node
    local f = ls.function_node
    local d = ls.dynamic_node
    local sn = ls.snippet_node
    local fmt = require 'luasnip.extras.fmt'.fmt
    local rep = require 'luasnip.extras'.rep

    ls.setup {}

    Map('i', '<C-j>', function() ls.jump(1) end)
    Map('i', '<C-k>', function() ls.jump(-1) end)

    ls.add_snippets('typst', {
        -- Figure TAB
        s('ftab', fmt([[
            #figure(
                caption: [{caption}],
                table(
                    columns: {columns},
                    table.header{header},
                    {body}{print_pos}
                )
            )
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
    })
end

return {
    {
        'L3MON4D3/LuaSnip',
        build = 'make install_jsregexp',
        config = setup_snippets
    }
}
