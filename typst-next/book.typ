#import "libs/lib.typ": *
#import "libs/environment-book.typ": book_template

/// Logo for CC BY-SA license
#let cc_by_sa = box(width: 3em, place(dy: -.85em, image("images/by-sa.svg", height: 1em)))
#let copyright = [_#sym.copyright Galvão-Sousa & Siefken, 2025 #cc_by_sa _]

#show: e.prepare()
#show: e.set_(slide_settings, active: false)
#show: e.set_(global_settings, copyright: copyright)
#show: book_template
#show ref: allow_missing_refs


#make_cover(
  text("Differential Equations", size: 45pt),
  authors: ([Jason Siefken], [Bernardo Galvão-Sousa]),
  subtitle: align(left, stack(
    [MAT244 Workbook],
    text([#datetime.today().display("[year]/[month]/[day] Edition")], size: 12pt),
    spacing: .6em,
  )),
)

#{
  // We don't have module bars in the introduction, so set inner and outer margins equal.
  set page(margin: (inside: 1in, outside: 1in))
  // Reset the page counter and set it to roman numerals.
  counter(page).update(1)
  set page(numbering: "i")

  outline(depth: 3, target: e.selector(module, outline: true).or(heading))

  pagebreak(to: "odd")
  include "modules/introduction.typ"

  set page(numbering: none)
  pagebreak(to: "odd")
}

// Modules start
#counter(page).update(1)
#{
  module(title: [Modelling], label: <mod:modelling>)[
    #include "modules/module-01-body.typ"
    #import "modules/module-01-practice-problems.typ": questions
    #set text(size: 0.85em)
    #practice_problems(questions)
  ]
  set page(margin: (inside: 1in, outside: 1in))
  include "modules/module-01-exercises.typ"
}

#{
  module(title: [Simulation], label: <mod:simulation>)[
    #include "modules/module-02-body.typ"
    #import "modules/module-01-practice-problems.typ": questions
    #set text(size: 0.85em)
    #practice_problems(questions)
  ]
  set page(margin: (inside: 1in, outside: 1in))
  include "modules/module-02-exercises.typ"
}

#{
  module(title: [Systems and Models with Interacting Terms], label: <mod:systems>)[
    #include "modules/module-03-body.typ"
    #import "modules/module-03-practice-problems.typ": questions
    #set text(size: 0.85em)
    #practice_problems(questions)
  ]
  set page(margin: (inside: 1in, outside: 1in))
  include "modules/module-03-exercises.typ"
}

#{
  module(title: [Equilibrium and Long-Term Behaviour], label: <mod:equilibrium>)[
    #include "modules/module-04-body.typ"
    #import "modules/module-04-practice-problems.typ": questions
    #set text(size: 0.85em)
    #practice_problems(questions)
  ]
  set page(margin: (inside: 1in, outside: 1in))
  include "modules/module-04-exercises.typ"
}

#{
  module(title: [Qualitative Analysis: Slope Fields and Phase Portraits])[
    #include "modules/module-05-body.typ"
    #import "modules/module-05-practice-problems.typ": questions
    #set text(size: 0.85em)
    #practice_problems(questions)
  ]
  set page(margin: (inside: 1in, outside: 1in))
  include "modules/module-05-exercises.typ"
}

#{
  module(title: [Linear Systems with Constant Coefficients (Real Solutions)], label: <mod:real>)[
    #include "modules/module-06-body.typ"
    #import "modules/module-06-practice-problems.typ": questions
    #set text(size: 0.85em)
    #practice_problems(questions)
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
    #import "modules/module-07-practice-problems.typ": questions
    #set text(size: 0.85em)
    #practice_problems(questions)
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
    #import "modules/module-08-practice-problems.typ": questions
    #set text(size: 0.85em)
    #practice_problems(questions)
  ]
  set page(margin: (inside: 1in, outside: 1in))
  include "modules/module-08-exercises.typ"
}

