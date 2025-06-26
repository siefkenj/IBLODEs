
// This file is meant to be imported and not compiled on its own.
#import "../common/settings-book.typ": workbook, show_def
#import "../libs/_workbook.typ": simple_table, label_module
#let (sans, serif, module, definition, example, theorem) = workbook

#label_module(<mod:real>)

In this module you will learn:
- How to find explicit solutions to systems of differential equations with constant coefficients by using the eigenvalues and eigenvectors of the coefficient matrix.
- How the real, distinct eigenvalues of a system of differential equations with constant coefficients are related to the stability of the equilibrium solutions.





// + Matrix from of the system
// + Diagonal matrix $arrow.double$ solution
// + linear combination of solutions $arrow.double$ solution
// + Definition of linear (in)dependence of solutions
// + Only need basis of solutions
// + Idea of eigen solutions
// + What is the dimension of the solution space?
//   - Theorem (Existence & Uniqueness 1) ...
// + Solve systems with real eigenvalues



== Linear Algebra Pre-requisites

Starting with this module, we will be using several results from linear algebra. We will assume that you are familiar with the following:
- Vector spaces and subspaces.
- Linear transformations and their null space/kernel and range/image.
- Linear independence of vectors.
- Span, basis, and dimension of a vector space/subspace.
- Eigenvalues and eigenvectors of a matrix and how to compute them.

You will find a review of these topics in @app:linear_algebra.


== Finding Explicit Solutions

For equations like $y'=7 y$, we were lucky enough to guess-and-check our way to solutions $y(t)=A e^(7 t)$ where $A in RR$ is a parameter.
It turns out, by using some insights from linear algebra, we will be able to guess-and-check our way to solutions to some systems of
differential equations as well.

=== Matrix Form

Consider the system
$
  x' &= 2 x + y \
  y' &= x + 2 y
$
We can rewrite this system as a matrix equation:
$
  mat(x'; y') = mat(2, 1; 1, 2) mat(x; y)
$

We can further refine our matrix equation by introducing a function $arrow(r)(t)=mat(x(t); y(t))$. Since the derivative
of a multivariable function is the derivative of each of its components, $arrow(r)'(t)=mat(x'(t); y'(t))$, and so
the system can be rewritten as
$
  arrow(r)' = mat(2, 1; 1, 2) arrow(r).
$

Differential equations written in this way are said to be expressed in _matrix form_.

#show_def("matrix_form")

=== Eigenvectors and Guessing Solutions

The equation $arrow(r)'=mat(2, 1; 1, 2) arrow(r)$ looks a lot like our previous equation $y' = k y$, so we might
get lucky and be able to guess a solution!

Let's start by guessing a solution of the form
$
  arrow(r)(t) = mat(A; B)e^(k t) = mat(A e^(k t); B e^(k t)),
$
where $A,B, k in RR$ are parameters.
This implies
$
  arrow(r)'(t) = mat(k A e^(k t); k B e^(k t)) = k mat(A e^(k t); B e^(k t)) = k space.thin arrow(r)(t).
$
From the original differential equation, we know $arrow(r)'=mat(2, 1; 1, 2)arrow(r)$. Combining this with our previous computation
gives us
$
  arrow(r)' = mat(2, 1; 1, 2) arrow(r) = k space.thin arrow(r).
$
In other words, $arrow(r)$ must be an eigenvector of $mat(2, 1; 1, 2)$ with eigenvalue $k$!

Computing, we see the eigenvectors of $mat(2, 1; 1, 2)$ are
$
  arrow(v_1) = mat(1; 1) " with eigenvalue " 3 wide "and" wide arrow(v_2) = mat(1; -1) " with eigenvalue " 1.
$
Thus we guess solutions
$
  arrow(r_1)(t) = mat(1; 1) e^(3 t) = mat(e^(3 t); e^(3 t)) wide "and" wide arrow(r_2)(t) = mat(1; -1) e^(t) = mat(e^(t); -e^(t)).
$

Verifying, we see that both $arrow(r_1)$ and $arrow(r_2)$ are solutions!


=== The Subspace of Solutions

Recall the system of differential equations
$
  x' = 2 x + y \
  y' = x + 2 y
$
expressed in matrix form as
$
  arrow(r)' = mat(2, 1; 1, 2) arrow(r)
