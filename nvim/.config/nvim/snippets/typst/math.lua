local function in_math()
    return InTreeSitterNode('math')
end

return {
    -- POLYnomial
    s({
        trig = 'poly',
        condition = in_math
    }, {
        i(1, 'a'), t('_'), i(2, '0'), t(' + '),
        d(3, function(args)
            local coef = args[1][1]
            local index0 = args[2][1]

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

    -- SeQ
    s({
        trig = 'sq',
        condition = in_math
    }, fmt([[{var}_{idx_from}, ...,  {var_rep}_{idx_to}]], {
        var = i(1, 'A'),
        var_rep = rep(1),
        idx_from = i(2, '1'),
        idx_to = i(3, 'n'),
    })),

    -- SUM
    s({
        trig = 'sum',
        condition = in_math,
    }, fmt([[
        sum_({i} = {from})^{to} {pos}
    ]], {
        i = i(1, 'i'),
        from = i(2, '1'),
        to = i(3, 'n'),
        pos = i(0),
    })),
}, {
    -------------------- AUTOSNIPPETS --------------------

    -- subscript
    -- example: A123 -> A_123
    s({
        trig = '(%a+)(%d+)',
        regTrig = true,
        condition = in_math
    }, {
        f(function(args, snip)
            return snip.captures[1] .. '_' .. snip.captures[2]
        end)
    }),
}
