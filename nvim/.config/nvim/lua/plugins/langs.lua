return {
    'pest-parser/pest.vim',
    {
        'aklt/plantuml-syntax',
        config = function()
            vim.g.plantuml_set_makeprg = 0
        end
    },
}
