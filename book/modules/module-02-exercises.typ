#import "../libs/lib.typ": *
#show: e.prepare(question)

#let MM = $upright(bold("M"))$
#let NN = $upright(bold("N"))$
#let OO = $upright(bold("O"))$
#let SS = $upright(bold("S"))$
// #let RR = $upright(bold("R"))$
// #let QQ = $upright(bold("Q"))$
#let infty = math.infinity

#{
  lesson(title: [Euler's Method], include "lesson-week-03.typ")
  question(label: <q:yearly_starfish>, {
    learning_objectives(
      [???],
    )
    notes[???]
    slide[

      Consider the following argument for the population model #SS where
      $P'(t) = P(t) dot abs(sin(2 pi t))$ with $P(0) = 10$:

      #quote(block: true)[
        #set text(blue)
        At $t = 0$, the change in population $approx P'(0) = 0$, so
        $ P(1) approx P(0) + P'(0) dot 1 = P(0) = 10. $
        At $t = 1$, the change in population $approx P'(1) = 0$, so
        $ P(2) approx P(1) + P'(1) dot 1 = P(0) = 10. $
        And so on.

        So, the population of starfish remains constant. #h(1fr)
      ]

      + Do you believe this argument? Can it be improved?
        #solution[
          No. While the logic follows a good idea, we know $P(t + Delta)approx P(t) + Delta P'(t)$
          when $Delta approx 0$. In the reasoning above, $Delta = 1$year was used. Over the course
          of a year, the equation $P'(t) = P(t) dot abs(sin(2 pi t))$ varies significantly, and is
          zero _only_ when $t$ is a multiple of $1/2$.

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
      [???],
    )
    notes[???]
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
      + Compare $Delta = 0.1$ and $Delta = 0.2$. Which approximation grows faster?
        #solution[
          Looking at the table and carefully comparing like values of $t$, we see the $Delta = 0.1$
          simulation grows faster.
        ]
      + Graph the population estimates for $Delta = 0.1$ and $Delta = 0.2$ on the same plot. What
        does the graph show?
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
      + What $Delta$s give the largest estimate for the population at time $t$?
        #solution[
          Simulating _this_ model, smaller $Delta$ values give larger estimates.
        ]
      + Is there a limit as $Delta arrow 0$?
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
      [???],
    )
    notes[???]
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
        + Come up with a definition/notation/assumptions for this concept.
          #solution[
            One reasonable choice is:
            - $R(t)$ = total available resource in the tide-pool.
            - Resource per individual: $r(t) = R(t)/P(t)$.

            Assumptions:
            - Births are proportional to population and to per-capita resource.
            - On the time scale of this model, treat $R(t)$ as approximately constant $R_0 > 0$.

            Then per-capita resource is $r(t)=R_0/P(t)$.
          ]
        + Create a differential equation for model $NN$.
          #solution[
            Let $b>0$ be a proportionality constant. If
            $
              "birth rate" ~ P(t) dot r(t),
            $
            then
            $
              P'(t) = b P(t) r(t) = b P(t) (R_0 / P(t)) = b R_0.
            $
            So model $NN$ gives approximately linear growth in time.
          ]
      + Repeat the modelling process for model $OO$.
        #solution[
          Let $K$ be carrying capacity (resource-limited maximum population). A standard way to
          model ``fraction of resources remaining'' is
          $
            1 - P(t)/K.
          $
          If births are proportional to population times this fraction, then
          $
            P'(t) = r P(t) (1 - P(t)/K),
          $
          where $r>0$ is a growth parameter. Big picture: this adds feedback that slows growth as
          resources are depleted.
        ]
      + Simulate population vs. time curves for each model.
        #solution[
          A typical comparison (same $P(0)=10$ and tuned parameters) is:
          - $MM$: exponential growth.
          - $NN$ (with constant total resource): roughly linear growth.
          - $OO$: logistic growth (initially increasing quickly, then leveling near $K$).

          For lecture prep, plotting all three together is useful: students can visually connect
          modelling assumptions to long-term behaviour.
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
          With matched initial data and reasonable parameters:
          - Short term: either $MM$ or $OO$ can look fastest depending on chosen $r$ and $K$, but
            $OO$ often tracks $MM$ briefly when $P << K$.
          - Long term: $MM$ is fastest (unbounded exponential), $OO$ levels off at $K$, and $NN$
            grows linearly.

          The key concept is asymptotic behaviour: assumptions about resource limits dominate
          long-run predictions.
        ]
      + Are some models more sensitive to your choice of $Delta$ when simulating?
        #solution[
          Yes. $MM$ is typically most sensitive because fast exponential growth amplifies numerical
          error. $OO$ is usually moderate (self-limiting dynamics help), and linear-growth $NN$ is
          usually least sensitive.
        ]
      + Are your simulations for each model consistently underestimates? Overestimates? Do any
        results surprise you?
        #solution[
          For increasing solutions with Euler's method, coarse-step simulations are often
          overestimates, not underestimates. This is strongest for $MM$ and weaker for $NN$.

          A common surprise is that qualitatively correct models can still give quantitatively poor
          predictions when $Delta$ is too large. This is a valuable reminder to separate model error
          from numerical-method error.
        ]
    ]
  })

  //book_only(pagebreak())
  //question(slide[ ])

  //book_only(pagebreak())
  //question(slide[ ])
}
