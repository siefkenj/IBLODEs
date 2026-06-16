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
      [Create a model using a second-order differential equation based on premises.],
      [Modify Euler's method to approximate solutions to second-order equations.],
      [Rewrite a second-order equation as a first-order system.],
    )
    notes[
      Welcome to higher-order equations, everyone!

      Our approach is to convert higher-order equations to first-order systems. However, before we
      do that we'll get our hands dirty extending Euler's method to second-order equations.

      - Some students may be turned off by modelling with "laws" from physics. Remind them that
        these laws are just premises by a different name.

      - In @ex:spring_modified_eulers[], students extend Euler's method. This technique is
        superseded by that in @ex:spring_simulate_with_system[], but it is still good practice to
        think about modifying algorithms.

      - In @ex:spring_modified_eulers[], some students coming from physics may have a clever idea of
        using the recursion:
        $
           x_(n+1) & = x_n + Delta dot x'_n, \
          x'_(n+1) & = x'_n - Delta dot #[*$x_(n+1)$*]
        $
        This works if you compute $x_(n+1)$ before $x'_(n+1)$, and this method is more numerically
        stable than the naive extension of Euler's method. _However_, we want to focus on the naive
        extension, because that will give the same output as passing to a first-order system and
        using Euler's method.

      - If students are concurrently enrolled in physics, the may have just finished their unit on
        oscillators. These students will be very comfortable with the modelling.

      - A nice wrap-up is to show two spreadsheets side-by-side, one implementing the modified
        Euler's method and the other implementing the system approach. Side-by-side it is clear that
        the resulting numbers are identical. The only difference is that the system approach has an
        extra column.

        The "big picture" conclusion is that we don't need to learn more methods. We can use the
        system approach for higher-order equations!
    ]
    slide(force_scale: 0.90em)[


      Consider a spring with a mass attached to the end.

      #springmass


      Let $x(t) =$ displacement (to the right) from equilibrium of the mass at time $t$.

      Recall from Physics the following laws:

      #aligned_terms(
        terms.item([(HL)], [Hooke's Law: For an elastic spring, force is proportional to negative
          the displacement from equilibrium.]),
        terms.item([(NL)], [Newton's Second Law: Force is proportional to acceleration (the
          proportionality constant is called mass).]),
        terms.item([(ML)], [Laws of Motion: Velocity is the time derivative of displacement and
          acceleration is the time derivative of velocity.]),
      )

      // #v(1in)

      + Model $x(t)$ with a differential equation.
        #solution[
          Define $F$ as the force acting on the mass. By (HL) we have $F = -k x$. By (NL) and (ML),
          we must also have $F = m x''$. Combining:
          $
            underbrace(m x'', "(ML)") quad underbrace(=, "(NL)") quad underbrace(-k x, "(HL)").
          $
          // With $k = 1$ and $m = 1$ this gives $x'' = -x$.
        ]

        For the remaining parts, assume the elasticity of the spring is $k = 1$ and the mass is $1$.

      + Suppose the spring is stretched $0.5$m from equilibrium and then let go (at time $t = 0$).
        + At $t = 0$, what are $x$, $x'$, and $x''$?
          #solution[
            "Let go" means the initial velocity is zero, so $x(0) = 0.5$ and $x'(0) = 0$. With $k=1$
            and $m=1$ the differential equation becomes $x'' = -x$ and so we have the additional
            condition $x''(0) = -x(0) = -0.5$.
          ]
        + #label_question_part(<ex:spring_modified_eulers>) Modify Euler's method to approximate a
          solution to the initial value problem.
          #solution[
            Since $x'' = -x$, we track both $x$ and $x'$ simultaneously. Euler's method becomes
            $
               x_(n+1) & = x_n + Delta dot x'_n, \
              x'_(n+1) & = x'_n + Delta dot x''_n = x'_n - Delta dot x_n.
            $
            Starting from $(x_0, x'_0) = (0.5, 0)$ with $Delta = 0.1$:
            #{
              let spring(x, xp) = (xp, -x)
              let sims = solve_2d_ivp(spring, (0.5, 0), 3, Delta: 0.1)
              let sim_table = range(4)
                .map(i => (calc.round(i * 0.1, digits: 3), sims.at(i)))
                .flatten()
              align(center, simple_table(
                headers: ($t_n$, $x_n$, $x'_n$),
                content: sim_table.map(v => [#calc.round(v, digits: 3)]),
              ))
            }
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

      + #label_question_part(<ex:spring_simulate_with_system>) Simulate the _system_ you found in
        the previous part using Euler's method.
        #solution[
          Using $Delta = 0.1$ and starting from $(x(0), y(0)) = (0.5, 0)$ we get the following table
          of approximations.
          #{
            let spring(x, y) = (y, -x)
            let sims = solve_2d_ivp(spring, (0.5, 0), 20, Delta: 0.1)
            let sim_table = range(7).map(i => (i * 0.1, sims.at(i))).flatten()
            align(center, simple_table(
              headers: ($t_n$, $x_n$, $y_n$),
              content: sim_table.map(v => [#calc.round(v, digits: 3)]),
            ))
          }
        ]


    ]
  })

  book_only(pagebreak())
  question({
    learning_objectives(
      [Interpret the phase portrait of the system of differential equations arising from a
        second-order equation.],
      [Solve a second-order equation by converting to a first-order system and using
        eigenvalues/eigenvectors.],
    )
    notes[
      Our goal is to figure out how our systems-of-ODEs tools apply to higher order ODEs.

      When we convert a higher-order equation to a system, one row of the system is "redundant". The
      main hurdle in using this method is blocking out the redundant information to get at
      information about the original (higher-order) equation.

      - In @ex:spring2_phase_portrait[], the phase portrait is the first point of confusion. One of
        the axes is about $x'$, not an independent variable.

      - For @ex:spring2_solve_system[], encourage students to use a computer to find
        eigenvalues/eigenvectors. If they use WolframAlpha, they will get eigenvectors of
        $
          mat(minus.plus i/sqrt(k); 1)
        $
        which aren't fun to do computations with.

        If students are struggling discuss with them what parts of their answer will be needed for
        @ex:spring2_final_solution[]. As a class, conclude you only need to find the
        first-coordinate of a general solution.

      - In @ex:spring2_solve_system[], go with the vectors the students choose in your discussion.
        However, if the vectors are normalized so that the first coordinate is $1$, the computations
        are easier.

      - As a wrap-up, relate the solution from @ex:spring2_final_solution[] to the phase portrait
        from @ex:spring2_phase_portrait[].

        @ex:higher_order_to_system_details will explore in more detail how to interpret phase
        portraits arising from higher-order equations.
    ]
    slide(force_scale: 0.95em)[

      Recall a spring with a mass attached to the end.

      #springmass


      $x(t) =$ displacement (to the right) from equilibrium of the mass at time $t$.


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
      where $y = x'$.


      + #label_question_part(<ex:spring2_phase_portrait>) Make a phase portrait for system
        @eq:spring_system[]. What are the axes on the phase portrait? What do you expect general
        solutions to look like?
        #solution[
          #{
            set align(center)
            vector_field(
              ((x, y) => (y, -x)),
              xlim: (-1.5, 1.5),
              ylim: (-1.5, 1.5),
              spacing: (.22, .22),
              scale_segments: 15,
              width: 5cm,
              height: 5cm,
              xaxis: (position: 0, tip: tiptoe.stealth, tick-distance: 1),
              yaxis: (position: 0, tip: tiptoe.stealth, tick-distance: 1),
              title: [$k=1$ #v(.3em)],
            )
          }
          The axes are $x$ (displacement) and $y = x'$ (velocity). Based on the phase portrait,
          solutions to the system should be periodic (graphed as circles in phase space).
        ]
      + #label_question_part(<ex:spring2_solve_system>) Use eigenvalues/eigenvectors to find a
        general solution to @eq:spring_system[]. (You may use a computer to compute
        eigenvalues/vectors.)
        #solution[
          The eigenvalues are $lambda = plus.minus i sqrt(k)$ and the corresponding eigenvectors are
          $mat(1; plus.minus i sqrt(k))$.

          This gives general (complex) solutions of the form
          $
            arrow(s)(t) = A e^(i sqrt(k) thin t) mat(1; i sqrt(k)) + B e^(-i sqrt(k) thin t) mat(1; -i sqrt(k))
          $
          where $A$ and $B$ are (complex) parameters.

          To find real solutions, we can pick $A=B=1/2$ and $A=-B=i/2$ as constants to find two
          linearly independent real solutions:
          $
            arrow(r)_1 (t) = mat(cos(sqrt(k) t); -sqrt(k) sin(sqrt(k) t)) wide "and" wide
            arrow(r)_2 (t) = mat(sin(sqrt(k) t); sqrt(k) cos(sqrt(k) t)).
          $

          Thus, we have a general real solution
          $
            arrow(r)(t) = C_1 arrow(r)_1 (t) + C_2 arrow(r)_2 (t)
          $
          where $C_1$ and $C_2$ are _real_ parameters.
        ]
      + #label_question_part(<ex:spring2_final_solution>) Use your solution to @eq:spring_system[]
        to find a general solution to @eq:spring[].
        #solution[
          The general solution to @eq:spring[] is the $x$-coordinate of the solution to
          @eq:spring_system[]:
          $
            x(t) = C_1 cos(sqrt(k) t) + C_2 sin(sqrt(k) t)
          $
          where $C_1, C_2 in RR$ are parameters.

          Note: since we only needed the $x$-coordinate of the solution to @eq:spring_system[], we
          only need to find the first coordinate in our calculations for @ex:spring2_solve_system[].
        ]

    ]
  })

  book_only(pagebreak())
  question(label: <ex:higher_order_to_system_details>, {
    learning_objectives(
      [Interpret the phase portrait of the system of differential equations arising from a
        second-order equation.],
      [Apply classification tools for a system of differential equations to analyze non-linear
        higher-order equations.],
    )
    notes[
      This is the culminating exercise for higher-order equations. We apply all the classification
      tools we have developed for systems (save re-centering about an equilibrium).

      A big part of this question is translating what we learn from a system to what it tells us
      about the original higher-order equation.

      - In @ex:higher_order_to_system_details2[], students are given a Desmos link with built-in
        Euler simulation. They've earned it by this point! And, built-in Euler simulations should
        help them explore faster.

        Announce to the students that they should use the provided Desmos link and not Desmos links
        from previous exercises.

      - Students will find @ex:higher_order_to_system_details2[] challenging. Trajectories in _phase
        space_ that are decreasing (i.e., $y$-coordinate going down) may correspond to increasing
        solutions to the original higher-order equation!

        This part was constructed on purpose to help student sort out the difference between
        trajectories in phase space and the behaviour of solutions to the original higher-order
        equation.

        During discussion, make sure that the meaning of the $y$-axis comes up: if trajectories are
        in the upper half-plane, then $x' > 0$ and so $x(t)$ is increasing, etc.. This argument can
        be used to rigorously show that the solutions with initial values found in
        @ex:higher_order_to_system_details2[] have the desired behaviour.

      - In @ex:higher_order_to_system_details3[], students are asked about an equilibrium solution
        to a higher-order equation for the first time. The definition is the same (a solution that
        is constant), but students may have forgotten the definition. They may need a hint that
        since a constant function has been proposed, all they need to do is verify it is a solution.

      - In @ex:higher_order_to_system_details3[], students may be confused about how to find
        $x'(t)$. (They have forgotten they can just differentiate the expression given to them for
        $x(t)$.)
    ]
    slide[

      Consider the second-order differential equation
      $ x'' = - (1 + x) dot x' + x^2 - x $

      + Rewrite the second-order differential equation as a system of first-order differential
        equations. (Hint: you may need to introduce an auxiliary equation.)
        #solution[
          Introduce $y = x'$. Then $y' = x'' = -(1+x) y + x^2 - x$, giving the system
          $
            x' & = y \
            y' & = -(1 + x) y + x^2 - x.
          $
        ]

      + #label_question_part(<ex:higher_order_to_system_details2>) The following Desmos link plots a
        phase portrait and draws an Euler approximation on the phase portrait:

        #link("https://www.desmos.com/calculator/fvqxqp6eds")

        Use the link to make a phase portrait for your system and answer the following questions:
        + #label_question_part(<ex:higher_order_to_system_details2a>) Are there initial conditions
          with $x(0) < 0$ so that a solution $x(t)$ is always increasing?
          #solution[
            #{
              set align(center)
              vector_field(
                ((x, y) => (y, -(1 + x) * y + x * x - x)),
                xlim: (-7.5, 7.5),
                ylim: (-10.5, 10.5),
                spacing: (.75, .95),
                scale_segments: 8,
                width: 5cm,
                height: 5cm,
                xaxis: (position: 0, tip: tiptoe.stealth, ticks: none, subticks: none),
                yaxis: (position: 0, tip: tiptoe.stealth, ticks: none, subticks: none),
              )
            }
            We are looking for trajectories in the phase portrait that satisfy two properties:
            - $x(0) < 0$ $->$ the trajectory starts in the left half-plane.
            - $x(t)$ is always increasing $->$ $x'> 0$ for all time. Since the vertical axis of the
              phase portrait is $y = x'$, this means that the trajectory must stay in the upper
              half-plane.
            We can see from the phase portrait that there are such trajectories.
          ]
        + #label_question_part(<ex:higher_order_to_system_details2b>) Are there initial conditions
          with $x(0) < 0$ so that a solution $x(t)$ first decreases and then increases?
          #solution[
            With reasoning similar to @ex:higher_order_to_system_details2a[], we are looking for
            trajectories that start in the left half-plane ($x(0) < 0$) and in the bottom half-plane
            ($x'(0) < 0$), but eventually enter the upper half-plane ($x' > 0$).

            We can see that there is such a trajectory (starting in the 3rd quadrant then passing to
            the 2nd).
          ]

      + #label_question_part(<ex:higher_order_to_system_details3>) Show that $x(t) = 0$ is an
        equilibrium solution for this equation.
        #solution[
          If $x(t) = 0$ for all $t$, then $x'(t) = 0$ and $x''(t) = 0$. Substituting into the
          equation:
          $
            x'' = -(1 + 0)(0) + 0^2 - 0 = 0 = x''.
          $
          The equation is satisfied, so $x(t) = 0$ is an equilibrium solution.
        ]

      + #label_question_part(<ex:higher_order_to_system_details4>) Use linearization and eigenvalues
        to classify the equilibrium $(x, x') = (0, 0)$ in phase space.
        #solution[
          With $arrow(F)(x, y) = mat(y; -(1+x)y + x^2 - x)$, the total derivative at $(0,0)$ is
          $
            D_(arrow(F))(0, 0) = mat(0, 1; -1, -1),
          $
          and so our linearized system is
          $mat(x_"approx"; y_"approx")' = mat(0, 1; -1, -1) mat(x_"approx"; y_"approx")$.

          The eigenvalues of $mat(0, 1; -1, -1)$ are $lambda = -1/2 plus.minus i sqrt(3)/2$. The
          real part of the eigenvalues is $-1/2 < 0$, so the linearized equilibrium is *stable* and
          *attracting*. By the Classification via Linearization theorem, the equilibrium
          $(x, x') = (0, 0)$ is also *stable* and *attracting*.
        ]

        #notes[
          - In @ex:higher_order_to_system_details5[], the meaning of attracting/repelling/etc. for
            equilibrium solutions to higher-order equations is more difficult to interpret. To be
            "attracted" to an equilibrium solution for a higher-order system, one needs all their
            initial conditions to be close to those of the equilibrium solution. In particular, this
            means $x'(0) approx 0$.

            This part is designed to have students confront the fact that for a higher-order
            equation, $x(0) approx x_"equilibrium" (0)$ does not provide you enough information to
            predict the behaviour of $x(t)$.

        ]
      + #label_question_part(<ex:higher_order_to_system_details5>) Let $x(t)$ be a solution to the
        original equation and suppose $x(0) = delta_1 approx 0$.
        + If $x'(0) = delta_2 approx 0$, speculate on the long term behaviour of $x(t)$.
          #solution[
            The initial state $(x(0), x'(0)) = (delta_1, delta_2)$ is close to the attracting
            equilibrium $(0, 0)$ in phase space. Since the equilibrium is attracting, nearby
            trajectories converge to it, so $x(t) arrow 0$ as $t arrow +infinity$.
          ]
        + If we put no conditions on $x'(0)$ will your answer be the same? Explain.
          #solution[
            No. If $x'(0)$ is large (negative or positive), trajectories head away from the origin
            (in phase space) with the $x$-coordinate becoming unbounded. That means solutions with
            initial conditions $x(0)approx 0$ and $x'(0) = "anything"$ could head towards $0$ or
            towards $plus.minus infinity$.
          ]

    ]
  })
}
