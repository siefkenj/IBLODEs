#import "./common.typ": *
#import "environment-module.typ": _heading_and_list_show_rule, module_settings


/// Template for making a book. This should be used as
/// ```typst
/// #show: book_template
/// ```
#let book_template(it) = {
  set par(justify: true)
  set page(
    paper: "us-letter",
    margin: (outside: 1.25in, y: 1cm),
    numbering: "1",
    number-align: center,
  )
  it
}