#{
  module(title: [Quantitative Analysis: Linearization])[
    #include "modules/module-09-body.typ"
    #import "modules/module-09-practice-problems.typ": questions
    #set text(size: 0.85em)
    #practice_problems(questions)
  ]
  set page(margin: (inside: 1in, outside: 1in))
  include "modules/module-09-exercises.typ"
}

#{
  module(title: [Higher Order Differential Equations], label: <mod:higher_order>)[
    #include "modules/module-10-body.typ"
    #import "modules/module-10-practice-problems.typ": questions
    #set text(size: 0.85em)
    #practice_problems(questions)
  ]
  set page(margin: (inside: 1in, outside: 1in))
  include "modules/module-10-exercises.typ"
}

#{
  module(title: [Introduction to Boundary Value Problems], label: <mod:boundary_value_problems>)[
    #include "modules/module-11-body.typ"
    #import "modules/module-11-practice-problems.typ": questions
    #set text(size: 0.85em)
    #practice_problems(questions)
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
    #import "modules/module-12-practice-problems.typ": questions
    #set text(size: 0.85em)
    #practice_problems(questions)
  ]
  set page(margin: (inside: 1in, outside: 1in))
  include "modules/module-12-exercises.typ"
}

// Appendices Start Here
#show: e.set_(
  module_settings,
  sidebar_color: color.rgb("#7db967"),
  supplement: "Appendix",
  numbering: "A",
)
#e.counter(module).update(0)

#{
  module(title: [Spreadsheets and Programming], label: <app:spreadsheet>)[
    #include "modules/appendix-01-body.typ"
    #import "modules/appendix-01-practice-problems.typ": questions
    #set text(size: 0.85em)
    #practice_problems(questions)
  ]
}

#{
  show: e.set_(global_settings, copyright: [_#sym.copyright Jiří Lebl 2008--2025 #cc_by_sa _])
  module(title: [Separable Equations], label: <app:separable>)[
    #include "modules/appendix-02-body.typ"
    #import "modules/appendix-02-practice-problems.typ": questions
    #set text(size: 0.85em)
    #practice_problems(questions)
  ]
}

#{
  show: e.set_(global_settings, copyright: [_#sym.copyright Jiří Lebl 2008--2025 #cc_by_sa _])
  module(title: [Integrating Factors], label: <app:integrating_factor>)[
    #include "modules/appendix-03-body.typ"
    #import "modules/appendix-03-practice-problems.typ": questions
    #set text(size: 0.85em)
    #practice_problems(questions)
  ]
}

#{
  module(title: [Series Solutions], label: <app:series_solution>)[
    #include "modules/appendix-04-body.typ"
    #import "modules/appendix-04-practice-problems.typ": questions
    #set text(size: 0.85em)
    #practice_problems(questions)
  ]
}

#{
  show: e.set_(global_settings, copyright: [_#sym.copyright Jiří Lebl 2008--2025 #cc_by_sa _])
  module(title: [Reduction of Order], label: <app:reduction_of_order>)[
    #include "modules/appendix-05-body.typ"
    #import "modules/appendix-05-practice-problems.typ": questions
    #set text(size: 0.85em)
    #practice_problems(questions)
  ]
}

#{
  module(title: [Linear Algebra], label: <app:linear_algebra>)[
    #include "modules/appendix-06-body.typ"
    #import "modules/appendix-06-practice-problems.typ": questions
    #set text(size: 0.85em)
    #practice_problems(questions)
  ]
}

#{
  module(title: [Complex Numbers], label: <app:complex>)[
    #include "modules/appendix-07-body.typ"
    #import "modules/appendix-07-practice-problems.typ": questions
    #set text(size: 0.85em)
    #practice_problems(questions)
  ]
}

#{
  module(
    title: [Solutions to Selected Practice Problems],
  )[
    #practice_problem_solutions()
  ]
}
