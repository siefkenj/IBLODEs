#import "libs/lib.typ": *
#import "libs/environment-slides.typ": slides_template

#show: e.prepare()
#show: slides_template
#show: e.set_(module_settings, active: false)

// Modules start
#counter(page).update(1)
#{
  module(title: [Modelling], label: <mod:modelling>)[
    #include "modules/module-01-body.typ"
  ]
  include "modules/module-01-exercises.typ"
}
