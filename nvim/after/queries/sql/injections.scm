; extends

; Ignore freemarker templates
(
    (literal) @field
    (#lua-match? @field "\.([a-z]+\${.*})")
)
