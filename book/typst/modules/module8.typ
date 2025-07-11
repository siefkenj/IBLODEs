
// This file is meant to be imported and not compiled on its own.
#import "../common/settings-book.typ": show_def, workbook
#import "../libs/_workbook.typ": label_module, simple_table
#import "../libs/_graphics.typ": vector_field
#import "@preview/tiptoe:0.3.0"
#import "@preview/lilaq:0.3.0" as lq
#let (sans, serif, module, definition, example, theorem) = workbook

#label_module(<mod:complex>)

In this module you will learn
- How to find explicit real solutions to systems of differential equations with constant coefficients when the eigenvalues of the coefficient matrix are complex.
- How the complex, distinct eigenvalues of a system of differential equations with constant coefficients are related to the stability of the equilibrium solutions.



== Complex Numbers Pre-requisites

For this module, we assume a basic understanding of complex numbers, including:
- Adding, subtracting, multiplying and dividing complex numbers.
- The complex conjugate.
- Euler's formula.

Review these topics in @app:complex before reading this module.


== Finding Explicit Solutions

Techniques from @mod:real and @mod:affine can be used to find explicit solutions to matrix/affine differential equations
so long as the coefficient matrix of the system has real eigenvalues.

A similar procedure can be used when the coefficient matrix has _complex_ eigenvalues, though some care is needed to obtain explicit _real_ solutions.

Consider the system
#align(center + horizon, stack(
  dir: ltr,
  spacing: 2em,

  $
    x' & = y     \
    y' & = - 4 x
  $,
  $<-->$,
  $
    arrow(r)' = mat(0, 1; -4, 0) arrow(r) wide "where" arrow(r)(t) = mat(x(t); y(t))
  $,
))

Following @mod:real, we can find explicit solutions by finding the eigenvalues and eigenvectors of $mat(0, 1; -4, 0)$. They are $lambda_1 = 2i$ with
eigenvector $v_1 = mat(-i; 2)$ and $lambda_2 = -2i$ with eigenvector $v_2 = mat(i; 2)$.

Using these eigenvalues and eigenvectors, we can construct two linearly independent solutions to the system:
#math.equation(
  numbering: "(1)",
  block: true,
  $
    arrow(r)_1(t) & = mat(-i; 2) e^(2 t i)
  $,
)<eq:first_solution>
#math.equation(
  numbering: "(1)",
  block: true,
  $
    arrow(r)_2(t) & = mat(i; 2) e^(-2 t i)
  $,
)<eq:second_solution>

We can verify by differentiating that both $arrow(r)_1(t)$ and $arrow(r)_2(t)$ are solutions. Further, they are linearly independent, and so the general solution to the system of differential equations is
$
  arrow(r)(t) = A arrow(r)_1(t) + B arrow(r)_2(t)
$
where $A$ and $B$ are parameters. The issue is that while our original system of differential equations was _real_ (i.e., had only real coefficients), this general solution is that its complex.

=== Finding Real Solutions

We know that the matrix equation
$
  arrow(r)' = mat(0, 1; -4, 0) arrow(r)
$
has a general solution
#math.equation(
  numbering: "(1)",
  block: true,
  $
    arrow(r)(t) = A mat(-i; 2) e^(2 t i) + B mat(i; 2) e^(-2 t i)
  $,
)<eq:complex_general_solution>
where $A$ and $B$ are parameters. However, since the problem was posed in terms of a real equation (most likely coming from a model involving only real quantities),
we would prefer a general solution that is real-valued.

#v(1em)
Before continuing, let's convince ourselves that real solutions exist.

Looking at a phase portrait for the system, we can see that there should be real solutions (we could trace them with our fingers!).

