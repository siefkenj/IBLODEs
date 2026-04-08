#import "libs/lib.typ": *
#import "libs/environment-book.typ": book_template

#show: e.prepare()
#show: e.set_(slide_settings, active: false)
#show: book_template
#show ref: allow_missing_refs

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

#{
  module(title: [Simulation], label: <mod:simulation>)[
    #include "modules/module-02-body.typ"
  ]
  set page(margin: (inside: 1in, outside: 1in))
  include "modules/module-02-exercises.typ"
}

#{
  module(title: [Systems and Models with Interacting Terms], label: <mod:systems>)[
    #include "modules/module-03-body.typ"
  ]
  set page(margin: (inside: 1in, outside: 1in))
  include "modules/module-03-exercises.typ"
}

#{
  module(title: [Equilibrium and Long-Term Behaviour], label: <mod:equilibrium>)[
    #include "modules/module-04-body.typ"
  ]
  set page(margin: (inside: 1in, outside: 1in))
  include "modules/module-04-exercises.typ"
}

#{
  module(title: [Qualitative Analysis: Slope Fields and Phase Portraits])[
    #include "modules/module-05-body.typ"
  ]
  set page(margin: (inside: 1in, outside: 1in))
  include "modules/module-05-exercises.typ"
}

#{
  module(title: [Linear Systems with Constant Coefficients (Real Solutions)], label: <mod:real>)[
    #include "modules/module-06-body.typ"
  ]
  set page(margin: (inside: 1in, outside: 1in))
  include "modules/module-06-exercises.typ"
}

#{
  module(
    title: [Linear Systems with Constant Coefficients (Affine Solutions)],
    label: <mod:affine>,
  )[
    #include "modules/module-07-body.typ"
  ]
  set page(margin: (inside: 1in, outside: 1in))
  include "modules/module-07-exercises.typ"
}

#{
  module(
    title: [Linear Systems with Constant Coefficients (Complex Solutions)],
    label: <mod:complex>,
  )[
    #include "modules/module-08-body.typ"
  ]
  set page(margin: (inside: 1in, outside: 1in))
  include "modules/module-08-exercises.typ"
}

#{
  module(title: [Quantitative Analysis: Linearization])[
    #include "modules/module-09-body.typ"
  ]
  set page(margin: (inside: 1in, outside: 1in))
  include "modules/module-09-exercises.typ"
}

#{
  module(title: [Higher Order Differential Equations], label: <mod:higher_order>)[
    #include "modules/module-10-body.typ"
  ]
  set page(margin: (inside: 1in, outside: 1in))
  include "modules/module-10-exercises.typ"
}

#{
  module(title: [Introduction to Boundary Value Problems], label: <mod:boundary_value_problems>)[
    #include "modules/module-11-body.typ"
  ]
  set page(margin: (inside: 1in, outside: 1in))
  include "modules/module-11-exercises.typ"
}

#{
  module(
    title: [Introduction to the Theory of Ordinary Differential Equations],
    label: <mod:existence_uniqueness>,
  )[
    #include "modules/module-12-body.typ"
  ]
  set page(margin: (inside: 1in, outside: 1in))
  include "modules/module-12-exercises.typ"
}



