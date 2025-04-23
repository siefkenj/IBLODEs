#import "../libs/_workbook.typ": aligned_terms

#let MM = $upright(bold("M"))$
#let SS = $upright(bold("S"))$
#let infty = math.infinity


#let setup(env) = {
  let (sans, serif, slide, restrict, question, definition, example, theorem, solution: _solution, show_def) = env
  let slides_only = restrict.with(when: ("slides", "slides-solutions"))
  let book_only = restrict.with(when: ("book", "guide", "book-solutions"))
  let guide_only = restrict.with(when: "guide")
  let solution = content => restrict(
    when: ("guide", "book-solutions", "slides-solutions"),
    _solution(content),
  )


  question(
    slide[

      Consider the system of differential equations
      $
        x'(t) &= x(t)\
        y'(t) &= 2y(t)
      $


      + Make a phase portrait for the system.

      #link("https://www.desmos.com/calculator/h3wtwjghv0")

      + What are the equilibrium solution(s) of the system?
      + Find a formula for $x(t)$ and $y(t)$ that satisfy the initial conditions $(x(0), y(0))=(x_0, y_0)$.
      + Let $arrow(r)(t)=(x(t),y(t))$. Find a matrix $A$ so that the differential equation can be equivalently expressed
      as

      $ arrow(r)'(t) = A arrow(r)(t). $

      + Write a solution to $arrow(r)' = A arrow(r)$ (where $A$ is the matrix you came up with).

    ],
  )

  book_only(pagebreak())
  question(
    slide[

      Let $A$ be an unknown matrix and suppose $arrow(p)$ and $arrow(q)$ are solutions to $arrow(r)'=A arrow(r)$.


      + Is $arrow(s)(t)=arrow(p)(t)+arrow(q)(t)$ a solution to $arrow(r)'=A arrow(r)$? Justify your answer.
      + Can you construct other solutions from $arrow(p)$ and $arrow(q)$? If yes, how so?



    ],
  )

  book_only(pagebreak())
  question(
    slide[

      #show_def("linear_dependence_algebraic")

      Define

      $
        arrow(p)(t) = vec(e^t, 0) wide
        arrow(q)(t) = vec(4 e^t , 0) wide
        arrow(h)(t) = vec(0, e^(2t)) wide
        arrow(z)(t) = vec(0, e^(3t)).
      $

      + Are $arrow(p)$ and $arrow(q)$ linearly independent or linearly dependent? Justify with the definition.
      + Are $arrow(p)$ and $arrow(h)$ linearly independent or linearly dependent? Justify with the definition.
      + Are $arrow(h)$ and $arrow(z)$ linearly independent or linearly dependent? Justify with the definition.
      + Is the set of three functions ${arrow(p),arrow(h),arrow(z)}$ linearly independent or linearly dependent? Justify with the definition.

    ],
  )


  book_only(pagebreak())
  question(
    slide[


      Recall

      $
        arrow(p)(t) = mat(e^t; 0) wide
        arrow(q)(t) = mat(4 e^t ; 0) wide
        arrow(h)(t) = mat(0; e^(2t)) wide
        arrow(z)(t) = mat(0; e^(3t)).
      $

      + Describe $"span"{arrow(p), arrow(h)}$. What is its dimension? What is a basis for it?
      + Let $S$ be the set of all solutions to $arrow(r)'(t) = mat(1, 0; 0, 2) arrow(r)(t)$. #text(0.75em)[(You've seen this equation before.)]

      Is $S$ a subspace? If so, what is its dimension?

      + Provided $S$ is a subspace, give a basis for $S$.
    ],
  )

  book_only(pagebreak())
  question(
    slide[

      Consider the differential equation
      $ y'(t) = 2 dot.c y(t). $



      + Write a solution whose graph passes through the point $(t,y)=(0,3)$.
      + Write a solution whose graph passes through the point $(t,y)=(0,y_0)$.
      + Write a solution whose graph passes through the point $(t,y)=(t_0,y_0)$.
      + Consider the following argument:

        #aligned_terms(
          terms.item(
            "",
            [
              For every point $(t_0, y_0)$, there is a corresponding solution to $y'(t) = 2 dot.c y(t)$.

              Since ${(t_0,y_0): t_0, y_0 in RR}$ is two dimensional, this means the set of solutions to $y'(t) = 2 dot.c y(t)$ is two dimensional.
            ],
          ),
        )

      Do you agree? Explain.

    ],
  )

  book_only(pagebreak())
  question(
    slide[

      #theorem(
        title: [Existence & Uniqueness 1],
        [
          The system of differential equations represented by $arrow(r)'(t) = M arrow(r)(t) + arrow(p)$ (or the single differential equation $y' = a y + b$) has a unique solution passing through every initial condition.
          Further, the domain of every solution is $RR$.
        ],
      )

      Let $S$ be the set of all solutions to $arrow(r)(t)= mat(1,0; 0, 2) arrow(r)(t)$.

      + Show that $"dim"(S) gt.eq 2$ by finding at least two linearly independent solutions.

      + Let $I$ be the set of all initial conditions. What is $I$?
      + Show that $"dim"(S) lt.eq  3$ by applying the theorem to the set of initial conditions.
      + Can two points in $I$ correspond to the same solution? Explain?
      + Find a subset $U subset.eq I$ so that every solution corresponds to a unique point in $U$.
      + Show that $"dim"(S) lt.eq 2$.
      + Suppose $M$ is an $n times n$ matrix. Consider the differential equation $arrow(r)'(t) = M arrow(r)(t)$. If you have found $n$ linearly independent solutions, can you determine the dimension of the set of all solutions? Explain.


    ],
  )


  book_only(pagebreak())
  question(
    slide[

      Consider the system
      $
        x'(t) &= 2x(t) \
        y'(t) &= 3y(t)
      $


      + Rewrite the system in matrix form.
      + Classify the following as solutions or non-solutions to the system.

      $
        arrow(r)_1(t) &= e^(2t) & wide wide
        arrow(r)_2(t) &= mat( e^(2t); 0 ) \
        arrow(r)_3(t) &= mat( e^(2t); 4e^(3t) ) &
        arrow(r)_4(t) &= mat( e^(3t); e^(2t) ) \
        arrow(r)_5(t) &= mat( 0; 0)
      $

      + State the definition of an eigenvector for the matrix $M$.
      + What should the definition of an _eigen solution_ be for this system?
      + Which functions from 38.2 are eigen solutions?
      + Find an eigen solution $arrow(r)_6$ that is linearly independent from $arrow(r)_2$.
      + Let $S="span"{arrow(r)_2, arrow(r)_6}$. Does $S$ contain _all_ solutions to the system? Justify your answer.

    ],
  )
}
