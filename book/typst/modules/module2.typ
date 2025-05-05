#import "../libs/_graphics.typ": slope_field
#import "../libs/_ode_solvers.typ": solve_1d_ivp
#import "@preview/lilaq:0.2.0" as lq
#import "@preview/tiptoe:0.3.0"

// This file is meant to be imported and not compiled on its own.
#import "../common/settings-book.typ": workbook, show_def
#let (sans, serif, module, definition, example) = workbook

In this module you will learn
- How to use slope fields and Euler's method to approximate solutions to differential equations.

Most differential equations do not have _elementary_ solutions. That is, solutions which can be written in
terms of polynomials, exponentials, logarithms, etc..
Put another way: most differential equations do not have "nice" solutions. However, most ordinary differential equations
that you will encounter _will have solutions_ (even though you cannot write them down in terms of other functions you know).

There are two approaches when a differential equation cannot be explicitly "solved":
1. Make up a new name for a function _defined_ to be the solution to the differential equation.
2. Approximate the solution.

Before the days of computers, approach 1 was commonplace. If you've heard of Bessel functions or Airy functions, these are functions defined to be the solutions
to particular differential equations.#footnote[Even the humble exponential is often defined to be the solution to $f'(t)=f(t)$ which satisfies $f(0)=1$.]

In this course, we will focus on approach 2.

== Visual Estimation

Suppose that $P(t)$ models the number of bacteria (in billions) in a petri dish at time $t$. Further, suppose that the bacteria are so numerous that
it makes sense to think of $P(t)$ as continuous and that $P$ satisfies
// The F below makes a reasonable picture, but it is complicated. An alternative is
//#let F(x, y) =  -y + 1/2
// but maybe that is too simple?
#let F(x, y) = calc.sin(calc.pi/2 * y - x) - 1.5
#let y_0 = 3
#let approx_val = (
  solve_1d_ivp(
    F,
    (
      0,
      y_0,
    ),
    100,
    Delta: 0.01,
    method: "rk4",
  )
    .last()
    .at(1)
)
#let approx_rounded = calc.round(approx_val, digits: 1)
#let formula = $sin(space.hair pi/2 dot P(t) - t space.hair) - 1.5$
$
  P'(t) = formula wide "and" wide P(0) = #(y_0).
$
Our task is to approximate $P(1)$.

We may not know exactly what our solution curve is, but the differential equation tells us what tangent lines
to the solution curve look like. It stands to reason that if we
draw little segments of tangent lines all over the $(t,P)$--plane, we can visually guess at the shape of the solution curve.

#{
  align(
    center,
    slope_field(
      F,
      xlim: (-.3, 1.1),
      ylim: (-.3, 3.3),
      width: 7cm,
      height: 3cm,
      spacing: (.06, .25),
      scale_segments: .05,
      yaxis: (position: 0, tip: tiptoe.stealth, filter: ((v, d) => calc.round(v, digits: 2) in (1., 2., 3.))),
      xaxis: (position: 0, tip: tiptoe.stealth, filter: ((v, d) => calc.round(v, digits: 2) in (0, 1.))),
      xlabel: $t$,
      ylabel: lq.label($P$, dx: -1cm),
    ),
  )
}

The above diagram, where small segments of tangent lines to solutions populate the plane, is called a _slope field_.

#show_def("slope_field")

Starting at $(t,P(t)) = (0,#(y_0))$, we can trace out what an approximate solution curve looks like.

#{
  let soln = solve_1d_ivp(
    F,
    (
      0,
      y_0,
    ),
    20,
    Delta: 0.05,
    method: "rk4",
  )
  let xs = soln.map(((x, y)) => x)
  let ys = soln.map(((x, y)) => y)

  align(
    center,
    slope_field(
      F,
      xlim: (-.3, 1.1),
      ylim: (-.3, 3.3),
      width: 7cm,
      height: 3cm,
      spacing: (.06, .25),
      scale_segments: .05,
      // yaxis: (position: 0, tip: tiptoe.stealth, filter: ((v, d) => false)),
      yaxis: (position: 0, tip: tiptoe.stealth, filter: ((v, d) => calc.round(v, digits: 2) in (1., 2., 3.))),
      xaxis: (position: 0, tip: tiptoe.stealth, filter: ((v, d) => calc.round(v, digits: 2) in (0, 1.))),
      xlabel: $t$,
      ylabel: lq.label($P$, dx: -1cm),
      lq.plot(
        xs,
        ys,
        mark: none,
        stroke: (paint: gray.darken(20%), thickness: 1pt, dash: (2pt, .5pt)),
      ),
    ),
  )
}

The solution curve we draw should be tangent to every slope segment it passes through. In the drawing above, the solution curve is increasing
and slightly concave down. Based on the drawing, we can estimate $P(1) approx #(approx_rounded)$.

