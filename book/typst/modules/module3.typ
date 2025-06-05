#import "../libs/_workbook.typ": aligned_terms, simple_table, label_module
#import "../libs/_ode_solvers.typ": solve_2d_ivp
#import "@preview/lilaq:0.2.0" as lq
#import "@preview/tiptoe:0.3.0"

#label_module(<mod:systems>)

// This file is meant to be imported and not compiled on its own.
#import "../common/settings-book.typ": workbook, show_def
#let (sans, serif, module, definition, example) = workbook



In this module you will learn
- How to build models using systems of differential equations.
- How to approximate solutions to systems of differential equations.
- How to graph solutions to systems of differential equations in component space and phase space.



== Modelling

In the previous two modules, we have seen how to model a single quantity using a differential equation. But,
what happens when we have multiple interrelated quantities?

Enter the _Yellow Meadow Ant_.
The Yellow Meadow Ant is a species of _farming_ ant.
They tend to farms of aphids, which are small insects that suck the sap from plants. The ants protect the aphids from predators and in
return the aphids secrete a sugary substance called honeydew, which the ants eat. The population of ants and the population of
aphids are symbiotically interrelated, as the growth of one population depends on the other.

We can create a _system_ of differential equations to model the interrelated populations:

$
  dif / (dif t) ("# ants at minute " t)
  &= a ("# ants at minute " t ) + b ("# aphids at time " t) \
  dif / (dif t) ("# aphids at minute " t)
  &= c ("# ants at minute " t ) - d ("# aphids at time " t)
$

The first equation models the growth of the ant population,
with $a$ representing the natural growth of ants in the absence of aphids
and $b$ representing the growth of the ant population due to the presence of aphids
(this term provides a "boost" to the ant population since the presence of aphids will mean more food for the ants).

The second equation models the growth of the aphid population,
with $c$ representing the growth of the aphid population due to the presence of ants
(this term has a positive effect on the growth of aphids since they will be protected from predators),
and $d$ representing the natural death of aphids in the absence of ants (they will be eaten by other creatures if ants aren't around to protect them).

The parameters $a, b, c, d >= 0$ depend on the species of ants and aphids
and could be estimated from data. For now, we will use nice values of $a,b,c,d$, so the numbers don't
get in our way.
//As we discussed in @mod:modelling, these constants can be estimated from data, but to do so, we need to be able to find the analytic solution to the system of differential equations.
//In @mod:real[Modules], @mod:affine[], and @mod:complex[] we will learn how to solve some types of systems of differential equations like this one, called linear systems of differential equations with constant coefficients.



== Simulation

We will use a modified version of Euler's method (see @mod:simulation) to simulate solutions to a system of differential equations.
The change will be that we will use two tangent lines to estimate the next data point---one tangent line for ants and one for aphids.

For now, we will assume $a=1, b=c=d=1 / 2$ and that we start out with $10$ (thousand) ants and $100$ (thousand) aphids.
Using a time step of $Delta = 0.25$, we compute
$
  ("# Ants")'(0) &= 1 dot 10 + 1 / 2 dot 100 = 60 \
  ("# Aphids")'(0) &= 1 / 2 dot 10 - 1 / 2 dot 100 = -45
$

and so
$
  ("# Ants") (0.25) &approx 10 + 0.25 dot 60 = 25 \
  ("# Aphids") (0.25) &approx 100 + 0.25 dot (-45) = 88.75
$
#let t_max = 1.75
We can now repeat this processes at $t=0.25$ to find approximate values for the number of ants and aphids at $t=0.5$.
Repeating until $t=#(t_max)$, we arrive at the following table of values:

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
#let F(x, y) = (a * x + b * y, c * x - d * y)
#let v_0 = (10, 100)
#let _Delta = 0.25
#let steps = calc.ceil(t_max / _Delta)

#let soln = solve_2d_ivp(F, v_0, steps, Delta: _Delta, method: "euler")

#let times = range(0, steps + 1).map(i => i * _Delta)
#let ants = soln.map(v => calc.round(v.at(0), digits: 3))
#let aphids = soln.map(v => calc.round(v.at(1), digits: 3))

#let data = times.zip(ants, aphids)

#align(
  center,
  simple_table(
    headers: ([Time], [(approximate) \# Ants], [(approximate) \# Aphids]),
    content: for row in data {
      (
        ..for y in row {
          (
            [#y],
          )
        },
      )
    },
  ),
)

Below is a graph of the simulation created from the table above. The solid curve represents the population (in thousands) of ants and the dashed curve represents the population (in thousands) of aphids.

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
      stroke: (dash: (4pt, 2pt)),
    ),
  ),
)

#let _Delta2 = 0.05
Of course, if we wanted a more accurate simulation of the populations, we could use a smaller step size. Below is a graph
using a step size of $Delta = #(_Delta2)$ showing the new estimates (solid and dashed) along with the old estimates (dotted).

