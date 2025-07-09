
// This file is meant to be imported and not compiled on its own.
#import "@preview/tiptoe:0.3.0"
#import "@preview/lilaq:0.3.0" as lq
#import "../common/settings-book.typ": show_def, workbook
#import "../libs/_workbook.typ": label_module
#import "../libs/_graphics.typ": vector_field
#let (sans, serif, module, definition, example, theorem) = workbook

#label_module(<mod:affine>)

In this module you will learn
- What makes a differential equation _affine_.
- How to relate affine equations and matrix equations.
- How to solve differential equations of the form $arrow(r)'=M arrow(r) + arrow(b)$.

We have a firm grasp on how to solve matrix differential equations of the form $arrow(r)'=M arrow(r)$.
What about equations of the form $arrow(r)'=M arrow(r) + arrow(b)$?
Unfortunately, that extra "$+arrow(b)$" changes a lot. For example, the solution set is no longer a subspace!

#example(
  prompt: [Show that solutions to $y'=2y+1$ do _not_ form a subspace.],
  [
    Since $y'=2y+1$ is separable, we can explicitly solve to find solutions:
    $
      y(t) = A e^(2 t) - 1 / 2 wide "where" A "is a parameter".
    $
    Picking the solution $y_1(t)=-1 / 2$ (where $A=0$) and $y_2(t)=e^(2 t)-1 / 2$ (where $A=1$), let
    $
      y_3(t) = y_1(t) + y_2(t) = -1 / 2 + e^(2 t) - 1 / 2 = e^(2 t) - 1.
    $
    Differentiating, $y_3 '(t) = 2e^(2t) = 2y_3(t) + 2$, and so $y_3$ is _not_ a solution. Therefore, the solutions of $y'=2y+1$
    _cannot_ form a subspace.
  ],
)

The issue is that $arrow(r)'=M arrow(r) + arrow(b)$ is no loner a matrix equation, it is an _affine equation_. Affine equations
are matrix equations plus a vector of constants. We will soon see how to compensate for the extra "$+arrow(b)$".

== Centering about the Equilibrium

Let $M = mat(0, 1; 1, 0)$ and consider the equations
#math.equation(
  block: true,
  numbering: "(1)",
  $arrow(u)'=M arrow(u)$,
)<eq:non-affine>
and
#math.equation(
  block: true,
  numbering: "(1)",
  $arrow(v)'=M arrow(v) + mat(-1; -2).$,
)<eq:affine>
We can
make phase portraits for both of these equations.


#{
  let F1(x, y) = (y, x)
  let F2(x, y) = (y - 1, x - 2)
  let xlim = (-7, 7)
  let ylim = (-7, 7)
  align(center, {
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
  })
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
Let $arrow(v)$ be a solution to @eq:affine and
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
  M arrow(s)(t) & =M (arrow(v)(t) - mat(2; 1))  \
                & = M arrow(v)(t) - M mat(2; 1) \
                & = M arrow(v)(t) - mat(1; 2)
                  = M arrow(v)(t) + mat(-1; -2) =
                  arrow(v)'(t).
$
In other words, $arrow(s)'=M arrow(s)$, and so $arrow(s)$ is a solution to @eq:non-affine.
What we have done is called a _change of variables_ and the result is that we can relate solutions
to the affine equation $arrow(v)'=M arrow(v) + mat(-1; -2)$ with solutions to the matrix equation $arrow(u)'=M arrow(u)$.

