#import "libs/lib.typ": *
#import "libs/environment-slides.typ": slides_template

#show: slides_template
#show: e.prepare()
#show: e.set_(module_settings, active: false)

// Modules start
#counter(page).update(1)
#{
  module(title: [Modelling], label: <mod:modelling>)[
    #include "modules/module-01-body.typ"
  ]
  slide[
    here is a slide. What is going on?
  ]
  slide[
    A second one

  ]
  question[

    #set page(footer: block(fill: red, width: 100%, height: 100%)[Copyright blah])
    #slide[
      The slide inside a question
      #colbreak()
      other]
    #block(width: 100%, height: 100%, fill: red)[hi]
  ]
  include "modules/module-01-exercises.typ"
}