$
where $arrow(r)(t) = mat(x(t); y(t))$. By guessing and checking, we found two solutions
$
  arrow(r_1)(t) = e^(3 t) mat(1; 1) wide "and" wide
  arrow(r_2)(t) = e^(-t) mat(1; -1),
$
but are there others?

In the case of the single-variable equation $y'=7y$, we noticed that multiplying a solution by a constant gave another solution. Will the same work in this case? Let's try.

#example(
  prompt: [Decide whether $alpha space.thin arrow(r)_1$ and $beta space.thin arrow(r)_2$ are solutions, where $alpha, beta in RR$ are constants.],
  [
    We can test if something is a solution to a differential equation by plugging it in.
    On the one hand, we have
    $
      (alpha space.thin arrow(r)_1(t))' = alpha space.thin arrow(r)'_1(t) = alpha space.thin 3 space.thin arrow(r)_1(t) .
    $
    On the other hand, we have
    $
      mat(2, 1; 1, 2) (alpha space.thin arrow(r)_1(t)) = alpha mat(2, 1; 1, 2) arrow(r)_1(t) = alpha space.thin 3 space.thin arrow(r)_1(t),
    $
    and so $(alpha space.thin arrow(r)_1(t)) = mat(2, 1; 1, 2) (alpha space.thin arrow(r)_1(t))$, showing that $alpha space.thin arrow(r)_1(t)$ is a solution
    no matter the value of $alpha$.
    A similar computation shows that $beta space.thin arrow(r)_2(t)$ is a solution for any value of $beta$.
  ],
)

The preceding example can be generalized to show that if you have a solution to a matrix differential equation, then all
scalar multiples of that solution are also solutions. This is in turn a special case of a more general theorem.

#theorem(
  title: [Solutions Form a Subspace],
  [
    Let $arrow(r)'=M arrow(r)$ be a matrix differential equation and let $cal(S)$ be the set of all solutions. Then, $cal(S)$
    is a subspace. In particular, $cal(S)$ is closed under linear combinations.
  ],
)

_Proof:_ Suppose that $cal(S)$ is the set of all solutions to $arrow(r)'=M arrow(r)$ (where $M$ is a square matrix). First, notice that
$
  arrow(0)' = arrow(0) = M arrow(0),
$
so $arrow(0) in cal(S)$. Next, suppose that $arrow(s)_1$ and $arrow(s)_2$ are solutions in $cal(S)$.
By definition, that means $arrow(s)'_1 = M arrow(s)_1$ and $arrow(s)'_2 = M arrow(s)_2$.
By the linearity of the derivative, we may now compute
$
  (alpha space.thin arrow(s)_1 + beta space.thin arrow(s)_2)' &= alpha space.thin arrow(s)'_1 + beta space.thin arrow(s)'_2 \
  &= alpha space.thin M arrow(s)_1 + beta space.thin M arrow(s)_2 \
  &= M (alpha space.thin arrow(s)_1 + beta space.thin arrow(s)_2),
$
and so $alpha space.thin arrow(s)_1 + beta space.thin arrow(s)_2$ is also a solution in $cal(S)$. #align(right, sym.square.filled)

#v(1em)

Given the above theorem, we can find all sorts of solutions to $arrow(r)'(t) = mat(2, 1; 1, 2) arrow(r)(t)$, like
$
  arrow(r)_1(t) + 4 space.thin arrow(r)_2(t) = mat(e^(3 t) + 4space.thin e^(t); e^(3 t) - 4space.thin e^(t)) wide "or" wide
  -2 space.thin arrow(r)_1(t) + 3 space.thin arrow(r)_2(t) = mat(-2space.thin e^(3 t) + 3space.thin e^(t); -2space.thin e^(3 t) - 3space.thin e^(t)).
$

But, have we found all the solutions? To answer that question we need to dive deeper into the linear algebra of the solution space.

== Linear Algebra of the Solution Space

You're familiar with the vector spaces $RR^n$, but the set of all function from $RR$ to $RR^n$, denoted $cal(F)^n$, also forms a vector space.
To quickly check, notice that the constant function $z(t)=0$ acts like the "zero vector", and
if $f:RR arrow RR$ and $g:RR arrow RR$ are functions, then so is $alpha dot f + beta dot g$.#footnote(
  [
    To fully check, you must check that all the _vector space_ axioms hold.
  ],
)

