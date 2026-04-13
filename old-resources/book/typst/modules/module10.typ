
// This file is meant to be imported and not compiled on its own.
#import "../common/settings-book.typ": show_def, workbook
#import "../libs/_workbook.typ": label_module, simple_table
// #import "../libs/_graphics.typ": vector_field
#import "../libs/_ode_solvers.typ": solve_2d_ivp
// #import "@preview/tiptoe:0.3.1"
// #import "@preview/lilaq:0.4.0" as lq
#let (sans, serif, module, definition, example) = workbook

#label_module(<mod:higher_order>)

In this module you will learn
- How to transform a higher order differential equation into a system of first order differential
  equations.
- How to analyze the stability of a higher order differential equation using eigenvalues and
  eigenvectors.
- How to approximate solutions to higher order differential equations.



== Order of a Differential Equation

#show_def("orderdiffeq")

So far, we have primarily studied first order differential equations (and systems). It's time to
make the jump to higher order differential equations---i.e. differential equations involving more
than just the first derivative.

== Converting Higher Order to First Order Systems

Rather than introducing new techniques to study higher order differential equations, we will use a
trick to convert a higher-order equation into a system of first order differential equations.

Consider the differential equation $f''=-f$. We now define a new function $g$ by $g=f'$. Thus,
$g' = f''=0$. It follows that:

#v(-1em)
#align(center + horizon, stack(
  dir: ltr,
  spacing: 1em,
  $ f''=-f $,
  $ <==> $,
  $ g=f'\ g'=-f $,
  $ <==> $,
  $ f'=g\ g'=-f $,
))

We have detailed methods to study $display(cases(f'=g, g'=-f))$; applying those methods and then
extracting information about $f$ (the original function of interest) will give us all the
information we need about the differential equation $f''=-f$ and its solutions. Not only that, but
this method is fully general: any higher order differential equation can be converted into a system
of first order differential equations by introducing additional functions for each derivative that
appears.

#example(
  prompt: [Write the third order differential equation
    $ u'''(x) - tan(u''(x)) + 3sqrt(1 + (u'(x))^2) + sin(u''(x)) dot.c u(x) = e^x $
    as a system of first order differential equations.],
  [
    We introduce two new functions:
    - $v(x) = u'(x)$
    - $w(x) = u''(x)$
    Notice that $w(x) = u''(x)=v'(x)$ and that $w'(x) = u'''(x)$.

    Substituting, we obtain
    $
      w' - tan(w) + 3 sqrt(1 + v^2) + sin(w) dot.c u = e^x.
    $

    Thus the original third order differential equation is equivalent to
    $
      cases(
        u' & = v,
        v' & = w,
        w' & = tan(w) - 3 sqrt(1 + v^2) - sin(w) dot.c u + e^x
      )
    $
  ],
)

== Solutions to higher order equations

Recall our example $f''=-f$, which is equivalent to the system $display(cases(f'&=g, g'&=-f))$.
Using the techniques we have learned for systems, we can find a general solution:
$
  f(t) & = A cos(t) + B sin(t) \
  g(t) & = A (-sin(t)) + B cos(t)
$
where $A$ and $B$ are parameters. Since the original differential equation was only about $f$, to
solve $f''=-f$, we throw away the solution for $g$, keeping only the solution for $f$. Thus, the
general solution to $f''=-f$ is
$
  f(t) = A cos(t) + B sin(t)
$
where $A$ and $B$ are parameters.

Notice that the general solution to $f''=-f$ has two parameters, whereas the general solution for a
single first-order differential equation typically has one parameter. This can be explained in two
ways:

1. To convert an equation $y^((n)) + ... = ...$ into a system of first-order equations, we introduce
  functions $f_1$, $f_2$, ..., $f_(n-1)$, one for each derivative of $y$ up to the $(n-1)^"st"$.
  Thus, we have a system of $n$ first-order equations, the solutions of which should have $n$
  parameters.
2. To solve an initial value problem for a higher-order differential equation $y^((n)) + ... = ...$,
  we need values for $y(0)$, $y'(0)$, ..., $y^(n-1)(0)$. That is, we need $n$-tuples of initial
  conditions to specify an initial value problem. Thus, in order to be able to solve initial value
  problems for an $n^"th"$ order differential equations, we expect the general solution to have $n$
  parameters.

==== Simulating solutions to higher order equations

To simulate a solution to a higher order differential equation, we first convert it to a system of
first-order differential equations and then use Euler's method. Finally, we ignore the simulated
coordinates for all but our function of interest.

#example(
  prompt: [Simulate the solution to the initial value problem
    $ f'' = -f $
    with initial conditions $f(0)=1$ and $f'(0)=0$.
  ],
  [
    We first convert the second-order differential equation into a system of first-order
    differential equations:
    $
      f' = g \
      g' = -f
    $

    Simulating with initial conditions $f(0)=1$ and $f'(0)=g(0)=0$ and a step size of $Delta = 0.1$
    gives us
    #let F(x, y) = (y, -x)
    #let sims = solve_2d_ivp(F, (1, 0), 6, Delta: 0.1)
    #let table = range(6).map(i => (i * .1, sims.at(i))).flatten()

    #align(center, simple_table(headers: ($t$, $f(t)$, $g(t)=f'(t)$), content: table.map(
      v => [#calc.round(
          v,
          digits: 2,
        )
      ],
    )))

    To get the simulated values for $f$, we take only the first two columns of the table, ignoring
    the $g(t)=f'(t)$ column.
  ],
)

=== Equilibrium solutions and stability for higher order differential equations

For a higher-order differential equation, the definition of an equilibrium solution is unchanged. It
is still _a solution that is constant_. What changes slightly is what it means to be "stable" or
"unstable".

Consider $f''=-f$. The only constant solution to this differential equation is $f(t)=0$. But, what
does it mean for a function $h$ to pass "close to" $f(0)=0$? In the case of first-order equations,
this meant that $h(0) approx f(0)$. For higher-order equations, we take the definition to mean that
$h$ and all its lower-order derivatives are close to $f$ and its lower-order derivatives. In this
case, that means
$
  h(0) approx f(0) wide "and" wide h'(0) approx f'(0).
$

Combining this with our method for rewriting a higher-order equation in terms of a system of
first-order equations we arrive at the following fact:
#quote(
  block: true,
)[The stability of the equilibrium solution to a higher-order differential equation is the same as
  the stability of the corresponding equilibrium solution to the system of first-order differential
  equations associated with the higher-order differential equation.]

#example(
  prompt: [What is the nature of the equilibrium solution to $f'' = -f$?],
  [
    Rewriting the higher-order equation as a system
    $
      f' = g \
      g' = -f
    $
    we can solve to find that $mat(f(t); g(t))=arrow(0)$ is the only equilibrium solution. Using
    eigenvalues, we classify this equilibrium solution as stable and not attracting.

    Applying this to $f''=-f$, we conclude that there is exactly one equilibrium solution, $f(t)=0$,
    and it is stable but not attracting.
  ],
)
