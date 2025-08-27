#import "../libs/_graphics.typ": slope_field
#import "../libs/_workbook.typ": label_module, simple_table
#import "../libs/_ode_solvers.typ": solve_2d_ivp
#import "../libs/_spreadsheet.typ": draw_spreadsheet
#import "@preview/lilaq:0.2.0" as lq
#import "@preview/tiptoe:0.3.0"

#let f1(A,B)=(calc.sin(B), A - B)
#let path1 = solve_2d_ivp(f1, (0.0, 5.0), 600, Delta: .1, method: "rk4")
#let pi_axis = ("0", $"\u{03C0}"/2$, "\u{03C0}", $(3"\u{03C0}")/2$)

#let questions = (
  (
    statement: [
      Find and classify the equilibrium points to the following equations: 
      + $x'=x^2$
      + $x'=sin(x)$
      + $x'=(x-1)(x-2)x^2$
      + $x'=e^(-x)$
    ],
    solution: [
      + Way 1 is good
      + Way 2 is better
    ],
    citation: [Notes on Diffy Q's by Jiří Lebl Chapter 1.6]
  ),
  (
    statement: [
      Assume that a population of fish in a lake satisfies $"dx"/"dt"="𝑘𝑥"(𝑀−𝑥)$. Now
suppose that fish are continually added at $𝐴$ fish per unit of time.
    + Find the differential equation for $x$.
    + Find and classify the equilibrium point(s).
    + What is the new limiting population?
    ],
    solution: [
      Abc.
    ],
    citation: [Notes on Diffy Q's by Jiří Lebl Chapter 1.6]
  ),
  (
    statement: [
      Below is the phase space showing the path travelled by a bee when it ventured out of the hive this morning. Find and classify the equilibrium point, can you tell if the bee is attracted to a flower or running away from a predator?
      
    #align(center,
    lq.diagram(
    //legend: (position: bottom + right),
    title: [Phase Space],
    width: 4cm,
    range(4),
    //ylim: (-1, 5),
    //xlim: (-1, 5),
    lq.plot(path1.map(((x, y)) => x), path1.map(((x, y)) => y), mark: none, stroke: 1.5pt, color: red.darken(20%)),
    //lq.plot(As2, Bs2, mark: none, stroke: 1.5pt),
    //lq.plot(As3, Bs3, mark: none, stroke: 1.5pt),
    //xaxis: (label: [$X(t)$], tick-distance: calc.pi),
    xaxis: (label: [$S(t)$],
    ticks: pi_axis.map(rotate.with(0deg, reflow: false)).enumerate(),
    subticks: none),
    yaxis: (label: [$D(t)$], tick-distance: 1),
    ),
  )
    ],
    solution: [
      + Way 1 is good
      + Way 2 is better
    ]
  ),
  (
    statement: [
      Suppose $x'$ is positive for $0<x<1$, it is zero when $x=0$ and $x=1$, and it is negative for all other values of $x$. 
      
      + Find and classify the equilibrium points.
      + Use Euler's method to find the $lim_(t-> \u{221E})x(t)$ with the initial condition $x(0)=1$. What does this say about the stability of the equilibrium point?
      + Repeat part (b) with the initial condition $x(0)=0.5$.
    ],
    solution: [
      The answer to the second question.
    ],
    citation: [Notes on Diffy Q's by Jiří Lebl Chapter 1.6]
  ),
  (
    statement: [
      A fifth question.
    ],
  )
)