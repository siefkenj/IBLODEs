#import "libs/lib.typ": *
#import "libs/environment-book.typ": book_template

#show: e.set_(slide_settings, active: false)
#show: book_template

#{
  // We don't have module bars in the introduction, so set inner and outer margins equal.
  set page(margin: (inside: 1in, outside: 1in))
  // Reset the page counter and set it to roman numerals.
  counter(page).update(1)
  set page(numbering: "i")
  include "modules/introduction.typ"

  set page(numbering: none)
  pagebreak(to: "odd")
}

// Modules start
#counter(page).update(1)
#{
  module(title: [Modelling], label: <mod:modelling>)[
    #include "modules/module-01-body.typ"
  ]
  set page(margin: (inside: 1in, outside: 1in))
  include "modules/module-01-exercises.typ"
}
