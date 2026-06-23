#import "../libs/lib.typ": *
#show: e.prepare(question)

#{
  lesson(title: [Complex Solutions], include "lesson-week-08.typ", label: <lesson:8>)
  question({
    learning_objectives(
      [From a list of premises, model a situation with differential-equations.],
      [Express a system of differential equations in affine form.],
      [Describe the behaviour of solutions to a system of differential equations using the phase
        portrait.],
    )
    notes[
      This question introduces a model where the eigen solutions are complex. The modelling process
      should be familiar by now. Details about complex solutions will come in future exercises.

      - In @ex:fd_phase_portrait[], let students know they can use Desmos, and that they can find a
        Desmos link in the previous exercises (for example @ex:sm_start_matrix_journey).

      - In @ex:fd_solution_shape[], solutions in phase space form ellipses. However, from the phase
        portrait it is hard to tell if they have a slight spiral behaviour (towards or away from the
        equilibrium). Acknowledge this and use it to motivate the need for analytic tools.

    ]
    slide(force_scale: 0.85em)[

      Consider the following *FD* model of Fleas and Dogs where
      $
        F(t) & = "number of parasites (fleas) at year " t " (in millions)" \
        D(t) & = "number of hosts (dogs) at year " t " (in thousands)"
      $


      #aligned_terms(
        terms.item($("P"_"fleas 1")$, [Ignoring all else, the number of parasites decays in
          proportion to its population (with constant 1).]),
        terms.item(
          $("P"_"fleas 2")$,
          [Ignoring all else, parasite numbers grow in proportion to the number of hosts (with
            constant 1 $"mega flea"/"kilo dog"$).],
        ),
        terms.item(
          $("P"_"dogs 1")$,
          [Ignoring all else, hosts numbers grow in proportion to their current number (with
            constant 1).],
        ),
        terms.item(
          $("P"_"dogs 2")$,
          [Ignoring all else, host numbers decrease in proportion to the number of parasites (with
            constant 2 $"kilo dog"/"mega flea"$).],
        ),
        terms.item(
          $("P"_"collar")$,
          [Anti-flea collars remove 2 million fleas per year.],
        ),
        terms.item(
          $("P"_"breeding")$,
          [Constant dog breeding adds 1 thousand dogs per year.],
        ),
      )

      // Original: delete when confident the wording of the above is correct.
      // - (P$1_F$) Ignoring all else, the number of parasites decays in proportion to its population
      //   (with constant 1).
      // - (P$2_F$) Ignoring all else, parasite numbers grow in proportion to the number of hosts (with
      //   constant 1 $"mega flea"/"kilo dog"$).
      // - (P$1_D$) Ignoring all else, hosts numbers grow in proportion to their current number (with
      //   constant 1).
      // - (P$2_D$) Ignoring all else, host numbers decrease in proportion to the number of parasites
      //   (with constant 2 $"kilo dog"/"mega flea"$).
      //   #slides_only(colbreak())
      // - (P$1_c$) Anti-flea collars remove 2 million fleas per year.
      // - (P$2_c$) Constant dog breeding adds 1 thousand dogs per year.

      + Write a system of differential equations for the *FD* model.
        #solution[
          $
            F' & = underbrace(-F, "P"_"fleas 1") & underbrace(+D, "P"_"fleas 2") quad & underbrace(-2, "P"_"collar") \
            D' & = underbrace(-2F, "P"_"dogs 2") quad & underbrace(+D, "P"_"dogs 1") quad & underbrace(+1, "P"_"breeding")
          $
        ]
      + Can you rewrite the system in matrix form $arrow(r)' = M arrow(r)$? What about in _affine_
        form $arrow(r)' = M arrow(r) + arrow(b)$?
        #solution[
          The constant terms $-2$ and $+1$ prevent a pure matrix form. However, the system can be
          written in affine form:
          $
            mat(F; D)' = underbrace(mat(-1, 1; -2, 1), M) mat(F; D) + underbrace(mat(-2; 1), arrow(b)).
          $
        ]
      + #label_question_part(<ex:fd_phase_portrait>) Make a phase portrait for your model.
        #solution[
          #{
            set align(center)
            vector_field(
              ((F, D) => (-F + D - 2, -2 * F + D + 1)),
              xlim: (-1, 7),
              ylim: (0, 10),
              spacing: (.7, .7),
              scale_segments: 18,
              width: 5cm,
              height: 5cm,
              xaxis: (position: 0, tip: tiptoe.stealth, ticks: none, subticks: none),
              yaxis: (position: 0, tip: tiptoe.stealth, ticks: none, subticks: none),
            )
          }
        ]
      + #label_question_part(<ex:fd_solution_shape>) What should solutions to the system look like
        in the phase plane? What are the equilibrium solution(s)?
        #solution[
          The equilibrium is found by solving $M arrow(E) + arrow(b) = arrow(0)$:
          $
              -E_F + E_D & = 2 \
            -2 E_F + E_D & = -1
          $
          Subtracting gives $E_F = 3$ and then $E_D = 5$, so the unique equilibrium is
          $(F, D) = (3, 5)$.

          From the phase portrait, it looks like non-equilibrium solutions circle clockwise around
          the equilibrium. However, we cannot be sure that the equilibrium is not subtly attracting
          or repelling, which would make the solutions spiral towards or away from the equilibrium.
        ]


    ]
  })


  book_only(pagebreak())
  question(label: <ex:fd_general_solution1>, {
    learning_objectives(
      [Rewrite an affine system as a matrix differential equation.],
      [Find eigen solutions to a matrix differential equation with complex eigenvalues.],
    )
    notes[
      @ex:fd_general_solution1[Core Exercises], @ex:fd_general_solution2[], and
      @ex:fd_general_solution3[] function as one very long question.

      This question scaffolds the process of creating a matrix equation from an affine equation and
      concludes with complex eigen solutions.

      - Make sure students have reviewed complex numbers *before* this question.

      - In @ex:fd_general_solution1_eigenvectors[], depending on how you solve the equation, you may
        get eigenvectors that look very different. Using row-reduction you get
        $mat(frac((1plus.minus i), 2, style: "horizontal"); 1)$. A simpler form is
        $mat(1 plus.minus i; 2)$. Keeping a complex number in the denominator gives
        $mat(1; 1 minus.plus i)$. These might look linearly independent to students. If it comes up,
        tell them that it is harder to determine "by sight" whether two complex vectors are linearly
        independent.

      - In @ex:fd_general_solution1_eigenvectors[], after giving students time to work, you may
        choose to announce that they may use a computer to find the eigenvectors. (This can save
        some time for those slow with computations.) If they use a computer, they are likely to
        arrive at $mat(1 plus.minus i; 2)$ for the eigenvectors, which will not match
        @ex:fd_general_solution2.

        If you do allow the use of a computer, during your wrap-up, make it clear what the
        expectations for a test will be. Do they need to be proficient at finding complex
        eigenvectors by hand?

      - In @ex:fd_general_solution1_eigen_solutions[], settle for two linearly independent eigen
        solutions. There is no need to list them _all_ or to talk about the fact that each eigen
        solution can be multiplied by a non-zero _complex_ number.

    ]
    slide(force_scale: 0.85em)[

      Recall the *FD* model of Fleas and Dogs where
      $
               F(t) & = "number of parasites (fleas) at year " t " (in millions)" \
               D(t) & = "number of hosts (dogs) at year " t " (in thousands)" \
        arrow(r)(t) & = mat(F(t); D(t))
      $

      and

      $ arrow(r)'(t) = mat(-1, 1; -2, 1) arrow(r)(t) + mat(-2; 1) $

      Define $arrow(s)(t)$ to be the displacement of $arrow(r)(t)$ from equilibrium at time $t$.

      + Find a formula for $arrow(s)$ in terms of $arrow(r)$.
        #solution[
          The equilibrium $arrow(E) = mat(3; 5)$ satisfies $M arrow(E) + arrow(b) = arrow(0)$ (as
          found previously). The displacement from equilibrium is
          $
            arrow(s)(t) = arrow(r)(t) - arrow(E) = mat(F(t) - 3; D(t) - 5).
          $
        ]
      + Can you find a matrix $M$ so that $arrow(s)'(t) = M arrow(s)(t)$?
        #solution[
          Since $arrow(s) = arrow(r) - arrow(E)$ and $arrow(E)$ is constant,
          $
            arrow(s)' = arrow(r)' = M arrow(r) + arrow(b) = M(arrow(s) + arrow(E)) + arrow(b)
            = M arrow(s) + underbrace((M arrow(E) + arrow(b)), = arrow(0)) = M arrow(s).
          $
          So $arrow(s)' = M arrow(s)$ with $M = mat(-1, 1; -2, 1)$.
        ]
      + What are the eigenvalues of $M$?
        #solution[
          The characteristic polynomial is
          $
            det(M - lambda I) = (-1 - lambda)(1 - lambda) + 2 = lambda^2 + 1 = 0,
          $
          giving eigenvalues $lambda = plus.minus i$.
        ]
      + #label_question_part(<ex:fd_general_solution1_eigenvectors>) Find an eigenvector for each
        eigenvalue of $M$.
        #solution[
          For $lambda = i$: solving $(M - i I)arrow(v) = arrow(0)$ we get an eigenvector of
          $mat(frac((1 - i), 2, style: "horizontal"); 1)$.

          For $lambda = -i$: solving $(M + i I)arrow(v) = arrow(0)$ we get an eigenvector of
          $mat(frac((1 + i), 2, style: "horizontal"); 1)$.
        ]
      + #label_question_part(<ex:fd_general_solution1_eigen_solutions>) What are the eigen solutions
        for $arrow(s)' = M arrow(s)$?
        #solution[
          $
            arrow(s)_1(t) = A e^(i t) mat(frac((1 - i), 2, style: "horizontal"); 1), quad arrow(s)_2(t) = B e^(-i t) mat(frac((1 + i), 2, style: "horizontal"); 1),
          $
          where $A,B$ are non-zero (complex) parameters.
        ]

    ]
  })


  book_only(pagebreak())
  question(label: <ex:fd_general_solution2>, {
    learning_objectives(
      [Use Euler's Formula to find real solutions to a matrix differential equation with complex
        eigenvalues.],
      [Use linear combinations of real solutions to produce new, real solutions to a matrix
        differential equation.],
    )
    notes[
      Forgetting about affine systems for a moment, we focus on creating real solutions from complex
      ones.

      There are "tricks" to do this (like taking the real part of a complex solution), but we rely
      on taking specific linear combinations of the complex eigen solutions.

      - If the the eigen solutions the class came up with in
        @ex:fd_general_solution1_eigen_solutions aren't the same as in this question, acknowledge
        that and explain that we will proceed with the form of the solutions given in this question.

      - Part @ex:fd_general_solution2_algebra[] will take a long time. Don't wait for all students
        to complete the algebra before discussing.

      - During discussion don't do the algebra *for more than one part* of
        @ex:fd_general_solution2_algebra on the board. It is not worth the time.

      - In @ex:fd_general_solution2_verify[], one can verify algebraically or geometrically (with a
        phase portrait). Almost no student will think geometrically. During discussion, if it hasn't
        come up, show them a geometric verification by plotting a solution on top of the phase
        portrait in Desmos. (This can be done by entering "$(cos(t) + sin(t), 2cos(t))$" into a cell
        and specifying a range for the parameter $t$.)

      - Students will ask if $arrow(s)_1 + arrow(s)_2$ and $i (arrow(s)_1 - arrow(s)_2)$ _always_
        give real solutions. You can tell them "yes, in most cases" (it won't work if the equation
        has complex coefficients). You may also explain that the most general method is to solve
        $alpha arrow(s)_1 + beta arrow(s)_2$ for constants $alpha, beta$ that make the resulting
        solution real.

      - In most textbooks, real solutions are obtained by taking the real and imaginary parts of a
        complex solution. This is a simple method that students are happy to memorize. We don't
        mention this method because we want to emphasize thinking about linear combinations.
    ]
    slide(force_scale: 0.85em)[


      Recall the *FD* model of Fleas and Dogs where
      $
               F(t) & = "number of parasites (fleas) at year " t " (in millions)" \
               D(t) & = "number of hosts (dogs) at year " t " (in thousands)" \
        arrow(r)(t) & = mat(F(t); D(t))
                      wide wide arrow(s)(t) = arrow(r)(t) - mat(3; 5)
      $

      and

      $ arrow(s)'(t) = M arrow(s)(t) wide "where" wide M = mat(-1, 1; -2, 1). $

      This equation has eigen solutions
      $
        arrow(s)_1(t) & = e^(i t) mat(frac((1 - i), 2, style: "horizontal"); 1) \
        arrow(s)_2(t) & = e^(-i t) mat(frac((1 + i), 2, style: "horizontal"); 1).
      $

      + #label_question_part(<ex:fd_general_solution2_algebra>) Recall Euler's formula
        $e^(i t) = cos(t) + i sin(t)$.
        + Use Euler's formula to expand $arrow(s)_1 + arrow(s)_2$. Are there any imaginary numbers
          remaining?
          #solution[
            $
              arrow(s)_1 + arrow(s)_2 = (cos t + i sin t) mat(frac((1-i), 2, style: "horizontal"); 1) + (cos t - i sin t) mat(frac((1+i), 2, style: "horizontal"); 1).
            $
            After expanding and simplifying, we get
            $arrow(s)_1 + arrow(s)_2 = mat(cos t + sin t; 2 cos t)$. No imaginary numbers remain.
          ]
        + Use Euler's formula to expand $i (arrow(s)_1 - arrow(s)_2)$. Are there any imaginary
          numbers remaining?
          #solution[
            $
              i(arrow(s)_1 - arrow(s)_2) = mat(cos t - sin t; -2 sin t)
            $
            No imaginary numbers remain.
          ]
      + #label_question_part(<ex:fd_general_solution2_verify>) Verify that your formulas for
        $arrow(s)_1 + arrow(s)_2$ and $i (arrow(s)_1 - arrow(s)_2)$ are solutions to
        $arrow(s)'(t) = M arrow(s)(t).$
        #solution[
          Directly verifying,
          $
            (arrow(s)_1 + arrow(s)_2)' = mat(- sin t + cos t; -2 sin t)
          $
          $
            M(arrow(s)_1 + arrow(s)_2) = mat(-(cos t + sin t) + 2 cos t; -2(cos t + sin t) + 2 cos t)
            = mat(cos t - sin t; -2 sin t).
          $
          So $(arrow(s)_1 + arrow(s)_2)' = M(arrow(s)_1 + arrow(s)_2)$.

          Similarly, $(i(arrow(s)_1 - arrow(s)_2))' = M(i(arrow(s)_1 - arrow(s)_2))$.

          We can also check graphically by plotting a solution on top of the phase portrait. If the
          solution "follows the arrows", then we know it is correct. Below is the solution
          $arrow(s)_1 (t) + arrow(s)_2 (t)$ plotted for $t in [0, pi]$.
          #{
            set align(center)
            let ts = lq.linspace(0, 1 * calc.pi, num: 100)
            vector_field(
              ((x, y) => (-x + y, -2 * x + y)),
              xlim: (-2, 2),
              ylim: (-2.5, 2.5),
              spacing: (.35, .35),
              scale_segments: 19,
              width: 5cm,
              height: 5cm,
              xaxis: (position: 0, tip: tiptoe.stealth, ticks: none, subticks: none),
              yaxis: (position: 0, tip: tiptoe.stealth, ticks: none, subticks: none),
              legend: (position: bottom + right),
              lq.plot(
                ts.map(t => calc.cos(t) + calc.sin(t)),
                ts.map(t => 2 * calc.cos(t)),
                mark: none,
                stroke: (paint: red.darken(20%), thickness: 1.5pt),
              ),
            )
          }
        ]
      + Can you give a third _real_ solution to $arrow(s)'(t) = M arrow(s)(t)?$
        #solution[
          Because this is a matrix equation, any linear combination of solutions is also a solution.
          So for example For example,
          $
            (arrow(s)_1 + arrow(s)_2) + i(arrow(s)_1 - arrow(s)_2) = mat(2 cos t; 2 cos t - 2 sin t).
          $
        ]



    ]
  })


  book_only(pagebreak())
  question(label: <ex:fd_general_solution3>, {
    learning_objectives(
      [Find the general solution to a matrix differential equation with complex eigenvalues.],
      [Find the general solution to an affine system of differential equations, whose corresponding
        matrix equation has complex eigenvalues.],
    )
    notes[
      Now that we have real solutions to the matrix equation, it's time to relate them back to the
      original affine equation.

      Since this is the culmination of @ex:fd_general_solution1[Core Exercises] and
      @ex:fd_general_solution2[], plan for wrap-up that gives an overview of the process of finding
      general real solutions and the fact that complex solutions, though they exist mathematically,
      make no sense in the context of our model.

      - The "process" concluded in this exercise is:
        + Create a matrix equation from an affine equation.
        + Find a basis of eigen solutions to the matrix equation.
        + If the solutions are complex, find linear combinations of them that give real solutions.
        + Translate the solutions you found for the matrix equation to get solutions to the affine
          equation.
        Part of this process is checking, along the way, that the mathematics you did makes sense in
        the context of the model. For example, mathematically, differential equations can have
        general _complex_ solutions. But, if the quantities we are modelling are real-valued, in the
        end, we should only consider real solutions.

      - During your wrap-up, have a discussion of whether the matrix equation has any _real_ eigen
        solutions. (It doesn't.) This can be used to motivate the need for complex numbers---using
        complex numbers, we can maintain our eigen techniques (even if we need to do some extra
        work).
    ]
    slide(force_scale: 0.85em)[

      Recall the *FD* model of Fleas and Dogs where
      $
               F(t) & = "number of parasites (fleas) at year " t " (in millions)" \
               D(t) & = "number of hosts (dogs) at year " t " (in thousands)" \
        arrow(r)(t) & = mat(F(t); D(t))
                      wide wide arrow(s)(t) = arrow(r)(t) - mat(3; 5)
      $

      and

      $ arrow(s)'(t) = M arrow(s)(t) wide "where" wide M = mat(-1, 1; -2, 1). $


      + What is the dimension of the space of solutions to $arrow(s)'(t) = M arrow(s)(t)$?
        #solution[
          The solution space has dimension $2$. Since $M$ is a $2 times 2$ matrix, there are exactly
          2 linearly independent solutions.
        ]
      + Give a _real_ basis for all solutions to $arrow(s)'(t) = M arrow(s)(t)$ and write down its
        general _real_ solution.
        #solution[
          From the previous question, the two real solutions
          $
            arrow(u)(t) = mat(cos t + sin t; 2 cos t) wide "and" wide
            arrow(v)(t) = mat(cos t - sin t; -2 sin t)
          $
          are linearly independent (their values at $t = 0$ are $mat(1; 2)$ and $mat(1; 0)$, which
          are linearly independent). They form a real basis. Therefore, the general real solution is
          $
            arrow(s)(t) = A arrow(u)(t) + B arrow(v)(t),
          $
          where $A$ and $B$ are _real_ parameters.
        ]
      // + Find a solution satisfying $arrow(s)(0) = mat(1; 3)$.
      //   #solution[
      //     Write $arrow(s)(t) = c_1 arrow(u)(t) + c_2 arrow(v)(t)$. At $t = 0$:
      //     $
      //       c_1 mat(1; 2) + c_2 mat(1; 0) = mat(1; 3).
      //     $
      //     The second row gives $2 c_1 = 3$, so $c_1 = 3/2$. The first row then gives
      //     $c_2 = 1 - c_1 = -1/2$. Therefore
      //     $
      //       arrow(s)(t) = 3/2 mat(cos t + sin t; 2 cos t) - 1/2 mat(cos t - sin t; -2 sin t)
      //       = mat(cos t + 2 sin t; 3 cos t + sin t).
      //     $
      //   ]
      + Using what you know, find the general solution to
        $arrow(r)thin' = mat(-1, 1; -2, 1) arrow(r) + mat(-2; 1)$.
        #solution[
          Since $arrow(s)(t) = arrow(r)(t) - mat(3; 5)$, we have
          $
            arrow(r)(t) = arrow(s)(t) + mat(3; 5)
            = A mat(cos t + sin t; 2 cos t) + B mat(cos t - sin t; -2 sin t) + mat(3; 5).
          $
          where $A$ and $B$ are real parameters.
        ]
      + Find a formula for $arrow(r)(t)$ satisfying $arrow(r)(0) = mat(4; 8)$.
        #solution[
          Since $arrow(r)(0)=mat(4; 8)$, we need to solve
          $
            mat(4; 8)= arrow(r)(0) & = A mat(cos 0 + sin 0; 2 cos 0) + B mat(cos 0 - sin 0; -2 sin 0) + mat(3; 5) \
            & = A mat(1; 2) + B mat(1; 0) + mat(3; 5)
            = mat(A + B + 3; 2A + 5)
          $
          for $A$ and $B$. This gives $A=3/2$ and $B=-1/2$, and so
          $
            arrow(r)(t) = mat(cos t + 2 sin t + 3; 3 cos t + sin t + 5).
          $
        ]
    ]
  })


  book_only(pagebreak())
  question({
    learning_objectives(
      [Incorporate new assumptions into an existing model.],
      [Deduce how complex eigenvalues relate to the stability of an equilibrium solution.],
    )
    notes[
      We have a classification method for equilibrium solutions to matrix differential equations
      with table for real eigenvalues. The goal of this question (along with a little modelling
      practice) is to develop a classification method for complex eigenvalues.

      - $a$ is meant to represent the concentration of a chemical in the shampoo. $a=1$ corresponds
        to the original *FD* model (where the dogs were shampooed with a generic
        shampoo---unmentioned in the model premises).

      - In @ex:fd_shampoo_equilibrium[] and @ex:fd_shampoo_analytic[], encourage students to use a
        computer to do the algebra for them. Otherwise it will take a _long_ time.

      - In @ex:fd_shampoo_graphical[], it is hard to see from the picture the stability when
        $a approx 1$. This should be acknowledged as a motivation for analytic methods. However, you
        can ask students to conjecture as to what happens when the model transitions from unstable
        to stable (and at which value of $a$ this occurs).

      - Part @ex:fd_shampoo_analytic[] requires some lecturing. Since we don't have a classification
        table for complex eigenvalues, we need to derive stability from the general solution.

        In your explanation, first discuss how we pass to a matrix differential equation. Then,
        assign names (like $arrow(v)_1$ and $arrow(v)_2$) to the eigenvectors (if students pursue
        the exact eigenvectors, the algebra will be overwhelming). Finally study the $e^(lambda t)$
        terms. When will they grow? When will they shrink?

        See the solution for an example of how to do this explanation.

      - In @ex:fd_shampoo_analytic[], we more-or-less derive the table in @mod:complex. Let students
        know your expectations in terms of whether or not they need to be able to re-derive the
        stability conditions on a test.
    ]
    slide[

      Recall the *FD* model of Fleas and Dogs where
      $
               F(t) & = "number of parasites (fleas) at year " t " (in millions)" \
               D(t) & = "number of hosts (dogs) at year " t " (in thousands)" \
        arrow(r)(t) & = mat(F(t); D(t))
                      wide wide arrow(s)(t) = arrow(r)(t) - mat(3; 5)
      $

      and

      $ arrow(s)'(t) = M arrow(s)(t) wide "where" wide M = mat(-1, 1; -2, 1). $

      Some research is being done on a shampoo for the dogs. It affects flea and dog reproduction:

      #aligned_terms(
        terms.item($("P"_"shampoo 1")$, [Ignoring all else, the number of parasites decays in
          proportion to its population with constant $a$.]),
        terms.item($("P"_"shampoo 2")$, [Ignoring all else, hosts numbers grow in proportion to
          their current number with constant $2 - a$.]),
      )
      - $0 <= a <= 2$.

      _These premises replace $("P"_"fleas 1")$ and $("P"_"dogs 1")$._

      + Modify the previous *FD* model to incorporate the effects of the shampoo.
        #solution[
          Replacing the decay constant for fleas and the growth constant for dogs gives
          $
            F' & = -a F + D - 2 \
            D' & = -2 F + (2-a) D + 1,
          $
          or in affine form $arrow(r)' = M_a arrow(r) + arrow(b)$ with $M_a = mat(-a, 1; -2, 2-a)$
          and $arrow(b) = mat(-2; 1)$.
        ]
      + Make a phase portrait for the *FD Shampoo* model.
        #solution[
          #{
            h(1fr)
            let a = 1 / 2
            vector_field(
              ((F, D) => (-(a) * F + D - 2, -2 * F + (2 - a) * D + 1)),
              xlim: (-1, 7),
              ylim: (0, 10),
              spacing: (.7, .7),
              scale_segments: 18,
              width: 4.5cm,
              height: 4.5cm,
              xaxis: (position: 0, tip: tiptoe.stealth, ticks: none, subticks: none),
              yaxis: (position: 0, tip: tiptoe.stealth, ticks: none, subticks: none),
              title: $a = 1/2$,
            )
            h(1fr)
            let a = 3 / 2
            vector_field(
              ((F, D) => (-(a) * F + D - 2, -2 * F + (2 - a) * D + 1)),
              xlim: (-1, 7),
              ylim: (0, 10),
              spacing: (.7, .7),
              scale_segments: 18,
              width: 4.5cm,
              height: 4.5cm,
              xaxis: (position: 0, tip: tiptoe.stealth, ticks: none, subticks: none),
              yaxis: (position: 0, tip: tiptoe.stealth, ticks: none, subticks: none),
              title: $a = 3/2$,
            )
            h(1fr)
          }
        ]
      + #label_question_part(<ex:fd_shampoo_equilibrium>) Find the equilibrium solutions for the *FD
        Shampoo* model.
        #solution[
          Setting $arrow(r)' = arrow(0)$ and solving $M_a arrow(E) = -arrow(b)$:
          $
                  -a E_F + E_D & = 2 \
            -2 E_F + (2-a) E_D & = -1.
          $
          From the first equation $E_D = a E_F + 2$. Substituting and simplifying:
          $
            E_F = frac(5-2a, a^2-2a+2), quad E_D = frac(4 + a, a^2-2a+2).
          $
          For $a=1$ this reduces to $(3, 5)$, consistent with the original *FD* model.
        ]
      + #label_question_part(<ex:fd_shampoo_graphical>) For each equilibrium solution determine its
        stability/instability/etc. by examining the phase portrait.
        #solution[
          From the phase portraits, it looks like the equilibrium is repelling and unstable for
          $a < 1/2$ and attracting and stable for $a > 3/2$.

          By watching the phase portrait as $a$ varies from $1/2$ to $3/2$, we conjecture
          - If $a < 1$: *unstable and repelling* (spiral out).
          - If $a > 1$: *stable and attracting* (spiral in).
          - If $a = 1$: *stable but not attracting*.
        ]
      + #label_question_part(<ex:fd_shampoo_analytic>) Analytically justify your conclusions about
        stability/instability/etc.
        #solution[
          We can study stability/instability by looking at the eigenvalues of $mat(-a, 1; -2, 2-a)$.
          The characteristic polynomial is $lambda^2 + 2(a-1) lambda + (a^2-2a+2)$ which gives
          eigenvalues of
          $
            lambda = 1 - a plus.minus i.
          $
          Supposing that $arrow(v)_1$ and $arrow(v)_2$ are the corresponding eigenvectors gives us a
          general solution of
          $
            arrow(s)(t) & = A e^((1-a + i)t) arrow(v)_1 + B e^((1-a - i)t) arrow(v)_2 \
                        & = e^((1-a)t)(A e^(i t) arrow(v)_1 + B e^(-i t) arrow(v)_2),
          $
          where $A,B$ are (complex) parameters. Calling
          $C(t)=A e^(i t) arrow(v)_1 + B e^(-i t) arrow(v)_2$ gives
          $
            arrow(s)(t) = e^((1-a)t) C(t).
          $
          No matter the values of $A$ and $B$, the term $C(t)$ is periodic (as can be seen via
          Euler's formula) and therefore bounded. Thus the $e^((1-a)t)$ term dominates:

          - If $1-a < 0$, this term goes to zero.
          - If $1-a > 0$, this term is unbounded.
          - If $1-a = 0$, this term is constant.

          Thus, if $a > 1$, the equilibrium is stable and attracting. If $a < 1$, the equilibrium is
          unstable and repelling. If $a = 1$, the equilibrium is stable but not attracting.

        ]


    ]
  })


  book_only(pagebreak())
  question({
    learning_objectives(
      (
        [Classify the equilibrium solution to a matrix differential equation with complex
          eigenvalues.],
      ),
    )
    notes[
      This question is practice with classifying equilibrium solutions to matrix differential
      equations with complex eigenvalues without the cognitive load of modelling.

      It can be *skipped* if you are short on time.
    ]
    slide[

      Consider the differential equation
      $ arrow(s)'(t) = M arrow(s)(t) quad "where" quad M = mat(-1, -4; 2, 3) $

      + Make a phase portrait. Based on your phase portrait, classify the equilibrium solution.

        #link("https://www.desmos.com/calculator/h3wtwjghv0")

        #solution[
          #{
            set align(center)
            vector_field(
              ((x, y) => (-x - 4 * y, 2 * x + 3 * y)),
              xlim: (-4, 4),
              ylim: (-4, 4),
              spacing: (.7, .7),
              scale_segments: 10,
              width: 5cm,
              height: 5cm,
              xaxis: (position: 0, tip: tiptoe.stealth, ticks: none, subticks: none),
              yaxis: (position: 0, tip: tiptoe.stealth, ticks: none, subticks: none),
            )
          }

          The phase portrait shows solutions spiraling outward away from the origin. The equilibrium
          at the origin appears *unstable and repelling*.
        ]
      + Find eigen solutions for this differential equation (you may use a calculator/computer to
        assist).
        #solution[
          The characteristic polynomial is
          $
            det(M - lambda I) = lambda^2 - 2 lambda + 5,
          $
          giving eigenvalues of $lambda = 1 plus.minus 2i$.

          Solving for the corresponding eigenvectors gives us eigen solutions
          $
            arrow(s)_1(t) = e^((1+2i)t) mat(-1+i; 1) wide "and" wide arrow(s)_2(t) = e^((1-2i)t) mat(-1-i; 1).
          $
        ]
      + Find a general _real_ solution.
        #solution[
          The general real solution is
          $
            arrow(s)(t) = c_1 e^t mat(-2cos 2t - 2sin 2t; 2cos 2t) + c_2 e^t mat(2cos 2t - 2sin 2t; 2sin 2t),
          $
          where $c_1$ and $c_2$ are real parameters.
        ]
      + Analytically classify the equilibrium solution.
        #solution[
          The eigenvalues are $1 plus.minus 2i$. Since the real part is greater than zero, all
          solutions spiral away from the origin, so the equilibrium is *unstable and repelling*.
        ]


    ]
  })
}