The space $cal(F)^n$ is _large_. In fact, it is _infinite dimensional_, but the theorems of linear algebra still apply (provided the proper definitions).

#show_def("linear_dependence_solutions")

#example(
  prompt: [Let $f(x)=x^2$, $g(x)=x$, and $h(x)=2x^2-x$. Show that ${f,g} subset.eq cal(F)^1$ is linearly independent but ${f,g,h} subset.eq cal(F)^1$ is linearly dependent],
  [
    Consider the set ${f,g}$. We can attempt to solve the equation
    $
      alpha f(x) + beta g(x) = 0
    $
    Expanding, we see
    $
      alpha f(x) + beta g(x) = alpha x^2 + beta x = 0.
    $
    Since this equation must hold true for all $x$, it must hold true for $x=1$. Therefore,
    $
      alpha f(1)+beta g(1) = alpha 1^2 + beta 1 = alpha + beta = 0.
    $
    Similarly, it must hold true for $x=2$, and so
    $
      alpha f(2)+beta g(2) = alpha 2^2 + beta 2 = 4alpha + 2beta = 0.
    $
    From the first equation, we see that $alpha = -beta$ and from the second that $alpha = -1 / 2 beta$.
    The only way for both of these conditions to be satisfied is if $alpha = 0$ and $beta = 0$. Thus ${f,g}$ is linearly independent.

    #v(1em)

    Alternatively, consider the set ${f,g,h}$. We can attempt to solve the equation
    $
      alpha f(x) + beta g(x) + gamma h(x) = alpha x^2 + beta x + gamma (2x^2 - x) = 0,
    $
    which, by inspection, has a non-trivial solution $alpha=-2$, $beta=1$, and $gamma=1$. Thus ${f,g,h}$
    are linearly dependent.
  ],
)

A historical technique for determining whether a set of functions is linearly independent is to compute the determinant of the _Wronskian matrix_;#footnote[See https://en.wikipedia.org/wiki/Wronskian]
while appeal to the Wronskian is occasionally useful, we will stick with direct approaches in this text.

With the definition of linear independence/dependence pinned down, we can apply the usual Linear Algebra definitions of subspace, basis, and dimension to $cal(F)^n$.

=== Dimension of the solution space

So far, we have established that solutions to matrix differential equations form a subspace, and as a subspace space, they must have a dimension#footnote[This is a powerful theorem coming from abstract Linear Algebra
  and relying on the axiom of choice. We will just accept this theorem as fact.]. Our next goal will be to establish the dimension of the solution space to a matrix differential equation
and then to find a general solution.

The following theorem will give us a place to start.

#theorem(
  title: [Existence & Uniqueness 1],
  [
    The system of differential equations represented by $arrow(r)'(t) = M arrow(r)(t) + arrow(p)$ (or the single differential equation $y' = a y + b$) has a unique solution passing through every initial condition.
    Further, the domain of every solution is $RR$.
  ],
)

Now, suppose that $M$ is an $n times n$ matrix. Let $cal(S)$ be the set of all solutions to $arrow(r)' = M arrow(r)$.
The above theorem states that every initial value problem
$
  arrow(r)' = M arrow(r) wide "and" wide arrow(r)(t_0) = mat(x_1; dots.v; x_n)
$
has a unique solution. Thus, the space of all solutions can be no "bigger" than the set of all initial conditions. Notice that we have $n+1$ parameters to choose for
initial conditions. We have $n$ choices coming from $x_1$, ..., $x_n$ with one more choice coming from the value of $t_0$.

This means that the dimension of $cal(S)$ is bounded above by $n+1$.#footnote[To make this argument fully rigorous, you need to establish the existence of a smooth map between the
  space of initial conditions and the space of solutions and then invoke the theorem that smooth maps cannot increase the dimension of a space.] But, we can do slightly better.

