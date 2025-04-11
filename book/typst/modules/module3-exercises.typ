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
      A simple model for population growth has the form
      $
        P'(t) = b dot P(t)
      $
      where $b$ is the birth rate.

      + Create a better model for population that includes both births and deaths.

    ],
  )

  book_only(pagebreak())
  question(
    slide[

      _Lotka-Volterra Predator-Prey_ models predict two populations, $F$ (foxes) and $R$ (rabbits), simultaneously. They take the form
      $
        F'(t) &= (B_F - D_F) dot F(t) \
        R'(t) &= (B_R - D_R) dot R(t)
      $
      where $B_{?}$ stands for births and $D_{?}$ stands for deaths.

      We will assume:
      - Foxes die at a constant rate.
      - Foxes mate when food is plentiful.
      - Rabbits mate at a constant rate.
      - Foxes eat rabbits.

      + Speculate on when $B_F$, $D_F$, $B_R$, and $D_R$ would be at their maximum(s)/minimum(s), given our assumptions.
      + Come up with appropriate formulas for $B_F$, $B_R$, $D_F$, and $D_R$.
    ],
  )

  book_only(pagebreak())
  question(
    slide[
      Suppose the population of $F$ (foxes) and $R$ (rabbits) evolves over time following the rule
      $
        F'(t) &= (0.01 dot R(t) - 1.1) dot F(t) \
        R'(t) &= (1.1 - 0.1 dot F(t)) dot R(t)
      $

      + Simulate the population of foxes and rabbits with a spreadsheet.
      + Do the populations continue to grow/shrink forever? Are they cyclic?
      + Should the humps/valleys in the rabbit and fox populations be in phase? Out of phase?
    ],
  )

  book_only(pagebreak())
  question(
    slide[
      // https://utoronto-my.sharepoint.com/:x:/g/personal/jason_siefken_utoronto_ca/Eay4QOMvy7lNr5pOKRv22NgBLGUw7qMpSCShUjeAdrhsHQ?e=bpg4CP
      Open the spreadsheet

      #link("https://uoft.me/foxes-and-rabbits")[https://uoft.me/foxes-and-rabbits]

      which contains an Euler approximation for the Foxes and Rabbits population.
      $
        F'(t) &= (0.01 dot R(t) - 1.1) dot F(t) \
        R'(t) &= (1.1 - 0.1 dot F(t)) dot R(t)
      $

      + Is the maximum population of the rabbits over/under estimated? Sometimes over, sometimes under?
      + What about the foxes?
      + What about the min populations?
    ],
  )

  book_only(pagebreak())
  question(
    slide(force_scale: 0.8em)[
      Open the spreadsheet

      #link("https://uoft.me/foxes-and-rabbits")[https://uoft.me/foxes-and-rabbits]

      which contains an Euler approximation for the Foxes and Rabbits population.
      $
        F'(t) &= (0.01 dot R(t) - 1.1) dot F(t) \
        R'(t) &= (1.1 - 0.1 dot F(t)) dot R(t)
      $

      #show_def("component_and_phase")

      + Plot the Fox vs. Rabbit population in the phase plane.
      + Should your plot show a closed curve or a spiral?
      + What “direction” do points move along the curve as
        time increases? Justify by referring to the model.
      + What is easier to see from plots in the phase plane
        than from component graphs (the graphs of fox and
        rabbit population vs. time)?
    ],
  )

  //book_only(pagebreak())
  //question(slide[ ])

  //book_only(pagebreak())
  //question(slide[ ])
}
