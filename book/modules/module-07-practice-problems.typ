#import "../libs/lib.typ": *

#let questions = (
  (
    statement: [
      Consider the affine system
      $
        arrow(r)' = mat(0, 1; 1, 0) arrow(r) + mat(-3; -1).
      $
      + Verify that $arrow(s)(t) = e^(t) mat(1; 1) + mat(1; 3)$ is a solution.
      + Is $arrow(u)(t) = e^(t) mat(1; 1)$ also a solution to the affine system? Justify your answer.
    ],
    solution: [
      + Differentiating gives $arrow(s)'(t) = e^(t) mat(1; 1)$. On the other hand,
        $
          mat(0, 1; 1, 0) arrow(s)(t) + mat(-3; -1)
            &= mat(0, 1; 1, 0) mat(e^(t) + 1; e^(t) + 3) + mat(-3; -1) \
            &= mat(e^(t) + 3; e^(t) + 1) + mat(-3; -1) = e^(t) mat(1; 1).
        $
        The two sides agree, so $arrow(s)$ is a solution.
      + No. The vector $arrow(u)$ solves the matrix equation $arrow(r)' = mat(0, 1; 1, 0) arrow(r)$, but the affine system would require
        $arrow(u)' = mat(0, 1; 1, 0) arrow(u) + mat(-3; -1)$. Here $arrow(u)' = e^(t) mat(1; 1)$, while
        $ \ mat(0, 1; 1, 0) arrow(u) + mat(-3; -1) = e^(t) mat(1; 1) + mat(-3; -1)$. The two differ by $mat(-3; -1) != arrow(0)$, so $arrow(u)$ is not a solution.
    ],
  ),
  (
    statement: [
      Suppose $arrow(v)(t)$ is a solution to the affine equation
      $
        arrow(v)' = M arrow(v) + arrow(b), wide "where" wide
        M = mat(2, 1; 1, 2), quad arrow(b) = mat(3; 0).
      $
      We will use $arrow(v)$ to build a solution of the matrix equation $arrow(r)' = M arrow(r)$, looking for one of the form
      $arrow(s)(t) = arrow(v)(t) + arrow(p)$ where $arrow(p)$ is a constant vector to be determined.
      + Using the fact that $arrow(v)$ solves the affine equation, write $arrow(s)'(t)$ in terms of $M$, $arrow(v)(t)$, and $arrow(b)$.
      + Compute $M arrow(s)(t)$ in terms of $M$, $arrow(v)(t)$, and $arrow(p)$.
      + We want $arrow(s)' = M arrow(s)$. Using the previous two parts, find the equation that $arrow(p)$ must satisfy.
      + Solve that equation for $arrow(p)$, and write down the solution $arrow(s)(t)$.
      + (Optional.) The theorem _Centering about the Equilibrium_ is stated using the equilibrium point of the affine equation. Find the equilibrium point $arrow(p)_("eq")$ here, and check that $arrow(v) - arrow(p)_("eq")$ matches the $arrow(s)$ you found.
    ],
    solution: [
      + Since $arrow(p)$ is constant, $arrow(p)' = arrow(0)$, so
        $
          arrow(s)'(t) = arrow(v)'(t) + arrow(p)' = arrow(v)'(t) = M arrow(v)(t) + arrow(b).
        $
      + Distributing $M$,
        $
          M arrow(s)(t) = M (arrow(v)(t) + arrow(p)) = M arrow(v)(t) + M arrow(p).
        $
      + Setting $arrow(s)' = M arrow(s)$,
        $
          M arrow(v)(t) + arrow(b) = M arrow(v)(t) + M arrow(p)
          quad ==> quad M arrow(p) = arrow(b).
        $
      + Since $det M = 3$, we have $\ M^(-1) = 1/3 mat(2, -1; -1, 2)$, so
        $
          arrow(p) = M^(-1) arrow(b) = 1/3 mat(2, -1; -1, 2) mat(3; 0) = mat(2; -1),
        $
        giving $arrow(s)(t) = arrow(v)(t) + mat(2; -1)$.
      + The equilibrium satisfies $M arrow(p)_("eq") + arrow(b) = arrow(0)$, so
        $arrow(p)_("eq") = -M^(-1) arrow(b) = mat(-2; 1)$. Then
        $arrow(v) - arrow(p)_("eq") = arrow(v) + mat(2; -1) = arrow(s)$, matching the theorem.
      ],
  ),
  (
    statement: [
      Find the solution $arrow(s)(t) = arrow(v)(t) + arrow(p)$ where $arrow(p)$ is a constant vector, and $arrow(v)(t)$ is a solution to the affine equation $arrow(v)'(t) = M arrow(v)(t) + arrow(b)$. Then find the equilibrium point $arrow(p)_("eq")$ of the affine equation, and describe how it compares to $arrow(p)$:
      #grid(
        columns: (auto, 1fr),
        gutter: 1em,

        [(a)], [$M = mat(2, 0; 0, 5), quad arrow(b) = mat(6; -10)$],
        [(b)], [$M = mat(1, 1; 0, 2), quad arrow(b) = mat(3; 4)$],
        [(c)], [$M = mat(2, 1; 1, 1), quad arrow(b) = mat(0; 3)$],
        [(d)], [$M = mat(3, 1; 2, 1), quad arrow(b) = mat(4; 1)$],
      )
    ],
    solution: [
      In each case $arrow(p) = M^(-1) arrow(b)$ and $arrow(s)(t) = arrow(v)(t) + arrow(p)$. Further, for a 2x2 matrix with a non-zero determinant, $M^(-1) = 1/(det M)mat(d, -b; -c, a)$ where $a$, $b$, $c$, and $d$ are the entries of $M$.
      + $M^(-1) = mat(1/2, 0; 0, 1/5)$, so $arrow(p) = mat(3; -2)$ and $arrow(s)(t) = arrow(v)(t) + mat(3; -2)$.
      + $det M = 2$, so $M^(-1) = 1/2 mat(2, -1; 0, 1)$, giving $arrow(p) = mat(1; 2)$ and $arrow(s)(t) = arrow(v)(t) + mat(1; 2)$.
      + $det M = 1$, so $M^(-1) = mat(1, -1; -1, 2)$, giving $arrow(p) = mat(-3; 6)$ and $arrow(s)(t) = arrow(v)(t) + mat(-3; 6)$.
      + $det M = 1$, so $M^(-1) = mat(1, -1; -2, 3)$, giving $arrow(p) = mat(3; -5)$ and $arrow(s)(t) = arrow(v)(t) + mat(3; -5)$.

      The equilibrium point satisfies $arrow(v)'(t) = arrow(0)$, i.e. $M arrow(p)_("eq") = -arrow(b)$, so $arrow(p)_("eq") = -M^(-1) arrow(b) = -arrow(p)$ in every case: \ (a) $mat(-3; 2)$, (b) $mat(-1; -2)$, (c) $mat(3; -6)$, (d) $mat(-3; 5)$.\ In other words, the constant shift $arrow(p)$ that turns a matrix-equation solution into an affine solution is exactly the negative of the affine equilibrium.
    ],
  ),
  (
    statement: [
      For each affine system $arrow(r)'(t) = M arrow(r)(t) + arrow(b)$ below, find the general solution $arrow(s)(t)$ by working through the following steps:
      + Find the equilibrium point $arrow(p)_("eq")$ by solving $arrow(r)'(t) = arrow(0)$.
      + Find the general solution $arrow(u)(t)$ of the associated matrix equation $arrow(r)'(t) = M arrow(r)(t)$ using its eigenvalues and eigenvectors. 
      + Form $arrow(s)(t) = arrow(u)(t) + arrow(p)_("eq")$.
      + Verify both ways that $arrow(s)(t)$ really is a solution of the affine system.
      #grid(
        columns: (auto, 1fr),
        gutter: 1em,

        [(i)], [$M = mat(0, 1; 1, 0), quad arrow(b) = mat(2; -2)$],
        [(ii)], [$M = mat(1, 2; 0, 3), quad arrow(b) = mat(-2; -3)$],
        [(iii)], [$M = mat(8, 3; 1, 2), quad arrow(b) = mat(2; 1)$],
        [(iv)], [$M = mat(-2, 1; 1, -2), quad arrow(b) = mat(0; 3)$],
      )
    ],
    solution: [
      The same pattern works for every system. We show (i) in full and report the rest.

    *(i)* Equilibrium: $M arrow(p)_("eq") = -arrow(b) = mat(-2; 2)$ gives $arrow(p)_("eq") = mat(2; -2)$. The matrix has eigenvalues $lambda = 1, -1$ with eigenvectors $mat(1; 1)$ and $mat(1; -1)$, so
      $
        arrow(u)(t) = A e^(t) mat(1; 1) + B e^(-t) mat(1; -1) \ "where" A "and" B "are parameters,"
      $
      and therefore
      $
        arrow(s)(t) = A e^(t) mat(1; 1) + B e^(-t) mat(1; -1) + mat(2; -2)  \ "where" A "and" B "are parameters."
      $
      Checking: $arrow(s)'(t) = A e^(t) mat(1; 1) - B e^(-t) mat(1; -1)$, while
      $
        M arrow(s)(t) + arrow(b) &= M arrow(u)(t) + M mat(2; -2) + mat(2; -2) \
      $
      $
        &= A e^(t) mat(1; 1) - B e^(-t) mat(1; -1) 
        + mat(-2; 2) + mat(2; -2) \
        &= A e^(t) mat(1; 1) - B e^(-t) mat(1; -1).
      $
      The two agree, so $arrow(s)$ is a solution.

    *(ii)* $arrow(p)_("eq") = mat(0; 1)$. Eigenvalues $lambda = 1, 3$ with eigenvectors $mat(1; 0)$ and $mat(1; 1)$, so
      $
        arrow(s)(t) = A e^(t) mat(1; 0) + B e^(3t) mat(1; 1) + mat(0; 1) \ "where" A "and" B "are parameters."
      $

    *(iii)* $arrow(p)_("eq") = -1/13 mat(1; 6)$. Eigenvalues $lambda = 5 plus.minus 2 sqrt(3) $ with eigenvectors $mat(3 + 2 sqrt(3); 1)$ and $mat(3 - 2 sqrt(3); 1)$, so
      $
        arrow(s)(t) = A e^((5+2 sqrt(3)) t) mat(3 + 2 sqrt(3); 1) + \ B e^((5 - 2 sqrt(3)) t) mat(3 - 2 sqrt(3); 1) -1/13 mat(1; 6) \ "where" A "and" B "are parameters."
      $

    *(iv)* $arrow(p)_("eq") = mat(1; 2)$. Eigenvalues $lambda = -1, -3$ with eigenvectors $mat(1; 1)$ and $mat(-1; 1)$, so
    $
      arrow(s)(t) = A e^(-t) mat(1; 1) + B e^(-3t) mat(-1; 1) + mat(1; 2) \ "where" A "and" B "are parameters."
    $

    ],
  ),
  (
    statement: [
      Each expression below is the general solution $arrow(s)(t)$ of some affine system $arrow(r)'(t) = M arrow(r)(t) + arrow(b)$, where $A$ and $B$ are parameters. For each one, recover the matrix $M$ and the vector $arrow(b)$ by working through the following steps:
      + Rreconstruct $M$. (Recall $M = P D P^(-1)$, where the columns of $P$ are the eigenvectors and $D$ is the diagonal matrix of the corresponding eigenvalues.)
      + From the constant term, identify the equilibrium point $arrow(p)_("eq")$, and use it to find $arrow(b)$ via $M arrow(p)_("eq") + arrow(b) = arrow(0)$.

      #grid(
        columns: (auto, 1fr),
        gutter: 1em,

        [(i)], [$ arrow(s)(t) = A e^(2t) mat(1; 0) + B e^(-t) mat(0; 1) + mat(3; 1) $],
        [(ii)], [$ arrow(s)(t) = A e^(3t) mat(1; 1) + B e^(t) mat(1; -1) + mat(0; 2) $],
        [(iii)], [$ arrow(s)(t) = A e^(-2t) mat(1; 0) + B e^(t) mat(1; 1) + mat(1; -1) $],
        [(iv)], [$ arrow(s)(t) = A e^(t) mat(2; 1) + B e^(-t) mat(1; 1) + mat(-1; 1) $],
      )
    ],
    solution: [
      The exponential part of the solution determines $M$: the coefficient in each exponent is an eigenvalue, and the vector it multiplies is the corresponding eigenvector. Two independent eigenpairs fix $M$ completely (so the recovered system is unique). The constant term is the equilibrium $arrow(p)_("eq")$, and $arrow(b) = -M arrow(p)_("eq")$. We show (i) and (iv) in full and report the rest.

      *(i)* The eigenpairs are $(2, mat(1; 0))$ and $(-1, mat(0; 1))$. Since the eigenvectors are the standard basis, $M$ is simply diagonal:
      $
        M = mat(2, 0; 0, -1).
      $
      The constant term gives $arrow(p)_("eq") = mat(3; 1)$, so
      $
        arrow(b) = -M arrow(p)_("eq") = -mat(6; -1) = mat(-6; 1),
      $
      and the system is $arrow(r)'(t) = mat(2, 0; 0, -1) arrow(r)(t) + mat(-6; 1)$.

      *(ii)* $M = mat(2, 1; 1, 2)$ (eigenpairs $(3, mat(1; 1))$ and $(1, mat(1; -1))$), with $arrow(p)_("eq") = mat(0; 2)$, so $arrow(b) = mat(-2; -4)$.

      *(iii)* $M = mat(-2, 3; 0, 1)$ (eigenpairs $(-2, mat(1; 0))$ and $(1, mat(1; 1))$), with $arrow(p)_("eq") = mat(1; -1)$, so $arrow(b) = mat(5; 1)$.

      *(iv)* $M = mat(3, -4; 2, -3)$ (eigenpairs $(1, mat(2; 1))$ and $(-1, mat(1; 1))$), with $arrow(p)_("eq") = mat(-1; 1)$, so $arrow(b) = mat(7; 5).$
    ],
  ),
  (
    statement: [
      For each affine system $arrow(r)'(t) = M arrow(r)(t) + arrow(b)$ below with the given initial condition, find the *specific* solution by working through the following steps:
      + Find the equilibrium point $arrow(p)_("eq")$ and the general solution $arrow(u)(t)$ of the matrix equation $arrow(r)'(t) = M arrow(r)(t)$, then form the general affine solution $arrow(s)(t) = arrow(u)(t) + arrow(p)_("eq")$.
      + Apply the initial condition by setting $t = 0$. Note that this gives $A arrow(v)_1 + B arrow(v)_2 = arrow(r)(0) - arrow(p)_("eq")$.

      #grid(
        columns: (auto, 1fr),
        gutter: 1em,

        [(i)], [$ M = mat(0, 1; 1, 0), quad arrow(b) = mat(2; -2), quad arrow(r)(0) = mat(4; 2) $],
        [(ii)], [$ M = mat(1, 2; 0, 3), quad arrow(b) = mat(-2; -3), quad arrow(r)(0) = mat(4; 2) $],
        [(iii)], [$ M = mat(-2, 1; 1, -2), quad arrow(b) = mat(0; 3), quad arrow(r)(0) = mat(2; 5) $],
        [(iv)], [$ M = mat(2, 3; 0, -1), quad arrow(b) = mat(2; 1), quad arrow(r)(0) = mat(1; 0) $],
      )
    ],
    solution: [
      In each case the general solution is $arrow(s)(t) = arrow(u)(t) + arrow(p)_("eq")$; the initial condition then fixes $A$ and $B$ via $A arrow(v)_1 + B arrow(v)_2 = arrow(r)(0) - arrow(p)_("eq")$. We show (i) and (iv) in full and report the rest.

      *(i)* See the previous problem for the equilibrium and general solution.
      Setting $t = 0$: $A mat(1; 1) + B mat(1; -1) = arrow(r)(0) - arrow(p)_("eq") = mat(4; 2) - mat(2; -2) = mat(2; 4)$, i.e. $A + B = 2$ and $A - B = 4$, giving $A = 3$, $B = -1$. Therefore
      $
        arrow(s)(t) = 3 e^(t) mat(1; 1) - e^(-t) mat(1; -1) + mat(2; -2).
      $

      *(ii)* $arrow(p)_("eq") = mat(0; 1)$, eigenpairs $(1, mat(1; 0))$ and $(3, mat(1; 1))$. The condition $A mat(1; 0) + B mat(1; 1) = mat(4; 2) - mat(0; 1) = mat(4; 1)$ gives $B = 1$, $A = 3$, so
      $
        arrow(s)(t) = 3 e^(t) mat(1; 0) + e^(3t) mat(1; 1) + mat(0; 1).
      $

      *(iii)* $arrow(p)_("eq") = mat(1; 2)$, eigenpairs $(-1, mat(1; 1))$ and $(-3, mat(-1; 1))$. The condition $A mat(1; 1) + B mat(-1; 1) = mat(2; 5) - mat(1; 2) = mat(1; 3)$ gives $A = 2$, $B = 1$, so
      $
        arrow(s)(t) = 2 e^(-t) mat(1; 1) + e^(-3t) mat(-1; 1) + mat(1; 2).
      $

      *(iv)* The matrix is upper-triangular, so the eigenvalues are $lambda = 2, -1$ with eigenvectors $mat(1; 0)$ and $mat(-1; 1)$. For the equilibrium, $M arrow(p)_("eq") = -arrow(b) = mat(-2; -1)$. Thus $arrow(p)_("eq") = mat(-5/2; 1)$ and
      $
        arrow(s)(t) = A e^(2t) mat(1; 0) + B e^(-t) mat(-1; 1) + mat(-5/2; 1) \ "where" A "and" B "are parameters."
      $
      Setting $t = 0$:
      $
        A mat(1; 0) + B mat(-1; 1) = mat(1; 0) - mat(-5/2; 1) = mat(7/2; -1).
      $
      The second component gives $B = -1$; the first gives $A - B = 7/2$, so $A = 5/2$. Therefore
      $
        arrow(s)(t) = 5/2 e^(2t) mat(1; 0) - e^(-t) mat(-1; 1) + mat(-5/2; 1).
      $
    ],
  ),
  (
    statement: [
      *(Equilibria: existence and uniqueness.)* The equilibrium point $arrow(p)_("eq")$ of the affine system $arrow(r)'(t) = M arrow(r)(t) + arrow(b)$ is a constant solution, i.e. one for which $arrow(r)'(t) = arrow(0)$.
      + Show that finding $arrow(p)_("eq")$ amounts to solving the linear system $M arrow(p)_("eq") = -arrow(b)$.
      + Under what condition on $M$ does the system have exactly one equilibrium? Express $arrow(p)_("eq")$ in that case.
      + Find a $2 times 2$ matrix $M$ and vector $arrow(b)$ for which the system has no equilibrium, and another pair for which it has infinitely many.
    ],
    solution: [
      + A constant solution has $arrow(r)'(t) = arrow(0)$. Substituting into the equation gives $arrow(0) = M arrow(p)_("eq") + arrow(b)$, i.e. $M arrow(p)_("eq") = -arrow(b)$.
      + The linear system has a unique solution exactly when $M$ is invertible ($det M != 0$), equivalently when $0$ is not an eigenvalue of $M$. Then $arrow(p)_("eq") = -M^(-1) arrow(b)$.
      + Take $M = mat(1, 1; 1, 1)$, whose column space is all multiples of $mat(1; 1)$. With $arrow(b) = mat(1; 0)$, the system $M arrow(p)_("eq") = mat(-1; 0)$ has no solution (the right side is not a multiple of $mat(1; 1)$), so there is no equilibrium. With $arrow(b) = mat(1; 1)$, the system $M arrow(p)_("eq") = mat(-1; -1)$ is solved by every point on the line $p_1 + p_2 = -1$, so there are infinitely many equilibria.
    ],
  ),
  (
    statement: [
      *(The shape of the solution set.)* Suppose $arrow(s)_1(t)$ and $arrow(s)_2(t)$ are both solutions of the same affine system $arrow(r)'(t) = M arrow(r)(t) + arrow(b)$.
      + Show that their difference $arrow(w)(t) = arrow(s)_1(t) - arrow(s)_2(t)$ is a solution of the matrix equation $arrow(r)'(t) = M arrow(r)(t)$.
      + Explain why this means that once you know a single particular solution of the affine system, every solution is that particular one plus a solution of the matrix equation.
    ],
    solution: [
      + Differentiating and using that both solve the affine system,
        $
          arrow(w)'(t) &= arrow(s)_1 '(t) - arrow(s)_2 '(t) 
          \ &= (M arrow(s)_1 + arrow(b)) - (M arrow(s)_2 + arrow(b)) \
           &= M(arrow(s)_1 - arrow(s)_2) = M arrow(w)(t),
        $
        so $arrow(w)$ solves the matrix equation.
    ],
  ),
  (
    statement: [
      *(Stability depends on $M$, not $arrow(b)$.)* Consider two affine systems with the same matrix $M$ but different constants, $arrow(r)'(t) = M arrow(r)(t) + arrow(b)_1$ and $arrow(r)'(t) = M arrow(r)(t) + arrow(b)_2$, each with a unique equilibrium.
      + Suppose every eigenvalue of $M$ is negative. Describe what happens to the solutions of each system as $t -> infinity$.
      + Does replacing $arrow(b)_1$ by $arrow(b)_2$ change whether solutions converge? What does it change?
      + Argue in general that whether the equilibrium attracts or repels nearby solutions is determined by $M$ alone.
    ],
    solution: [
      + Each solution is $arrow(s)(t) = arrow(u)(t) + arrow(p)_("eq")$. With all eigenvalues negative, every term of $arrow(u)(t)$ is a decaying exponential, so $arrow(u)(t) -> arrow(0)$ and $arrow(s)(t) -> arrow(p)_("eq")$. Every solution converges to its equilibrium.
      + No. Changing $arrow(b)$ moves the location of the equilibrium that solutions head toward, but not whether they head toward it. Convergence is governed by $arrow(u)(t)$, which depends only on $M$.
      + For any solution, $arrow(s)(t) - arrow(p)_("eq") = arrow(u)(t)$ solves the matrix equation, and its growth or decay is set by the signs of the eigenvalues of $M$ (their real parts, more generally). The vector $arrow(b)$ enters only through $arrow(p)_("eq")$, which relocates the center without touching the dynamics. So stability is a property of $M$.
    ],
  ),
  (
    statement: [
      *(When centering fails.)* Centering relies on the equilibrium $arrow(p)_("eq") = -M^(-1) arrow(b)$, which requires $M$ to be invertible. Suppose instead that $0$ is an eigenvalue of $M$.
      + Explain why there is no longer a guaranteed unique equilibrium, and identify the two qualitatively different cases that can occur.
      + Let $M = mat(1, 1; 1, 1)$. Show there is no equilibrium, then describe what solutions do along the $lambda = 0$ direction.
    ],
    solution: [
      + The equilibrium must satisfy $M arrow(p)_("eq") = -arrow(b)$. When $M$ is singular this system has either no solution (if $-arrow(b)$ is not in the column space of $M$) or infinitely many (a whole line of equilibria). In neither case is there a single isolated point to center about.
      + The column space of $M$ is the multiples of $mat(1; 1)$, and $-arrow(b) = mat(-1; 1)$ \ is not among them, so $M arrow(p)_("eq") = mat(-1; 1)$ has no solution: no equilibrium exists. Writing a solution in the eigenbasis, $arrow(r)(t) = alpha(t) mat(1; 1) + beta(t) mat(1; -1)$, the matrix equation decouples as $alpha' = 2 alpha$ and $beta' = 0$, while the forcing $arrow(b) = mat(1; -1)$ lies entirely along the $lambda = 0$ direction, contributing $beta' = 1$. Hence $beta(t) = beta_0 + t$.
    ],
  ),
  (
    statement: [
      *(Proof: Centering about the Equilibrium.)* Let $M$ be an invertible matrix, $arrow(b)$ a vector, and $arrow(p)$ the equilibrium of the affine equation $arrow(r)'(t) = M arrow(r)(t) + arrow(b)$, so that $M arrow(p) + arrow(b) = arrow(0)$. Prove both halves of the theorem:
      + If $arrow(v)(t)$ is a solution of the affine equation, then $arrow(s)(t) = arrow(v)(t) - arrow(p)$ is a solution of the matrix equation $arrow(r)'(t) = M arrow(r)(t)$.
      + If $arrow(u)(t)$ is a solution of the matrix equation, then $arrow(q)(t) = arrow(u)(t) + arrow(p)$ is a solution of the affine equation.
    ],
    solution: [
      Throughout, $arrow(p)$ is constant, so $arrow(p)' = arrow(0)$, and by definition $M arrow(p) = -arrow(b)$.
      + Suppose $arrow(v)' = M arrow(v) + arrow(b)$, and set $arrow(s) = arrow(v) - arrow(p)$. Then
        $
          arrow(s)'(t) = arrow(v)'(t) - arrow(p)' = arrow(v)'(t) = M arrow(v)(t) + arrow(b),
        $
        while
        $
          M arrow(s)(t) &= M(arrow(v)(t) - arrow(p)) 
          \ &= M arrow(v)(t) - M arrow(p) = M arrow(v)(t) + arrow(b).
        $
        The two expressions agree, so $arrow(s)'(t) = M arrow(s)(t)$: $arrow(s)$ solves the matrix equation.
      + Suppose $arrow(u)' = M arrow(u)$, and set $arrow(q) = arrow(u) + arrow(p)$. Then $arrow(q)'(t) = arrow(u)'(t) = M arrow(u)(t)$, while
        $
          M arrow(q)(t) + arrow(b) &= M(arrow(u)(t) + arrow(p)) + arrow(b) \ &= M arrow(u)(t) + (M arrow(p) + arrow(b)) = M arrow(u)(t).
        $
        Again the two agree, so $arrow(q)'(t) = M arrow(q)(t) + arrow(b)$: $arrow(q)$ solves the affine equation. #h(1fr) $qed$
    ],
  ),

)

