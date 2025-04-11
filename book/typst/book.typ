#import "@preview/in-dexter:0.7.0": *
#import "common/cover.typ": make_cover
#import "libs/_workbook.typ": exercises, solutions, aligned_terms
//#import "_workbook.typ": setup
#set page(paper: "us-letter")
#set par(justify: true)

//#let workbook = setup(banner_color: color.rgb("#00a2cb"))
#import "common/settings-book.typ": env
#let (sans, serif, module, definition, example) = env

#make_cover(
  text("Differential Equations", size: 45pt),
  authors: ([Jason Siefken], [Bernardo Galvão-Sousa]),
  subtitle: align(
    left,
    stack(
      [MAT244 Workbook],
      text([#datetime.today().display("[year]/[month]/[day] Edition")], size: 12pt),
      spacing: .6em,
    ),
  ),
)

#pagebreak(to: "odd", weak: true)
#counter(page).update(1)

#show terms: it => aligned_terms(..it.children, separator: it.separator, tight: it.tight, spacing: it.spacing)

// Module 1
#(env.module)(
  title: [Modelling],
  [
    #include "modules/module1.typ"
    #import "modules/module1-practice-problems.typ": questions
    #exercises(questions, module_number: 1)
    #solutions(questions, module_number: 1)
  ],
)
// Core exercises for Module 1
#{
  import "modules/module1-exercises.typ": setup
  setup(env)
}

// Module 2
#(env.module)(
  title: [Simulation],
  [
    #include "modules/module2.typ"
    #import "modules/module2-practice-problems.typ": questions
    #exercises(questions, module_number: 2)
    #solutions(questions, module_number: 2)
  ],
)
// Core exercises for Module 2
#{
  import "modules/module2-exercises.typ": setup
  setup(env)
}

// Module 3
#(env.module)(
  title: [Systems and Models with Interacting Terms],
  [
    #include "modules/module3.typ"
    #import "modules/module3-practice-problems.typ": questions
    #exercises(questions, module_number: 3)
    #solutions(questions, module_number: 3)
  ],
)
// Core exercises for Module 3
#{
  import "modules/module3-exercises.typ": setup
  setup(env)
}

// Module 4
#(env.module)(
  title: [Equilibrium and Long-Term Behaviour],
  [
    #include "modules/module4.typ"
    #import "modules/module4-practice-problems.typ": questions
    #exercises(questions, module_number: 4)
    #solutions(questions, module_number: 4)
  ],
)
// Core exercises for Module 4
#{
  import "modules/module4-exercises.typ": setup
  setup(env)
}

#make-index()
