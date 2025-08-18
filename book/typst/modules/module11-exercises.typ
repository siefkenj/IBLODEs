#import "../libs/_workbook.typ": aligned_terms

#let MM = $upright(bold("M"))$
#let SS = $upright(bold("S"))$
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
    slide[

      #slides_only([*Boundary Value Problems*])

      Recall the spring-mass system modeled by
      $ x'' = -x $

      We would like to use the spring-mass system to ring a bell at regular intervals, 
      so we put a hammer at the end of the spring. Whenever the displacement is maximal,
      the hammer strikes a bell producing a ring.

      + Convert the spring-mass system into a system of differential equations.
        Make a phase portrait for the system using the following Desmos link:

        #link("https://www.desmos.com/calculator/fvqxqp6eds")

      + In the _Options Euler_ on Desmos, adjust $Delta$ and the number of steps so that simulated solutions are only 
        shown for $t in [0, 1]$.

        Use simulations to answer the remaining questions.

      + You start by displacing the hammer by $1$m and letting go. Is it possible that the bell rings every 1 second?

      + You start by displacing the hammer by $1$m and giving the hammer a push. Is it possible that the bell rings every 1 second?

      + What is the smallest amount of time between consecutive rings (given a positive displacement)?

    ],
  )

  book_only(pagebreak())
  question(
    slide(force_scale: 0.95em)[

      #slides_only([*Boundary Value Problems*])

    Recall the spring-mass system modeled by
    $ x'' = -x $
    We would like to use the spring-mass system to ring a bell at regular intervals, 
    so we put a hammer at the end of the spring. Whenever the displacement is maximal,
    the hammer strikes a bell producing a ring.

    The general solution to the spring-mass system can also be written as
    $
      x(t) = A cos(t + d)
    $
    where $A,d in RR$ are parameters.

    // Consider the subspaces
    // $ S_1 = "span"{ sin(t), cos(t) } quad S_2 = { A cos(t + d) : A, d in RR } $

    // + What dimension is each subspace?
    // + Which subspaces are sets of solutions to the spring-mass system?
    // + Use what you know about complete solutions and linear algebra to prove $S_1 = S_2$.

    //   Use your knowledge about $S_1$ and $S_2$ to 
    Analytically answer the remaining questions.
    + You start by displacing the hammer by $1$m and letting go. Is it possible that the bell rings every 1 second?
    + You start by displacing the hammer by $1$m and giving the hammer a push. Is it possible that the bell rings every 1 second?
    + What is the smallest amount of time between consecutive rings (given a positive displacement)?

    ],
  )



book_only(pagebreak())
  question(
    slide[

      #slides_only([*Boundary Value Problems*])


      A boundary value problem is a differential equation paired with two conditions
      at different values of $t$.

      Consider the following boundary value problems:

       #align(
        center,
        table(
          columns: 3,
          align: (center, center, center),
          stroke: none,
          column-gutter: 1em,
          table.header(
            [(i)], 
            [(ii)],
            [(iii)],
          ),
            // Equations
            $x'' = -x$,
            $x'' = -x$,
            $x'' = -x$,
            // Boundary condition at left endpoint
            $x(0) = 1$,
            $x(0) = 1$,
            $x(0) = 1$,
            // Boundary condition at right endpoint
            $x(pi) = 1$,
            $x(pi) = -1$,
            $x(pi / 2) = 0$,
          )
       )

        

      + Using phase portraits and simulations, determine how many solutions each boundary value problem has.
      + Can you find analytic arguments to justify your conclusions?

  ],
)


}