#theorem(
  title: [Solutions pass through $t=0$],
  [
    Let $arrow(w)$ be a solution to the initial value problem $arrow(r)' = M arrow(r)$ with initial condition $arrow(r)(t_0) = arrow(r)_0$.
    Then, $arrow(w)$ is _also_ the solution to the initial value problem $arrow(r)'=M arrow(r)$ with initial condition $arrow(r)(0) = arrow(w)_0$ where
    $arrow(w)_0 = arrow(w)(0)$.
  ],
)
_Proof:_ Let $arrow(w)$ be a solution to the initial value problem $arrow(r)' = M arrow(r)$ with initial condition $arrow(r)(t_0) = arrow(r)_0$. Based on the Existence & Uniqueness Theorem 1,
we know $arrow(w)_0=arrow(w)(0)$ is defined. Further, since there is a solution to every initial value problem, $arrow(r)' = M arrow(r)$ with $arrow(r)(0)=arrow(w)_0$ has a solution.
Finally, because every solution passing through a set of initial conditions is unique, since $arrow(w)(t)$ already passes through $arrow(w)_0$, we must have that
$arrow(w)$ is the unique solution to the initial value problem $arrow(r)' = M arrow(r)$ with initial condition $arrow(r)(0) = arrow(w)_0$. $square.filled$

The preceding theorem shrinks the space of solutions. Originally we knew that the set of all solutions can be obtained by solving initial value problems
for all choices of $x_1$, ..., $x_n$, *and* $t_0$. But now we know
that fixing $t_0=0$ gives us the same solutions. Thus, by making $n$ choices, we can determine a solution. This means
$
  dim(cal(S)) <= n.
$

This argument leads to the following theorem.
#theorem(
  title: [Solution Space Upper Bound],
  [
    Let $M$ be an $n times n$ matrix and let $cal(S)$ be the set of all solutions to $arrow(r)'(t) = M arrow(r)(t)$. Then
    $
      dim(cal(S)) <= n.
    $
  ],
)

=== Finding a basis of solutions

Recall that $M$ is an $n times n$ matrix and that $cal(S)$ is the set of all solutions to $arrow(r)' = M arrow(r)$. We have established $dim(cal(S)) <= n$.
We will now try to find the exact dimension and a basis for $cal(S)$.

Before reading this part of the module, you should work through the core exercises @ex:basic_system[] -- @ex:system_eigen_solutions[] to understand where the idea comes from. XXX Think about whether this becomes a consistent margin note, at the beginning of the module, or something different.

Suppose that $arrow(v)$ is an eigenvector for $M$ with eigenvalue $lambda$ and consider $arrow(s)(t)=arrow(v)e^(lambda t)$.
Multiplying by $M$ we get
$
  M arrow(s)(t) = M (arrow(v) e^(lambda t)) = M arrow(v) e^(lambda t) = lambda arrow(v) e^(lambda t) = lambda arrow(s)(t).
$
Similarly, taking a derivative with respect to $t$, we get
$
  (dif) / (dif t) arrow(s)(t)= lambda arrow(v) e^(lambda t) = lambda arrow(s)(t).
$
In other words, $arrow(s)' =lambda arrow(s)= M arrow(s)$, and so $arrow(s)$ is a solution to our differential equation. This means that whenever we have an eigenvector/eigenvalue
for $M$, we can write down an explicit solution to $arrow(r)'=M arrow(r)$. Solutions constructed this way are called _eigen solutions_.

#show_def("eigensolution")

We just proved that any eigen solution to $arrow(r)'=M arrow(r)$ is, indeed, a solution. Since eigen solutions corresponding to linearly independent eigenvectors
are linearly independent (justify this fact to yourself), we know
$
  dim(cal(S)) >= "# linearly independent eigenvectors of" M.
$

Thus, if $M$ has $n$ linearly independent eigenvectors (i.e., if $M$ is diagnoalizable), then
$
  dim(cal(S)) >= n.
$

Combined with our previous result, we now have the following theorem.
#theorem(
  title: [Solution Space Dimension],
  [
    Let $M$ be an $n times n$ matrix and let $cal(S)$ be the set of all solutions to $arrow(r)'(t) = M arrow(r)(t)$. Then, if $M$ is diagonalizable,
    $
      dim(cal(S)) = n.
    $
  ],
)

In this text, we will only consider matrix differential equations where the matrix is diagonalizable, but the above theorem
also holds when $M$ is _not_ diagonalizable. However, the proof relies on finding a basis of solutions, some of which are not eigen solutions.


=== Solutions of systems with real eigenvalues

