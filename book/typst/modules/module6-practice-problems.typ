#import "../libs/_workbook.typ": aligned_terms
#let questions = (
  (
    statement: [
      Define

      $
        arrow(p)(t) = mat(e^t; 0) wide
        arrow(q)(t) = mat(4 e^t; 0) \
        arrow(h)(t) = mat(0; e^(2t)) wide
        arrow(z)(t) = mat(0; e^(3t))
      $

      + Are $arrow(p)$ and $arrow(q)$ linearly independent or linearly dependent? Justify with the
        definition.
      + Are $arrow(p)$ and $arrow(h)$ linearly independent or linearly dependent? Justify with the
        definition.
      + Are $arrow(h)$ and $arrow(z)$ linearly independent or linearly dependent? Justify with the
        definition.
      + Is the set of three functions ${arrow(p),arrow(h),arrow(z)}$ linearly independent or
        linearly dependent? Justify with the definition.
      + Describe $"span"{arrow(p), arrow(h)}$. What is its dimension? What is a basis for it?
      + Let $S$ be the set of all solutions to $arrow(r)'(t) = mat(1, 0; 0, 2) arrow(r)(t)$.

        Is $S$ a subspace? If so, what is its dimension?

      + Provided $S$ is a subspace, give a basis for $S$.
    ],
    solution: [
      The answer to the second question.
    ],
  ),
  (
    statement: [
      Consider the differential equation
      $ y'(t) = 2 dot.c y(t). $

      + Write a solution whose graph passes through the point $(t,y)=(0,3)$.
      + Write a solution whose graph passes through the point $(t,y)=(0,y_0)$.
      + Write a solution whose graph passes through the point $(t,y)=(t_0,y_0)$.
      + Consider the following argument:

        #aligned_terms(
          terms.item(
            "",
            [
              For every point $(t_0, y_0)$, there is a corresponding solution to
              $y'(t) = 2 dot.c y(t)$.

              Since ${(t_0,y_0): t_0, y_0 in RR}$ is two dimensional, this means the set of
              solutions to $y'(t) = 2 dot.c y(t)$ is two dimensional.
            ],
          ),
        )

        Do you agree? Explain.
    ],
  ),
  (
    statement: [
      Let $S$ be the set of all solutions to
      $ arrow(r)(t)= mat(1, 0; 0, 2) arrow(r)(t). $

      + Show that $"dim"(S) gt.eq 2$ by finding at least two linearly independent solutions.

      + Let $I$ be the set of all initial conditions. What is $I$?
      + Show that $"dim"(S) lt.eq 3$ by applying the theorem to the set of initial conditions.
      + Can two points in $I$ correspond to the same solution? Explain?
      + Find a subset $U subset.eq I$ so that every solution corresponds to a unique point in $U$.
      + Show that $"dim"(S) lt.eq 2$.
      + Suppose $M$ is an $n times n$ matrix. Consider the differential equation
        $arrow(r)'(t) = M arrow(r)(t)$. If you have found $n$ linearly independent solutions, can
        you determine the dimension of the set of all solutions? Explain.

    ],
    solution: [
      + Way 1 is good
      + Way 2 is better
    ],
    citation: [X],
  ),
)
