#import "../libs/lib.typ": *
#import "definitions.typ": show_def
#show: e.prepare(question)
#show ref: allow_missing_refs

#let OO = $upright(bold("O"))$

#{
  lesson(title: [Introduction to Equilibria & Stability], include "lesson-week-04.typ")
  question(label: <ex:LV_equilibrium>, {
    learning_objectives(
      [Find equilibrium solutions to a system of differential equations by numerical and graphical
        experimentation.],
      [Find equilibrium solutions to a system of differential equations by algebraic manipulation.],
      [Graph equilibrium solutions in phase space and component space.],
    )
    notes[
      This question is an introduction to equilibrium solutions. It starts geometrically before
      moving on to algebra.

      One of the key goals is for students to recognize equilibrium solutions as constant solutions
      _first_ and connect them to derivatives being zero _second_. We don't want students memorizing
      "derivative equals zero" as the definition of an equilibrium solution. We want them thinking
      of "derivative equals zero" as a property of equilibrium solutions. (The "solve for when the
      derivative is zero" trick only works for autonomous systems; it will mislead students working
      with non-autonomous systems.)

      - Students won't know what a "small curve" is. After giving them some time to think, take this
        up as a class discussion. Maximum radius is a definition they will agree with. They may
        suggest other ideas like curve length; don't spend a lot of time on complicated topology,
        formal definitions, or deriving any formulas; we just want to estimate from the graphs.

      - Some students will find the exact equilibrium solutions numerically, but they won't see any
        "curve" in their graph (Spreadsheets generally do not graph single points). Let these
        students know that a point counts as a curve, but wait until class discussion to explain
        this to everyone.
    ]
    slide(force_scale: .95em)[
      Open and make a copy of the spreadsheet

      #align(center, link("https://uoft.me/foxes-and-rabbits")[https://uoft.me/foxes-and-rabbits])

      which contains an Euler approximation for the Foxes and Rabbits population.
      $
        F'(t) & = (0.01 dot R(t) - 1.1) dot F(t) \
        R'(t) & = (1.1 - 0.1 dot F(t)) dot R(t)
      $

      #show_def("equilibrium_solution")

      + By changing initial conditions, what is the "smallest" curve you can get in phase space?
        What happens at those initial conditions?
        #solution[
          The smallest possible curve is a single point. Starting with initial conditions
          $(F, R) = (11, 110)$, the rabbit and fox populations remain constant.
        ]
      + What should $F'$ and $R'$ be if $F$ and $R$ are _equilibrium solutions_?
        #solution[
          At an equilibrium solution, neither population changes, so both derivatives must be zero:
          $F' = 0$ and $R' = 0$.
        ]
      + How many equilibrium solutions are there for the fox-and-rabbit system? Justify your answer.
        #solution[
          There are two equilibrium solutions.

          From
          $
            F' = (0.01dot R - 1.1) F
          $
          we get $F = 0$ or $R = 110$.

          From
          $
            R' = (1.1 - 0.1dot F) R
          $
          we get $R = 0$ or $F = 11$.

          Thus
          $
            (F, R) = (0, 0) wide "or" wide (F,R) = (11, 110).
          $
        ]
      + What do the equilibrium solutions look like in phase space? What about their graphs in
        component space?
        #solution[
          In phase space, equilibria appear as single points.

          As graphs in component space, they appear as horizontal lines.
        ]
    ]
  })

  book_only(pagebreak())
  question({
    learning_objectives(
      [Find equilibrium solutions to a single differential equation.],
      [Draw the phase space for a single differential equation.],
      [Reason about the behaviour of solutions to a single differential equation based on the
        behaviour of the derivative in regions of the phase space.],
    )
    notes[
      You may not have spent time on model $OO$ before. Don't spend time on explaining it now as the
      goal is not modelling but extracting information from the differential equation.

      By now, we have experience with the phase space for systems of ODEs but not with the phase
      space of a single ODE. Students will find the phase space of a single ODE unsettling.

      The goal of this question is to get students to generalize what they know about 2d phase
      spaces to the 1d case.

      - Students may need some prodding to get @ex:1d_phase_space2[]. Ask them to check the
        definition again and identify the dependent and independent variables. What should the axes
        of the phase space be?

      - Students are not used to thinking about graphs in 1d spaces. They are used to curves in 2d.
        They are used to graphs for solutions with different initial conditions never overlapping.

      - Draw the phase space for single equations *vertically*. This way you can place the phase
        space side by side with component space and interpret the graphs more easily.

      - Students will have a hard time with @ex:1d_phase_space3[]. They are used to derivatives of
        $P(t)$ depending on $t$ (in contrast to $P'$ depending on $P$).

        One way to help them is to work together to sketch sample solutions curves in component
        space: is the derivative here positive or negative? Big or small? Do this in a plot next to
        the phase space line and connect the two.

    ]
    slide(force_scale: 0.95em)[

      Recall the logistic model for starfish growth (introduced in @ex:models_MNO):
      #aligned_terms(
        terms.item(
          OO,
          [\# new children per year $~$ current population times the fraction of total resources
            remaining],
        ),
      )

      which can be modeled with the equation
      $
        P'(t) = k dot P(t) dot (1 - R_i / R dot P(t))
      $

      where
      - $P(t)$ is the population at time $t$
      - $k$ is a constant of proportionality
      - $R$ is the total number of resources
      - $R_i$ is the resources that one starfish wants to consume

      For this question, use $k = 1.1$, $R = 1$, and $R_i = 0.1$.

      + #label_question_part(<ex:1d_phase_space1>) What are the equilibrium solutions for model #OO?
        #solution[
          Solving $P' = 1.1 P (1 - 0.1 dot P)=0$, we get $P'=0$ when $P = 0$ or $1 - 0.1 dot P = 0$,
          that is $P=10$.

          Thus the equilibrium solutions are
          $
            P(t) = 0 quad "and" quad P(t) = 10.
          $
        ]
      + #label_question_part(<ex:1d_phase_space2>) What does the phase space for model #OO look
        like? What do graphs of equilibrium solutions look like?
        #solution[
          A phase space for model $OO$ looks like a line, since there is only one dependent variable
          (population). Equilibrium solutions still appear as dots along that line.
        ]
      + #label_question_part(<ex:1d_phase_space3>) Classify the behaviour of solutions that lie
        _between_ the equilibrium solutions. E.g., are they increasing, decreasing, oscillating?
        #solution[
          If $0 < P < 10$, then $P' > 0$, so solutions that start with a population between $0$ and
          $10$ increase. If $P > 10$, then $P' < 0$, so solutions that start with a population above
          $10$ decrease. Lastly, it makes no sense to have a negative population, but considered in
          the abstract, if $P < 0$, then $P' < 0$, so solutions that start with a "negative
          population" decrease.
        ]
    ]
  })

  book_only(pagebreak())
  question({
    learning_objectives(
      ([Classify equilibrium solutions as attracting, repelling, stable, or unstable.],),
    )
    notes[
      This question is students' first time classifying equilibrium solutions. There are formal and
      informal definitions. Focus on the informal definitions and leave the formal definitions for
      the students who demand precision.

      - There is a slide with just formal and informal definitions side-by-side. Give students some
        time to read this slide, then focus on the informal definitions.
      - The domain of solutions is important; stress that since $P >= 0$, we only consider solutions
        with $P >= 0$ when analyzing stability.
      - The language of "locally" gets students confused. Try to explain that when analyzing
        stability, we only care about what happens to solutions that start _near_ the equilibrium
        solution. However, for a specific equation, near may mean within 0.1 units, or withing 0.001
        units, etc. Since we cannot say up-front how close is close enough, we use the term
        "locally".

        This is precisely defined in the formal definitions, but let students know that the
        expectation is that they know how to apply the definitions, not that they can state
        everything precisely.
      - We write out a full classification. E.g., "stable and attracting" rather than just
        "attracting", even though these two are equivalent.

        As instructors, we want to know students understand the definitions individually (and that
        more than one can apply). Emphasize your standards of explanation for the course.

        *Don't* make a table of which classifications are mutually exclusive in this exercise. Save
        that for @ex:equilibrium_examples.

    ]
    slides_only(
      slide(force_scale: 0.75em)[
        #show_def("equilibrium_classification_informal")
        #show_def("equilibrium_classification_formal")
      ],
    )
    slide[

      #show_def("equilibrium_classification_informal")

      #slides_only(colbreak())
      Recall the starfish population model #OO given by
      $ P'(t) = k dot P(t) dot (1 - R_i / R dot P(t)) $
      Use $k = 1.1$, $R = 1$, and $R_i = 0.1$ unless instructed otherwise.

      + Classify the equilibrium solutions for model #OO as attracting, repelling, stable, or
        unstable.
        #solution[
          As found in @ex:1d_phase_space1, the equilibrium solutions occur when $P=0$ or $P=10$.

          *Case $P=10$*:

          If $P$ is slightly above $10$, then $P'$ is negative, so a solution starting at $P > 10$
          will decrease toward $10$.

          If $P$ is slightly below $10$, then $P'$ is positive, so a solution starting at $P < 10$
          will increase toward $10$.

          Thus solutions near $P=10$ move toward $10$, so $P=10$ is stable and attracting.

          *Case $P=0$*:

          Since we cannot have negative population, it only makes sense to consider solutions that
          start with $P>0$ when classifying the equilibrium $P=0$.

          If $P$ is slightly above $0$, then $P'$ is positive, so a solution starting at $P > 0$
          will increase away from $0$.

          Thus, $P=0$ is unstable and repelling.
        ]
      + Does changing $k$ change the nature of the equilibrium solutions? How can you tell?
        #solution[
          As long as $k>0$, the nature of the equilibrium solutions does not change (because the
          derivatives used in the arguments for stability/instability won't change sign).
        ]

    ]
  })

  book_only(pagebreak())
  question(label: <ex:equilibrium_examples>, {
    learning_objectives(
      [Create examples for each type of equilibrium solution classification.],
      [Determine which classifications are mutually exclusive and which must co-occur.],
    )
    notes[
      Give students time to sketch. They have already seen attracting and repelling examples. Stable
      but not attracting will be more challenging for them.

      After you discuss the examples, make a table and have students fill in the rows representing
      possible classifications. E.g., when done you'll have,
      #{
        set align(center)
        set text(size: .8em)
        table(
          columns: 4,
          "Attracting", "Repelling", "Stable", "Unstable",
          sym.checkmark, sym.crossmark, sym.checkmark, sym.crossmark,
          sym.crossmark, sym.crossmark, sym.checkmark, sym.crossmark,
          sym.crossmark, sym.checkmark, sym.crossmark, sym.checkmark,
          sym.crossmark, sym.crossmark, sym.crossmark, sym.checkmark,
        )
      }

      - After making the table, remind students that they shouldn't memorize the table. Instead,
        they must understand where the table comes from and should be able to explain each row (and
        each missing row).

      - Students will ask about unstable but not repelling. If they do, this is a great opportunity
        for them to make another sketch!
    ]
    slide(force_scale: 0.95em)[
      #show_def("equilibrium_classification_informal")

      #slides_only(colbreak())
      Let
      $
        F'(t) = class("normal", ?)
      $
      be an unknown differential equation with equilibrium solution $f(t) = 1$.

      #let ts = lq.linspace(0, 4, num: 80)
      #let ts_short = lq.linspace(0, 2, num: 80)
      #let eq_stroke = (thickness: 1.5pt, paint: green.darken(30%))
      #let nearby_stroke = (
        thickness: .6pt,
        paint: black,
        dash: (2pt, 1pt),
      )

      + Draw an example of what solutions might look like if $f$ is _attracting_.
        #solution[
          #align(center, lq.diagram(
            width: 5.5cm,
            xaxis: (label: [$t$], ticks: none),
            yaxis: (label: [$y$], tick-distance: .5),
            xlim: (0, 4),
            ylim: (0, 2),
            lq.plot(
              ts,
              ts.map(t => 1 + .7 * calc.exp(-1.4 * t)),
              mark: none,
              stroke: nearby_stroke,
            ),
            lq.plot(
              ts,
              ts.map(t => 1 + .35 * calc.exp(-1.1 * t)),
              mark: none,
              stroke: nearby_stroke,
            ),
            lq.plot(
              ts,
              ts.map(t => 1 - .35 * calc.exp(-1.1 * t)),
              mark: none,
              stroke: nearby_stroke,
            ),
            lq.plot(
              ts,
              ts.map(t => 1 - .7 * calc.exp(-1.4 * t)),
              mark: none,
              stroke: nearby_stroke,
            ),
            lq.plot(ts, ts.map(t => 1), mark: none, stroke: eq_stroke),
          ))
        ]
      + Draw an example of what solutions might look like if $f$ is _repelling_.
        #solution[
          #align(center, lq.diagram(
            width: 5.5cm,
            xaxis: (label: [$t$], ticks: none),
            yaxis: (label: [$y$], tick-distance: .5),
            xlim: (0, 2),
            ylim: (0, 2),
            lq.plot(
              ts_short,
              ts_short.map(t => 1 + .08 * calc.exp(t)),
              mark: none,
              stroke: nearby_stroke,
            ),
            lq.plot(
              ts_short,
              ts_short.map(t => 1 + .15 * calc.exp(t)),
              mark: none,
              stroke: nearby_stroke,
            ),
            lq.plot(
              ts_short,
              ts_short.map(t => 1 - .08 * calc.exp(t)),
              mark: none,
              stroke: nearby_stroke,
            ),
            lq.plot(
              ts_short,
              ts_short.map(t => 1 - .12 * calc.exp(t)),
              mark: none,
              stroke: nearby_stroke,
            ),
            lq.plot(ts_short, ts_short.map(t => 1), mark: none, stroke: eq_stroke),
          ))
        ]
      + Draw an example of what solutions might look like if $f$ is _stable_.
        #solution[
          #align(center, lq.diagram(
            width: 5.5cm,
            xaxis: (label: [$t$], ticks: none),
            yaxis: (label: [$y$], tick-distance: .5),
            xlim: (0, 4),
            ylim: (0, 2),
            lq.plot(
              ts,
              ts.map(t => 1 + .7 * calc.exp(-1.4 * t)),
              mark: none,
              stroke: nearby_stroke,
            ),
            lq.plot(
              ts,
              ts.map(t => 1 + .35 * calc.exp(-1.1 * t)),
              mark: none,
              stroke: nearby_stroke,
            ),
            lq.plot(
              ts,
              ts.map(t => 1 - .35 * calc.exp(-1.1 * t)),
              mark: none,
              stroke: nearby_stroke,
            ),
            lq.plot(
              ts,
              ts.map(t => 1 - .7 * calc.exp(-1.4 * t)),
              mark: none,
              stroke: nearby_stroke,
            ),
            lq.plot(ts, ts.map(t => 1), mark: none, stroke: eq_stroke),
          ))
          or
          #align(center, lq.diagram(
            width: 5.5cm,
            xaxis: (label: [$t$], ticks: none),
            yaxis: (label: [$y$], tick-distance: .5),
            xlim: (0, 4),
            ylim: (0, 2),
            lq.plot(ts, ts.map(t => 1.35), mark: none, stroke: nearby_stroke),
            lq.plot(ts, ts.map(t => 1.15), mark: none, stroke: nearby_stroke),
            lq.plot(ts, ts.map(t => .85), mark: none, stroke: nearby_stroke),
            lq.plot(ts, ts.map(t => .65), mark: none, stroke: nearby_stroke),
            lq.plot(ts, ts.map(t => 1), mark: none, stroke: eq_stroke),
          ))

          Here solutions near $y=1$ stay close to $y=1$ for all future time.
        ]
      + Could $f$ be stable but _not_ attracting?
        #solution[
          Yes.

          #align(center, lq.diagram(
            width: 5.5cm,
            xaxis: (label: [$t$], ticks: none),
            yaxis: (label: [$y$], tick-distance: .5),
            xlim: (0, 4),
            ylim: (0, 2),
            lq.plot(ts, ts.map(t => 1.35), mark: none, stroke: nearby_stroke),
            lq.plot(ts, ts.map(t => 1.15), mark: none, stroke: nearby_stroke),
            lq.plot(ts, ts.map(t => .85), mark: none, stroke: nearby_stroke),
            lq.plot(ts, ts.map(t => .65), mark: none, stroke: nearby_stroke),
            lq.plot(ts, ts.map(t => 1), mark: none, stroke: eq_stroke),
          ))

        ]
    ]
  })

  book_only(pagebreak())
  question.with(label: <ex:O_slope_field>)({
    learning_objectives(
      [Produce a slope field for a single differential equation.],
      [Use a slope field to identify equilibrium solutions.],
      [Use a slope field to reason about the shape of solutions.],
    )
    notes[
      Have students work on @ex:find_slope_field_slope[] and @ex:O_slope_field2[] and discuss before
      having students spend time on @ex:O_slope_field3[].

      Before students work on @ex:O_slope_field3[], explain to them what "qualitative description"
      means. I.e., how do you describe the shape of solutions without using any technical language?
      (E.g., if you were describing it to your 12 year old sibling.)

      - Don't underestimate @ex:find_slope_field_slope[]. We would _hope_ it is easy for students,
        but many are shaky on their tangent lines.
      - The featured slope field does not have any horizontal line segments. This is *on purpose*.
        We want students to reason about the slopes that aren't depicted.
      - For @ex:O_slope_field3[], students may not come up with the letter analogies (e.g.,
        "S"-shaped, "L"-shaped, hockey-stick-graph, etc.). These are commonly used in public
        discourse, so bring them up if they don't.

    ]
    slide(force_scale: 0.83em)[

      #slides_only(v(1em))

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

      A _slope field_ is a plot of small segments of tangent lines to solutions of a differential
      equation at different initial conditions.

      On the left is a slope field for model #OO, available at

      #link("https://www.desmos.com/calculator/ghavqzqqjn")

      + #label_question_part(<ex:find_slope_field_slope>) If you were sketching the slope field for
        model #OO by hand, what (straight) line would you sketch a segment of at $(5, 3)$? Write an
        equation for that line.
        #solution[
          At $(t, P) = (5,3)$, the slope is
          $
            P' = 1.1 dot 3 dot (1 - 0.1 dot 3) = 2.31.
          $
          So the tangent-line segment should lie on
          $
            y = 2.31(x - 5) + 3.
          $
        ]
      + #label_question_part(<ex:O_slope_field2>) How can you recognize equilibrium solutions in a
        slope field?
        #solution[
          Equilibrium solutions occur at $y$-values where the slope is always zero, so they appear
          as horizontal bands of zero-slope line segments. However, since not every point is given a
          line segment in a slope field, sometimes you need to interpolate, looking for places that
          the slopes change sign, and predicting that between those places, the slope must be zero.
        ]
      + #label_question_part(<ex:O_slope_field3>) Give qualitative descriptions of different
        solutions to the _differential equation_ used in model #OO (i.e., use words to describe
        them). Do all of those solutions make sense in terms of _model #(OO)_?
        #solution[
          Qualitatively:
          - If $0 < P(0) < 10$, solutions are "S"-shaped and increase toward $10$.
          - If $P(0) > 10$, solutions are "L"-shaped and decrease toward $10$.
          - If $P(0)=0$ or $P(0)=10$, the solutions are constant (horizontal lines).
          - If $P(0)<0$, the differential equation still has a solution, that curve downward.

          Only solutions with $P>=0$ make sense in the context of model $OO$.
        ]

    ]
  })
}
