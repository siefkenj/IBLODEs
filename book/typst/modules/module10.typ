
// This file is meant to be imported and not compiled on its own.
#import "../common/settings-book.typ": workbook, show_def
#import "../libs/_workbook.typ": label_module, simple_table
// #import "../libs/_graphics.typ": vector_field
// #import "../libs/_ode_solvers.typ": solve_2d_ivp
// #import "@preview/tiptoe:0.3.0"
// #import "@preview/lilaq:0.3.0" as lq
#let (sans, serif, module, definition, example) = workbook

#label_module(<mod:higher_order>)

In this module you will learn
- How to use transform a higher order differential equation into a first order system of differential equations
- How to analyze the stability of a higher order differential equation using eigenvalues and eigenvectors
- How to approximate solutions to higher order differential equations using numerical methods



=== Order of a differential equation

#show_def("orderdiffeq")

Up to this module, we only studied first order differential equations (and systems). 

In this module, we are going  to study higher order differential equations, which are differential equations that involve derivatives of order greater than one.

=== Transforming a higher order differential equation into a first order system of differential equations

When studying a higher order differential equation, we can rewrite it as an equivalent system of first order differential equations by introducing an auxiliary variable for each of the derivatives (except the highest one).

#example(
  prompt: [Write the third order differential equation 
  $ u'''(x) - tan(u''(x)) + 3sqrt(1 + (u'(x))^2) + sin(u''(x)) dot.c u(x) = e^x $
  as a system of first order differential equations.],
  [
    We introduce a new variable for each derivative (except the highest one):
    - $v(x) = u'(x)$;
    - $w(x) = v'(x)$, and notice that $w(x) = u''(x)$, so $w'(x) = u'''(x)$.
    
    We can then write the differential equation using these variables and their derivatives of order at most one:
    $ w' - tan(w) + 3 sqrt(1 + v^2) + sin(w) dot.c u = e^x $

    Thus the original third order differential equation is equivalent to
    $ cases(
        u' &= v,
        v' &= w,
        w' &= tan(w) - 3 sqrt(1 + v^2) - sin(w) dot.c u + e^x
      ) $
  ]
)

This means that all the machinery that we developed in the previous modules for systems of differential equations applies directly to higher-order differential equations.


=== Equilibrium solutions for higher order differential equations

The definition of _equilibrium solution_ remains the same, which means that an equilibrium solution will satisfy
$ u(x) &equiv C\ 
  u'(x) &equiv 0\
  u''(x) &equiv 0\
  dots.v $
for some constant $C$.

So when we transform a higher order differential equation into a system, the equilibrium becomes a vector with a very specific form
$ arrow(r) = mat(C; 0; 0; dots.v) $


=== Stability of equilibrium solutions of a higher order differential equation

Recall the definitions introduced in @mod:equilibrium.

To study the stability, we transform the equation into a system and study its eigenvalues according to the table at the end of @mod:complex.

#example(
  prompt: [What is the stability of the equilibrium solutions of the differential equation $u''(x) = -u(x)$?],
  [
    The first step is to find the equilibrium solution which has zero derivatives, so it satisfies
    $ 0 = - u $
    and so it has one equilibrium solution $u(x)=0$.
  
    
    The second step is to introduce an auxiliary variable
    - $v(x) = u'(x)$

    We can then write the differential equation as
    $ cases(
      u' &= v,
      v' &= -u
      )
    $

    We introduce a new variable $arrow(r)(x) = mat(u(x);v(x))$, and we can write the differential equation as a system in matrix form
    $ arrow(r)' = mat(0,1;-1,0) arrow(r) $

    This matrix has the eigenvalues $plus.minus i$, so we know that the equilibrium solution $arrow(r)=0$ is stable but not attracting nor repelling.

    Because the system is equivalent to the original differential equation, we can conclude that the equilibrium solution $u=0$ is also stable but neither attracting nor repelling.
  ]
)

=== Linearization of higher order differential equations

The linearization of a higher order differential equation is done in the same way as for first order differential equations, by transforming it into a system and then linearizing the system.

It is important to re-write the differential equation as a system of first order differential equations before linearizing it. It is easy to make mistakes if we try to linearize a higher order differential equation directly.


=== Numerical methods for higher order differential equations

Similarly to the study of the stability, we first transform the differential equation to its equivalent system of first order different equations, and then we can apply any numerical method, like Euler's Method introduced in @mod:simulation to simulate its solutions.