Tracing out solutions on slope fields is a good way to see overall qualities of a solution, like whether it is increasing/decreasing or its concavity.
But, its numerical accuracy is limited. A small change in how we sketched the curve could lead to estimates
that $P(1) approx #(calc.round(approx_rounded -.2, digits: 1))$ or $P(1) approx #(approx_rounded+.2)$,
a wide range. If we're after precise numerical estimates, we can formalize this "slope field estimation" by means of Euler's method.



== Euler's Method

Recall that $P(t)$ models the number of bacteria (in billions) in a petri dish at time $t$ with
$
  P'(t) = formula quad quad "and" quad quad P(0) = #(y_0).
$

Our task is to numerically approximate $P(1)$.

A simple approach would be to approximate $P(1)$ using a tangent line through the point $(0, P(0))$. We know the slope $P'(0)= P(0)=#(F(0,y_0))$, and
so we get an approximation of $P(0) + P'(0)(t-0)lr(|, size: #(0pt + 150%))_(t=1)=#(y_0+F(0,y_0))$.

#let (soln_xs, soln_ys) = {
  let soln = solve_1d_ivp(
    F,
    (
      0,
      y_0,
    ),
    20,
    Delta: 0.05,
    method: "rk4",
  )
  let xs = soln.map(((x, y)) => x)
  let ys = soln.map(((x, y)) => y)
  (xs, ys)
}

#{
  let soln = solve_1d_ivp(
    F,
    (
      0,
      y_0,
    ),
    1,
    Delta: 1,
    method: "euler",
  )
  let xs = soln.map(((x, y)) => x)
  let ys = soln.map(((x, y)) => y)

  align(
    center,
    lq.diagram(
      xlim: (-.3, 1.1),
      ylim: (-.3, 3.3),
      width: 7cm,
      height: 3cm,
      yaxis: (position: 0, tip: tiptoe.stealth, filter: ((v, d) => false)),
      xaxis: (position: 0, tip: tiptoe.stealth, filter: ((v, d) => calc.round(v, digits: 2) in (0, 1.))),
      xlabel: $t$,
      ylabel: lq.label($P$, dx: -1cm),
      lq.plot(
        soln_xs,
        soln_ys,
        mark: none,
        stroke: (paint: gray.darken(20%), thickness: 1pt, dash: (2pt, .5pt)),
      ),
      lq.plot(
        xs,
        ys,
        //mark: "square",
        //stroke: (paint: gray.darken(20%), thickness: 1pt, dash: (2pt, .5pt)),
      ),
    ),
  )
}

XXX add error bars to figure.

Our approximation is an underestimate. How can we be more accurate? By using two tangent lines!

A tangent line is a good approximation to a function near the point of tangency. So, instead of approximating $P(1)$ using a tangent line at $t=0$, let's approximate $P(0.5)$ using a tangent line at $t=0$
and then approximate $P(1)$ using a tangent line at $t=0.5$.#footnote[Unfortunately, we don't know the exact value of $P(0.5)$, so we cannot use the _true_ tangent line to the solution curve at $t=0.5$.
But, we know an approximate value of $P(0.5)$. For now, we will assume this approximate value is close enough.]

#{
  let soln = solve_1d_ivp(
    F,
    (
      0,
      y_0,
    ),
    2,
    Delta: .5,
    method: "euler",
  )
  let xs = soln.map(((x, y)) => x)
  let ys = soln.map(((x, y)) => y)

  align(
    center,
    lq.diagram(
      xlim: (-.3, 1.1),
      ylim: (-.3, 3.3),
      width: 7cm,
      height: 3cm,
      yaxis: (position: 0, tip: tiptoe.stealth, filter: ((v, d) => false)),
      xaxis: (position: 0, tip: tiptoe.stealth, filter: ((v, d) => calc.round(v, digits: 2) in (0, 1.))),
      xlabel: $t$,
      ylabel: lq.label($P$, dx: -1cm),
      lq.plot(
        soln_xs,
        soln_ys,
        mark: none,
        stroke: (paint: gray.darken(20%), thickness: 1pt, dash: (2pt, .5pt)),
      ),
      lq.plot(
        xs,
        ys,
        //mark: "square",
        //stroke: (paint: gray.darken(20%), thickness: 1pt, dash: (2pt, .5pt)),
      ),
    ),
  )
}

Continuing, we can become more and more accurate. Here is a picture showing what happens if we use four tangent lines.

#{
  let soln = solve_1d_ivp(
    F,
    (
      0,
      y_0,
    ),
    4,
    Delta: .25,
    method: "euler",
  )
  let xs = soln.map(((x, y)) => x)
  let ys = soln.map(((x, y)) => y)

  align(
    center,
    lq.diagram(
      xlim: (-.3, 1.1),
      ylim: (-.3, 3.3),
      width: 7cm,
      height: 3cm,
      yaxis: (position: 0, tip: tiptoe.stealth, filter: ((v, d) => false)),
      xaxis: (position: 0, tip: tiptoe.stealth, filter: ((v, d) => calc.round(v, digits: 2) in (0, 1.))),
      xlabel: $t$,
      ylabel: lq.label($P$, dx: -1cm),
      lq.plot(
        soln_xs,
        soln_ys,
        mark: none,
        stroke: (paint: gray.darken(20%), thickness: 1pt, dash: (2pt, .5pt)),
      ),
      lq.plot(
        xs,
        ys,
        //mark: "square",
        //stroke: (paint: gray.darken(20%), thickness: 1pt, dash: (2pt, .5pt)),
      ),
    ),
  )
}

