#import "../libs/_workbook.typ": aligned_terms, simple_table, label_core_exercise
#import "../libs/_graphics.typ": vector_field
#import "@preview/lilaq:0.4.0" as lq
#import "@preview/tiptoe:0.3.1"

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
      #label_core_exercise(<ex:basic_system>)

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
        arrow(q)(t) = vec(4 e^t, 0) wide
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
        arrow(q)(t) = mat(4 e^t; 0) wide
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

      XXX TO BE REMOVED - ADDED TO MODULE 6 PRACTICE PROBLEMS

      #theorem(
        title: [Existence & Uniqueness 1],
        [
          The system of differential equations represented by $arrow(r)'(t) = M arrow(r)(t) + arrow(p)$ (or the single differential equation $y' = a y + b$) has a unique solution passing through every initial condition.
          Further, the domain of every solution is $RR$.
        ],
      )

      Let $S$ be the set of all solutions to $arrow(r)(t)= mat(1, 0; 0, 2) arrow(r)(t)$.

      + Show that $"dim"(S) gt.eq 2$ by finding at least two linearly independent solutions.

      + Let $I$ be the set of all initial conditions. What is $I$?
      + Show that $"dim"(S) lt.eq 3$ by applying the theorem to the set of initial conditions.
      + Can two points in $I$ correspond to the same solution? Explain?
      + Find a subset $U subset.eq I$ so that every solution corresponds to a unique point in $U$.
      + Show that $"dim"(S) lt.eq 2$.
      + Suppose $M$ is an $n times n$ matrix. Consider the differential equation $arrow(r)'(t) = M arrow(r)(t)$. If you have found $n$ linearly independent solutions, can you determine the dimension of the set of all solutions? Explain.


    ],
  )


  book_only(pagebreak())
  question(
    slide(force_scale: 0.85em)[
      #label_core_exercise(<ex:system_eigen_solutions>)

      Consider the system
      $
        x'(t) &= 2x(t) \
        y'(t) &= 3y(t)
      $


      + Rewrite the system in matrix form.
      + Classify the following as solutions or non-solutions to the system.

      $
        arrow(r)_1(t) &= e^(2t) & wide wide
        arrow(r)_2(t) &= mat(e^(2t); 0) \
        arrow(r)_3(t) &= mat(e^(2t); 4e^(3t)) &
        arrow(r)_4(t) &= mat(e^(3t); e^(2t)) \
        arrow(r)_5(t) &= mat(0; 0)
      $

      + State the definition of an eigenvector for the matrix $M$.
      + What should the definition of an _eigen solution_ be for this system? #label_core_exercise(<ex:system_eigen_solutions_part2>)
      + Which functions from @ex:system_eigen_solutions_part2[] are eigen solutions?
      + Find an eigen solution $arrow(r)_6$ that is linearly independent from $arrow(r)_2$.
      + Let $S="span"{arrow(r)_2, arrow(r)_6}$. Does $S$ contain _all_ solutions to the system? Justify your answer.

    ],
  )

  book_only(pagebreak())
  question(
    slide[

      Recall the system
      $
        x'(t) &= 2x(t) \
        y'(t) &= 3y(t)
      $
      has eigen solutions $arrow(r)_2(t)=mat(e^(2t); 0)$ and $arrow(r)_6(t)=mat(0; e^(3t))$


      + Sketch $arrow(r)_2$ and $arrow(r)_6$ in the phase plane.
      + Use

        https://www.desmos.com/calculator/h3wtwjghv0

        to make a phase portrait for the system.

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
        In which phase plane above is the dashed (green) curve
        the graph of a solution to the system? Explain.

    ],
  )

  book_only(pagebreak())
  question(
    slide[

      Suppose $A$ is a $2 times 2$ matrix and $arrow(s)_1$ and $arrow(s)_2$ are eigen solutions to $arrow(r)' = A arrow(r)$ with eigenvalues $1$ and $-1$, respectively.

      + Write possible formulas for $arrow(s)_1(t)$ and $arrow(s)_2(t)$.
      + Sketch a phase plane with graphs of $arrow(s)_1$ and $arrow(s)_2$ on it.
      + Add a non-eigen solution to your sketch.
      + Sketch a possible phase portrait for $arrow(r)' = A arrow(r)$. Can you extend your phase portrait to all quadrants?
    ],
  )

  book_only(pagebreak())
  question(
    slide[

      Consider the following phase portrait for a system of the form $arrow(r)' = A arrow(r)$
      for an unknown matrix $A$.

      #let F(x, y) = (y, x)
      #align(
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
        ),
      )

      + Can you identify any eigen solutions?
      + What are the eigenvalues of $A$? What are their signs?
    ],
  )

  book_only(pagebreak())
  question(
    slide[

      Consider the differential equation $arrow(r)'(t) = M arrow(r)(t)$ where $M = mat(0, 1; 1, 0)$.

      + Verify that $mat(1; 1)$ and $mat(1; -1)$ are eigenvectors for $M$. What are the corresponding eigenvalues?

      +
        + Is $arrow(r)_1(t) = e^t mat(1; 0)$ a solution to the differential equation? An eigen solution?
        + Is $arrow(r)_2(t) = e^t mat(1; 1)$ a solution to the differential equation? An eigen solution?
        + Is $arrow(r)_3(t) = e^(2t) mat(1; -1)$ a solution to the differential equation? An eigen solution?

      + Find an eigen solution for the system corresponding to the eigenvalue $-1$. Write your answer in vector form.

      + Let $arrow(v)$ be an eigenvector for $M$ with eigenvalue $lambda$. Explain how to write down an eigen solution to $arrow(r)'(t) = M arrow(r)(t)$ with eigenvalue $lambda$.

      + Let $arrow(v) != arrow(0)$ be a non-eigenvector for $M$. Could $arrow(r)(t) = e^(lambda t) arrow(v)$ be a solution to $arrow(r)'(t) = M arrow(r)(t)$ for some $lambda$? Explain.
    ],
  )

  book_only(pagebreak())
  question(
    slide[
      #slides_only(v(0.5em))
      Recall the differential equation $arrow(r)'(t) = M arrow(r)(t)$ where $M = mat(0, 1; 1, 0)$.

      + Write down a general solution to the differential equation.
      + Write down a solution to the initial value problem $arrow(r)(0) = mat(x_0; y_0)$.
      + Are your answers to the first two parts the same? Do they contain the same information?
    ],
  )

  book_only(pagebreak())
  question(
    slide[

      The phase portrait for a differential equation arising from the matrix $mat(0, 1; 1, 0)$ (left)
      and $mat(1, 0; 0, -1)$ (right) are shown.

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

      Both have eigenvalues $plus.minus 1$, but they have different eigenvectors.

      + How are the phase portraits related to each other?
      + Suppose $P$ is a $2 times 2$ matrix with eigenvalues $plus.minus 1$. In what ways could
        the phase portrait for $arrow(r)'(t) = P arrow(r)(t)$ look _different_ from the above portraits?
        In what way(s) must it look the same?
    ],
  )

  book_only(pagebreak())
  question(
    slide[

      Consider the following phase plane with lines in the direction of $arrow(a)$ (dashed green) and $arrow(b)$ (red).


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

      + Sketch a phase portrait where the directions $arrow(a)$ and $arrow(b)$ correspond to eigen solutions with eigenvalues that are:

        #align(
          center,
          simple_table(
            headers: ([], [sign for $arrow(a)$], [sign for $arrow(b)$]),
            content: (
              [1],
              [pos],
              [pos],
              [2],
              [neg],
              [neg],
              [3],
              [neg],
              [pos],
              [4],
              [pos],
              [neg],
              [5],
              [pos],
              [zero],
            ),
          ),
        )

      + Classify the solution at the origin for situations (1)--(5) as stable or unstable.
      + Would any of your classifications in the previous part change if the directions of $arrow(a)$ and $arrow(b)$ changed?
    ],
  )


  book_only(pagebreak())
  question(
    slide[


      You are examining a differential equation $arrow(r)'(t) = M arrow(r)(t)$ for an unknown $2 times 2$ matrix $M$.

      You would like to determine whether $arrow(r)(t) = mat(0; 0)$ is stable, unstable, attracting, or repelling.

      + Come up with a rule to determine the nature of the equilibrium solution $arrow(r)(t) = mat(0; 0)$ based on the eigenvalues of $M$ (provided there exist two linearly independent eigen solutions).
      + Consider the system of differential equations
        $
          x'(t) &= x(t) + 2 dot y(t) \
          y'(t) &= 3 dot x(t) - 4 dot y(t)
        $

        + Classify the stability of the equilibrium solution $(x(t), y(t)) = (0, 0)$ using any method you want.
        + Justify your answer analytically using eigenvalues.

    ],
  )
}
