#import "../libs/_workbook.typ": aligned_terms, label_core_exercise, simple_table
#import "../libs/_graphics.typ": vector_field
#import "../libs/_ode_solvers.typ": solve_2d_ivp
#import "@preview/lilaq:0.4.0" as lq
#import "@preview/tiptoe:0.3.1"

#let MM = $upright(bold("M"))$
#let SS = $upright(bold("S"))$
#let infty = math.infinity


#let setup(env) = {
  let (
    sans,
    serif,
    slide,
    restrict,
    question,
    definition,
    example,
    theorem,
    solution: _solution,
    show_def,
  ) = env
  let slides_only = restrict.with(when: ("slides", "slides-solutions"))
  let book_only = restrict.with(when: ("book", "guide", "book-solutions"))
  let guide_only = restrict.with(when: "guide")
  let solution = content => restrict(
    when: ("guide", "book-solutions", "slides-solutions"),
    _solution(content),
  )


  question(
    slide[
      #label_core_exercise(<ex:basic_system>)

      Consider the system of differential equations
      $
        x'(t) & = x(t) \
        y'(t) & = 2y(t)
      $


      + Make a phase portrait for the system.

        #link("https://www.desmos.com/calculator/h3wtwjghv0")

      + What are the equilibrium solution(s) of the system?
      + Find a formula for $x(t)$ and $y(t)$ that satisfy the initial conditions
        $(x(0), y(0))=(x_0, y_0)$.
      + Let $arrow(r)(t)=(x(t),y(t))$. Find a matrix $A$ so that the differential equation can be
        equivalently expressed as

        $ arrow(r)'(t) = A arrow(r)(t). $

      + Write a solution to $arrow(r)' = A arrow(r)$ (where $A$ is the matrix you came up with).

        _Hint: you already did most of the work!_

    ],
  )


  book_only(pagebreak())
  question(
    slide[
      The _superposition principle_ states that solutions to the matrix equation
      $arrow(r)' = A arrow(r)$ form a subspace.

      + Justify that if $arrow(p)$ and $arrow(q)$ are solutions to $arrow(r)'=A arrow(r)$, then so
        is $arrow(s)(t)=arrow(p)(t)+arrow(q)(t)$. Does this show that solutions to
        $arrow(r)' = A arrow(r)$ form a subspace? What is left to show?

      + #label_core_exercise(<ex:basic_system_span>) Recall the differential equation
        $arrow(r)'= mat(1, 0; 0, 2)arrow(r)$ from @ex:basic_system. Express the solutions you found
        as a span.

      + Let $cal(S)$ be the set of all solutions to $arrow(r)'= mat(1, 0; 0, 2)arrow(r)$ and
        consider the following theorem:

        #theorem(
          title: [Solution Space Dimension],
          [
            Let $M$ be an $n times n$ matrix and let $cal(S)$ be the set of all solutions to
            $arrow(r)'(t) = M arrow(r)(t)$. Then $dim(cal(S)) = n.$
          ],
        )

        Use this theorem to justify that your span from @ex:basic_system_span[] is equal to
        $cal(S)$.

      + Let $cal(K)="span"{mat(e^t; e^(2t)), mat(7e^t; 7 e^(2t))}$. Is $cal(K)=cal(S)$?

        Let $cal(J)="span"{mat(e^t; e^(2t)), mat(e^t; 7 e^(2t))}$. Is $cal(J)=cal(S)$?

        Justify your answers.

    ],
  )

  book_only(pagebreak())
  question(
    slide(force_scale: 0.85em)[
      #label_core_exercise(<ex:system_eigen_solutions>)

      Consider the system
      $
        x'(t) & = 2x(t) \
        y'(t) & = 3y(t)
      $


      + Rewrite the system in matrix form.
      + Classify the following as solutions or non-solutions to the system.

      $
        arrow(r)_1(t) & = e^(2t)               & wide wide
                                                 arrow(r)_2(t) & = mat(e^(2t); 0) \
        arrow(r)_3(t) & = mat(e^(2t); 4e^(3t)) & arrow(r)_4(t) & = mat(e^(3t); e^(2t)) \
        arrow(r)_5(t) & = mat(0; 0)
      $

      + State the definition of an eigenvector for the matrix $M$.
      + What should the definition of an _eigen solution_ be for this system? #label_core_exercise(
          <ex:system_eigen_solutions_part2>,
        )
      + Which functions from @ex:system_eigen_solutions_part2[] are eigen solutions?
      + Find an eigen solution $arrow(r)_6$ that is linearly independent from $arrow(r)_2$.
      + Let $S="span"{arrow(r)_2, arrow(r)_6}$. Does $S$ contain _all_ solutions to the system?
        Justify your answer.

    ],
  )

  book_only(pagebreak())
  question(
    slide[

      Recall the system
      $
        x'(t) & = 2x(t) \
        y'(t) & = 3y(t)
      $
      has eigen solutions $arrow(r)_2(t)=mat(e^(2t); 0)$ and $arrow(r)_6(t)=mat(0; e^(3t))$


      + Sketch $arrow(r)_2$ and $arrow(r)_6$ in the phase plane.
      + Use

        https://www.desmos.com/calculator/h3wtwjghv0

        to make a phase portrait for the system.

      // + Consider the solution $arrow(s)(t) = arrow(r)_2(t) - arrow(r)_6(t)$.

      //   Calculate $arrow(s)(-1)$, $arrow(s)(0)$, $arrow(s)(1)$, and $arrow(s)(2)$. Use this
      //   data to sketch a graph of $arrow(s)$ in phase space.

      + #{
          let xs = lq.linspace(0, 5, num: 20)
          let stroke = (paint: green.darken(20%), thickness: 1pt, dash: (4pt, 1pt))
          let width = slides_only(2cm, otherwise: 3cm)

          box(
            width: 100%,
            align(
              center,
              {
                lq.diagram(
                  title: "(A)",
                  xlim: (-.5, 5.5),
                  ylim: (-.5, 5.5),
                  width: width,
                  height: width,
                  yaxis: (position: 0, tip: tiptoe.stealth, filter: ((v, d) => false)),
                  xaxis: (position: 0, tip: tiptoe.stealth, filter: ((v, d) => false)),
                  lq.plot(
                    xs,
                    xs.map(x => calc.pow(x, 3 / 2)),
                    mark: none,
                    stroke: stroke,
                  ),
                )
                h(1em)
                lq.diagram(
                  title: "(B)",
                  xlim: (-.5, 5.5),
                  ylim: (-.5, 5.5),
                  width: width,
                  height: width,
                  yaxis: (position: 0, tip: tiptoe.stealth, filter: ((v, d) => false)),
                  xaxis: (position: 0, tip: tiptoe.stealth, filter: ((v, d) => false)),
                  lq.plot(
                    xs,
                    xs.map(x => calc.pow(x, 2 / 3)),
                    mark: none,
                    stroke: stroke,
                  ),
                )
                h(1em)
                lq.diagram(
                  title: "(C)",
                  xlim: (-.5, 5.5),
                  ylim: (-.5, 5.5),
                  width: width,
                  height: width,
                  yaxis: (position: 0, tip: tiptoe.stealth, filter: ((v, d) => false)),
                  xaxis: (position: 0, tip: tiptoe.stealth, filter: ((v, d) => false)),
                  lq.plot(
                    xs,
                    xs.map(x => 2 * x),
                    mark: none,
                    stroke: stroke,
                  ),
                )
              },
            ),
          )
        }
        In which phase plane above is the dashed (green) curve the graph of a solution to the
        system? Explain.

    ],
  )

  book_only(pagebreak())
  question(
    slide[

      Suppose $A$ is a $2 times 2$ matrix and $arrow(s)_1$ and $arrow(s)_2$ are eigen solutions to
      $arrow(r)' = A arrow(r)$ with eigenvalues $1$ and $-1$, respectively.

      + Write possible formulas for $arrow(s)_1(t)$ and $arrow(s)_2(t)$.
      + Sketch a phase plane with graphs of $arrow(s)_1$ and $arrow(s)_2$ on it.
      + Add a non-eigen solution to your sketch.
      + Sketch a possible phase portrait for $arrow(r)' = A arrow(r)$. Can you extend your phase
        portrait to all quadrants?
    ],
  )

  book_only(pagebreak())
  question(
    slide[

      Consider the following phase portrait for a system of the form $arrow(r)' = A arrow(r)$ for an
      unknown matrix $A$.

      #{
        let F(x, y) = (y, x)
        let res = solve_2d_ivp(F, (-8.5, 10), 50, Delta: .05, method: "rk4")
        let (xs, ys) = (res.map(((x, y)) => x), res.map(((x, y)) => y))
        align(
          center,
          vector_field(
            F,
            xlim: (-10, 10),
            ylim: (-10, 10),
            spacing: (1.5, 1.5),
            scale_segments: 20.0,
            width: 5cm,
            height: 5cm,
            yaxis: (position: 0, tip: tiptoe.stealth, ticks: none, subticks: none),
            xaxis: (position: 0, tip: tiptoe.stealth, ticks: none, subticks: none),
            lq.plot(
              (0, 10),
              (0, -10),
              mark: none,
              stroke: 1.5pt,
            ),
            lq.plot(
              (0, 10),
              (0, 5),
              mark: none,
              stroke: 1.5pt,
            ),
            lq.plot(
              xs,
              ys,
              mark: none,
              stroke: 1.5pt,
            ),
            lq.place(10, 5, align: left, text(fill: orange.darken(20%), pad(.3em)[$arrow(f)(t)$])),
            lq.place(10, -9, align: left, text(fill: blue.darken(20%), pad(.3em)[$arrow(g)(t)$])),
            lq.place(8, 9, align: left, text(fill: red.darken(40%), pad(.3em)[$arrow(h)(t)$])),
          ),
        )
      }

      + Identify which of $arrow(f)$, $arrow(g)$, and $arrow(h)$ are _solutions_ to the differential
        equation. Which are _eigen solutions_?
      + Graph an additional eigen solution.
      + What can you say about the eigenvalues of $A$? What are their signs?
    ],
  )

  book_only(pagebreak())
  question(
    slide[

      Consider the differential equation $arrow(r)'(t) = M arrow(r)(t)$ where $M = mat(0, 2; 2, 0)$.

      + Verify that $mat(1; 1)$ and $mat(1; -1)$ are eigenvectors for $M$. What are the
        corresponding eigenvalues?

      +
        + Is $arrow(r)_1(t) = e^(2t) mat(1; 0)$ a solution to the differential equation? An eigen
          solution?
        + Is $arrow(r)_2(t) = e^(2t) mat(1; 1)$ a solution to the differential equation? An eigen
          solution?
        + Is $arrow(r)_3(t) = e^(t) mat(1; -1)$ a solution to the differential equation? An eigen
          solution?

      + Find an eigen solution for the system corresponding to the eigenvalue $-2$. Write your
        answer in vector form.

      + Let $arrow(v)$ be an eigenvector for $M$ with eigenvalue $lambda$. Explain how to write down
        an eigen solution to $arrow(r)'(t) = M arrow(r)(t)$ with eigenvalue $lambda$.

      + Let $arrow(v) != arrow(0)$ be a non-eigenvector for $M$. Could
        $arrow(r)(t) = e^(lambda t) arrow(v)$ be a solution to $arrow(r)'(t) = M arrow(r)(t)$ for
        some $lambda$? Explain.
    ],
  )

  book_only(pagebreak())
  question(
    slide[
      #slides_only(v(0.5em))
      Recall the differential equation $arrow(r)'(t) = M arrow(r)(t)$ where $M = mat(0, 2; 2, 0)$.

      + Write down a general solution to the differential equation.
      + Write down a solution to the initial value problem $arrow(r)(0) = mat(x_0; y_0)$.
      + Are your answers to the first two parts the same? Do they contain the same information?
    ],
  )

  book_only(pagebreak())
  question(
    slide[

      The phase portrait for a differential equation arising from the matrix $mat(0, 2; 2, 0)$
      (left) and $mat(2, 0; 0, -2)$ (right) are shown.

      #align(
        center,
        {
          vector_field(
            (x, y) => (y, x),
            xlim: (-10, 10),
            ylim: (-10, 10),
            spacing: (1.5, 1.5),
            scale_segments: 20.0,
            width: 4cm,
            height: 4cm,
            yaxis: (position: 0, tip: tiptoe.stealth, ticks: none, subticks: none),
            xaxis: (position: 0, tip: tiptoe.stealth, ticks: none, subticks: none),
          )
          h(1em)
          vector_field(
            (x, y) => (x, -y),
            xlim: (-10, 10),
            ylim: (-10, 10),
            spacing: (1.5, 1.5),
            scale_segments: 20.0,
            width: 4cm,
            height: 4cm,
            yaxis: (position: 0, tip: tiptoe.stealth, ticks: none, subticks: none),
            xaxis: (position: 0, tip: tiptoe.stealth, ticks: none, subticks: none),
          )
        },
      )

      Both have eigenvalues $plus.minus 2$, but they have different eigenvectors.

      + How are the phase portraits related to each other?
      + Suppose $P$ is a $2 times 2$ matrix with eigenvalues $plus.minus 2$. In what ways could the
        phase portrait for $arrow(r)'(t) = P arrow(r)(t)$ look _different_ from the above portraits?
        In what way(s) must it look the same?
    ],
  )

  book_only(pagebreak())
  question({
    let intro = [
      The lines with directions $arrow(a)$ (dashed green) and $arrow(b)$ (red) are graphs of eigen
      solutions to a differential equation.


      #align(
        center,
        {
          let xs = lq.linspace(-3.5, 3.5, num: 2)
          let xticks = lq.linspace(-3, 3, num: 7)
          lq.diagram(
            xlim: (-3.5, 3.5),
            ylim: (-3.5, 3.5),
            width: 5cm,
            height: 5cm,
            yaxis: (position: 0, tip: tiptoe.stealth, ticks: xticks, filter: ((v, d) => false)),
            xaxis: (position: 0, tip: tiptoe.stealth, ticks: xticks, filter: ((v, d) => false)),
            lq.plot(
              xs,
              xs.map(x => 3 * x),
              mark: none,
              stroke: (paint: red, thickness: 1pt),
            ),
            lq.place(0.7, 3)[#text(red)[$arrow(b)$]],
            lq.plot(
              xs,
              xs.map(x => x / 3),
              mark: none,
              stroke: (paint: green.darken(20%), thickness: 1pt, dash: (3pt, 1pt)),
            ),
            lq.place(3, 1.3)[#text(green.darken(20%))[$arrow(a)$]],
          )
        },
      )
    ]

    slide(force_scale: .9em)[
      #intro

      + Suppose the eigenvalue for $arrow(a)$ is $-1$ and the eigenvalue for $arrow(b)$ is $1$.
        + Sketch five possible solutions to the differential equation and mark where each solution
          curve is traced out fastest vs. slowest.
        + Sketch a phase portrait for the differential equation. Pay close attention to when the
          arrows are long vs. short.
    ]
    slide(force_scale: .9em)[
      #slides_only(intro)

      #enum.item(2)[
        Sketch a phase portrait where the eigenvalues associated with $arrow(a)$ and $arrow(b)$ are:

        #align(
          center,
          simple_table(
            headers: ([], [sign for $arrow(a)$], [sign for $arrow(b)$]),
            content: (
              [1],
              [neg],
              [pos],
              [2],
              [pos],
              [neg],
              [3],
              [pos],
              [pos],
              [4],
              [neg],
              [neg],
              [5],
              [pos],
              [zero],
            ),
          ),
        )
      ]

      + Classify the solution at the origin for situations (1)--(5) as stable or unstable.
      + Would any of your classifications in the previous part change if the directions of
        $arrow(a)$ and $arrow(b)$ changed?
    ]
  })


  book_only(pagebreak())
  question(
    slide[


      You are examining a differential equation $arrow(r)'(t) = M arrow(r)(t)$ for an unknown
      $2 times 2$ matrix $M$.

      You would like to determine whether $arrow(r)(t) = mat(0; 0)$ is stable, unstable, attracting,
      or repelling.

      + Come up with a rule to determine the nature of the equilibrium solution
        $arrow(r)(t) = mat(0; 0)$ based on the eigenvalues of $M$ (provided there exist two linearly
        independent eigen solutions).
      + Consider the system of differential equations
        $
          x'(t) & = x(t) + 2 dot y(t) \
          y'(t) & = 3 dot x(t) - 4 dot y(t)
        $

        + Classify the stability of the equilibrium solution $(x(t), y(t)) = (0, 0)$ using any
          method you want.
        + Justify your answer analytically using eigenvalues.

    ],
  )
}