The process of using many tangent lines to iteratively approximate a solution to a differential equation is called
_Euler's method_, and the resulting approximation is called an _Euler approximation_.

#show_def("eulers_method")

When applying Euler's method, the big decision to make is how many tangent lines to use. This is often expressed in terms of a _step size_, typically
denoted by the letter $Delta$, where $Delta = "domain of approximation"/"# of tangent lines used"$.

== Implementing Euler's Method

XXX Table and fill in the table
Then move to Excel - automate process 



== Accuracy of Euler's Method

When using Euler's method, in general, the smaller the step size, the more accurate the approximation. And, when taking a limit towards an infinitely small step size,
the approximation converges to the exact solution.

XXX Figure showing Euler's method becoming more accurate with more steps

However, it's important to remember that Euler approximations are still approximations and can be misleading if not interpreted carefully.
For example, consider the initial value problem
$
  y' = -y^(1 / 5) quad quad "and" quad quad y(0) = 1.
$

By examining a slope field for this differential equation, we can see solutions that start positive, decrease to zero, and then stay at zero
(since $y'=0$ whenever $y=0$).

#let F = (x, y) => -y / calc.abs(y) * calc.pow(calc.abs(y), 1. / 5)
#{
  align(
    center,
    slope_field(
      F,
      xlim: (-.3, 3.1),
      ylim: (-3.3, 3.3),
      width: 7cm,
      height: 3cm,
      spacing: (.1, .5),
      scale_segments: .07,
      yaxis: (position: 0, tip: tiptoe.stealth, filter: ((v, d) => false)),
      xaxis: (position: 0, tip: tiptoe.stealth, filter: ((v, d) => false)),
    ),
  )
}

However, Euler approximations to this differential equation attain negative values. This is true no matter the step size.

#{
  align(
    center,
    {
      {
        let delta = .5
        let soln = solve_1d_ivp(
          F,
          (
            0,
            2,
          ),
          20,
          Delta: delta,
          method: "euler",
        )
        let xs = soln.map(((x, y)) => x)
        let ys = soln.map(((x, y)) => y)
        lq.diagram(
          xlim: (-.3, 4.1),
          ylim: (-2.3, 2.3),
          width: 4cm,
          height: 3cm,
          yaxis: (position: 0, tip: tiptoe.stealth, filter: ((v, d) => false), stroke: .3pt),
          xaxis: (position: 0, tip: tiptoe.stealth, filter: ((v, d) => false), stroke: .3pt),
          lq.plot(
            xs,
            ys,
            mark: none,
            //stroke: (paint: gray.darken(20%), thickness: 1pt, dash: (2pt, .5pt)),
          ),
          title: $Delta = #(delta)$,
        )
      }
      {
        let delta = .25
        let soln = solve_1d_ivp(
          F,
          (
            0,
            2,
          ),
          20,
          Delta: delta,
          method: "euler",
        )
        let xs = soln.map(((x, y)) => x)
        let ys = soln.map(((x, y)) => y)
        lq.diagram(
          xlim: (-.3, 4.1),
          ylim: (-2.3, 2.3),
          width: 4cm,
          height: 3cm,
          yaxis: (position: 0, tip: tiptoe.stealth, filter: ((v, d) => false), stroke: .3pt),
          xaxis: (position: 0, tip: tiptoe.stealth, filter: ((v, d) => false), stroke: .3pt),
          lq.plot(
            xs,
            ys,
            mark: none,
            //stroke: (paint: gray.darken(20%), thickness: 1pt, dash: (2pt, .5pt)),
          ),
          title: $Delta = #(delta)$,
        )
      }
      {
        let delta = .1
        let soln = solve_1d_ivp(
          F,
          (
            0,
            2,
          ),
          200,
          Delta: delta,
          method: "euler",
        )
        let xs = soln.map(((x, y)) => x)
        let ys = soln.map(((x, y)) => y)
        lq.diagram(
          xlim: (-.3, 4.1),
          ylim: (-2.3, 2.3),
          width: 4cm,
          height: 3cm,
          yaxis: (position: 0, tip: tiptoe.stealth, filter: ((v, d) => false), stroke: .3pt),
          xaxis: (position: 0, tip: tiptoe.stealth, filter: ((v, d) => false), stroke: .3pt),
          lq.plot(
            xs,
            ys,
            mark: none,
            //stroke: (paint: gray.darken(20%), thickness: 1pt, dash: (2pt, .5pt)),
          ),
          title: $Delta = #(delta)$,
        )
      }
    },
  )
}
