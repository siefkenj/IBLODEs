#import "../libs/_workbook.typ": aligned_terms, label_core_exercise, simple_table
#import "../libs/_ode_solvers.typ": solve_1d_ivp
#import "../libs/_graphics.typ": slope_field
#import "@preview/lilaq:0.4.0" as lq
#import "@preview/tiptoe:0.3.1"

#let MM = $upright(bold("M"))$
#let SS = $upright(bold("S"))$
#let infty = math.infinity

#let setup(env) = {
  let (sans, serif, slide, restrict, question, definition, solution: _solution, show_def) = env
  let slides_only = restrict.with(when: ("slides", "slides-solutions"))
  let book_only = restrict.with(when: ("book", "guide", "book-solutions"))
  let guide_only = restrict.with(when: "guide")
  let solution = content => restrict(
    when: ("guide", "book-solutions", "slides-solutions"),
    _solution(content),
  )


  question(
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
      + Can you rewrite the system in matrix/affine form? Why or why not?


    ],
  )

  let LL = $upright(bold("L"))$
  book_only(pagebreak())
  question(
    slide[

      #label_core_exercise(<ex:linear_approx_1d>)

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

      + Notice that $(dif P)/(dif t)=f(P(t))$. Use this observation to create a "simple" model
        $LL_(1/2)$ that approximates $LL$ when $P approx 1/2$.

      + Model $LL_(1/2)$ is called an _affine approximation of model $LL$ centered at $P=1/2$_.

        Find additional affine approximations to model $LL$ centered at each equilibrium solution.

    ],
  )


  book_only(pagebreak())
  question(
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
      + Does the nature of the equilibrium solutions change when using an affine approximation?
      + Classify each equilibrium solution of the original equation by using affine approximations.

    ],
  )

  book_only(pagebreak())
  question(
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
      + Use affine approximations to classify the equilibrium solutions as stable/unstable/etc.


    ],
  )

  book_only(pagebreak())
  question({
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

    slide(force_scale: 0.907em)[

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

      #book_only(pagebreak())
      + Find the matrix for $D_(arrow(F))$, the total derivative of $arrow(F)$.
      + Create an affine approximation to $arrow(F)$ around $arrow(e) = (0, 0)$ and use this to
        write an approximation to the original system.
      + In the original system, the equilibrium $(0, 0)$ is unstable and not repelling. Justify this
        using your affine approximation.
      + #label_core_exercise(<ex:affine-approx-part3>)
        Create an affine approximation to $arrow(F)$ around $arrow(e) = (100 / 9 b, 1000 / 27 b^2)$
        and use this to write an approximation to the original system.
      + Make a phase portrait for the original system and your approximation from part
        @ex:affine-approx-part3[]. How do they compare?
      + Analyze the nature of the equilibrium solution in part @ex:affine-approx-part3[] using eigen
        techniques. Relate your analysis to the original system.

    ]
  })


  book_only(pagebreak())
  question(
    slide[

      #slides_only(v(1em))

      Define $arrow(F)(x, y) = mat(y; - x y + x^2 - x - y)$ and consider the differential equation
      $ mat(x'; y') = arrow(F)(x, y). $

      + Make a phase portrait for this differential equation. Based on your phase portrait, can you
        determine the nature of the equilibrium at $(0, 0)$?

        #link("https://www.desmos.com/calculator/peby3xd7jj")

      + Find an affine approximation to $arrow(F)$ centered at $(0, 0)$.
      + Write down a differential equation that approximates the original equation near $(0, 0)$.
      + Analyze the nature of the equilibrium solution $arrow(r)(t) = (0, 0)$ using eigen
        techniques. (You may use a computer to assist in eigen computations.) Relate your analysis
        to the original system.


    ],
  )
}
