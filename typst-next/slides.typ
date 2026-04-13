#import "libs/lib.typ": *
#import "libs/environment-slides.typ": slides_template

#show ref: allow_missing_refs
#show: slides_template
#show: e.prepare()
#show: e.set_(module_settings, active: false)


#make_cover(
  text("Differential Equations", size: 45pt),
  authors: ([Jason Siefken], [Bernardo Galvão-Sousa]),
  subtitle: align(left, stack(
    [MAT244 Slides],
    text([#datetime.today().display("[year]/[month]/[day] Edition")], size: 12pt),
    spacing: .6em,
  )),
)


// Modules start
#counter(page).update(1)
#{
  module(title: [Modelling], label: <mod:modelling>)[
    #include "modules/module-01-body.typ"
  ]
  include "modules/module-01-exercises.typ"
}

#{
  module(title: [Simulation], label: <mod:simulation>)[
    #include "modules/module-02-body.typ"
  ]
  include "modules/module-02-exercises.typ"
}

#{
  module(title: [Systems and Models with Interacting Terms], label: <mod:systems>)[
    #include "modules/module-03-body.typ"
  ]
  include "modules/module-03-exercises.typ"
}

#{
  module(title: [Equilibrium and Long-Term Behaviour], label: <mod:equilibrium>)[
    #include "modules/module-04-body.typ"
  ]
  include "modules/module-04-exercises.typ"
}

#{
  module(title: [Qualitative Analysis: Slope Fields and Phase Portraits])[
    #include "modules/module-05-body.typ"
  ]
  include "modules/module-05-exercises.typ"
}

#{
  module(title: [Linear Systems with Constant Coefficients (Real Solutions)], label: <mod:real>)[
    #include "modules/module-06-body.typ"
  ]
  include "modules/module-06-exercises.typ"
}

#{
  module(
    title: [Linear Systems with Constant Coefficients (Affine Solutions)],
    label: <mod:affine>,
  )[
    #include "modules/module-07-body.typ"
  ]
  include "modules/module-07-exercises.typ"
}

#{
  module(
    title: [Linear Systems with Constant Coefficients (Complex Solutions)],
    label: <mod:complex>,
  )[
    #include "modules/module-08-body.typ"
  ]
  include "modules/module-08-exercises.typ"
}

#{
  module(title: [Quantitative Analysis: Linearization])[
    #include "modules/module-09-body.typ"
  ]
  include "modules/module-09-exercises.typ"
}

#{
  module(title: [Higher Order Differential Equations], label: <mod:higher_order>)[
    #include "modules/module-10-body.typ"
  ]
  include "modules/module-10-exercises.typ"
}

#{
  module(title: [Introduction to Boundary Value Problems], label: <mod:boundary_value_problems>)[
    #include "modules/module-11-body.typ"
  ]
  include "modules/module-11-exercises.typ"
}

#{
  module(
    title: [Introduction to the Theory of Ordinary Differential Equations],
    label: <mod:existence_uniqueness>,
  )[
    #include "modules/module-12-body.typ"
  ]
  include "modules/module-12-exercises.typ"
}

#{
  module(title: [Interesting ODEs], label: <mod:interesting_odes>)[
  ]
  include "modules/interesting_odes.typ"
}