#let steps2 = calc.ceil(t_max / _Delta2)
#let soln2 = solve_2d_ivp(F, v_0, steps2, Delta: _Delta2, method: "euler")
#let times2 = range(0, steps2 + 1).map(i => i * _Delta2)

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
      times2,
      soln2.map(v => v.at(0)),
      label: [Ants],
      mark: none,
    ),
    lq.plot(
      times2,
      soln2.map(v => v.at(1)),
      label: [Aphids],
      mark: none,
      stroke: (dash: (4pt, 2pt)),
    ),
    lq.plot(
      times,
      ants,
      mark: none,
      stroke: (paint: gray, dash: (1pt, 2pt)),
    ),
    lq.plot(
      times,
      aphids,
      mark: none,
      stroke: (paint: gray, dash: (1pt, 2pt)),
    ),
  ),
)

== Component and Phase Spaces

The graph above is called a _component graph_. It shows the dependent variables (the populations of ants and aphids) vs. the independent
variable (time).#footnote[It is actually two component graphs, one for the ants and one for the aphids.]

However, we often want to consider the relationship _between the dependent variables_.
In this example, we might plot the population of ants vs. the population of aphids.

#align(
  center,
  lq.diagram(
    // ylim: (70, 104),
    width: 7cm,
    height: 4cm,
    yaxis: (position: left, tip: tiptoe.stealth),
    xaxis: (position: bottom, tip: tiptoe.stealth),
    xlabel: [\# Ants\ (thousands)],
    ylabel: [\# Aphids\ (thousands)],
    lq.plot(
      ants,
      aphids,
    ),
  ),
)

This plot suggests a relationship: there is a threshold where if the \# ants is above that threshold, they enable growth in \# aphids.
More analysis is needed to see if this observation is valid, but the graph points us in the right direction.#footnote[See if you can find what the threshold \# ants is
  by analyzing the differential equation directly.]

#v(1em)
Plots like the one above are called _phase plots_ or _plots in phase space_. The space where each axis corresponds to a dependent variable is called _phase space_ or the _phase plane_.

#show_def("component_and_phase")

#example(
  prompt: [The Three-dimensional Lorenz Equations],
  [
    Phase space is not limited to two dimensions.
    Consider the Lorentz equations, introduced by Edward Lorenz to demonstrate the inherent challenge in weather prediction.#footnote[The Lorenz equations
      would go on to become a foundational example in the study of chaos theory---a deterministic but hard to predict dependence on initial conditions.]
    The Lorenz equations are
    $
      (dif x) / (dif t) &= sigma (y - x) \
      (dif y) / (dif t) &= x (rho - z) - y \
      (dif z) / (dif t) &= x y - beta z
    $
    where $sigma = 10$, $rho = 28$, and $beta = 8 / 3$.

    Since there are three dependent variables ($x$, $y$, and $z$), the phase space associated with
    the Lorenz equations is three dimensional.

    Simulating using Euler's method, we get the following phase-space plot.

    #let sigma = 10
    #let rho = 28
    #let beta = 8 / 3
    #let F(x, y, z) = (sigma * (y - x), x * (rho - z) - y, x * y - beta * z)
    #let v_0 = (1, 1, 1)
    #let steps = 1500
    #let _Delta = 0.01

    #let soln = (v_0,)
    #for i in range(steps) {
      let (x_0, y_0, z_0) = soln.at(-1)
      let (dx, dy, dz) = F(x_0, y_0, z_0)
      let v = (x_0 + _Delta * dx, y_0 + _Delta * dy, z_0 + _Delta * dz)
      soln.push(v)
    }

    #let times = range(0, steps + 1).map(i => i * _Delta)
    #let x = soln.map(v => v.at(0))
    #let y = soln.map(v => v.at(1))
    #let z = soln.map(v => v.at(2))

    #import "@preview/plotsy-3d:0.1.0": plot-3d-parametric-curve

    #let xfunc(t) = x.at(int(t))
    #let yfunc(t) = y.at(int(t))
    #let zfunc(t) = z.at(int(t))

    #align(
      center,
      plot-3d-parametric-curve(
        xfunc,
        yfunc,
        zfunc,
        subdivisions: 1, //number of line segments per unit
        scale_dim: (0.01, 0.01, 0.01), // relative and global scaling
        tdomain: (0, steps),
        // axis_step: (5,5,5), // adjust distance between x, y, z number labels
        dot_thickness: 0.02em,
        front_axis_thickness: 0.0em,
        rear_axis_dot_scale: (0.08, 0.08),
        rear_axis_text_size: 0.5em,
        // axis_label_size: 1.5em,
        rotation_matrix: ((-.5, 1, 4), (0, -1, 1)),
        axis_label_offset: (1, .6, .5),
        // matrix transform-rotate-dir() from cetz
      ),
    )

    From the plot in phase space, we can see the spiralling nature of solutions. Something that is much harder to see from the component graphs.

    #align(
      center,
      lq.diagram(
        // xlim: (0, 1.6),
        // ylim: (-5, 125),
        title: [Lorenz Equations (Component Space)],
        width: 7cm,
        height: 4cm,
        yaxis: (position: left, tip: tiptoe.stealth),
        xaxis: (position: bottom, tip: tiptoe.stealth),
        xlabel: $t$,
        legend: (position: bottom + right),
        lq.plot(
          times,
          x,
          label: [$x$],
          mark: none,
        ),
        lq.plot(
          times,
          y,
          label: [$y$],
          mark: none,
        ),
        lq.plot(
          times,
          z,
          label: [$z$],
          mark: none,
        ),
      ),
    )
  ],
)











