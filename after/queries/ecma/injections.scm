; extends

(call_expression
  arguments:
  (arguments
    (template_string
      (string_fragment) @injection.content
      (#set! injection.language "html"))))

(assignment_expression
  right:
  (template_string
    (string_fragment) @injection.content
    (#set! injection.language "html")))

(call_expression
  function: ((identifier) @_name
                          (#eq? @_name "lit"))
  arguments: ((template_string
                (string_fragment) @injection.content
                (#set! injection.language "html"))))

(variable_declarator
  name: ((identifier) @name
                          (#eq? @name "style"))
  value: ((template_string
                (string_fragment) @injection.content
                (#set! injection.language "css"))))
