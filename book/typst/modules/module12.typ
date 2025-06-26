
// This file is meant to be imported and not compiled on its own.
#import "../common/settings-book.typ": workbook, show_def
#let (sans, serif, module, definition, example, theorem) = workbook
#import "../libs/_workbook.typ": label_module

#import "../libs/_graphics.typ": slope_field
#import "@preview/lilaq:0.2.0" as lq
#import "@preview/tiptoe:0.3.0"

#label_module(<mod:existence_uniqueness>)

This appendix is adapted from #link("https://www.jirka.org/diffyqs/")[Jiri Lebl's book "Notes on Diffy Qs"].



We wish to ask two fundamental questions about the problem
$ y' = f(x, y), quad y(x_0) = y_0. $

- Does a solution _exist_?
- Is the solution _unique_ (if it exists)?

What do you think is the answer?
The answer seems to be yes to both, does it not? Well, pretty much. But there are cases when the answer to either question can be no.

Since generally the equations we encounter in applications
come from real life situations, it seems
logical that a solution always exists.
It also has to be unique if we believe our
universe is deterministic. If the solution does not exist, or if it is
not unique, we have
probably not devised the correct model. Hence, it is good to know
when things go wrong and why.

#example(
  prompt: [
  Attempt to solve:

  $ y' = 1 / x, quad y(0) = 0. $
  ],
  [
  Integrate to find the general solution $y = ln abs(x) + C$. The
  solution does not exist at $x = 0$. See the figure below with teh slope field for this differential equation and some solutions.


  #{
    let F(x,y) = if x == 0 { float.inf } else {1 / x}
    let g(x,C) = if x == 0 { float.inf } else {calc.ln(calc.abs(x))+C}
    let xsm = lq.linspace(-3.01, -0.01, num: 30)
    let xsp = lq.linspace(0.01, 3.01, num: 30)
    let soln0 = xsm.map(x => g(x, 0))
    let soln1 = xsm.map(x => g(x, 3))
    let soln2 = xsp.map(x => g(x, 1))
    let soln3 = xsp.map(x => g(x, 2))
    let soln4 = xsp.map(x => g(x, -1))

    align(
      center,
      slope_field(
        F,
        xlim: (-3, 3),
        ylim: (-3, 3),
        width: 6cm,
        height: 6cm,
        spacing: (.2, .2),
        scale_segments: .125,
        slope_color: gray,
        yaxis: (position: 0, tip: tiptoe.stealth, filter: ((v, d) => calc.round(v, digits: 2) in (-3., -2., -1., 0, 1., 2., 3.))),
        xaxis: (position: 0, tip: tiptoe.stealth, filter: ((v, d) => calc.round(v, digits: 0) in (0, 1, 2, 3))),
        // xlabel: $x$,
        // ylabel: $y$,
        lq.plot(xsm,soln0, mark:none, stroke: (thickness: 1.5pt)),
        lq.plot(xsm,soln1, mark:none, stroke: (thickness: 1.5pt)),
        lq.plot(xsp,soln2, mark:none, stroke: (thickness: 1.5pt)),
        lq.plot(xsp,soln3, mark:none, stroke: (thickness: 1.5pt)),
        lq.plot(xsp,soln4, mark:none, stroke: (thickness: 1.5pt)),
      ),
    )
  }
  Observe how the slopes get more and more vertical as $x$ approaches 0.

  Moreover, the equation may have been written as the seemingly harmless $x y' = 1$.

  ]
)

#example(
  prompt: [
  Solve:
  $ y' = 2 sqrt(abs(y)), quad y(0) = 0. $],
  [

  See the figure below with the slope field for this differential equation and some solutions.

    #{
    let F(x,y) = 2 * calc.sqrt(calc.abs(y))
    let g(x) = if x < 0 { -x*x } else { x*x }
    let xs = lq.linspace(-3, 3, num: 60)
    let soln0 = xs.map(x => 0)
    let soln1 = xs.map(x => g(x))
    
    align(
      center,
      slope_field(
        F,
        xlim: (-3, 3),
        ylim: (-3, 3),
        width: 6cm,
        height: 6cm,
        spacing: (.2, .2),
        scale_segments: .125,
        slope_color: gray,
        yaxis: (position: 0, tip: tiptoe.stealth, filter: ((v, d) => calc.round(v, digits: 2) in (-3., -2., -1., 0, 1., 2., 3.))),
        xaxis: (position: 0, tip: tiptoe.stealth, filter: ((v, d) => calc.round(v, digits: 0) in (0, 1, 2, 3))),
        // xlabel: $x$,
        // ylabel: $y$,
        lq.plot(xs,soln0, mark:none, stroke: (thickness: 1.5pt)),
        lq.plot(xs,soln1, mark:none, stroke: (thickness: 1.5pt)),
      )
    )
  }

  Note that $y = 0$ is a solution. But another solution is the function

  $ y(x) = 
    cases(
      x^2 " if " x >= 0,
      -x^2 " if " x < 0,
    )
  $
  ]
)

It is hard to tell by staring at the slope field that the
solution is not
unique.
Is there any hope?
Of course there is. We have the following theorem,
known as Picard's theorem
// Named after the French mathematician
// Charles Émile Picard (1856--1941)

#theorem(
  title: [Picard's theorem on existence and uniqueness
  // existence and uniqueness
  // Picard's theorem
  ],
  [
  If $f(x, y)$ is continuous (as a function of two
  variables) and $(diff f) / (diff y)$ exists and is
  continuous near some $(x_0, y_0)$, then a solution to

  $ y' = f(x, y), quad y(x_0) = y_0, $

  exists (at least for $x$ in some small interval) and is unique.
]
)

Note that the problems $y' = 1 / x$, $y(0) = 0$ and 
$y' = 2 sqrt(abs(y))$, $y(0) = 0$ do not satisfy the hypothesis of the
theorem.
Even if we can use the theorem,
we ought to be careful about this existence business. It is quite
possible that the solution only exists for a short while.

#example(
  prompt:[
  For some constant $A$, solve:

  $ y' = y^2, quad y(0) = A. $],
  [
  We know how to solve this equation. First assume that $A != 0$,
  so $y$ is not equal to zero at least for some $x$ near 0. So
  $x' = 1 / y^2$, so
  $x = -1 / y + C$, so $y = 1 / (C - x)$. If $y(0) = A$, then
  $C = 1 / A$ so

  $ y = 1 / (1 / A - x). $

  If $A = 0$, then $y = 0$ is a solution.

  For example, when $A = 1$
  the solution "blows up" at $x = 1$. Hence, the solution does not exist
  for all $x$ even if the equation is nice everywhere. The equation
  $y' = y^2$ certainly
  looks nice.
  ]
)

For most of this
course we will be interested in equations where existence and
uniqueness holds, and in fact holds "globally" unlike for the equation
$y' = y^2$.
// But it is necessary to understand the examples where things fail for the
// aforementioned reasons.

