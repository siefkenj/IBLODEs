#import "../libs/_workbook.typ": aligned_terms

#let MM = $upright(bold("M"))$
#let SS = $upright(bold("S"))$
#let OO = $upright(bold("O"))$
#let infty = math.infinity

#let setup(env) = {
  let (sans, serif, slide, restrict, question, definition, solution: _solution, show_def) = env
  let slides_only = restrict.with(when: ("slides", "slides-solutions"))
  let book_only = restrict.with(when: ("book", "guide", "book-solutions"))
  let guide_only = restrict.with(when: "guide")
  let solution = content => restrict(
    when: ("guide", "book-solutions", "slides-solutions"),
    _solution(content),
  )


  question(
    slide(force_scale: .95em)[
      Open the spreadsheet

      #link("https://uoft.me/foxes-and-rabbits")[https://uoft.me/foxes-and-rabbits]

      which contains an Euler approximation for the Foxes and Rabbits population.
      $
        F'(t) &= (0.01 dot R(t) - 1.1) dot F(t) \
        R'(t) &= (1.1 - 0.1 dot F(t)) dot R(t)
      $

      #show_def("equilibrium_solution")

      + By changing initial conditions, what is the "smallest" curve you can get in the phase plane? What happens at
        those initial conditions?
      + What should $F'$ and $R'$ be if $F$ and $R$ are _equilibrium solutions_?
      + How many equilibrium solutions are there for the fox-and-rabbit system? Justify your answer.
      + What do the equilibrium solutions look like in the phase plane? What about their component graphs?
    ],
  )

  book_only(pagebreak())
  question(
    slide[

      Recall the logistic model for starfish growth:
      #aligned_terms(
        terms.item(
          OO,
          [\# new children per year $~$ current population times the fraction of total resources remaining],
        ),
      )

      which can be modeled with the equation
      $
        P'(t) = k dot P(t) dot (1 - R_i / R dot P(t))
      $

      where
      - $P(t)$ is the population at time $t$
      - $k$ is a constant of proportionality
      - $R$ is the total number of resources
      - $R_i$ is the resources that one starfish wants to consume

      Use $k = 1.1$, $R = 1$, and $R_i = 0.1$ unless instructed otherwise.

      + What are the equilibrium solutions for model #OO?
      + What does a "phase plane" for model #OO look like? What do graphs of equilibrium solutions look like?
      + Classify the behaviour of solutions that lie _between_ the equilibrium solutions. E.g., are they increasing, decreasing, oscillating?
    ],
  )

  book_only(pagebreak())
  question({
    slide(force_scale: 0.75em)[
      #show_def("equilibrium_classification_informal")
      #show_def("equilibrium_classification_formal")
    ]
    slide(force_scale: 0.9em)[
      #show_def("equilibrium_classification_informal")

      Let
      $
        F'(t) = ?
      $
      be an unknown differential equation with equilibrium solution $f(t) = 1$.

      + Draw an example of what solutions might look like if $f$ is _attracting_.
      + Draw an example of what solutions might look like if $f$ is _repelling_.
      + Draw an example of what solutions might look like if $f$ is _stable_.
      + Could $f$ be stable but _not_ attracting?
    ]
  })

  book_only(pagebreak())
  question(
    slide[

      #show_def("equilibrium_classification_informal")

      Recall the starfish population model #OO given by
      $ P'(t) = k dot P(t) dot (1 - R_i / R dot P(t)) $
      Use $k = 1.1$, $R = 1$, and $R_i = 0.1$ unless instructed otherwise.

      + Classify the equilibrium solutions for model #OO as attracting, repelling, stable, unstable, or semi-stable.
      + Does changing $k$ change the nature of the equilibrium solutions? How can you tell?

    ],
  )

  book_only(pagebreak())
  question(
    slide[


    ],
  )
}
