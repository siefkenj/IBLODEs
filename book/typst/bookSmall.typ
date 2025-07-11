#import "@preview/in-dexter:0.7.0": *
#import "common/cover.typ": make_cover
#import "libs/_workbook.typ": exercises, solutions, aligned_terms, _show_ref
//#import "_workbook.typ": setup
#set page(paper: "us-letter")
#set par(justify: true)

//#let workbook = setup(banner_color: color.rgb("#00a2cb"))
#import "common/settings-book.typ": env
#let (sans, serif, module, definition, example) = env



#pagebreak(to: "odd", weak: true)
#counter(page).update(1)

// Allow us to use `@ref` syntax to reference core exercises, etc.
#show ref: _show_ref

#show terms: it => aligned_terms(..it.children, separator: it.separator, tight: it.tight, spacing: it.spacing)


#set math.mat(delim: "[")


#serif[
  // Module 1
  #(env.module)(
    title: [Modelling],
    [
      
      #import "modules/module1-practice-problems.typ": questions
      #exercises(questions, module_number: 1)
      #solutions(questions, module_number: 1)
    ],
  ) 

  // Module 2
  #(env.module)(
    title: [Simulation],
    [
      
      #import "modules/module4-practice-problems.typ": questions
      #exercises(questions, module_number: 2)
      #solutions(questions, module_number: 2)
    ]
  )


  // Module 3
  #(env.module)(
    title: [Systems and Models with Interacting Terms],
    [
      
      #import "modules/module3-practice-problems.typ": questions
      #exercises(questions, module_number: 3)
      #solutions(questions, module_number: 3)
    ],
  )
]
