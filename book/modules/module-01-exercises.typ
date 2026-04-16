#import "../libs/lib.typ": *
#show: e.prepare(question)


#let MM = $upright(bold("M"))$
#let SS = $upright(bold("S"))$
#let infty = math.infinity

#{
  lesson(title: [The Introduction], include "lesson-week-01.typ")
  question({
    learning_objectives(
      [Recognize how many assumptions must be made to formalize a problem into math.],
      [Distinguish Definitions/Assumptions/Relationships when setting up a modelling problem.],
      [Interpret commonly-used notation like "$~$" and "$\#$" in the context of a modelling
        problem.],
    )
    notes[
      Take your time with this question. It sets up the tone for the course. Make students *pin
      down* their assumptions.

      - Most students will not recognize half of the assumptions they are making. One of the goals
        is to get student aware of how many assumptions go into setting up a model and how
        mathematical notation can remove ambiguity.

      - Students will be wondering "when do we stop writing down our assumptions?" Have a good
        answer ready (along the lines of, "there's no algorithm that tells you when enough is
        enough; part of being in this class is learning what the standards are in a math class;
        other fields will have other standards (e.g., physics, or law, or engineering, etc.)")

      - The class may be split over two very reasonable interpretations:
        + $P(t)$ measures star fish at the *start* of year $t$.
        + $P(t)$ measures star fish at the *end* of year $t$.

        In case 1, you get
        $
          P(t+1) = P(t) + C(t).
        $
        In case 2, you get
        $
          P(t+1) = P(t) + C(t+1).
        $

        _Make sure you have this distinction straight in your head._ One way to help the students is
        to have them make a chart of Adults, Children, and Total Population for each year.

        Both formulations lead to $P(t+1) = P(t) + K P(t)$ *if you are careful*. Case 1 is easier to
        see; standardize on case 1.

      - They will come up with lots of definitions/notation. After collecting ideas, circle a
        minimal set to work with going forward. Explain that "there are many ways to model this
        situation, and we will focus on these definitions for now".
    ]
    slide[
      You are observing starfish that made their way to a previously uninhabited tide-pool. You’d
      like to predict the year-on-year population of these starfish. You start with a simple
      assumption
      $
        "#new children per year" ~ "size of current population"
      $

      + Come up with a mathematical model for the number of star fish in a given year. Your model
        should provide
        - *Definitions*: any notation, variables, and parameters you use.
        - *Assumptions*: what assumptions do you need to make to simplify the situation enough to
          get a model?
        - *Relationships*: how do quantities in your model relate to each other? (In math,
          relationships are often stated in terms of equations.)

      #solution([
        Definitions:
        - $P(t)$ is the number of starfish at the *start of year* $t$.
        - $K$ is the number of children born during the year per starfish per year.
        - $P(0) = P_0$ is the initial population of starfish.
        - $C(t)$ is the number of children born during year $t$.

        Assumptions:
        - Starfish have children once per year.
        - Baby starfish are ready to procreate at the next breeding cycle.
        - Starfish do not die or otherwise leave the tide-pool.
        - We are measuring starfish in units large enough that "fractions" make sense.

        Relationships:
        - $P(t+1) = P(t) + K P(t)$

        or
        - $C(t) = K P(t)$
        - $P(t+1) = P(t) + C(t)$
      ])

    ]
  })

  book_only(pagebreak())
  question.with(label: <ex:m1>)(
    slide[
      Let

      #aligned_terms(
        terms.item("(Birth Rate)", [$K=1.1$ children per starfish per year]),
        terms.item("(Initial Pop.)", [$P_0=10$ star fish]),
      )

      and define the model $MM_1$ to be the model for starfish population with these parameters.

      + Simulate the total number of starfish per year using Excel.
        #solution[
          #{
            let sim = solve_1d_ivp((t, P) => 1.1 * P, (0, 10), 5, Delta: 1, method: "euler")
            let cells = (
              "A1": "K",
              "A2": "1.1",
              "B1": "t",
              "C1": "P",
            )
            for i in range(sim.len()) {
              let row = i + 2
              let t = sim.at(i).at(0)
              let P = sim.at(i).at(1)
              cells.insert("B" + str(row), str(t))
              cells.insert("C" + str(row), str(calc.round(P, digits: 2)))
            }

            align(center, draw_spreadsheet(cols: 3, rows: 7, cells: cells))
          }
        ]
    ],
  )

  book_only(pagebreak())
  question.with(label: <ex:m1_star>)(
    slide[
      Recall the model $MM_1$ (from the #link(<ex:m1>)[previous question]).

      Define the model $MM^*_1$ to be
      $
        P(t) = P_0 e^(0.742t)
      $
      + Are $MM_1$ and $MM^*_1$ different models or the same?
        #solution([
          They are different models. $MM_1$ is a discrete model while $MM^*_1$ is a continuous
          model. Their values start nearly identical, but differ after many years.
        ])
      + Which of $MM_1$ or $MM^*_1$ is better?
        #solution([
          Neither model is intrinsically better than the other. It all depends on what you are
          trying to learn from the model.
        ])
      + List an advantage and a disadvantage for each of $MM_1$ and $MM^*_1$.
        #solution[
          $MM_1$ is easy to simulate and it is easy to explain where it came from. However, in order
          to find the population at year $t$, you must first find the population at all previous
          years.

          $MM^*_1$ is easy to compute (provided you have a calculator). It can compute the
          population at any time without computing the population at all previous times. However, it
          is harder to explain where it came from.
        ]
    ],
  )

  book_only(pagebreak())
  question.with(label: <ex:m_star>)(
    slide[
      In the model #link(<ex:m1>)[$MM_1$], we assumed the starfish had $K$ children at one point
      during the year.

      We want to create a model $MM_n$ where the starfish are assumed to have $K\/n$ children $n$
      times per year (at regular intervals).
      + Let $t_0$, $t_1$, $t_2$, ..., be the times that children are born in model $MM_n$. Find
        expressions for $t_0$, $t_1$, $t_2$, ....
        #solution[
          $t_0=0$, $t_1=1/n$, $t_2=2/n$, and in general,
          $
            t_i = i / n
          $
        ]
      + Find a (recursive) formula that gives the population for model $MM_n$.
        #solution[
          Let $P(0) = P_0$ be the population at time $0$. Then,
          $
            P(t + inline(1/n)) = P(t) + inline((K/n)) P(t) = (1 + inline(K/n)) P(t).
          $
        ]
      + Simulate the models $MM_1$, $MM_2$, $MM_3$ in Excel. Which grows fastest?
        #solution[
          $MM_3$ grows fastest.
        ]
      + What happens to $MM_n$ as $n arrow infinity$? #label_question_part(<ex:m_star2>)
        #solution[
          Simulations of $MM_n$ get larger as $n$ increases. These simulations appear to settle down
          (i.e., converge).
        ]
    ],
  )

  book_only(pagebreak())
  question(
    slide[
      #heading(depth: 3, outlined: false, [Exploring $MM_n$])

      We can rewrite the assumptions of $MM_n$ as follows:
      - At time $t$ there are $P_n (t)$ starfish.
      - $P_n (0) = 10$
      - During the time interval $(t, t + 1 / n)$ there will be (on average) $K / n$ new children
        per starfish.

      + Write an expression for $P_n (t + 1 / n)$ in terms of $P_n (t)$.
        #solution[
          $
            P_n (t + inline(1 / n)) = P_n (t) + inline((K / n)) P_n (t) = (1 + inline(K / n)) P_n (t).
          $

        ]
      + Write an expression for $Delta P_n$, the change in population from time $t$ to
        $t + Delta t$.
        #solution[
          With $Delta t = 1/n$,
          $
            Delta P_n = P_n (t + Delta t) - P_n (t) = P_n (t + inline(1 / n)) - P_n (t) = inline(K P_n (t) Delta t).
          $
        ]
      + Write an expression for $(Delta P_n) / (Delta t)$.
        #solution[
          $
            (Delta P_n) / (Delta t) = K P_n (t).
          $
        ]
      + Write down a differential equation relating $P'(t)$ to $P(t)$ where
        $P(t) = display(lim_(n arrow infty) P_n (t))$.
        #solution[
          Taking the limit $n arrow infty$, we have
          $
            lim_(n arrow infty) (Delta P_n) / (Delta t) = P'.
          $
          Putting it together, we arrive at the model
          $
            P'(t) = K P(t), quad P(0)=10.
          $
        ]
    ],
  )

  let M1 = [
    Recall the model $MM_1$ defined by:
    - $P_1(0) = 10$
    - $P_1(t + 1) = P_1(t) + K P_1(t)$ for $t >= 0$ years and $K = 1.1$.
  ]

  let MInf = [
    Define the model $MM_infty$ by:
    - $P(0) = 10$
    - $P'(t) = k P(t)$.
  ]


  book_only(pagebreak())
  question.with(label: <ex:m_infinity>)(
    slide[
      #book_only(
        // In book mode, put the models side by side
        table(
          columns: (2fr, 1fr),
          stroke: none,
          M1, MInf,
        ),
        otherwise: [#M1#MInf],
      )

      + If $k = K = 1.1$, does the model $MM_infty$ produce the same population estimates as $MM_1$?
        #solution[
          No. A quick side-by-side simulation/table shows they agree at $t=0$ but differ after that.
        ]
    ],
  )

  book_only(pagebreak())
  question(
    slide[
      Suppose that the estimates produced by $MM_1$ agree with the actual (measured) population of
      starfish.

      Fill out the table with #sym.checkmark or #sym.crossmark indicating which models have which
      properties.

      #let fill_box = it => book_only(box(width: 1fr, height: 4cm, it))
      #align(
        center,
        table(
          columns: 4,
          align: center,
          "Model", "Accuracy", "Explanatory", [(your favourite property)#solution[*continuous*]],
          $MM_1$,
          fill_box[#solution[#sym.checkmark]],
          fill_box[#solution[#sym.checkmark]],
          fill_box[#solution[#sym.crossmark]],

          $MM^*_1$,
          fill_box[#solution[#sym.checkmark]],
          fill_box[#solution[#sym.crossmark]],
          fill_box[#solution[#sym.checkmark]],

          $MM_infty$,
          fill_box[#solution[#sym.crossmark]],
          fill_box[#solution[#sym.checkmark]],
          fill_box[#solution[#sym.checkmark]],
        ),
      )
      #solution[
        - $MM_1$: accuracy #sym.checkmark (by definition), explanatory #sym.checkmark (we know where
          the model comes from).
        - $MM^*_1$: accuracy #sym.crossmark (matches $MM_1$ for a while), explanatory #sym.crossmark
          (this model seemingly came out of nowhere).
        - $MM_infty$: accuracy #sym.crossmark (values aren't even close), explanatory #sym.checkmark
          (we derived this model).

        The third column could be many things, but an important option is *continuous*. In this case
        - $MM_1$: #sym.crossmark #h(1em) $MM^*_1$: #sym.checkmark #h(1em) $MM_infty$: #sym.checkmark

        No model gets all #sym.checkmark. #text(size: 2em, emoji.face.frown)
      ]
    ],
  )

  book_only(pagebreak())
  question(
    slide[
      #book_only(
        // In book mode, put the models side by side
        table(
          columns: (2fr, 1fr),
          stroke: none,
          M1, MInf,
        ),
        otherwise: [#M1#MInf],
      )

      For this question, we will assume that that $MM_1$ accurately predicts the population.

      + If $k=K=1.1$, does $MM_infty$ underestimate or overestimate the population?
        #solution[
          Overestimate. Simulated values for $MM_infty$ sit above $MM_1$ once $t>0$.
        ]
      + If $k=0.5$, does $MM_infty$ underestimate or overestimate the population?
        #solution[
          Underestimate. With this smaller $k$, simulated $MM_infty$ values lie below $MM_1$.
        ]
      + Can you find a value of $k$ so that $MM_infty$ accurately predicts the population?
        #solution[
          Yes. Tune $k$ in your simulation until the yearly values align with $MM_1$.

          The matching value is $k = ln(2.1) approx 0.742$. With this choice, $MM_infty$ and $MM_1$
          agree (or nearly agree) at integer years.
        ]
    ],
  )

  book_only(pagebreak())
  question(
    slide(
      //force_two_column: false,
      [
        After more observations, scientists notice a seasonal effect on starfish. They propose a new
        model called $SS$:
        - $P(0) = 10$
        - $P'(t) = k dot P(t) dot |sin(2 π t)|$

        + What can you tell about the population (without trying to compute it)?
          #solution[
            Qualitatively, the population never decreases (for $k>0$), but growth speed oscillates
            seasonally.

            This means the population curve will drift up but in a "wavy" way.
          ]
        + Assuming $k = 1.1$, estimate the population after 10 years.
          #solution[
            Simulating, interpreting $P'(t) approx (Delta P)/(Delta t)$ with $Delta t = 0.01$, we
            get
            #{
              let Delta = 0.01
              let sim = solve_1d_ivp(
                (t, P) => 1.1 * P * calc.abs(calc.sin(2 * calc.pi * t)),
                (0, 10),
                1000,
                Delta: Delta,
                method: "euler",
              )
              let P10 = sim.last().at(1)
              [
                $P(10) approx #calc.round(P10, digits: 0)$.
              ]
            }
          ]
        + Assuming $k = 1.1$, estimate the population after 10.3 years.
          #solution[
            Using the same simulation method as in the previous part,
            #{
              let Delta = 0.01
              let sim = solve_1d_ivp(
                (t, P) => 1.1 * P * calc.abs(calc.sin(2 * calc.pi * t)),
                (0, 10),
                1030,
                Delta: Delta,
                method: "euler",
              )
              let P103 = sim.last().at(1)
              [
                $P(10.3) approx #calc.round(P103, digits: 0)$.
              ]
            }
          ]

      ],
    ),
  )
}