The preceding section shows us that if we have a full set of eigenvectors#footnote["full set" means that for an $n times n$ matrix we have $n$ linearly independent eigenvectors.]
for a matrix $M$, _every solution_ can be expressed as a linear combination of the eigen solutions.

#example(
  prompt: [Find all solutions of the system of differential equations],
  [
    $
      (dif x) / (dif t) &= 2 x + y \
      (dif y) / (dif t) &= x + 2 y
    $

    We can write this system in matrix form as:
    $
      mat((dif x) / (dif t); (dif y) / (dif t))
      = mat(2, 1; 1, 2) mat(x; y)
    $
    and if we let $arrow(r) = mat(x; y)$ and $M = mat(2, 1; 1, 2)$, we can write the system as:
    $ (dif arrow(r)) / (dif t) = M arrow(r), $
    where $arrow(r)$ is a vector of the two dependent variables and $M$ is the coefficient matrix.

    We can find the eigenvalues and eigenvectors of the matrix $M$:
    - $lambda_1 = 3$ with eigenvector $arrow(v_1) = mat(1; 1),$

    - $lambda_2 = 1$ with eigenvector $arrow(v_2) = mat(1; -1).$

    We can now write the eigen solutions of the system of differential equations:
    $
      arrow(r_1)(t) &= arrow(v_1) e^(3 t) = mat(1; 1) e^(3 t), \
      arrow(r_2)(t) &= arrow(v_2) e^(1 t) = mat(1; -1) e^(1 t).
    $

    Linear combination of these two solutions form general solution:
    $
      arrow(r)(t) = alpha mat(1; 1) e^(3 t) + beta mat(1; -1) e^(1 t),
    $
    where $alpha$ and $beta$ are constants that depend on the initial conditions of the system.
  ],
)

#example(
  prompt: [Find the solution to $arrow(r)'=mat(2, 1; 1, 2)arrow(r)$ that satisfies $arrow(r)(0) = mat(1; 0)$.],
  [
    We already found the general solution to $arrow(r)'=mat(2, 1; 1, 2)arrow(r)$:
    $
      arrow(r)(t) = alpha mat(1; 1) e^(3 t) + beta mat(1; -1) e^(1 t),
    $
    where $alpha$ and $beta$ are parameters.

    Since we require $arrow(r)(0)=mat(1; 0)$, we can solve
    $
      arrow(r)(0) = alpha mat(1; 1) e^(3 dot 0) + beta mat(1; -1) e^(1 dot 0) \
      mat(1; 0) &= alpha mat(1; 1) + beta mat(1; -1)
    $
    to get $alpha= 1 / 2$ and $beta= 1 / 2$.
    Thus the solution that satisfies the initial condition is:
    $
      arrow(r)(t) &= (1 / 2) mat(1; 1) e^(3 t) + (1 / 2) mat(1; -1) e^(1 t) \
      &= (1 / 2) mat(e^(3t) + e^t; e^(3t) - e^t).
    $
  ],
)

=== Eigen solutions in phase space

XXX Finish

=== Stability of the Equilibrium Solutions

Now that we have a method to find the solutions of a system of differential equations with constant coefficients, we can study the question:
#quote(block: true)[
  As time goes to infinity, what is the long-term behaviour of solutions? Do they tend towards or away from the equilibrium solution(s)?
]

First note that if $arrow(s)$ is an equilibrium solution to $arrow(r)'=M arrow(r)$, then $arrow(s)'(t)=arrow(0)$ which implies $M arrow(s)=arrow(0)$.
This means that if $M$ is invertible, the equation $arrow(r)'=M arrow(r)$ has a unique equilibrium solution: $arrow(s)'(t)=arrow(0)$. Further,
all equilibrium solutions can be found by analyzing the null space of $M$.

For illustration purposes, let us now consider a $2 times 2$ matrix $M$ with real and distinct eigenvalues $lambda_1 != lambda_2$ and corresponding eigenvectors
$arrow(v)_1$
and $arrow(v)_2$.
The general solution to the equation $arrow(r)'= M arrow(r)$ is
$
  arrow(r)(t) = c_1 arrow(v)_1 e^(lambda_1 t) + c_2 arrow(v)_2 e^(lambda_2 t),
