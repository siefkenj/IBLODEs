#import "../libs/lib.typ": *
#show: e.prepare(question)

#{
  question({
    learning_objectives(
      [???],
    )
    notes[???]
    slide(force_scale: 0.89em)[

      #slides_only([*Existence and Uniqueness*])



      Whether a solution to a differential equation exists or is unique is a #emph[hard] question
      with many partial answers.


      #book_only([Recall the Theorem:])

      #theorem(
        title: [Existence and Uniqueness II],
        [
          Let $F(t, x, x') = 0$ with $x(t_0) = x_0$ describe an initial value problem.

          - IF $F(t, x, x') = x'(t) + p(t) x(t) + g(t)$ for some functions $p$ and $g$
          - AND $p$ and $g$ are continuous on an open interval $I$ containing $t_0$
          - THEN the initial value problem has a unique solution on $I$.
        ],
      )




      + The theorem expresses differential equations in the form $F(t, x, x', x'', dots) = 0$ (i.e.
        as a level set of some function $F$).

        Rewrite the following differential equations in the form $F(t, x, x', x'', dots) = 0$:
        + $x'' = -k x$
          #solution[
            $F(t, x, x'') = x'' + k x = 0$.
          ]
        + $x'' = -x dot x' + x^2$
          #solution[
            $F(t, x, x', x'') = x'' + x dot x' - x^2 = 0$.
          ]
        + $x''' = (x')^2 - cos x$
          #solution[
            $F(t, x, x', x''') = x''' - (x')^2 + cos x = 0$.
          ]

      + Which of the following does the theorem say _must_ have a unique solution on an interval
        containing $0$?
        + $y' = frac(3, 2) y^(1/3)$ with $y(0) = 0$
          #solution[
            The theorem requires $F(t, x, x') = x'(t) + p(t) x(t) + g(t)$, i.e., the equation must
            be *first-order and linear* in $x$. Here $F = y' - frac(3, 2) y^(1/3)$; the term
            $y^(1/3)$ is not of the form $p(t) y$. The theorem does *not* apply.
          ]
        + $x'(t) = floor(t) x(t)$ with $x(0) = 0$
          #solution[
            Here $F = x' - floor(t) x$, which is $x' + p(t) x + g(t) = 0$ with $p(t) = -floor(t)$
            and $g(t) = 0$. However, $floor(t)$ has a jump discontinuity at $t = 0$ (it equals $-1$
            for $t in (-1, 0)$ and $0$ for $t in [0, 1)$), so $p$ is *not continuous* on any open
            interval containing $t_0 = 0$. The theorem does *not* apply.
          ]
        + $x'(t) = floor(t - frac(1, 2)) x(t) + t^2$ with $x(0) = 0$
          #solution[
            Here $F = x' - floor(t - 1\/2) x - t^2$, giving $p(t) = -floor(t - 1\/2)$ and
            $g(t) = -t^2$.

            The jump discontinuities of $floor(t - 1\/2)$ occur where $t - 1\/2$ is an integer,
            i.e., at $t = dots, -1\/2, 1\/2, 3\/2, dots$. The nearest jumps to $t_0 = 0$ are at
            $t = -1\/2$ and $t = 1\/2$.

            On the open interval $(-1\/2, 1\/2)$ containing $t_0 = 0$:
            $
              t - 1\/2 in (-1, 0) wide arrow.r wide floor(t - 1\/2) = -1 wide "(constant)".
            $
            So $p(t) = -(-1) = 1$ and $g(t) = -t^2$ are both continuous on $(-1\/2, 1\/2)$.

            The theorem *does* apply: the IVP has a unique solution on $(-1\/2, 1\/2)$.
          ]

        Note: $floor(x)$ is the _floor_ of $x$, i.e., the largest integer less than or equal to $x$.


    ]
  })
}
