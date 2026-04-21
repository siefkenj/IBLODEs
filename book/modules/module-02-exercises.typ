#import "../libs/lib.typ": *
#show: e.prepare(question)

#show ref: allow_missing_refs

#let MM = $upright(bold("M"))$
#let NN = $upright(bold("N"))$
#let OO = $upright(bold("O"))$
#let SS = $upright(bold("S"))$
// #let RR = $upright(bold("R"))$
// #let QQ = $upright(bold("Q"))$
#let infty = math.infinity

#{
  question(label: <q:yearly_starfish>, {
    learning_objectives(
      [Derive Euler's method.],
      [Use a spreadsheet to execute Euler's method.],
      [Evaluate another's argument.],
    )
    notes[
      This exercise is *very important*. It is where we derive Euler's method.

      Ask students both what is _good_ about the argument and what is _bad_ about it. (Students are
      pretty good at pointing out flaws, but not so good at seeing valuable ideas in incorrect
      arguments.)

      After discussing @ex:introduce_euler1[], introduce the vocabulary of "step size" and have them
      build a spreadsheet to simulate using a similar idea to the presented argument but smaller
      "step size".

      Conclude the exercises by telling the students they have just derived Euler's method, and they
      can now simulate the solution to _any_ (first-order, ordinary) differential equation!

      - Students may have trouble with tangent lines. They are used to seeing
        $f(x) approx f'(a)(x-a) + f(a)$. They are _not_ used to seeing
        $f(a+Delta) approx f(a) + Delta f'(a)$. If needed, take some time to discuss how these forms
        are equivalent.

      - At this point, it is okay if students hard-code a step-size in their spreadsheet.

        If some finish quickly, you can ask them to make a spreadsheet where the step-size is
        adjustable.

      - Students are still beginners at spreadsheets, but now is the time to set expectations. Tell
        students they need to practice going from a blank spreadsheet to a working simulation (in
        less than 5 minutes).
    ]
    slide[

      Consider the following argument for the population model #SS where
      $P'(t) = P(t) dot abs(sin(2 pi t))$ with $P(0) = 10$:

      #quote(block: true)[
        #set text(blue)
        At $t = 0$, the change in population $approx P'(0) = 0$, so, using a tangent-line
        approximation,
        $ P(1) approx P(0) + P'(0) dot 1 = P(0) = 10. $
        At $t = 1$, the change in population $approx P'(1) = 0$, so
        $ P(2) approx P(1) + P'(1) dot 1 = P(0) = 10. $
        And so on.

        So, the population of starfish remains constant. #h(1fr)
      ]

      + #label_question_part(<ex:introduce_euler1>) Do you believe this argument? Can it be
        improved?
        #solution[
          The argument is *not* believable. While the logic follows a good idea, we know
          $P(t + Delta)approx P(t) + Delta P'(t)$ when $Delta approx 0$. In the reasoning above,
          $Delta = 1$ year was used. Over the course of a year, the equation
          $P'(t) = P(t) dot abs(sin(2 pi t))$ varies significantly, and is zero _only_ when $t$ is a
          multiple of $1/2$.

          A better argument would be to use a smaller $Delta$. If $Delta = 0.05$, for example, the
          population estimate would not be constant.
        ]
      + Simulate an improved version using a spreadsheet.
        #solution[
          Simulating with $Delta = 0.05$ via the formula
          $
            P(t + Delta) approx P(t) + P(t) abs(sin(2 pi t)) Delta quad P(0) = 10,
          $
          we get the following spreadsheet.

          #{
            let sim = solve_1d_ivp(
              (t, P) => P * calc.abs(calc.sin(2 * calc.pi * t)),
              (0, 10),
              5,
              Delta: 0.05,
              method: "euler",
            )

            let cells = (
              "A1": "Delta t",
              "A2": "0.05",
              "B1": "t",
              "C1": "P",
            )

            for i in range(sim.len()) {
              let row = i + 2
              let t = sim.at(i).at(0)
              let P = sim.at(i).at(1)
              cells.insert("B" + str(row), str(calc.round(t, digits: 2)))
              cells.insert("C" + str(row), str(calc.round(P, digits: 4)))
            }

            align(center, draw_spreadsheet(cols: 3, rows: 7, cells: cells))
          }

          The spreadsheet shows that the population grows above 10.
        ]

    ]
  })

  book_only(pagebreak())
  question(label: <ex:euler_delta_comparison>, {
    learning_objectives(
      [Correctly compare numerical data generated from a table; in particular compare population
        estimates for like values of $t$ rather than by comparing the $n$#super[th] rows directly.],
      [Conjecture as to the relationship between step size and Euler estimates.],
    )
    notes[
      Graphs are easy to compare; numerical data less so. One trap is for students to compare rows
      of data without thinking about what the row means. Expect _some_ students to think $Delta=0.2$
      grows faster for this reason.

      Spreadsheets make it hard to graph independent sets of $x y$ pairs on the same plot. For this
      reason, copying-and-pasting data into a Desmos is a good compromise for visualizing.

      In @ex:visualize_simulations[], have students conjecture as to whether the approximations will
      "converge" or whether they forever get bigger and diverge as $Delta arrow 0$. They don't have
      the tools to answer this question rigorously, so leave it at a conjecture.

      - Copy-and-pasting into Desmos is covered in @app:spreadsheet[].

      - When copy-and-pasting into Desmos, do not copy the header column (only copy the numbers).

      - There are two copies of this exercise in the slides. The first is with a table meant for use
        with @ex:euler_delta_comparison1[] and @ex:euler_delta_comparison2[]. The second slide has
        graphs and is meant for use with @ex:euler_delta_comparison3[] and
        @ex:visualize_simulations[].

    ]
    slide[
      (Simulating $MM_(infty)$ from @ex:m_infinity with different $Delta$s)

      #align(
        center,
        stack(
          dir: ltr,
          spacing: 1em,
          simple_table(
            headers: ([Time], [Pop. ($Delta = 0.1$)]),
            content: (
              [0.0],
              [10],
              [0.1],
              [11.1],
              [0.2],
              [12.321],
              [0.3],
              [13.67631],
              [0.4],
              [15.1807041],
            ),
          ),
          simple_table(
            headers: ([Time], [Pop. ($Delta = 0.2$)]),
            content: (
              [0.0],
              [10],
              [0.2],
              [12.2],
              [0.4],
              [14.884],
              [0.6],
              [18.15848],
              [0.8],
              [22.1533456],
            ),
          ),
        ),
      )

      #slides_only(colbreak())
      + #label_question_part(<ex:euler_delta_comparison1>) Compare $Delta = 0.1$ and $Delta = 0.2$.
        Which approximation grows faster?
        #solution[
          Looking at the table and carefully comparing like values of $t$, we see the $Delta = 0.1$
          simulation grows faster.
        ]
      + #label_question_part(<ex:euler_delta_comparison2>) Graph the population estimates for
        $Delta = 0.1$ and $Delta = 0.2$ on the same plot. What does the graph show?
        #solution[
          #let all_sims = {
            let ret = (:)
            for Delta in (0.1, 0.2) {
              let steps = calc.ceil(2.4 / Delta)
              let sim = solve_1d_ivp(
                (x, y) => 1.1 * y,
                (0, 10),
                steps,
                Delta: Delta,
                method: "euler",
              )
              ret.insert(
                "d" + str(Delta),
                (
                  xs: sim.map(v => v.at(0)),
                  ys: sim.map(v => v.at(1)),
                ),
              )
            }
            ret
          }

          #let colors = (
            purple,
            red.darken(10%),
          )

          #align(
            center,
            lq.diagram(
              xlim: (0, 2.8),
              ylim: (0, 130),
              lq.plot(
                all_sims.at("d0.1").xs,
                all_sims.at("d0.1").ys,
                mark: none,
                color: colors.at(0),
                stroke: 1.2pt,
              ),
              lq.place(
                all_sims.at("d0.1").xs.last(),
                all_sims.at("d0.1").ys.last(),
                align: bottom + left,
                pad(x: 0.2em, y: .0em)[
                  #set text(colors.at(0))
                  $Delta=0.1$
                ],
              ),
              lq.plot(
                all_sims.at("d0.2").xs,
                all_sims.at("d0.2").ys,
                mark: none,
                color: colors.at(1),
                stroke: 1.2pt,
              ),
              lq.place(
                all_sims.at("d0.2").xs.last(),
                all_sims.at("d0.2").ys.last(),
                align: bottom + left,
                pad(x: .2em, y: -.1em)[
                  #set text(colors.at(1))
                  $Delta=0.2$
                ],
              ),
            ),
          )

          The curve for $Delta = 0.1$ grows faster than the curve for $Delta = 0.2$.
        ]

        #slides_only(v(.7cm))
      + #label_question_part(<ex:euler_delta_comparison3>) What $Delta$s give the largest estimate
        for the population at time $t$?
        #solution[
          Simulating _this_ model, smaller $Delta$ values give larger estimates.
        ]
      + #label_question_part(<ex:visualize_simulations>) Is there a limit as $Delta arrow 0$?
        #solution[
          Yes, but it isn't necessarily obvious from the data. As $Delta arrow 0$, the Euler
          estimates converge to the continuous solution.
        ]
    ]

    // This is a recreation of the previous slide with a graphic. It will only appear in a slide deck
    slides_only(
      slide[

        (Simulating $MM_(infty)$ with different $Delta$s)

        // Recreation of
        // https://www.desmos.com/calculator/x7qbgv6mkc
        #let all_sims = {
          // Make a chart comparing Euler's method using Delta=0.05, 0.1, 0.2, and 0.3
          // The chart should end at ~x=2.5
          let num_steps(Delta) = calc.ceil(2.4 / Delta)
          let ret = (:)
          for Delta in (0.05, 0.1, 0.2, 0.3) {
            let steps = num_steps(Delta)
            let sim = solve_1d_ivp((x, y) => 1.1 * y, (0, 10), steps, Delta: Delta, method: "euler")
            ret.insert(
              "d" + str(Delta),
              (
                xs: sim.map(v => v.at(0)),
                ys: sim.map(v => v.at(1)),
              ),
            )
          }
          ret
        }

        #let colors = (
          green.darken(20%),
          purple,
          red.darken(10%),
          orange.darken(20%),
        )

        #align(
          center,
          lq.diagram(
            xlim: (0, 3.3),
            ylim: (0, 150),
            lq.plot(
              all_sims.at("d0.05").xs,
              all_sims.at("d0.05").ys,
              mark: none,
              color: colors.at(0),
              stroke: 1.2pt,
            ),
            lq.place(
              all_sims.at("d0.05").xs.last(),
              all_sims.at("d0.05").ys.last(),
              align: bottom + left,
              pad(x: 0em, y: .4em)[
                #set text(colors.at(0))
                $Delta=0.05$
              ],
            ),
            lq.plot(
              all_sims.at("d0.1").xs,
              all_sims.at("d0.1").ys,
              mark: none,
              color: colors.at(1),
              stroke: 1.2pt,
            ),
            lq.place(
              all_sims.at("d0.1").xs.last(),
              all_sims.at("d0.1").ys.last(),
              align: bottom + left,
              pad(x: 0.2em, y: .0em)[
                #set text(colors.at(1))
                $Delta=0.1$
              ],
            ),
            lq.plot(
              all_sims.at("d0.2").xs,
              all_sims.at("d0.2").ys,
              mark: none,
              color: colors.at(2),
              stroke: 1.2pt,
            ),
            lq.place(
              all_sims.at("d0.2").xs.last(),
              all_sims.at("d0.2").ys.last(),
              align: bottom + left,
              pad(x: .2em, y: -.1em)[
                #set text(colors.at(2))
                $Delta=0.2$
              ],
            ),
            lq.plot(
              all_sims.at("d0.3").xs,
              all_sims.at("d0.3").ys,
              mark: none,
              color: colors.at(3),
              stroke: 1.2pt,
            ),
            lq.place(
              all_sims.at("d0.3").xs.last(),
              all_sims.at("d0.3").ys.last(),
              align: bottom + left,
              pad(x: .3em, y: -.3em)[
                #set text(colors.at(3))
                $Delta=0.3$
              ],
            ),
          ),
        )

        #enum.item(1)[Compare $Delta = 0.1$ and $Delta = 0.2$. Which approximation grows faster?]
        + Graph the population estimates for $Delta = 0.1$ and $Delta = 0.2$ on the same plot. What
          does the graph show?

          #v(.7cm)
        + What $Delta$s give the largest estimate for the population at time $t$?
        + Is there a limit as $Delta arrow 0$?
      ],
    )
  })

  book_only(pagebreak())
  question(label: <ex:models_MNO>, {
    learning_objectives(
      [Apply modelling techniques to new situations to establish differential-equations based
        models.],
      [Simulate more complicated models using a spreadsheet.],
    )
    notes[
      This exercise is mean for a "modelling hour" class. Use as many parts as time allows, and
      leave the remaining parts for homework.

      Emphasize the modelling processes again. Don't let students "jump to equations". One way to
      encourage this is to pre-write on the board headings of Definitions/Assumptions/Relationships.

      The modelling is more important than the simulations.

      - Students will be surprised (and delighted?) to see model $NN$ giving linear growth.

      - Model $OO$ is meant to give logistic growth. It is hard to parse and will be challenging for
        students.

      - For both models, students will be tempted to make the resources a function of time.
        Encourage them to simplify and add complexity after they have a working model.
    ]
    slide[
      Consider the following models for starfish growth:

      #aligned_terms(
        terms.item(MM, [\# new children per year $~$ current population.]),
        terms.item(
          NN,
          [\# new children per year $~$ current population times resources available per
            individual.],
        ),
        terms.item(
          OO,
          [\# new children per year $~$ current population times the fraction of total resources
            remaining.],
        ),
      )

      + Model $NN$ introduces the concept of "resources available per individual".
        + Come up with definitions and assumptions for this concept.
          #solution[
            Definitions:
            - $k > 0$ is the proportionality constant (natural growth rate per year).
            - $R$ = total available resources in the tide-pool.
            - $r(t) = R/P(t)$ is the resources per individual.


            Assumptions:
            - The only way starfish population changes is by births (e.g., no deaths, no migration,
              etc.).
            - $R$ is constant (e.g., resources replenishes every year).
            - A continuous model is appropriate:
              - Fractions of starfish make sense.
              - Children are ready to reproduce immediately after birth.
              - Children are born throughout the year.
          ]
        + Come up with relationships pertaining to model $NN$ in the form of a differential
          equation.
          #solution[
            Since
            $
              "births" ~ P(t) dot r(t),
            $
            then
            $
              P'(t) = k P(t) r(t) = k P(t) inline(R / P(t)) = k R.
            $
            So model $NN$ gives linear growth.
          ]
      + Repeat the modelling process for model $OO$.
        #solution[
          _Definitions_:
          - $k > 0$ is the proportionality constant (natural growth rate per year).
          - $F$ = resources consumed per starfish per year.
          - $R$ = total available resources in the tide-pool.
          - $ell(t) = (R- F dot P(t))/R$ is the fraction of total resources remaining.

          _Assumptions_:
          - The only way starfish population changes is by births (e.g., no deaths, no migration,
            etc.).
          - $F$ is constant (e.g., each starfish consumes the same amount of resources regardless of
            how many other starfish there are).
          - $R$ is constant (e.g., resources replenishes every year).
          - A continuous model is appropriate:
            - Fractions of starfish make sense.
            - Children are ready to reproduce immediately after birth.
            - Children are born throughout the year.

          _Relationships_:

          Since
          $
            "births" ~ P(t) dot ell(t),
          $
          then
          $
            P'(t) & = k P(t) ell(t) = k P(t) inline((R - F P(t))/R) \
                  & = k P(t) (1 - inline(F/R) P(t)).
          $

        ]
      + Simulate population vs. time curves for each model.
        #solution[
          After picking initial populations and values for the constants, we observe the following
          behaviours:
          - $MM$: exponential growth.
          - $NN$: linear growth.
          - $OO$: logistic growth (initially increasing quickly, then leveling off).
        ]

    ]
  })

  book_only(pagebreak())
  question(label: <ex:model_growth_comparison>, {
    learning_objectives(
      [???],
    )
    notes[???]
    slide[
      Recall the models

      #aligned_terms(
        terms.item(MM, [\# new children per year $~$ current population.]),
        terms.item(
          NN,
          [\# new children per year $~$ current population times resources available per
            individual.],
        ),
        terms.item(
          OO,
          [\# new children per year $~$ current population times the fraction of total resources
            remaining.],
        ),
      )

      + Determine which population grows fastest in the short term and which grows fastest in the
        long term.
        #solution[
          // Using the same initial population and the same values for common constants, we see:
          - $MM$ grows slowly then quickly (it is exponential).
          - $NN$ grows consistently (it is linear).
          - $OO$ grows slowly, then speeds up, then grows slowly (it is logistic).
        ]
      + Are some models more sensitive to your choice of $Delta$ when simulating?
        #solution[
          Yes. Model $OO$ should plateau to a value of $R/F$. However, if the step size is too
          large, simulations will overshoot this value.
        ]
      + Are your simulations for each model consistently underestimates? Overestimates? Do any
        results surprise you?
        #solution[
          - $MM$ simulations are underestimates.
          - $NN$ simulations are accurate (the model is linear, so Euler's method gives the exact
            solution).
          - $OO$ simulations are underestimates at the beginning, and overestimates at the end, with
            very strange behaviour if the step size is too large
        ]
    ]
  })

  //book_only(pagebreak())
  //question(slide[ ])

  //book_only(pagebreak())
  //question(slide[ ])
}
