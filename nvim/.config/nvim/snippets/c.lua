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
        <ret> <name>(<args>) {
            <body>
        }
    ]], {
        ret = i(1, 'void'),
        name = i(2, 'func'),
        args = i(3, 'void'),
        body = d(4, selection_and_insert),
    })),

    s({
        trig = 'main',
        condition = InTreeSitterTopLevelNode
    }, fmta([[
        int main(<args>) {
            <body>
        }
    ]], {
        args = c(1, {
            t('void'),
            t('int argc, char** argv'),
            t('int argc, char** argv, char** envp')
        }),
        body = d(2, selection_and_insert),
    })),

    -------------------- Loops --------------------
    s('for', fmt([[
        for (size_t {var} = {from}; {var_rep} < {to}; ++{var_rep}) {{
            {body}
        }}
    ]], {
        var = i(1, 'i'),
        from = i(2, '0'),
        to = i(3, 'n'),
        var_rep = rep(1),
        body = d(4, selection_and_insert)
    })),

    s('while', fmta([[
        while (<cond>) {
            <body>
        }
    ]], {
        cond = i(1, 'cond'),
        body = d(2, selection_and_insert),
    })),

    s('do-while', fmta([[
        do {
            <body>
        } while (<cond>);
    ]], {
        cond = i(1, 'cond'),
        body = d(2, selection_and_insert),
    })),

    -------------------- If's --------------------

    s('if', fmta([[
        if (<cond>) {
            <body>
        }
    ]], {
        cond = i(1, 'cond'),
        body = d(2, selection_and_insert),
    })),

    s('elif', fmta([[
        else if (<cond>) {
            <body>
        }
    ]], {
        cond = i(1, 'cond'),
        body = d(2, selection_and_insert),
    })),

    s('else', fmta([[
        else {
            <body>
        }
    ]], {
        body = d(2, selection_and_insert),
    })),

    -------------------- Structs --------------------
    s('struct', fmta([[
        struct <name> {
            <body>
        };
    ]], {
        name = i(1, 'my_struct'),
        body = d(2, selection_and_insert),
    })),
}