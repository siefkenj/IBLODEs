#import "../libs/_workbook.typ": aligned_terms

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
      You are observing starfish that made their way to a previously uninhabited tide-pool. You’d like to predict
      the year-on-year population of these starfish.
      You start with a simple assumption
      $
        "#new children per year" ~ "size of current population"
      $

      + Come up with a mathematical model for the number of star fish in a given year. Your model should
        - Define any notation (variables and parameters) you use
        - Include at least one formula/equation
        - Explain how your formula/equation relates to the starting assumption

      #solution([
        Definitions:
          - $P(t)$ is the number of starfish at the start of year $t$.
          - $K$ is the number of children born at the end of the year per starfish per year.
          - $P(0) = P_0$ is the initial population of starfish.

        Assumptions:
          - Starfish have children once per year.
          - Baby starfish are ready to procreate immediately.
          - Starfish do not die or otherwise leave the tide-pool.

        Relationships:
          - $P(t+1) = K dot P(t)$
      ])

    ],
  )

  book_only(pagebreak())
  question(
    slide[
      Let

      #aligned_terms(
        terms.item("(Birth Rate)", [$K=1.1$ children per starfish per year]),
        terms.item("(Initial Pop.)", [$P_0=10$ star fish]),
      )

      and define the model $MM_1$ to be the model for starfish population with these parameters.

      + Simulate the total number of starfish per year using Excel.
    ],
  )

  book_only(pagebreak())
  question(
    slide[
      Recall the model $MM_1$ (from the previous question).

      Define the model $MM^*_1$ to be
      $
        P(t) = P_0 e^(0.742t)
      $
      + Are $MM_1$ and $MM^*_1$ different models or the same?
        #solution([
          They are different models. $MM_1$ is a discrete model while $MM^*_1$ is a continuous model. Their values also
          differ after several steps.
        ])
      + Which of $MM_1$ or $MM^*_1$ is better?
        #solution([
          Neither model is intrinsically better than the other. It all depends on what you are trying to learn from the model.
        ])
      + List an advantage and a disadvantage for each of $MM_1$ and $MM^*_1$.
        #solution[
          $MM_1$ is easy to simulate and it is easy to explain where it came from. However,
          in order to find the population at year $t$, you must first find the population at all previous years.

          $MM^*_1$ is easy to compute (provided you have a calculator). It can compute the population at any time without
          computing the population at all previous times. However, it is harder to explain where it came from.
        ]
    ],
  )

  book_only(pagebreak())
  question(
    slide[
      In the model $MM_1$, we assumed the starfish had $K$ children at one point during the year.
      + Create a model $MM_n$ where the starfish are assumed to have $K\/n$ children $n$ times per year (at regular intervals).
      + Simulate the models $MM_1$, $MM_2$, $MM_3$ in Excel. Which grows fastest?
        #solution[
          $MM_3$ grows fastest.
        ]
      + What happens to $MM_n$ as $n arrow infinity$?
        #solution[
          $MM_n$ continues to increase as $n arrow infty$, however this increase is bounded and $display(lim_(n arrow infty) M_n)$ converges
          to another model.
        ]
    ],
  )

  book_only(pagebreak())
  question(
    slide[
      === Exploring $MM_n$

      We can rewrite the assumptions of $MM_n$ as follows:
      - At time $t$ there are $P_n(t)$ starfish.
      - $P_n(0) = 10$
      - During the time interval $(t, t + 1/n)$ there will be (on average) $K/n$ new children per starfish.

      + Write an expression for $P_n (t + 1/n)$ in terms of $P_n(t)$.
      + Write an expression for $Delta P_n$, the change in population from time $t$ to $t + Delta t$.
      + Write an expression for $(Delta P_n) / (Delta t)$.
      + Write down a differential equation relating $P'(t)$ to $P(t)$ where $P(t) = display(lim_(n arrow infty) P_n(t))$.
    ],
  )

  book_only(pagebreak())
  question(
    slide[
      Recall the model $MM_1$ defined by:
      - $P_1(0) = 10$
      - $P_1(t + 1) = K P(t)$ for $t >= 0$ years and $K = 1.1$.

      Define the model $MM_infty$ by:
      - $P(0) = 10$
      - $P'(t) = k P(t)$.

      + If $k = K = 1.1$, does the model $MM_infty$ produce the same population estimates as $MM_1$?
    ],
  )

  book_only(pagebreak())
  question(
    slide[
      Suppose that the estimates produced by $MM_1$ agree with the actual (measured) population of starfish.

      Fill out the table indicating which models have which properties.

      #align(
        center,
        table(
          columns: 4,
          align: center,
          "Model", "Accuracy", "Explanatory", "(your favourite property)",
          $MM_1$, none, none, none,
          $MM^*_1$, none, none, none,
          $MM_infty$, none, none, none,
        ),
      )
    ],
  )

  book_only(pagebreak())
  question(
    slide[
      #let M1 = [
        Recall the model $MM_1$ defined by:
        - $P_1(0) = 10$
        - $P_1(t + 1) = K P(t)$ for $t >= 0$ years and $K = 1.1$.
      ]

      #let MInf = [
        Define the model $MM_infty$ by:
        - $P(0) = 10$
        - $P'(t) = k P(t)$.
      ]

      #book_only(
        // In book mode, put the models side by side
        table(
          columns: (2fr, 1fr),
          stroke: none,
          M1, MInf
        ),
        otherwise: [#M1#MInf],
      )

      + Suppose that $MM_1$ accurately predicts the population. Can you find a value of $k$ so that $MM_infty$ accurately predicts the population?
    ],
  )

  book_only(pagebreak())
  question(
    slide(
      force_two_column: true,
      [
        After more observations, scientists notice a seasonal effect on starfish. They propose a new
        model called $SS$:
        - $P(0) = 10$
        - $P'(t) = k dot P(t) dot |sin(2 π t)|$

        + What can you tell about the population (without trying to compute it)?
        + Assuming $k = 1.1$, estimate the population after 10 years.
        + Assuming $k = 1.1$, estimate the population after 10.3 years.

      ],
    ),
  )
}
)

