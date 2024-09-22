local function setup_snippets()
    local ls = require 'luasnip'
    local s = ls.snippet
    local t = ls.text_node
    local i = ls.insert_node
    local f = ls.function_node
    local d = ls.dynamic_node
    local r = ls.restore_node
    local sn = ls.snippet_node
    local fmt = require 'luasnip.extras.fmt'.fmt
    local rep = require 'luasnip.extras'.rep
    local k = require("luasnip.nodes.key_indexer").new_key

    ls.setup {}

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

        -- POLYnomial
        s('poly', {
            i(1, 'a'), t('_'), i(2, '0'), t(' + '),
            d(3, function(args)
                local coef = args[1][1]
                local index0 = args[2][1]
                local index0_num = tonumber(index0)

                local function delta_index(index, delta)
                    local index_num = tonumber(index)

                    if index_num == nil then
                        if delta == 0 then
                            return '(' .. index .. ')'
                        end

                        local delta_sgn = delta > 0 and '+' or '-'
                        local delta_abs = math.abs(delta)
                        return '(' .. index .. ' ' .. delta_sgn .. ' ' .. delta_abs .. ')'
                    else
                        return tostring(index_num + delta)
                    end
                end

                return sn(nil, {
                    t(coef .. '_' .. delta_index(index0, 1) .. ' '),
                    i(1, 'x'),
                    f(function(args)
                        local var = args[1][1]
                        local index_back_0 = args[2][1]

                        return ' + ' ..
                            coef ..
                            '_' ..
                            delta_index(index0, 2) ..
                            ' ' ..
                            var ..
                            '^' ..
                            delta_index(index0, 2) ..
                            ' + ... + ' ..
                            coef ..
                            '_' .. delta_index(index_back_0, -1) .. ' ' .. var .. '^' .. delta_index(index_back_0, -1)
                    end, { 1, 2 }),
                    t(' + ' .. coef .. '_'), i(2, 'n'), t(' '), rep(1), t('^'), rep(2)
                })
            end, { 1, 2 }),
        }),

        -- CODE
        s('code', fmt([[
            ```{lang}
            {body}
            ```
        ]], {
            lang = i(1, "lang"),
            body = i(0)
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
            $ {math} $ {pos}
        ]], {
            math = i(1),
            pos = i(0),
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
