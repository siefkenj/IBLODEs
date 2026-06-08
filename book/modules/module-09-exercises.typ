#import "../libs/lib.typ": *
#show: e.prepare(question)
#show ref: allow_missing_refs


#{
  question({
    learning_objectives(
      [???],
    )
    notes[???]
    slide[


      //  Completed phase portrait in desmos:
      //  https://www.desmos.com/calculator/tvjag852ja

      Recall the tree model from @ex:tree_model:

      - $H(t)$ = height (in meters) of tree trunk at time $t$
      - $A(t)$ = surface area (in square meters) of all leaves at time $t$

      $ H'(t) = 0.3 dot A(t) - b dot H(t) $
      $ A'(t) = -0.3 dot (H(t))^2 + A(t) $
      and $0 <= b <= 2$

      A phase portrait for this model is available at

      #link("https://www.desmos.com/calculator/tvjag852ja")

      #h(1em)

      + Visually classify the stability of each equilibrium solution as attracting/repelling/etc.
        Does the stability depend on $b$? Are you confident in your visual assessment?
        #solution[
          From the phase portrait, the equilibrium at $(0, 0)$ is _unstable and not repelling_: some
          trajectories move away from it in one direction while approaching along another. The
          non-zero equilibrium $arrow(E)^* = (100 / (9 b), 1000 / (27 b^2))$ appears _attracting_,
          with nearby trajectories curving toward it.

          Yes, the stability depends on $b$: changing $b$ moves the location of $arrow(E)^*$ and
          affects whether the equilibrium is attracting.

          The unstable-and-not-repelling nature of $(0, 0)$ is fairly clear from the phase portrait.
          The attracting nature of $arrow(E)^*$ is plausible visually but should be confirmed
          analytically.
        ]
      + Can you rewrite the system in matrix/affine form? Why or why not?
        #solution[
          No. An affine system requires the right-hand side to have the form $M arrow(r) + arrow(b)$
          for a matrix $M$ and constant vector $arrow(b)$. The term $-0.3 H^2$ in $A'$ is
          _quadratic_ in $H$, so the system cannot be written in matrix or affine form.
        ]


    ]
  })

  let LL = $upright(bold("L"))$
  book_only(pagebreak())
  question(label: <ex:linear_approx_1d>, {
    learning_objectives(
      [???],
    )
    notes[???]
    slide[

      A simple logistic model $LL$ for a population is
      $ (dif P) / (dif t) = P(t) dot (1 - (P(t)) / 2) $
      where $P(t)$ represents the population at time $t$.

      //We'd like to find a "simpler" version of model $LL$. Since simplifications require tradeoffs,
      We will focus on finding a simpler version of model $LL$ that works when $P approx 1/2$.
      // to approximate $(dif P) / (dif t)$ when $P approx 1 / 2$.

      //+ What is the value of $(dif P) / (dif t)$ when $P = 1 / 2$?

      + Define $f(P) = P dot (1 - P / 2)$ and let $A_(1/2)(P)$ denote the affine
        approximation#footnote[In calculus, this is called a "linear approximation".] to $f$
        centered at $P=1/2$. Find $A_(1/2)(P)$.
        #solution[
          We have $f(P) = P - P^2 / 2$, so $f'(P) = 1 - P$. Evaluating at $P = 1 / 2$:
          $
            f(1 / 2) = 1 / 2 - 1 / 8 = 3 / 8, wide f'(1 / 2) = 1 - 1 / 2 = 1 / 2.
          $
          Therefore
          $
            A_(1 / 2)(P) = f(1 / 2) + f'(1 / 2)(P - 1 / 2) = 3 / 8 + 1 / 2 (P - 1 / 2).
          $
        ]

      + Notice that $(dif P)/(dif t)=f(P(t))$. Use this observation to create a "simple" model
        $LL_(1/2)$ that approximates $LL$ when $P approx 1/2$.
        #solution[
          Replacing $f(P)$ with its affine approximation $A_(1 / 2)(P)$, model $LL_(1 / 2)$ is
          $
            (dif P) / (dif t) approx 3 / 8 + 1 / 2 (P - 1 / 2).
          $
        ]

      + Model $LL_(1/2)$ is called an _affine approximation of model $LL$ centered at $P=1/2$_.

        Find additional affine approximations to model $LL$ centered at each equilibrium solution.
        #solution[
          The equilibria of $LL$ satisfy $f(P) = P(1 - P / 2) = 0$, giving $P = 0$ and $P = 2$.

          At $P = 0$: $f(0) = 0$ and $f'(0) = 1$, so
          $
            A_0(P) = P, wide "giving model" wide LL_0 colon (dif P) / (dif t) approx P.
          $

          At $P = 2$: $f(2) = 0$ and $f'(2) = 1 - 2 = -1$, so
          $
            A_2(P) = -(P - 2), wide "giving model" wide LL_2 colon (dif P) / (dif t) approx -(P - 2).
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

      Based on our calculations from @ex:linear_approx_1d, we have several different affine
      approximations.


      #align(
        center,
        table(
          stroke: none,
          align: (right, left, left),
          columns: 3,
          // Original ODE
          [(Original $LL$)],
          [$P' = P (1 - P / 2)$],
          [(#link("https://www.desmos.com/calculator/v1coz4shtw"))],
          // Linear approximation at P = 1/2
          [($LL_(1 / 2)$)],
          [$P' approx 3 / 8 + 1 / 2 (P - 1 / 2)$],
          [(#link("https://www.desmos.com/calculator/zsb2apxhqs"))],
          // Linear approximation at P = 0
          [($LL_0$)], [$P' approx P$], [(#link("https://www.desmos.com/calculator/vw48bvqgrc"))],
          // Linear approximation at P = 2
          [($LL_2$)],
          [$P' approx - (P - 2)$],
          [(#link("https://www.desmos.com/calculator/i2utk6vnqh"))],
        ),
      )


      + What are the similarities/differences in the Desmos plots of solutions to the original
        equation vs. the other equations?
        #solution[
          *Similarities*: Near the center of each approximation, solutions closely match the
          original model $LL$. Each affine model captures the local slope direction correctly.

          *Differences*: Globally the models diverge. $LL_0$ predicts unbounded exponential growth
          ($P arrow +infinity$) for all $P > 0$, while $LL$ saturates at $P = 2$. $LL_2$ sends all
          initial conditions toward $P = 2$ regardless of how far away they start, whereas $LL$ only
          does this for $P > 0$. $LL_(1 / 2)$ matches $LL$ well only in a neighborhood of
          $P = 1 / 2$ and diverges elsewhere.
        ]
      + Does the nature of the equilibrium solutions change when using an affine approximation?
        #solution[
          No. The affine model $LL_0$, centered at the equilibrium $P = 0$, has eigenvalue
          $f'(0) = 1 > 0$, correctly identifying $P = 0$ as *unstable*. The model $LL_2$, centered
          at $P = 2$, has eigenvalue $f'(2) = -1 < 0$, correctly identifying $P = 2$ as *stable and
          attracting*. Affine approximations centered at equilibria preserve the stability type.
        ]
      + Classify each equilibrium solution of the original equation by using affine approximations.
        #solution[
          - $P = 0$: from $LL_0$, eigenvalue $f'(0) = 1 > 0$ → *unstable and repelling*.
          - $P = 2$: from $LL_2$, eigenvalue $f'(2) = -1 < 0$ → *stable and attracting*.
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

      Consider the differential equation whose slope field is sketched below.
      $
        P'(t) & = - P(t) dot (0.1 + P(t)) dot (0.2 + P(t)) \
              & = - (P(t))^3 - 0.3 dot (P(t))^2 - 0.02 dot P(t)
      $

      #text(size: 0.9em, link("https://www.desmos.com/calculator/ikp9rgo0kv"))

      #let F = (x, y) => -y * (0.1 + y) * (0.2 + y)
      #{
        let dist = 3.1
        let steps = 20
        // Start a solution plot at each of these y-values
        let solns = (-1, -.5, -.25, -.15, -.1, -.05, 0, .05, .5, 1).map(y => solve_1d_ivp(
          F,
          (
            0,
            y,
          ),
          steps,
          Delta: dist / steps,
          method: "rk4",
        ))
        align(
          center,
          slope_field(
            F,
            xlim: (-.3, dist),
            ylim: (-1.3, 1.3),
            width: 7cm,
            height: 3cm,
            spacing: (.1, .125),
            scale_segments: .07,
            yaxis: (position: 0, tip: tiptoe.stealth, tick-distance: 1),
            xaxis: (position: 0, tip: tiptoe.stealth, filter: ((v, d) => false)),
            ..solns.map(soln => lq.plot(
              soln.map(((x, y)) => x),
              soln.map(((x, y)) => y),
              mark: none,
              stroke: (paint: blue.darken(30%), thickness: 1pt),
            )),
          ),
        )
      }

      + Find all equilibrium solutions.
        #solution[
          Setting $P' = 0$: $-P(0.1 + P)(0.2 + P) = 0$ gives $P = 0$, $P = -0.1$, $P = -0.2$.
        ]
      + Use affine approximations to classify the equilibrium solutions as stable/unstable/etc.
        #solution[
          Define $f(P) = -P(0.1 + P)(0.2 + P)$. By the product rule,
          $
            f'(P) = -(0.1 + P)(0.2 + P) - P(0.2 + P) - P(0.1 + P) = -3P^2 - 0.6P - 0.02.
          $

          - $P = 0$: $f'(0) = -0.02 < 0$ → *stable and attracting*.
          - $P = -0.1$: $f'(-0.1) = -3(0.01) - 0.6(-0.1) - 0.02 = -0.03 + 0.06 - 0.02 = 0.01 > 0$ →
            *unstable and repelling*.
          - $P = -0.2$: $f'(-0.2) = -3(0.04) - 0.6(-0.2) - 0.02 = -0.12 + 0.12 - 0.02 = -0.02 < 0$ →
            *stable and attracting*.

          This matches the slope field: solutions between $-0.2$ and $-0.1$ are repelled toward the
          two stable equilibria, and solutions above $-0.1$ converge to $P = 0$.
        ]


    ]
  })

  book_only(pagebreak())
  question({
    learning_objectives(
      [???],
    )
    notes[???]
    slide(force_scale: 0.94em)[

      To make a 1d affine approximation of a function $f$ at the point $E$ we have the formula
      $ f(x) wide approx wide f(E) + f'(E) (x - E). $

      To make a 2d approximation of a function $arrow(F)(x, y) = (F_1(x, y), F_2(x, y))$ at the
      point $arrow(E)$, we have a similar formula
      $
        arrow(F)(x, y) wide approx wide arrow(F)(arrow(E)) + D_(arrow(F))(arrow(E)) (mat(x; y) - arrow(E))
      $
      where $D_(arrow(F))(arrow(E))$ is the _total derivative_ of $arrow(F)$ at $arrow(E)$, which
      can be expressed as the matrix
      $
        D_(arrow(F))(arrow(E)) = mat(
          (partial F_1) / (partial x), (partial F_1) / (partial y);
          (partial F_2) / (partial x), (partial F_2) / (partial y)
        )
      $
      evaluated at $arrow(E)$.
    ]

    book_only(v(5em))

    slide(force_scale: 0.85em)[

      Recall our model from Exercise @ex:tree_model for the life cycle of a tree where $H(t)$ was
      height, $A(t)$ was the leaves' surface area, and $t$ was time:

      $
        H'(t) & = 0.3 dot A(t) - b dot H(t) \
        A'(t) & = -0.3 dot (H(t))^2 + A(t)
      $
      with $0 <= b <= 2$


      We know the following:
      - The equations cannot be written in matrix form.
      - The equilibrium points are $(0, 0)$ and $(100 / 9 b, 1000 / 27 b^2)$.

      We want to find an affine approximation to the system.

      Define $arrow(F)(H, A) = (H', A')$

      #book_only(colbreak())
      + Find the matrix for $D_(arrow(F))$, the total derivative of $arrow(F)$.
        #solution[
          With $F_1(H, A) = 0.3 A - b H$ and $F_2(H, A) = -0.3 H^2 + A$,
          $
            D_(arrow(F))(H, A) = mat(
              (partial F_1) / (partial H), (partial F_1) / (partial A);
              (partial F_2) / (partial H), (partial F_2) / (partial A)
            ) = mat(-b, 0.3; -0.6 H, 1).
          $
        ]
      + Create an affine approximation to $arrow(F)$ around $arrow(e) = (0, 0)$ and use this to
        write an approximation to the original system.
        #solution[
          Evaluating at $(H, A) = (0, 0)$:
          $
            D_(arrow(F))(0, 0) = mat(-b, 0.3; 0, 1), wide arrow(F)(0, 0) = mat(0; 0).
          $
          The affine approximation of the original system is
          $
            mat(H'_"approx"; A'_"approx") = mat(-b, 0.3; 0, 1) mat(H_"approx"; A_"approx").
          $
        ]
      + In the original system, the equilibrium $(0, 0)$ is unstable and not repelling. Justify this
        using your affine approximation.
        #solution[
          The matrix $M = mat(-b, 0.3; 0, 1)$ is upper triangular, so its eigenvalues are the
          diagonal entries: $lambda_1 = -b$ and $lambda_2 = 1$.

          Since $lambda_2 = 1 > 0$, the linearized equilibrium is unstable; by the Classification
          via Linearization theorem, the original equilibrium is also *unstable*. Since
          $lambda_1 = -b < 0$ (for $b > 0$), there is a stable direction — not all trajectories are
          repelled — so the equilibrium is *not repelling*.
        ]
      + #label_question_part(<ex:affine-approx-part3>)
        Create an affine approximation to $arrow(F)$ around $arrow(e) = (100 / 9 b, 1000 / 27 b^2)$
        and use this to write an approximation to the original system.
        #solution[
          Let $arrow(E)^* = (100 / (9 b), 1000 / (27 b^2))$. Since $arrow(E)^*$ is an equilibrium,
          $arrow(F)(arrow(E)^*) = arrow(0)$. Evaluating the total derivative:
          $
            D_(arrow(F))(arrow(E)^*) = mat(-b, 0.3; -0.6 dot 100 / (9 b), 1) = mat(-b, 0.3; -20 / (3 b), 1).
          $
          Setting $arrow(s) = mat(H; A) - arrow(E)^*$, the approximation is
          $
            arrow(s)' = mat(-b, 0.3; -20 / (3 b), 1) arrow(s).
          $
        ]
      + Make a phase portrait for the original system and your approximation from part
        @ex:affine-approx-part3[]. How do they compare?
        #solution[
          #{
            let b_val = 1.2
            let H_star = 100 / (9 * b_val)
            let A_star = 1000 / (27 * b_val * b_val)
            let F_orig(x, y) = (0.3 * y - b_val * x, -0.3 * x * x + y)
            let F_lin(x, y) = (
              -b_val * (x - H_star) + 0.3 * (y - A_star),
              (-20 / (3 * b_val)) * (x - H_star) + 1 * (y - A_star),
            )
            let xlim = (-2, 20)
            let ylim = (-5, 55)
            set align(center)
            vector_field(
              F_orig,
              xlim: xlim,
              ylim: ylim,
              spacing: (1.3, 3.5),
              scale_segments: 12,
              width: 5cm,
              height: 5cm,
              xaxis: (position: 0, tip: tiptoe.stealth, ticks: none, subticks: none),
              yaxis: (position: 0, tip: tiptoe.stealth, ticks: none, subticks: none),
              title: [Original ($b = 1.2$) #v(.3em)],
            )
            h(1em)
            vector_field(
              F_lin,
              xlim: xlim,
              ylim: ylim,
              spacing: (1.3, 3.5),
              scale_segments: 12,
              width: 5cm,
              height: 5cm,
              xaxis: (position: 0, tip: tiptoe.stealth, ticks: none, subticks: none),
              yaxis: (position: 0, tip: tiptoe.stealth, ticks: none, subticks: none),
              title: [Linearization ($b = 1.2$) #v(.3em)],
            )
          }
          Near $arrow(E)^*$, the two phase portraits look very similar — the linearization captures
          the local behavior well. Far from $arrow(E)^*$, they diverge: the linearization does not
          reproduce the unstable-and-not-repelling behavior at the origin or the nonlinear behavior
          for large $H$.
        ]
      + Analyze the nature of the equilibrium solution in part @ex:affine-approx-part3[] using eigen
        techniques. Relate your analysis to the original system.
        #solution[
          For $M = mat(-b, 0.3; -20 / (3 b), 1)$:
          $
            "tr"(M) = 1 - b, wide det(M) = -b dot 1 - 0.3 dot (-20 / (3 b)) = -b + 2 / b.
          $
          For the eigenvalues to have negative real part we need $"tr"(M) < 0$ and $det(M) > 0$:
          $
            "tr"(M) < 0 & arrow.r.double b > 1, \
             det(M) > 0 & arrow.r.double 2 / b > b arrow.r.double b^2 < 2 arrow.r.double b < sqrt(2).
          $
          So for $1 < b < sqrt(2)$, both conditions hold and the linearized equilibrium is *stable
          and attracting*. By the Classification via Linearization theorem, the original equilibrium
          $arrow(E)^*$ is also *attracting* for $1 < b < sqrt(2)$.

          For $b < 1$: $"tr"(M) > 0$ → unstable. For $b > sqrt(2)$: $det(M) < 0$ → unstable.
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

      #slides_only(v(1em))

      Define $arrow(F)(x, y) = mat(y; - x y + x^2 - x - y)$ and consider the differential equation
      $ mat(x'; y') = arrow(F)(x, y). $

      + Make a phase portrait for this differential equation. Based on your phase portrait, can you
        determine the nature of the equilibrium at $(0, 0)$?

        #link("https://www.desmos.com/calculator/peby3xd7jj")

        #solution[
          #{
            set align(center)
            vector_field(
              ((x, y) => (y, -x * y + x * x - x - y)),
              xlim: (-1.5, 1.5),
              ylim: (-1.5, 1.5),
              spacing: (.2, .2),
              scale_segments: 8,
              width: 5cm,
              height: 5cm,
              xaxis: (position: 0, tip: tiptoe.stealth, ticks: none, subticks: none),
              yaxis: (position: 0, tip: tiptoe.stealth, ticks: none, subticks: none),
            )
          }
          The arrows near the origin appear to spiral inward, suggesting the equilibrium at $(0, 0)$
          is attracting. However, it is difficult to distinguish a spiral from a center from a phase
          portrait alone; analytic confirmation is needed.
        ]
      + Find an affine approximation to $arrow(F)$ centered at $(0, 0)$.
        #solution[
          With $F_1(x, y) = y$ and $F_2(x, y) = -x y + x^2 - x - y$, the total derivative is
          $
            D_(arrow(F))(x, y) = mat(
              0, 1;
              -y + 2 x - 1, -x - 1
            ).
          $
          At $(0, 0)$: $D_(arrow(F))(0, 0) = mat(0, 1; -1, -1)$ and $arrow(F)(0, 0) = mat(0; 0)$.

          The affine approximation is
          $
            arrow(F)(x, y) approx mat(0, 1; -1, -1) mat(x; y).
          $
        ]
      + Write down a differential equation that approximates the original equation near $(0, 0)$.
        #solution[
          $
            mat(x'_"approx"; y'_"approx") = mat(0, 1; -1, -1) mat(x_"approx"; y_"approx"),
          $
          i.e., $x'_"approx" = y_"approx"$ and $y'_"approx" = -x_"approx" - y_"approx"$.
        ]
      + Analyze the nature of the equilibrium solution $arrow(r)(t) = (0, 0)$ using eigen
        techniques. (You may use a computer to assist in eigen computations.) Relate your analysis
        to the original system.
        #solution[
          For $M = mat(0, 1; -1, -1)$, the characteristic polynomial is
          $
            det(M - lambda I) = det mat(-lambda, 1; -1, -1 - lambda)
            = lambda(1 + lambda) + 1 = lambda^2 + lambda + 1 = 0.
          $
          The eigenvalues are
          $
            lambda = (-1 plus.minus sqrt(1 - 4)) / 2 = -1 / 2 plus.minus i sqrt(3) / 2.
          $
          The real part is $-1 / 2 < 0$, so the linearized equilibrium is *stable and attracting*.
          By the Classification via Linearization theorem, the original equilibrium $(0, 0)$ is also
          *attracting*.
        ]


    ]
  })
}
