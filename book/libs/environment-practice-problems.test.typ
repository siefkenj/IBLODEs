#import "environments.typ": *
#import "environment-module.typ": *
#import "settings-module.typ": *
#import "settings.typ": *
#import "environment-practice-problems.typ": *

#set page(height: 5in)

= Tests for the practice problem function.

#practice_problem(
  statement: [Here is a practice problem with parts
    + Part 1.
      + Subpart A.
      + Subpart B.
    + Part 2.
  ],
)

#practice_problem(
  statement: [This practice problem includes a solution field.],
  solution: [Let $u = x^2$. Then integrate directly.],
)

#practice_problem(
  statement: [This practice problem includes a citation.],
  citation: [Calculus, Section 2.5, Exercise 14.],
)

#practice_problem(
  statement: [This practice problem includes both a solution and a citation.],
  solution: [Apply separation of variables and then use the initial condition.],
  citation: [Jiri Lebl, _Differential Equations for Engineers_, Chapter 1.],
)

= Test a collection of practice problems.

#practice_problems(
  (
    (
      statement: [Here is a practice problem with parts
        + Part 1.
          + Subpart A.
          + Subpart B.
        + Part 2.
      ],
    ),
    (
      statement: [This practice problem includes a solution field.],
      solution: [Let $u = x^2$. Then integrate directly.],
    ),
    (
      statement: [This practice problem includes a citation.],
      citation: [Calculus, Section 2.5, Exercise 14.],
    ),
    (
      statement: [This practice problem includes both a solution and a citation.],
      solution: [Apply separation of variables and then use the initial condition.],
      citation: [Jiri Lebl, _Differential Equations for Engineers_, Chapter 1.],
    ),
  ),
)

#pagebreak()
#show: e.set_(global_settings, double_sided: false)
#module(
  title: [Practice problems in a module],
)[
  Here is a module with practice problems.
  #practice_problems(
    (
      (
        statement: [Here is a practice problem with parts
          + Part 1.
            + Subpart A.
            + Subpart B.
          + Part 2.
        ],
      ),
      (
        statement: [This practice problem includes a solution field.],
        solution: [Let $u = x^2$. Then integrate directly.],
      ),
      (
        statement: [This practice problem includes a citation.],
        citation: [Calculus, Section 2.5, Exercise 14.],
      ),
      (
        statement: [This practice problem includes both a solution and a citation.],
        solution: [Apply separation of variables and then use the initial condition.],
        citation: [Jiri Lebl, _Differential Equations for Engineers_, Chapter 1.],
      ),
    ),
  )
]
#show: e.set_(
  module_settings,
  sidebar_color: color.rgb("#7db967"),
  supplement: "Appendix",
  numbering: "A",
)
#module(
  title: [Practice problems in a module 2],
)[
  Here is a module with practice problems.
  #practice_problems(
    (
      (
        statement: [Here is a practice problem with parts
          + Part 1.
            + Subpart A.
            + Subpart B.
          + Part 2.
        ],
        solution: [
          + Stuff
            + Do it
          + Well
        ],
      ),
      (
        statement: [This practice problem includes both a solution and a citation.],
        solution: [Apply separation of variables and then use the initial condition.],
        citation: [Jiri Lebl, _Differential Equations for Engineers_, Chapter 1.],
      ),
    ),
  )
]


#module(
  title: [Solutions Module],
)[
  Here is a module with practice problem solutions

  #practice_problem_solutions()
]

= Test copyright setting

#show: e.set_(
  global_settings,
  copyright: "Copyright 2024. All rights reserved.",
  double_sided: false,
)

#module(
  title: [Copyright Test Module],
)[
  This module should have a copyright.
]

#[
  #show: e.set_(global_settings, copyright: "No copying permitted.")

  #module(
    title: [Copyright Test Module 2],
  )[
    This module should have a different copyright.
  ]
]

#module(
  title: [Copyright Test Module 3],
)[
  This module should have the same copyright as two modules previous.
]
