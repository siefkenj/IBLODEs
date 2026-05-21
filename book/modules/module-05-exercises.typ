#import "../libs/lib.typ": *
#import "definitions.typ": show_def
#show: e.prepare(question)
#show ref: allow_missing_refs

#let OO = $upright(bold("O"))$

#{
  lesson(title: [Phase Portraits], include "lesson-week-05.typ")
  book_only(pagebreak())
  question({
    learning_objectives(
      [Identify equilibrium solutions to systems of differential equations in (joint) component
        space.],
      [Explain why high-dimensional plots make the analysis of systems of differential equations
        difficult.],
    )
    notes[
      The purpose of this exercise is to motivate phase portraits. Students catch on fairly quickly.

      As a conclusion, rotate the plot in desmos to look straight down the $z$ axis and ask them if
      it looks familiar. Does it remind them of their plots in phase space for
      @ex:intro_to_phase_space?

      - The 3d slope field is hard to make in Desmos. The lengths of the slopes are not always the
        same. This is a limitation of the tool.

      - We don't expect students to produce 3d slope fields. This is a stepping stone to phase
        portraits, and we won't touch on it again.
    ]
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
        #solution[
          Foxes, Rabbits, and time (vertically).
        ]
      + What should the graph of an equilibrium solution look like?
        #solution[
          The fox and rabbit populations will be constant, but time will continue to increase, so
          the graph will be a vertical line.
        ]
      + What should the graph of a typical solution look like?
        #solution[
          A typical solution should look like a spiral/helix spiralling upwards.
        ]
      + What are ways to simplify the picture so we can more easily analyze solutions?
        #solution[
          We could remove the time variable, and only plot fox and rabbit axes.
        ]

    ]
  })


  book_only(pagebreak())
  question({
    learning_objectives(
      [Use phase portraits to visualize solutions to a system of differential equations.],
      [Use phase portraits to visualize and classify equilibria of a system of differential
        equations.],
      [Explain why a phase portrait is better than a "slope field in phase space".],
    )
    notes[
      We want students to have an intuitive understanding for phase portraits. This question works
      with a model they are familiar with and adds in the details of the phase portrait.

      Before finishing the exercise, have a discussion about what advantages phase portraits have
      over a "slope field in phase space" (the collapsed 3d slope field from the previous question).
      I.e., a phase portrait encodes direction (via the arrows) and speed (via the lengths of the
      arrows); these would be lost in a "slope field in phase space".

      - Students quickly become comfortable looking at phase portraits. However, many don't
        internalize the definition. Specifically, they have a hard time explaining how the vectors
        and their lengths relate to solutions.

      - For @ex:classify_lv_equilibria_with_phase_portrait[], students may have trouble classifying
        $(0,0)$ as unstable *not repelling*. Be prepared with an explanation.

      - For @ex:put_data_in_phase_portrait[], remind students that they already have a spreadsheet
        from @ex:intro_to_phase_space; they can reuse it.

        After copy-and-pasting simulated data into Desmos, ask students whether solutions will
        spiral out or not. We concluded in @ex:intro_to_phase_space that solutions do _not_ spiral,
        but many student will have forgotten this.

        This question is also a good chance to mention that phase portraits can be used to
        double-check a simulation. If you programmed the simulation correctly, the graphed curve
        should follow the arrows!
    ]
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
        #solution[
          The horizontal axis is fox population and the vertical axis is rabbit population.
        ]
      + Identify the equilibria in the phase portrait. What are the lengths of the vectors at those
        points?
        #solution[
          The equilibria occur when $F'=0$ and $R'=0$. We have already solved for those in
          @ex:LV_equilibrium, finding $(F,R)=(0,0)$ and $(F,R)=(11,110)$. At these points, the
          lengths of the vectors in a phase portrait will be zero.
        ]
      + #label_question_part(<ex:classify_lv_equilibria_with_phase_portrait>) Classify each
        equilibrium as stable/unstable.
        #solution[
          $(0,0)$ is unstable and not repelling. $(11,110)$ appears stable. It is hard to tell from
          the phase portrait whether it is attracting or very subtly repelling, but our analysis in
          @ex:intro_to_phase_space shows that it stable (and not attracting).
        ]
      + #label_question_part(<ex:put_data_in_phase_portrait>) Copy and paste data from your
        simulation spreadsheet into the Desmos plot. Does the resulting curve fit with the picture?
        #solution[
          Yes. The curve follows the arrows.
        ]
      // + Why is the vector at $(5,100)$ longer than the vector at $(10,100)$? Justify numerically.


    ]
  })


  book_only(pagebreak())
  question(label: <ex:exploring_equilibria>, {
    learning_objectives(
      [Create graphs in component and phase spaces for equilibrium solutions and solutions near
        equilibrium solutions.],
      [Identify whether an equilibrium solution is attracting, repelling, or neither based on phase
        portraits.],
      [Create phase portraits for systems with attracting or repelling equilibrium solutions, as
        well as for systems with no equilibrium solution.],
    )
    notes[
      This question is about the relationship between component space, phase space, and phase
      portraits. It presents an opportunity for you to set expectations about drawing graphs and
      phase portraits (how many arrows, what about their lengths, etc.).

      - Students are still beginner at thinking in terms of phase space and component space. *Do not
        underestimate this exercise.* It will be hard for them.

      - @ex:sketch_component_graphs_of_equilibrium[] will be easy for students, but many will get
        stuck on @ex:sketch_phase_space_of_equilibrium[]. You can prompt them with: at time $0$,
        what are the $x$ and $y$ values? How about at time $1$? $2$? Can you plot it now for all
        times in phase space?

      - @ex:sketch_attracting_equilibrium[] will also be hard. Prompting again helps. Ask them at
        time $t=1$, where should their non-equilibrium solution be? What about time $t=2$? $t=3$?
        Now sketch.

      - After students become comfortable with lines in phase space heading towards or away from
        equilibria, you/they can bring up spirals.

      - Clarify to students expectations around phase portraits: there need to be enough arrows to
        know what's going on (in all quadrants), arrows need to be _straight_, the length of the
        arrows is short near equilibria and longer farther away.

        Also, discuss what it means for the phase portrait to represent a _continuous_ system. For
        the level of rigour in the course, it is sufficient that the length of the arrows doesn't
        change too suddenly, nor does the direction of the arrows change suddenly.
    ]
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
        + #label_question_part(<ex:sketch_component_graphs_of_equilibrium>) Sketch component graphs
          for the equilibrium solution.
          #solution[
            #let ts = lq.linspace(0, 4, num: 80)

            #align(center, stack(
              lq.diagram(
                width: 4cm,
                title: [$x$ Component],
                xaxis: (label: [$t$], ticks: none),
                yaxis: (label: [$x$], tick-distance: 1),
                xlim: (0, 4),
                ylim: (0, 5),
                lq.plot(ts, ts.map(t => 2), mark: none, stroke: (thickness: 1.3pt)),
              ),
              lq.diagram(
                width: 4cm,
                title: [$y$ Component],
                xaxis: (label: [$t$], ticks: none),
                yaxis: (label: [$y$], tick-distance: 1),
                xlim: (0, 4),
                ylim: (0, 5),
                lq.plot(ts, ts.map(t => 4), mark: none, stroke: (
                  thickness: 1.3pt,
                  dash: (3pt, 1pt),
                )),
              ),
              dir: ltr,
              spacing: 1em,
            ))
          ]
        + #label_question_part(<ex:sketch_phase_space_of_equilibrium>) Sketch the equilibrium in
          _phase space_.
          #solution[
            #align(center, lq.diagram(
              width: 4cm,
              height: 4cm,
              xaxis: (label: [$x$], tick-distance: 1),
              yaxis: (label: [$y$], tick-distance: 1),
              xlim: (0, 5),
              ylim: (0, 5),
              lq.line((1.9, 4), (2.1, 4), stroke: (thickness: 1.5pt)),
              lq.line((2, 3.9), (2, 4.1), stroke: (thickness: 1.5pt)),
              lq.place(2.65, 4.2, $(2,4)$),
            ))
          ]
      + #label_question_part(<ex:sketch_attracting_equilibrium>) Suppose $(x(t),y(t))$ is a solution
        that satisfies $(x(0), y(0))=(3,3)$. Sketch a possible graph for this solution. Make
        sketches in both component and phase spaces.
        #solution[
          #let ts = lq.linspace(0, 4, num: 80)
          #let X(t) = 2 + calc.exp(-t)
          #let Y(t) = 4 - calc.exp(-t)

          #align(center, stack(
            lq.diagram(
              width: 4cm,
              title: [$x$ Component],
              xaxis: (label: [$t$], ticks: none),
              yaxis: (label: [$x$], tick-distance: 1),
              xlim: (0, 4),
              ylim: (0, 5),
              lq.plot(ts, ts.map(t => X(t)), mark: none, stroke: (thickness: 1.2pt)),
            ),
            lq.diagram(
              width: 4cm,
              title: [$y$ Component],
              xaxis: (label: [$t$], ticks: none),
              yaxis: (label: [$y$], tick-distance: 1),
              xlim: (0, 4),
              ylim: (0, 5),
              lq.plot(ts, ts.map(t => Y(t)), mark: none, stroke: (
                thickness: 1.2pt,
                dash: (3pt, 1pt),
              )),
            ),
            dir: ltr,
            spacing: 1em,
          ))

          #v(.7em)

          #align(center, lq.diagram(
            width: 5.5cm,
            title: [Phase Space],
            xaxis: (label: [$x$], tick-distance: .5),
            yaxis: (label: [$y$], tick-distance: .5),
            xlim: (1.9, 3.1),
            ylim: (2.9, 4.1),
            lq.plot(ts.map(t => X(t)), ts.map(t => Y(t)), mark: none, stroke: (thickness: 1.2pt)),
            lq.place(2.95, 3.05, $(3,3)$),
            lq.place(2.1, 3.95, $(2,4)$),
          ))
        ]
      + Draw a possible _phase portrait_ for this system that agrees with your answer to the
        previous parts.
        #solution[
          #align(center, vector_field(
            ((x, y) => (2 - x, 4 - y)),
            xlim: (0, 5),
            ylim: (0, 5),
            spacing: (.6, .6),
            scale_segments: 15,
            width: 4.5cm,
            height: 4.5cm,
            xaxis: (position: 0, tip: tiptoe.stealth, label: [$x$], tick-distance: 1),
            yaxis: (position: 0, tip: tiptoe.stealth, label: [$y$], tick-distance: 1),
            lq.place(2.35, 4.2, $(2,4)$),
          ))
        ]
      + Sketch a phase portrait for a _new_ system of differential equations that has a repelling
        equilibrium solution.
        #solution[
          The phase portrait below has a repelling equilibrium at $(0,0)$.

          #align(center, vector_field(
            ((x, y) => (x, y)),
            xlim: (-3, 3),
            ylim: (-3, 3),
            spacing: (.75, .75),
            scale_segments: 15,
            width: 5cm,
            height: 5cm,
            xaxis: (position: 0, tip: tiptoe.stealth),
            yaxis: (position: 0, tip: tiptoe.stealth),
          ))
        ]
      + Sketch a phase portrait for a _new_ system of differential equations that has no equilibrium
        solutions.
        #solution[
          The phase portrait below is for a system that has no equilibrium solution.

          #align(center, vector_field(
            ((x, y) => (1, 1)),
            xlim: (-3, 3),
            ylim: (-3, 3),
            spacing: (.75, .75),
            scale_segments: 25,
            width: 5cm,
            height: 5cm,
            xaxis: (position: 0, tip: tiptoe.stealth),
            yaxis: (position: 0, tip: tiptoe.stealth),
          ))
        ]

    ]
  })


  book_only(pagebreak())
  question({
    learning_objectives(
      [Draw phase portraits for a single differential equation.],
      [Identify whether an equilibrium solution for a single differential equation is attracting,
        repelling, or neither based on a phase portrait.],
    )
    notes[
      Often times, the 1-d case is easier than the 2-d case. However, students have trouble with 1-d
      graphs. For this reason, we introduced 2-d phase portraits first. Now it's time to analyze the
      1-d case.

      This exercise can be left as homework if you're running short on time (1-d phase portraits
      play a minor role compared to 2-d ones).

      - Students often struggle to identify what the phase space looks like,
        @ex:dimension_phase_space_modelO[] addresses this.

      - In @ex:dimension_phase_space_modelO_equilibrium[], if it didn't come up already, discuss
        what solutions look like when graphed in phase space.
    ]
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
      // XXX put back link later; it breaks if the reference is not found.
      // Recall the #link(<ex:O_slope_field>)[slope field for model $OO$].
      Recall the slope field for model $OO$, which had an equation of the form $P'= space.thin ???$.

      + #label_question_part(<ex:dimension_phase_space_modelO>)

        + What is the dimension of the phase space for model $OO$?
          #solution[
            The phase space is 1-dimensional, since there is only one dependent variable.
          ]

        + What would a phase portrait for model $OO$ look like? Draw it.
          #solution[
            Since model $OO$ has one dependent variable, the phase portrait would lie on a line with
            arrows pointing down below $0$, up between $0$ and $10$, and down above $10$.

            // XXX Make a figure here
          ]
      + #label_question_part(<ex:dimension_phase_space_modelO_arrow_size>) Where are the arrows the
        longest? Shortest?
        #solution[
          The arrows are longest for very negative or very positive values. They are also reasonably
          long near $5$. The arrows are shortest near $0$ and $10$.
        ]
      + #label_question_part(<ex:dimension_phase_space_modelO_equilibrium>) How could you tell from
        a 1d phase portrait whether an equilibrium solution is attracting/repelling/etc.?
        #solution[
          Looking at arrows on both sides of the equilibrium, if both point toward the equilibrium,
          it is attracting (and stable). If both point away, it is repelling (unstable). If one side
          points in and the other out, it is unstable but not repelling.
        ]
    ]
  })

  book_only(pagebreak())
  question.with(label: <ex:tree_model>)({
    learning_objectives(
      [Use Desmos to make a phase portrait for a system of differential equations that has a
        parameter.],
      [Interpret the meaning of equilibrium solutions in the context of a model.],
    )
    notes[
      This is the start of the _tree model_, which will be used throughout the course. *Do not skip*
      this question.

      Rather than deal with the complexity of the modelling process now, the aim of this question is
      to get familiar with the equations/visualization of the equations for the tree model. We will
      practice the modelling process for the tree model in future exercises.

      - The goal of @ex:tree_model_part1[] is for students to translate between the model-specific
        variables $H$ and $A$ into the desmos variables $x$ and $y$, and to figure out how to set
        bounds on a parameter in Desmos.

        After they have worked for a minute, make a general announcement: "If you're stuck, think
        about which variables in the model correspond to $x$ and $y$ in Desmos."

        Wrap this part up with a Demo. Show how to set the bounds of $b$ (many will not have even
        thought about it).

      - In @ex:tree_model_part3[], some will miss the equilibrium at $(0,0)$.

        Some students will find the equilibriums graphically rather than algebraically. Make sure
        all students eventually find the equilibrium algebraically.
      // Tree model is important
    ]
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

      + #label_question_part(<ex:tree_model_part1>) Modify

        #link("https://www.desmos.com/calculator/vrk0q4espx")

        to make a phase portrait for the tree model.

        #solution[
          Make
          $
            X(x,y)=0.3 dot y - b dot x \
            Y(x,y)=-0.3 dot x^2 + y
          $
          and set the bounds of the slider for $b$ to be $0 <= b <= 2$.
        ]
      + What do equilibrium solutions mean in terms of tree growth?
        #solution[
          Equilibria mean that the tree is not changing in height and the leaf area of the tree is
          not changing.
        ]
      + #label_question_part(<ex:tree_model_part3>) For $b=1$ what are the equilibrium solution(s)?
        #solution[
          Solving for when $H'=0$ and $A'=0$, we see the equilibria are
          $
            (H,A) = (0,0) quad "and" quad (H,A) = (100/9, 1000/27).
          $
        ]

    ]
  })


  book_only(pagebreak())
  question(label: <ex:tree_modelling_with_spreadsheet>, {
    learning_objectives(
      [Simulate the solution to a system of differential equations with a parameter, using a
        spreadsheet.],
      [Overlay a simulated solution on a phase portrait to check the simulation.],
      [Interpret solutions to initial value problems in the context of a model.],
    )
    notes[
      None of these exercises are new, but the context of the tree model is new. Give them time to
      work and then discuss.


      - Make sure students actually make the spreadsheet (from scratch). They still need practice.
      - Make sure to discuss what the 2nd, 3rd, and 4th quadrants mean in terms of the model: none
        of them make sense.

        This is discussed in more detail in @ex:tree_model_euler[].
      - For @ex:sim_tree_20_10[] and @ex:sim_tree_10_10[], students can investigate graphically (no
        need to simulate for different values of $b$, though doing simulations doesn't hurt!).
    ]
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
        #solution[
          For $b=1$, $Delta = 0.1$ and initial conditions $(H(0),A(0))=(10,17)$, we get:

          #{
            let b = 1.0
            let Delta = 0.1
            let H0 = 10.0
            let A0 = 17.0
            let F(H, A) = (0.3 * A - b * H, -0.3 * H * H + A)
            let sim = solve_2d_ivp(F, (H0, A0), 20, Delta: Delta, method: "euler")

            let cells = (
              "A1": "Delta",
              "A2": str(Delta),
              "A4": $H_0$,
              "A5": str(H0),
              "A6": $A_0$,
              "A7": str(A0),
              "B1": "H",
              "C1": "A",
              "D1": "H'",
              "E1": "A'",
            )

            for i in range(6) {
              let row = i + 2
              let H = sim.at(i).at(0)
              let A = sim.at(i).at(1)
              let H_prime = 0.3 * A - b * H
              let A_prime = -0.3 * H * H + A

              cells.insert("B" + str(row), str(calc.round(H, digits: 2)))
              cells.insert("C" + str(row), str(calc.round(A, digits: 2)))
              cells.insert("D" + str(row), str(calc.round(H_prime, digits: 2)))
              cells.insert("E" + str(row), str(calc.round(A_prime, digits: 2)))
            }

            align(center, draw_spreadsheet(cols: 5, rows: 7, cells: cells))

            v(.8em)

            align(center, vector_field(
              F,
              width: 6cm,
              height: 6cm,
              title: [Phase Portrait for $b=1$],
              xaxis: (position: 0, tip: tiptoe.stealth, label: [$H$], tick-distance: 5),
              yaxis: (position: 0, tip: tiptoe.stealth, label: [$A$], tick-distance: 10),
              xlim: (0, 21),
              ylim: (-5, 22),
              spacing: (1.5, 2.5),
              scale_segments: 10,
              lq.plot(
                sim.map(((H, A)) => H),
                sim.map(((H, A)) => A),
                mark: none,
                stroke: (thickness: 2.3pt),
              ),
            ))
          }

          Above is a plot of (a segment of) the simulated solution overlaid on the phase portrait.
        ]
      + #label_question_part(<ex:sim_tree_20_10>) What will happen to a tree with
        $(H(0), A(0))=(20,10)$? Does this depend on $b$?
        #solution[
          Both the tree height and the leaf area will initially decrease. Following the arrows in
          the phase portrait, we see that the leaf area will decrease to $0$ (and then the tree will
          die).

          This happens no matter the value of $b in [0,2]$.
        ]
      + #label_question_part(<ex:sim_tree_10_10>) What will happen to a tree with
        $(H(0), A(0))=(10,10)$? Does this depend on $b$?
        #solution[
          Again, initially the tree height and leaf area will both decrease. However for $b > 1.25$
          this decrease "turns around" before the tree is dead, and the height and leaf area
          increase again.
        ]




    ]
  })


  book_only(pagebreak())
  question({
    learning_objectives(
      [Match premises to terms of equations for an existing model.],
      [Interpret parameters of a model in terms of the real world.],
    )
    notes[
      Now that we are familiar with the mechanics of the tree model, it is time to see where it
      comes from.

      We aren't doing a full modelling process, but we are practicing linking an existing model's
      assumptions to differential equations.

      - In @ex:tree_model_premises[], $"P"_"leaves"$ and $"P"_"energy 1/2"$ must be combined to get
        the terms in the $A'$ equation.
      - In @ex:tree_model_b[], students will have some creative answers. Not all of them will align
        with the fact that, all else being equal, large $b$ means a tree sinks faster.

        Two reasonable answers are: $b$ is the inverse viscosity of the swamp, or $b$ is the density
        of the tree (suggested by a student in 2025!).

        Students may say something like "$b$ is the speed of sinking". Encourage them to think about
        real world properties that *$b$ could represent*, as opposed to how $b$ influences the
        equations.
    ]
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


      + #label_question_part(<ex:tree_model_premises>) How are the premises expressed in the
        differential equations?
        #solution[
          $
            H' &= underbrace(0.3 dot A, "P"_("height 1")) & underbrace(- quad b dot H, "P"_("height 2")) \
            A' &= underbrace(-0.3 dot H^2, "P"_"leaves" space \& space "P"_("energy 2")) wide &+ underbrace(A, "P"_"leaves" space \& space "P"_("energy 1"))
          $
        ]
      + #label_question_part(<ex:tree_model_b>) What does the parameter $b$ represent (in the real
        world)?
        #solution[
          $b$ is related to the rate of sinking. The larger $b$, the more the tree sinks, given its
          height. $b$ could be interpreted as the inverse viscosity of the swamp.
        ]
      + #label_question_part(<ex:tree_model_euler>) Applying Euler's method to this system shows
        that some solutions pass from the 1st to 4th quadrant of the phase plane. Is this realistic?
        Describe the life cycle of such a tree?
        #solution[
          No. A tree in the 4th quadrant would have "negative" leaf area, which makes no sense.
          Realistically, when a tree reaches 0 leaf area, it should stay at 0 leaf area but continue
          sinking (negative values of $H$ could be interpreted as the tree sinking below the
          ground).
        ]

    ]
  })


  book_only(pagebreak())
  question({
    learning_objectives(
      [Find equilibrium solutions to a system of differential equations with a parameter.],
      [Study the stability of equilibrium solutions.],
      [Explain the consequences of stable/unstable equilibrium for a model.],
    )
    notes[
      We are motivating:
      - The importance/relevance of equilibrium solutions.
      - The need for formal methods (beyond graphical inspection) for classifying equilibria.

      At the moment, we can find equilibrium solutions by solving equations, but to classify them as
      stable/unstable, we rely on visualizations and simulation. The conclusion of this question is:
      _we need better tools for classifying equilibria_.

      - In @ex:tree_model_part3[], we solve for the equilibrium solutions when $b=1$. We're doing it
        generally now.
      - In @ex:tree_model_live_forever[], students need to interpret what stable/unstable means in
        the "real world". The $(0,0)$ equilibrium doesn't count as the tree "living". It needs
        positive height/leaf area to be considered alive.

        Students may struggle with converting "if the wind blows..." into mathematics. One way to
        assist is to prompt students: "If the tree is at the equilibrium, and then a few leaves blow
        off, where in phase space will the tree be? What happens to the tree from that point on?"

      - @ex:tree_model_b5[] and @ex:tree_model_b12[] can be left as homework if time is short.
    ]
    slide[
      Recall the tree model
      $
        H'(t) & = 0.3 dot.c A(t)-b dot.c H(t) \
        A'(t) & = -0.3 dot.c (H(t))^2 + A(t)
      $

      + Find all equilibrium solutions for $0 lt.eq b lt.eq 2$.
        #solution[
          Solving
          $
            0 = 0.3 dot A - b dot H wide "and" wide 0 = -0.3 dot H^2 + A,
          $
          we get
          $
            (H,A)=(0,0) wide "or" wide
            (H,A)= (100/9 b, 1000/27 b^2).
          $
        ]
      + #label_question_part(<ex:tree_model_live_forever>) For which $b$ does a tree have the
        possibility of living forever? If the wind occasionally blew off a few random leaves, would
        that change your answer?
        #solution[
          If the tree is exactly at the equilibrium $(H,A) = (100/9 b, 1000/27 b^2)$, it will live
          forever.

          However, if we account for minor perturbations, like a few leaves blowing off, the
          stability of the equilibrium becomes important. In that case, if the equilibrium is stable
          or attracting, the tree has a possibility of living forever.

          By inspecting the phase portrait, it appears that when $b > 1$, arrows near this
          equilibrium spiral inwards, and so the equilibrium is attracting. When $b < 1$, arrows
          near this equilibrium spiral outwards, and so the equilibrium is repelling. When $b=1$, it
          is hard to tell what is happening.
        ]
      + #label_question_part(<ex:tree_model_b5>)
        Find a value $b_5$ of $b$ so that there is an equilibrium with $H=5$.
        #solution[
          At a (positive) equilibrium, $H = 100/9 b$.

          Solving $5=100/9 b_5$, we get $b_5 = 9/20 = 0.45$.
        ]

        Find a value $b_(12)$ of $b$ so that there is an equilibrium with $H=12$.
        #solution[
          At a (positive) equilibrium, $H = 100/9 b$.

          Solving $12=100/9 b_(12)$, we get $b_(12) = 9/100 dot 12 = 108/100 = 1.08$.
        ]

      + #label_question_part(<ex:tree_model_b12>) Predict what happens to a tree near equilibrium
        (but not at equilibrium) when $b=b_5$. What about when $b=b_(12)$.
        #solution[
          A tree near equilibrium when $b=b_5$ will eventually die. The fluctuations in leaf area
          and height get bigger and bigger until it has no leaves left and sinks forevermore.

          A tree near equilibrium when $b=b_(12)$ stabilize in height and leaf area. The
          fluctuations in leaf area and height get smaller and smaller and the tree lives forever.
        ]
    ]
  })
}
