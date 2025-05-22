
// This file is meant to be imported and not compiled on its own.
#import "../common/settings-book.typ": workbook, show_def
#import "../libs/_workbook.typ": simple_table, label_module
#let (sans, serif, module, definition, example, theorem) = workbook

#label_module(<mod:real>)

In this module you will learn
- How to find analytic solutions to systems of differential equations with constant coefficients by using the eigenvalues and eigenvectors of the coefficient matrix.
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



=== Linear Algebra Pre-requisites

Starting with this module, we will be using several results from linear algebra. We will assume that you are familiar with the following concepts:
- Vector spaces and subspaces.
- Linear transformation and their null space/kernel and range/image.
- Linear independence of vectors.
- Span, basis, and dimension of a vector space/subspace.
- Eigenvalues and eigenvectors of a matrix and how to compute them.

You will find a review of these topics in APPENDIX XXX. If you are not familiar with them, we recommend that you review them before continuing with this module.


== Finding Analytic Solutions

For equations like $y'=7 y$, we were lucky enough to find solutions $y(t)=A e^(7 t)$ (where $A in RR$ is a parameter) by guessing and checking.
It turns out, by using some insights from linear algebra, we will be able to guess-and-check solutions to some systems of
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
When rewritten this way, we say that the system of differential equations is written in _matrix form_.

XXX ADD DEFINITION OF MATRIX FORM

We can further refine our matrix form by introducing a function $arrow(r)(t)=mat(x(t); y(t))$. Since the derivative
of a multivariable function is the derivative of each of its components, $arrow(r)'(t)=mat(x'(t); y'(t))$, and so
the system can be rewritten as
$
  arrow(r)' = mat(2, 1; 1, 2) arrow(r).
$


=== Eigenvectors and Guessing Solutions

The equation $arrow(r)'=mat(2, 1; 1, 2) arrow(r)$ looks a lot like our previous equation $y' = k y$, so we might
get lucky and be able to guess a solution!

Let's start by guessing a solution of the form
$
  arrow(r)(t) = mat(A; B)e^(k t) = mat(A e^(k t); B e^(k t))  wide arrow.r.double.long wide arrow(r)'(t) = mat(k A e^(k t); k B e^(k t)) = k mat(A e^(k t); B e^(k t)) = k space.thin arrow(r)(t),
$
where $A,B, k in RR$ are parameters.
With this guess, combining with the original system of differential equations, we see that
$
  arrow(r)' = mat(2, 1; 1, 2) arrow(r) = k space.thin arrow(r).
$
In other words, $arrow(r)$ must be an eigenvector of $mat(2, 1; 1, 2)$ with eigenvalue $k$!

Computing, we see the eigenvectors of $mat(2, 1; 1, 2)$ are
$
  arrow(v_1) = mat(1; 1) " with eigenvalue " 3 wide "and" wide arrow(v_2) = mat(1; -1) " with eigenvalue " -1.
$
Thus we guess solutions
$
  arrow(r_1)(t) =  mat(1; 1) e^(3 t) = mat(e^(3 t); e^(3 t)) wide "and" wide arrow(r_2)(t) = mat(1; -1) e^(-t)  = mat(e^(-t); -e^(-t)).
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
  prompt: [Decide whether $alpha space.thin arrow(r)_1$ and $beta space.thin arrow(r)_2$ are solutions, where $alpha, beta in RR$ are constants],
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
    and so $(alpha space.thin arrow(r)_1(t)) = mat(2, 1; 1, 2) (alpha space.thin arrow(r)_1(t))$ showing that $alpha space.thin arrow(r)_1(t)$ is a solution
    no matter the value of $alpha$.

    A similar computation shows that $beta space.thin arrow(r)_2(t)$ is a solution for any value of $beta$.
  ],
)

The preceding example can be generalized to show that if you have a solution to a matrix differential equation, then all
scalar multiples of that solution are also solutions, which is in turn a special case of a more general theorem.

