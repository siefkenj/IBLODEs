#import "@preview/in-dexter:0.7.0": *
#import "common/cover.typ": make_cover
#import "libs/_workbook.typ": exercises, solutions, aligned_terms
//#import "_workbook.typ": setup
#set par(justify: true)
#set page(
  width: 17.7cm,
  height: 10cm,
  margin: (x: 4pt, top: .7cm, bottom: 3cm),
  footer-descent: 8pt,
)

//#let workbook = setup(banner_color: color.rgb("#00a2cb"))
#import "common/settings-slides.typ": env
#let (sans, serif, module, definition, example) = env

#make_cover(
  text("Differential Equations", size: 45pt),
  authors: ([Jason Siefken], [Bernardo Galvão-Sousa]),
  subtitle: align(
    left,
    stack(
      [MAT244 Slides],
      text([#datetime.today().display("[year]/[month]/[day] Edition")], size: 12pt),
      spacing: .6em,
    ),
  ),
)


#counter(page).update(1)


#serif[

  // Core exercises for Module 1
  #{
    import "modules/module1-exercises.typ": setup
    setup(env)
  }

  // Core exercises for Module 2
  #{
    import "modules/module2-exercises.typ": setup
    setup(env)
  }

  // Core exercises for Module 3
  #{
    import "modules/module3-exercises.typ": setup
    setup(env)
  }

  // Core exercises for Module 4
  #{
    import "modules/module4-exercises.typ": setup
    setup(env)
  }
]


