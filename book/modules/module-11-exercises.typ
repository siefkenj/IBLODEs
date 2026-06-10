#import "../libs/lib.typ": *
#show: e.prepare(question)

#{
  lesson(title: [Boundary Value Problems], include "lesson-week-11.typ")
  question({
    learning_objectives(
      [???],
    )
    notes[???]
    slide[

      #slides_only([*Boundary Value Problems*])

      Recall the spring-mass system modeled by
      $ x'' = -x $

      We would like to use the spring-mass system to ring a bell at regular intervals, so we put a
      hammer at the end of the spring. Whenever the displacement is maximal, the hammer strikes a
      bell producing a ring.

      + Convert the spring-mass system into a system of differential equations. Make a phase
        portrait for the system using the following Desmos link:

        #link("https://www.desmos.com/calculator/fvqxqp6eds")

        #solution[
          Introducing $y = x'$, the system is
          $
            x' & = y \
            y' & = -x,
          $
          i.e., $mat(x; y)' = mat(0, 1; -1, 0) mat(x; y)$.
          #{
            set align(center)
            vector_field(
              ((x, y) => (y, -x)),
              xlim: (-1.5, 1.5),
              ylim: (-1.5, 1.5),
              spacing: (.22, .22),
              scale_segments: 8,
              width: 5cm,
              height: 5cm,
              xaxis: (position: 0, tip: tiptoe.stealth, tick-distance: 1),
              yaxis: (position: 0, tip: tiptoe.stealth, tick-distance: 1),
            )
          }
          The matrix $mat(0, 1; -1, 0)$ has characteristic polynomial $lambda^2 + 1 = 0$, so
          eigenvalues $lambda = plus.minus i$ (pure imaginary). The phase portrait shows closed
          circles centred at the origin: all solutions are periodic.
        ]
      + In the _Options Euler_ on Desmos, adjust $Delta$ and the number of steps so that simulated
        solutions are only shown for $t in [0, 1]$.

        Use simulations to answer the remaining questions.

        #solution[
          Choose $Delta$ and the number of steps so that $"steps" times Delta = 1$. For example,
          $Delta = 0.1$ with $10$ steps, or $Delta = 0.01$ with $100$ steps.
        ]
      + You start by displacing the hammer by $1$m and letting go. Is it possible that the bell
        rings every 1 second?
        #solution[
          Letting go means $x(0) = 1$ and $x'(0) = 0$. The simulation traces the unit circle in
          phase space, returning to the maximum $x = 1$ (i.e., $(x, y) = (1, 0)$) after one full
          revolution, which takes time $2 pi approx 6.28$ seconds. The bell cannot ring every $1$
          second.
        ]

      + You start by displacing the hammer by $1$m and giving the hammer a push. Is it possible that
        the bell rings every 1 second?
        #solution[
          A push means $x'(0) = v_0 != 0$, so the initial state $(1, v_0)$ lies on a circle of
          radius $sqrt(1 + v_0^2) > 1$. The simulation shows a larger circle traversed at the same
          angular speed — one full revolution still takes exactly $2 pi approx 6.28$ seconds. The
          bell still cannot ring every $1$ second.
        ]

      + What is the smallest amount of time between consecutive rings (given a positive
        displacement)?
        #solution[
          From the phase portrait, all trajectories are circles traversed with angular speed $1$
          rad/s, so every trajectory has period exactly $2 pi$. The smallest possible time between
          consecutive rings is $2 pi approx 6.28$ seconds.
        ]

    ]
  })

  book_only(pagebreak())
  question({
    learning_objectives(
      [???],
    )
    notes[???]
    slide(force_scale: 0.95em)[

      #slides_only([*Boundary Value Problems*])

      Recall the spring-mass system modeled by
      $ x'' = -x $
      We would like to use the spring-mass system to ring a bell at regular intervals, so we put a
      hammer at the end of the spring. Whenever the displacement is maximal, the hammer strikes a
      bell producing a ring.

      The general solution to the spring-mass system can also be written as
      $
        x(t) = A cos(t + d)
      $
      where $A,d in RR$ are parameters.

      Analytically answer the remaining questions.
      + You start by displacing the hammer by $1$m and letting go. Is it possible that the bell
        rings every 1 second?
        #solution[
          Letting go means $x(0) = 1$ and $x'(0) = 0$.
          $
             x(0) & = A cos(d) = 1, \
            x'(0) & = -A sin(d) = 0.
          $
          From the second equation $sin(d) = 0$, so $d = 0$ (taking $A > 0$), giving
          $x(t) = cos(t)$. The maxima of $cos(t)$ occur at $t = 0, 2pi, 4pi, dots$, spaced
          $2pi approx 6.28$ apart. It is *not possible* for the bell to ring every $1$ second.
        ]
      + You start by displacing the hammer by $1$m and giving the hammer a push. Is it possible that
        the bell rings every 1 second?
        #solution[
          A push means $x'(0) = v_0 != 0$. From
          $
            A cos(d) = 1, quad -A sin(d) = v_0,
          $
          we get $A = sqrt(1 + v_0^2)$. The maxima of $A cos(t + d)$ occur when $cos(t + d) = 1$,
          i.e., at $t = -d, -d + 2pi, -d + 4pi, dots$, spaced $2pi$ apart. The period is *always
          $2pi$*, regardless of $v_0$. The bell cannot ring every $1$ second.
        ]
      + What is the smallest amount of time between consecutive rings (given a positive
        displacement)?
        #solution[
          For any $A > 0$ and any $d$, the function $x(t) = A cos(t + d)$ has period $2pi$.
          Consecutive maxima are always separated by exactly $2pi$. The smallest time between
          consecutive rings is $2 pi$.
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

      #slides_only([*Boundary Value Problems*])


      A boundary value problem is a differential equation paired with two conditions at different
      values of $t$.

      Consider the following boundary value problems:

      #align(
        center,
        table(
          columns: 3,
          align: (center, center, center),
          stroke: none,
          column-gutter: 1em,
          table.header([(i)], [(ii)], [(iii)]),
          // Equations
          $x'' = -x$, $x'' = -x$, $x'' = -x$,
          // Boundary condition at left endpoint
          $x(0) = 1$, $x(0) = 1$, $x(0) = 1$,
          // Boundary condition at right endpoint
          $x(pi) = 1$, $x(pi) = -1$, $x(pi / 2) = 0$,
        ),
      )



      + Using phase portraits and simulations, determine how many solutions each boundary value
        problem has.
        #solution[
          Using the shooting method: start from $x(0) = 1$ (i.e., $y(0) = x'(0)$ is the free
          parameter) and simulate until $t = pi$ or $t = pi\/2$, checking the endpoint value.

          For any initial velocity $y_0 = x'(0)$, the general solution is
          $x(t) = cos(t) + y_0 sin(t)$, so:
          - At $t = pi$: $x(pi) = cos(pi) + y_0 sin(pi) = -1$, regardless of $y_0$.
          - At $t = pi\/2$: $x(pi\/2) = cos(pi\/2) + y_0 sin(pi\/2) = y_0$.

          From the simulation, no choice of $y_0$ moves $x(pi)$ away from $-1$. And $x(pi\/2) = y_0$
          hits any target exactly once.

          - (i) $x(pi) = 1$: No solution (simulation always returns $-1$).
          - (ii) $x(pi) = -1$: Infinitely many solutions (every $y_0$ works).
          - (iii) $x(pi\/2) = 0$: Exactly one solution ($y_0 = 0$).
        ]
      + Can you find analytic arguments to justify your conclusions?

        _Hint_: The general solution can be written as
        $
          x(t)=A cos t + B sin t " or " x(t) = A cos(t + d)
        $
        where $A,B,d$ are parameters. Use whichever form makes the question easier.
        #solution[
          Using $x(t) = A cos t + B sin t$. The condition $x(0) = 1$ gives $A = 1$, so
          $x(t) = cos t + B sin t$ for any $B$.

          - *(i)* $x(pi) = cos(pi) + B sin(pi) = -1 + 0 = -1 != 1$ for all $B$. *No solution.*
          - *(ii)* $x(pi) = -1 = -1$ ✓ for every $B in RR$. Every $x(t) = cos t + B sin t$ is a
            solution. *Infinitely many solutions.*
          - *(iii)* $x(pi\/2) = cos(pi\/2) + B sin(pi\/2) = 0 + B = B = 0$. So $B = 0$ is forced,
            giving the unique solution $x(t) = cos t$. *Exactly one solution.*
        ]

    ]
  })
}
