
// This file is meant to be imported and not compiled on its own.
#import "@preview/tiptoe:0.3.0"
#import "../common/settings-book.typ": workbook, show_def
#import "../libs/_graphics.typ": vector_field
#let (sans, serif, module, definition, example, theorem) = workbook

In this module you will learn
- What makes a differential equation _affine_.
- How to relate affine equations and matrix equations.
- How to solve differential equations of the form $arrow(r)'=M arrow(r) + arrow(b)$.

We have a firm grasp on how to solve matrix differential equations of the form $arrow(r)'=M arrow(r)$.
What about equations of the form $arrow(r)'=M arrow(r) + arrow(b)$?
Unfortunately, that extra "$+arrow(b)$" changes a lot. For example, solutions no longer form a subspace!

#example(
  prompt: [Show that solutions to $y'=2y+1$ do _not_ form a subspace.],
  [
    Since $y'=2y+1$ is separable, we can explicitly solve to find solutions:
    $
      y(t) = A e^(2 t) - 1 / 2 wide "where" A "is a parameter".
    $
    Picking the solution $y_1(t)=-1 / 2$ (where $A$ corresponds to $0$) and $y_2(t)=e^(2 t)-1 / 2$ (where $A$ corresponds to $1$), let
    $
      y_3(t) = y_1(t) + y_2(t) = -1 / 2 + e^(2 t) - 1 / 2 = e^(2 t) - 1.
    $
    Differentiating, $y_3'(t) = 2e^(2t) = 2y_3(t) + 2$, and so $y_3$ is _not_ a solution. Therefore, the solutions of $y'=2y+1$
    _cannot_ form a subspace.
  ],
)

The issue is that $arrow(r)'=M arrow(r) + arrow(b)$ is no loner a matrix equation, it is an _affine equation_. Affine equations
are matrix equations plus a vector of constants, and we will soon see how to compensate for that extra "$+arrow(b)$".

== Centering about the Equilibrium

Let $M = mat(0, 1; 1, 0)$ and consider the equations $arrow(u)'=M arrow(u)$ and $arrow(v)'=M arrow(v) + mat(-1; -2)$. We can
make phase portraits for both of these equations.


#{
  let F1(x, y) = (y, x)
  let F2(x, y) = (y - 1, x - 2)
  let xlim = (-7, 7)
  let ylim = (-7, 7)
  align(
    center,
    {
      vector_field(
        F1,
        title: $arrow(u)'=M arrow(u)$,
        xlim: xlim,
        ylim: ylim,
        spacing: (.75, .75),
        scale_segments: 20.0,
        width: 5cm,
        height: 5cm,
        yaxis: (position: 0, tip: tiptoe.stealth, ticks: none, subticks: none),
        xaxis: (position: 0, tip: tiptoe.stealth, ticks: none, subticks: none),
      )
      h(2em)
      vector_field(
        F2,
        title: $arrow(v)'=M arrow(v) + mat(-1; -2)$,
        xlim: xlim,
        ylim: ylim,
        spacing: (.75, .75),
        scale_segments: 20.0,
        width: 5cm,
        height: 5cm,
        yaxis: (position: 0, tip: tiptoe.stealth, ticks: none, subticks: none),
        xaxis: (position: 0, tip: tiptoe.stealth, ticks: none, subticks: none),
      )
    },
  )
}

The phase portraits look very similar: they are shifts of each other. To figure out the exact shift, let's
analyze the equilibrium points of both equations.

$
  arrow(u)'=M arrow(u) = mat(0; 0) quad <==>quad arrow(u) = mat(0; 0)
$
and
$
  arrow(v)'=M arrow(v) + mat(-1; -2) = mat(0; 0) quad <==>quad arrow(v) = mat(2; 1)
$

and so the phase portraits are shifted by the vector $mat(2; 1)$.

We can use this information to relate the solutions to $arrow(u)'=M arrow(u)$ and $arrow(v)'=M arrow(v) + mat(-1; -2)$ to each other.
Let $arrow(v)$ be a solution to $arrow(v)'=M arrow(v) + mat(-1; -2)$ and
define the function
$
  arrow(s)(t) = arrow(v)(t) - mat(2; 1).
$
We can now compute
$
  arrow(s)'(t) = ( arrow(v)(t) - mat(2; 1))' = arrow(v)'(t) - mat(2; 1)' = arrow(v)'(t),
