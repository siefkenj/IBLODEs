#import "../libs/lib.typ": *
#show: e.prepare(question)
#show ref: allow_missing_refs


#{
  lesson(title: [Linearization], include "lesson-week-09.typ", label: <lesson:9>)
  question({
    learning_objectives(
      ([Conjecture the stability of an equilibrium solution by looking at a phase portrait.],),
    )
    notes[
      We first saw the tree model in @ex:tree_model but didn't have the tools beyond phase portraits
      to analyze it. Now we've developed tools based on eigenvalues, but we cannot yet apply those
      tools to the tree model.

      The purpose of this exercise is to motivate the need for a new tool---linearization.

      The tree model will be the "big linearization" example in @ex:tree_model_linearization, so the
      secondary objective of this question is to recall the tree model.

      - In @ex:tree_model_visual1[], if students have not stared at enough phase portraits, their
        intuition may not be strong enough to classify the stability of the equilibria. When
        $b approx 0$ or $b approx 2$, a trained eye should be able to identify the stability. If
        students cannot, they need more practice!

        (When $b = 0$, not considered in this question, the two equilibrium points collapse into one
        and the stability of $(0,0)$ is not clear from the phase portrait.)

        Part of the point of this question is that we cannot be _totally sure_ about stability just
        by looking at a phase portrait, so we need more tools.

      - In @ex:tree_model_visual1[], *zooming in* (and narrowing the phase portrait window) is a
        good technique to get a better look at the behavior near the equilibria.

      - The strong conclusion from this exercise is that *we need more tools* (our existing tools
        don't work on this model). Make sure you emphasize this in your conclusion. (Hopefully we
        didn't waste our time in the last few weeks developing the eigen tools #emoji.face.wink!)

    ]
    slide[


      //  Completed phase portrait in desmos:
      //  https://www.desmos.com/calculator/tvjag852ja

      Recall the tree model from @ex:tree_model:

      - $H(t)$ = height (in meters) of tree trunk at time $t$
      - $A(t)$ = surface area (in square meters) of all leaves at time $t$

      $ H'(t) = 0.3 dot A(t) - b dot H(t) $
      $ A'(t) = -0.3 dot (H(t))^2 + A(t) $
      and $0 < b <= 2$

      A phase portrait for this model is available at

      // #link("https://www.desmos.com/calculator/tvjag852ja")
      #link("https://www.desmos.com/calculator/1r3kjptoo7")

      #h(1em)

      + #label_question_part(<ex:tree_model_visual1>) Visually classify the stability of each
        equilibrium solution as attracting/repelling/etc. Does the stability depend on $b$? Are you
        confident in your visual assessment?
        #solution[
          Zooming in to the equilibrium at $(0, 0)$ we guess it is _unstable and not repelling_:
          some trajectories move away from it in one direction while approaching along another.

          The other equilibrium (at $(100 / (9 b), 1000 / (27 b^2))$) appears _attracting_ for
          $b approx 0$ and repelling when $b approx 2$.

          Except for when $b=0$ and there is only one equilibrium, it appears the stability of
          $(0,0)$ is not affected by $b$ but the stability of $(100 / (9 b), 1000 / (27 b^2))$ is.
        ]
      + Can you rewrite the system in matrix/affine form? Why or why not?
        #solution[
          No. An affine system requires the right-hand side to have the form $M arrow(r) + arrow(b)$
          for a matrix $M$ and constant vector $arrow(b)$. The term $-0.3 H^2$ in $A'$ is quadratic
          in $H$, so the system cannot be written in matrix or affine form.
        ]


    ]
  })

  let LL = $upright(bold("L"))$
  book_only(pagebreak())
  question(label: <ex:linear_approx_1d>, {
    learning_objectives(
      [Given a model based on a differential equation of the form $y'=f(y)$, create a related affine
        model by finding an affine approximation to $f$.
      ],
      [Distinguish between an affine approximation to a function, a differential equation, and a
        model.],
    )
    notes[
      Before we do linearization for systems, we develop the theory using equations of a single
      variable.

      - A major point of confusion is the difference between an "approximation to a _function_" and
        an "approximation to a _differential equation_ or _model_". Given a differential equation
        $y'=f(y)$, the process of linearization is first to find an affine approximation, $A$, to
        $f$ near a point of interest and then define a *new* differential equation $y'=A(y)$. This
        new equation is not an "approximate" differential equation (i.e., it should not be written
        $y' approx A(y)$), it's a differential equation in its own right. However, its solutions are
        approximations of solutions to the original differential equation $y'=f(y)$.

        This is emphasized in @ex:affine_approx3[].

      // During discussion be careful with your language. A solution $y$ to $y'=f(y)$ and a solution
      // $y$ to $y'=A(y)$ are different functions;

      - In model $LL$, $P$ is a _function_. In @ex:affine_approx1[], we treat $P$ as a _variable_.
        Parts @ex:affine_approx1[] and @ex:affine_approx2[] are split up to emphasize the difference
        between approximating a function and creating a model/differential equation based on that
        approximation.

      - For @ex:affine_approx4[], plan based on your available time. This part is more practice that
        can be done at home for the students who are slower. For students who haven't found
        solutions, you can tell them that solutions are given in @ex:three_affine_approximations.


    ]
    slide[

      A logistic model $LL$ for a population is
      $ (dif P) / (dif t) = P(t) dot (1 - (P(t)) / 2) $
      where $P(t)$ represents the population at time $t$.

      //We'd like to find a "simpler" version of model $LL$. Since simplifications require tradeoffs,
      We will focus on finding a simpler version of model $LL$ that works when $P approx 1/2$.
      // to approximate $(dif P) / (dif t)$ when $P approx 1 / 2$.

      //+ What is the value of $(dif P) / (dif t)$ when $P = 1 / 2$?

      + #label_question_part(<ex:affine_approx1>) Define $f(P) = P dot (1 - P / 2)$ and let
        $A_(1/2)(P)$ denote the affine approximation#footnote[In calculus, this is called a "linear
          approximation".] to $f$ centered at $P=1/2$. Find $A_(1/2)(P)$.
        #solution[
          The affine approximation to $f$ at $P = 1 / 2$ is given by the tangent line to $f$ at
          $P = 1 / 2$ which is
          $
            A_(1 / 2)(P) = f(1 / 2) + f'(1 / 2)(P - 1 / 2) = 3 / 8 + 1 / 2 (P - 1 / 2).
          $
        ]

      + #label_question_part(<ex:affine_approx2>) Notice that $(dif P)/(dif t)=f(P(t))$. Use this
        observation to create a "simple" model $LL_(1/2)$ that approximates $LL$ when
        $P approx 1/2$.
        #solution[
          Using model $LL$, we replace $f(P)$ with its affine approximation $A_(1 / 2)(P)$ to get
          model $LL_(1 / 2)$:
          $
            (dif P) / (dif t) = 3 / 8 + 1 / 2 (P - 1 / 2).
          $
        ]

      + #label_question_part(<ex:affine_approx3>) What is the difference between
        "$A_(1/2)(P)=3/8+1/2(P-1/2)$" and "$(dif P)/(dif t) = 3/8+1/2(P-1/2)$"? Which one relates to
        $LL$? How does it relate?

        #solution[
          The first expression defines a function. Its formula gives the affine approximation to the
          function $f$ at $P = 1 / 2$.

          The second expression is a differential equation. It defines a new model with similar
          properties to model $LL$ when $P approx 1 / 2$.
        ]

      + #label_question_part(<ex:affine_approx4>) Model $LL_(1/2)$ is called an _affine
        approximation of model $LL$ centered at $P=1/2$_.

        Find additional affine approximations to model $LL$ centered at each equilibrium solution.
        #solution[
          The equilibria of $LL$ satisfy $f(P) = P(1 - P / 2) = 0$, giving $P = 0$ and $P = 2$.

          Using affine approximation we arrive at models

          - $LL_0$ given by $(dif P) / (dif t) = P$, and

          - $LL_2$ given by $(dif P) / (dif t) = -(P - 2)$.
        ]

    ]
  })


  book_only(pagebreak())
  question(label: <ex:three_affine_approximations>, {
    learning_objectives(
      [Use affine approximations to classify the stability of an equilibrium solution.],
      [Recognize that the stability of an equilibrium solution to a differential equation and the
        stability of the corresponding equilibrium solution to an affine approximation _centered at
        the equilibrium point_ are the same.],
    )
    notes[
      This exercise continues @ex:linear_approx_1d. We want students to get an intuitive feeling for
      what solutions look like when they come from differential equations arising from
      approximations. In the end they should notice that the nature of the relevant equilibrium
      solution doesn't change, *but* if your approximation is not centered at an equilibrium, the
      nature of the equilibrium solution is unrelated to the original.

      - When discussing @ex:three_affine_approximations1[], open each Desmos link in a separate tab,
        and scale the axes so the viewport for each tab is the same. Then you can flip back and
        forth between the original and the approximation and make it visually clear how solutions to
        the approximate models and the original model match.

      - Use the word "approximation" carefully. Before the term "linearization" is introduced, it is
        difficult to talk about how the models $LL_?$ relate to $LL$ without confusing language.

        During you discussion, introduce the term *linearization* when needed. Restrict the word
        "approximation" for "approximation of a function" or "a solution to model $LL_?$
        approximates a solution to model $LL$".


      - Care was taken to structure this question in terms of _models_ (the $LL_?$) and _equations_
        (the $P'=...$). In @ex:three_affine_approximations2[] and
        @ex:three_affine_approximations3[], we use the term "affine approximation" rather than the
        more precise "model arising from an affine approximation"; focus on the nature of the
        linearized models rather than vocabulary.

      - In your wrap-up, tell the students that the process of creating a model via affine
        approximations is called *linearization* and the new models (e.g. $LL_?$) are called
        *linearized models*.

      - In @ex:three_affine_approximations3[], students may make arguments like $A_0 ' > 0$ so the
        equilibrium is repelling. If they know that $A_0 '$ is the eigenvalue of the $1 times 1$
        matrix defining the equation, that is great! If they do not recognize this, they are
        probably memorizing rules. Encourage them to argue from first principles.
    ]
    slide[

      Based on our calculations from @ex:linear_approx_1d, we have several different models based on
      affine approximations.


      #align(
        center,
        table(
          stroke: none,
          align: (right, left, left),
          columns: 3,
          // Original ODE
          [(Original $LL$)],
          [$P' = P (1 - P / 2)$],
          [(#link("https://www.desmos.com/calculator/v1coz4shtw"))],
          // Linear approximation at P = 1/2
          [($LL_(1 / 2)$)],
          [$P' = 3 / 8 + 1 / 2 (P - 1 / 2)$],
          [(#link("https://www.desmos.com/calculator/zsb2apxhqs"))],
          // Linear approximation at P = 0
          [($LL_0$)], [$P' = P$], [(#link("https://www.desmos.com/calculator/vw48bvqgrc"))],
          // Linear approximation at P = 2
          [($LL_2$)], [$P' = - (P - 2)$], [(#link("https://www.desmos.com/calculator/i2utk6vnqh"))],
        ),
      )


      + #label_question_part(<ex:three_affine_approximations1>) What are the
        similarities/differences in the Desmos plots of solutions to the original equation vs. the
        other equations?
        #solution[
          *Similarities*: Near the point of interest of each approximation, solutions closely match
          the solutions to the original model $LL$ _for a limited range of $t$ values_.

          *Differences*: When $P$ is not near the point of interest, the alternative models give
          wildly different population predictions than the original model $LL$.
        ]
      + #label_question_part(<ex:three_affine_approximations2>) Does the nature of the equilibrium
        solutions change when using an affine approximation?
        #solution[
          No. But, notice that $LL_(1/2)$ is not centered at an equilibrium and its equilibrium
          solution is completely unrelated to those of model $LL$.
        ]
      + #label_question_part(<ex:three_affine_approximations3>) Classify each equilibrium solution
        of the original equation by using affine approximations.
        #solution[
          For $P=0$, we use the model $LL_(0)$ given by $P' = A_0(P) = P$.
          - If $P>0$, then $P' = P > 0$ so solutions are increasing and move away from $P=0$.
          - If $P<0$, then $P' = P < 0$ so solutions are decreasing and move away from $P=0$.

          Thus the equilibrium $P=0$ is *unstable and repelling*.

          For $P=2$, we use the model $LL_(2)$ given by $P' = A_2(P) = -(P-2)$.
          - If $P>2$, then $P' = -(P-2) < 0$ so solutions are decreasing and move toward $P=2$.
          - If $P<2$, then $P' = -(P-2) > 0$ so solutions are increasing and move toward $P=2$.
          Thus, the equilibrium $P=2$ is *stable and attracting*.
        ]

    ]
  })

  book_only(pagebreak())
  question({
    learning_objectives(
      ([Classify equilibrium solutions by linearizing about equilibrium points.],),
    )
    notes[
      Normally we can classify equilibrium solutions using a slope field and a plot of sample
      solutions. In this question, the details are too squished to see, so we will classify by
      linearizing instead.

      This question is extra practice following @ex:three_affine_approximations. It can be *skipped*
      or quickly discussed (e.g., motivated but with computations left as homework) if you are short
      on time.
    ]
    slide[

      Consider the differential equation whose slope field is sketched below.
      $
        P'(t) & = - P(t) dot (0.1 + P(t)) dot (0.2 + P(t)) \
              & = - (P(t))^3 - 0.3 dot (P(t))^2 - 0.02 dot P(t)
      $

      #text(size: 0.9em, link("https://www.desmos.com/calculator/ikp9rgo0kv"))

      #let F = (x, y) => -y * (0.1 + y) * (0.2 + y)
      #{
        let dist = 3.1
        let steps = 20
        // Start a solution plot at each of these y-values
        let solns = (-1, -.5, -.25, -.15, -.1, -.05, 0, .05, .5, 1).map(y => solve_1d_ivp(
          F,
          (
            0,
            y,
          ),
          steps,
          Delta: dist / steps,
          method: "rk4",
        ))
        align(
          center,
          slope_field(
            F,
            xlim: (-.3, dist),
            ylim: (-1.3, 1.3),
            width: 7cm,
            height: 3cm,
            spacing: (.1, .125),
            scale_segments: .07,
            yaxis: (position: 0, tip: tiptoe.stealth, tick-distance: 1),
            xaxis: (position: 0, tip: tiptoe.stealth, filter: ((v, d) => false)),
            ..solns.map(soln => lq.plot(
              soln.map(((x, y)) => x),
              soln.map(((x, y)) => y),
              mark: none,
              stroke: (paint: blue.darken(30%), thickness: 1pt),
            )),
          ),
        )
      }

      + Find all equilibrium solutions.
        #solution[
          Solving $P' = 0=-P(0.1 + P)(0.2 + P) = 0$ gives $P = 0$, $P = -0.1$, $P = -0.2$.
        ]
      + Use affine approximations to classify the equilibrium solutions as stable/unstable/etc.
        #solution[
          - $P = 0$: *stable and attracting*.
          - $P = -0.1$: *unstable and repelling*.
          - $P = -0.2$: *stable and attracting*.
        ]


    ]
  })

  book_only(pagebreak())
  question(label: <ex:tree_model_linearization>, {
    learning_objectives(
      (
        [Classify equilibrium solutions of non-linear systems of differential equations by
          linearizing about equilibrium points.],
      ),
    )
    notes[
      This question is the capstone of the course. It combines everything we've learned so far and
      it will take a _long_ time.

      - This question takes two slides. The first slide shows formulas that students can directly
        apply.

        Some students will have had a multivariable calculus that included the Total
        Derivative/Jacobian matrix and some won't. For the sake of time, stress the similarity
        between the 1d and 2d formulas and encourage students to apply the 2d formula.

      - Parts @ex:tree_model_linearization1[] through @ex:tree_model_linearization3[] focus on the
        equilibrium at $(0,0)$ and the algebra is relatively simple. Parts
        @ex:tree_model_linearization4[] through @ex:tree_model_linearization6[] is conceptually no
        more difficult, but the algebra is more involved.

      - In @ex:tree_model_linearization5[], during discussion, open Desmos in two different tabs and
        switch back and forth between the model and the linearization to show students the effects
        of linearizing. Emphasize that it is good near the equilibrium but not far from it (or near
        the non-approximated equilibrium).

      - Part @ex:tree_model_linearization6[] is computationally involved and has subtleties. After
        giving students some time to find the eigenvalues, take the lead and walk through the
        analysis.

        - Start with the case of complex eigenvalues---it is more straightforward.
        - Watch out for $b=1$, the stability cannot be determined from the linearization. (Analysis
          outside the scope of this course shows that it is stable and not-attracting).
        - When the eigenvalues are real, one needs to check whether they have the same sign or not.
          Graphing $lambda$ as a function of $b$ is convincing---algebraic proofs will be lost on
          the students.

      - In @ex:tree_model_linearization6[], if time allows, give implications for the original tree
        model.
      - Because this linearization example is in the context of a model with some number that aren't
        nice, the big ideas may be lost on students. @ex:linearization_practice provides practice
        with 2d linearization with no model.

    ]
    slide(force_scale: 0.94em)[

      To make a 1d affine approximation of a function $f$ at the point $E$ we have the formula
      $ f(x) wide approx wide f(E) + f'(E) (x - E). $

      To make a 2d approximation of a function $arrow(F)(x, y) = (F_1(x, y), F_2(x, y))$ at the
      point $arrow(E)$, we have a similar formula
      $
        arrow(F)(x, y) wide approx wide arrow(F)(arrow(E)) + D_(arrow(F))(arrow(E)) (mat(x; y) - arrow(E))
      $
      where $D_(arrow(F))(arrow(E))$ is the _total derivative_ of $arrow(F)$ at $arrow(E)$, which
      can be expressed as the matrix
      $
        D_(arrow(F))(arrow(E)) = mat(
          (partial F_1) / (partial x), (partial F_1) / (partial y);
          (partial F_2) / (partial x), (partial F_2) / (partial y)
        )
      $
      evaluated at $arrow(E)$.
    ]

    book_only(line(length: 100%, stroke: 0.5pt))

    slide(force_scale: 0.85em)[


      Recall our model from Exercise @ex:tree_model for the life cycle of a tree where $H(t)$ was
      height, $A(t)$ was the leaves' surface area, and $t$ was time:

      $
        H'(t) & = 0.3 dot A(t) - b dot H(t) \
        A'(t) & = -0.3 dot (H(t))^2 + A(t)
      $
      with $0 < b <= 2$


      We know the following:
      - The equations cannot be written in matrix form.
      - The equilibrium points are $(0, 0)$ and $(100 / 9 b, 1000 / 27 b^2)$.

      We want to find an affine approximation to the system.

      Define $arrow(F)(H, A) = (H', A')$.

      + #label_question_part(<ex:tree_model_linearization1>) Find the matrix for $D_(arrow(F))$, the
        total derivative of $arrow(F)$.
        #solution[
          With $F_1(H, A) = 0.3 A - b H$ and $F_2(H, A) = -0.3 H^2 + A$,
          $
            D_(arrow(F))(H, A) = mat(
              (partial F_1) / (partial H), (partial F_1) / (partial A);
              (partial F_2) / (partial H), (partial F_2) / (partial A)
            ) = mat(-b, 0.3; -0.6 H, 1).
          $
        ]
      + #label_question_part(<ex:tree_model_linearization2>) Create an affine approximation to
        $arrow(F)$ around $arrow(E) = (0, 0)$ and use this to write an approximation to the original
        system.
        #solution[
          Evaluating at $(H, A) = (0, 0)$:
          $
            D_(arrow(F))(0, 0) = mat(-b, 0.3; 0, 1), wide arrow(F)(0, 0) = mat(0; 0).
          $
          The affine approximation of the original system (i.e., the linearization) is
          $
            mat(H'_"approx"; A'_"approx") = mat(-b, 0.3; 0, 1) mat(H_"approx"; A_"approx").
          $
        ]
      + #label_question_part(<ex:tree_model_linearization3>) In the original system, the equilibrium
        $(0, 0)$ is unstable and not repelling. Justify this using your affine approximation.
        #solution[
          The matrix $D_(arrow(F))(0,0) = mat(-b, 0.3; 0, 1)$ is upper triangular, so its
          eigenvalues are $lambda_1 = -b$ and $lambda_2 = 1$.

          Since $0 < b <= 2$, the eigenvalues have opposite signs (and neither is zero) and so the
          linearized system has an unstable but not repelling equilibrium at $(0,0)$; by the
          Classification via Linearization theorem,
          // Since we aren't rendering the body of the module, we cannot use this reference.
          // @thm:classification_via_linearization
          the original equilibrium is also *unstable* and not repelling.
        ]
      + #label_question_part(<ex:tree_model_linearization4>) #label_question_part(
          <ex:affine-approx-part3>,
        ) Create an affine approximation to $arrow(F)$ around
        $arrow(E) = (100 / 9 b, 1000 / 27 b^2)$ and use this to write an approximation to the
        original system.
        #solution[
          Let $arrow(E) = (100 / 9 b, 1000 / 27 b^2)$. Since $arrow(E)$ is an equilibrium,
          $arrow(F)(arrow(E)) = arrow(0)$. Evaluating the total derivative:
          $
            D_(arrow(F))(arrow(E)) = mat(-b, 0.3; -0.6 dot 100 / 9 b, 1) = mat(-b, 0.3; -20 / 3 b, 1).
          $
          And so the linearized system is
          $
            mat(H'_"approx"; A'_"approx") = mat(-b, 0.3; -20 / (3 b), 1) (mat(H_"approx"; A_"approx") - arrow(E)  //mat(100 / (9 b); 1000 / (27 b^2))
            ).
          $
        ]
      + #label_question_part(<ex:tree_model_linearization5>) Make a phase portrait for the original
        system and your approximation from part @ex:affine-approx-part3[]. How do they compare?
        #solution[
          #{
            let b_val = 1.75
            let H_star = 100 / 9 * b_val
            let A_star = 1000 / 27 * b_val * b_val
            let F_orig(x, y) = (0.3 * y - b_val * x, -0.3 * x * x + y)
            let F_lin(x, y) = (
              -b_val * (x - H_star) + 0.3 * (y - A_star),
              (-20 / 3 * b_val) * (x - H_star) + 1 * (y - A_star),
            )
            let xlim = (-2, 40)
            let ylim = (-5, 175)
            let scale_segments = 26
            let spacing = (3.3, 7.5)
            set align(center)
            vector_field(
              F_orig,
              xlim: xlim,
              ylim: ylim,
              spacing: spacing,
              scale_segments: scale_segments,
              width: 5cm,
              height: 5cm,
              xaxis: (position: 0, tip: tiptoe.stealth, ticks: none, subticks: none),
              yaxis: (position: 0, tip: tiptoe.stealth, ticks: none, subticks: none),
              title: [Original ($b = #b_val$) #v(.3em)],
            )
            h(1em)
            vector_field(
              F_lin,
              xlim: xlim,
              ylim: ylim,
              spacing: spacing,
              scale_segments: scale_segments,
              width: 5cm,
              height: 5cm,
              xaxis: (position: 0, tip: tiptoe.stealth, ticks: none, subticks: none),
              yaxis: (position: 0, tip: tiptoe.stealth, ticks: none, subticks: none),
              title: [Linearization ($b = #b_val$) #v(.3em)],
            )
          }
          Near $arrow(E)$, the two phase portraits look very similar. Far from $arrow(E)$, the
          linearization doesn't match the original model well (in particular at $(0,0)$ they exhibit
          very different behavior).
        ]
      + #label_question_part(<ex:tree_model_linearization6>) Analyze the nature of the equilibrium
        solution in part @ex:affine-approx-part3[] using eigen techniques. Relate your analysis to
        the original system.
        #notes[
          - In @ex:tree_model_linearization6[], determining the stability for $b=1$ analytically is
            outside the scope of the course. It happens to be stable and not attracting. This can be
            seen by showing that trajectories near the equilibrium in phase space are closed loops
            (e.g., by solving $(dif A)/(dif H) = (A'(t))/(H'(t))$. The resulting curves are given by
            $
              x^3/5 + 3/10 y^2 -2x y = k
            $
            where $k$ is a parameter.

            See https://www.desmos.com/calculator/q1rpumr4e4
        ]
        #solution[
          For $arrow(E)=mat(100 / 9 b; 1000 / 27 b^2)$ the eigenvalues of $D_(arrow(F))(arrow(E))$
          are
          $
            lambda = (1-b)/2 plus.minus sqrt((b - 3)^2 - 8)/2.
          $

          We now do a case-by-case analysis.
          - If $(b-3)^2-8 < 0$, the eigenvalues are complex and the stability is completely
            determined by the real parts, $(1-b)/2$.

            This happens when $b in (3 - sqrt(8), 2] approx (0.17, 2]$.

            - If $b in (0.17, 1)$, the real part is positive and the equilibrium is *unstable* and
              *repelling* (spiralling out).
            - If $b in (1,2)$, the real part is negative and the equilibrium is *stable* and
              *attracting* (spiralling in).
            - If $b=1$, the real part is zero and and so we *cannot determine* stability in the
              original model from the linearization.

          - If $b in (0, 3-sqrt(8)] approx (0, 0.17]$, both eigenvalues are real.

            By graphing, we verify that for all $b$ in this interval, both
            $(1-b)/2 + sqrt((b - 3)^2 - 8)/2$ and $(1-b)/2 - sqrt((b - 3)^2 - 8)/2$ are positive,
            and so the equilibrium is *unstable* and *repelling*.

          // - (Outside the scope of this course) If $b=1$, we can find a differential equation for
          //   $y(x)$ to study the trajectories of solutions in phase space. It can be checked that
          //   with initial conditions near $arrow(E)$, the trajectories remain bounded, thus the
          //   equilibrium is *stable* but not attracting.
          //
          In conclusion, for $b in (0, 1)$ the equilibrium is *unstable* and *repelling* (spiralling
          out); for $b in (1, 2]$ the equilibrium is *stable* and *attracting* (spiralling in); and
          for $b=1$ we cannot determine stability from the linearization.

          So for $b<1$ (very "viscous" swamp), the tree dies out eventually, whereas for $b>1$ (less
          "viscous" swamp), the tree has a chance to grow to a stable height.
        ]

    ]
    book_only(colbreak())
  })


  book_only(pagebreak())
  lesson(title: [Linearization II & Higher Order Equations], include "lesson-week-10.typ", label: <lesson:10>)
  question(label: <ex:linearization_practice>, {
    learning_objectives(
      (
        [Classify an equilibrium solution of a non-linear system of differential equations by
          linearizing about the equilibrium point.],
      ),
    )
    notes[
      After the complicated example in @ex:tree_model_linearization, it's time for some practice and
      review.

      This question has no model and no parameter.

      - There are equilibrium points at $(0, 0)$ and $(1, 0)$, but students are only asked to
        classify $(0,0)$. You can have them do $(1,0)$ for homework.

      - Discussion time for this question is a good time to summarize the process of linearization
        and applying the Classification via Linearization theorem.

      - If your students seemed confused about linearization in @ex:tree_model_linearization, *don't
        skip* this exercise. At this point in the term, going a little slower to make sure students
        understand is worth it.
    ]
    slide[

      #slides_only(v(1em))

      Define $arrow(F)(x, y) = mat(y; - x y + x^2 - x - y)$ and consider the differential equation
      $ mat(x'; y') = arrow(F)(x, y). $

      + Make a phase portrait for this differential equation. Based on your phase portrait, can you
        determine the nature of the equilibrium at $(0, 0)$?

        #link("https://www.desmos.com/calculator/peby3xd7jj")

        #solution[
          #{
            set align(center)
            vector_field(
              ((x, y) => (y, -x * y + x * x - x - y)),
              xlim: (-1.5, 1.5),
              ylim: (-1.5, 1.5),
              spacing: (.2, .2),
              scale_segments: 10,
              width: 5cm,
              height: 5cm,
              xaxis: (position: 0, tip: tiptoe.stealth, ticks: none, subticks: none),
              yaxis: (position: 0, tip: tiptoe.stealth, ticks: none, subticks: none),
            )
          }
          The arrows near the origin appear to spiral inward, suggesting the equilibrium at $(0, 0)$
          is stable and attracting.
        ]
      + Find an affine approximation to $arrow(F)$ centered at $(0, 0)$.
        #solution[
          With $F_1(x, y) = y$ and $F_2(x, y) = -x y + x^2 - x - y$, the total derivative is
          $
            D_(arrow(F))(x, y) = mat(
              0, 1;
              -y + 2 x - 1, -x - 1
            ).
          $
          Computing at $(0, 0)$, we get $D_(arrow(F))(0, 0) = mat(0, 1; -1, -1)$ and
          $arrow(F)(0, 0) = mat(0; 0)$. Therefore, the affine approximation is given by
          $
            arrow(F)(x, y) approx mat(0, 1; -1, -1) mat(x; y).
          $
        ]
      + Write down a differential equation based on your affine approximation.

        For which initial conditions will solutions to this new equation be close to solutions to
        the original?
        #solution[
          $
            mat(x'_"approx"; y'_"approx") = mat(0, 1; -1, -1) mat(x_"approx"; y_"approx")
          $

          If $(x(t),y(t))$ is a solution to the original system and
          $(x_"approx" (t), y_"approx" (t))$ is a solution to the linearized system, then
          $(x_"approx", y_"approx")$ will be a good approximation of $(x, y)$ if
          $(x_"approx" (0), y_"approx" (0)) = (x(0), y(0)) approx (0,0)$. I.e., the solutions start
          at the same initial value and that value is near $arrow(0)$.
        ]
      + Analyze the nature of the equilibrium solution $arrow(r)(t) = (0, 0)$ using eigen
        techniques. (You may use a computer to assist in eigen computations.) Relate your analysis
        to the original system.
        #solution[
          For $M = mat(0, 1; -1, -1)$, the eigenvalues are
          $lambda = -1 / 2 plus.minus i sqrt(3) / 2.$

          The real part is $-1 / 2 < 0$, so the linearized equilibrium is *stable* and *attracting*.
          By the Classification via Linearization theorem, the equilibrium point $(0,0)$ for the
          original system is also *stable* and *attracting*.
        ]


    ]
  })
}