#example(
  prompt: [Let $M=mat(1, 2; 3, 4)$ and suppose $arrow(v)$ is a solution to $arrow(v)'=M arrow(v) + mat(2; 0)$.
    Find a solution to $arrow(r)'=M arrow(r)$ in terms of $arrow(v)$.],
  [
    There are several methods to proceed: (i) we could start by finding the equilibrium points for each equation and then
    applying the difference between equilibrium points as a translation. Alternatively, (ii) we could start out by
    assuming that the solutions are related by _some_ translation, and then figuring out what that translation is after the fact.
    Let's take approach (ii).

    We know that $arrow(v)$ is a solution to $arrow(v)'=M arrow(v) + mat(2; 0)$. Define
    $
      arrow(s)(t) = arrow(v)(t) + arrow(p)
    $
    for a vector $arrow(p)$ that we will determine later.


    We want $arrow(s)$ to be a solution to $arrow(r)'=M arrow(r)$. Computing
    $
      arrow(s)'(t) = (arrow(v)(t) + arrow(p))' = arrow(v)'(t) + arrow(p)' = arrow(v)'(t) = M arrow(v)(t) + mat(2; 0)
    $
    and
    $
      M arrow(s)(t) = M (arrow(v)(t) + arrow(p)) = M arrow(v)(t) + M arrow(p).
    $
    Setting these equal (because we want $arrow(s)' = M arrow(s)$) we see that
    $
      M arrow(p) = mat(2; 0)
    $
    and so $arrow(p) = M^(-1)mat(2; 0) = mat(-4; 3)$. Therefore, our solution to $arrow(r)'=M arrow(r)$ in terms of $arrow(v)$ is
    $
      arrow(s)(t) = arrow(v)(t) + mat(-4; 3).
    $
  ],
)

The processes we just followed (shifting a solution to the affine equation by its equilibrium point
to find a solution to the corresponding matrix equation) always works, and we will refer to it as
_centering about the equilibrium_.

#theorem(title: [Centering about the Equilibrium], [
  Let $M$ be a matrix and $arrow(b)$ a vector and consider the differential equations:
  #math.equation(
    block: true,
    numbering: "(1)",
    $arrow(r)'=M arrow(r)$,
  )<eq:abstract-non-affine>
  #math.equation(
    block: true,
    numbering: "(1)",
    $arrow(r)'=M arrow(r) + arrow(b)$,
  )<eq:abstract-affine>

  If $arrow(p)$ is the equilibrium point of the affine equation @eq:abstract-affine[] and
  $arrow(v)$ is a solution to the affine equation @eq:abstract-affine[], then
  $
    arrow(s)(t) = arrow(v)(t) - arrow(p)
  $
  is a solution to the matrix equation @eq:abstract-non-affine[].

  Similarly, if $arrow(u)$ is a solution to the matrix equation @eq:abstract-non-affine[], then
  $
    arrow(q)(t) = arrow(u)(t) + arrow(p)
  $
  is a solution to the affine equation @eq:abstract-affine[].
])

_Proof:_ We leave the proof as an exercise for the reader.

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
  arrow(s)'(t) = (A e^(t) mat(1; 1) + B e^(-t) mat(1; -1) + mat(2; 1))' & = A e^(t) mat(1; 1) - B e^(-t) mat(1; -1)
$
and
$
  mat(0, 1; 1, 0) arrow(s)(t) + mat(-1; -2) &= mat(0, 1; 1, 0) (A e^(t) mat(1; 1) + B e^(-t) mat(1; -1) + mat(2; 1)) + mat(-1; -2) \
  &= mat(0, 1; 1, 0) (A e^(t) mat(1; 1) + B e^(-t) mat(1; -1)) + mat(0, 1; 1, 0) mat(2; 1) + mat(-1; -2) \
  &= A e^(t) mat(1; 1) - B e^(-t) mat(1; -1) + mat(1; 2) + mat(-1; -2) \
  &= A e^(t) mat(1; 1) - B e^(-t) mat(1; -1),
$
and so $arrow(s)$ is a solution for every choice of $A$ and $B$.

=== Figuring out what to shift by

Do not try to _memorize_ how to shift one solution to get another. Instead, spend some time visualizing
the relationship between solutions to an affine equation and its corresponding matrix equation.

Remember: a matrix equation always has $arrow(r)(t)=arrow(0)$ as an equilibrium solution. So, if you think of the phase space picture from before
and translate the equilibrium solution, all other solutions will be translated in the same way.

XXX Annotate this diagram with an arrow showing how the equilibrium solution changes.
#{
  let F1(x, y) = (y, x)
  let F2(x, y) = (y - 1, x - 2)
  let xlim = (-7, 7)
  let ylim = (-7, 7)
  align(center, {
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
      lq.plot((0,), (0,), mark-size: 10pt, mark-color: black, stroke: black),
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
      lq.plot((2,), (1,), mark-size: 10pt, mark-color: black, stroke: black),
    )
  })
}

Above to go from matrix to affine, we translate solutions by $mat(2; 1)$. To go from affine to matrix, we translate solutions by $mat(-2; -1)$.

But, *make sure to actually compute the equilibrium solution(s)*. When confronted with an equation like $arrow(r)' = M arrow(r) + arrow(p)$, it is tempting to
claim that $arrow(p)$ is an equilibrium solution. In all likelihood, *it is not*! (It is actually $-M^(-1) arrow(p)$.)