#theorem(
  title: [Solutions Form a Subspace],
  [
    Let $arrow(r)'=M arrow(r)$ be a matrix differential equation and let $cal(S)$ be the set of all solutions. Then, $cal(S)$
    is a subspace. In particular, $cal(S)$ is closed under linear combinations.
  ],
)

The proof relies on some basic linear algebra results.

_Proof:_ Suppose that $cal(S)$ is the set of all solutions the an equation $arrow(r)'=M arrow(r)$ (where $M$ is a square matrix). First, notice that
$
  arrow(0)' = arrow(0) = M arrow(0),
$
so $arrow(0) in cal(S)$. Next, suppose that $arrow(s_1)$ and $arrow(s_2)$ are solutions in $cal(S)$.
By definition that means $arrow(s_1)' = M arrow(s_1)$ and $arrow(s_2)' = M arrow(s_2)$.
By the linearity of the derivative, we may now compute
$
  (alpha space.thin arrow(s_1) + beta space.thin arrow(s_2))' &= alpha space.thin arrow(s_1)' + beta space.thin arrow(s_2)' \
  &= alpha space.thin M arrow(s_1) + beta space.thin M arrow(s_2) \
  &= M (alpha space.thin arrow(s_1) + beta space.thin arrow(s_2)),
$
and so $alpha space.thin arrow(s_1) + beta space.thin arrow(s_2)$ is also a solution in $cal(S)$. #align(right, sym.square.filled)

#v(1em)

Given the above theorem, we can find all sorts of solutions to $arrow(r)'(t) = mat(2, 1; 1, 2) arrow(r)(t)$ like
$
  arrow(r)_1(t) + 4 space.thin arrow(r)_2(t) = mat(e^(3 t) + 4space.thin e^(-t); e^(3 t) - 4space.thin e^(-t)) wide "or" wide
  -2 space.thin arrow(r)_1(t) + 3 space.thin arrow(r)_2(t) = mat(-2space.thin e^(3 t) + 3space.thin e^(-t); -2space.thin e^(3 t) - 3space.thin e^(-t)).
$

But, have we found all the solutions? To answer that question we need to dive deeper into the linear algebra of the solution space.

== Linear Algebra of the Solution Space

You're familiar with the vector spaces $RR^n$, but the set of all function from $RR$ to $RR^n$, $cal(F)^n$, also forms a vector space.
To quickly check, notice that the constant function $z(t)=0$ acts like the "zero vector" in a normal vector space, and
if $f:RR arrow RR$ and $g:RR arrow RR$ are functions, then so is $alpha dot f + beta dot g$.#footnote(
  [
    To fully check, you must check that all the _vector space_ axioms hold.
  ],
)

The space $cal(F)^1$ is _large_. In fact, it is _infinite dimensional_, but the theorems of linear algebra still apply (provided the proper definitions).

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

XXX Mention Wronskian?

With the definition of linear independence/dependence pinned down, we can apply the usual Linear Algebra definitions of subspace, basis, and dimension to $cal(F)^n$.


To recap what we have learned so far:
- We can form linear combinations of solutions to find other solutions of the system.
- The solution space of a system of differential equations with constant coefficients is a vector space.
- We have a definition of linear dependence of solutions.



=== Finding a basis of solutions using eigenvalues and eigenvectors


Before reading this part of the module, you should work through the core exercises @ex:basic_system[] -- @ex:system_eigen_solutions[] to understand where the idea comes from. XXX Think about whether this becomes a consistent margin note, at the beginning of the module, or something different.

Consider a system of differential equations with constant coefficients:
$ (dif arrow(r)) / (dif t) = M arrow(r), $
where $M$ is a matrix with real entries.

We can find the eigenvalues and eigenvectors of the matrix $M$.
An eigenvalue $lambda$ and corresponding eigenvector $arrow(v)$ of the matrix $M$ satisfy
$ M arrow(v) = lambda arrow(v). $

