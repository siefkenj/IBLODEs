#import "./common.typ": *
#import "environment-module.typ": _heading_and_list_show_rule, module_settings
#import "environments.typ": _show_link
#import "environment-module.typ": module
#import "environment-only.typ": book_only

/// Outline show rules.
#let _outline_show_rule(it) = {
  show outline.entry.where(level: 1): it => {
    set block(above: 1.2em)
    set text(weight: "bold")
    // [#e.counter(module).at(it.element.location())]
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
    margin: (outside: 1.25in, bottom: 1cm, top: 1.5cm),
    numbering: "1",
    number-align: center,
  )
  show link: _show_link
  show: _outline_show_rule
  it
}

/// Create an invisible header that only shows up in the PDF outline with the label "Core Exercises".
#let create_core_exercise_header() = {
  book_only({
    show heading: none
    heading(level: 2, outlined: false, bookmarked: true, numbering: none, [Core Exercises])
  })
}
