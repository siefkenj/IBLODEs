#import "../libs/lib.typ": *
#import "definitions.typ": show_def
#show: e.prepare(question)

#{
  lesson(title: [Systems of ODEs], include "lesson-week-03.typ")
  question({
    learning_objectives(
      ([Generalize an existing model to account for more-inclusive assumptions.],),
    )
    notes[
      This is a stepping stone to build up the Lotka-Volterra model. The goal is to generalize to a
      birth and death rate that can change with time.

      - Students will suggest a constant death rate immediately. Prompt them to generalize further.

        Many students will suggest birth and death rates that depend on time. A few might suggest
        birth and death rates that depend on the population *and* time. This situation is ideal, but
        it is not necessary to get to this level of generality. It will naturally come up in
        @ex:LV_model[].
    ]
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

          A more complicated (and inclusive) generalization introduces a possibly-changing birth
          rate and death rate, $b(P,t)$ and $d(P,t)$, giving
          $
            P'(t) = (b(P, t) - d(P, t)) dot P(t).
          $
        ]

    ]
  })

  book_only(pagebreak())
  question.with(label: <ex:LV_model>)({
    learning_objectives(
      [Produce a _simplest possible_ model that fits a given set of premises.],
      [Derive the formula for the Lotka-Volterra model based on premises phrased in words.],
    )
    notes[
      This exercise serves as practice for (i) modelling, (ii) thinking about systems with
      interacting terms, (iii) finding simple formulas to reflect vague assumptions, (iv) establish
      a canonical system of ODEs (the Lotka-Volterra model) to explore in future simulations and
      analysis.

      Students shouldn't have much trouble, but may propose complicated formulas for $B_F$ and
      $D_R$. Encourage them to simplify.

      - The order of $"P"_"foxes 1"$ and $"P"_"foxes 2"$ is intentional, as $"P"_"foxes 1"$ is
        easier to reason about.

      - $B_?$ and $D_?$ are _rates_. Some students may confuse them with absolute numbers of births
        and deaths, which will lead them to propose strange formulas (E.g., $D_F = d_F dot F$).
    ]
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
            [$D_F$ (fox deaths)], [(Constant)], [(Constant)],
            [$B_F$ (fox births)], [When $R$ is large], [When $R$ is small],
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
      [Simulate a solution to a system of differential equations using Euler's method.],
      [Analyze the behaviour of solutions to a system in component space.],
    )
    notes[
      The main thrust of this exercise is to practice simulating a system of ODEs.

      _It is *very* helpful if they have had a quiz on 1-d Euler simulations before this_.

      This is likely the first system students are simulating. Again, offer the students advice:
      make a table by hand first; make a spreadsheet only when you have a feel for the algorithm.

      - Ask students to start a new, blank, spreadsheet. Don't build off a previously existing one.
      - The system is unstable and diverges quickly, especially for large step sizes. If students
        are getting `#N/A` it is due to numerical instability. Tell them to use a smaller step size.
      - Students may pick a step size of 1. Though the problem doesn't explicitly give the units of
        $t$, these students are usually helped by asking them: do they think simulating the
        populations _once per year_ is reasonable?
      - If time allows, have a discussion with the students about what an appropriate step size is.
        What is "too big"?

        This can be approached in two ways: (i) smaller is always better and (ii) what are the units
        of $t$, and what sounds reasonable based on those units. Encourage both approaches (that is,
        students should think in terms of both approaches, not just one). Approach (ii) requires
        looking at population graphs and exercising intuition about the world. Will fox and rabbit
        populations in the real world cycle every few days? Every few weeks? Every few years?
    ]
    slide[
      Suppose the population of $F$ (foxes) and $R$ (rabbits) evolves over time following the rule
      $
        F'(t) & = (0.01 dot R(t) - 1.1) dot F(t) \
        R'(t) & = (1.1 - 0.1 dot F(t)) dot R(t)
      $

      + Simulate the population of foxes and rabbits with initial populations $F(0) = 5$,
        $R(0) = 100$, using a spreadsheet.
        #solution[
          Using Euler's method with a step size of $Delta = 0.05$ and initial values $F(0) = 5$,
          $R(0) = 100$, we get:

          #{
            set text(size: .8em)
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
          More analysis is needed to determine if the behaviour is truly cyclic (i.e., periodic).
        ]
      + Should the humps/valleys in the rabbit and fox populations be in phase? Out of phase?
        #solution[
          They should be out of phase, but with the same period. When the rabbit population gets
          large, foxes are born. They then eat the rabbits, reducing the rabbit population. As the
          rabbit population gets smaller, the foxes start to die off.
        ]
    ]
  })

  book_only(pagebreak())
  question.with(label: <ex:fox_and_rabbit>)({
    learning_objectives(
      [Recognize the effect of step size on simulations],
      [Reason about the "true" solution to a system of differential equations by noticing patterns
        in simulations as step sizes get smaller.],
    )
    notes[
      Smaller step sizes are better, but what happens to systemic errors? That's what this question
      explores.

      This exercise provides a spreadsheet with adjustable step size. Have students use this
      spreadsheet so that everyone has a uniform experience.

      Before students start working, explain what the "clamp" on the spreadsheet means (see the
      note).

      Discuss @ex:lv_shape[] and establish a baseline understanding before having students work on
      the remaining parts.

      Parts @ex:lv_peaks[] and @ex:lv_peaks_get_closer[] are _hard_ for students. Discuss how
      smaller step sizes are more accurate and how we need to imagine that the solution curves are
      "heading to" the solution curve for the exact solution.

      Conclude with a model solution for @ex:lv_peaks_get_closer[], since this is exactly the type
      of argument we expect students to articulate in the homeworks, projects, and exams.

      - Students will have to run `File` > `Create a Copy` before they can edit the spreadsheet.

      - The spreadsheet has a "clamp" that suppresses values of $F$ and $R$ that are too big. If
        students graph the clamped values (i.e., not the "raw" columns), they will have
        interpretable graphs. If they graph the raw values and use a step size greater than $0.05$,
        the scale of the graph axes will make no sense.

      - Avoid making phase graphs when discussing this question. Phase graphs are coming; stick to
        component graphs for now.

      - Students will know how to scroll to find the value at the peaks/values. They _will not_ know
        the magic excel formulas:
        ```
        =MAXIFS(F:F,E:E, "<5")
        =INDEX(E:E, MATCH(MAXIFS(F:F, E:E, "<5"), F:F, 0))
        ```
        The first finds the maximum of column `F` given that the time (column `E`) is less than 5.
        The second finds the time at which that maximum occurs. *Demo the "scrolling method"*; if
        you choose to show fancy formulas, emphasize that students don't need to learn them.


    ]
    slide(force_scale: 0.95em)[
      // https://utoronto-my.sharepoint.com/:x:/g/personal/jason_siefken_utoronto_ca/Eay4QOMvy7lNr5pOKRv22NgBLGUw7qMpSCShUjeAdrhsHQ?e=bpg4CP
      Open and make a copy of the spreadsheet

      #align(center, link("https://uoft.me/foxes-and-rabbits")[https://uoft.me/foxes-and-rabbits])

      which contains an Euler approximation for the Foxes and Rabbits population.
      $
        F'(t) & = (0.01 dot R(t) - 1.1) dot F(t) \
        R'(t) & = (1.1 - 0.1 dot F(t)) dot R(t)
      $

      + #label_question_part(<ex:lv_shape>) Simulate the rabbit population using different step
        sizes $Delta$.
        + Does the choice of $Delta$ affect the qualitative "shape" of the population curve?
          #solution[
            No. For small $Delta$, the population curves oscillate similarly.
          ]
        + Does it affect the _height_ of the peaks and valleys?
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
          Both. As we shrink $Delta$, we notice that the height of the first peak gets smaller and
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
  question(label: <ex:intro_to_phase_space>, {
    learning_objectives(
      [Distinguish between graphs in component space and graphs in phase space.],
      [Recognize when to use phase space or component space.],
      [Produce graphs in phase space.],
      [Identify properties of solutions to a system of differential equations by analyzing graphs in
        phase space.],
      [Determine whether properties of a graph in phase space are due to the model or due to
        numerical error.],
    )
    notes[
      This is students' first exposure to phase space. Explain to them that a skill we're developing
      is "reading and understanding a definition on your own". Then give them time to work on
      @ex:phase_space1[].

      Discuss @ex:phase_space1[] before having students work on @ex:phase_space2[].

      - @ex:phase_space3[] is your chance to establish vocabulary to talk about the shape. "Egg
        shaped" works well.

        It is also a repeat of @ex:lv_peaks[] and @ex:lv_peaks_get_closer[], but in phase space.

      - If students are stuck on @ex:phase_space4[], ask them what should happen when the fox/rabbit
        population is at a peak/valley. Then ask them to find those peaks or valleys on their plot
        in phase space.

    ]
    slide(force_scale: 0.85em)[
      Open and make a copy of the spreadsheet

      #slides_only(v(-.5em))
      #align(center, link("https://uoft.me/foxes-and-rabbits")[https://uoft.me/foxes-and-rabbits])
      #slides_only(v(-.5em))

      which contains an Euler approximation for the Foxes and Rabbits population.
      #slides_only(v(-1.3em))
      $
        F'(t) & = (0.01 dot R(t) - 1.1) dot F(t) \
        R'(t) & = (1.1 - 0.1 dot F(t)) dot R(t)
      $
      #slides_only(v(-.5em))

      #slides_only(
        {
          set text(size: 0.85em)
          show_def("component_and_phase_spaces")
        },
        otherwise: show_def("component_and_phase_spaces"),
      )
      + #label_question_part(<ex:phase_space1>)
        + Were the graphs you made in @ex:fox_and_rabbit in component space or phase space? How can
          you tell?
          #solution[
            They were graphs in component space, since the axes were time and population.
          ]
        + What are the axes of the phase space associated with this model?
          #solution[
            The axes of the phase space are foxes and rabbits (i.e., $F$ and $R$).
          ]
      + #label_question_part(<ex:phase_space2>) Plot the Fox vs. Rabbit population in the phase
        space.
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
      + #label_question_part(<ex:phase_space3>) Should your plot show a closed curve or a spiral?
        #solution[
          For an exact solution, it should be a closed curve.

          For simulated data, it should be a spiral. In @ex:lv_peaks and @ex:lv_peaks_get_closer[],
          we saw the peaks/valleys are over/under estimated, and drift further apart as time goes
          on. Thus, the plot of the simulated data should spiral outwards.

          As we make the step size smaller, the spiral should converge to an "egg" shape.
        ]
      + #label_question_part(<ex:phase_space4>) What “direction” do points move along the curve as
        time increases? Justify by referring to the model.
        #solution[
          The curve is traced out in a clockwise direction. We can see this because, if we look at a
          peak of $R$, we know that the fox population should be increasing at that point, so the
          graph must move to the right.
        ]
      + What is easier to see from plots in the phase plane than from plots in component space (the
        graphs of fox and rabbit population vs. time)?
        #solution[
          The plots in phase space make it clear that the fox and rabbit populations are cyclic,
          oscillating in relation to each other.
        ]
    ]
  })
}
