#import "../libs/lib.typ": *
#show: e.prepare(question)

#let SS = $upright(bold("S"))$
// Catenary Problem
#{
  let catenary = {
    let xs = lq.linspace(-1, 1.5, num: 25)
    let thickness = 1.5pt


    align(
      center,
      {
        show: lq.set-grid(stroke: none)
        lq.diagram(
          //width: 5cm,
          //height: 0.875cm,
          // xlim: (-2, 14),
          // ylim: (-5, 5),
          yaxis: none,
          xaxis: none,
          // Green Ground
          lq.rect(
            -1.5,
            -0.1,
            width: 3.5,
            height: 0.1,
            stroke: none,
            fill: color.rgb("#358b13"),
          ),
          lq.line(
            (-1.5, 0),
            (2, 0),
            stroke: (paint: black, thickness: thickness),
          ),
          // Poles at the ends
          lq.line(
            (-1, 0),
            (-1, calc.cosh(-1)),
            stroke: (paint: black, thickness: thickness),
          ),
          lq.line(
            (1.5, 0),
            (1.5, calc.cosh(1.5)),
            stroke: (paint: black, thickness: thickness),
          ),
          // Catenary curve
          lq.plot(
            xs,
            xs.map(x => calc.cosh(x)),
            mark: none,
            stroke: (paint: blue, thickness: 1.5 * thickness),
          ),
          // Straight rod S
          lq.line(
            (0, 0),
            (0, 1),
            stroke: (paint: gray, thickness: 0.5 * thickness, dash: "dashed"),
          ),
          lq.line(
            (0.5, 0),
            (0.5, calc.cosh(0.5)),
            stroke: (paint: gray, thickness: 0.5 * thickness, dash: "dashed"),
          ),
          lq.line(
            (0, 1),
            (0.5, calc.cosh(0.5)),
            stroke: (paint: purple.lighten(50%), thickness: 1.5 * thickness),
          ),
          lq.place(0, -0.25)[#text(fill: gray, $x$)],
          lq.place(0.5, -0.25)[#text(fill: gray, $x + Delta$)],
          // Gravitational Force
          lq.path(
            (0.25, 0.9),
            (0.25, 0.5),
            stroke: (paint: black),
            tip: tiptoe.stealth,
          ),
          lq.place(0.25, 0.3)[$arrow(F)_g$],
          // Tension Forces
          lq.path(
            (0.5, calc.cosh(0.5)),
            (1, 2 * calc.cosh(0.5) - 1 + 0.15),
            stroke: (paint: black),
            tip: tiptoe.stealth,
          ),
          lq.place(0.7, 1.55)[$arrow(T)_R$],
          lq.path(
            (0, 1),
            (-0.5, 2 - calc.cosh(0.5) + 0.15),
            stroke: (paint: black),
            tip: tiptoe.stealth,
          ),
          lq.place(-0.25, 1.25)[$arrow(T)_L$],
        )
      },
    )
  }


  let catenary_simple = {
    let xs = lq.linspace(-1.5, 1.5, num: 30)
    let thickness = 1.5pt


    align(
      center,
      {
        show: lq.set-grid(stroke: none)
        lq.diagram(
          width: 5cm,
          height: 3cm,
          // xlim: (-2, 14),
          // ylim: (-5, 5),
          yaxis: none,
          xaxis: none,
          // Green Ground
          lq.rect(
            -1.75,
            -0.1,
            width: 3.5,
            height: 0.1,
            stroke: none,
            fill: color.rgb("#358b13"),
          ),
          lq.line(
            (-1.75, 0),
            (1.75, 0),
            stroke: (paint: black, thickness: thickness),
          ),
          // Poles at the ends
          lq.line(
            (-1.5, 0),
            (-1.5, calc.cosh(-1.5)),
            stroke: (paint: black, thickness: thickness),
          ),
          lq.line(
            (1.5, 0),
            (1.5, calc.cosh(1.5)),
            stroke: (paint: black, thickness: thickness),
          ),
          // Catenary curve
          lq.plot(
            xs,
            xs.map(x => calc.cosh(x)),
            mark: none,
            stroke: (paint: blue, thickness: 1.5 * thickness),
          ),
        )
      },
    )
  }

  lesson(title: [Famous ODEs], include "lesson-week-12.typ", label: <lesson:12>)
  question(label: <ex:catenary1>, {
    learning_objectives(
      ([Model a catenary (a hanging chain) using a second-order differential equation.],),
    )
    notes[
      @ex:catenary1[Core Exercises] and @ex:catenary2[] derive the model for a hanging chain while
      @ex:catenary3 explores the consequences of this model by answering real-world questions (using
      boundary value problems).

      - In @ex:catenary1_S[], the exact formula is complex. We will simplify it by approximating
        with derivatives in @ex:catenary2.

      - In @ex:catenary1_tension_vec[], students will be uncomfortable finding the direction of the
        vector while ignoring its length. You can let the students know that the length of this
        vector will be addressed in @ex:catenary2.
    ]
    slide(force_scale: 0.87em)[

      Consider a rope hanging from two poles.

      #catenary


      $H(x) =$ height of the rope above ground at position $x$.

      We will consider the following premises and physics laws:
      - ($P_"D"$) The linear density of the rope is constant: $rho$ kg/m
      - ($P_"G"$) Gravity pulls downwards in proportion to mass (the proportionality constant is
        called $g$)
      - ($P_"T"$) Tension pulls tangentially to the rope
      // - (S) The rope is not moving (it is stationary)
      - ($P_"NL"$) Newton's First Law: a body at rest will remain at rest unless it is acted upon by
        a force
      // - (NL) Newton's Second Law: Force is proportional to acceleration (the proportionality constant is called mass).
      // - (ML) Laws of Motion: Velocity is the time derivative of displacement and acceleration is the time derivative of velocity.

      To model the rope, imagine it is made of *small rigid rods*. We will focus on one such rod,
      $S$, (drawn in the figure) from $x$ to $x + Delta$.

      + Given ($P_"NL"$), find a relation between the force vectors $arrow(T)_L$, $arrow(T)_R$,
        $arrow(F)_g$.
        #solution[
          Since the rod is at rest, ($P_"NL"$) requires the net force to be zero:
          $
            arrow(T)_L + arrow(T)_R + arrow(F)_g = arrow(0).
          $
        ]
      + #label_question_part(<ex:catenary1_S>) Find the (exact) length of the segment #SS and its
        mass. Find the vector $arrow(F)_g$.
        #solution[
          The segment goes from $(x, H(x))$ to $(x + Delta, H(x + Delta))$, so its exact length is
          $
            SS = sqrt(Delta^2 + (H(x + Delta) - H(x))^2).
          $
          By ($P_"D"$), we have a mass of $rho SS$, and so by ($P_"G"$), the gravitational force is
          $
            arrow(F)_g approx mat(0; -rho g sqrt(Delta^2 + (H(x + Delta) - H(x))^2)).
          $
        ]
      + #label_question_part(<ex:catenary1_tension_vec>) Find a vector $arrow(V)_L$ in the direction
        of $arrow(T)_L$ (the magnitude doesn't matter at this point).
        #solution[
          By ($P_"T"$), tension acts tangentially to the rope. At position $x$, the tangent
          direction is $(1, H'(x))$. Since $arrow(T)_L$ pulls the segment to the left, we have
          $
            arrow(V)_L = mat(-1; -H'(x)).
          $
        ]

    ]
  })


  book_only(pagebreak())
  question(label: <ex:catenary2>, {
    learning_objectives(
      ([Model a catenary (a hanging chain) using a second-order differential equation.],),
    )
    notes[It's time to find a differential equation. From @ex:catenary1, we have a model that
      depends on the value of $H$ at $x$ and $x+Delta$, but the differential equations we're used to
      solving depend on the value a function and its derivatives at a single point.

      The goal of this question is to get rid of any $H(x + Delta)$ or $H'(x + Delta)$ terms.
      Explain this to the students before starting.

      - Parts @ex:catenary2_combine[] is more involved. After giving students some time to think,
        you may choose to walk through the solution on the board.
      - In @ex:catenary2_alpha_beta[], students will identify that $alpha = beta$, but completing
        the argument is hard. They also may not have recognized that we might have accidentally
        constructed a differential equation with a hidden function $alpha(x)$.

        After giving students time to speculate, walk them through an argument that $alpha$ and
        $beta$ are constant (there are many arguments; the solution gives one example).
    ]
    slide(force_scale: 0.75em)[

      Consider a rope hanging from two poles.

      #catenary

      The only forces acting on the rope are gravity and tension.

      Similarly to the previous exercise, we can find a vector $arrow(V)_R = mat(1; H'(x + Delta))$
      in the direction of $arrow(T)_R$, but with possibly different magnitude.

      So far we have:
      - $arrow(T)_L = alpha arrow(V)_L$ for some $alpha > 0$, and
      - $arrow(T)_R = beta arrow(V)_R$ for some $beta > 0$.

      + Can you find approximations of the vectors $arrow(F)_g$, $arrow(T)_L$, $arrow(T)_R$ that
        only use $H(x)$, $H'(x)$, and $H''(x)$?

        Hint:
        - $H(x + Delta) approx H(x) + Delta dot H'(x)$,
        - $H'(x + Delta) approx H'(x) + Delta dot H''(x)$.

        #solution[
          Using our previous results, we have
          $
            arrow(F)_g & approx mat(0; -rho g Delta sqrt(1 + (H'(x))^2)) \
            arrow(T)_L & = alpha mat(-1; -H'(x)) \
            arrow(T)_R & approx beta mat(1; H'(x) + Delta H''(x))
          $
          with $arrow(T)_R$ following because $H'(x + Delta) approx H'(x) + Delta H''(x)$.
        ]
      + #label_question_part(<ex:catenary2_combine>) Put everything together to find a (second
        order) differential equation for $H$.
        #solution[
          Substituting into $arrow(T)_L + arrow(T)_R + arrow(F)_g = arrow(0)$, we get
          $
            mat(-alpha + beta; -alpha H'(x) + beta(H'(x) + Delta H''(x)) - rho g Delta sqrt(1 + (H'(x))^2)) = mat(0; 0),
          $
          and so $alpha = beta$. Solving for $H''(x)$ in the second coordinate gives
          $
            H''(x) = frac(rho g, alpha) sqrt(1 + (H'(x))^2).
          $
          To get this expression we divided by both $Delta$ and $alpha$. Since neither can be zero,
          the arithmetic is valid.
        ]

      + #label_question_part(<ex:catenary2_alpha_beta>) Do $alpha$ or $beta$ depend on $x$? Explain.
        #solution[
          Suppose the rope is divided into $n$ segments $SS_1, ..., SS_n$ with $alpha_1=beta_1$,
          ..., $alpha_n=beta_n$ as derived above. Since the rope is stationary, the tension on the
          right end of segment $SS_i$ must be equal and opposite to the tension pulling on the left
          end of segment $SS_(i+1)$. This means that $beta_i=alpha_(i+1)$, and so
          $alpha_i=beta_i=alpha_(i+1)$.

          By induction, all $alpha_i$ (and $beta_i$) are equal, and so $alpha$ and $beta$ do not
          depend on $x$.
        ]


    ]
  })


  book_only(pagebreak())
  question(label: <ex:catenary3>, {
    learning_objectives(
      ([Solve boundary value problems with conditions coming from real-world scenarios.],),
    )
    notes[
      It's time to solve some boundary value problems! This question is very challenging and really
      pushes students to interpret phase portraits in the context of boundary value problems.

      This question can be extended in lots of interesting ways if you have time.

      - In @ex:catenary3_find_k[], students will need to adjust the $Delta$ and $N$ to make sure
        they graph a solution for $x in [0, 10]$. They may forget this! After they make the graph go
        for the correct amount of "time", they can adjust $k$ to solve the boundary value problem.

        This is similar to what we did in @ex:bell_ring_adjust_euler.
    ]
    slide(force_scale: 0.85em)[

      Recall a rope hanging from two poles.

      #catenary_simple

      $H(x) =$ the height of the rope at position $x$.

      We have the following model for it:
      $ H''(x) = k sqrt(1 + (H'(x))^2) $

      Toronto Hydro is stringing some wire. The posts are 20m apart and at a height of 10m. At the
      lowest point, the wire is 5m above the ground.

      + #label_question_part(<ex:catenary3_boundary>) We can exploit symmetry to model this
        situation. Assume the ends of the wire are at $x = -10$ and $x = 10$.
        + Find $H(-10)$, $H(10)$, $H(0)$, and $H'(0)$.
          #solution[
            $H(-10) = 10$, #h(1em) $H(10) = 10$, #h(1em) $H(0) = 5$, #h(1em) $H'(0) = 0$.
          ]
        + Write down a boundary value problem that models the wire for $x in [0,10]$.

          #solution[
            $
              H''(x) & = k sqrt(1 + (H'(x))^2) \
                H(0) & = 5 \
               H'(0) & = 0 \
               H(10) & = 10 \
            $
          ]

      +
        + Using your knowledge from Calculus, find a formula for the total length of the wire. Does
          your formula simplify in a nice way?

          #solution[
            Since the wire hangs symmetrically, we can find the total length of the wire from $0$ to
            $10$ and double it. Using the arc-length formula from calculus, we have
            $
              2 integral_(0)^(10) sqrt(1 + (H'(x))^2) dif x & =
                                                              2 integral_(0)^(10) (H''(x)) / k dif x \
                                                            & = frac(2, k) (H'(10) - H'(0)) \
                                                            & = frac(2, k) H'(10).
            $
          ]
        + #label_question_part(<ex:catenary3_find_k>) Using the following Desmos link, can you find
          a solution to the boundary value problem?

          #link("https://www.desmos.com/calculator/l4fair6454")

          #solution[
            The Desmos link is already set up to plot a solution in phase space starting at
            $(H,H') = (5,0)$.

            To find a solution to the boundary value problem, we need to:
            #set enum(numbering: "(i)", full: false)
            + Adjust $Delta$ and $N$ to make sure we graph a solution for $x in [0, 10]$ (since by
              symmetry, this will allow us to find a solution for the whole interval $[-10, 10]$).

            + Adjust $k$ so that the solution satisfies the boundary condition $H(10) = 10$.

            After adjusting, we end up with the following.

            #let (diagram, k, H_prime, _Delta) = {
              let k = 0.093082 // Using RK4
              let k = 0.093102
              let F(x, y) = (y, k * calc.sqrt(1 + y * y))

              let _Delta = 0.002
              let steps = calc.ceil(10 / _Delta)

              let soln1 = solve_2d_ivp(F, (5, 0), steps, Delta: _Delta, method: "euler")

              let xs = lq.linspace(-3.5, 3.5, num: 2)
              let xticks = lq.linspace(-3, 3, num: 7)
              let diagram = vector_field(
                F,
                xlim: (-1, 15),
                ylim: (-1.5, 1.5),
                spacing: (1.05, .25),
                scale_segments: 60,
                width: 10cm,
                height: 5cm,
                xaxis: (position: 0, tip: tiptoe.stealth, subticks: none),
                yaxis: (position: 0, tip: tiptoe.stealth, subticks: none),
                title: [Solution Trajectory in Phase Space with $Delta = #_Delta$
                  #v(-.5em)
                  $
                    cases(
                      k & = #k,
                      (H(0), H'(0)) & = (5, 0),
                      (H(10), H'(10)) &= (#calc.round(soln1.last().at(0), digits: 5), #calc.round(soln1.last().at(1), digits: 5))
                    )
                  $
                ],
                lq.plot(
                  soln1.map(((x, y)) => x),
                  soln1.map(((x, y)) => y),
                  mark: none,
                  stroke: (paint: red.darken(20%), thickness: 1.8pt),
                ),
              )
              (diagram, k, soln1.last().at(1), _Delta)
            }

            #{
              set align(center)
              diagram
            }

            Using our result from earlier, this means that the total length of the wire is
            $2/k H'(10) approx #(calc.round(2 / k * H_prime, digits: 5))$.

          ]
      + It happens that $k = frac(rho g, T)$ where $T$ is the minimum tension in the rope.

        Suppose Toronto Hydro hung the wires so that they were at minimum 9m above the ground. Would
        the tension be higher or lower? By how much?
        #solution[
          Intuitively, the minimum tension should be higher, since it will take more tension to pull
          up the slack in the rope.

          Approximating with Desmos, we find that if $(H(0), H'(0)) = (9,0)$ and $H(10) = 10$, then
          $k approx 0.02$, which means the minimum tension is approximately
          $#calc.round(0.093 / 0.02, digits: 5)$ times higher than the previous case.

          // Alternatively, we can solve $T = (H''(10))/sqrt(1+(H'(10))^2) approx (H''(10)) / (H'(10))$
        ]

      // + Should the difference between maximum and minimum tension be higher or lower for low-hanging
      //   wires? What does your intuition say? What does the phase portrait say?
      //   #solution[
      //     Let $T_"min"$ be the minimum tension, which occurs at the lowest point of the wire's hang.
      //     Let $T_"max"$ be the maximum tension, which occurs at the highest point of the wire's
      //     hang. We know $T_"min" = k/(rho g)$. Further, since the end points of the wire must hold
      //     up the entire mass of the wire,
      //     $
      //       T_"max" > 1/2 rho g dot "length of wire" = (rho g)/k H'(10)
      //     $

      //     XXX: Finish
      //     // The minimum tension occurs at the lowest point of the wire's hang and is proportional to
      //     // $1/k$. The maximum tension occurs at the highest point. at which point the tension greater
      //     // than $1/k H'$

      //     // Intuitively, by making the wire hang _very_ low, the difference in tension between the
      //     // bottom of the hang and attachment points of the wires should be large.


      //     // Looking at the phase portrait, we can see this.

      //   ]

      // The wire has a (linear) density of 1 kg/m and gravity is 9.8 m/s^2.
      // For safety reasons, the wire's tensile strength needs to be 5 times the maximum tension when the wire is resting.
      // What strength of wire do they need?
      // Assuming the posts are both the same height, relate the length of the rope with the tension at the posts.
      // Assuming the posts have different heights, relate the length of the rope with the tension at the posts.


    ]
  })


  // Pendulum Problem


  let pendulum = {
    let xs = lq.linspace(-1, 1.5, num: 25)
    let thickness = 1.5pt


    align(
      center,
      {
        show: lq.set-grid(stroke: none)
        lq.diagram(
          width: 1.6cm,
          height: 3.55cm,
          // xlim: (-2, 14),
          // ylim: (-5, 5),
          yaxis: none,
          xaxis: none,
          // Cement Ceiling
          lq.rect(
            -1,
            0,
            width: 2,
            height: 0.25,
            stroke: none,
            fill: color.rgb("#a4c7c7"), // cement
          ),
          lq.line(
            (-1, 0),
            (1, 0),
            stroke: (paint: black, thickness: thickness),
          ),
          // Pendulum
          lq.line(
            (0, 0),
            (1, -4),
            stroke: (paint: black, thickness: thickness),
          ),
          lq.ellipse(
            1 - 0.5,
            -4 - 0.5,
            height: 1,
            width: 1,
            fill: purple.lighten(70%), // pinkish
            stroke: (paint: black, thickness: thickness),
          ),
          lq.place(1, -4)[$m$],
          // y axis
          lq.line(
            (0, 0),
            (0, -4),
            stroke: (paint: gray, thickness: 0.5 * thickness, dash: "dashed"),
          ),
          lq.path(
            (0, -3),
            (0.2, -3),
            (0.4, -2.95),
            (0.6, -2.85),
            (0.7, -2.8),
            tip: tiptoe.stealth,
            stroke: (paint: gray, thickness: 0.5 * thickness), //, dash: "dashed"),
          ),
          lq.place(0.3, -2.6)[#text(fill: gray, $theta$)],
          // Gravitational Force
          lq.path(
            (1, -4.75),
            (1, -5.85),
            stroke: (paint: black),
            tip: tiptoe.stealth,
          ),
          lq.place(1.4, -5.2)[$arrow(F)_g$],
          // Tension Force
          lq.path(
            (1.1, -3.3),
            (0.85, -2.3),
            stroke: (paint: black),
            tip: tiptoe.stealth,
          ),
          lq.place(1.4, -2.9)[$arrow(T)$],
        )
      },
    )
  }


  book_only(pagebreak())
  question({
    learning_objectives(
      ([Model a pendulum using a second-order differential equation.],),
    )
    notes[
      Setting up the pendulum model is straight forward, but the algebra requires patience.

      - In @ex:pendulum_choice[], you can find a first-order equation (eliminating $theta''$) which
        includes the parameter $alpha$, or you can find a second-order equation (eliminating
        $(theta ')^2$) which incidentally eliminates $alpha$. We suggest the second-order approach.
    ]
    slide(force_scale: 0.74em)[

      Consider a pendulum as in the figure below.


      #align(
        center,
        table(
          columns: (1fr, 1fr),
          align: (center, left),
          stroke: none,
          { pendulum },
          [
            $theta(t) =$ the angle the pendulum makes with the vertical axis (positive in the
            counterclockwise direction and negative in the clockwise direction).
          ],
        ),
      )

      Assume the pendulum is composed of a weightless rigid rod of length $1$m and a mass of $1$kg
      at its end. In addition assume:

      - ($P_"G"$) Gravity pulls downwards in proportion to mass (the proportionality constant is
        called $g$).
      - ($P_"T"$) Tension pulls the mass in the direction of the rod.
      - ($P_"NL"$) Newton's Second Law: Force is proportional to acceleration (the proportionality
        constant is called mass).
      - ($P_"ML"$) Laws of Motion: Velocity is the time derivative of displacement and acceleration
        is the time derivative of velocity.

      + Let $theta(t)$ be the angle at time $t$ and let $arrow(r)(t)$ be the mass's position at time
        $t$.

        Find $arrow(r)(t)$ and $arrow(r)''(t)$ in terms of $theta(t)$.
        #solution[
          With the pivot at the origin and rod length $L = 1$, we have
          $
            arrow(r)(t) = mat(sin theta(t); -cos theta(t)).
          $

          Differentiating twice gives
          $
            arrow(r)''(t) = mat(theta'' cos theta - (theta')^2 sin theta; theta'' sin theta + (theta')^2 cos theta).
          $
        ]
      + Find the vector $arrow(F)_g$.
        #solution[
          By ($P_"G"$) with mass $m = 1$, gravity pulls straight down:
          $
            arrow(F)_g = mat(0; -g).
          $
        ]
      + Find a vector $arrow(T)_d$ so that $arrow(T) = alpha arrow(T)_d$ for some $alpha > 0$.
        #solution[
          By ($P_"T"$), tension acts along the rod toward the pivot. The direction of this force is
          $-arrow(r)$, so
          $
            arrow(T)_d = -arrow(r) = mat(-sin theta; cos theta).
          $
        ]
      //	Find the velocity and acceleration vectors for the mass.
      + #label_question_part(<ex:pendulum_choice>) Find a second-order differential equation for the
        pendulum.

        _Hint: ($P_("NL")$) gives you an equation for each coordinate. Solve one for $(theta')^2$
        and substitute it into the other equation._
        #solution[
          By ($P_"NL"$), with $m = 1$ we have $arrow(r)'' = arrow(F)_g + alpha arrow(T)_d$. That is,
          $
            mat(theta'' cos theta - (theta')^2 sin theta; theta'' sin theta + (theta')^2 cos theta) = mat(0; -g) + alpha mat(-sin theta; cos theta).
          $

          Expanding the first coordinate and solving for $(theta')^2$ gives
          $
            (theta')^2 = alpha + theta'' (cos theta)/(sin theta).
          $
          Substituting this into the second coordinate, we get
          $
            theta'' sin theta + (alpha + theta'' (cos theta)/(sin theta)) cos theta = -g + alpha cos theta
          $
          Multiplying both sides by $sin theta$ and applying the trig identity
          $sin^2 theta + cos^2 theta = 1$ we finally arrive at
          $
            theta'' = -g sin theta.
          $

          Alternatively, we could have multiplied the first coordinate by $cos theta$ and the second
          coordinate by $sin theta$ and added the two coordinates together to get the same result
          (solving this way removes the possibility of dividing by zero).
        ]
      //	Write the differential equation as a system of 1$^{rm st}$-order differential equations.


    ]
  })


  book_only(pagebreak())
  question({
    learning_objectives(
      (
        [Interpret and relate the phase portrait for the motion of a pendulum to real-world
          scenarios.],
      ),
    )
    notes[
      This problem re-derives the classic small-angle formula for the motion of a pendulum. It uses
      many of the techniques of the course (converting a second-order equation to a system,
      linearization, and interpreting phase portraits and equilibria).

      - For @ex:pendulum_approx_conditions[], the _Buckingham $pi$ Theorem_ allows you to conclude
        that the period of oscillation is proportional to $sqrt(L/g)$ for the full _non-linear_
        model.
    ]
    slide(force_scale: 0.87em)[


      Consider a pendulum as in the figure below.


      #align(
        center,
        table(
          columns: (1fr, 1fr),
          align: (center, left),
          stroke: none,
          { pendulum },
          [
            $theta(t) =$ the angle the pendulum makes with the vertical axis (positive in the
            counterclockwise direction and negative in the clockwise direction).
          ],
        ),
      )

      If we had preserved length and mass in our derivation, we would have the following model:
      $ theta''(t) = - (g / L) sin(theta(t)) $


      Let (P) be the corresponding system of first-order differential equations. The following
      Desmos link is already set up with (P).

      #link("https://www.desmos.com/calculator/acmiingcqf")

      + If $L = 3$m, and you set the pendulum in motion at $theta = 0$ by giving it a *small* push,
        what does the motion look like?
        #solution[
          A small push means $theta(0) = 0$ and $abs(theta'(0))$ is small. Based on the phase
          portrait, there would be periodic behaviour: the pendulum would swing back and forth.
        ]

      + If $L = 3$m, and you set the pendulum in motion at $theta = 0$ by giving it a *big* push,
        what does the motion look like?
        #solution[
          A large push means $theta(0) = 0$ and $abs(theta'(0))$ is large. If the push is large
          enough, $theta(t)$ will continue to increase (or decrease) forever. This corresponds to
          the pendulum doing a "loop the loop".
        ]

      + Why are there infinitely many equilibrium solutions? Based on your physical intuition, which
        equilibria are stable and which are unstable?
        #solution[
          At every multiple of $2pi$ there is an equilibrium corresponding to the pendulum hanging
          straight down. Intuitively, these are stable.

          At every odd multiple of $pi$ there is an equilibrium corresponding to the pendulum
          standing straight up. Intuitively, these are unstable.
        ]

      + Find an affine approximation to (P) around $(theta, theta') = (0, 0)$.
        #solution[
          Let $omega = theta'$ be the angular velocity. Using this (P), the corresponding
          first-order system, is
          $
            mat(theta'; omega') = mat(omega; -(g/L) sin theta).
          $
          The linearization of this system around $(theta, omega) = (0, 0)$ is
          $
            mat(theta_"approx" '; omega_"approx" ') = mat(0, 1; -g/L, 0) mat(theta_"approx"; omega_"approx").
          $
        ]

      + #label_question_part(<ex:pendulum_approx_conditions>) Physicists often claim that the
        oscillations of $theta(t)$ are modelled by a sine wave with period $2 pi sqrt(L /g)$. Under
        what conditions are the physicists (mostly) correct?
        #solution[
          Explicitly solving the linearized system gives us a general solution of
          $
            theta_"approx" (t) = A cos(sqrt(g/L) dot t) + B sin(sqrt(g/L) dot t),
          $
          where $A,B$ are real parameters. These solutions are periodic with period
          $2 pi sqrt(L /g)$.

          As long as $theta(0)$ and $theta'(0)$ are both small, these solutions will be good
          approximations of solutions to the true pendulum equation.
        ]
    ]
  })
}