#let F(x, y) = (y, -4 * x)
#align(center, vector_field(
  title: lq.title([Phase Portrait for\ #v(-.3em)$arrow(r)'=mat(0, 1; -4, 0)arrow(r)$#v(.4em)]),
  F,
  xlim: (-4, 4),
  ylim: (-4, 4),
  //spacing: (2.5, 2.5),
  scale_segments: 8.0,
  width: 5cm,
  height: 5cm,
  xaxis: (position: 0, tip: tiptoe.stealth, subticks: none, ticks: none),
  yaxis: (position: 0, tip: tiptoe.stealth, subticks: none, ticks: none),
))

Applying Euler's method to simulate solutions, we also see that our simulations are always real-valued.

The question is, how can we manipulate @eq:complex_general_solution to find real solutions? The answer
relies on Euler's formula.

#theorem(title: [Euler's Formula], [
  For any real number $t$ we have: #h(1fr) $ e^(i t) = cos(t) + i sin(t) $
])

Using Euler's formula, we can rewrite the solutions from @eq:first_solution and @eq:second_solution as
$
  arrow(r)_1(t) =mat(-i; 2) e^(2 i t) & = mat(-i; 2) (cos(2 t) + i sin(2 t))                     \
                                      & =mat(sin(2 t); 2 cos(2 t))+ i mat(-cos(2 t); 2 sin(2 t))
$
and
$
  arrow(r)_2(t) = mat(i; 2) e^(-2 i t) & = mat(i; 2) (cos(-2 t) + i sin(-2 t))                   \
                                       & = mat(i; 2) (cos(2 t) - i sin(2 t))                     \
                                       & =mat(sin(2t); 2cos(2t)) + i mat(cos(2 t); -2 sin(2 t)).
$

Thus, the general solution from @eq:complex_general_solution can be rewritten as
$
  arrow(r)(t) = A arrow(r)_1(t) + B arrow(r)_2(t) & = A ( mat(sin(2 t); 2 cos(2 t))+ i mat(-cos(2 t); 2 sin(2 t))) +B(mat(sin(2t); 2cos(2t)) + i mat(cos(2 t); -2 sin(2 t))) \
  & = (A+B)mat(sin(2 t); 2 cos(2 t)) + i (A - B) mat(-cos(2 t); 2 sin(2 t))
$
where $A$ and $B$ are parameters. Since we are allowed to pick $A$ and $B$ to be any value we like, we can try to pick $A$ and $B$
so that the resulting solution is real.

There are many options, but one such choice is $A=1/2$ and $B=1/2$, which gives
$
  arrow(r)_3 (t) = (inline(1/2 + 1/2)) mat(sin(2 t); 2 cos(2 t)) + i (inline(1/2 - 1/2)) mat(-cos(2 t); 2 sin(2 t)) & = mat(sin(2 t); 2 cos(2 t)).
$
Alternatively, picking $A=-i/2$ and $B=i/2$ gives
$
  arrow(r)_4 (t) = (inline(-i/2 + i/2)) mat(sin(2 t); 2 cos(2 t)) + i (inline(-i/2 - i/2)) mat(-cos(2 t); 2 sin(2 t)) & = mat(-cos(2 t); 2 sin(2 t)).
$
Since we have two linearly-independent solutions, we can write the general solution as
$
  arrow(r)(t) = P arrow(r)_3(t) + Q arrow(r)_4(t) & = P mat(-cos(2 t); 2 sin(2 t)) + Q mat(cos(2 t); -2 sin(2 t))
$
where $P$ and $Q$ are parameters. Here, *as long as we pick $P$ and $Q$ to be real numbers, the result will be a real solution*.

=== Other Methods to Find Real Solutions

In the previous section, we exploited the general _complex_ solution to find the general real solution. Specifically, we
carefully chose the parameters in the general complex solution to find two linearly independent real solutions. Then, we took
(real) linear combinations of these two real solutions to find the general real solution. _This method always works_.#footnote[That is, it works so long as
  there is a real solution] However, it is sometimes possible to save some time by using guess-and-check.

