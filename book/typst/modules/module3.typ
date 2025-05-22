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

In the previous two modules we have seen how to build models using differential equations by estimating how a quantity changes.

In reality, we usually find a system of interrelated quantities changing. For example, in the previous module we saw how to model the growth of a population of ants. Several species of ants farm aphids, which are small insects that suck the sap from plants. The ants protect the aphids from predators and in return the aphids secrete a sugary substance called honeydew, which the ants eat. The population of ants and the population of aphids are symbiotically interrelated, as the growth of one population depends on the other.

We can then create a system of differential equations to model the growth of both populations.

$
  dif / (dif t) ("# ants at minute " t)
  &= a ("# ants at minute " t ) + b ("# aphids at time " t) \
  dif / (dif t) ("# aphids at minute " t)
  &= c ("# ants at minute " t ) - d ("# aphids at time " t)
$

The first equation models the growth of the ant population. The first term with parameter $a$ models the natural growth of ants in the absence of aphids. The second term with parameter $b$ models the growth of the ant population due to the presence of aphids -- this term provides a "boost" to the growth of the ant population since the presence of aphids will mean more food is available for the ants.

The second equation models the growth of the aphid population. The first term with parameter $c$ models the growth of the aphid population due to the presence of ants -- this term has a positive effect to the growth of the aphid population since they will be protected from predators. The second term with parameter $d$ models the natural death of aphids in the absence of ants due to the fact that predation will overwhelm their natural growth.

The parameters $a, b, c, d >= 0$ depend on the species of ants and aphids. As we discussed in @mod:modelling, these constants can be estimated from data, but to do so, we need to be able to find the analytic solution to the system of differential equations.
In @mod:real[Modules], @mod:affine[], and @mod:complex[] we will learn how to solve some types of systems of differential equations like this one, called linear systems of differential equations with constant coefficients.



== Simulation

Just like we did in @mod:simulation to simulate one differential equation, we use Euler's method to simulate a system of differential equations.

The method is the same as before, but now we have to keep track of two quantities at each step. We can do this by using a table to keep track of the values of the two populations at each time step.

As an example, consider $a=1, b=c=d=1 / 2$ and starting populations of $10$ (thousand) ants and $100$ (thousand) aphids. We can simulate the system of differential equations using Euler's method with a time step of $0.25$:

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
#let steps = 6
#let _Delta = 0.25

#let soln = solve_2d_ivp(F, v_0, steps, Delta: _Delta, method: "euler")

#let times = range(0, steps + 1).map(i => i * _Delta)
#let ants = soln.map(v => calc.round(v.at(0), digits: 3))
#let aphids = soln.map(v => calc.round(v.at(1), digits: 3))

#let data = times.zip(ants, aphids)

#align(
  center,
  simple_table(
    headers: ([Time], [\# Ants], [\# Aphids]),
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



== Component and Phase Spaces

The graph above is called a _component space graph_. It shows the populations of ants and aphids at each time step.
It is actually two component graphs, one for the ants and one for the aphids.

However, it is often more useful to plot the populations against each other. This is called a _phase space graph_. In this graph, the population of ants is on the $x$-axis and the population of aphids is on the $y$-axis. The graph shows how the populations of ants and aphids change with respect to each other.
#align(
  center,
  lq.diagram(
    // ylim: (70, 104),
    width: 7cm,
    height: 4cm,
    yaxis: (position: left, tip: tiptoe.stealth),
    xaxis: (position: bottom, tip: tiptoe.stealth),
    xlabel: [\# Ants],
    ylabel: [\# Aphids],
    lq.plot(
      ants,
      aphids,
    ),
  ),
)

#show_def("component_and_phase")

#example(
  prompt: [Phase space graphs can have more than two dimensions.],
  [
    Observe that is we have a system of $n$ differential equations, then the phase space graph must also be plotted in $n$ dimensions.

    As an example, consider the Lorentz attractor, which is a system of three differential equations that models the motion of a particle in a fluid. It is given by the following system of differential equations:
    $
      (dif x) / (dif t) &= sigma (y - x) \
      (dif y) / (dif t) &= x (rho - z) - y \
      (dif z) / (dif t) &= x y - beta z
    $
    where $sigma = 10$, $rho = 28$, and $beta = 8 / 3$.

    To plot the solution in phase space, we need to plot in three dimensions. Below is the graph of one solution in phase space.

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
        rotation_matrix: ((-2, 1, 4), (0, -1, 1)),
        axis_label_offset: (1, .6, .5),
        // matrix transform-rotate-dir() from cetz
      ),
    )

    And the graph of the same solution in component space.
    #align(
      center,
      lq.diagram(
        // xlim: (0, 1.6),
        // ylim: (-5, 125),
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











