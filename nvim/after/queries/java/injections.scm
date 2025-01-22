; extends

(
    [
        (string_fragment)
        (multiline_string_fragment)
    ] @injection.content
    (#match? @injection.content "(\n)?(SELECT|INSERT|UPDATE|DELETE).+(FROM|INTO|VALUES|SET).*(WHERE|GROUP BY)?")
    (#offset! @injection.content 0 0 0 0)
    (#set! injection.language "sql")
)
