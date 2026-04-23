#import "../libs/lib.typ": *
#import "definitions.typ": show_def
#show: e.prepare(question)

#let OO = $upright(bold("O"))$

#{
  lesson(title: [Introduction to Stability], include "lesson-week-04.typ")
  question({
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
          The smallest possible "curve" is a single point, obtained by starting at an equilibrium
          initial condition.

          For this system, that happens at $(F, R) = (0, 0)$ and $(F, R) = (11, 110)$. At either of
          these initial conditions, the populations stay constant in time.
        ]
      + What should $F'$ and $R'$ be if $F$ and $R$ are _equilibrium solutions_?
        #solution[
          At an equilibrium solution, neither population changes, so both derivatives must be zero:
          $
            F' = 0 quad "and" quad R' = 0.
          $
        ]
      + How many equilibrium solutions are there for the fox-and-rabbit system? Justify your answer.
        #solution[
          There are two equilibrium solutions.

          From
          $
            F' = (0.01 R - 1.1) F
          $
          we need $F = 0$ or $R = 110$. From
          $
            R' = (1.1 - 0.1 F) R
          $
          we need $R = 0$ or $F = 11$. Intersections give
          $
            (F, R) = (0, 0) "and" (11, 110).
          $
        ]
      + What do the equilibrium solutions look like in the phase plane? What about their component
        graphs?
        #solution[
          In the phase plane, equilibria appear as fixed points (single points with no motion).

          In component graphs, they appear as constant functions of time: both $F(t)$ and $R(t)$ are
          horizontal lines.
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

      Use $k = 1.1$, $R = 1$, and $R_i = 0.1$ unless instructed otherwise.

      + What are the equilibrium solutions for model #OO?
        #solution[
          Model #OO is
          $
            P' = 1.1 P (1 - 0.1 P).
          $
          Equilibria satisfy $P' = 0$, so
          $
            P = 0 "or" 1 - 0.1 P = 0.
          $
          Thus the equilibrium solutions are
          $
            P(t) = 0 quad "and" quad P(t) = 10.
          $
        ]
      + What does a "phase plane" for model #OO look like? What do graphs of equilibrium solutions
        look like?
        #solution[
          Since this is a 1D model, the phase portrait is a line of $P$-values with equilibrium
          points marked at $0$ and $10$.

          The component graphs of equilibrium solutions are horizontal lines: $P(t)=0$ and
          $P(t)=10$.
        ]
      + Classify the behaviour of solutions that lie _between_ the equilibrium solutions. E.g., are
        they increasing, decreasing, oscillating?
        #solution[
          If $0 < P < 10$, then $P > 0$ and $(1 - 0.1 P) > 0$, so $P' > 0$. Therefore those
          solutions increase.

          They do not oscillate. They increase toward the carrying capacity $P=10$.
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

      + Draw an example of what solutions might look like if $f$ is _attracting_.
        #solution[
          For an attracting equilibrium at $f(t)=1$, nearby solutions move toward $1$ as time
          increases. So curves starting slightly above and below $1$ both approach the horizontal
          line $y=1$.
        ]
      + Draw an example of what solutions might look like if $f$ is _repelling_.
        #solution[
          For a repelling equilibrium at $f(t)=1$, nearby solutions move away from $1$ as time
          increases. Curves starting near $y=1$ separate from that horizontal line in forward time.
        ]
      + Draw an example of what solutions might look like if $f$ is _stable_.
        #solution[
          For a stable equilibrium, solutions that start close to $y=1$ stay close for all future
          time. A sketch should show trajectories remaining in a narrow band around $y=1$.
        ]
      + Could $f$ be stable but _not_ attracting?
        #solution[
          Yes.

          Example: $y' = 0$. Every solution is constant, so if you start near $y=1$, you stay near
          $y=1$ (stable), but you do not move toward $1$ unless you started at $1$ (not attracting).
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
          With $k=1.1 > 0$, model #OO is
          $
            P' = 1.1 P (1 - 0.1 P).
          $
          Equilibria are $P=0$ and $P=10$.

          - Near $P=0$, solutions with small positive $P$ increase away from $0$, so $P=0$ is
            repelling (unstable).
          - Near $P=10$, solutions move toward $10$ from above and below (within the physical
            region), so $P=10$ is attracting (stable).
        ]
      + Does changing $k$ change the nature of the equilibrium solutions? How can you tell?
        #solution[
          Changing the magnitude of $k$ changes the speed of motion, but not the equilibrium
          locations (still $P=0$ and $P=10$).

          For $k>0$, the classification stays the same ($0$ repelling, $10$ attracting). If the sign
          of $k$ were reversed, the arrows reverse and the classifications swap.
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
          At $(5,3)$, the slope is
          $
            m = 1.1 dot 3 dot (1 - 0.1 dot 3) = 2.31.
          $
          So the tangent-line segment should lie on
          $
            y - 3 = 2.31(x - 5).
          $
        ]
      + How can you recognize equilibrium solutions in a slope field?
        #solution[
          Equilibrium solutions occur at $y$-values where the slope is always zero, so they appear
          as horizontal bands of zero-slope line segments across all $x$.

          For model #OO, these are $y=0$ and $y=10$.
        ]
      + Give qualitative descriptions of different solutions to the _differential equation_ used in
        model #OO (i.e., use words to describe them). Do all of those solutions make sense in terms
        of _model #(OO)_?
        #solution[
          Qualitatively:
          - If $0 < P(0) < 10$, the solution increases toward $10$.
          - If $P(0) > 10$, the solution decreases toward $10$.
          - If $P(0)=0$ or $P(0)=10$, the solution is constant.
          - If $P(0)<0$, the differential equation still has a solution, but it stays negative and
            is not meaningful as a population.

          So not every differential-equation solution is physically meaningful for the starfish
          model; we usually restrict to $P(t) >= 0$.
        ]

    ]
  })
}
