#import "../libs/lib.typ": *
#import "definitions.typ": show_def
#show: e.prepare(question)
#show ref: allow_missing_refs

#let OO = $upright(bold("O"))$

#{
  lesson(title: [Introduction to Stability], include "lesson-week-04.typ")
  question(label: <ex:LV_equilibrium>, {
    learning_objectives(
      [???],
    )
    notes[???]
    slide(force_scale: .95em)[
      Open and make a copy of the spreadsheet

      #align(center, link("https://uoft.me/foxes-and-rabbits")[https://uoft.me/foxes-and-rabbits])

      which contains an Euler approximation for the Foxes and Rabbits population.
      $
        F'(t) & = (0.01 dot R(t) - 1.1) dot F(t) \
        R'(t) & = (1.1 - 0.1 dot F(t)) dot R(t)
      $

      #show_def("equilibrium_solution")

      + By changing initial conditions, what is the "smallest" curve you can get in the phase plane?
        What happens at those initial conditions?
        #solution[
          The smallest possible curve is a single point. Starting with initial conditions
          $(F, R) = (11, 110)$, the rabbit and fox populations remain constant.
        ]
      + What should $F'$ and $R'$ be if $F$ and $R$ are _equilibrium solutions_?
        #solution[
          At an equilibrium solution, neither population changes, so both derivatives must be zero:
          $F' = 0$ and $R' = 0$.
        ]
      + How many equilibrium solutions are there for the fox-and-rabbit system? Justify your answer.
        #solution[
          There are two equilibrium solutions.

          From
          $
            F' = (0.01dot R - 1.1) F
          $
          we get $F = 0$ or $R = 110$.

          From
          $
            R' = (1.1 - 0.1dot F) R
          $
          we get $R = 0$ or $F = 11$.

          Thus
          $
            (F, R) = (0, 0) wide "or" wide (F,R) = (11, 110).
          $
        ]
      + What do the equilibrium solutions look like in the phase plane? What about their component
        graphs?
        #solution[
          In the phase plane, equilibria appear as single points.

          As component graphs, they appear as horizontal lines.
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

      Recall the logistic model for starfish growth (introduced in @ex:models_MNO):
      #aligned_terms(
        terms.item(
          OO,
          [\# new children per year $~$ current population times the fraction of total resources
            remaining],
        ),
      )

      which can be modeled with the equation
      $
        P'(t) = k dot P(t) dot (1 - R_i / R dot P(t))
      $

      where
      - $P(t)$ is the population at time $t$
      - $k$ is a constant of proportionality
      - $R$ is the total number of resources
      - $R_i$ is the resources that one starfish wants to consume

      For this question, use $k = 1.1$, $R = 1$, and $R_i = 0.1$.

      + What are the equilibrium solutions for model #OO?
        #solution[
          Solving $P' = 1.1 P (1 - 0.1 dot P)=0$, we get $P'=0$ when $P = 0$ or $1 - 0.1 dot P = 0$,
          that is $P=10$.

          Thus the equilibrium solutions are
          $
            P(t) = 0 quad "and" quad P(t) = 10.
          $
        ]
      + What does a "phase plane" for model #OO look like? What do graphs of equilibrium solutions
        look like?
        #solution[
          A phase plane for model $OO$ looks like a line, since there is only one dependent variable
          (population). Equilibrium solutions still appear as dots along that line.
        ]
      + Classify the behaviour of solutions that lie _between_ the equilibrium solutions. E.g., are
        they increasing, decreasing, oscillating?
        #solution[
          If $0 < P < 10$, then $P' > 0$, so solutions that start with a population between $0$ and
          $10$ increase. If $P > 10$, then $P' < 0$, so solutions that start with a population above
          $10$ decrease. Lastly, it makes no sense to have a negative population, but considered in
          the abstract, if $P < 0$, then $P' < 0$, so solutions that start with a "negative
          population" decrease.
        ]
    ]
  })

  book_only(pagebreak())
  question({
    learning_objectives(
      [???],
    )
    notes[???]
    slides_only(
      slide(force_scale: 0.75em)[
        #show_def("equilibrium_classification_informal")
        #show_def("equilibrium_classification_formal")
      ],
    )
    slide(force_scale: 0.95em)[
      #show_def("equilibrium_classification_informal")

      #slides_only(colbreak())
      Let
      $
        F'(t) = class("normal", ?)
      $
      be an unknown differential equation with equilibrium solution $f(t) = 1$.

      #let ts = lq.linspace(0, 4, num: 80)
      #let ts_short = lq.linspace(0, 2, num: 80)
      #let eq_stroke = (thickness: 1.5pt, paint: green.darken(30%))
      #let nearby_stroke = (
        thickness: .6pt,
        paint: black,
        dash: (2pt, 1pt),
      )

      + Draw an example of what solutions might look like if $f$ is _attracting_.
        #solution[
          #align(center, lq.diagram(
            width: 5.5cm,
            xaxis: (label: [$t$], ticks: none),
            yaxis: (label: [$y$], tick-distance: .5),
            xlim: (0, 4),
            ylim: (0, 2),
            lq.plot(
              ts,
              ts.map(t => 1 + .7 * calc.exp(-1.4 * t)),
              mark: none,
              stroke: nearby_stroke,
            ),
            lq.plot(
              ts,
              ts.map(t => 1 + .35 * calc.exp(-1.1 * t)),
              mark: none,
              stroke: nearby_stroke,
            ),
            lq.plot(
              ts,
              ts.map(t => 1 - .35 * calc.exp(-1.1 * t)),
              mark: none,
              stroke: nearby_stroke,
            ),
            lq.plot(
              ts,
              ts.map(t => 1 - .7 * calc.exp(-1.4 * t)),
              mark: none,
              stroke: nearby_stroke,
            ),
            lq.plot(ts, ts.map(t => 1), mark: none, stroke: eq_stroke),
          ))
        ]
      + Draw an example of what solutions might look like if $f$ is _repelling_.
        #solution[
          #align(center, lq.diagram(
            width: 5.5cm,
            xaxis: (label: [$t$], ticks: none),
            yaxis: (label: [$y$], tick-distance: .5),
            xlim: (0, 2),
            ylim: (0, 2),
            lq.plot(
              ts_short,
              ts_short.map(t => 1 + .08 * calc.exp(t)),
              mark: none,
              stroke: nearby_stroke,
            ),
            lq.plot(
              ts_short,
              ts_short.map(t => 1 + .15 * calc.exp(t)),
              mark: none,
              stroke: nearby_stroke,
            ),
            lq.plot(
              ts_short,
              ts_short.map(t => 1 - .08 * calc.exp(t)),
              mark: none,
              stroke: nearby_stroke,
            ),
            lq.plot(
              ts_short,
              ts_short.map(t => 1 - .12 * calc.exp(t)),
              mark: none,
              stroke: nearby_stroke,
            ),
            lq.plot(ts_short, ts_short.map(t => 1), mark: none, stroke: eq_stroke),
          ))
        ]
      + Draw an example of what solutions might look like if $f$ is _stable_.
        #solution[
          #align(center, lq.diagram(
            width: 5.5cm,
            xaxis: (label: [$t$], ticks: none),
            yaxis: (label: [$y$], tick-distance: .5),
            xlim: (0, 4),
            ylim: (0, 2),
            lq.plot(
              ts,
              ts.map(t => 1 + .7 * calc.exp(-1.4 * t)),
              mark: none,
              stroke: nearby_stroke,
            ),
            lq.plot(
              ts,
              ts.map(t => 1 + .35 * calc.exp(-1.1 * t)),
              mark: none,
              stroke: nearby_stroke,
            ),
            lq.plot(
              ts,
              ts.map(t => 1 - .35 * calc.exp(-1.1 * t)),
              mark: none,
              stroke: nearby_stroke,
            ),
            lq.plot(
              ts,
              ts.map(t => 1 - .7 * calc.exp(-1.4 * t)),
              mark: none,
              stroke: nearby_stroke,
            ),
            lq.plot(ts, ts.map(t => 1), mark: none, stroke: eq_stroke),
          ))
          or
          #align(center, lq.diagram(
            width: 5.5cm,
            xaxis: (label: [$t$], ticks: none),
            yaxis: (label: [$y$], tick-distance: .5),
            xlim: (0, 4),
            ylim: (0, 2),
            lq.plot(ts, ts.map(t => 1.35), mark: none, stroke: nearby_stroke),
            lq.plot(ts, ts.map(t => 1.15), mark: none, stroke: nearby_stroke),
            lq.plot(ts, ts.map(t => .85), mark: none, stroke: nearby_stroke),
            lq.plot(ts, ts.map(t => .65), mark: none, stroke: nearby_stroke),
            lq.plot(ts, ts.map(t => 1), mark: none, stroke: eq_stroke),
          ))

          Here solutions near $y=1$ stay close to $y=1$ for all future time.
        ]
      + Could $f$ be stable but _not_ attracting?
        #solution[
          Yes.

          #align(center, lq.diagram(
            width: 5.5cm,
            xaxis: (label: [$t$], ticks: none),
            yaxis: (label: [$y$], tick-distance: .5),
            xlim: (0, 4),
            ylim: (0, 2),
            lq.plot(ts, ts.map(t => 1.35), mark: none, stroke: nearby_stroke),
            lq.plot(ts, ts.map(t => 1.15), mark: none, stroke: nearby_stroke),
            lq.plot(ts, ts.map(t => .85), mark: none, stroke: nearby_stroke),
            lq.plot(ts, ts.map(t => .65), mark: none, stroke: nearby_stroke),
            lq.plot(ts, ts.map(t => 1), mark: none, stroke: eq_stroke),
          ))

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

      #slides_only(show_def("equilibrium_classification_informal"))

      #slides_only(colbreak())
      Recall the starfish population model #OO given by
      $ P'(t) = k dot P(t) dot (1 - R_i / R dot P(t)) $
      Use $k = 1.1$, $R = 1$, and $R_i = 0.1$ unless instructed otherwise.

      + Classify the equilibrium solutions for model #OO as attracting, repelling, stable, or
        unstable.
        #solution[
          Substituting in the values of $k$, $R$, and $R_i$, we see
          $P' = 1.1 dot P (1 - 0.1 dot P)$. Notice $P'=0$ when $P=0$ or $P=10$, and so these are the
          equilibrium solutions.

          *Case $P=10$*:

          If $P$ is slightly above $10$, then $P'$ is negative, so a solution starting at $P > 10$
          will decrease toward $10$.

          If $P$ is slightly below $10$, then $P'$ is positive, so a solution starting at $P < 10$
          will increase toward $10$.

          Thus solutions near $P=10$ move toward $10$, so $P=10$ is stable and attracting.

          *Case $P=0$*:

          Since we cannot have negative population, it only makes sense to consider solutions that
          start with $P>0$ when classifying the equilibrium $P=0$.

          If $P$ is slightly above $0$, then $P'$ is positive, so a solution starting at $P > 0$
          will increase away from $0$.

          Thus, $P=0$ is unstable and repelling.
        ]
      + Does changing $k$ change the nature of the equilibrium solutions? How can you tell?
        #solution[
          As long as $k>0$, the nature of the equilibrium solutions does not change (because the
          derivatives used in the arguments for stability/instability won't change sign).
        ]

    ]
  })

  book_only(pagebreak())
  question.with(label: <ex:O_slope_field>)({
    learning_objectives(
      [???],
    )
    notes[???]
    slide(force_scale: 0.83em)[

      #slides_only(v(1em))

      #let F(x, y) = 1.1 * y * (1 - 0.1 / 1 * y)
      #align(
        center,
        slope_field(
          F,
          xlim: (-3, 20),
          ylim: (-6.2, 15),
          spacing: 1.1,
          width: 7cm,
          height: 5cm,
          scale_segments: 1.5,
        ),
      )

      A _slope field_ is a plot of small segments of tangent lines to solutions of a differential
      equation at different initial conditions.

      On the left is a slope field for model #OO, available at

      #link("https://www.desmos.com/calculator/ghavqzqqjn")

      + If you were sketching the slope field for model #OO by hand, what (straight) line would you
        sketch a segment of at $(5, 3)$? Write an equation for that line.
        #solution[
          At $(t, P) = (5,3)$, the slope is
          $
            P' = 1.1 dot 3 dot (1 - 0.1 dot 3) = 2.31.
          $
          So the tangent-line segment should lie on
          $
            y = 2.31(x - 5) + 3.
          $
        ]
      + How can you recognize equilibrium solutions in a slope field?
        #solution[
          Equilibrium solutions occur at $y$-values where the slope is always zero, so they appear
          as horizontal bands of zero-slope line segments. However, since not every point is given a
          line segment in a slope field, sometimes you need to interpolate, looking for places that
          the slopes change sign, and predicting that between those places, the slope must be zero.
        ]
      + Give qualitative descriptions of different solutions to the _differential equation_ used in
        model #OO (i.e., use words to describe them). Do all of those solutions make sense in terms
        of _model #(OO)_?
        #solution[
          Qualitatively:
          - If $0 < P(0) < 10$, solutions are "S"-shaped and increase toward $10$.
          - If $P(0) > 10$, solutions are "L"-shaped and decrease toward $10$.
          - If $P(0)=0$ or $P(0)=10$, the solutions are constant (horizontal lines).
          - If $P(0)<0$, the differential equation still has a solution, that curve downward.

          Only solutions with $P>=0$ make sense in the context of model $OO$.
        ]

    ]
  })
}
