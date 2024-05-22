;; SQL
(
    (string_content) @data @injection.content
    (#match? @data "SELECT|INSERT|UPDATE|DELETE|CREATE|ALTER|DROP")
    (#set! injection.language "sql")
)

(macro_invocation
macro: (identifier)
(token_tree)
)

;; yew html! macro:
(macro_invocation
    macro: (identifier) @macro_name
    (#eq? @macro_name "html")

    (token_tree ; macro body
        [
            ; token tree of depth from 1 to 4 (increase if needed)
            (token_tree) @injection.content
            (token_tree (token_tree) @injection.content)
            (token_tree (token_tree (token_tree) @injection.content))
            (token_tree (token_tree (token_tree (token_tree) @injection.content)))
        ]

        ; (#not-match? @injection.content "^\\{\\s*<")
        (#match? @injection.content "^\\{\\s*[^\\s<]")
        (#set! injection.language "rust")
        (#set! injection.include-children)
    )
)
