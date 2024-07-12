local function setup_neoterm()
    Map('n', '<leader>t', function() vim.fn.execute(vim.v.count .. ' Ttoggle') end)

    vim.g.neoterm_default_mod = 'vert'
    Map('i', '<C-i>', '<C-o><Plug>(neoterm-repl-send-line)')
    Map('n', '<C-i>', '<Plug>(neoterm-repl-send-line)')
    Map('x', '<C-i>', '<Plug>(neoterm-repl-send)')

    -- Run ./run
    Map('n', '<F5>', ':T ./run<CR>')
    Map('n', '<F6>', function()
        vim.g.neoterm_default_mod = ''
        vim.cmd [[ :term://./run<CR> ]]
        vim.g.neoterm_default_mod = 'vert'
    end)
    Map('n', '<F7>', ':!./run<CR>')
end

return {
    {
        'kassio/neoterm',
        config = setup_neoterm,
    },
}