$
because the derivative of a constant vector is $arrow(0)$.
Alternatively, multiplying by $M$ we get
$
  M arrow(s)(t) &=M (arrow(v)(t) - mat(2; 1)) \
  &= M arrow(v)(t) - M mat(2; 1)\
  &= M arrow(v)(t) - mat(1; 2)
  = M arrow(v)(t) + mat(-1; -2) =
  arrow(v)(t)'.
$
In other words, $arrow(s)'=M arrow(s)$, and so $arrow(s)$ is a solution to the first equation.
What we have done is called a _change of variables_ and the result is that we can relate solutions
to the affine equation $arrow(v)'=M arrow(v) + mat(-1; -2)$ to the matrix equation $arrow(u)'=M arrow(u)$.

#example(
  prompt: [Let $M=mat(1, 2; 3, 4)$ and suppose $arrow(v)$ is a solution to $arrow(v)'=M arrow(v) + mat(2; 0)$.
    Find a solution to $arrow(r)'=M arrow(r)$ in terms of $arrow(v)$.],
  [
    XXX Finish
  ],
)

The processes we just followed (shifting a solution to the affine equation by its equilibrium point
to find a solution to the corresponding matrix equation) always works, and we will refer to it as
_centering about the equilibrium_.

#theorem(
  title: [Centering about the Equilibrium],
  [
    Let $M$ be a matrix and $arrow(b)$ a vector and consider the differential equations
    #block[
      #set enum(numbering: "(1)")
      + $arrow(r)'=M arrow(r)$
      + $arrow(r)'=M arrow(r) + arrow(b)$
    ]


    If $arrow(p)$ is the equilibrium point of the affine equation (2) and
    $arrow(v)$ is a solution to the affine equation (2), then
    $
      arrow(s)(t) = arrow(v)(t) - arrow(p)
    $
    is a solution to the matrix equation (1).

    Similarly, if $arrow(u)$ is a solution to the matrix equation (1), then
    $
      arrow(s)(t) = arrow(u)(t) + arrow(p)
    $
    is a solution to the affine equation (2).
  ],
)

_Proof:_ We leave the proof of this Theorem as an exercise for the reader. XXX

== Solving Affine Equations

Centring (and uncentering) about the equilibrium can be used to solve affine equations.
Let's use our example from earlier:
$
  arrow(r)'= mat(0, 1; 1, 0) arrow(r) + mat(-1; -2)
$
By solving for $arrow(r)'(t)=arrow(0)$, we see that $arrow(r)(t)=mat(2; 1)$ is an equilibrium solution.
Next, we will apply our eigenvector techniques to solve the related equation $arrow(r)'= mat(0, 1; 1, 0) arrow(r)$.
This equation has solutions
$
  arrow(u)(t) = A e^(t) mat(1; 1) + B e^(-t) mat(1; -1) wide "where" A "and" B "are parameters".
$
_These are not solutions to the original affine equation!_ However, we can define
$
  arrow(s)(t) = arrow(u)(t) + mat(2; 1) = A e^(t) mat(1; 1) + B e^(-t) mat(1; -1) + mat(2; 1) wide "where" A "and" B "are parameters".
$
Now, we can check that $arrow(s)$ is a solution.
$
  arrow(s)'(t) = (A e^(t) mat(1; 1) + B e^(-t) mat(1; -1) + mat(2; 1))' &= A e^(t) mat(1; 1) - B e^(-t) mat(1; -1)
$
and
$
  mat(0, 1; 1, 0) arrow(s)(t) + mat(-1; -2) &= mat(0, 1; 1, 0) (A e^(t) mat(1; 1) + B e^(-t) mat(1; -1) + mat(2; 1)) + mat(-1; -2) \
  &= mat(0, 1; 1, 0) (A e^(t) mat(1; 1) + B e^(-t) mat(1; -1)) + mat(0, 1; 1, 0) mat(2; 1) + mat(-1; -2) \
  &= A e^(t) mat(1; 1) - B e^(-t) mat(1; -1) + mat(1; 2) + mat(-1; -2) \
  &= A e^(t) mat(1; 1) - B e^(-t) mat(1; -1),
$
and so $arrow(s)$ is a solution for every choice of $A$ and $B$.

