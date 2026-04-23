#import "../libs/lib.typ": *
#show: e.prepare(question)

#{
  lesson(title: [Complex Solutions], include "lesson-week-08.typ")
  question({
    learning_objectives(
      [???],
    )
    notes[???]
    slide(force_scale: 0.85em)[

      Consider the following *FD* model of Fleas and Dogs where
      $
        F(t) & = "number of parasites (fleas) at year " t " (in millions)" \
        D(t) & = "number of hosts (dogs) at year " t " (in thousands)"
      $

      - (P$1_F$) Ignoring all else, the number of parasites decays in proportion to its population
        (with constant 1).
      - (P$2_F$) Ignoring all else, parasite numbers grow in proportion to the number of hosts (with
        constant 1 $"mega flea"/"kilo dog"$).
      - (P$1_D$) Ignoring all else, hosts numbers grow in proportion to their current number (with
        constant 1).
      - (P$2_D$) Ignoring all else, host numbers decrease in proportion to the number of parasites
        (with constant 2 $"kilo dog"/"mega flea"$).
        #slides_only(colbreak())
      - (P$1_c$) Anti-flea collars remove 2 million fleas per year.
      - (P$2_c$) Constant dog breeding adds 1 thousand dogs per year.

        + Write a system of differential equations for the *FD* model.
          #solution[???]
        + Can you rewrite the system in matrix form $arrow(r)' = M arrow(r)$? What about in _affine_
          form $arrow(r)' = M arrow(r) + arrow(b)$?
          #solution[???]
        + Make a phase portrait for your model.
          #solution[???]
        + What should solutions to the system look like in the phase plane? What are the equilibrium
          solution(s)?
          #solution[???]


    ]
  })


  book_only(pagebreak())
  question({
    learning_objectives(
      [???],
    )
    notes[???]
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
        #solution[???]
      + Can you find a matrix $M$ so that $arrow(s)'(t) = M arrow(s)(t)$?
        #solution[???]
      + What are the eigenvalues of $M$?
        #solution[???]
      + Find an eigenvector for each eigenvalue of $M$.
        #solution[???]
      + What are the eigen solutions for $arrow(s)' = M arrow(s)$?
        #solution[???]

    ]
  })


  book_only(pagebreak())
  question({
    learning_objectives(
      [???],
    )
    notes[???]
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
        arrow(s)_1(t) & = e^(i t) mat(1 - i; 2) \
        arrow(s)_2(t) & = e^(-i t) mat(1 + i; 2).
      $

      + Recall Euler's formula $e^(i t) = cos(t) + i sin(t)$.
        + Use Euler's formula to expand $arrow(s)_1 + arrow(s)_2$. Are there any imaginary numbers
          remaining?
          #solution[???]
        + Use Euler's formula to expand $i (arrow(s)_1 - arrow(s)_2)$. Are there any imaginary
          numbers remaining?
          #solution[???]
      + Verify that your formulas for $arrow(s)_1 + arrow(s)_2$ and $i (arrow(s)_1 - arrow(s)_2)$
        are solutions to
        $arrow(s)'(t) = M arrow(s)(t).$
        #solution[???]
      + Can you give a third _real_ solution to $arrow(s)'(t) = M arrow(s)(t)?$
        #solution[???]



    ]
  })


  book_only(pagebreak())
  question({
    learning_objectives(
      [???],
    )
    notes[???]
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
        #solution[???]
      + Give a _real_ basis for all solutions to $arrow(s)'(t) = M arrow(s)(t)$.
        #solution[???]
      + Find a solution satisfying $arrow(s)(0) = mat(1; 3)$.
        #solution[???]
      + Using what you know, find a general formula for $arrow(r)(t)$.
        #solution[???]
      + Find a formula for $arrow(r)(t)$ satisfying $arrow(r)(0) = mat(4; 8)$.
        #solution[???]
    ]
  })


  book_only(pagebreak())
  question({
    learning_objectives(
      [???],
    )
    notes[???]
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
      - (P$S_F$) Ignoring all else, the number of parasites decays in proportion to its population
        with constant $1 + a$.
      - (P$S_D$) Ignoring all else, hosts numbers grow in proportion to their current number with
        constant $1 - a$.
      - $-1 <= a <= 1$.

      _These premises replace (P$1_F$) and (P$1_D$)._

      + Modify the previous *FD* model to incorporate the effects of the shampoo.
        #solution[???]
      + Make a phase portrait for the *FD Shampoo* model.
        #solution[???]
      + Find the equilibrium solutions for the *FD Shampoo* model.
        #solution[???]
      + For each equilibrium solution determine its stability/instability/etc.
        #solution[???]
      + Analytically justify your conclusions about stability/instability/etc.
        #solution[???]


    ]
  })


  book_only(pagebreak())
  question({
    learning_objectives(
      [???],
    )
    notes[???]
    slide[

      Consider the differential equation
      $ arrow(s)'(t) = M arrow(s)(t) quad "where" quad M = mat(-1, -4; 2, 3) $

      + Make a phase portrait. Based on your phase portrait, classify the equilibrium solution.
        #solution[???]

      #link("https://www.desmos.com/calculator/h3wtwjghv0")
      + Find eigen solutions for this differential equation (you may use a calculator/computer to
        assist).
        #solution[???]
      + Find a general _real_ solution.
        #solution[???]
      + Analytically classify the equilibrium solution.
        #solution[???]


    ]
  })
}
