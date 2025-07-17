
// This file is meant to be imported and not compiled on its own.
#import "../common/settings-book.typ": workbook, show_def
#import "../libs/_workbook.typ": label_module, simple_table
// #import "../libs/_graphics.typ": vector_field
#import "../libs/_ode_solvers.typ": solve_2d_ivp
#import "@preview/lilaq:0.4.0" as lq
#import "@preview/tiptoe:0.3.1"

#let (sans, serif, module, definition, example) = workbook
#label_module(<mod:boundary_value_problems>)

In this module you will learn
- What is a boundary value problem
- How to solve a boundary value problem
- How to approximate the solutions of a boundary value problem


=== What is a boundary value problem?

Until now, we always studied differential equations with some initial conditions: conditions given all for the same value of the dependent variable. These are called _initial value problems_.

_Boundary value problems_ are composed by one or more differential equation and a set of conditions given at different values of the dependent variable.


#example(
  prompt: [ Consider the differential equation $u''(x) = -u(x)$ with the conditions below.
  Which of these are initial value problems and which are boundary value problems?],
  [
    + $u(0) = 0, u'(0) = -1$ is an initial value problem, because all the conditions are given for the same value of $x$, namely $x=0$.
    + $u'(100) = -2, u''(100) = 3$ is also an initial value problem, with the conditions given for the value $x=100$.
    + $u(1) = 0, u'(2) = 0$ is a boundary value problem, because the conditions are given for different values of $x$: one condition at $x=1$ and the other at $x=2$.
  ]
)


=== Solving a boundary value problem

Typically a boundary value problem is higher order, since for first order diffferential equations we only need one condition.

So the first step is usually to transform it into a system of differential equations. Then we can solve it using the methods outlined in previous modules.

Once we have a general solution, we find the arbitrary constants using the conditions. It is exactly the same process as the one to solve an initial value problem.


=== Existence and Uniqueness of solution

The Theorem introduced in @mod:real doesn't apply to this type of conditions. In fact, there is no general Theorem of Existence and Uniqueness of solutions for boundary value problems.



=== Simulating solutions using the shooting method


Euler's method requires a full set of initial conditions to start and simulate the solution of a differential equation, so it doesn't apply to a boundary value problem.

Instead, we need to modify it into what is known as a _shooting method_.

The idea of the _shooting method_ is the following:
+ Start with the boundary condition for the smallest value of $x=x_0$.
+ Introduce parameters $arrow(xi)$ for the remaining componentsnecessary to complete an initial condition at $x=x_0$.
+ Start with some value $arrow(xi)_0$, e.g. $arrow(xi)_0=arrow(0)$ and use Euler's method to simulate the solution until it reaches the other coundary condition at $x_1$.
+ Adjust the value of the parameter $arrow(xi)$ and simulate again.
+ Repeat until you find a solution that satisfies the boundary condition at $x_1$ or comes very close to it.

#example(
  prompt: [Simulate the solution of the boundary value problem 
  $ cases(
    u'' = - 2 u' - 2u,
    u(0) = 1,
    u(1) = 1
  ) $
  ],
  [
    We first write this differential equation as a system
    $ arrow(r)' = mat(0,1; -2, -2) arrow(r). $

    Our boundary condition at $x=0$, gives us the first component of an initial condition.
    To be able to simulate the solution, we need to introduce a parameter for the second component of the vector $arrow(r)$, so we write:
    $ arrow(r)(0) = mat(1; xi) $

    Let us start with $x_i = 0$. We can use Euler's method to simulate the solution of the system with $h=0.01$ and obtain
    $ arrow(r)(1) approx mat(0.507; -0.623) $

    This means that the approximation of the solution at $x=1$ is $u(1) approx 0.507$.

    Observe that we really only care about the first component of the vector $arrow(r)(x)$, which is the solution $u(x)$ of the original differential equation.

    Here is a table of the successive applications of the Euler's Method with different initial conditions and how close the solution is to the boundary condition at $x=1$:

    #align(
      center,
      simple_table(
        headers: ($xi$, $u(1)$),
        content: (
          $0$, $0.507$,
          $1$, $0.818$,
          $2$, $1.130$,
          $1.5$, $0.974$,
          $1.75$, $1.052$,
          $1.625$, $1.013$,
          $1.5625$, $0.994$
        ),
      ),
    )

    To adjust the value of $xi$, we started with an initial guess of $xi=0$ and increased it until we obtained two values of $u(1)$ that are on either side of the boundary condition $u(1)=1$. In this case, we found that $u(1) < 1$ for $xi=1$ and $u(1) > 1$ for $xi=2$. That means that the value of $xi$ we are looking for is between $1$ and $2$, so we successively bisected the interval $[1, 2]$ to find a better approximation of $xi$.

    There are lots of different methods to adjust the value of $xi$ to get closer to the boundary condition at $x=1$. Here we just used a simple bisection method, but you can use any method you like.


    We can see that the value of $u(1)$ is getting closer to the boundary condition $u(1)=1$ as we adjust the value of $xi$.

    Once we are happy with the approximation, we can sketch the solution we found. Below is the grpah for the simulation with $xi = 1.5625$.

    #{
      
      let F(x, y) = (y, -2 * x - 2 * y)
      let v_0 = (1, 1.5625)
      let _Delta = 0.01
      let steps = calc.ceil(1 / _Delta)

      let soln = solve_2d_ivp(F, v_0, steps, Delta: _Delta, method: "euler")

      let times = range(0, steps + 1).map(i => i * _Delta)
      let approx_sol = soln.map(v => calc.round(v.at(0), digits: 3))

      align(
        center,
        lq.diagram(
          // xlim: (0, 1.6),
          // ylim: (-5, 125),
          width: 7cm,
          height: 4cm,
          yaxis: (position: 0, tip: tiptoe.stealth),
          xaxis: (position: 0.975, tip: tiptoe.stealth),
          
          legend: (position: bottom + right),
          lq.plot(
            times,
            approx_sol,
            mark: none,
          ),
        ),
      )
    }


    // We solve it and find the general solution:
    // $ arrow(r)(x) = c_1 e^(-x) mat(sin(x) + cos(x); -2sin(x)) + c_2 e^(-x) mat(sin(x); cos(x) - sin(x)) $
    // where $c_1$ and $c_2$ are arbitrary constants.

    // We are only interested in the solution $u(x)$ of the original differential equation, so we take the first component of the vector $arrow(r)(x)$:
    // $ u(x) = c_1 e^(-x) (sin(x) + cos(x)) + c_2 e^(-x) sin(x) $

    // We now need to find the values of $c_1$ and $c_2$ that satisfy the boundary conditions.

    // We have the first condition $u(0) = 1$, which gives us:
    // $ u(0) = c_1 + c_2 = 1 $
    // The second condition is $u(pi/2) = 1$, which gives us:
    // $ u(pi/2) = c_1 e^(-pi/2) + c_2 e^(-pi/2) = 1 $
    // We can solve this system of equations to find the values of $c_1$ and $c_2$:
    // $ c_1 = 1 - c_2, quad c_2 = e^(pi/2) - 1 $
    // So the solution is:
    // $ u(x) = (1 - e^(pi/2) + 1)e^(-x) (sin(x) + cos(x)) + (e^(pi/2) - 1)e^(-x) sin(x) $

  ]
)


