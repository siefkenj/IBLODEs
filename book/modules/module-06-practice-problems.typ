#import "../libs/lib.typ": *

// XXX: add a continuation to @ex:general_eigen_solution_with_initial_values[] that asks students for interpretations in component space of what it means to "pass through any initial condition".



#let questions = (
  (
    statement: [Let $A$ be a $3 times 3$ matrix with eigenvalue of $3$ and a corresponding
      eigenvector $arrow(v) = mat(1; -1; 3)$. Find $A arrow(v)$.#v(.7em)],
    solution: [
      $A arrow(v) = 3 arrow(v) = 3 mat(1; -1; 3) = mat(3; -3; 9)$#v(.7em)
    ],
    citation: [_Notes on Diffy Q's_ by Jiří Lebl 2.4.5],
  ),
  (
    statement: [Find the general solution of $cases(x'_1=3x_1+x_2, x'_2=2x_1+4x_2)$ using the
      eigenvalue method. Do not use complex exponentials in your solution.#v(0.5em)],
    solution: [
      The coefficient matrix is $A = mat(3, 1; 2, 4)$, with characteristic equation $lambda^2 - 7 lambda + 10 = (lambda - 2)(lambda - 5) = 0$, so the eigenvalues are $lambda = 2, 5$. For $lambda = 2$, $A - 2I = mat(1, 1; 2, 2)$ gives the eigenvector $mat(1; -1)$; for $lambda = 5$, $A - 5I = mat(-2, 1; 2, -1)$ gives $mat(1; 2)$. Therefore
      $
        arrow(x) = C_1 mat(1; -1) e^(2t) + C_2 mat(1; 2) e^(5t) \ "where" C_1 "and" C_2 "are parameters."
      $#v(.7em)
    ],
    citation: [_Notes on Diffy Q's_ by Jiří Lebl 2.4.7],
  ),
  (
    statement: [Solve $cases(x'_1=x_2, x'_2=x_1)$ using the eigenvalue method.#v(0.7em)],
    solution: [
      The coefficient matrix is $A = mat(0, 1; 1, 0)$, with characteristic equation $lambda^2 - 1 = (lambda - 1)(lambda + 1) = 0$, so the eigenvalues are $lambda = 1, -1$. For $lambda = 1$, the associated eigenvector is $mat(1; 1)$; $lambda = -1$ gives $mat(1; -1)$. Therefore
      $arrow(x)= C_1 mat(1; 1)e^t + C_2 mat(1; -1) e^(-t)$#v(.7em)
    ],
    citation: [_Notes on Diffy Q's_ by Jiří Lebl 2.4.103],
  ),
  (
    statement: [Let $A = mat(5, -3; 3, -1)$. Find the general solution of
      $arrow(x)' = A arrow(x)$.],
    solution: [
      Here $A = mat(5, -3; 3, -1)$ has characteristic equation $lambda^2 - 4 lambda + 4 = (lambda - 2)^2 = 0$, so $lambda = 2$ is a repeated eigenvalue. Solving $(A - 2I) arrow(v) = arrow(0)$ with $A - 2I = mat(3, -3; 3, -3)$ yields only the single eigenvector $arrow(v) = mat(1; 1)$, so the eigenvalue is defective and we need a generalized eigenvector $arrow(w)$ satisfying $(A - 2I) arrow(w) = arrow(v)$. This requires $3 w_1 - 3 w_2 = 1$; taking $w_2 = 0$ gives $arrow(w) = mat(1/3; 0)$. Therefore
      $
        arrow(x) = C_1 mat(1; 1) e^(2t) + C_2 (mat(1; 1) t + mat(1/3; 0)) e^(2t) \ "where" C_1 "and" C_2 "are parameters."
      $#v(.7em)
    ],
    citation: [_Notes on Diffy Q's_ by Jiří Lebl 2.8.2],
  ),
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
      Recall that functions $arrow(f)_1, ..., arrow(f)_k$ are linearly dependent if there are constants $c_1, ..., c_k$, not all zero, such that $c_1 arrow(f)_1(t) + ... + c_k arrow(f)_k(t) = arrow(0)$ for all $t$; otherwise they are linearly independent.
      + *Dependent.* Since $arrow(q)(t) = mat(4 e^t; 0) = 4 mat(e^t; 0) = 4 arrow(p)(t)$, the combination $4 arrow(p)(t) - arrow(q)(t) = arrow(0)$ holds for all $t$ with coefficients $(4, -1) != (0, 0)$.
      + *Independent.* Suppose $c_1 arrow(p)(t) + c_2 arrow(h)(t) = mat(c_1 e^t; c_2 e^(2t)) = arrow(0)$ for all $t$. The first component forces $c_1 = 0$ and the second forces $c_2 = 0$, so only the trivial combination works.
      + *Independent.* Suppose $c_1 arrow(h)(t) + c_2 arrow(z)(t) = mat(0; c_1 e^(2t) + c_2 e^(3t)) = arrow(0)$ for all $t$. Dividing $c_1 e^(2t) + c_2 e^(3t) = 0$ by $e^(2t)$ gives $c_1 + c_2 e^t = 0$ for all $t$; since $e^t$ is non-constant this forces $c_2 = 0$, and then $c_1 = 0$, so only the trivial combination works.
      + *Independent.* Suppose $c_1 arrow(p)(t) + c_2 arrow(h)(t) + c_3 arrow(z)(t) = mat(c_1 e^t; c_2 e^(2t) + c_3 e^(3t)) = arrow(0)$ for all $t$. The first component gives $c_1 = 0$; the second gives $c_2 = c_3 = 0$ by the argument in part (c). Only the trivial combination works.
      + $"span"{arrow(p), arrow(h)}$ is the set of all functions $c_1 mat(e^t; 0) + c_2 mat(0; e^(2t)) = mat(c_1 e^t; c_2 e^(2t))$ with $c_1, c_2 in RR$. Since $arrow(p)$ and $arrow(h)$ are linearly independent (part (b)), they form a basis, so the dimension is $2$. A basis is ${arrow(p), arrow(h)}$.
      + Yes, $S$ is a subspace: it is the solution set of a linear homogeneous system, so the zero function is a solution and sums and scalar multiples of solutions are again solutions. Since the coefficient matrix is a diagonalizable, $2 times 2$ matrix, and $S$ is the set of all solutions, we have, by the Solution Space Dimension theorem stated earlier in the chapter, that 
        $"dim"(S) = 2$.
      + The functions $arrow(p)$ and $arrow(h)$ are themselves solutions: $arrow(p)'(t) = mat(e^t; 0) = mat(1, 0; 0, 2) arrow(p)(t)$ and $arrow(h)'(t) = mat(0; 2 e^(2t)) = mat(1, 0; 0, 2) arrow(h)(t)$, so both lie in $S$. They are linearly independent by part (b), so they span a $2$-dimensional subspace of $S$. Since $"dim"(S) = 2$ from part (f), that subspace must be all of $S$. We also know that a linearly independent set whose size equals the dimension is automatically a basis. Hence $S = "span"{arrow(p), arrow(h)}$, and ${arrow(p), arrow(h)}$ is a basis for $S$.
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
    solution: [
      The general solution of $y'(t) = 2 y(t)$ is $y(t) = C e^(2t)$ where C is a parameter.
      + Setting $y(0) = 3$ gives $C = 3$, so $y(t) = 3 e^(2t)$.
      + Setting $y(0) = y_0$ gives $C = y_0$, so $y(t) = y_0 e^(2t)$.
      + Setting $y(t_0) = y_0$ gives $C e^(2 t_0) = y_0$, so $C = y_0 e^(-2 t_0)$ and $y(t) = y_0 e^(2(t - t_0))$.
      + No. The argument confuses the set of points in the plane with the set of solutions. Every point $(t_0, y_0)$ does lie on some solution (existence), but that correspondence is many-to-one: a single solution $y(t) = C e^(2t)$ passes through infinitely many points and all of those points pick out the same solution. The solutions themselves form the one-parameter family $y(t) = C e^(2t)$, $C in RR$, so the solution set is one dimensional, not two. (Fixing $t_0 = 0$, the solutions are in bijection with the single value $y_0 in RR$.)
    ],
  ),
  (
    statement: [
      Let $S$ be the set of all solutions to
      $ arrow(r)'(t)= mat(1, 0; 0, 2) arrow(r)(t). $

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
      + The system decouples as $r_1 ' = r_1$ and $r_2 ' = 2 r_2$. Two solutions are $arrow(r)_a (t) = mat(1; 0) e^t$ and $arrow(r)_b (t) = mat(0; 1) e^(2t)$; each satisfies the system (e.g. $arrow(r)_b ' = 2 mat(0; 1) e^(2t) = mat(1, 0; 0, 2) arrow(r)_b$), and they are linearly independent (if $c_1 mat(1; 0) e^t + c_2 mat(0; 1) e^(2t) = arrow(0)$ for all $t$, both components force $c_1 = c_2 = 0$). Hence $"dim"(S) gt.eq 2$.
      + An initial condition specifies the state at a time, so $I = {(t_0, arrow(r)_0) : t_0 in RR, arrow(r)_0 in RR^2} tilde.equiv RR^3$.
      + By the existence theorem, every initial condition in $I$ yields a solution, defining an onto map $Phi : I -> S$ (onto because each solution has, for instance, an initial condition at $t_0 = 0$). A surjection from a three-dimensional set gives $"dim"(S) lt.eq 3$.
      + Yes. A single solution $arrow(r)(t)$ satisfies the initial condition $(t_0, arrow(r)(t_0))$ at every time $t_0$, so all of the infinitely many points ${(t_0, arrow(r)(t_0)) : t_0 in RR}$ map to that one solution. So $Phi$ is far from injective.
      + Let $U = {(0, arrow(r)_0) : arrow(r)_0 in RR^2} tilde.equiv RR^2$. By existence and uniqueness, each $arrow(r)_0$ determines exactly one solution and every solution arises this way, so $Phi$ restricted to $U$ is a bijection onto $S$.
      + The restricted map $Phi|_U : RR^2 -> S$ is a linear bijection, so $"dim"(S) lt.eq 2$. With part (a), $"dim"(S) = 2$.
      + Yes. The argument is independent of dimension: $n$ linearly independent solutions give $"dim"(S) gt.eq n$, while the bijection between solutions and initial states at a fixed time ($RR^n$) gives $"dim"(S) lt.eq n$. So $"dim"(S) = n$ exactly, and the $n$ solutions found form a basis.
    ],
  ),
  (
    statement: [
      For each system $arrow(r)'(t) = M arrow(r)(t)$ below with the given initial condition:
      #[
        #set enum(numbering: "(i)")
        + Find the unique solution using the eigenvalue method.
        + Determine the stability of the system from its eigenvalues.
      ]
      + $M = mat(-3, 1; 1, -3), quad arrow(r)(0) = mat(2; 0)$
      + $M = mat(0, 1; 2, 1), quad arrow(r)(0) = mat(1; 5)$
      + $M = mat(-1, 1, 0; 0, -2, 2; 0, 0, -3), quad arrow(r)(0) = mat(3; -3; 1)$
      + $M = mat(-1, 1; 1, -1), quad arrow(r)(0) = mat(3; 1)$
    ],
    solution: [
      Determine the eigenvalues and eigenvectors of $M$ by your favourite way. Part (ii) needs no extra computation as we can determine stability directly from the eigenvalues found in part (i). 
      + The eigenvalues are $lambda = -2, -4$, with eigenvectors $mat(1; 1)$ and $mat(1; -1)$ respectively. The general solution is
          $
            arrow(r)(t) = A mat(1; 1) e^(-2t) + B mat(1; -1) e^(-4t) \ "where" A "and" B "are parameters."
          $
          Applying $arrow(r)(0) = mat(2; 0)$ gives $A mat(1; 1) + B mat(1; -1) = mat(2; 0)$, i.e., $A + B = 2$ and $A - B = 0$, so $A = B = 1$. The unique solution is
          $
            arrow(r)(t) = mat(1; 1) e^(-2t) + mat(1; -1) e^(-4t).
          $
          Both eigenvalues are negative, so the origin is stable and attracting, that is, every solution decays to $arrow(0)$ as $t -> infinity$.

      + The eigenvalues are $lambda = 2, -1$, with eigenvectors $mat(1; 2)$ and $mat(1; -1)$ respectively. The general solution is
          $
            arrow(r)(t) = A mat(1; 2) e^(2t) + B mat(1; -1) e^(-t) \ "where" A "and" B "are parameters."
          $
          Applying $arrow(r)(0) = mat(1; 5)$ gives $A + B = 1$ and $2A - B = 5$, so $A = 2$, $B = -1$. The unique solution is
          $
            arrow(r)(t) = 2 mat(1; 2) e^(2t) - mat(1; -1) e^(-t).
          $
          One eigenvalue is positive and one is negative, so the origin is unstable (a saddle): solutions decay along $mat(1; -1)$ but grow along $mat(1; 2)$.

      + Since $M$ is upper triangular, its eigenvalues are the diagonal entries $lambda = -1, -2, -3$. The corresponding eigenvectors are $mat(1; 0; 0)$, $mat(1; -1; 0)$, and $mat(1; -2; 1)$, so the general solution is
          $
            arrow(r)(t) = A mat(1; 0; 0) e^(-t) + B mat(1; -1; 0) e^(-2t) + C mat(1; -2; 1) e^(-3t)
          $
          where $A$, $B$, and $C$ are parameters. Applying $arrow(r)(0) = mat(3; -3; 1)$ and reading the components bottom-up: the third gives $C = 1$, the second gives $-B - 2C = -3$ so $B = 1$, and the first gives $A + B + C = 3$ so $A = 1$. The unique solution is
          $
            arrow(r)(t) = mat(1; 0; 0) e^(-t) + mat(1; -1; 0) e^(-2t) + mat(1; -2; 1) e^(-3t).
          $
          All three eigenvalues are negative, so the origin is stable and attracting. (The table's criterion extends to $3 times 3$ systems: the origin attracts exactly when every eigenvalue is negative.)

      + The eigenvalues are $lambda = 0, -2$, with eigenvectors $mat(1; 1)$ and $mat(1; -1)$ respectively. Since $e^(0 dot t) = 1$, the general solution is
          $
            arrow(r)(t) = A mat(1; 1) + B mat(1; -1) e^(-2t) \ "where" A "and" B "are parameters."
          $
          Applying $arrow(r)(0) = mat(3; 1)$ gives $A + B = 3$ and $A - B = 1$, so $A = 2$, $B = 1$. The unique solution is
          $
            arrow(r)(t) = 2 mat(1; 1) + mat(1; -1) e^(-2t).
          $
          One eigenvalue is zero and one is negative, so the system is stable but not attracting. As $t -> infinity$ the $e^(-2t)$ term vanishes and the solution approaches $2 mat(1; 1) = mat(2; 2)$. Solutions settle onto this line rather than decaying to the origin.
    ],
  ),
  (
    statement: [
      Given a description of how solutions behave, construct a system $arrow(r)'(t) = M arrow(r)(t)$ whose coefficient matrix produces that behavior. For each part, give a valid $2 times 2$ matrix $M$ (unless stated otherwise) and briefly justify it using its eigenvalues. #emph[Answers are not unique], i.e., your matrices may differ from the ones given in the solution.

      #emph[Hint:] choose eigenvalues with the required signs first; then either use a diagonal matrix with those eigenvalues on the diagonal, or build $M = P D P^(-1)$ from eigenvectors of your choosing when the behavior must occur along specific directions.
      #[
        #set enum(numbering: "(a)")
        + *Stable and attracting:* every solution satisfies $arrow(r)(t) -> arrow(0)$ as $t -> infinity$.
        + *Unstable and repelling:* every nonzero solution satisfies $|arrow(r)(t)| -> infinity$ as $t -> infinity$.
        + *Unstable (saddle):* some solutions approach $arrow(0)$ and others grow without bound.
        + *Stable, non-attracting:* no solution grows without bound, but not every solution approaches $arrow(0)$.
        + *Stable, with every solution converging to the line* $"span"{mat(2; 1)}$ as $t -> infinity$.
        + A $3 times 3$ system that is *stable and attracting.*
      ]
    ],
    solution: [
      The behavior is governed entirely by the signs of the eigenvalues (and, in part (e), by the eigenvectors), so each part reduces to choosing eigenvalues of the right type and realizing them as a matrix. The constructions below are one valid choice each; many others work.
      #[
        #set enum(numbering: "(a)")
        + Need both eigenvalues to be negative. The diagonal matrix
          $
            M = mat(-1, 0; 0, -2)
          $
          has eigenvalues $-1, -2 < 0$, so every solution $A mat(1; 0) e^(-t) + B mat(0; 1) e^(-2t)$ decays to $arrow(0)$, making it stable and attracting.
        + Need both eigenvalues to bepositive. Taking
          $
            M = mat(1, 0; 0, 2)
          $
          gives eigenvalues $1, 2 > 0$, so every nonzero solution grows without bound, making it unstable and repelling.
        + Need eigenvalues to beof opposite sign. Taking
          $
            M = mat(1, 0; 0, -1)
          $
          gives eigenvalues $1, -1$: solutions along $mat(0; 1)$ (eigenvalue $-1$) decay, while those along $mat(1; 0)$ (eigenvalue $1$) grow. This is a saddle and is unstable.
        + Need eigenvalues that are $lt.eq 0$ with at least one equal to $0$ (a zero eigenvalue gives solutions that neither grow nor decay, so the system is stable but not attracting). Taking
          $
            M = mat(0, 0; 0, -1)
          $
          gives eigenvalues $0, -1$: solutions along $mat(1; 0)$ are constant (they do not approach $arrow(0)$), while those along $mat(0; 1)$ decay. Nothing grows, so it is stable but not attracting.
        + We need solutions to converge to the line $"span"{mat(2; 1)}$, so that line must be a line of equilibria, i.e., we assign the eigenvalue $0$ to the eigenvector $mat(2; 1)$, and a negative eigenvalue to a second (independent) eigenvector so the off-line component decays. Take eigenvalues $0$ (for $mat(2; 1)$) and $-1$ (for $mat(0; 1)$), with $P = mat(2, 0; 1, 1)$, $D = mat(0, 0; 0, -1)$:
          $
            M = P D P^(-1) = mat(2, 0; 1, 1) mat(0, 0; 0, -1) mat(1/2, 0; -1/2, 1) = mat(0, 0; 1/2, -1).
          $
          Every solution is $A mat(2; 1) + B mat(0; 1) e^(-t)$; as $t -> infinity$ the $e^(-t)$ term vanishes and the solution approaches $A mat(2; 1)$, a point on $"span"{mat(2; 1)}$.
        + Need all three eigenvalues to benegative. The diagonal matrix
          $
            M = mat(-1, 0, 0; 0, -2, 0; 0, 0, -3)
          $
          has eigenvalues $-1, -2, -3 < 0$, so every solution decays to $arrow(0)$.
        ]
    ],
  ),
  (
    statement: [
      Consider the system $arrow(r)'(t) = M arrow(r)(t)$ with $M = mat(3, -1; 2, 0)$. We will now look at the geometry of the solutions.
      + Find the eigenvalues and eigenvectors of $M$, and write the general solution.
      + A solution that starts on one of the two eigenlines $"span"{arrow(v)_1}$ or $"span"{arrow(v)_2}$ stays on that line for all $t$. Describe the motion of a solution starting on each eigenline.
      + Now consider the solution with $arrow(r)(0) = mat(1; 0)$, which lies on neither eigenline. As $t -> infinity$, the trajectory becomes parallel to one of the eigenvectors. Which one, and why?
      + (Optional.) Sketch the phase portrait: the two eigenlines with arrows showing the direction of motion, together with the trajectory from part (c).
    ],
    solution: [
      + The eigenvalues are $lambda = 2, 1$, with eigenvectors $arrow(v)_1 = mat(1; 1)$ and$arrow(v)_2 = mat(1; 2)$ respectively. The general solution is
          $
            arrow(r)(t) = A mat(1; 1) e^(2t) + B mat(1; 2) e^(t) \ "where" A "and" B "are parameters."
          $
      + Both eigenvalues are positive, so on each eigenline the solution moves away from the origin. On $"span"{mat(1; 1)}$ (set $B = 0$): $arrow(r)(t) = A mat(1; 1) e^(2t)$ races outward along that line at rate $e^(2t)$. On $"span"{mat(1; 2)}$ (set $A = 0$): $arrow(r)(t) = B mat(1; 2) e^(t)$ moves outward along that line at the slower rate $e^(t)$.
      + Applying $arrow(r)(0) = mat(1; 0)$ gives $A + B = 1$ and $A + 2B = 0$, so $A = 2$, $B = -1$, and
          $
            arrow(r)(t) = 2 mat(1; 1) e^(2t) - mat(1; 2) e^(t).
          $
          Factoring out the faster-growing term, $arrow(r)(t) = e^(2t) (2 mat(1; 1) - mat(1; 2) e^(-t))$. As $t -> infinity$ the $e^(-t)$ piece vanishes, so $arrow(r)(t) approx 2 e^(2t) mat(1; 1)$, thus, the trajectory becomes parallel to $arrow(v)_1 = mat(1; 1)$, the eigenvector of the larger (dominant) eigenvalue.
      + The phase portrait is an unstable node. The two dashed lines are the eigenlines, each carrying straight-line solutions. The blue line is the dominant eigendirection $"span"{mat(1; 1)}$ (eigenvalue $lambda = 2$), and the red line is the slower eigendirection $"span"{mat(1; 2)}$ (eigenvalue $lambda = 1$). Because both eigenvalues are positive, every arrow points outward, away from the origin, and solutions on the blue line escape faster ($e^(2t)$) than those on the red line ($e^t$). The solid black curve is the trajectory from part (c), with $arrow(r)(0) = mat(1; 0)$, which lies on neither eigenline. Far from the origin it runs parallel to the blue line, exactly as part (c) predicted. Closer to the origin, the slower $e^t$ term carries relatively more weight, so the curve sets out more along the red direction before bending to align with blue as it grows.
        #v(.5em)
        #{
          let F(x, y) = (3 * x - y, 2 * x)
          let traj = solve_2d_ivp(F, (.1, 0), 30, Delta: .1, method: "rk4")
          let traj_segments = range(traj.len() - 1).map(i =>
            lq.line(traj.at(i), traj.at(i + 1), stroke: (paint: black, thickness: 1.5pt))
          )

          let diag = vector_field(
            F,
            width: 5cm,
            height: 5cm,
            xlim: (-1, 1),
            ylim: (-1, 1),
            spacing: (.15, .15),
            yaxis: (position: 0, tip: tiptoe.stealth, filter: ((v, d) => false)),
            xaxis: (position: 0, tip: tiptoe.stealth, filter: ((v, d) => false)),
            // blue = dominant eigenline span{(1,1)}, lambda = 2
            lq.line((0, 0), (1, 1), stroke: (paint: blue, dash: (4pt, 1pt), thickness: 1.5pt)),
            lq.line((0, 0), (-1, -1), stroke: (paint: blue, dash: (4pt, 1pt), thickness: 1.5pt)),
            // red = slow eigenline span{(1,2)}, lambda = 1
            lq.line((0, 0), (.5, 1), stroke: (paint: red, dash: (4pt, 1pt), thickness: 1.5pt)),
            lq.line((0, 0), (-.5, -1), stroke: (paint: red, dash: (4pt, 1pt), thickness: 1.5pt)),
            ..traj_segments,
          )

          align(center, diag)
        }
    ],
  ),
  (
    statement: [
      (*Bonus*) As we will see in a later chapter, we can rewrite second-order equations as a first-order linear system. Consider the second-order equation $y'' - y' - 6y = 0$.
      + Introduce $r_1 = y$ and $r_2 = y'$. Write the system $arrow(r)' = M arrow(r)$ that this substitution produces, and identify $M$.
      + Find the eigenvalues and eigenvectors of $M$.
      + Write the general solution of the system, then extract the general solution $y(t)$ of the original equation.
      + Verify that the eigenvalues of $M$ are exactly the roots of the characteristic equation $lambda^2 - lambda - 6 = 0$ of the original ODE.
    ],
    solution: [
      + With $r_1 = y$ and $r_2 = y'$, we have $r_1 ' = y' = r_2$ and $r_2 ' = y'' = y' + 6 y = 6 r_1 + r_2$. In matrix form,
          $
            arrow(r)' = mat(0, 1; 6, 1) arrow(r), quad "so" quad M = mat(0, 1; 6, 1).
          $
      + Solving by your favourite method, the eigenvalues are $lambda = 3, -2$, with eigenvectors $mat(1; 3)$ and $mat(1; -2)$ respectively.
      + The general solution of the system is
          $
            arrow(r)(t) = A mat(1; 3) e^(3t) + B mat(1; -2) e^(-2t) \ "where" A "and" B "are parameters."
          $
          The original unknown is $y = r_1$, the first component, so
          $
            y(t) = A e^(3t) + B e^(-2t).
          $
      + Substituting $y = e^(lambda t)$ into $y'' - y' - 6 y = 0$ gives $(lambda^2 - lambda - 6) e^(lambda t) = 0$, so the scalar characteristic equation is $lambda^2 - lambda - 6 = 0$, which is identical to $det(M - lambda I) = 0$ (the characteristic equation of $M$).
    ],
  ),
)