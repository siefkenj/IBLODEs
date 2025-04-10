#import "@preview/lilaq:0.2.0" as lq
#import "../libs/_workbook.typ": aligned_terms, simple_table
#import "../libs/_ode_solvers.typ": solve_1d_ivp

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

      Consider the following argument for the population model #SS where
      $P'(t) = P(t) dot abs(sin(2 pi t))$ with $P(0) = 10$:

      #quote(block: true)[
        #set text(blue)
        At $t = 0$, the change in population $approx P'(0) = 0$, so
        $ P(1) approx P(0) + P'(0) dot 1 = P(0) = 10. $
        At $t = 1$, the change in population $approx P'(1) = 0$, so
        $ P(2) approx P(1) + P'(1) dot 1 = P(0) = 10. $
        And so on.

        So, the population of starfish remains constant.
      ]

      + Do you believe this argument? Can it be improved?
      + Simulate an improved version using a spreadsheet.

    ],
  )

  book_only(pagebreak())
  question({
    slide[
      (Simulating $MM_(infty)$ with different $Delta$s)

      #align(
        center,
        simple_table(
          headers: ([Time], [Pop. ($Delta = 0.1$)], [Time], [Pop. ($Delta = 0.2$)]),
          content: (
            [0.0],
            [10],
            [0.0],
            [10],
            [0.1],
            [11.1],
            [0.2],
            [12.2],
            [0.2],
            [12.321],
            [0.4],
            [14.884],
            [0.3],
            [13.67631],
            [0.6],
            [18.15848],
            [0.4],
            [15.1807041],
            [0.8],
            [22.1533456],
          ),
        ),
      )

      #slides_only(colbreak())
      + Compare $Delta = 0.1$ and $Delta = 0.2$. Which approximation grows faster?
      + Graph the population estimates for $Delta = 0.1$ and $Delta = 0.2$ on the same plot. What does the graph show?

      + What $Delta$s give the largest estimate for the population at time $t$?
      + Is there a limit as $Delta arrow 0$?
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
                $Delta=0.2$
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
        + Graph the population estimates for $Delta = 0.1$ and $Delta = 0.2$ on the same plot. What does the graph show?

        #v(.7cm)
        #enum.item(3)[What $Delta$s give the largest estimate for the population at time $t$?]
        + Is there a limit as $Delta arrow 0$?
      ],
    )
  })

  book_only(pagebreak())
  question(
    slide[


    ],
  )

  book_only(pagebreak())
  question(slide[ ])

  book_only(pagebreak())
  question(slide[ ])

  book_only(pagebreak())
  question(slide[ ])
}
