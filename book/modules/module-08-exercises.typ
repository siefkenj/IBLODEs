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
          #solution[
            $
              F' & = underbrace(-F, "P"1_F) + underbrace(D, "P"2_F) underbrace(-2, "P"1_c) \
              D' & = underbrace(-2F, "P"2_D) + underbrace(D, "P"1_D) underbrace(+1, "P"2_c)
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
        + Make a phase portrait for your model.
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
        + What should solutions to the system look like in the phase plane? What are the equilibrium
          solution(s)?
          #solution[
            The equilibrium is found by solving $M arrow(E) + arrow(b) = arrow(0)$:
            $
                -E_F + E_D & = 2 \
              -2 E_F + E_D & = -1
            $
            Subtracting gives $E_F = 3$ and then $E_D = 5$, so the unique equilibrium is
            $(F, D) = (3, 5)$.

            The matrix $M = mat(-1, 1; -2, 1)$ has characteristic polynomial $lambda^2 + 1 = 0$,
            giving pure imaginary eigenvalues $lambda = plus.minus i$. Solutions in the phase plane
            are therefore closed curves (a center) surrounding the equilibrium $(3, 5)$.
          ]


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
      + Find an eigenvector for each eigenvalue of $M$.
        #solution[
          For $lambda = i$: solving $(M - i I)arrow(v) = arrow(0)$ via the first row
          $(-1-i)v_1 + v_2 = 0$ gives $v_2 = (1+i)v_1$. Taking $v_1 = 1-i$ (to simplify $v_2$):
          $v_2 = (1+i)(1-i) = 2$, so an eigenvector is $mat(1-i; 2)$.

          For $lambda = -i$: by conjugation, an eigenvector is $mat(1+i; 2)$.
        ]
      + What are the eigen solutions for $arrow(s)' = M arrow(s)$?
        #solution[
          $
            arrow(s)_1(t) = e^(i t) mat(1-i; 2), quad arrow(s)_2(t) = e^(-i t) mat(1+i; 2).
          $
        ]

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
          #solution[
            $
              arrow(s)_1 + arrow(s)_2 & = (cos t + i sin t) mat(1-i; 2) + (cos t - i sin t) mat(1+i; 2).
            $
            First component:
            $
              (cos t + i sin t)(1 - i) + (cos t - i sin t)(1 + i) = 2 cos t + 2 sin t.
            $
            Second component: $2(cos t + i sin t) + 2(cos t - i sin t) = 4 cos t$.

            So $arrow(s)_1 + arrow(s)_2 = mat(2 cos t + 2 sin t; 4 cos t)$. No imaginary numbers
            remain.
          ]
        + Use Euler's formula to expand $i (arrow(s)_1 - arrow(s)_2)$. Are there any imaginary
          numbers remaining?
          #solution[
            $
              arrow(s)_1 - arrow(s)_2 = mat(2 i(sin t - cos t); 4 i sin t),
            $
            so
            $
              i(arrow(s)_1 - arrow(s)_2) = mat(2 i^2(sin t - cos t); 4 i^2 sin t) = mat(2 cos t - 2 sin t; -4 sin t).
            $
            No imaginary numbers remain.
          ]
      + Verify that your formulas for $arrow(s)_1 + arrow(s)_2$ and $i (arrow(s)_1 - arrow(s)_2)$
        are solutions to
        $arrow(s)'(t) = M arrow(s)(t).$
        #solution[
          Since $arrow(s)_1$ and $arrow(s)_2$ are solutions and the equation is linear, any linear
          combination is also a solution. We can also verify directly:

          Let $arrow(u) = mat(2 cos t + 2 sin t; 4 cos t)$. Then
          $
            arrow(u)' = mat(-2 sin t + 2 cos t; -4 sin t)
            wide "and" wide
            M arrow(u) = mat(-(2 cos t + 2 sin t) + 4 cos t; -2(2 cos t + 2 sin t) + 4 cos t)
            = mat(2 cos t - 2 sin t; -4 sin t).
          $

          Wait, let me recheck: $arrow(u)' = mat(2 cos t - 2 sin t; -4 sin t) = M arrow(u)$.
          #sym.checkmark

          Similarly, let $arrow(v) = mat(2 cos t - 2 sin t; -4 sin t)$. Then
          $
            arrow(v)' = mat(-2 sin t - 2 cos t; -4 cos t)
            wide "and" wide
            M arrow(v) = mat(-(2 cos t - 2 sin t) - 4 sin t; -2(2 cos t - 2 sin t) - 4 sin t)
            = mat(-2 cos t - 2 sin t; -4 cos t).
          $
          So $arrow(v)' = M arrow(v)$. #sym.checkmark
        ]
      + Can you give a third _real_ solution to $arrow(s)'(t) = M arrow(s)(t)?$
        #solution[
          Any linear combination of $arrow(s)_1 + arrow(s)_2$ and $i(arrow(s)_1 - arrow(s)_2)$ is
          also a real solution. For example,
          $
            (arrow(s)_1 + arrow(s)_2) + i(arrow(s)_1 - arrow(s)_2) = mat(4 cos t; 4 cos t - 4 sin t).
          $
        ]



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
        #solution[
          The solution space has dimension $2$. Since $M$ is a $2 times 2$ matrix, there are exactly
          2 linearly independent solutions.
        ]
      + Give a _real_ basis for all solutions to $arrow(s)'(t) = M arrow(s)(t)$.
        #solution[
          From the previous question, the two real solutions
          $
            arrow(u)(t) = mat(2 cos t + 2 sin t; 4 cos t) wide "and" wide
            arrow(v)(t) = mat(2 cos t - 2 sin t; -4 sin t)
          $
          are linearly independent (their values at $t = 0$ are $mat(2; 4)$ and $mat(2; 0)$, which
          are linearly independent). They form a real basis.
        ]
      + Find a solution satisfying $arrow(s)(0) = mat(1; 3)$.
        #solution[
          Write $arrow(s)(t) = c_1 arrow(u)(t) + c_2 arrow(v)(t)$. At $t = 0$:
          $
            c_1 mat(2; 4) + c_2 mat(2; 0) = mat(1; 3).
          $
          The second row gives $4 c_1 = 3$, so $c_1 = 3/4$. The first row then gives
          $c_2 = (1 - 2 c_1) / 2 = -1/4$. Therefore
          $
            arrow(s)(t) = 3/4 mat(2 cos t + 2 sin t; 4 cos t) - 1/4 mat(2 cos t - 2 sin t; -4 sin t)
            = mat(cos t + 2 sin t; 3 cos t + sin t).
          $
        ]
      + Using what you know, find a general formula for $arrow(r)(t)$.
        #solution[
          Since $arrow(s)(t) = arrow(r)(t) - mat(3; 5)$, we have
          $
            arrow(r)(t) = arrow(s)(t) + mat(3; 5)
            = c_1 mat(2 cos t + 2 sin t; 4 cos t) + c_2 mat(2 cos t - 2 sin t; -4 sin t) + mat(3; 5).
          $
        ]
      + Find a formula for $arrow(r)(t)$ satisfying $arrow(r)(0) = mat(4; 8)$.
        #solution[
          The initial displacement is $arrow(s)(0) = mat(4; 8) - mat(3; 5) = mat(1; 3)$, which
          matches the previous part. Therefore
          $
            arrow(r)(t) = mat(cos t + 2 sin t + 3; 3 cos t + sin t + 5).
          $
        ]
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
        #solution[
          Replacing the decay constant for fleas and the growth constant for dogs gives
          $
            F' & = -(1+a) F + D - 2 \
            D' & = -2 F + (1-a) D + 1,
          $
          or in affine form $arrow(r)' = M_a arrow(r) + arrow(b)$ with
          $M_a = mat(-(1+a), 1; -2, 1-a)$ and $arrow(b) = mat(-2; 1)$.
        ]
      + Make a phase portrait for the *FD Shampoo* model.
        #solution[
          #{
            h(1fr)
            let a = -1 / 2
            vector_field(
              ((F, D) => (-(1 + a) * F + D - 2, -2 * F + (1 - a) * D + 1)),
              xlim: (-1, 7),
              ylim: (0, 10),
              spacing: (.7, .7),
              scale_segments: 18,
              width: 4.5cm,
              height: 4.5cm,
              xaxis: (position: 0, tip: tiptoe.stealth, ticks: none, subticks: none),
              yaxis: (position: 0, tip: tiptoe.stealth, ticks: none, subticks: none),
              title: $a = -1/2$,
            )
            h(1fr)
            let a = 1 / 2
            vector_field(
              ((F, D) => (-(1 + a) * F + D - 2, -2 * F + (1 - a) * D + 1)),
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
          }
        ]
      + Find the equilibrium solutions for the *FD Shampoo* model.
        #solution[
          Setting $arrow(r)' = arrow(0)$ and solving $M_a arrow(E) = -arrow(b)$:
          $
              -(1+a) E_F + E_D & = 2 \
            -2 E_F + (1-a) E_D & = -1.
          $
          From the first equation $E_D = (1+a) E_F + 2$. Substituting and simplifying:
          $
            E_F = frac(3 - 2a, 1 + a^2), quad E_D = frac(5 + a, 1 + a^2).
          $
          For $a=0$ this reduces to $(3, 5)$, consistent with the original *FD* model.
        ]
      + For each equilibrium solution determine its stability/instability/etc.
        #solution[
          The eigenvalues of $M_a$ (computed in the next part) are $-a plus.minus i$, with real part
          $-a$.

          - If $a > 0$: real part $< 0$ $arrow.r$ *stable and attracting* (spiral in).
          - If $a = 0$: pure imaginary $arrow.r$ *stable but not attracting* (center).
          - If $a < 0$: real part $> 0$ $arrow.r$ *unstable and repelling* (spiral out).
        ]
      + Analytically justify your conclusions about stability/instability/etc.
        #solution[
          The linearization at the equilibrium is $M_a$ itself (since the system is already affine).
          Its trace and determinant are
          $
            "tr"(M_a) = -(1+a) + (1-a) = -2a, quad
            det(M_a) = -(1+a)(1-a) + 2 = 1 + a^2.
          $
          The characteristic polynomial is $lambda^2 + 2a lambda + (1 + a^2)$. The discriminant is
          $
            (2a)^2 - 4(1 + a^2) = -4 < 0,
          $
          so eigenvalues are always complex: $lambda = -a plus.minus i$. The real part is $-a$,
          which determines stability as described above.
        ]


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
        #solution[
          #{
            set align(center)
            vector_field(
              ((x, y) => (-x - 4 * y, 2 * x + 3 * y)),
              xlim: (-4, 4),
              ylim: (-4, 4),
              spacing: (.7, .7),
              scale_segments: 18,
              width: 5cm,
              height: 5cm,
              xaxis: (position: 0, tip: tiptoe.stealth, ticks: none, subticks: none),
              yaxis: (position: 0, tip: tiptoe.stealth, ticks: none, subticks: none),
            )
          }

          The phase portrait shows solutions spiraling outward away from the origin. The equilibrium
          at the origin appears *unstable and repelling*.
        ]

      #link("https://www.desmos.com/calculator/h3wtwjghv0")
      + Find eigen solutions for this differential equation (you may use a calculator/computer to
        assist).
        #solution[
          The characteristic polynomial is
          $
            det(M - lambda I) = (-1-lambda)(3-lambda) + 8 = lambda^2 - 2 lambda + 5 = 0,
          $
          giving $lambda = 1 plus.minus 2i$.

          For $lambda = 1 + 2i$: solving $(M - (1+2i)I) arrow(v) = arrow(0)$, the first row gives
          $(-2-2i) v_1 - 4 v_2 = 0$, so $v_1 = -v_2(1-i)$. Taking $v_2 = 1$: eigenvector
          $mat(-1+i; 1)$.

          The eigen solutions are
          $
            arrow(s)_1(t) = e^((1+2i)t) mat(-1+i; 1), quad arrow(s)_2(t) = e^((1-2i)t) mat(-1-i; 1).
          $
        ]
      + Find a general _real_ solution.
        #solution[
          Expand $arrow(s)_1(t) = e^t (cos 2t + i sin 2t) mat(-1+i; 1)$:
          $
            "Re"(arrow(s)_1) = e^t mat(-cos 2t - sin 2t; cos 2t), quad
            "Im"(arrow(s)_1) = e^t mat(cos 2t - sin 2t; sin 2t).
          $
          The general real solution is
          $
            arrow(s)(t) = c_1 e^t mat(-cos 2t - sin 2t; cos 2t) + c_2 e^t mat(cos 2t - sin 2t; sin 2t).
          $
        ]
      + Analytically classify the equilibrium solution.
        #solution[
          The eigenvalues are $1 plus.minus 2i$. Since the real part is $1 > 0$, all solutions
          spiral away from the origin, so the equilibrium is *unstable and repelling*.
        ]


    ]
  })
}
