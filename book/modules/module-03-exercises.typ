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
          A simple improvement is to include a death rate $d >= 0$. Then we have
          $
            P'(t) = (b - d) P(t).
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
          #set align(center)
          #table(
            columns: 3,
            stroke: 0.5pt,
            [*Rate*], [*Maximum*], [*Minimum*],
            [$B_F$ (fox births)], [When $R$ is large], [When $R$ is small],
            [$D_F$ (fox deaths)], [(Constant)], [(Constant)],
            [$B_R$ (rabbit births)], [(Constant)], [(Constant)],
            [$D_R$ (rabbit deaths)], [When $F$ is large], [When $F$ is small],
          )
        ]
      + Come up with appropriate formulas for $B_F$, $B_R$, $D_F$, and $D_R$.
        #solution[
          Let $b_F, b_R, d_F, d_R >= 0$ be constants. Then
          $
            B_F & = b_F dot R & wide D_F & = d_F \
            B_R & = b_R       & wide D_R & = d_R dot F
          $
        ]
    ]
  })

  book_only(pagebreak())
  question(label: <ex:lv_simulation>, {
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
          Using Euler's method with a step size of $Delta = 0.05$ and initial values $F(0) = 5$,
          $R(0) = 100$, we get:

          #{
            let Delta = 0.05
            let sim = solve_2d_ivp(
              (F, R) => ((0.01 * R - 1.1) * F, (1.1 - 0.1 * F) * R),
              (5, 100),
              5,
              Delta: Delta,
              method: "euler",
            )

            let cells = (
              "A1": "Delta t",
              "A2": str(Delta),
              "B1": "t",
              "C1": "F",
              "D1": "R",
              "E1": "F'",
              "F1": "R'",
            )

            for i in range(sim.len()) {
              let row = i + 2
              let t = i * Delta
              let F = sim.at(i).at(0)
              let R = sim.at(i).at(1)
              let F_prime = (0.01 * R - 1.1) * F
              let R_prime = (1.1 - 0.1 * F) * R
              cells.insert("B" + str(row), str(calc.round(t, digits: 2)))
              cells.insert("C" + str(row), str(calc.round(F, digits: 2)))
              cells.insert("D" + str(row), str(calc.round(R, digits: 2)))
              cells.insert("E" + str(row), str(calc.round(F_prime, digits: 2)))
              cells.insert("F" + str(row), str(calc.round(R_prime, digits: 2)))
            }

            align(center, draw_spreadsheet(cols: 6, rows: 7, cells: cells))
          }
        ]
      + Do the populations continue to grow/shrink forever? Are they cyclic?
        #solution[
          Simulations suggest that the populations of foxes and rabbits rise and fall (oscillate).
        ]
      + Should the humps/valleys in the rabbit and fox populations be in phase? Out of phase?
        #solution[
          They should be out of phase. When the rabbit population gets large, foxes are born. They
          then eat the rabbits, reducing the rabbit population. As the rabbit population gets
          smaller, the foxes start to die off.
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
            No. For small $Delta$, the population curves oscillate similarly.
          ]
        + Does it affect the height of the peaks and valleys?
          #solution[
            Yes. The larger the $Delta$, the higher the peaks become (and the lower the valleys).
          ]
        + Does it affect the _time_ when the peaks and valleys occur?
          #solution[
            No. The time each peak/valley occurs is approximately the same for different $Delta$
            values.
          ]
      + #label_question_part(<ex:lv_peaks>) We want to know about the peaks and valleys for the
        _exact_ rabbit population curve.

        Do your simulations consistently under or over estimate the population of rabbits?
        #solution[
          Yes. As we shrink $Delta$, we notice that the height of the first peak gets smaller and
          the height of the first valley gets larger. Since smaller $Delta$'s give a more accurate
          approximation, we conjecture that the exact rabbit population peaks are lower than the
          peaks in our simulations (and the valleys are higher).
        ]
      + #label_question_part(<ex:lv_peaks_get_closer>) Let $p_1$ and $p_2$ be the first and second
        local maxima for the (exact) rabbit population. Is $p_1$ bigger, smaller, or equal to $p_2$?
        Justify with numerical evidence.
        #solution[
          They are equal for an exact solution. Using Euler simulations, we can compare the first
          two rabbit peaks for decreasing values of $Delta$. We see that the peaks appear to be
          stabilizing and tending towards the same height.

          Using initial populations of $F(0) = 5$ and $R(0) = 100$, we get:

          #{
            let find_peak(values) = {
              let peaks = ()
              for j in range(1, values.len() - 1) {
                let prev = values.at(j - 1)
                let curr = values.at(j)
                let next = values.at(j + 1)
                if prev < curr and curr > next {
                  peaks.push(curr)
                }
              }
              peaks
            }

            let d1 = 0.05
            let deltas = (d1, d1 / 2, d1 / 4, d1 / 8)
            let results = ()

            for i in range(deltas.len()) {
              let Delta = deltas.at(i)
              let total_time = 10
              let steps = calc.ceil(total_time / Delta)

              let sim = solve_2d_ivp(
                (F, R) => ((0.01 * R - 1.1) * F, (1.1 - 0.1 * F) * R),
                (5, 100),
                steps,
                Delta: Delta,
                method: "euler",
              )

              let rabbit_values = sim.map(v => v.at(1))
              let peaks = find_peak(rabbit_values)

              let p1 = peaks.at(0)
              let p2 = peaks.at(1)
              let diff = calc.abs(p2 - p1)
              results.push((
                str(Delta),
                str(calc.round(p1, digits: 4)),
                str(calc.round(p2, digits: 4)),
                str(calc.round(diff, digits: 4)),
              ))
            }

            align(
              center,
              {
                let table_rows = ()
                for result in results {
                  table_rows.push([#result.at(0)])
                  table_rows.push([#result.at(1)])
                  table_rows.push([#result.at(2)])
                  table_rows.push([#result.at(3)])
                }

                table(
                  columns: 4,
                  stroke: 0.5pt,
                  table.header(
                    [*$Delta$*],
                    [*First peak ($p_1$)*],
                    [*Second peak ($p_2$)*],
                    [*$abs(p_2 - p_1)$*],
                  ),
                  ..table_rows,
                )
              },
            )
          }
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
          #{
            let Delta = 0.05
            let total_time = 20
            let steps = calc.ceil(total_time / Delta)
            let soln = solve_2d_ivp(
              (F, R) => ((0.01 * R - 1.1) * F, (1.1 - 0.1 * F) * R),
              (5, 100),
              steps,
              Delta: Delta,
              method: "euler",
            )
            let foxes = soln.map(((F, R)) => F)
            let rabbits = soln.map(((F, R)) => R)

            align(center, lq.diagram(
              title: [Phase plot: Foxes vs. Rabbits],
              xlim: (0, 30),
              ylim: (0, 260),
              width: 8cm,
              height: 5cm,
              xaxis: (position: 0, tip: tiptoe.stealth),
              yaxis: (position: 0, tip: tiptoe.stealth),
              xlabel: $F$,
              ylabel: lq.label($R$),
              lq.plot(foxes, rabbits, mark: none),
            ))
          }
        ]
      + Should your plot show a closed curve or a spiral?
        #solution[
          For an exact solution, it should be a closed curve. Since, as we saw in @ex:lv_peaks and
          @ex:lv_peaks_get_closer[], the peaks and valleys are over/under estimated, and drift
          further apart as time goes on. Thus, the plot of the simulated data should spiral
          outwards.
        ]
      + What “direction” do points move along the curve as time increases? Justify by referring to
        the model.
        #solution[
          The curve is traced out in a clockwise direction. We can see this because, fi we look at a
          peak of $R$, we know that the fox population should be increasing at that point, so the
          graph must move to the right.
        ]
      + What is easier to see from plots in the phase plane than from component graphs (the graphs
        of fox and rabbit population vs. time)?
        #solution[
          The phase plots makes it clear that the fox and rabbit populations are cyclic, oscillating
          in relation to each other.
        ]
    ]
  })
}
