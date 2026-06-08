#import "../libs/lib.typ": *
#show: e.prepare(question)

#{
  let springmass = {
    let ts = lq.linspace(1.5, 30, num: 150)
    let thickness = 1.5pt


    align(
      center,
      {
        show: lq.set-grid(stroke: none)
        lq.diagram(
          width: 5cm,
          height: 0.875cm,
          // xlim: (-2, 14),
          // ylim: (-5, 5),
          yaxis: none,
          xaxis: none,
          lq.rect(
            -1,
            -1,
            width: 1,
            height: 2,
            stroke: none,
            fill: color.rgb("#8B4513"), // brown
          ),
          lq.line(
            (0, -1),
            (0, 1),
            stroke: (paint: black, thickness: thickness),
          ),
          lq.plot(
            ts.map(t => 0.6 + 1.2 * (0.3 * t - calc.sin(t))),
            ts.map(t => 1.2 * (1 - calc.cos(t)) - 1),
            mark: none,
            stroke: (paint: black, thickness: thickness),
          ),
          lq.ellipse(
            0.6 + 1.2 * (0.3 * 30 - calc.sin(30)) - 1,
            1.2 * (1 - calc.cos(30)) - 2,
            height: 2,
            width: 2,
            fill: color.rgb("#bbbbbb"), // gray
            stroke: (paint: black, thickness: thickness),
          ),
          lq.place(0.6 + 1.2 * (0.3 * 30 - calc.sin(30)), 1.2 * (1 - calc.cos(30)) - 1)[M],
        )
      },
    )
  }


  question({
    learning_objectives(
      [???],
    )
    notes[???]
    slide(force_scale: 0.90em)[


      Consider a spring with a mass attached to the end.

      #springmass


      Let $x(t) =$ displacement to the right of the spring from equilibrium at time $t$.

      Recall from Physics the following laws:

      - (HL) Hooke's Law: For an elastic spring, force is proportional to negative the displacement
        from equilibrium.
      - (NL) Newton's Second Law: Force is proportional to acceleration (the proportionality
        constant is called mass).
      - (ML) Laws of Motion: Velocity is the time derivative of displacement and acceleration is the
        time derivative of velocity.

      // #v(1in)

      + Model $x(t)$ with a differential equation.
        #solution[
          By (HL), $F_"spring" = -k x$. By (NL) and (ML), $F = m x''$. Combining:
          $
            underbrace(m x'', "(NL)") = underbrace(-k x, "(HL)").
          $
          With $k = 1$ and $m = 1$ this gives $x'' = -x$.
        ]

        For the remaining parts, assume the elasticity of the spring is $k = 1$ and the mass is $1$.

      + Suppose the spring is stretched $0.5$m from equilibrium and then let go (at time $t = 0$).
        + At $t = 0$, what are $x$, $x'$, and $x''$?
          #solution[
            "Let go" means zero initial velocity, so $x(0) = 0.5$ and $x'(0) = 0$. Using the
            differential equation: $x''(0) = -x(0) = -0.5$.
          ]
        + Modify Euler's method to approximate a solution to the initial value problem.
          #solution[
            Since $x'' = -x$, we track both $x$ and $x'$ simultaneously. Euler's method becomes
            $
               x_(n+1) & = x_n + Delta dot x'_n, \
              x'_(n+1) & = x'_n + Delta dot x''_n = x'_n - Delta dot x_n.
            $
            Starting from $(x_0, x'_0) = (0.5, 0)$ with $Delta = 0.1$:
            #align(center, simple_table(
              headers: ($n$, $t_n$, $x_n$, $x'_n$),
              content: (
                [0],
                [0.0],
                [0.500],
                [0.000],
                [1],
                [0.1],
                [0.500],
                [-0.050],
                [2],
                [0.2],
                [0.495],
                [-0.100],
                [3],
                [0.3],
                [0.485],
                [-0.150],
              ),
            ))
          ]

      + Introduce the auxiliary equation $y = x'$. Can the second-order spring equation be rewritten
        as a first-order system involving $x'$ and $y'$? If so, do it.
        #solution[
          Yes. Since $y = x'$, we have $y' = x'' = -x$. The first-order system is
          $
            x' & = y \
            y' & = -x
          $
          or in matrix form
          $
            mat(x; y)' = mat(0, 1; -1, 0) mat(x; y).
          $
        ]

      + Simulate the _system_ you found in the previous part using Euler's method.
        #solution[
          #{
            let spring(x, y) = (y, -x)
            let sims = solve_2d_ivp(spring, (0.5, 0), 20, Delta: 0.1)
            let sim_table = range(7).map(i => (i * 0.1, sims.at(i))).flatten()
            align(center, simple_table(
              headers: ($t$, $x(t)$, $y(t) = x'(t)$),
              content: sim_table.map(v => [#calc.round(v, digits: 3)]),
            ))
          }
          Applying the Euler update $(x_(n+1), y_(n+1)) = (x_n + Delta y_n, y_n - Delta x_n)$ with
          $(x_0, y_0) = (0.5, 0)$ and $Delta = 0.1$ produces the table above. The solution
          oscillates, with $x(t)$ cycling between approximately $+0.5$ and $-0.5$.
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

      Recall a spring with a mass attached to the end.

      #springmass


      $x(t)$ = displacement to the right of the spring from equilibrium at time $t$

      We have two competing models

      #math.equation(
        block: true,
        numbering: _ => "(A)",
        $ x'' = -k x $,
      )<eq:spring>


      #math.equation(
        block: true,
        numbering: _ => "(B)",
        $ mat(x; y)' = mat(0, 1; -k, 0) mat(x; y) $,
      )<eq:spring_system>
      where $y = x'$


      + Make a phase portrait for system @eq:spring_system[]. What are the axes on the phase
        portrait? What do you expect general solutions to look like?
        #solution[
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
              title: [$k=1$ #v(.3em)],
            )
          }
          The axes are $x$ (displacement) and $y = x'$ (velocity). The matrix $mat(0, 1; -k, 0)$ has
          characteristic polynomial $lambda^2 + k = 0$, giving pure imaginary eigenvalues
          $lambda = plus.minus i sqrt(k)$. The equilibrium at the origin is a _center_, and general
          solutions are closed ellipses traversed periodically.
        ]
      + Use eigenvalues/eigenvectors to find a general solution to @eq:spring_system[]. (You may use
        a computer to compute eigenvalues/vectors.)
        #solution[
          The eigenvalues are $lambda = plus.minus i sqrt(k)$. For $lambda = i sqrt(k)$, solving
          $(M - i sqrt(k) I) arrow(v) = arrow(0)$ via the first row gives
          $-i sqrt(k) v_1 + v_2 = 0$, so $v_2 = i sqrt(k) v_1$. Taking $v_1 = 1$, the eigenvector is
          $mat(1; i sqrt(k))$.

          The corresponding eigen solution is $e^(i sqrt(k) t) mat(1; i sqrt(k))$. Expanding via
          Euler's formula $e^(i sqrt(k) t) = cos(sqrt(k) t) + i sin(sqrt(k) t)$:
          $
            e^(i sqrt(k) t) mat(1; i sqrt(k))
            = underbrace(mat(cos(sqrt(k) t); -sqrt(k) sin(sqrt(k) t)), "Re part")
            + i underbrace(mat(sin(sqrt(k) t); sqrt(k) cos(sqrt(k) t)), "Im part").
          $
          The real and imaginary parts are two linearly independent real solutions, giving the
          general solution
          $
            mat(x(t); y(t)) = A mat(cos(sqrt(k) t); -sqrt(k) sin(sqrt(k) t))
            + B mat(sin(sqrt(k) t); sqrt(k) cos(sqrt(k) t)).
          $
        ]
      + Use your solution to @eq:spring_system[] to find a general solution to @eq:spring[].
        #solution[
          The general solution to @eq:spring[] is the $x$-component of the solution to
          @eq:spring_system[]:
          $
            x(t) = A cos(sqrt(k) t) + B sin(sqrt(k) t)
          $
          where $A, B in RR$ are parameters. This is a periodic oscillation with period
          $2 pi \/ sqrt(k)$.
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

      Consider the second-order differential equation
      $ x'' = - (1 + x) dot x' + x^2 - x $

      + Rewrite the second-order differential equation as a system of first-order differential
        equations. (Hint: you may need to introduce an auxiliary equation.)
        #solution[
          Introduce $y = x'$. Then $y' = x'' = -(1+x) y + x^2 - x$. The first-order system is
          $
            x' & = y \
            y' & = -(1 + x) y + x^2 - x.
          $
        ]

      + The following Desmos link plots a phase portrait and draws an Euler approximation on the
        phase portrait:

        #link("https://www.desmos.com/calculator/fvqxqp6eds")

        Use the link to make a phase portrait for your system and answer the following questions:
        + Are there initial conditions with $x(0) < 0$ so that a solution $x(t)$ is always
          increasing?
          #solution[
            #{
              set align(center)
              vector_field(
                ((x, y) => (y, -(1 + x) * y + x * x - x)),
                xlim: (-2, 2.5),
                ylim: (-2.5, 2.5),
                spacing: (.28, .28),
                scale_segments: 6,
                width: 5cm,
                height: 5cm,
                xaxis: (position: 0, tip: tiptoe.stealth, ticks: none, subticks: none),
                yaxis: (position: 0, tip: tiptoe.stealth, ticks: none, subticks: none),
              )
            }
            From the phase portrait, trajectories near the origin with $x(0) < 0$ spiral toward the
            attracting equilibrium at $(0, 0)$. Since trajectories spiral in, $y = x'$ changes sign
            and $x$ oscillates — it is not always increasing. For initial conditions close to the
            origin, there are *no* such trajectories.
          ]
        + Are there initial conditions with $x(0) < 0$ so that a solution $x(t)$ first decreases and
          then increases?
          #solution[
            Yes. Starting with $x(0) < 0$ and $y(0) = x'(0) < 0$ (initial velocity negative), $x$
            initially decreases. As the trajectory spirals toward $(0, 0)$, it enters the upper
            half-plane ($y > 0$), after which $x$ increases. So $x(t)$ first decreases and then
            increases before oscillating toward $0$.
          ]

      + Show that $x(t) = 0$ is an equilibrium solution for this equation.
        #solution[
          If $x(t) = 0$ for all $t$, then $x'(t) = 0$ and $x''(t) = 0$. Substituting into the
          equation:
          $
            x'' = -(1 + 0)(0) + 0^2 - 0 = 0 = x''.
          $
          The equation is satisfied, so $x(t) = 0$ is an equilibrium solution.
        ]

      + Use linearization and eigenvalues to classify the equilibrium $(x, x') = (0, 0)$ in phase
        space.
        #solution[
          With $arrow(F)(x, y) = (y, -(1+x)y + x^2 - x)$, the total derivative is
          $
            D_(arrow(F))(x, y) = mat(0, 1; -y + 2x - 1, -(1 + x)).
          $
          At $(0, 0)$: $D_(arrow(F))(0, 0) = mat(0, 1; -1, -1)$, and $arrow(F)(0,0) = mat(0; 0)$.

          The characteristic polynomial is
          $
            det(mat(0, 1; -1, -1) - lambda I) = (-lambda)(-1-lambda) + 1 = lambda^2 + lambda + 1 = 0,
          $
          giving eigenvalues $lambda = -1\/2 plus.minus i sqrt(3)\/2$.

          The real part is $-1\/2 < 0$, so the linearized equilibrium is *stable and attracting*. By
          the Classification via Linearization theorem, the original equilibrium $(x, x') = (0, 0)$
          is also *attracting*.
        ]

      + Let $x(t)$ be a solution to the original equation and suppose $x(0) = delta_1 approx 0$.
        + If $x'(0) = delta_2 approx 0$, speculate on the long term behaviour of $x(t)$.
          #solution[
            The initial state $(x(0), x'(0)) = (delta_1, delta_2)$ is close to the attracting
            equilibrium $(0, 0)$ in phase space. Since the equilibrium is attracting, nearby
            trajectories converge to it, so $x(t) arrow 0$ as $t arrow +infinity$.
          ]
        + If we put no conditions on $x'(0)$ will your answer be the same? Explain.
          #solution[
            Not necessarily. If $x'(0)$ is large, the initial phase-space point $(delta_1, x'(0))$
            may be far from $(0, 0)$, potentially outside its basin of attraction. In that case the
            trajectory need not converge to $0$, and could exhibit different long-term behaviour
            (oscillations of larger amplitude, or divergence). The convergence to $0$ is only
            guaranteed when *both* $x(0)$ and $x'(0)$ are small.
          ]

    ]
  })
}