Now define the function
$ arrow(r)(t) = arrow(v) e^(lambda t), $
where we recall that $(lambda, arrow(v))$ is an eigenvalue-eigenvector pair of $M$.

We will show that this is a solution of the system of differential equations.
To see this, we differentiate $arrow(r)(t)$ with respect to $t$:
$ (dif arrow(r)(t)) / (dif t) = lambda arrow(v) e^(lambda t) $
and we can also compute $M arrow(r)(t)$:
$ M arrow(r)(t) = M ( arrow(v) e^(lambda t)) =  M arrow(v) e^(lambda t) = lambda arrow(v) e^(lambda t) $
where we used the fact that $arrow(v)$ is an eigenvector of $M$ with eigenvalue $lambda$.
Thus we have
$ (dif arrow(r)(t)) / (dif t) = M arrow(r)(t). $
and we have shown that $arrow(r)(t)$ is a solution of the system of differential equations.

This means that we can find a solution of the system of differential equations by finding an eigenvalue-eigenvector pair of the coefficient matrix $M$. We call these solutions _eigen solutions_.

#show_def("eigensolution")


Since the set of all eigenvectors of a matrix $M in RR^(N times N)$ form a basis#footnote([This applies only if the matrix is diagnoalizable. In this course we will only consider diagnoalizable matrices. For non-diagonalizable matrices, see REFERENCE XXX.]) of $RR^N$, we now have an algorithm to find a set of $N$ linearly independent solutions of a $N times N$ system of differential equations with constant coefficients.


=== Dimension of the solution space


From the previous parts of this module, we have learned that the solution space is a vector space with _dimension greater or equal to $N$_, where $N$ is the number of dependent variables in the system.

We now want to show that the solution space is a vector space with _dimension less than or equal to $N$_.

The first step is to show that the system of differential equations has a unique solution passing through every initial condition.

#theorem(
  title: [Existence & Uniqueness 1],
  [
    The system of differential equations represented by $arrow(r)'(t) = M arrow(r)(t) + arrow(p)$ (or the single differential equation $y' = a y + b$) has a unique solution passing through every initial condition.
    Further, the domain of every solution is $RR$.
  ],
)

This implies that the solution space is a vector space with dimension less than or equal to $N+1$, since each solution is uniquely determined by its initial condition $(t_0, x_1, dots, x_N) in RR^(N+1)$.

However, the Theorem above also concludes that the domain of every solution is $RR$, which means that every solution is defined for $t=0$ and so can be uniquely determined by its initial condition $(0, x_1, dots, x_N)$, which forms a subspace of dimension $N$.

This means that the solution space is a vector space with dimension less than or equal to $N$.
Thus we have shown that the solution space is a vector space with dimension equal to $N$.

#theorem(
  title: [Solution Space Dimension],
  [
    The solution space of a system of differential equations with constant coefficients $arrow(r)'(t) = M arrow(r)(t) + arrow(p)$ is a vector space with dimension equal to the number of dependent variables in the system.
  ],
)


=== Solutions of systems with real eigenvalues

We can now use the results we have learned in this module to find the solutions of a system of differential equations with constant coefficients.

The set formed by the eigen solutions of the system of differential equations is a basis of the solution space. This means that we can find all solutions of the system by forming linear combinations of the eigen solutions.


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

    We can now form a linear combination of these two solutions to find the general solution of the system of differential equations:
    $ arrow(r)(t) = alpha mat(1; 1) e^(3 t) + beta mat(1; -1) e^(1 t), $
    where $alpha$ and $beta$ are constants that depend on the initial conditions of the system.
  ],
)

