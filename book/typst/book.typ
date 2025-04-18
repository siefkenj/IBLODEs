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

#serif[
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

  // Module 5
  #(env.module)(
    title: [Qualitative Analysis: Slope Fields and Phase Portraits],
    [
      #include "modules/module5.typ"
      #import "modules/module5-practice-problems.typ": questions
      #exercises(questions, module_number: 5)
      #solutions(questions, module_number: 5)
    ],
  )
  // Core exercises for Module 5
  #{
    import "modules/module5-exercises.typ": setup
    setup(env)
  }

  // Module 6
  #(env.module)(
    title: [Linear Systems with Constant Coefficients (Real Solutions)],
    [
      #include "modules/module6.typ"
      #import "modules/module6-practice-problems.typ": questions
      #exercises(questions, module_number: 6)
      #solutions(questions, module_number: 6)
    ],
  )
  // Core exercises for Module 6
  #{
    import "modules/module6-exercises.typ": setup
    setup(env)
  }

  // Module 7
  #(env.module)(
    title: [Linear Systems with Constant Coefficients (Affine Solutions)],
    [
      #include "modules/module7.typ"
      #import "modules/module7-practice-problems.typ": questions
      #exercises(questions, module_number: 7)
      #solutions(questions, module_number: 7)
    ],
  )
  // Core exercises for Module 7
  #{
    import "modules/module7-exercises.typ": setup
    setup(env)
  }

  // Module 8
  #(env.module)(
    title: [Linear Systems with Constant Coefficients (Complex Solutions)],
    [
      #include "modules/module8.typ"
      #import "modules/module8-practice-problems.typ": questions
      #exercises(questions, module_number: 8)
      #solutions(questions, module_number: 8)
    ],
  )
  // Core exercises for Module 8
  #{
    import "modules/module8-exercises.typ": setup
    setup(env)
  }

  // Module 9
  #(env.module)(
    title: [Quantitative Analysis: Linearization],
    [
      #include "modules/module9.typ"
      #import "modules/module9-practice-problems.typ": questions
      #exercises(questions, module_number: 9)
      #solutions(questions, module_number: 9)
    ],
  )
  // Core exercises for Module 9
  #{
    import "modules/module9-exercises.typ": setup
    setup(env)
  }
  
  // Module 10
  #(env.module)(
    title: [Higher Order Differential Equations],
    [
      #include "modules/module10.typ"
      #import "modules/module10-practice-problems.typ": questions
      #exercises(questions, module_number: 10)
      #solutions(questions, module_number: 10)
    ],
  )
  // Core exercises for Module 10
  #{
    import "modules/module10-exercises.typ": setup
    setup(env)
  }
  
  // Module 11
  #(env.module)(
    title: [Introduction to Boundary Value Problems],
    [
      #include "modules/module11.typ"
      #import "modules/module11-practice-problems.typ": questions
      #exercises(questions, module_number: 11)
      #solutions(questions, module_number: 11)
    ],
  )
  // Core exercises for Module 11
  #{
    import "modules/module11-exercises.typ": setup
    setup(env)
  }

  // Module 12
  #(env.module)(
    title: [Introduction to the Theory of Ordinary Differential Equations],
    [
      #include "modules/module12.typ"
      #import "modules/module12-practice-problems.typ": questions
      #exercises(questions, module_number: 12)
      #solutions(questions, module_number: 12)
    ],
  )
  // Core exercises for Module 12
  #{
    import "modules/module12-exercises.typ": setup
    setup(env)
  }
  #make-index()
]
