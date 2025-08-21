
// This file is meant to be imported and not compiled on its own.
#import "../common/settings-book.typ": show_def, workbook
#import "../libs/_workbook.typ": label_module, simple_table
// #import "../libs/_graphics.typ": vector_field
#import "../libs/_ode_solvers.typ": solve_2d_ivp
#import "@preview/lilaq:0.4.0" as lq
#import "@preview/tiptoe:0.3.1"

#let (sans, serif, module, definition, example) = workbook
#label_module(<mod:boundary_value_problems>)

In this module you will learn
- What a boundary value problem is.
- How to solve a boundary value problem.
- How to approximate the solutions of a boundary value problem.


== What is a Boundary Value Problem?

Consider the following two situations:

+ You place a cookie sheet in an oven with an initial temperature of $180 degree$. You'd like to
  study the temperature of the cookie sheet as it heats up in the oven.
+ You place a rod in the ground, deep into the permafrost. Because the permafrost never melts, one
  side of the rod is always at $0 degree$. The other end of the rod is $10 degree$. You'd like to
  study the temperature of the rod at different places along its length.

The first situation is one we're familiar with. It is modeled by an _initial value problem_. I.e.
differential equations coupled with a set of values each functions should take on at a specific
time/place/etc.

The second situation is different. It is modeled by a _boundary value problem_. Here, we specify the
values each functions should take on at _different_ times/places/etc.

// Consider the differential equation $u''(x) = -u(x)$. To specify an initial value problem, we might
// ask for a solution where $u(1) = 0, u'(1) = -1$. To specify a _boundary value problem_, we might ask
// for a solution where $u(1) = 0$ and $u'(2) = 0$.

== Solving a Boundary Value Problem

Typically a boundary value problem is higher order (since to uniquely specify a solution to a first
order differential equation, we usually only need one condition).

The setup is the same as for initial value problems. First, convert the higher order equation into a
system of first order equations. If you can find a general solution, you can try to solve for which
parameters in the general solution will satisfy the boundary conditions. If you cannot find a
general solution, you will simulate.



=== Simulating with the Shooting Method

We used Euler's method to simulate solutions to initial value problems. We worked forward (or
backward) in time from our initial conditions to find an approximate solution. Unfortunately, for
boundary value problems, this won't work. Since we don't have initial conditions, we don't know from
where to start approximating solutions!

To work around this shortcoming, we will use the _shooting method_.

Suppose you would like to solve the following boundary value problem with the shooting method.
$
  cases(
    u''(t) = - u(t),
    u(0) = 1,
    u(1) = 1
  )
$
The idea is as follows.
+ Take the smallest value $t$ that you have conditions for. In this case, $t=0$. Use this value and
  fill in guesses for the remaining values. In this case, we have $u(0)=1$ and we will use a guess
  for $u'(0)$.
+ Use Euler's method to simulate the solution until you reach the next value of $t$ for which you
  have a condition. In this case, we will simulate until $t=1$.
+ Test whether your simulation overestimates or underestimates the next value for which you have a
  condition.
+ Adjust your guess(es) for for the missing initial conditions, and note whether you get closer or
  further from your next condition.
+ Repeat until you find a solution that matches (or comes very close to) all of your boundary
  conditions.

#example(
  prompt: [Simulate a solution to the boundary value problem
    $
      cases(
        u''(x) = - 2 u'(x) - 2u(x),
        u(0) = 1,
        u(1) = 1
      )
    $
  ],
  [
    We first write this differential equation as a system
    $ arrow(r)' = mat(0, 1; -2, -2) arrow(r). $

    Our boundary condition at $x=0$ gives us the one part of an initial condition (i.e.,
    $u(0) = 1$). To be able to simulate the solution, we introduce a parameter to represent our
    guess for $u'(0)$. We use the guess $u'(0)=xi$. Therefore,
    $
      arrow(r)(0) = mat(1; xi).
    $

    Let us start with a guess of $xi = 0$. We can use Euler's method to simulate the solution of the
    system with $Delta =0.01$ and obtain
    $
      arrow(r)(1) approx mat(0.507; -0.623).
    $

    This means that the approximation of the solution at $x=1$ is $u(1) approx 0.507$.

    Since this is an underestimate of the desired condition $u(1)=1$, we will try a different value
    of $xi$.

    Below is a table of successive guesses for $xi$ and the corresponding values of $u(1)$.

    #align(
      center,
      simple_table(
        headers: ($xi$, $u(1)$),
        content: (
          $0$,
          $0.507$,
          $1$,
          $0.818$,
          $2$,
          $1.130$,
          $1.5$,
          $0.974$,
          $1.75$,
          $1.052$,
          $1.625$,
          $1.013$,
          $1.5625$,
          $0.994$,
        ),
      ),
    )

    You can see that by the $6^"th"$ guess, we are quite close to the desired condition $u(1)=1$.


    Once we are happy with the approximation, we can sketch the solution we found. Below is the
    graph for the simulation with $xi = 1.5625$.

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

  ],
)



=== Limitations of Boundary Value Problems

Whereas initial value problems usually have solutions, boundary value problems often do not. For
example, consider
$
  cases(y'=-y, y(0)=1, y(1)=2).
$
Given these conditions, we know that $y'(0) = -1$,
$y'(1) = -2$, and $y' < 0$ whenever $y > 0$. Thus, a solution starting at $y(0)=1$ will start by
decreasing, and will not increase until/unless it passes below the $x$-axis. This is incompatible
with $y(1)=2$. Therefore, $y'=-y$ with $y(0)=1$ and $y(1)=2$ has no solution.

The situation is even worse than it first appears because, although there are general theorems for
the existence of solutions to initial value problems, there are no known general theorems for the
existence of solutions to boundary value problems. Don't let that stop you from exploring, though!
Many models of the real world lend themselves to boundary value problems.