$
where $c_1$ and $c_2$ parameters. We want to study the long-term behaviour of solutions, which depends on the long-term behaviour of the exponential function:
$
  lim_(t arrow infinity) e^(lambda t) = cases(
    0 &" if " lambda < 0,
    1 &" if " lambda = 0,
    infinity &" if " lambda > 0,
  ).
$

We immediately see:
- If $lambda_1 < 0$ and $lambda_2 < 0$, then $lim_(t arrow infinity) arrow(r)(t) = arrow(0)$ no matter the values of $c_1$ and $c_2$.
- If $lambda_1 > 0$ and $lambda_2 > 0$, then $lim_(t arrow infinity) arrow(r)(t)$ diverges as long as at least one of $c_1$ and $c_2$ are non-zero.

What can this tell us about the stability of the equilibrium solution?

Recall the informal classification of equilibrium solutions#footnote([Check @mod:equilibrium for the precise definition.]) from @mod:equilibrium.

#show_def("equilibrium_classification_informal")

Now consider the equilibrium solution $arrow(s)(t)=arrow(0)$.#footnote[There may be other equilibrium solutions, but this equilibrium solution always exists.]
If $arrow(r)(t) = c_1 arrow(v)_1 e^(lambda_1 t) + c_2 arrow(v)_2 e^(lambda_2 t)$ is "close to" $arrow(s)(t)=arrow(0)$ at time $t=0$, then $c_1$ and $c_2$ are close to zero.
We can now consider cases based on $lambda_1$ and $lambda_2$:

- If $lambda_1$ or $lambda_2$ is positive, then there will be solutions that diverge $==>$ $arrow(s)$ is unstable.
- If $lambda_1$ and $lambda_2$ are negative, then _all_ solutions will converge zero $==>$ $arrow(s)$ is stable and attracting.
- If one of $lambda_1$ or $lambda_2$ is zero, then there are constant solutions near $arrow(s)$ $==>$ $arrow(s)$ is not attracting nor repelling.
  - If $lambda_1=0$ and $lambda_2 < 0$, then $arrow(s)$ will be stable, because solutions either converge to the equilibrium ($arrow(0)$) or are constant solutions.
  - If $lambda_1=0$ and $lambda_2 > 0$, then $arrow(s)$ will be unstable, because solutions either diverge to infinity or are constant solutions.


The following tables summarize our findings:

#align(
  center,
  simple_table(
    headers: ([Eigenvalue $lambda_1$], [Eigenvalue $lambda_2$], [Stability of Equilibrium]),
    content: (
      // real, both negative
      $lambda_1<0$,
      $lambda_2<0$,
      [Stable and Attracting],
      // real, both positive
      $lambda_1>0$,
      $lambda_2>0$,
      [Unstable and Repelling],
      // real, one positive, one negative
      $lambda_1<0$,
      $lambda_2>0$,
      [Unstable],
      table.hline(stroke: .5pt),
      $lambda_1=0$,
      $lambda_2=0$,
      [Stable],
      // real, 0 + negative
      $lambda_1=0$,
      $lambda_2<0$,
      [Stable],
      // real, 0 + positive
      $lambda_1=0$,
      $lambda_2>0$,
      [Unstable],
      table.hline(stroke: .5pt),
    ),
  ),
)

or

#align(
  center,
  simple_table(
    headers: ([Sign of Eigenvalues], [Stability of Equilibrium]),
    content: (
      // real, both negative
      [Both negative],
      [Stable and Attracting],
      // real, both positive
      [Both positive],
      [Unstable and Repelling],
      // real, one positive, one negative
      [One negative, one positive],
      [Unstable],
      table.hline(stroke: .5pt),
      [Both zero],
      [Stable],
      // real, 0 + negative
      [One is zero, one is negative],
      [Stable],
      // real, 0 + positive
      [One is zero, one is positive],
      [Unstable],
      table.hline(stroke: .5pt),
    ),
  ),
)

#example(
  prompt: [Suppose $arrow(r)'=M arrow(r)$ has a general solution $ arrow(r)(t) = alpha mat(1; 1) e^(t) + beta mat(0; 1) e^(-t). $
    Prove that the equilibrium solution $arrow(s)(t)=arrow(0)$ unstable and _not_ repelling.],
  [
    XXX Finish
  ],
)

