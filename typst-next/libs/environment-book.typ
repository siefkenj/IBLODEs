#import "./common.typ": *
#import "environment-module.typ": _heading_and_list_show_rule, module_settings
#import "environments.typ": _show_link

/// Outline show rules.
#let _outline_show_rule(it) = {
  show outline.entry.where(level: 1): it => {
    set block(above: 1.2em)
    set text(weight: "bold")
    // context {
    //   // [hi #e.counter(module)
    //   // .at(it.element.location())]
    //   // [#it.element.location()]
    // }
    it
  }
  it
}


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
  show link: _show_link
  show: _outline_show_rule
  it
}
