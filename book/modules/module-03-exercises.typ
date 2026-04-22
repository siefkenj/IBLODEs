#import "../libs/lib.typ": *
#import "definitions.typ": show_def
#show: e.prepare(question)

#{
  lesson(title: [Systems of ODEs], include "lesson-week-03.typ")
  question({
    learning_objectives(
      [???],
    )
    notes[???]
    slide[
      A simple model for population growth has the form
      $
        P'(t) = b dot P(t)
      $
      where $b$ is the birth rate.

      + Create a better model for population that includes both births and deaths.
        #solution[
          A simple improvement is to include a per-capita death rate $d$.
          $
            P'(t) = (b - d) P(t), quad b,d >= 0.
          $
          Equivalently, if $B(t)=b P(t)$ and $D(t)=d P(t)$, then
          $
            P'(t) = B(t) - D(t).
          $
        ]

    ]
  })

  book_only(pagebreak())
  question.with(label: <ex:LV_model>)({
    learning_objectives(
      [???],
    )
    notes[???]
    slide[
      _Lotka-Volterra Predator-Prey_ models predict two populations, $F$ (foxes) and $R$ (rabbits),
      simultaneously. They take the form
      $
        F'(t) & = (B_F - D_F) dot F(t) \
        R'(t) & = (B_R - D_R) dot R(t)
      $
      where $B_(space.thin ?)$ stands for births and $D_(space.thin ?)$ stands for deaths.

      We will assume:
      #aligned_terms(
        terms.item($("P"_("foxes 1"))$, [Foxes die at a constant rate.]),
        terms.item($("P"_("foxes 2"))$, [Foxes mate when food is plentiful.]),
        terms.item($("P"_("rabbits"))$, [Rabbits mate at a constant rate.]),
        terms.item($("P"_("predation"))$, [Foxes eat rabbits.]),
      )


      + Speculate on when $B_F$, $D_F$, $B_R$, and $D_R$ would be at their maximum(s)/minimum(s),
        given our assumptions.
        #solution[
          Under the assumptions, we expect:
          - $D_F$ (fox deaths) to be largest when $F$ is large and smallest when $F=0$.
          - $B_R$ (rabbit births) to be largest when $R$ is large and smallest when $R=0$.
          - $B_F$ (fox births) to be largest when both $F$ and $R$ are large, and smallest when
            either population is $0$.
          - $D_R$ (rabbit deaths from predation) to be largest when both $F$ and $R$ are large, and
            smallest when either population is $0$.
        ]
      + Come up with appropriate formulas for $B_F$, $B_R$, $D_F$, and $D_R$.
        #solution[
          A standard Lotka-Volterra choice is
          $
            B_F = alpha F R, quad D_F = gamma F, quad B_R = beta R, quad D_R = delta F R,
          $
          where $alpha,beta,gamma,delta > 0$ are constants.

          Then
          $
            F' = (alpha R - gamma) F, quad R' = (beta - delta F) R.
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
      Suppose the population of $F$ (foxes) and $R$ (rabbits) evolves over time following the rule
      $
        F'(t) & = (0.01 dot R(t) - 1.1) dot F(t) \
        R'(t) & = (1.1 - 0.1 dot F(t)) dot R(t)
      $

      + Simulate the population of foxes and rabbits with a spreadsheet.
        #solution[
          Using Euler's method with a small step size (for example, $Delta = 0.05$), simulations
          show oscillating fox and rabbit populations over time.
        ]
      + Do the populations continue to grow/shrink forever? Are they cyclic?
        #solution[
          The simulation suggests the populations are cyclic rather than monotone. They rise and
          fall repeatedly.
        ]
      + Should the humps/valleys in the rabbit and fox populations be in phase? Out of phase?
        #solution[
          They should be out of phase. Rabbit peaks typically happen first, then fox peaks follow
          after a delay because fox growth depends on rabbit availability.
        ]
    ]
  })

  book_only(pagebreak())
  question.with(label: <ex:fox_and_rabbit>)({
    learning_objectives(
      [???],
    )
    notes[???]
    slide(force_scale: 0.95em)[
      // https://utoronto-my.sharepoint.com/:x:/g/personal/jason_siefken_utoronto_ca/Eay4QOMvy7lNr5pOKRv22NgBLGUw7qMpSCShUjeAdrhsHQ?e=bpg4CP
      Open and make a copy of the spreadsheet

      #align(center, link("https://uoft.me/foxes-and-rabbits")[https://uoft.me/foxes-and-rabbits])

      which contains an Euler approximation for the Foxes and Rabbits population.
      $
        F'(t) & = (0.01 dot R(t) - 1.1) dot F(t) \
        R'(t) & = (1.1 - 0.1 dot F(t)) dot R(t)
      $

      + Simulate the rabbit population using different step sizes $Delta$.
        + Does the choice of $Delta$ affect the qualitative "shape" of the population curve?
          #solution[
            Yes. For small $Delta$, the oscillatory shape is similar, but for larger $Delta$ the
            curve is visibly distorted and may look more spiral-like across cycles.
          ]
        + Does it affect the height of the peaks and valleys?
          #solution[
            Yes. The estimated peak and valley heights change with $Delta$.
          ]
        + Does it affect the _time_ when the peaks and valleys occur?
          #solution[
            Yes. The estimated times of peaks and valleys shift as $Delta$ changes.
          ]
      + We want to know about the peaks and valleys of the _exact_ population curve for rabbits.

        Do your simulations consistently under or over estimate the population of rabbits?
        #solution[
          No. Euler simulations are not consistently above or below the exact rabbit curve over all
          times; the sign of the error can change during the cycle.
        ]
      + Let $p_1$ and $p_2$ be the first and second local maxima for the (exact) rabbit population.
        Is $p_1$ bigger, smaller, or equal to $p_2$? Justify with numerical evidence.
        #solution[
          They are equal for the exact Lotka-Volterra model (periodic orbit). Numerically, using
          smaller $Delta$ values, the first two rabbit peaks get closer and closer to the same
          value, with differences attributable to discretization error.
        ]
    ]
  })

  book_only(pagebreak())
  question({
    learning_objectives(
      [???],
    )
    notes[???]
    slide(force_scale: 0.77em)[
      Open and make a copy of the spreadsheet

      #align(center, link("https://uoft.me/foxes-and-rabbits")[https://uoft.me/foxes-and-rabbits])

      which contains an Euler approximation for the Foxes and Rabbits population.
      $
        F'(t) & = (0.01 dot R(t) - 1.1) dot F(t) \
        R'(t) & = (1.1 - 0.1 dot F(t)) dot R(t)
      $

      #show_def("component_and_phase")

      + Plot the Fox vs. Rabbit population in the phase plane.
        #solution[
          Plot points $(F(t), R(t))$ with foxes on the horizontal axis and rabbits on the vertical
          axis, then connect points in increasing time order.
        ]
      + Should your plot show a closed curve or a spiral?
        #solution[
          For the exact model, it should be a closed curve. With Euler simulation, you often see a
          slight spiral (typically outward for larger $Delta$) due to numerical error.
        ]
      + What “direction” do points move along the curve as time increases? Justify by referring to
        the model.
        #solution[
          With the standard initial data in the spreadsheet, trajectories move counterclockwise in
          the phase plane. At $(F,R)=(10,100)$, we have
          $
            F'=(0.01 dot 100 - 1.1) dot 10 < 0, quad R'=(1.1 - 0.1 dot 10) dot 100 > 0,
          $
          so motion starts up-and-left.
        ]
      + What is easier to see from plots in the phase plane than from component graphs (the graphs
        of fox and rabbit population vs. time)?
        #solution[
          Phase plots make cycle geometry and predator-prey interaction easier to see: closed
          orbits, relative lag, and how population size pairs $(F,R)$ evolve together.
        ]
    ]
  })
}
