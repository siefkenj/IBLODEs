#import "../libs/lib.typ": *
#show: e.prepare(question)


#let MM = $upright(bold("M"))$
#let SS = $upright(bold("S"))$
#let infty = math.infinity

#{
  lesson(title: [The Introduction], include "lesson-week-01.typ")
  question(label: <ex:intro_modelling>, {
    learning_objectives(
      [Recognize that modelling is an imperfect process and one must make choices when modelling.],
      [Recognize how many assumptions must be made to formalize a problem into math.],
      [Distinguish Definitions/Assumptions/Relationships when setting up a modelling problem.],
      [Interpret commonly-used notation like "$~$" and "$\#$" in the context of a modelling
        problem.],
    )
    notes[
      Take your time with this question. It sets up the tone for the course. Make students *pin
      down* their assumptions.

      - Emphasize that modelling is an *iterative* process. After you write some
        Definitions/Assumptions, you might revise or modify them after trying to write down
        Relationships.

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
        - *Assumptions*: what "real world" effects are important and which should be ignored? (Start
          simple and add complexity only as needed.)
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
  question.with(label: <ex:m1>)({
    learning_objectives(
      [Recognize that evaluating a recursive model is done iteratively (and may feel different than
        evaluating a function from calculus).],
      [Use a table to organize and track values when evaluating a recursive model.],
      [Use a spreadsheet to automate calculations that would otherwise be done by hand.],
    )
    notes[
      - *After @ex:table_by_hand[]*, do a brief introduction to spreadsheets before this question
        (only the basics). See @app:spreadsheet.

        Many students will claim that they already know spreadsheets, but what they mean is that
        they have seen spreadsheets. They are not familiar with at least one of: indexing
        conventions, dragging down to continue a formula or to extend a pattern in a row/column,
        locking an index with \$, etc.

      - Students may ask if they can use a "real" programming language instead. If you are teaching
        this class based on spreadsheets, tell them they are welcome to _also_ use another
        programming language, but they must be able to do the computations with a spreadsheet as
        well.

      - *Warning*: The iPad\/tablet/phone versions of spreadsheets are hard to use, waste time, and
        encounter strange errors. Tell students to avoid them. (Online spreadsheets tend to work
        better.)

    ]
    slide[
      Let

      #aligned_terms(
        terms.item("(Birth Rate)", [$K=1.1$ children per starfish per year]),
        terms.item("(Initial Pop.)", [$P_0=10$ star fish]),
      )

      and define the model $MM_1$ to be the model for starfish population with these parameters.

      + #label_question_part(<ex:table_by_hand>) Use a table to compute the starfish population for
        the first 3 years. You may use a calculator (but not a spreadsheet).
      + Simulate the total number of starfish per year using a spreadsheet.
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
    ]
  })

  book_only(pagebreak())
  question.with(label: <ex:m1_star>)({
    learning_objectives(
      [Recognize that a "model" includes both predictions and mechanisms. I.e., two _different_
        models can make the same predictions.],
      [Explore pros and cons of recursive models vs. models given by a single formula (like a
        function from calculus).],
    )
    notes[
      Students love closed-form expressions. They are comfortable with them, and because of that
      they think they are "better". This question aims to expose them to another perspective.

      - The number $0.74194$ is an approximation of $ln(2.1) approx #calc.ln(2.1)$. This number is
        *meant to be mysterious*. Don't tell the students where it comes from (though some may
        figure it out on their own).

      - $MM_1$ and $MM_1^*$ would produce the same output if $ln(2.1)$ were used instead of
        $0.74194$. As given, if students simulate $MM_1$ and $MM_1^*$ with a spreadsheet, they will
        see that the outputs differ after 1 year (if they show all decimal places) or after 11 years
        (if they round to whole numbers).

        Because of this, students will happily say that $MM_1$ and $MM^*_1$ are different because
        they produce different outputs. Acknowledge that that is a good answer, but encourage them
        to think deeper: if more decimal places of $0.74194$ were used such that the numbers matched
        exactly, would the models still be different?

      - In @ex:pros_cons_of_m_star[], many will say that $MM^*_1$ is "easier to calculate". This is
        a matter of perspective. By hand, $MM_1$ is easier! With a calculator $MM_1^*$ might be
        easier. The real key difference is that $MM^*_1$ can be calculated for a year directly,
        where as $MM_1$ requires you to calculate all previous years first.

      - Make sure that "explainability" comes out as an advantage for $MM_1$. This will be revisited
        in @ex:pros_and_cons_table.

      - Let them know that "`=EXP(X)`" is how you compute $e^X$ in a spreadsheet.


    ]
    slide[
      Recall the model $MM_1$ (from the #link(<ex:m1>)[previous question]).

      Define the model $MM^*_1$ to be
      $
        P(t) = P_0 e^(0.74194 space.thin t).
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
      + #label_question_part(<ex:pros_cons_of_m_star>) List an advantage and a disadvantage for each
        of $MM_1$ and $MM^*_1$.
        #solution[
          $MM_1$ is easy to simulate and it is easy to explain where it came from. However, in order
          to find the population at year $t$, you must first find the population at all previous
          years.

          $MM^*_1$ is easy to compute (provided you have a calculator). It can compute the
          population at any time without computing the population at all previous times. However, it
          is harder to explain where it came from.
        ]
    ]
  })

  book_only(pagebreak())
  question.with(label: <ex:m_star>)({
    learning_objectives(
      [Shift thinking about a recursive model as "$P(t+1) = f(P(t))$" to thinking
        "$P("next time") = f(P("previous time"))$".],
      [Simulate a more complicated recursive model.],
      [Compare data tables with different increments of the independent variable (e.g., different
        time steps).],
    )
    notes[
      In addition to exploring more complicated models, this exercise is the start of our journey of
      deriving Euler's method.
      - For @ex:fill_m2_table[], some students will put $t=0,1/2,1$ and others will want to put
        $t=0,1,2$. During discussion, emphasize that $t=0,1/2,1$ is correct.

        In general, the students who choose $t=0,1,2$ know something is happening at $t=1/2$, etc.,
        but don't include it on their table.
      - In spreadsheets it is easy to make two plots on the same axis *if they share an independent
        variable*. Since the $t$-series are different for different $MM_n$'s, they are very hard to
        compare graphically in a spreadsheet. Show students how to copy-and-paste their data into
        Desmos for graphing. See @app:spreadsheet.

      - While making a spreadsheet for $MM_2$/$MM_3$ may seem as easy as making a spreadsheet for
        $MM_1$, students are still beginners and will find it much more challenging.

      - The goal of @ex:m_star2[] is to explore and build intuition for the next few exercises.


    ]
    slide[
      In the model #link(<ex:m1>)[$MM_1$], we assumed the starfish had $K$ children at one point
      during the year.

      We want to create a model $MM_n$ where the starfish are assumed to have $K\/n$ children $n$
      times per year (at regular intervals).
      + #label_question_part(<ex:fill_m2_table>) Consider $MM_2$. Complete the following table
        assuming $K=1.1$.

        #{
          set align(center)
          table(
            columns: (.5fr, 1fr, 1fr),
            rows: 1.6em,
            align: horizon,
            [$t$], [$P(t)$], [$C(t)$],
            [0], [10], [#solution[$K/2 dot 10$]],
            [#solution[1/2]],
            [#solution[$10 + K/2 dot 10$]],
            [#solution[$K/2 dot (10 + K/2 dot 10)$]],

            [#solution[1]], [], [],
          )
        }

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
      + Simulate the models $MM_1$, $MM_2$, $MM_3$ with a spreadsheet. Which grows fastest?
        #solution[
          $MM_3$ grows fastest.
        ]
      + #label_question_part(<ex:m_star2>) What happens to $MM_n$ as $n arrow infinity$?
        #solution[
          Simulations of $MM_n$ get larger as $n$ increases. These simulations appear to settle down
          (i.e., converge).
        ]
    ]
  })

  lesson(title: [Deriving and Simulating Differential Equations], include "lesson-week-02.typ")
  book_only(pagebreak())
  question({
    learning_objectives(
      [- Convert a recursive model into a differential equation model by taking limits.],
    )
    notes[
      The goal of this exercise is to use Calculus-style thinking to _pass to_ a differential
      equation, not to rigorously create a differential equations model from a recursive model.
      Focus on the ideas and not details about interchanging limits and regularity.

      This question is hard for students and will take more guidance.

      - Explain that $Delta$ in expressions like "$Delta t$" means "change in $t$".

      - The "analysis details" of @ex:passing_to_limit_details[] should not be focused on. It is
        enough that students see the connection as reasonable.

    ]
    slide[
      #heading(depth: 3, outlined: false, [Exploring $MM_n$])

      We can rewrite the assumptions of $MM_n$ as follows:
      - At time $t$ there are $P_n (t)$ starfish.
      - $P_n (0) = 10$
      - During the time interval $(t, t + 1 / n)$ there will be $K / n$ new children per starfish.

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
      + Define $P(t) = display(lim_(n arrow infty) P_n (t))$.
        + Find $display(lim_(n arrow infty)) (Delta P_n) / (Delta t)$.
          #solution[
            $
              lim_(n arrow infty) (Delta P_n) / (Delta t) = lim_(n arrow infty) K P_n (t) = K P(t).
            $
          ]
        + #label_question_part(<ex:passing_to_limit_details>) Express $P'(t)$ using limits. Can you
          write $P'$ in terms of $Delta P_n$?
          #solution[
            By definition of the derivative,
            $
              P'(t) = lim_(Delta t arrow 0) (P(t + Delta t) - P(t)) / (Delta t).
            $
            We can rewrite this as
            $P'(t) = display(lim_(n arrow infty)) (P(t + inline(1 / n)) - P(t)) / (inline(1 / n))$.
            Since $Delta t = 1/n$ and $P(t+1/n) - P(t) approx Delta P_n$ when $n$ is large, we get
            $P'(t) = display(lim_(n arrow infty)) (Delta P_n) / (Delta t).$
          ]

        + Write down a differential equation relating $P'(t)$ to $P(t)$.
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
    ]
  })

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
  question.with(label: <ex:m_infinity>)({
    learning_objectives(
      // [Explain how a discrete model expressed as $Delta P= f(t,P)$ can produce a related continuous
      //   model $P'=f(t,P)$.],
      [Use $MM_n$'s to approximate $MM_infinity$.],
      [Recognize that when passing from a discrete model to a continuous one, the model predictions
        may differ even if the formulas look the same.],
      // [Notice that $Delta P= f(t,P)$ and $P'=f(t,P)$ produce different population estimates even
      //   though the right-hand side is the same.],
    )
    notes[
      This problem is about comparing continuous and discrete models, but *also* about previewing
      Euler's method.

      This question tries to balance:
      + Comparing discrete and continuous models.
      + Approximating continuous models as limits of discrete models.
      + Previewing Euler's method.

      Don't spend too much time on any one of these topics, since they come up again in future
      questions.
    ]
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

      + How can the model(s) $MM_n$ be used to approximate the model $MM_infinity$?
        #solution[
          We can approximate $MM_infinity$ by simulating $MM_n$ with a large $n$.
        ]

      + #label_question_part(<ex:comparing_m_infinity>) If $k = K = 1.1$, does the model $MM_infty$
        produce the same population estimates as $MM_1$?
        #solution[
          No. Simulating model $MM_n$, we see that $MM_a$ gives a larger population estimate than
          $MM_b$ when $a > b$. Thus $MM_infinity$ should give a larger population estimate than
          $MM_1$.
        ]
    ]
  })

  book_only(pagebreak())
  question(label: <ex:pros_and_cons_table>, {
    learning_objectives(
      [Be able to state pros and cons of different types of models.],
      [Identify whether a particular model is explanatory.],
      [State general properties that a model can have.],
      [Recognize that modelling is an imperfect process and one must make choices when modelling.],
    )
    notes[
      *Continuity* is the heading to focus on for the last column.

      The big idea is: no model gets checkmarks across an entire row. However, if we want checkmarks
      across an entire row, our best bet is to modify $MM_infinity$ to be accurate (trying to
      explain $MM_1^*$ _might_ be doable but it's not obvious how; $MM_1$ will never be continuous).

      After you fill out a the whole table, ask the students which model can be modified (slightly)
      to get all checkmarks.

      - Students will come up with _your favourite property_ ideas like: "easy to compute",
        "long-term accuracy", "sparks joy", etc..
      - If they do not mention *continuous* for _your favourite property_, bring it up yourself.
      - This question motivates the approach taken by the text for the entire semester. Take time to
        appropriately emphasize it.

    ]
    slide[
      A model is:
      - _Accurate_: if its predictions match the real-world measurements.
      - _Explanatory_: if you can explain how the model relates to your assumptions and the world.

      Suppose that the estimates produced by $MM_1$ agree with the actual (measured) population of
      starfish.

      Fill out the table with #sym.checkmark or #sym.crossmark indicating which models have which
      properties. In addition, think about *another* property that you would like a model to have
      and indicate which models have that property.

      #let fill_box = it => book_only(box(width: 1fr, height: 2cm, it))
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
        - $MM_1$: accuracy #sym.checkmark (by definition), explanatory #sym.checkmark (we can view
          this model as saying "the change in population is proportional to the current population",
          which directly relates to our original assumptions).
        - $MM^*_1$: accuracy #sym.crossmark (matches $MM_1$ for a while), explanatory #sym.crossmark
          (this model seemingly came out of nowhere).
        - $MM_infty$: accuracy #sym.crossmark (values aren't even close), explanatory #sym.checkmark
          (we can view this model as saying "the change in population is proportional to the current
          population", which directly relates to our original assumptions).

        The third column could be many things, but an important option is *continuous*. In this case
        - $MM_1$: #sym.crossmark #h(1em) $MM^*_1$: #sym.checkmark #h(1em) $MM_infty$: #sym.checkmark

        No model gets all #sym.checkmark. #text(size: 2em, emoji.face.frown)
      ]
    ]
  })

  book_only(pagebreak())
  question({
    learning_objectives(
      [Use $MM_n$'s to approximate $MM_infinity$.],
      [Simulate a differential equation using a spreadsheet.],
      [Experimentally tune a parameter in a model to match data.],
    )
    notes[
      Students have already done @ex:fixing_m_infinity1[] in @ex:comparing_m_infinity[], so it
      should be quick.

      Have students make a spreadsheet for @ex:fixing_m_infinity2[]; they should remember that they
      can simulate $MM_infinity$ by simulating $MM_n$ with large $n$.

      When they get to @ex:fixing_m_infinity3[], encourage them to make a spreadsheet with an
      "adjustable $k$". That is, a cell that stores the value of $k$, which can be changed
      on-the-fly.

      Conclude the question by giving a quick demo of making the spreadsheet and using a
      bisection-style search to find $k approx 0.742$.

      After finding $k approx 0.742$, we now have a model that checks all boxes from
      @ex:pros_and_cons_table[]! Emphasize this.

      - Students are still beginners at spreadsheets. Be patient, but make sure they are actually
        making spreadsheets (and not just trying to solve it in their heads).
      - This question is much easier if students build a spreadsheet with an "adjustable $k$".
        Encourage them to build a spreadsheet with adjustable $k$ right off the bat.
      - Many students will see the "0.74194" from $MM_1^*$ and plug it in as a guess.

        Ideally we want them to do some sort of bisection search; to aid this, erase formulas for
        $MM_1^*$ from the board before start this question.

      - After finding $k approx 0.742$, students may claim that this makes model $MM_1^*$
        "explanatory". However, this is not the case. For model $MM_infinity$, we can label each
        part of the equation with which assumption(s) it came from. Model $MM_1^*$ does not admit
        such a labelling. So, although model $MM_1^*$ becomes less mysterious, it doesn't become
        "explanatory".
    ]
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

      For this question, we will assume that $MM_1$ accurately predicts the population.

      + #label_question_part(<ex:fixing_m_infinity1>) If $k=K=1.1$, does $MM_infty$ underestimate or
        overestimate the population?
        #solution[
          Overestimate. Simulated values for $MM_infty$ sit above $MM_1$ once $t>0$.
        ]
      + #label_question_part(<ex:fixing_m_infinity2>) If $k=0.5$, does $MM_infty$ underestimate or
        overestimate the population?
        #solution[
          Underestimate. With this smaller $k$, simulated $MM_infty$ values lie below $MM_1$.
        ]
      + #label_question_part(<ex:fixing_m_infinity3>) Can you find a value of $k$ so that $MM_infty$
        accurately predicts the population?
        #solution[
          Yes. Tune $k$ in your simulation until the yearly values align with $MM_1$.

          The matching value is $k = ln(2.1) approx 0.742$. With this choice, $MM_infty$ and $MM_1$
          agree (or nearly agree) at integer years.
        ]
    ]
  })

  book_only(pagebreak())
  question({
    learning_objectives(
      [???],
    )
    notes[???]
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
    )
  })
}


