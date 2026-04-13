#import "../libs/lib.typ": *
#import "definitions.typ": show_def
#show: e.prepare(question)

#let MM = $upright(bold("M"))$
#let SS = $upright(bold("S"))$
#let OO = $upright(bold("O"))$
#let infty = math.infinity

#{
  book_only(pagebreak())
  question(
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
      + What should the graph of an equilibrium solution look like?
      + What should the graph of a typical solution look like?
      + What are ways to simplify the picture so we can more easily analyze solutions?

    ],
  )


  book_only(pagebreak())
  question(
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
      + Identify the equilibria in the phase portrait. What are the lengths of the vectors at those
        points?
      + Classify each equilibrium as stable/unstable.
      + Copy and paste data from your simulation spreadsheet into the Desmos plot. Does the
        resulting curve fit with the picture?
      // + Why is the vector at $(5,100)$ longer than the vector at $(10,100)$? Justify numerically.


    ],
  )


  book_only(pagebreak())
  question(
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
        + Sketch the equilibrium in _phase space_.
      + Suppose $(x(t),y(t))$ is a solution that satisfies $(x(0), y(0))=(3,3)$. Sketch a possible
        graph for this solution. Make sketches in both component and phase spaces.
      + Draw a possible phase portrait for this system that agrees with your answer to the previous
        parts.
      + Sketch a phase portrait for a _new_ system of differential equations that has a repelling
        equilibrium solution.
      + Sketch a phase portrait for a _new_ system of differential equations that has no equilibrium
        solutions.

    ],
  )


  book_only(pagebreak())
  question(
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
      Recall the #link(<ex:O_slope_field>)[slope field for model $OO$].

      + What would a phase portrait for model $OO$ look like? Draw it.
      + Where are the arrows the longest? Shortest?
      + How could you tell from a 1d phase portrait whether an equilibrium solution is
        attracting/repelling/etc.?
    ],
  )

  book_only(pagebreak())
  question.with(label: <ex:tree_model>)(
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
      + What do equilibrium solutions mean in terms of tree growth?
      + For $b=1$ what are the equilibrium solution(s)?

    ],
  )


  book_only(pagebreak())
  question(
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
      + What will happen to a tree with $(H(0), A(0))=(20,10)$? Does this depend on $b$?
      + What will happen to a tree with $(H(0), A(0))=(10,10)$? Does this depend on $b$?




    ],
  )


  book_only(pagebreak())
  question(
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
      + What does the parameter $b$ represent (in the real world)?
      + Applying Euler's method to this system shows that some solutions pass from the 1st to 4th
        quadrant of the phase plane. Is this realistic? Describe the life cycle of such a tree?

    ],
  )


  book_only(pagebreak())
  question(
    slide[
      Recall the tree model
      $
        H'(t) & = 0.3 dot.c A(t)-b dot.c H(t) \
        A'(t) & = -0.3 dot.c (H(t))^2 + A(t)
      $

      + Find all equilibrium solutions for $0 lt.eq b lt.eq 2$.
      + For which $b$ does a tree have the possibility of living forever? If the wind occasionally
        blew off a few random leaves, would that change your answer?
      +
        Find a value $b_5$ of $b$ so that there is an equilibrium with $H=5$.

        Find a value $b_(12)$ of $b$ so that there is an equilibrium with $H=12$.

      + Predict what happens to a tree near equilibrium (but not at equilibrium) when $b=b_5$. What
        about when $b=b_(12)$.
    ],
  )
}
