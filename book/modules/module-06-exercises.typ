#import "../libs/lib.typ": *
#show: e.prepare(question)

#{
  lesson(title: [Matrix Systems], include "lesson-week-06.typ")
  question.with(label: <ex:basic_system>)({
    learning_objectives(
      [???],
    )
    notes[???]
    slide[
      Consider the system of differential equations
      $
        x'(t) & = x(t) \
        y'(t) & = 2y(t)
      $


      + Make a phase portrait for the system.

        #link("https://www.desmos.com/calculator/h3wtwjghv0")

        #solution[
          XXX ADD PHASE PORTRAIT
        ]
        // #solution[
        //   The origin is the only equilibrium. Away from the origin, arrows point away from
        //   $(0,0)$ in every quadrant. The vertical component grows faster than the horizontal one
        //   (because $y'=2y$), so trajectories bend toward vertical as $|t|$ increases.
        // ]

      + What are the equilibrium solution(s) of the system?
        #solution[
          Equilibria satisfy $x'=0$ and $y'=0$, so $x=0$ and $y=0$. The only equilibrium solution is $x(t)=0$ and $y(t)=0$ for all $t$.
        ]
      + Find a formula for $x(t)$ and $y(t)$ that satisfy the initial conditions
        $(x(0), y(0))=(x_0, y_0)$.
        #solution[
          Since $x'=x$ and $y'=2y$ are independent of each other, we can solve them separately to get
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
          A solution can be found by substituting the formulas for $x(t)$ and $y(t)$ that we found into vector form:
          $
            arrow(r)(t)
              =mat(x(t); y(t))
              = mat(x_0 e^t; y_0 e^(2t)).
          $

          To get a solution, we can set $x_0=y_0=1$ to get
          $
            arrow(r)(t)=mat(e^t; e^(2t)).
          $
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
          So $arrow(s)$ is a solution. This proves closure under addition.

          To conclude subspace, we still need closure under scalar multiplication and that the zero
          function is in the set, that is, we need to show that:
          - If $arrow(p)$ is a solution and $c in RR$, then $c space.thin arrow(p)$ is a solution.
          - The zero function $arrow(z)(t)=mat(0;0)$ is a solution.
        ]

      + #label_question_part(<ex:basic_system_span>) Recall the differential equation
        $arrow(r)'= mat(1, 0; 0, 2)arrow(r)$ from @ex:basic_system. Express the solutions you found
        as a span.

        #solution[
          The solutions we found can be expressed as
          $ 
            arrow(r)(t) = x_0 mat(e^t; 0) + y_0 mat(0; e^(2t)),
          $
          so they are linear combination of the functions
          $ 
            mat(e^t; 0) quad "and" quad mat(0; e^(2t)).
          $

          Therefore, the set of solutions is the span of these two functions:
          $
            "span"{mat(e^t; 0), mat(0; e^(2t))}.
          $
        ]

      + #label_question_part(<ex:sol_space_dimension>) Let $cal(S)$ be the set of all solutions to $arrow(r)'= mat(1, 0; 0, 2)arrow(r)$ and
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

        #solution[
          The theorem says $dim(cal(S))=2$ for this $2 times 2$ system.

          The two functions
          $
            mat(e^t;0) quad "and" quad mat(0;e^(2t))
          $
          are linearly independent solutions, so their span is a 2-dimensional subspace of
          $cal(S)$. Since $cal(S)$ itself is 2-dimensional, that span must equal all of $cal(S)$.
        ]

      + Let $cal(K)="span"{mat(e^t; e^(2t)), mat(7e^t; 7 e^(2t))}$. Is $cal(K)=cal(S)$?

        Let $cal(J)="span"{mat(e^t; e^(2t)), mat(e^t; 7 e^(2t))}$. Is $cal(J)=cal(S)$?

        Justify your answers.

        #solution[
          No for $cal(K)$: The second function in the span is $7$ times the first, so $cal(K)$ is 1-dimensional
          and cannot equal the 2-dimensional space $cal(S)$.

          Yes for $cal(J)$. Its generators are linearly independent, so $dim(cal(J))=2$. Also each of hte functions in the span are solutions of the system, so $cal(J) subset.eq cal(S)$. 
          
          Since $cal(J)$ and $cal(S)$ both have dimension $2$ and $cal(J) subset.eq cal(S)$, they must be equal.
        ]

    ]
  })

  book_only(pagebreak())
  question.with(label: <ex:system_eigen_solutions>)({
    learning_objectives(
      [???],
    )
    notes[???]
    slide(force_scale: .85em)[
      Consider the system
      $
        x'(t) & = 2x(t) \
        y'(t) & = 3y(t)
      $

      + Rewrite the system in matrix form.
        #solution[
          $
            arrow(r)'(t) = mat(2, 0; 0, 3) arrow(r)(t),
          $
          where $arrow(r)(t)=mat(x(t);y(t))$.
        ]
      + Classify the following as solutions or non-solutions to the system.

        $
          arrow(r)_1(t) & = e^(2t)               & wide wide
                                                   arrow(r)_2(t) & = mat(e^(2t); 0) \
          arrow(r)_3(t) & = mat(e^(2t); 4e^(3t)) & arrow(r)_4(t) & = mat(e^(3t); e^(2t)) \
          arrow(r)_5(t) & = mat(0; 0)
        $

        #solution[
          $arrow(r)_1$ is not even a vector-valued function (as written), so it is not a solution in
          this 2D system.

          $arrow(r)_2$ is a solution, which can be checked by direct substitution into the system:
          $ 
            arrow(r)'_2(t) & = mat(2 e^(2t); 0) \
            mat(2, 0; 0, 3) arrow(r)_2(t) & = mat(2 e^(2t); 0)
          $
          which matches, so $arrow(r)_2$ is a solution.
          
          $arrow(r)_3$ is also a solution (can be checked in a similar way).

          $arrow(r)_4$ is not a solution:
          $
            arrow(r)'_4(t) & = mat(3 e^(3t); 2 e^(2t)) \
            mat(2, 0; 0, 3) arrow(r)_4(t) & = mat(2 e^(3t); 3 e^(2t))
          $
          which do not match.

          $arrow(r)_5$ is a solution (the zero solution).
        ]

      + State the definition of an eigenvector for the matrix $M$.
        #solution[
          A nonzero vector $arrow(v)$ is an eigenvector of $M$ if there exists a scalar $lambda$ such
          that
          $
            M arrow(v)=lambda arrow(v).
          $

          In other words, $arrow(v)$ is an eigenvector if it is a nonzero vector that gets stretched/contracted by $M$ without changing direction.
        ]
      + What should the definition of an _eigen solution_ be for this system? #label_question_part(
          <ex:system_eigen_solutions_part2>,
        )
        #solution[
          An eigen solution is a nonzero solution $arrow(r)(t)$ that doesn't change direction, so it satisfies
          $ 
              arrow(r)'(t) = lambda arrow(r)(t),
          $
          for some $lambda in RR$.
          
          Note that to be an eigen solution, it must also be a solution to the system, so it must also satisfy
          $
            arrow(r)'(t) = M arrow(r)(t).
          $
        ]
      + Which functions from @ex:system_eigen_solutions_part2[] are eigen solutions?
        #solution[
          We only need to check the solutions from the previous part, which are $arrow(r)_2$ and $arrow(r)_3$.

          $arrow(r)_2$ is an eigen solution since $arrow(r)'_2(t)=2 arrow(r)_2(t)$.

          $arrow(r)_3$ is a solution but not an eigen solution because $arrow(r)'_3(t) = mat(2 e^(2t); 12 e^(3t))$ which cannot be written as a scalar multiple of $arrow(r)_3(t)$.


          $arrow(r)_5$ is a solution, but not counted as an eigen solution since it is the zero
          function.

        ]
      + Find an eigen solution $arrow(r)_6$ that is linearly independent from $arrow(r)_2$.
        #solution[
          Extending the example of $arrow(r)_2$, we can find another eigen solution by using the second component of the solution:
          $
            arrow(r)_6(t)=mat(0; e^(3t)).
          $
          We can check that this is indeed an eigen solution:
          $
            arrow(r)'_6(t) & = mat(0; 3 e^(3t)) = 3 arrow(r)_6(t) 
          $
          so it is an eigen solution with eigenvalue $3$.
        ]
      + Let $S="span"{arrow(r)_2, arrow(r)_6}$. Does $S$ contain _all_ solutions to the system?
        Justify your answer.

        #solution[
          Yes. We have two linearly independent solutions, so $S$ has dimension 2 and $S subset.eq cal(S)$.
          
          From the Theorem in @ex:sol_space_dimension[], we know $cal(S)$ has dimension 2, so $S=cal(S)$.
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

      Recall the system
      $
        x'(t) & = 2x(t) \
        y'(t) & = 3y(t)
      $
      has eigen solutions $arrow(r)_2(t)=mat(e^(2t); 0)$ and $arrow(r)_6(t)=mat(0; e^(3t))$


      + Sketch $arrow(r)_2$ and $arrow(r)_6$ in the phase plane.
        #solution[

          XXX ADD GRAPHS

          $arrow(r)_2$ traces the $x$-axis (for positive scalar multiples, it moves away from the
          origin as $t$ increases). $arrow(r)_6$ traces the $y$-axis (also away from the origin for
          positive multiples).
        ]
      + Use

        https://www.desmos.com/calculator/h3wtwjghv0

        to make a phase portrait for the system.

        #solution[
          XXX ADD PHASE PORTRAIT
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
          so as $t$ increases, the $y$-component grows faster than the $x$-component. The only curve that has this behavior is the one in diagram (A).
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
      Suppose $A$ is a $2 times 2$ matrix and $arrow(s)_1$ and $arrow(s)_2$ are eigen solutions to
      $arrow(r)' = A arrow(r)$ with eigenvalues $1$ and $-1$, respectively.

      + Write possible formulas for $arrow(s)_1(t)$ and $arrow(s)_2(t)$.
        #solution[
          For some nonzero vectors $arrow(v)_1, arrow(v)_2$,
          $
            arrow(s)_1(t)=e^t arrow(v)_1, wide
            arrow(s)_2(t)=e^(-t) arrow(v)_2.
          $
        ]
      + Sketch a phase plane with graphs of $arrow(s)_1$ and $arrow(s)_2$ on it.
        #solution[
          Draw two lines through the origin in the eigenvector directions: one unstable eigendirection
          (for eigenvalue $1$) and one stable eigendirection (for eigenvalue $-1$).
        ]
      + Add a non-eigen solution to your sketch.
        #solution[
          Add a trajectory for
          $
            arrow(r)(t)=e^t arrow(v)_1 + e^(-t) arrow(v)_2
          $
          with both coefficients nonzero. This curve is not a straight line through the origin.
        ]
      + Sketch a possible phase portrait for $arrow(r)' = A arrow(r)$. Can you extend your phase
        portrait to all quadrants?
        #solution[
          A saddle portrait: arrows move away from the origin along the $lambda=1$ eigendirection and
          toward the origin along the $lambda=-1$ eigendirection. Yes, it extends to all quadrants by
          symmetry of the linear system.
        ]
    ]
  })

  book_only(pagebreak())
  question({
    learning_objectives(
      [???],
    )
    notes[???]
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

      + Identify which of $arrow(f)$, $arrow(g)$, and $arrow(h)$ are _solutions_ to the differential
        equation. Which are _eigen solutions_?
        #solution[
          The smooth curve that follows the vector field is a solution trajectory.

          The vertical segment/line is not a solution curve for this system (except at the origin),
          because the vector field is not tangent to it away from $(0,0)$.

          Eigen solutions must be straight lines through the origin in eigendirections, so only a
          line aligned with an eigendirection would count as an eigen solution.
        ]
      + Graph an additional eigen solution.
        #solution[
          For this portrait (with dynamics like $x'=y, y'=x$), one eigen solution is
          $
            arrow(r)(t)=e^t mat(1;1).
          $
          Another is $e^(-t) mat(1;-1)$.
        ]
      + What can you say about the eigenvalues of $A$? What are their signs?
        #solution[
          The portrait has saddle behavior, so one eigenvalue is positive and one is negative.
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

      Consider the differential equation $arrow(r)'(t) = M arrow(r)(t)$ where $M = mat(0, 2; 2, 0)$.

      + Verify that $mat(1; 1)$ and $mat(1; -1)$ are eigenvectors for $M$. What are the
        corresponding eigenvalues?

        #solution[
          $
            M mat(1;1)=mat(2;2)=2 mat(1;1),
          $
          so $mat(1;1)$ has eigenvalue $2$.

          $
            M mat(1;-1)=mat(-2;2)=-2 mat(1;-1),
          $
          so $mat(1;-1)$ has eigenvalue $-2$.
        ]

      +
        + Is $arrow(r)_1(t) = e^(2t) mat(1; 0)$ a solution to the differential equation? An eigen
          solution?
          #solution[
            No. $arrow(r)_1'(t)=mat(2e^(2t);0)$ but
            $M arrow(r)_1(t)=mat(0;2e^(2t))$, so they are not equal.
            Therefore it is neither a solution nor an eigen solution.
          ]
        + Is $arrow(r)_2(t) = e^(2t) mat(1; 1)$ a solution to the differential equation? An eigen
          solution?
          #solution[
            Yes. Since $mat(1;1)$ is an eigenvector with eigenvalue $2$,
            $
              arrow(r)_2'(t)=2e^(2t)mat(1;1)=M arrow(r)_2(t).
            $
            So it is a solution, and specifically an eigen solution.
          ]
        + Is $arrow(r)_3(t) = e^(t) mat(1; -1)$ a solution to the differential equation? An eigen
          solution?
          #solution[
            No. For $mat(1;-1)$ the matching exponential rate should be $e^(-2t)$, not $e^t$.
            Indeed,
            $
              arrow(r)_3'(t)=e^t mat(1;-1),
            $
            while
            $
              M arrow(r)_3(t)=-2e^t mat(1;-1).
            $
            So it is not a solution, hence not an eigen solution.
          ]

      + Find an eigen solution for the system corresponding to the eigenvalue $-2$. Write your
        answer in vector form.

        #solution[
          $
            arrow(r)(t)=e^(-2t) mat(1;-1)
          $
          (or any nonzero scalar multiple of this).
        ]

      + Let $arrow(v)$ be an eigenvector for $M$ with eigenvalue $lambda$. Explain how to write down
        an eigen solution to $arrow(r)'(t) = M arrow(r)(t)$ with eigenvalue $lambda$.

        #solution[
          Use
          $
            arrow(r)(t)=e^(lambda t) arrow(v).
          $
          Then $arrow(r)'(t)=lambda e^(lambda t)arrow(v)=e^(lambda t)M arrow(v)=M arrow(r)(t)$.
        ]

      + Let $arrow(v) != arrow(0)$ be a non-eigenvector for $M$. Could
        $arrow(r)(t) = e^(lambda t) arrow(v)$ be a solution to $arrow(r)'(t) = M arrow(r)(t)$ for
        some $lambda$? Explain.

        #solution[
          No. Substituting gives
          $
            lambda e^(lambda t) arrow(v)=M(e^(lambda t)arrow(v))=e^(lambda t)M arrow(v),
          $
          so we must have $M arrow(v)=lambda arrow(v)$. That would make $arrow(v)$ an eigenvector,
          contradicting the assumption.
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

      + Write down a general solution to the differential equation.
        #solution[
          Using eigenpairs $(2, mat(1;1))$ and $(-2, mat(1;-1))$:
          $
            arrow(r)(t)=C_1 e^(2t) mat(1;1) + C_2 e^(-2t) mat(1;-1).
          $
        ]
      + Write down a solution to the initial value problem $arrow(r)(0) = mat(x_0; y_0)$.
        #solution[
          Solve
          $
            mat(x_0;y_0)=C_1 mat(1;1)+C_2 mat(1;-1),
          $
          so
          $
            C_1=(x_0+y_0)/2, quad C_2=(x_0-y_0)/2.
          $
          Therefore
          $
            arrow(r)(t)=
            (x_0+y_0)/2 e^(2t) mat(1;1)
            + (x_0-y_0)/2 e^(-2t) mat(1;-1).
          $
        ]
      + Are your answers to the first two parts the same? Do they contain the same information?
        #solution[
          Yes. They are the same family of solutions written with different parameters.

          The general form uses free constants $(C_1,C_2)$; the IVP form rewrites those constants in
          terms of the initial data $(x_0,y_0)$.
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
          They are both saddle portraits. One can be obtained from the other by a linear change of
          coordinates (a rotation/scaling that aligns eigenvector directions).
        ]
      + Suppose $P$ is a $2 times 2$ matrix with eigenvalues $plus.minus 2$. In what ways could the
        phase portrait for $arrow(r)'(t) = P arrow(r)(t)$ look _different_ from the above portraits?
        In what way(s) must it look the same?
        #solution[
          It can look different in orientation (eigendirections can rotate), stretching, and overall
          geometry under coordinate changes.

          It must still have one stable eigendirection and one unstable eigendirection, so the origin
          must remain a saddle (hence unstable).
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
            Draw invariant lines in directions $arrow(a)$ and $arrow(b)$, then add curved trajectories
            bending from the stable direction toward the unstable direction. Arrow lengths should be
            smallest near $(0,0)$ and larger farther away.
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
          (1) unstable, (2) unstable, (3) unstable, (4) stable (asymptotically stable),
          (5) unstable.
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
