#import "../libs/_workbook.typ": aligned_terms, simple_table
#import "../libs/_ode_solvers.typ": solve_2d_ivp
#import "@preview/lilaq:0.2.0" as lq
#import "@preview/tiptoe:0.3.0"



// This file is meant to be imported and not compiled on its own.
#import "../common/settings-book.typ": workbook, show_def
#let (sans, serif, module, definition, example) = workbook



In this module you will learn
- How to build models using systems of differential equations.
- How to approximate solutions to systems of differential equations.



== Modelling

In the previous two modules we have seen how to build models using differential equations by estimating how a quantity changes. 

In reality, we usually find a system of interrelated quantities changing. For example, in the previous module we saw how to model the growth of a population of ants. Several species of ants farm aphids, which are small insects that suck the sap from plants. The ants protect the aphids from predators and in return the aphids secrete a sugary substance called honeydew, which the ants eat. The population of ants and the population of aphids are symbiotically interrelated, as the growth of one population depends on the other.

We can then create a system of differential equations to model the growth of both populations. 

$ dif / (dif t) ("# ants at minute " t) 
    &= a ("# ants at minute " t ) + b ("# aphids at time " t) \
  dif / (dif t) ("# aphids at minute " t)
    &= c ("# ants at minute " t ) - d ("# aphids at time " t) $

The first equation models the growth of the ant population. The first term with parameter $a$ models the natural growth of ants in the absence of aphids. The second term with parameter $b$ models the growth of the ant population due to the presence of aphids -- this term provides a "boost" to the growth of the ant population since the presence of aphids will mean more food is available for the ants.

The second equation models the growth of the aphid population. The first term with parameter $c$ models the growth of the aphid population due to the presence of ants -- this term has a positive effect to the growth of the aphid population since they will be protected from predators. The second term with parameter $d$ models the natural death of aphids in the absence of ants due to the fact that predation will overwhelm their natural growth.

The parameters $a, b, c, d >= 0$ depend on the species of ants and aphids. As we discussed in MODULE 1, these constants can be estimated from data, but to do so, we need to be able to find the analytic solution to the system of differential equations. 
In MODULES 6, 7, 8 we will learn how to solve some types of systems of differential equations like this one, called linear systems of differential equations with constant coefficients.



== Simulation

Just like we did in MODULE 2 to simulate one differential equation, we use Euler's method to simulate a system of differential equations.

The method is the same as before, but now we have to keep track of two quantities at each step. We can do this by using a table to keep track of the values of the two populations at each time step.

As an example, consider $a=1, b=c=d=1/2$ and starting populations of $10$ (thousand) ants and $100$ (thousand) aphids. We can simulate the system of differential equations using Euler's method with a time step of $0.25$:

// #align(
//         center,
//         simple_table(
//           headers: ([Time], [\# Ants], [\# Aphids]),
//           content: (
//           [0], [10], [100],
//           [0.25], [25], [88.75],
//           [0.5], [42.344], [80.781],
//           [0.75], [63.027], [75.977],
//           [1], [88.281], [74.358],
//           [1.25], [119.646], [76.098],
//           ),
//         ),
//       )

#let a = 1
#let b = 0.5
#let c = 0.5
#let d = 0.5
#let F(x,y) = (a*x + b*y, c*x - d*y)
#let v_0 = (10, 100)
#let steps = 6
#let Delta = 0.25


// EULER'S METHOD while the solve_2d_ivp doesn't work!!
  #let v = v_0
  #let soln = (v,)
  #for i in range(steps) {
    let (x_0, y_0) = soln.at(-1)
    let (dx, dy) = F(x_0, y_0)
    let v = (x_0 + Delta * dx, y_0 + Delta * dy)
    soln.push(v)
  }

// #let soln = solve_2d_ivp(
//     F,
//     v_0,
//     5,
//     0.25,
//     method: "euler",
// )

#let times = range(0, steps + 1).map((i) => i * Delta)
#let ants = soln.map((v) => calc.round(v.at(0), digits: 3))
#let aphids = soln.map((v) => calc.round(v.at(1), digits: 3))

#let data = times.zip(ants, aphids)

#align(
  center,
  simple_table(
    headers: ([Time], [\# Ants], [\# Aphids]),
    content: 
    for row in data {(  
    ..for y in row {(
        [#y],
    )}
  )}
  ),
)

Below is a graph of the simulation created from the table above. The blue line represents the population (in thousands) of ants and the orange line represents the population (in thousands) of aphids. 


#align(
    center,
    lq.diagram(
      // xlim: (0, 1.6),
      // ylim: (-5, 125),
      width: 7cm,
      height: 4cm,
      yaxis: (position: 0, tip: tiptoe.stealth),
      xaxis: (position: 0, tip: tiptoe.stealth, ticks: times),
      xlabel: $t$,
      ylabel: lq.label([Populations\ (thousands)], angle: -90deg),
      legend: (position: bottom + right),
      lq.plot(
        times,
        ants,
        label: [Ants],
      ),
      lq.plot(
        times,
        aphids,
        label: [Aphids],
      ),
    ),
  )