#example(
  prompt: [Finding the solution that satisfies $arrow(r)(0) = mat(1; 0)$.],
  [

    We are now given an initial condition $arrow(r)(0) = mat(1; 0)$.
    We can find the values of $alpha$ and $beta$ by substituting $t=0$ into the general solution:
    $
      arrow(r)(0) &= alpha mat(1; 1) e^(3 * 0) + beta mat(1; -1) e^(1 * 0) \
      mat(1; 0) &= alpha mat(1; 1) + beta mat(1; -1)
    $
    This gives us the following system of equations that we can solve for $alpha$ and $beta$:
    $
      alpha &= 1 / 2 \
      beta &= 1 / 2
    $
    Thus the solution that satisfies the initial condition is:
    $
      arrow(r)(t) &= (1 / 2) mat(1; 1) e^(3 t) + (1 / 2) mat(1; -1) e^(1 t) \
      &= (1 / 2) mat(e^(3t) + e^t; e^(3t) - e^t).
    $
  ],
)


Observe that this process works for any system of differential equations with constant coefficients as long as the eigenvalues are real and distinct.
We will see in the next module that this is not the case for all systems of differential equations with constant coefficients. In particular, we will see that if the eigenvalues are complex, this method does work but will yield eigen solutions that involve complex numbers. Since we are interested in real solutions, there will be some additional steps to obtain a basis of real solutions from the complex eigen solutions.







=== Stability of the Equilibrium Solutions

Before reading the remainder of this module, we recommend that you gain some intuition about the solutions of systems of differential equations with real distinct eigenvalues by solving the core exercises in this module.

Now that we have a method to find the solutions of a system of differential equations with constant coefficients, we can study what happens to solutions when they start near an equilibrium solution.

*As time goes to infinity, do these solutions approach the equilibrium solution or do they move away from it?*

Recall the informal classification of equilibrium solutions#footnote([Check @mod:equilibrium for the precise definition.]) from @mod:equilibrium.

#show_def("equilibrium_classification_informal")

Consider a system of differential equations
$ (dif arrow(r))/(dif t) = M arrow(r), $
where the eigenvalues of the coefficient matrix $M$ are two different real numbers: $lambda_1 eq.not lambda_2$.

Observe that the unique equilibrium solution is $arrow(r)(t) = mat(0; 0)$, so we want to establish the stability of this equilibrium solution.

Following the process described earlier in this module, we know that the solutions of the system of differential equations will have the form
$ arrow(r)_i (t) 
  = c_1 arrow(v)_1 e^(lambda_1 t) + c_2 arrow(v)_2 e^(lambda_2 t), $
where $c_1$ and $c_2$ are constants that depend on the initial conditions of the system, and $arrow(v)_1$ and $arrow(v)_2$ are the eigenvectors associated with the eigenvalues $lambda_1$ and $lambda_2$, respectively.

When computing the limit of such a solution as $t$ approaches infinity, we can focus on the exponential terms, since the other terms are constant.

Moreover, we know the limits of exponential functions:
$
  lim_(t arrow infinity) e^(lambda_1 t) = cases(
    0 &" if " lambda_1 < 0,
    1 &" if " lambda_1 = 0,
    infinity &" if " lambda_1 > 0,
  ).
$

So we can conclude that
- If one of the eigenvalues is positive, then there will be solutions that converge to infinity (unstable).
- If both eigenvalues are negative, then all solutions will converge to the equilibrium solution (stable and attracting).
- If one of the eigenvalues is zero, then there are constant solutions near the equilibrium, so it will be neither attracting nor repelling.
  - If the other eigenvalue is negative, then the equilibrium solution will be stable, because all solutions either converge to the equilibrium ($arrow(0)$) or are constant solutions.
  - If the other eigenvalue is positive, then the equilibrium solution will be unstable, because all solutions either diverge to infinity or are constant solutions.


We can summarize these results with the following table:

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
            [Unstable and Repelling],
            table.hline(stroke: .5pt),
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

OR 

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
            [Unstable and Repelling],
            table.hline(stroke: .5pt),
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

XXX CHOOSE ONE TABLE!!


