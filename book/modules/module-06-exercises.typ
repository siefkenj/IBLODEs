#import "../libs/lib.typ": *
#show: e.prepare(question)

#{
  lesson(title: [Matrix Systems], include "lesson-week-06.typ")
  question.with(label: <ex:basic_system>)({
    learning_objectives(
      [Solve a system of differential equations that can be expressed as multiple separable
        equations.],
      [Express a system of differential equations in matrix form.],
      [Express a solution to a system of differential equations in vector form.],
    )
    notes[
      The purpose of this exercise is to establish matrix form and to give students an actual
      example of a solution to a system of differential equations.

      - It is assumed that students are familiar with linear algebra, matrices, and vectors. If not,
        have students review _before_ this day of class.

      - Introduce the vocabulary _Matrix Form_ at the end of this exercise.

      - We will differentiate between _Matrix Form_ ($arrow(r)' = A arrow(r)$) and _Affine Form_
        ($arrow(r)' = A arrow(r) + arrow(b)$) later in the course. No need to make a big deal about
        it now, but be aware as an instructor.

      - For @ex:diagonal_equation[], if some struggle, tell them to cover up one equation and try to
        solve the other. Then see if they can find solutions to both.

    ]
    slide[
      Consider the system of differential equations
      $
        x'(t) & = x(t) \
        y'(t) & = 2y(t)
      $


      + Make a phase portrait for the system.

        #link("https://www.desmos.com/calculator/h3wtwjghv0")

        #solution[
          #align(center, vector_field(
            ((x, y) => (x, 2 * y)),
            xlim: (-4, 4),
            ylim: (-4, 4),
            spacing: (.7, .7),
            scale_segments: 18,
            width: 4.8cm,
            height: 4.8cm,
            xaxis: (position: 0, tip: tiptoe.stealth, ticks: none, subticks: none),
            yaxis: (position: 0, tip: tiptoe.stealth, ticks: none, subticks: none),
          ))
        ]

      + What are the equilibrium solution(s) of the system?
        #solution[
          Equilibria satisfy $x'=0$ and $y'=0$, so $x=0$ and $y=0$. The only equilibrium solution is
          $x(t)=0$ and $y(t)=0$ for all $t$.
        ]
      + #label_question_part(<ex:diagonal_equation>) Find a formula for $x(t)$ and $y(t)$ that
        satisfy the initial conditions $(x(0), y(0))=(x_0, y_0)$.
        #solution[
          Since $x'=x$ and $y'=2y$ are independent of each other, we can solve them separately to
          get
          $
            x(t) = x_0 e^t wide
            y(t) = y_0 e^(2t).
          $
        ]
      + Let $arrow(r)(t)=(x(t),y(t))$. Find a matrix $A$ so that the differential equation can be
        equivalently expressed as

        $ arrow(r)'(t) = A arrow(r)(t). $

        #solution[
          $
            A = mat(1, 0; 0, 2),
          $
          so $arrow(r)'(t)=A arrow(r)(t)$.
        ]

      + Write a solution to $arrow(r)' = A arrow(r)$ (where $A$ is the matrix you came up with).

        _Hint: you already did most of the work!_

        #solution[
          A solution can be found by substituting the formulas for $x(t)$ and $y(t)$ that we found
          into vector form:
          $
            arrow(r)(t)
            =mat(x(t); y(t))
            = mat(x_0 e^t; y_0 e^(2t)).
          $

          To get a _particular_ solution, we can set $x_0=y_0=1$ to get
          $
            arrow(r)(t)=mat(e^t; e^(2t)).
          $
        ]

    ]
  })


  book_only(pagebreak())
  question({
    learning_objectives(
      [Be able to show that the set of solutions to a matrix differential equation forms a
        subspace.],
      [Express the set of all solutions to matrix differential equation as a span.],
      [Justify when a particular span is the set of all solutions to a matrix differential
        equation.],
    )
    notes[
      The main goal of this question is for students to know (and be able to justify) when they have
      a complete set of solutions to a matrix system. This question works towards this goal with
      minimal abstract linear algebra.

      - In physics, the term _superposition principle_ is used. We rarely use this term, preferring
        linear algebra terminology, but students should be aware of the term.
      - We don't prove the @thm:sol_space_dimension Theorem. In previous iterations, we tried to
        give a proof, but most students were confused. Working through the proof has been moved to
        the practice problems for this module.
      - Some students have had abstract linear algebra with abstract vector spaces. Some have had
        linear algebra in $RR^n$ only.
      - Don't spend a lot of time justifying why two solutions are linearly independent. For us,
        plugging in a value of $t$ (e.g. $t=1$) and seeing that the resulting vectors are linearly
        independent is sufficient. There is no need to introduce the Wronskian.
    ]
    slide[
      The _superposition principle_ states that solutions to the matrix equation
      $arrow(r)' = A arrow(r)$ form a subspace.

      + Justify that if $arrow(p)$ and $arrow(q)$ are solutions to $arrow(r)'=A arrow(r)$, then so
        is $arrow(s)(t)=arrow(p)(t)+arrow(q)(t)$. Does this show that solutions to
        $arrow(r)' = A arrow(r)$ form a subspace? What is left to show?

        #solution[
          If $arrow(p)'=A arrow(p)$ and $arrow(q)'=A arrow(q)$, then
          $
            arrow(s)' = (arrow(p)+arrow(q))' = arrow(p)' + arrow(q)' = A arrow(p) + A arrow(q)
            = A(arrow(p)+arrow(q)) = A arrow(s).
          $
          So $arrow(s)$ is a solution, and so the sum of any two solutions is a solution.

          The set of all solutions to $arrow(r)' = A arrow(r)$ *does* form a subspace. However, to
          justify this, we still need to show that scalar multiples of solutions are also solutions,
          and that the there always exists at least one solution to $arrow(r)' = A arrow(r)$.
        ]

      + #label_question_part(<ex:basic_system_span>) Recall the differential equation
        $arrow(r)'= mat(1, 0; 0, 2)arrow(r)$ from @ex:basic_system. Express the solutions you found
        as a span.

        #solution[
          $
            "span"{mat(e^t; 0), mat(0; e^(2t))}
          $
        ]

      + #label_question_part(<ex:sol_space_dimension>) Let $cal(S)$ be the set of all solutions to
        $arrow(r)'= mat(1, 0; 0, 2)arrow(r)$ and consider the following theorem:

        #theorem(
          title: [Solution Space Dimension],
          label: <thm:sol_space_dimension>,
          [
            Let $M$ be an $n times n$ matrix and let $cal(S)$ be the set of all solutions to
            $arrow(r)'(t) = M arrow(r)(t)$. Then $dim(cal(S)) = n.$
          ],
        )

        Use this theorem to justify that your span from @ex:basic_system_span[] is equal to
        $cal(S)$.

        #solution[
          The theorem states $dim(cal(S))=2$ for this $2 times 2$ system.

          The two functions
          $
            mat(e^t; 0) quad "and" quad mat(0; e^(2t))
          $
          are linearly independent solutions, so their span is a 2-dimensional subspace of $cal(S)$.
          Since $cal(S)$ itself is 2-dimensional, that span must equal all of $cal(S)$.
        ]

      + Let $cal(K)="span"{mat(e^t; e^(2t)), mat(7e^t; 7 e^(2t))}$. Is $cal(K)=cal(S)$?

        Let $cal(J)="span"{mat(e^t; e^(2t)), mat(e^t; 7 e^(2t))}$. Is $cal(J)=cal(S)$?

        Justify your answers.

        #solution[
          No for $cal(K)$: The second function in the span is $7$ times the first, so $cal(K)$ is
          1-dimensional and cannot equal the 2-dimensional space $cal(S)$.

          Yes for $cal(J)$. It is the span of two linearly independent solutions, so
          $dim(cal(J))=2$. Also each of the functions in the span are solutions of the system, so
          $cal(J) subset.eq cal(S)$.

          Since $cal(J)$ and $cal(S)$ both have dimension $2$ and $cal(J) subset.eq cal(S)$, they
          must be equal.
        ]

    ]
  })

  book_only(pagebreak())
  question.with(label: <ex:system_eigen_solutions>)({
    learning_objectives(
      [Define the term _eigen solution_.],
      [Relate _eigen solutions_ and _eigenvectors_.],
      [Identify whether a solution to a matrix differential equation is an eigen solution.],
    )
    notes[
      This question is abstract, but should be straight forward.

      - Many will not remember what an eigenvector is. Go over @ex:state_eigenvector[] on the board
        before having them work on @ex:state_eigen_function[].
    ]
    slide(force_scale: .85em)[
      Consider the system
      $
        x'(t) & = 2x(t) \
        y'(t) & = 3y(t)
      $

      + Rewrite the system in matrix form.
        #solution[
          $
            arrow(r)'(t) = mat(2, 0; 0, 3) arrow(r)(t)
            wide "where" wide arrow(r)(t)=mat(x(t); y(t)).
          $
        ]
      + Classify the following as solutions or non-solutions to the system.

        $
          arrow(r)_1(t) & = e^(2t)               & wide wide
                                                   arrow(r)_2(t) & = mat(e^(2t); 0) \
          arrow(r)_3(t) & = mat(e^(2t); 4e^(3t)) & arrow(r)_4(t) & = mat(e^(3t); e^(2t)) \
          arrow(r)_5(t) & = mat(0; 0)
        $

        #solution[
          - $arrow(r)_1$ is not a vector-valued function (as written), so it is not a solution in
            this 2-d system.

          - $arrow(r)_2$ is a solution, which can be checked by direct substitution into the system:
            $arrow(r)'_2(t) & = mat(2 e^(2t); 0)=mat(2, 0; 0, 3) arrow(r)_2(t)$.

          - $arrow(r)_3$ is also a solution (checked in a similar way).

          - $arrow(r)_4$ is not a solution:
            $arrow(r)'_4(t) & = mat(3 e^(3t); 2 e^(2t)) !=mat(2 e^(3t); 3 e^(2t)) = mat(2, 0; 0, 3) arrow(r)_4(t)$.

          - $arrow(r)_5$ is a solution (the zero solution).
        ]

      + #label_question_part(<ex:state_eigenvector>) State the definition of an eigenvector for the
        matrix $M$.
        #solution[
          A nonzero vector $arrow(v)$ is an _eigenvector_ for $M$ if there exists a scalar $lambda$
          such that
          $
            M arrow(v)=lambda arrow(v).
          $

          In other words, $arrow(v)$ is an eigenvector if it is a nonzero vector that gets
          stretched/contracted by $M$ without changing direction.
        ]
      + #label_question_part(<ex:state_eigen_function>) What should the definition of an _eigen
        solution_ be for this system? #label_question_part(
          <ex:system_eigen_solutions_part2>,
        )
        #solution[
          An eigen solution is a nonzero solution $arrow(r)(t)$ that doesn't change direction. That
          is, there exists a scalar $lambda$ so that
          $
            arrow(r)'(t) = lambda arrow(r)(t).
          $

          Note that to be an eigen solution, $arrow(r)(t)$ must also be a _solution_. That is, it
          must satisfy $arrow(r)'(t) = M arrow(r)(t).$
        ]
      + Which functions from @ex:system_eigen_solutions_part2[] are eigen solutions?
        #solution[
          We only need to check the solutions from the previous part, which are $arrow(r)_2$ and
          $arrow(r)_3$.

          - $arrow(r)_2$ is an eigen solution since $arrow(r)'_2(t)=2 arrow(r)_2(t)$.

          - $arrow(r)_3$ is a solution but not an eigen solution because
            $arrow(r)'_3(t) = mat(2 e^(2t); 12 e^(3t))$, which is not a scalar multiple of
            $arrow(r)_3(t)$.
          - $arrow(r)_5$ is a solution, but not an eigen solution because, by definition, zero
            cannot be an eigen solution.

        ]
      + Find an eigen solution $arrow(r)_6$ that is linearly independent from $arrow(r)_2$.
        #solution[
          Using $arrow(r)_2$ as inspiration, we guess
          $
            arrow(r)_6(t)=mat(0; e^(3t)).
          $
          We check that this is indeed an eigen solution:
          $arrow(r)'_6(t) & = mat(0; 3 e^(3t)) = 3 arrow(r)_6(t)$, so it is an eigen solution with
          eigenvalue $3$.
        ]
      + Let $S="span"{arrow(r)_2, arrow(r)_6}$. Does $S$ contain _all_ solutions to the system?
        Justify your answer.

        #solution[
          Yes. We have two linearly independent solutions, so $S$ has dimension 2 and consists
          solely of solutions.

          From the @thm:sol_space_dimension Theorem, we know the set of all solutions has dimension
          2, so $S$ must be the set of all solutions.
        ]

    ]
  })

  book_only(pagebreak())
  question({
    learning_objectives(
      ([Graph solutions to matrix systems in phase space.],),
    )
    notes[
      This exercise is straightforward, but don't skip it. Reasoning about phase space is still new
      to the students and they need practice.

      - This problem is constructed so that only looking at the phase portrait makes it look like
        solutions trace straight lines radially outwards. Students must think deeper (and reason
        about equations) to overcome this.

        The lesson from this is: phase portraits are helpful, but we need analytic tools to be sure
        of the behavior of solutions.
    ]
    slide[

      Recall the system
      $
        x'(t) & = 2x(t) \
        y'(t) & = 3y(t)
      $
      has eigen solutions $arrow(r)_2(t)=mat(e^(2t); 0)$ and $arrow(r)_6(t)=mat(0; e^(3t))$


      + Sketch $arrow(r)_2$ and $arrow(r)_6$ in the phase plane.
        #solution[
          #align(center, lq.diagram(
            xlim: (-4, 4),
            ylim: (-4, 4),
            width: 5cm,
            height: 5cm,
            yaxis: (position: 0, tip: tiptoe.stealth, ticks: none, subticks: none),
            xaxis: (position: 0, tip: tiptoe.stealth, ticks: none, subticks: none),
            lq.plot(
              (0, 4),
              (0, 0),
              mark: none,
              stroke: (paint: blue.darken(20%), thickness: 2.3pt),
            ),
            lq.plot(
              (0, 0),
              (0, 4),
              mark: none,
              stroke: (paint: red.darken(20%), thickness: 2.3pt),
            ),
            lq.place(3.05, 0.55, align: left, text(blue.darken(20%))[$arrow(r)_2$]),
            lq.place(0.25, 3.05, align: left, text(red.darken(20%))[$arrow(r)_6$]),
          ))
        ]
      + Use

        https://www.desmos.com/calculator/h3wtwjghv0

        to make a phase portrait for the system.

        #solution[
          #align(center, vector_field(
            ((x, y) => (2 * x, 3 * y)),
            xlim: (-4, 4),
            ylim: (-4, 4),
            spacing: (.7, .7),
            scale_segments: 18,
            width: 4.8cm,
            height: 4.8cm,
            xaxis: (position: 0, tip: tiptoe.stealth, ticks: none, subticks: none),
            yaxis: (position: 0, tip: tiptoe.stealth, ticks: none, subticks: none),
          ))
        ]

      // + Consider the solution $arrow(s)(t) = arrow(r)_2(t) - arrow(r)_6(t)$.

      //   Calculate $arrow(s)(-1)$, $arrow(s)(0)$, $arrow(s)(1)$, and $arrow(s)(2)$. Use this
      //   data to sketch a graph of $arrow(s)$ in phase space.

      + #{
          let xs = lq.linspace(0, 5, num: 20)
          let stroke = (paint: green.darken(20%), thickness: 1pt, dash: (4pt, 1pt))
          let draw_diagram(width) = {
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
          slides_only(draw_diagram(2cm), otherwise: draw_diagram(3cm))
        }
        In which phase plane above is the dashed (green) curve the graph of a solution to the
        system? Explain.

        #solution[
          The solutions have the form
          $
            arrow(r)(t)=mat(x_0 e^(2t); y_0 e^(3t)),
          $
          so as $t$ increases, the $y$-component grows faster than the $x$-component. The only curve
          that has this behavior is the one in diagram (A).
        ]

    ]
  })

  book_only(pagebreak())
  question({
    learning_objectives(
      [Graph eigen solutions in phase space using only information about their eigenvalues.],
      [Create a phase portrait for a matrix system based only on information about eigenvalues.],
    )
    notes[
      We are taking our first step towards the theorem that the stability of an equilibrium solution
      can be determined by eigenvalues.

      In this exercise, we aim to gain familiarity with eigen solutions and their relationship to
      eigenvectors and phase portraits.

      Emphasize the graphing in this question.

      - Students were primed in the previous question to think about eigen solutions that run along
        the axes. However, there are many more options and some students may bring up a
        non-axis-aligned eigen solution.

        During discussion, agree on an axis-aligned pair of linearly independent eigen solutions
        (but acknowledge that other proposals are correct, if there are other correct proposals).

      - Students may propose incompatible answers. For example $mat(e^t; 0)$ and $mat(e^(-t); 0)$.
        If they do, explain that they are both great answers, but we cannot have them both be
        solutions at the same time. We must choose.

      - In @ex:graph_non_eigen_solution[], if students struggle to find a non-eigen solution, remind
        them that they can add existing solutions to get new solutions.

        If they struggle to graph in phase space, have them plug in different $t$ values and plot
        the resulting points.

      - In @ex:graph_eigen_phase_portrait[], re-emphasize the standards for a phase portrait. E.g.,
        how many arrows are needed? What should their lengths be? etc.

        They should be graphing *by hand* (which should happen naturally, since they're not given an
        equation).

        If students struggle, remind them that the arrows in a phase portrait are tangent to
        solutions. So by graphing some eigen/non-eigen solutions and making tangent vectors, they
        should be able to get an idea for the look of the phase portrait.
    ]
    slide[
      Suppose $A$ is a $2 times 2$ matrix and $arrow(s)_1$ and $arrow(s)_2$ are eigen solutions to
      $arrow(r)' = A arrow(r)$ with eigenvalues $1$ and $-1$, respectively.

      + Write possible formulas for $arrow(s)_1(t)$ and $arrow(s)_2(t)$.
        #solution[
          $
            arrow(s)_1(t)=mat(e^t; 0) wide
            arrow(s)_2(t)=mat(0; e^(-t)).
          $
        ]
      + Sketch a phase plane with graphs of $arrow(s)_1$ and $arrow(s)_2$ on it.
        #solution[

          #align(center, lq.diagram(
            xlim: (-4, 4),
            ylim: (-4, 4),
            width: 5cm,
            height: 5cm,
            yaxis: (position: 0, tip: tiptoe.stealth, ticks: none, subticks: none),
            xaxis: (position: 0, tip: tiptoe.stealth, ticks: none, subticks: none),
            lq.plot(
              (0, 4),
              (0, 0),
              mark: none,
              stroke: (paint: blue.darken(20%), thickness: 2.3pt),
            ),
            lq.plot(
              (0, 0),
              (0, 4),
              mark: none,
              stroke: (paint: red.darken(20%), thickness: 2.3pt),
            ),
            lq.place(3.05, 0.55, align: left, text(blue.darken(20%))[$arrow(s)_1$]),
            lq.place(0.25, 3.05, align: left, text(red.darken(20%))[$arrow(s)_2$]),
          ))
        ]
      + #label_question_part(<ex:graph_non_eigen_solution>) Add a non-eigen solution to your sketch.
        #solution[
          Adding the two eigen solutions together, we get another solution
          $arrow(r)(t) = mat(e^t; e^(-t))$. Plotting this gives:
          #{
            let xs = lq.linspace(.25, 4, num: 80)
            align(center, lq.diagram(
              xlim: (-4, 4),
              ylim: (-4, 4),
              width: 5cm,
              height: 5cm,
              yaxis: (position: 0, tip: tiptoe.stealth, ticks: none, subticks: none),
              xaxis: (position: 0, tip: tiptoe.stealth, ticks: none, subticks: none),
              lq.plot(
                (0, 4),
                (0, 0),
                mark: none,
                stroke: (paint: blue.darken(20%), thickness: 2.3pt),
              ),
              lq.plot(
                (0, 0),
                (0, 4),
                mark: none,
                stroke: (paint: red.darken(20%), thickness: 2.3pt),
              ),
              lq.plot(
                xs,
                xs.map(x => 1 / x),
                mark: none,
                stroke: (paint: green.darken(20%), thickness: 1.8pt),
              ),
              lq.place(1.5, 1.1, align: left, text(green.darken(20%))[$arrow(r)$]),
            ))
          }
        ]
      + #label_question_part(<ex:graph_eigen_phase_portrait>) Sketch a possible phase portrait for
        $arrow(r)' = A arrow(r)$. Can you extend your phase portrait to all quadrants?
        #solution[

          #align(center, vector_field(
            ((x, y) => (x, -y)),
            xlim: (-4, 4),
            ylim: (-4, 4),
            spacing: (.7, .7),
            scale_segments: 18,
            width: 4.8cm,
            height: 4.8cm,
            xaxis: (position: 0, tip: tiptoe.stealth, ticks: none, subticks: none),
            yaxis: (position: 0, tip: tiptoe.stealth, ticks: none, subticks: none),
          ))
        ]
    ]
  })

  book_only(pagebreak())
  question({
    learning_objectives(
      [Identify the graphs of solutions and non-solutions overlaid on a phase portrait.],
      [Identify the graphs of eigen solutions using a phase portrait.],
      [Identify the signs of eigenvalues using a phase portrait.],
    )
    notes[
      This question is rich. Phrased in terms of pictures, we want students to wrestle with the
      meaning of solutions, eigen solutions, and phase portraits. Ensure you have adequate time for
      this question.

      - For @ex:eigen_solution_from_graph[], students may guess a solution without a good
        justification. For example, they might guess that "eigen solutions are straight lines", but
        not be able to explain why.

        Students will *really struggle* with this justification. The explanation we would like is
        that if you are at position $arrow(r)(t)$ along the graph of an eigen solution, then the
        arrow at that point in the phase portrait must be $arrow(r)'(t)=lambda arrow(r)(t)$, and so
        it can only point directly towards or directly away from the origin.

        Thinking about $arrow(r)(t)$ as a vector (in relation to the origin) will be awkward for
        them.

      - @ex:guess_eigenvalues[] is under-determined. Encourage students to think in terms of eigen
        solutions, sketching and then comparing with the direction of the arrows in the phase
        portrait.

    ]
    slide(force_scale: .9em)[

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

      + #label_question_part(<ex:eigen_solution_from_graph>) Identify which of $arrow(f)$,
        $arrow(g)$, and $arrow(h)$ are _solutions_ to the differential equation. Which are _eigen
        solutions_?
        #solution[
          When a _solution_ $arrow(r)(t)$ is graphed on a phase portrait, the arrows of the phase
          portrait will be tangent to the graph of $arrow(r)$.

          When a solution $arrow(r)(t)$ is an _eigen solution_, the arrow of the phase portrait at
          location $arrow(r)(t)$ is a multiple of $arrow(r)(t)$.

          - $arrow(f)$ is _not_ a solution.
          - $arrow(g)$ is a solution and is an _eigen_ solution.
          - $arrow(h)$ is a solution but _not_ an eigen solution.
        ]
      + Graph an additional eigen solution.
        #solution[

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
                  (0, 10),
                  mark: none,
                  stroke: 1.5pt + green.darken(20%),
                ),
              ),
            )
          }
        ]
      + #label_question_part(<ex:guess_eigenvalues>) What can you say about the eigenvalues of $A$?
        What are their signs?
        #solution[
          The eigen values could be $plus.minus 1$ (or $plus.minus 2$, etc.). What we know for sure
          is that they are of opposite signs.
        ]
    ]
  })

  book_only(pagebreak())
  question(label: <ex:system_eigen_solutions_in_general>, {
    learning_objectives(
      [???],
    )
    notes[???]
    slide[

      Consider the differential equation $arrow(r)'(t) = M arrow(r)(t)$ where $M = mat(0, 2; 2, 0)$.

      + Verify that $mat(1; 1)$ and $mat(1; -1)$ are eigenvectors for $M$. What are the
        corresponding eigenvalues?

        #solution[
          $M mat(1; 1)=mat(2; 2)=2 mat(1; 1),$
          so $mat(1; 1)$ has eigenvalue $2$.

          $M mat(1; -1)=mat(-2; 2)=-2 mat(1; -1),$
          so $mat(1; -1)$ has eigenvalue $-2$.
        ]

      +
        + Is $arrow(r)_1(t) = e^(2t) mat(1; 0)$ a solution to the differential equation? An eigen
          solution?
          #solution[
            No. $arrow(r)'_1(t)=mat(2e^(2t); 0)$ but $M arrow(r)_1(t)=mat(0; 2e^(2t))$. Since the
            two are not equal, it is neither a solution nor an eigen solution.
          ]
        + Is $arrow(r)_2(t) = e^(2t) mat(1; 1)$ a solution to the differential equation? An eigen
          solution?
          #solution[
            Yes.
            $arrow(r)'_2 (t)=2e^(2t)mat(1; 1)=M arrow(r)_2(t),$
            so it is a solution. Additionally, $arrow(r)'_2 (t) = 2 arrow(r)_2 (t)$, so it is an
            eigen solution.
          ]
        + Is $arrow(r)_3(t) = e^(t) mat(1; -1)$ a solution to the differential equation? An eigen
          solution?
          #solution[
            No. Computing,
            $arrow(r)'_3(t)=e^t mat(1; -1) = 1 arrow(r)_3 (t),$
            but
            $
              M arrow(r)_3(t)=-2e^t mat(1; -1).
            $
            Because the two don't match, $arrow(r)_3$ is not a solution. Since it is not a solution,
            it cannot be an eigen solution.
          ]

      + Find an eigen solution for the system corresponding to the eigenvalue $-2$. Write your
        answer in vector form.

        #solution[
          $
            arrow(r)(t)=e^(-2t) mat(1; -1)
          $
        ]

      + Let $arrow(v)$ be an eigenvector for $M$ with eigenvalue $lambda$. Explain how to write down
        an eigen solution to $arrow(r)'(t) = M arrow(r)(t)$ with eigenvalue $lambda$.

        #solution[
          Define
          $arrow(r)(t)=e^(lambda t) arrow(v).$
          Then $arrow(r)'(t)=lambda e^(lambda t)arrow(v)=e^(lambda t)M arrow(v)=M arrow(r)(t)$.
        ]

      + Let $arrow(v) != arrow(0)$ be a non-eigenvector for $M$. Could
        $arrow(r)(t) = e^(lambda t) arrow(v)$ be a solution to $arrow(r)'(t) = M arrow(r)(t)$ for
        some $lambda$? Explain.

        #solution[
          No. Substituting gives
          $
            lambda e^(lambda t) arrow(v)=M(e^(lambda t)arrow(v))=e^(lambda t)M arrow(v).
          $
          Since $arrow(v) != arrow(0)$, we must have $M arrow(v)=lambda arrow(v)$. That would make
          $arrow(v)$ an eigenvector, contradicting the assumption.
        ]

    ]
  })

  book_only(pagebreak())
  question({
    learning_objectives(
      [???],
    )
    notes[???]
    slide[
      #slides_only(v(0.5em))
      Recall the differential equation $arrow(r)'(t) = M arrow(r)(t)$ where $M = mat(0, 2; 2, 0)$.

      + #label_question_part(<ex:general_eigen_solution_with_params>) Write down a general solution
        to the differential equation.
        #solution[
          In @ex:system_eigen_solutions_in_general, we found eigen solutions $e^(2t) mat(1; 1)$ and
          $e^(-2t) mat(1; -1)$. Linear combinations of these give us the general solution:
          $
            arrow(r)(t)=C_1 e^(2t) mat(1; 1) + C_2 e^(-2t) mat(1; -1)
          $
          where $C_1$ and $C_2$ are parameters.
        ]
      + Write down a solution to the initial value problem $arrow(r)(0) = mat(x_0; y_0)$.
        #solution[
          Letting $t=0$ in the general solution, we have
          $
            mat(x_0; y_0)=C_1 mat(1; 1)+C_2 mat(1; -1),
          $
          so
          $
            C_1=(x_0+y_0)/2, quad C_2=(x_0-y_0)/2.
          $
          Therefore
          $
            arrow(r)(t)=
            (x_0+y_0)/2 e^(2t) mat(1; 1)
            + (x_0-y_0)/2 e^(-2t) mat(1; -1).
          $
        ]
      + #label_question_part(<ex:general_eigen_solution_with_initial_values>) Are your answers to
        the first two parts the same? Do they contain the same information?
        #solution[
          No, they are not the same formula. However, they do contain the same information.

          In @ex:general_eigen_solution_with_params[], we used parameters $C_1$ and $C_2$. In
          @ex:general_eigen_solution_with_initial_values[], we wrote a solution in terms of an
          arbitrary initial condition $(x_0,y_0)$. These are different ways of writing solutions,
          however, every solution in @ex:general_eigen_solution_with_params[] can be written in the
          form of the solution in @ex:general_eigen_solution_with_initial_values[] and vice versa,
          so they contain the same information.
        ]
    ]
  })

  book_only(pagebreak())
  question({
    learning_objectives(
      [???],
    )
    notes[???]
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
        #solution[
          They are rotations of each other.
        ]
      + Suppose $P$ is a $2 times 2$ matrix with eigenvalues $plus.minus 2$. In what ways could the
        phase portrait for $arrow(r)'(t) = P arrow(r)(t)$ look _different_ from the above portraits?
        In what way(s) must it look the same?
        #solution[
          The overall "flow" of the vectors must be the same (there is a line radiating away from
          the origin and a line wih vectors pointing towards the origin), but those two lines can
          point in any direction; they do not need to be orthogonal to each other.
        ]
    ]
  })

  lesson(title: [Matrix Systems Continued], include "lesson-week-07.typ")
  book_only(pagebreak())
  question({
    learning_objectives(
      [???],
    )
    notes[???]
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
          #solution[
            Sketch a saddle: trajectories approach the origin along direction $arrow(a)$ and move
            away along direction $arrow(b)$.

            Mark arrows short near the origin and long far from the origin (speed increases with
            distance from equilibrium in this linear setting).
          ]
        + Sketch a phase portrait for the differential equation. Pay close attention to when the
          arrows are long vs. short.
          #solution[
            Draw invariant lines in directions $arrow(a)$ and $arrow(b)$, then add curved
            trajectories bending from the stable direction toward the unstable direction. Arrow
            lengths should be smallest near $(0,0)$ and larger farther away.
          ]
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
        #solution[
          Qualitative portraits:

          (1) and (2): saddle.

          (3): source/repelling node (both eigendirections unstable).

          (4): sink/attracting node (both eigendirections stable).

          (5): one unstable eigendirection and one neutral eigendirection (line of non-decaying
          behavior).
        ]
      ]

      + Classify the solution at the origin for situations (1)--(5) as stable or unstable.
        #solution[
          (1) unstable, (2) unstable, (3) unstable, (4) stable (asymptotically stable), (5)
          unstable.
        ]
      + Would any of your classifications in the previous part change if the directions of
        $arrow(a)$ and $arrow(b)$ changed?
        #solution[
          No. Classification depends on eigenvalue signs, not on the specific orientation of
          eigendirections in the plane.
        ]
    ]
  })


  book_only(pagebreak())
  question({
    learning_objectives(
      [???],
    )
    notes[???]
    slide[


      You are examining a differential equation $arrow(r)'(t) = M arrow(r)(t)$ for an unknown
      $2 times 2$ matrix $M$.

      You would like to determine whether $arrow(r)(t) = mat(0; 0)$ is stable, unstable, attracting,
      or repelling.

      + Come up with a rule to determine the nature of the equilibrium solution
        $arrow(r)(t) = mat(0; 0)$ based on the eigenvalues of $M$ (provided there exist two linearly
        independent eigen solutions).
        #solution[
          For a $2 times 2$ linear system with two independent eigen solutions:

          - both eigenvalues $lt 0$: attracting/sink (asymptotically stable)
          - both eigenvalues $gt 0$: repelling/source (unstable)
          - opposite signs: saddle (unstable)
          - one zero eigenvalue: not asymptotically stable; stability depends on the other sign
            (with a positive other eigenvalue it is unstable).
        ]
      + Consider the system of differential equations
        $
          x'(t) & = x(t) + 2 dot y(t) \
          y'(t) & = 3 dot x(t) - 4 dot y(t)
        $

        + Classify the stability of the equilibrium solution $(x(t), y(t)) = (0, 0)$ using any
          method you want.
          #solution[
            Unstable (a saddle).
          ]
        + Justify your answer analytically using eigenvalues.
          #solution[
            The coefficient matrix is $M=mat(1, 2; 3, -4)$.

            Its characteristic polynomial is
            $
              det(M-lambda I) = lambda^2 + 3lambda - 10 = (lambda-2)(lambda+5).
            $
            So eigenvalues are $2$ and $-5$, which have opposite signs. Therefore $(0,0)$ is a
            saddle equilibrium, hence unstable.
          ]

    ]
  })
}
