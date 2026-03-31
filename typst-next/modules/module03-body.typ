#import "../libs/_workbook.typ": aligned_terms, label_module, simple_table
#import "../libs/_ode_solvers.typ": solve_2d_ivp
#import "@preview/lilaq:0.4.0" as lq
#import "@preview/tiptoe:0.3.1"

#label_module(<mod:systems>)

// This file is meant to be imported and not compiled on its own.
#import "../common/settings-book.typ": show_def, workbook
#let (sans, serif, module, definition, example) = workbook



In this module you will learn
- How to build models using systems of differential equations.
- How to approximate solutions to systems of differential equations.
- How to graph solutions to systems of differential equations in component space and phase space.



== Modelling

In the previous two modules, we modeled single quantities in isolation. But, what happens when we
have multiple interrelated quantities?

To explore this, we will model populations of _Yellow Meadow Ants_. The Yellow Meadow Ant is a
species of _farming_ ant. They tend to farms of aphids, which are small insects that suck the sap
from plants. The ants protect the aphids from predators and in return the aphids secrete a sugary
substance called honeydew, which the ants eat. The population of ants and the population of aphids
are symbiotically interrelated, as the growth of one population depends on the other.

We can create a _system_ of differential equations to model the interrelated populations:

$
    dif / (dif t) ("# ants at week " t) & = a ("# ants at week " t ) + b ("# aphids at week " t) \
  dif / (dif t) ("# aphids at week " t) & = c ("# ants at week " t ) - d ("# aphids at week " t)
$

The first equation models the growth of the ant population, with $a$ representing the natural growth
of ants in the absence of aphids and $b$ representing the growth of the ant population due to the
presence of aphids (this term provides a "boost" to the ant population since the presence of aphids
will mean more food for the ants).

The second equation models the growth of the aphid population, with $c$ representing the growth of
the aphid population due to the presence of ants (this term has a positive effect on the growth of
aphids since they will be protected from predators), and $d$ representing the natural death of
aphids in the absence of ants (they will be eaten by other creatures if ants aren't around to
protect them).

The parameters $a, b, c, d >= 0$ depend on the habitat; they could be gathered from data, but we
will instead use artificially nice values of $a,b,c,d$.
//As we discussed in @mod:modelling, these constants can be estimated from data, but to do so, we need to be able to find the analytic solution to the system of differential equations.
//In @mod:real[Modules], @mod:affine[], and @mod:complex[] we will learn how to solve some types of systems of differential equations like this one, called linear systems of differential equations with constant coefficients.



== Simulation

We will use a modified version of Euler's method (see @mod:simulation) to simulate a solution to
this system of differential equations. But, we will use two tangent lines to estimate the next data
point---one tangent line for ants and one for aphids.

For now, we will assume $a=1, b=c=d=1 / 2$ and that units are in thousands. The initial population
will be $10$ thousand ants and $100$ thousand aphids. Using a time step of $Delta = 0.25$, we
compute
$
    ("# Ants")'(0) & = 1 dot 10 + 1 / 2 dot 100 = 60 \
  ("# Aphids")'(0) & = 1 / 2 dot 10 - 1 / 2 dot 100 = -45
$

and so
$
    ("# Ants") (0.25) & approx 10 + 0.25 dot 60 = 25 \
  ("# Aphids") (0.25) & approx 100 + 0.25 dot (-45) = 88.75
$
#let t_max = 1.75
We can now repeat this processes at $t=0.25$ to find approximate values for the number of ants and
aphids at $t=0.5$, etc.. Repeating until $t=#(t_max)$, we arrive at the following table of values:

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

The graph below shows the simulated Ant and Aphid populations over time.

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
Of course, if we wanted a more accurate simulation, we could use a smaller step size. Below is a
graph using a step size of $Delta = #(_Delta2)$, The new, more accurate estimates are shown (solid
and dashed) along with the old estimates (dotted).

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
      stroke: (paint: black, dash: (1pt, 2pt)),
    ),
    lq.plot(
      times,
      aphids,
      mark: none,
      stroke: (paint: black, dash: (1pt, 2pt)),
    ),
  ),
)

== Component and Phase Spaces

The graphs above are called _component graphs_. They show the dependent variables (the populations
of ants and aphids) vs. the independent variable (time).#footnote[Each is actually composed of two
  component graphs, one for the ants and one for the aphids.]

However, we often want to consider the relationship _between the dependent variables_. In this
example, we might plot the population of ants vs. the population of aphids.

#align(
  center,
  lq.diagram(
    // ylim: (70, 104),
    width: 7cm,
    height: 4cm,
    yaxis: (position: left, tip: tiptoe.stealth),
    xaxis: (position: bottom, tip: tiptoe.stealth),
    xlabel: [\# Ants\ (thousands)],
    ylabel: [\# Aphids #h(0.75em)\ (thousands)],
    lq.plot(
      ants,
      aphids,
    ),
  ),
)

This plot suggests a relationship: there is a threshold where if the \# ants is above that
threshold, they enable growth in \# aphids. More analysis is needed to see if this observation
always holds, but the graph points us in the right direction.#footnote[See if you can find what the
  threshold \# ants is by analyzing the differential equation directly.]

#v(1em)
Plots like the one above are called _phase plots_ or _plots in phase space_. The space where each
axis corresponds to a dependent variable is called _phase space_ or the _phase plane_.

#show_def("component_and_phase")

As you may have noticed in the above definition, phase space is not limited to two dimensions.

#example(
  prompt: [The Three-dimensional Lorenz Equations],
  [
    Phase space is not limited to two dimensions. Consider the Lorenz equations, introduced by
    Edward Lorenz to demonstrate the inherent challenge in weather prediction.#footnote[The Lorenz
      equations would go on to become a foundational example in the study of chaos theory---a
      deterministic but hard to predict dependence on initial conditions.] The Lorenz equations are
    $
      (dif x) / (dif t) & = sigma (y - x) \
      (dif y) / (dif t) & = x (rho - z) - y \
      (dif z) / (dif t) & = x y - beta z
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

    #import "@preview/plotsy-3d:0.2.1": plot-3d-parametric-curve

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
        scale-dim: (0.01, 0.01, 0.01), // relative and global scaling
        tdomain: (0, steps),
        // axis_step: (5,5,5), // adjust distance between x, y, z number labels
        dot-thickness: 0.02em,
        front-axis-thickness: 0.0em,
        rear-axis-dot-scale: (0.08, 0.08),
        rear-axis-text-size: 0.5em,
        //axis-label-size: 1.5em,
        rotation-matrix: ((-.5, 1, 4), (0, -1, 1)),
        axis-label-offset: (1, .6, .5),
        // matrix transform-rotate-dir() from cetz
      ),
    )

    Even though the phase plot is hard to interpret due to the three-dimensional nature of the data,
    we can still see the spiralling nature of solutions. Something that is much harder to see from
    the component graphs below.

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

=== When to use Phase Plots and Component Graphs


Component graphs are almost always useful, helping to visualize how quantities change over time,
however relationships between quantities can be hard to see from component graphs. When quantities
are interrelated, plots in _phase space_ help reveal their relationships.

However, phase plots should only be used when studying *autonomous* systems of differential
equations. Why? Because, by definition, phase space does not include the independent variable
(usually time). For autonomous equations, you can pick any point along a solution curve to represent
"time zero". This makes phase plots for autonomous systems easy to interpret. For non-autonomous
systems, the exact time (i.e., whether it is time $0$ or time $1$, etc.) matters. But phase plots
have no way to encode time information, so you end up with a plot that loses so much information,
it's rarely useful.