Consider again the general complex solution. After @eq:complex_general_solution is expanded using Euler's formula, we have
$
  arrow(r)(t)
  = (A+B)mat(sin(2 t); 2 cos(2 t)) + i (A - B) mat(-cos(2 t); 2 sin(2 t)).
$
We can then take the real and imaginary parts of this solution:
$
  arrow(r)_"real" (t) = (A+B)mat(sin(2 t); 2 cos(2 t)) wide "and" wide
  arrow(r)_"imag" (t) = (A - B) mat(-cos(2 t); 2 sin(2 t)).
$
Testing by differentiating, we can verify that $arrow(r)_"real"$ and $arrow(r)_"imag"$
are both real solutions to the original system. Further,  $arrow(r)_"real"$ and $arrow(r)_"imag"$
are linearly independent (so long as $A,B != 0$), so we can find the general real via linear combinations
of $arrow(r)_"real"$ and $arrow(r)_"imag"$.

Guessing-and-checking by examining the real and imaginary parts of a complex solution will often save you time---remember, all you need
to write down a general real solution is the correct number of linearly independent real solutions.

#example(
  prompt: [Find the general real solution to
    $
      (dif x) / (dif t) & = 0.11 y \
      (dif y) / (dif t) & = - 11 x
    $
    and the solution to the initial value problem $x(0) = 1$ and $y(0) = -1$.],
  [

    By rewriting the system in matrix form and using eigenvalues and eigenvectors, we find a general complex solution
    $
      arrow(r)(t) = A mat(-i/10; 1) e^(1.1 i t) + B mat(i/10; 1) e^(-1.1 i t).
    $
    Expanding with Euler's formula gives
    $
      arrow(r)(t) & = A mat(-i/10; 1) (cos(1.1 t) + i sin(1.1 t)) + B mat(i/10; 1) (cos(-1.1 t) + i sin(-1.1 t)) \
                  & = A mat(-i/10; 1) (cos(1.1 t) + i sin(1.1 t)) + B mat(i/10; 1) (cos(1.1 t) - i sin(1.1 t))   \
                  & = (A + B) mat(sin(1.1 t)/10; cos(1.1 t)) + i (A - B) mat(-cos(1.1 t)/10; sin(1.1 t)).
    $

    Picking $A=1/2$, $B=1/2$ and $A=-i/2$, $B=i/2$ gives us two linearly independent real solutions
    $
      arrow(r)_1(t) = mat(sin(1.1 t)/10; cos(1.1 t)) wide "and" wide
      arrow(r)_2(t) = mat(-cos(1.1 t)/10; sin(1.1 t)),
    $
    thus the general real solution is
    $
      arrow(r)(t) = P arrow(r)_1 (t) + Q arrow(r)_2 (t)
      = P mat(sin(1.1 t)/10; cos(1.1 t)) + Q mat(-cos(1.1 t)/10; sin(1.1 t))
    $
    where $P$ and $Q$ are real parameters.

    #v(1em)

    To solve the initial value problem, we need to find values of $P$ and $Q$ such that
    $
      arrow(r)(0) = P mat(0; 1) + Q mat(-1/10; 0) = mat(1; -1).
    $
    With some linear algebra, we find that $P = -1$ and $Q = -10$. Thus, the solution to the initial value problem is
    $
      arrow(r)(t) = -1 mat(sin(1.1 t)/10; cos(1.1 t)) - 10 mat(-cos(1.1 t)/10; sin(1.1 t))
      = mat(
        -sin(1.1 t)/10 + cos(1.1 t); \
        cos(1.1 t) - 10 sin(1.1 t)
      ).
    $
  ],
)


=== Stability of the Equilibrium Solutions

As we have seen in @mod:real, the stability of equilibrium solutions of a matrix/affine system
is determined by the eigenvalues of the coefficient matrix.

We previously only considered real eigenvalues. But, the case 
is similar when the eigenvalues are complex. Specifically, the stability of the equilibrium solutions
is determined by the _real part of the eigenvalues_.

