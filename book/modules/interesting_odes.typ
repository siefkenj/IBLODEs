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
          lq.place(0, -0.25)[#text(fill: gray, $d$)],
          lq.place(0.5, -0.25)[#text(fill: gray, $d + Delta$)],
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

  question({
    learning_objectives(
      [???],
    )
    notes[???]
    slide(force_scale: 0.87em)[

      Consider a rope hanging from two poles.

      #catenary


      $H(d) =$ height of the rope above ground at position $d$.

      We will consider the following premises and physics laws:
      - ($P_D$) The linear density of the rope is constant: $rho$ kg/m
      - ($P_G$) Gravity pulls downwards in proportion to mass (the proportionality constant is
        called $g$)
      - ($P_T$) Tension pulls tangentially to the rope
      // - (S) The rope is not moving (it is stationary)
      - ($P_(N L)$) Newton's First Law: a body at rest will remain at rest unless it is acted upon
        by a force
      // - (NL) Newton's Second Law: Force is proportional to acceleration (the proportionality constant is called mass).
      // - (ML) Laws of Motion: Velocity is the time derivative of displacement and acceleration is the time derivative of velocity.

      To model the rope, imagine it is made of *small rigid rods*. We will focus on one such rod,
      $S$, (drawn in the figure) from $d$ to $d + Delta$.

      + Given ($P_(N L)$), find a relation between the force vectors $arrow(T)_L$, $arrow(T)_R$,
        $arrow(F)_g$.
        #solution[
          Since the rod is at rest, ($P_(N L)$) requires the net force to be zero:
          $
            arrow(T)_L + arrow(T)_R + arrow(F)_g = arrow(0).
          $
        ]
      + Approximate the length of the segment #SS and its mass. Approximate the vector $arrow(F)_g$.
        #solution[
          The segment goes from $(d, H(d))$ to $(d + Delta, H(d + Delta))$. Its length is
          approximately
          $
            sqrt(Delta^2 + (H(d + Delta) - H(d))^2) approx Delta sqrt(1 + (H'(d))^2).
          $
          By ($P_D$), its mass is approximately $rho Delta sqrt(1 + (H'(d))^2)$.

          By ($P_G$), the gravitational force is
          $
            arrow(F)_g approx mat(0; -rho g Delta sqrt(1 + (H'(d))^2)).
          $
        ]
      + Find a vector $arrow(V)_L$ in the direction of $arrow(T)_L$ (the magnitude doesn't matter at
        this point).
        #solution[
          By ($P_T$), tension acts tangentially to the rope. At position $d$ the tangent direction
          is $(1, H'(d))$. Since $arrow(T)_L$ pulls the segment to the left (away from $d + Delta$):
          $
            arrow(V)_L = mat(-1; -H'(d)).
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
    slide(force_scale: 0.75em)[

      Consider a rope hanging from two poles.

      #catenary

      The only forces acting on the rope are gravity and tension.

      Similarly to the previous exercise, we can find a vector $arrow(V)_R = mat(1; H'(d + Delta))$
      in the direction of $arrow(T)_R$, but with possibly different magnitude.

      So far we have:
      - $arrow(T)_L = alpha arrow(V)_L$ for some $alpha > 0$, and
      - $arrow(T)_R = beta arrow(V)_R$ for some $beta > 0$.

      + Can you find approximations of the vectors $arrow(F)_g$, $arrow(T)_L$, $arrow(T)_R$ that
        only use $H(d)$, $H'(d)$, and $H''(d)$?

        Hint:
        - $H(d + Delta) approx H(d) + Delta dot H'(d)$,
        - $H'(d + Delta) approx H'(d) + Delta dot H''(d)$.

        #solution[
          Using the Taylor hints and the result of $arrow(V)_L$ from the previous exercise:
          $
            arrow(F)_g &approx mat(0; -rho g Delta sqrt(1 + (H'(d))^2)), \
            arrow(T)_L &= alpha mat(-1; -H'(d)), \
            arrow(T)_R &approx beta mat(1; H'(d) + Delta H''(d)).
          $
        ]
      + Put everything together to find a (second order) differential equation for $H$.
        #solution[
          Substituting into $arrow(T)_L + arrow(T)_R + arrow(F)_g = arrow(0)$:

          *Horizontal:* $-alpha + beta = 0$, so $alpha = beta$.

          *Vertical:* $-alpha H'(d) + beta(H'(d) + Delta H''(d)) - rho g Delta sqrt(1 + (H'(d))^2) = 0$.

          With $beta = alpha$, the $H'(d)$ terms cancel:
          $
            alpha Delta H''(d) = rho g Delta sqrt(1 + (H'(d))^2).
          $
          Dividing by $Delta$ and setting $k = rho g \/ alpha$:
          $
            H''(d) = k sqrt(1 + (H'(d))^2).
          $
        ]

      + Do $alpha$ or $beta$ depend on $d$? Explain.
        #solution[
          Since $alpha = beta$, both equal the horizontal component of tension throughout the rope.
          If this varied with $d$, a segment would experience a net horizontal force and accelerate
          horizontally — contradicting the fact that the rope is stationary. Therefore $alpha$ (and
          $beta$) are *constant* and do not depend on $d$. Consequently $k = rho g \/ alpha$ is also
          constant.
        ]


    ]
  })


  book_only(pagebreak())
  question({
    learning_objectives(
      [???],
    )
    notes[???]
    slide(force_scale: 0.85em)[

      Recall a rope hanging from two poles.

      #catenary_simple

      $H(d) =$ the height of the rope at position $d$.

      We have the following model for it:
      $ H''(d) = k sqrt(1 + (H'(d))^2) $

      Toronto Hydro is stringing some wire. The posts are 20m apart and at a height of 10m. At the
      lowest point, the wire is 5m above the ground.

      + Set up a boundary value problem that can be used to find the total length of the wire.
        #solution[
          Place the left post at $d = 0$ and the right post at $d = 20$. The boundary conditions
          are $H(0) = 10$ and $H(20) = 10$. By symmetry the minimum occurs at $d = 10$:
          $H(10) = 5$ and $H'(10) = 0$.

          The boundary value problem is: find $k > 0$ and $H$ satisfying
          $
            H''(d) = k sqrt(1 + (H'(d))^2), quad H(0) = 10, quad H(20) = 10, quad H(10) = 5.
          $
          Once $H$ is found, the total wire length is the arc length of the curve
          $(d, H(d))$ for $d in [0, 20]$.
        ]

      + Using the following Desmos link, can you find a solution to the boundary value problem?

        #link("https://www.desmos.com/calculator/l4fair6454")

        #solution[
          In the Desmos link, vary $k$ until the catenary through the midpoint $(10, 5)$ (with zero
          slope there) reaches height $10$ at both $d = 0$ and $d = 20$. Desmos then computes the
          arc length of that curve to give the total wire length.
        ]
      + It happens that $k = frac(rho g, T)$ where $T$ is the minimum tension in the rope.

        Suppose Toronto Hydro hung the wires so that they were at minimum 9m above the ground. Would
        the tension be higher or lower? By how much?
        #solution[
          We have $k = rho g \/ T$, so $T = rho g \/ k$. A wire hanging no lower than $9$m has sag
          $10 - 9 = 1$m rather than $10 - 5 = 5$m. The catenary is flatter, requiring a *smaller*
          $k$, and hence *larger* minimum tension $T = rho g \/ k$.

          The value of $k$ for each case is found by solving
          $
            frac(cosh(10k) - 1, k) = "sag"
          $
          numerically (sag $= 5$ for the $5$m wire, sag $= 1$ for the $9$m wire), then comparing
          $T = rho g \/ k$. A wire hanging at $9$m requires roughly five times the horizontal
          tension of one hanging at $5$m.
        ]

      + Should the difference between maximum and minimum tension be higher or lower for low-hanging
        wires? What does your intuition say? What does the phase portrait say?
        #solution[
          The minimum tension $T_"min" = rho g \/ k$ occurs at the lowest point, and the maximum
          tension at the posts is $T_"max" = T_"min" cosh(10k)$. Using
          $frac(cosh(10k) - 1, k) = "sag"$:
          $
            T_"max" - T_"min" = frac(rho g, k)(cosh(10k) - 1) = rho g dot "sag".
          $
          The difference equals $rho g times "sag"$, so *low-hanging wires have a larger difference*.

          *Intuition:* A saggy wire makes a steep angle at the posts, so the tension there must also
          support a large vertical component — much more than at the bottom.

          *Phase portrait:* Solutions with larger sag range over a wider interval of $H'$ values
          (steeper slopes at the endpoints), corresponding to a larger ratio $T_"max" \/ T_"min"$.
        ]

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
      [???],
    )
    notes[???]
    slide(force_scale: 0.74em)[

      Consider a pendulum as in the figure below.


      #align(
        center,
        table(
          columns: (1fr, 1fr),
          align: (center, center),
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

      - ($P_G$) Gravity pulls downwards in proportion to mass (the proportionality constant is
        called $g$).
      - ($P_T$) Tension pulls the mass in the direction of the rod.
      - ($P_(N L)$) Newton's Second Law: Force is proportional to acceleration (the proportionality
        constant is called mass).
      - ($P_(M L)$) Laws of Motion: Velocity is the time derivative of displacement and acceleration
        is the time derivative of velocity.

      + Let $theta(t)$ be the angle at time $t$ and let $arrow(r)(t)$ be the mass's position at time
        $t$.

        Find $arrow(r)(t)$ and $arrow(r)''(t)$ in terms of $theta(t)$.
        #solution[
          With the pivot at the origin and rod length $L = 1$, the mass at angle $theta$ is at
          $
            arrow(r)(t) = mat(sin theta(t); -cos theta(t)).
          $
          Differentiating: $arrow(r)'(t) = mat(theta' cos theta; theta' sin theta)$.

          Differentiating again:
          $
            arrow(r)''(t) = mat(theta'' cos theta - (theta')^2 sin theta; theta'' sin theta + (theta')^2 cos theta).
          $
        ]
      + Find the vector $arrow(F)_g$.
        #solution[
          By ($P_G$) with mass $m = 1$, gravity pulls straight down:
          $
            arrow(F)_g = mat(0; -g).
          $
        ]
      + Find a vector $arrow(T)_d$ so that $arrow(T) = alpha arrow(T)_d$ for some $alpha > 0$.
        #solution[
          By ($P_T$), tension acts along the rod toward the pivot. The direction from the mass at
          $mat(sin theta; -cos theta)$ toward the pivot at the origin is $-arrow(r)$:
          $
            arrow(T)_d = mat(-sin theta; cos theta).
          $
        ]
      //	Find the velocity and acceleration vectors for the mass.
      + Find a second-order differential equation for the pendulum.
        _Hint: ($P_(N L)$) gives you an equation for each coordinate. Solve one for $(theta')^2$ and
        substitute it into the other equation._
        #solution[
          By ($P_(N L)$) with $m = 1$: $arrow(r)'' = arrow(F)_g + alpha arrow(T)_d$, giving
          $
            theta'' cos theta - (theta')^2 sin theta &= -alpha sin theta, quad "(1)" \
            theta'' sin theta + (theta')^2 cos theta &= -g + alpha cos theta. quad "(2)"
          $
          Multiply (1) by $sin theta$, (2) by $(-cos theta)$, and add:
          $
            -(theta')^2 (sin^2 theta + cos^2 theta) = -alpha(sin^2 theta + cos^2 theta) + g cos theta,
          $
          so $(theta')^2 = alpha - g cos theta$.

          Substituting into (2):
          $
            theta'' sin theta + (alpha - g cos theta) cos theta = -g + alpha cos theta \
            theta'' sin theta = -g + g cos^2 theta = -g sin^2 theta.
          $
          Dividing by $sin theta$ (and using continuity for $sin theta = 0$):
          $
            theta'' = -g sin theta.
          $
        ]
      //	Write the differential equation as a system of 1$^{rm st}$-order differential equations.


    ]
  })


  book_only(pagebreak())
  question({
    learning_objectives(
      [???],
    )
    notes[???]
    slide(force_scale: 0.87em)[


      Consider a pendulum as in the figure below.


      #align(
        center,
        table(
          columns: (1fr, 1fr),
          align: (center, center),
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
          A small push means $theta(0) = 0$ and $theta'(0) = omega_0$ with $|omega_0|$ small. In
          the phase portrait the initial state $(0, omega_0)$ is near the equilibrium $(0, 0)$, and
          the trajectory is a small closed curve around it. The pendulum oscillates back and forth
          through the bottom position with small amplitude, nearly sinusoidally.
        ]

      + If $L = 3$m, and you set the pendulum in motion at $theta = 0$ by giving it a *big* push,
        what does the motion look like?
        #solution[
          A large push gives $theta'(0) = omega_0$ with $|omega_0|$ large. If the kinetic energy
          exceeds the potential energy barrier at $theta = pi$ (pendulum pointing straight up), the
          pendulum has enough energy to swing over the top and rotate continuously in one direction.
          In the phase portrait the trajectory is an unbounded wave rather than a closed curve.
        ]

      + Why are there infinitely many equilibrium solutions? Based on your physical intuition, which
        equilibria are stable and which are unstable?
        #solution[
          Setting $theta' = 0$ and $theta'' = 0$: $-(g\/L) sin theta = 0$, so $theta = n pi$ for
          every integer $n$. Since $theta$ tracks total angle (not reduced modulo $2 pi$), each
          integer gives a distinct equilibrium — infinitely many.

          Physically:
          - $theta = 2k pi$ (pendulum hanging straight down): *stable*. A small displacement
            produces a restoring force, causing small oscillations that stay near the equilibrium.
          - $theta = (2k+1) pi$ (pendulum pointing straight up): *unstable and not repelling*.
            Any small displacement causes the pendulum to fall to one side. The total derivative at
            these equilibria has eigenvalues $plus.minus sqrt(g\/L)$ (one positive, one negative),
            confirming instability.
        ]

      + Find an affine approximation to (P) around $(theta, theta') = (0, 0)$.
        #solution[
          Let $omega = theta'$. The system (P) is $arrow(F)(theta, omega) = (omega, -(g\/L) sin theta)$.
          The total derivative is
          $
            D_(arrow(F))(theta, omega) = mat(0, 1; -(g\/L) cos theta, 0).
          $
          At $(0, 0)$: $arrow(F)(0, 0) = mat(0; 0)$ and $D_(arrow(F))(0, 0) = mat(0, 1; -g\/L, 0)$.

          The affine approximation is
          $
            mat(theta'; omega') approx mat(0, 1; -g\/L, 0) mat(theta; omega),
          $
          or equivalently the linearized equation $theta'' approx -(g\/L) theta$.
        ]

      + Physicists often claim that $theta(t)$ oscillates like a sine wave with period
        $2 pi sqrt(L /g)$. Under what conditions are the (mostly) correct?
        #solution[
          The linearized equation $theta'' = -(g\/L) theta$ has general solution
          $theta(t) = A cos(sqrt(g\/L) dot t) + B sin(sqrt(g\/L) dot t)$, which oscillates with
          period $2pi \/ sqrt(g\/L) = 2 pi sqrt(L\/g)$.

          This is a good approximation to the nonlinear pendulum when the solution stays close to
          $(0, 0)$ — that is, when both the initial angle $|theta(0)|$ and initial angular velocity
          $|theta'(0)|$ are small, so that $|theta(t)|$ remains small throughout and
          $sin theta approx theta$.

          For $L = 3$m: period $approx 2 pi sqrt(3\/g) approx 3.5$s.
        ]
    ]
  })
}
