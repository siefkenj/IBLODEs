#import "../libs/lib.typ": *
#import "definitions.typ": show_def
#show: e.prepare(question)
#show ref: allow_missing_refs

#let OO = $upright(bold("O"))$

#{
  lesson(title: [Phase Portraits], include "lesson-week-05.typ")
  book_only(pagebreak())
  question({
    learning_objectives(
      [???],
    )
    notes[???]
    slide[
      #align(
        center,
        block(breakable: false)[
          #image("../images/slope-field-3d.png", width: 2in)

          #v(-7pt)
          #link("https://www.desmos.com/3d/kvyztvmp0g")
        ],
      )

      Three dimensional slope fields are possible, but hard to interpret. This is a slope field for
      the Foxes--Rabbits model.


      + What are the three dimensions in the plot?
        #solution[
          Foxes, Rabbits, and time (vertically).
        ]
      + What should the graph of an equilibrium solution look like?
        #solution[
          The fox and rabbit populations will be constant, but time will continue to increase, so
          the graph will be a vertical line.
        ]
      + What should the graph of a typical solution look like?
        #solution[
          A typical solution should look like a spiral/helix spiralling upwards.
        ]
      + What are ways to simplify the picture so we can more easily analyze solutions?
        #solution[
          We could remove the time variable, and only plot fox and rabbit axes.
        ]

    ]
  })


  book_only(pagebreak())
  question({
    learning_objectives(
      [???],
    )
    notes[???]
    slide(force_scale: 0.87em)[

      //https://www.desmos.com/calculator/wdgtznxndp
      //
      // Without Euler's built in:
      // https://www.desmos.com/calculator/vrk0q4espx

      #let F(x, y) = ((0.01 * y - 1.1) * x, (1.1 - 0.1 * x) * y)

      #align(
        center,
        vector_field(
          F,
          xlim: (-5, 40),
          ylim: (-30, 310),
          spacing: (3, 19),
          scale_segments: 20.0,
          width: 6.5cm,
          height: 6.5cm,
          yaxis: (position: 0, tip: tiptoe.stealth, tick-distance: 50),
          xaxis: (position: 0, tip: tiptoe.stealth),
        ),
      )


      #show_def("phase_portrait")

      This is a phase portrait for the Foxes--Rabbits model (introduced in @ex:LV_model).

      #link("https://www.desmos.com/calculator/vrk0q4espx")


      + What do the $x$ and $y$ axes correspond to?
        #solution[
          The horizontal axis is fox population and the vertical axis is rabbit population.
        ]
      + Identify the equilibria in the phase portrait. What are the lengths of the vectors at those
        points?
        #solution[
          The equilibria occur when $F'=0$ and $R'=0$. We have already solved for those in
          @ex:LV_equilibrium, finding $(F,R)=(0,0)$ and $(F,R)=(11,110)$. At these points, the
          lengths of the vectors in a phase portrait will be zero.
        ]
      + Classify each equilibrium as stable/unstable.
        #solution[
          $(0,0)$ is unstable and not repelling. $(11,110)$ appears stable, but it is hard to tell
          from the phase portrait whether it is attracting or very subtly repelling.
        ]
      + Copy and paste data from your simulation spreadsheet into the Desmos plot. Does the
        resulting curve fit with the picture?
        #solution[
          Yes. The curve follows the arrows.
        ]
      // + Why is the vector at $(5,100)$ longer than the vector at $(10,100)$? Justify numerically.


    ]
  })


  book_only(pagebreak())
  question(label: <ex:exploring_equilibria>, {
    learning_objectives(
      [???],
    )
    notes[???]
    slide[

      // % https://www.desmos.com/calculator/wdgtznxndp
      // %
      // % Without Euler's built in:
      // % https://www.desmos.com/calculator/vrk0q4espx

      The unknown (continuous) system of differential equations $x'=...$, $y'=...$ has an
      _attracting_ equilibrium solution
      $
        x_"eq" (t) & =2 \
        y_"eq" (t) & =4
      $

      +
        + Sketch component graphs for the equilibrium solution.
          #solution[
            #let ts = lq.linspace(0, 4, num: 80)

            #align(center, stack(
              lq.diagram(
                width: 4cm,
                title: [$x$ Component],
                xaxis: (label: [$t$], ticks: none),
                yaxis: (label: [$x$], tick-distance: 1),
                xlim: (0, 4),
                ylim: (0, 5),
                lq.plot(ts, ts.map(t => 2), mark: none, stroke: (thickness: 1.3pt)),
              ),
              lq.diagram(
                width: 4cm,
                title: [$y$ Component],
                xaxis: (label: [$t$], ticks: none),
                yaxis: (label: [$y$], tick-distance: 1),
                xlim: (0, 4),
                ylim: (0, 5),
                lq.plot(ts, ts.map(t => 4), mark: none, stroke: (
                  thickness: 1.3pt,
                  dash: (3pt, 1pt),
                )),
              ),
              dir: ltr,
              spacing: 1em,
            ))
          ]
        + Sketch the equilibrium in _phase space_.
          #solution[
            #align(center, lq.diagram(
              width: 4cm,
              height: 4cm,
              xaxis: (label: [$x$], tick-distance: 1),
              yaxis: (label: [$y$], tick-distance: 1),
              xlim: (0, 5),
              ylim: (0, 5),
              lq.line((1.9, 4), (2.1, 4), stroke: (thickness: 1.5pt)),
              lq.line((2, 3.9), (2, 4.1), stroke: (thickness: 1.5pt)),
              lq.place(2.65, 4.2, $(2,4)$),
            ))
          ]
      + Suppose $(x(t),y(t))$ is a solution that satisfies $(x(0), y(0))=(3,3)$. Sketch a possible
        graph for this solution. Make sketches in both component and phase spaces.
        #solution[
          #let ts = lq.linspace(0, 4, num: 80)
          #let X(t) = 2 + calc.exp(-t)
          #let Y(t) = 4 - calc.exp(-t)

          #align(center, stack(
            lq.diagram(
              width: 4cm,
              title: [$x$ Component],
              xaxis: (label: [$t$], ticks: none),
              yaxis: (label: [$x$], tick-distance: 1),
              xlim: (0, 4),
              ylim: (0, 5),
              lq.plot(ts, ts.map(t => X(t)), mark: none, stroke: (thickness: 1.2pt)),
            ),
            lq.diagram(
              width: 4cm,
              title: [$y$ Component],
              xaxis: (label: [$t$], ticks: none),
              yaxis: (label: [$y$], tick-distance: 1),
              xlim: (0, 4),
              ylim: (0, 5),
              lq.plot(ts, ts.map(t => Y(t)), mark: none, stroke: (
                thickness: 1.2pt,
                dash: (3pt, 1pt),
              )),
            ),
            dir: ltr,
            spacing: 1em,
          ))

          #v(.7em)

          #align(center, lq.diagram(
            width: 5.5cm,
            title: [Phase Space],
            xaxis: (label: [$x$], tick-distance: .5),
            yaxis: (label: [$y$], tick-distance: .5),
            xlim: (1.9, 3.1),
            ylim: (2.9, 4.1),
            lq.plot(ts.map(t => X(t)), ts.map(t => Y(t)), mark: none, stroke: (thickness: 1.2pt)),
            lq.place(2.95, 3.05, $(3,3)$),
            lq.place(2.1, 3.95, $(2,4)$),
          ))
        ]
      + Draw a possible phase portrait for this system that agrees with your answer to the previous
        parts.
        #solution[
          #align(center, vector_field(
            ((x, y) => (2 - x, 4 - y)),
            xlim: (0, 5),
            ylim: (0, 5),
            spacing: (.6, .6),
            scale_segments: 15,
            width: 4.5cm,
            height: 4.5cm,
            xaxis: (position: 0, tip: tiptoe.stealth, label: [$x$], tick-distance: 1),
            yaxis: (position: 0, tip: tiptoe.stealth, label: [$y$], tick-distance: 1),
            lq.place(2.35, 4.2, $(2,4)$),
          ))
        ]
      + Sketch a phase portrait for a _new_ system of differential equations that has a repelling
        equilibrium solution.
        #solution[
          One example is $x'=x$, $y'=y$, which has a repelling equilibrium at $(0,0)$.

          #align(center, vector_field(
            ((x, y) => (x, y)),
            xlim: (-3, 3),
            ylim: (-3, 3),
            spacing: (.75, .75),
            scale_segments: 15,
            width: 5cm,
            height: 5cm,
            xaxis: (position: 0, tip: tiptoe.stealth),
            yaxis: (position: 0, tip: tiptoe.stealth),
          ))
        ]
      + Sketch a phase portrait for a _new_ system of differential equations that has no equilibrium
        solutions.
        #solution[
          One example is $x'=1$, $y'=1$, which has no point where both derivatives are zero.

          #align(center, vector_field(
            ((x, y) => (1, 1)),
            xlim: (-3, 3),
            ylim: (-3, 3),
            spacing: (.75, .75),
            scale_segments: 25,
            width: 5cm,
            height: 5cm,
            xaxis: (position: 0, tip: tiptoe.stealth),
            yaxis: (position: 0, tip: tiptoe.stealth),
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


      #slides_only(colbreak())
      // XXX put back link later; it breaks if the reference is not found.
      // Recall the #link(<ex:O_slope_field>)[slope field for model $OO$].
      Recall the slope field for model $OO$.

      + What would a phase portrait for model $OO$ look like? Draw it.
        #solution[
          Since model $OO$ has one dependent variable, the phase portrait would lie on a line.

          // XXX Make a figure here
        ]
      + Where are the arrows the longest? Shortest?
        #solution[
          The arrows are longest for very negative or very positive $>>10$ values.
        ]
      + How could you tell from a 1d phase portrait whether an equilibrium solution is
        attracting/repelling/etc.?
        #solution[
          Look at arrows on both sides of the equilibrium. If both point toward the equilibrium, it
          is attracting (and stable). If both point away, it is repelling (unstable). If one side
          points in and the other out, it is unstable but not repelling.
        ]
    ]
  })

  book_only(pagebreak())
  question.with(label: <ex:tree_model>)({
    learning_objectives(
      [???],
    )
    notes[???]
    slide[
      // Completed phase portrait in desmos:
      // https://www.desmos.com/calculator/tvjag852ja

      The following differential equation models the life cycle of a tree. In the model

      - $H(t) =$ height (in meters) of tree trunk at time $t$
      - $A(t) =$ surface area (in square meters) of all leaves at time $t$


      $
        H'(t) & = 0.3 dot.c A(t)-b dot.c H(t) \
        A'(t) & = -0.3 dot.c (H(t))^2 + A(t)
      $

      and $0 lt.eq b lt.eq 2$.

      #slides_only(colbreak())

      + Modify

        #link("https://www.desmos.com/calculator/vrk0q4espx")

        to make a phase portrait for the tree model.
        #label_question_part(<ex:tree_model_part1>)
        #solution[
          Make
          $
            X(x,y)=0.3 dot y - b dot x \
            Y(x,y)=-0.3 dot x^2 + y
          $
          and set the bounds of the slider for $b$ to be $0 <= b <= 2$.
        ]
      + What do equilibrium solutions mean in terms of tree growth?
        #solution[
          Equilibria mean that the tree is not changing in height and the leaf area of the tree is
          not changing.
        ]
      + For $b=1$ what are the equilibrium solution(s)?
        #solution[
          Solving for when $H'=0$ and $A'=0$, we see the equilibria are
          $
            (H,A) = (0,0) quad "and" quad (H,A) = (100/9, 1000/27).
          $
        ]

    ]
  })


  book_only(pagebreak())
  question(label: <ex:tree_modelling_with_spreadsheet>, {
    learning_objectives(
      [???],
    )
    notes[???]
    slide[

      #slides_only(
        block[
          The following differential equation models the life cycle of a tree. In the model

          - $H(t) =$ height (in meters) of tree trunk at time $t$
          - $A(t) =$ surface area (in square meters) of all leaves at time $t$


          $
            H'(t) & = 0.3 dot.c A(t)-b dot.c H(t) \
            A'(t) & = -0.3 dot.c (H(t))^2 + A(t)
          $

          and $0 lt.eq b lt.eq 2$.
        ],
      )


      + Fix a value of $b$ and use a spreadsheet to simulate some solutions with different initial
        conditions. Plot the results on your phase portrait from @ex:tree_model_part1[].
        #solution[
          For $b=1$, $Delta = 0.1$ and initial conditions $(H(0),A(0))=(10,17)$, we get:

          #{
            let b = 1.0
            let Delta = 0.1
            let H0 = 10.0
            let A0 = 17.0
            let F(H, A) = (0.3 * A - b * H, -0.3 * H * H + A)
            let sim = solve_2d_ivp(F, (H0, A0), 20, Delta: Delta, method: "euler")

            let cells = (
              "A1": "Delta",
              "A2": str(Delta),
              "A4": $H_0$,
              "A5": str(H0),
              "A6": $A_0$,
              "A7": str(A0),
              "B1": "H",
              "C1": "A",
              "D1": "H'",
              "E1": "A'",
            )

            for i in range(6) {
              let row = i + 2
              let H = sim.at(i).at(0)
              let A = sim.at(i).at(1)
              let H_prime = 0.3 * A - b * H
              let A_prime = -0.3 * H * H + A

              cells.insert("B" + str(row), str(calc.round(H, digits: 2)))
              cells.insert("C" + str(row), str(calc.round(A, digits: 2)))
              cells.insert("D" + str(row), str(calc.round(H_prime, digits: 2)))
              cells.insert("E" + str(row), str(calc.round(A_prime, digits: 2)))
            }

            align(center, draw_spreadsheet(cols: 5, rows: 7, cells: cells))

            v(.8em)

            align(center, vector_field(
              F,
              width: 6cm,
              height: 6cm,
              title: [Phase Portrait for $b=1$],
              xaxis: (position: 0, tip: tiptoe.stealth, label: [$H$], tick-distance: 5),
              yaxis: (position: 0, tip: tiptoe.stealth, label: [$A$], tick-distance: 10),
              xlim: (0, 21),
              ylim: (-5, 22),
              spacing: (1.5, 2.5),
              scale_segments: 10,
              lq.plot(
                sim.map(((H, A)) => H),
                sim.map(((H, A)) => A),
                mark: none,
                stroke: (thickness: 2.3pt),
              ),
            ))
          }

          This gives one Euler trajectory overlaid on the phase portrait.
        ]
      + What will happen to a tree with $(H(0), A(0))=(20,10)$? Does this depend on $b$?
        #solution[
          Both the tree height and the leaf area will initially decrease. Following the arrows in
          the phase portrait, we see that the leaf area will decrease to $0$ (and then the tree will
          die).

          This happens no matter the value of $b in [0,2]$.
        ]
      + What will happen to a tree with $(H(0), A(0))=(10,10)$? Does this depend on $b$?
        #solution[
          Again, initially the tree height and leaf area will both decrease. However for $b > 1.25$
          this decrease "turns around" before the tree is dead, and the height and leaf area
          increase again.
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
      The tree model
      $
        H'(t) & = 0.3 dot.c A(t)-b dot.c H(t) \
        A'(t) & = -0.3 dot.c (H(t))^2 + A(t)
      $

      was based on the premises

      #aligned_terms(
        terms.item($("P"_("height 1"))$, [$"CO"_2$ is absorbed by the leaves and turned directly
          into trunk height.]),
        terms.item(
          $("P"_("height 2"))$,
          [The tree is in a swamp and constantly sinks at a speed proportional to its height.],
        ),
        terms.item($("P"_("leaves"))$, [Leaves grow proportionality to the energy available.]),
        terms.item($("P"_("energy 1"))$, [The tree gains energy from the sun proportionally to the
          leaf area.]),
        terms.item($("P"_("energy 2"))$, [The tree loses energy proportionally to the square of its
          height.]),
      )


      + How are the premises expressed in the differential equations?
        #solution[
          In
          $
            H' = 0.3 dot A - b dot H,
          $
          the term $+0.3 dot A$ encodes growth from leaf-driven energy and $-b dot H$ encodes
          sinking loss. In
          $
            A' = -0.3 dot H^2 + A,
          $
          the $+A$ term is energy gain from sunlight (proportional to leaf area) and $-0.3 dot H^2$
          is energy loss growing with tree size.
        ]
      + What does the parameter $b$ represent (in the real world)?
        #solution[
          $b$ is the proportional sinking/decay rate of trunk height in the swamp: larger $b$ means
          faster height loss for the same $H$.
        ]
      + Applying Euler's method to this system shows that some solutions pass from the 1st to 4th
        quadrant of the phase plane. Is this realistic? Describe the life cycle of such a tree?
        #solution[
          No, not literally: the 4th quadrant has $A<0$, which is not physically meaningful
          (negative leaf area). Interpreted biologically, the tree loses essentially all leaves, can
          no longer sustain itself, and dies; the model is no longer realistic once it predicts
          $A<0$.
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
      Recall the tree model
      $
        H'(t) & = 0.3 dot.c A(t)-b dot.c H(t) \
        A'(t) & = -0.3 dot.c (H(t))^2 + A(t)
      $

      + Find all equilibrium solutions for $0 lt.eq b lt.eq 2$.
        #solution[
          Solve
          $
            0 = 0.3 dot A - b dot H, quad 0 = -0.3 dot H^2 + A.
          $
          From the second equation, $A=0.3 dot H^2$. Substituting into the first gives
          $
            0 = 0.09 dot H^2 - b dot H = H(0.09 dot H-b).
          $
          Hence
          $
            H=0 "or" H = 100b/9.
          $
          So equilibria are
          $
            (H,A)=(0,0)
          $
          and, for $b>0$,
          $
            (H,A)= (100b/9, 1000b^2/27).
          $
        ]
      + For which $b$ does a tree have the possibility of living forever? If the wind occasionally
        blew off a few random leaves, would that change your answer?
        #solution[
          A nonzero equilibrium exists when $b>0$, so in that sense a tree can persist forever for
          any $b>0$. But robustness to perturbations is stronger when that equilibrium is attracting
          (here, for larger $b$, approximately $b>1$). Random leaf loss can knock a tree away from a
          non-attracting equilibrium, so perturbations make stability important.
        ]
      +
        Find a value $b_5$ of $b$ so that there is an equilibrium with $H=5$.
        #solution[
          Using $H_* = 100b/9$, set $5=100b/9$, so
          $
            b_5 = 9/20 = 0.45.
          $
        ]

        Find a value $b_(12)$ of $b$ so that there is an equilibrium with $H=12$.
        #solution[
          Using $H_* = 100b/9$, set $12=100b/9$, so
          $
            b_(12) = 108/100 = 1.08.
          $
        ]

      + Predict what happens to a tree near equilibrium (but not at equilibrium) when $b=b_5$. What
        about when $b=b_(12)$.
        #solution[
          Near the nonzero equilibrium, the Jacobian has trace $1-b$ and determinant $b$. So for
          $b=b_5=0.45<1$, nearby solutions are unstable (move away). For $b=b_(12)=1.08>1$, nearby
          solutions are stable/attracting (move back toward equilibrium).
        ]
    ]
  })
}