Consider the matrix differential equation
$ (dif arrow(r)) / (dif t) = M arrow(r), $
where $M$ is a $2 times 2$ matrix with eigenvalues $lambda_1 = a + i b$ and $lambda_2 = a - i b$.

First, observe that the unique equilibrium solution is $arrow(r)(t) = mat(0; 0)$, so we want to establish the stability of this equilibrium solution.

Following the process described earlier in this module, we know that the solutions of the system of differential equations will have the form
$
  arrow(r)_i (t)
  = arrow(v)_i e^(lambda_i t)
  = arrow(v)_i e^(a t) e^(i b t)
  = arrow(v)_i e^(a t) (cos(b t) + i sin(b t)),
$
where $arrow(v)_i$ is the eigenvector associated with the eigenvalue $lambda_i$.

We can now study what will happen to the solutions as $t$ approaches infinity, by focusing on each term of the solution
$
  arrow(r)_i (t)
  = arrow(v)_i e^(a t) (cos(b t) + i sin(b t)).
$

The first term $arrow(v)_i$ is a constant vector, so it will not affect the stability of the equilibrium solution.

The third term $cos(b t) + i sin(a t)$ is a periodic function, so it will not affect the stability of the equilibrium solution either.

The only term that can affect the stability of the equilibrium solution is the second term $e^(a t)$.

- If $a < 0$, then $e^(a t)$ will approach 0 as $t$ approaches infinity, and the equilibrium solution will be _stable_ and _attracting_.

- If $a > 0$, then $e^(a t)$ will approach infinity as $t$ approaches infinity, and the equilibrium solution will be _unstable_ and _repelling_.

- If $a = 0$, then $e^(a t)$ will be equal to 1 for all $t$, and the equilibrium solution will be _stable_ but neither attracting nor repelling.


=== Summary // of Stability of Equilibrium Solutions

Below we combine all the results obtained in the last modules about the stability of equilibrium solutions of systems of differential equations with constant coefficients.

Consider the following system of differential equations
$ (dif arrow(r)) / (dif t) = M arrow(r) + arrow(b), $
where the eigenvalues of the coefficient matrix $M$ are $lambda_1$ and $lambda_2$.
The stability of the equilibrium solution $arrow(r)(t) = - M^(-1) arrow(b)$ is determined by the eigenvalues of the coefficient matrix $M$.

#align(center, simple_table(
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
    // complex, both negative real part
    $lambda_1 = a + i b, a<0$,
    $lambda_2 = a - i b, a<0$,
    [Stable and Attracting],
    // complex, both positive real part
    $lambda_1 = a + i b, a>0$,
    $lambda_2 = a - i b, a>0$,
    [Unstable and Repelling],
    // complex, zero real part
    $lambda_1 = i b$,
    $lambda_2 = - i b$,
    [Stable],
  ),
))

OR

#align(center, simple_table(
  headers: ([Real/Complex], [Sign of Eigenvalues], [Stability of Equilibrium]),
  content: (
    // real, both negative
    [Real],
    [Both negative],
    [Stable and Attracting],
    // real, both positive
    [Real],
    [Both positive],
    [Unstable and Repelling],
    // real, one positive, one negative
    [Real],
    [One negative, one positive],
    [Unstable and Repelling],
    table.hline(stroke: .5pt),
    // real, 0 + negative
    [Real],
    [One is zero, one is negative],
    [Stable],
    // real, 0 + positive
    [Real],
    [One is zero, one is positive],
    [Unstable],
    table.hline(stroke: .5pt),
    // complex, both negative real part
    [Complex],
    [Real parts negative],
    [Stable and Attracting],
    // complex, both positive real part
    [Complex],
    [Real parts positive],
    [Unstable and Repelling],
    // complex, zero real part
    [Complex],
    [Real parts zero],
    [Stable],
  ),
))

XXX CHOOSE ONE TABLE!!












