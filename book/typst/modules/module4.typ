
// This file is meant to be imported and not compiled on its own.
#import "../common/settings-book.typ": workbook, show_def
#import "../libs/_graphics.typ": slope_field
#import "../libs/_ode_solvers.typ": solve_2d_ivp
#import "@preview/tiptoe:0.3.0"
#import "@preview/lilaq:0.2.0" as lq
#let (sans, serif, module, definition, example) = workbook

In this module you will learn
- What equilibrium solutions and equilibrium points are.
- How to estimate the long term behavior of a differential equation/system of differential equations.

By their nature, a model built from differential equations will tell you how a quantity _changes_. Equally important
are the conditions under which a quantity _does not_ change, the so-called _equilibrium solutions_.

#show_def("equilibrium_solution")

Suppose you are modelling a leaf falling off a balcony onto the ground. Let $h(t)$ represent the height of the leaf above the ground at time $t$.
If we assume that air resistance causes the leaf to fall at a constant speed of $1$ $m slash s$,
we can set up a differential equation to model the leaf's motion.
$
  h' = cases(
    -1 &" if " h > 0,
    0 &" if " h <= 0,
  )
$
Looking at a slope field for this equation, we can see that most solutions look "L"-shaped, first decreasing to zero and then remaining constant.

#{
  align(
    center,
    slope_field(
      (x, y) => if y > 0 { -1 } else { 0 },
      xlim: (-.3, 3.1),
      ylim: (-.7, 3.3),
      width: 5cm,
      height: 6cm,
      spacing: .3,
      scale_segments: .15,
      yaxis: (position: 0, tip: tiptoe.stealth, filter: ((v, d) => calc.round(v, digits: 2) in (1., 2., 3.))),
      xaxis: (position: 0, tip: tiptoe.stealth, tick-distance: 1.0),
      xlabel: $t$,
      ylabel: lq.label($h$, dx: -0cm),
      lq.plot((0, 1, 3), (1, 0, 0), mark: none, stroke: 1.5pt, z-index: 100),
      lq.plot((0, 2, 3), (2, 0, 0), mark: none, stroke: (thickness: 1.5pt, dash: (4pt, 1pt)), z-index: 100),
    ),
  )
}

But, there is one solution that is qualitatively different: $h(t)=0$. Indeed, the function $h(t)=0$ satisfies $h'(t)=0$, and so is a solution to the differential equation.
It is the _equilibrium solution_ to the differential equation corresponding to the leaf resting on the ground (and not actually falling at all).

#v(1em)

Let's consider a more complicated example.

Two ponds, Pond $A$ and Pond $B$, each with a volume of 1 million litres, are connected by canals. Pond $A$ is fed by a stream with runoff from a farm
that is contaminated with pesticides. Pond $B$ is fed by a mountain stream of clean water. The ponds exchange water through their canals at a rate of 0.1 million litres per day.
Additionally, the ponds have spill-gates that allow any excess water to flow out of each pond so they maintain a constant volume.

XXX Figure

Let $A(t)$ be the amount of pesticide in Pond $A$ at time $t$, and let $B(t)$ be the amount of pesticide in Pond $B$ at time $t$. W will assume:
- The ponds are well-mixed.
- Contaminated water flows into Pond $A$ at a rate of $0.05$ million litres per day with $1$ kilogram of pesticide per million litres.
- Clean water flows into Pond $B$ at a rate of $0.02$ million litres per day.
We can model $A$ and $B$ with the following system of differential equations.#footnote[
  To come up with this model, notice that $A'$, the change in the amount of pesticide in Pond $A$,
  is equal to the inflow of pesticide minus the outflow of pesticide. Pond $A$ has an inflow of
  $0.05 "kg" slash "day"$ from farm runoff and an inflow of $0.1 dot B(t) "kg" slash "day"$ from Pond $B$.
  It has an outflow of $0.1 dot A(t) "kg" slash "day"$ to Pond $B$ and an outflow of $0.05 dot A(t) "kg" slash "day"$ to the environment.
  Thus $A'=0.05+0.1 dot B -0.1 dot A - 0.05 dot A= -0.15 dot A +0.1 dot B +0.05$. A similar argument will produce an equation for $B'$.
]
$
  A' &=& -0.15 dot &A& quad + quad 0.1 dot &B& quad + quad &0.05\
  B' &=& 0.1 dot &A& quad - quad 0.12 dot &B& &
$

With our model defined, we can now make plots showing the amount of pesticide vs. time given different initial conditions.

#let F(A, B) = (-0.15 * A + 0.1 * B + 0.05, 0.1 * A - 0.12 * B)
#let _delta = 1
#let steps = 130
#let sim(A_0, B_0) = {
  let res = solve_2d_ivp(F, (A_0, B_0), steps, Delta: _delta, method: "rk4")
  (res.map(((x, y)) => x), res.map(((x, y)) => y))
}
#let (As, Bs) = sim(0.6, 0.1)
#let (As2, Bs2) = sim(1.4, 0.5)
#let (As3, Bs3) = sim(.1, 1.4)
#let ts = lq.arange(0, (steps + 1) * _delta, step: _delta)


#{
  let width = 4.8cm
  lq.diagram(
    //legend: (position: bottom + right),
    width: width,
    ylim: (0, 1.5),
    lq.plot(ts, As, mark: none, stroke: 1.5pt, label: "Pond A"),
    lq.plot(ts, Bs, mark: none, stroke: 1.5pt, label: "Pond B"),
    xaxis: (label: [$t$ (days)]),
    yaxis: (label: [Pesticide (kg)]),
  )
  h(-1.8em)
  lq.diagram(
    //legend: (position: bottom + right),
    width: width,
    ylim: (0, 1.5),
    lq.plot(ts, As2, mark: none, stroke: 1.5pt),
    lq.plot(ts, Bs2, mark: none, stroke: 1.5pt),
    xaxis: (label: [$t$ (days)]),
    yaxis: (filter: (v, d) => false),
  )
  h(-1.8em)
  lq.diagram(
    //legend: (position: bottom + right),
    width: width,
    ylim: (0, 1.5),
    lq.plot(ts, As3, mark: none, stroke: 1.5pt),
    lq.plot(ts, Bs3, mark: none, stroke: 1.5pt),
    xaxis: (label: [$t$ (days)]),
    yaxis: (filter: (v, d) => false),
  )
}

Using our physical intuition, we would expect that the amount of pesticide in each pond tends towards a constant (i.e., an equilibrium), and that's
exactly what we see in the plots.
No matter the initial conditions, the eventual amount of pesticide in Pond $A$ is slightly less than $0.8 "kg"$
and the eventual amount of pesticide in Pond $B$ is slightly more than $0.6 "kg"$.

We can compute the equilibrium solution to this differential equation exactly. Since we know that an equilibrium solution is constant, we know that the
derivative of an equilibrium solution is always zero. Solving
$
  0 quad=quad A' &=& -0.15 dot &A& quad + quad 0.1 dot &B& quad + quad &0.05\
  0 quad =quad B' &=& 0.1 dot &A& quad - quad 0.12 dot &B& &
$
we arrive at the unique solution $(A,B)=(0.75, 0.625)$. In other words,
$
  A(t) &= 0.75\
  B(t) &= 0.625
$
is the only equilibrium solution to this system.

XXX Example of a simple system with more than one equilibrium solution

== Equilibrium Points

We can also examine equilibrium solutions in phase space. Using our pond example, we can make a plot in phase space.

#align(
  center,
  {
    let width = 4.8cm
    lq.diagram(
      title: [Component Space],
      //legend: (position: bottom + right),
      width: width,
      ylim: (0, 1.5),
      lq.plot(ts, As, mark: none, stroke: 1.5pt, label: "Pond A"),
      lq.plot(ts, Bs, mark: none, stroke: 1.5pt, label: "Pond B"),
      xaxis: (label: [$t$ (days)]),
      yaxis: (label: [Pesticide (kg)]),
    )
    h(3em)
    lq.diagram(
      //legend: (position: bottom + right),
      title: [Phase Space],
      width: width,
      ylim: (0, 1.5),
      xlim: (0, 1.5),
      lq.plot(As, Bs, mark: none, stroke: 1.5pt, color: red.darken(20%)),
      //lq.plot(As2, Bs2, mark: none, stroke: 1.5pt),
      //lq.plot(As3, Bs3, mark: none, stroke: 1.5pt),
      xaxis: (label: [A], tick-distance: 0.2),
      yaxis: (label: [B], tick-distance: 0.2),
    )
  },
)

As we noticed, all solutions tend towards the equilibrium solutions $A(t)=0.75$ and $B(t)=0.625$. In phase space, this manifests as
all solutions tending towards the point $(A,B)=(0.75, 0.625)$. Further, if we graph the equilibrium solution $A(t)=0.75$ and $B(t)=0.625$
in phase space, instead of a curve, we get a single point $(A,B)=(0.75, 0.625)$. We call this point an _equilibrium point_.

#align(
  center,
  {
    /// Plot `xs` and `ys` and annotate the plot with arrows to indicate the direction of flow.
    /// - `xs` list of x-coordinates
    /// - `ys` list of y-coordinates
    /// - `arrow_pos` where to place the arrows as a percentage of the distance along the path. This is determined by counting points, not by actual distance.
    let flow_plot(xs, ys, arrow_pos: (0, .3, .6), ..lq_args) = {
      let indices = arrow_pos.map(alpha => {
        let index = int(alpha * (xs.len() - 1))
        index = calc.max(0, index)
        index = calc.min(xs.len() - 1, index)
        // Look forward 1 step
        let index2 = index + 1
        // If we stepped past the end of the array, step back
        if index2 >= xs.len() {
          index2 = index
          index -= 1
        }

        (index, index2)
      })

      (
        (
          lq.plot(
            xs,
            ys,
            mark: none,
            ..lq_args,
          ),
        )
          + indices.map(((index, index2)) => {
            let x1 = xs.at(index)
            let y1 = ys.at(index)
            let x2 = xs.at(index2)
            let y2 = ys.at(index2)

            lq.line(
              (x1, y1),
              (x2, y2),
              tip: tiptoe.stealth,
              ..lq_args,
              stroke: (thickness: 2pt, paint: white),
            )
          })
          + indices.map(((index, index2)) => {
            let x1 = xs.at(index)
            let y1 = ys.at(index)
            let x2 = xs.at(index2)
            let y2 = ys.at(index2)

            lq.line(
              (x1, y1),
              (x2, y2),
              tip: tiptoe.stealth,
              ..lq_args,
            )
          })
      )
    }

    let width = 4.8cm
    lq.diagram(
      //legend: (position: bottom + right),
      title: [Phase Space],
      width: width,
      ylim: (0, 1.5),
      xlim: (0, 1.5),
      xaxis: (label: [A], tick-distance: 0.2),
      //yaxis: (label: [B], tick-distance: 0.2),
      ..flow_plot(As, Bs, arrow_pos: (0.02, .3), stroke: (thickness: 1.5pt, paint: red.darken(30%))),
      ..flow_plot(As2, Bs2, arrow_pos: (0.01, .06), stroke: (thickness: 1.5pt, paint: green.darken(30%))),
      ..flow_plot(As3, Bs3, arrow_pos: (0.02, .001, .05), stroke: (thickness: 1.5pt, paint: blue.darken(30%))),
      lq.scatter((0.75,), (0.625,), size: 6pt, color: purple.darken(30%)),
      lq.place(
        0.75 - .04,
        0.625,
        align: right,
        [#box(fill: white, outset: 3pt, [Equilibrium Point]) #sym.arrow],
      ),
    )
  },
)
== Types of Equilibrium Solutions

In the mixing ponds example, all solutions tended towards the equilibrium solution (the equilibrium solution is _attracting_).
This isn't always the case.

In fact, consider the following population model#footnote[
  $100$ represents the carrying capacity of the environment (if the population exceeds the carrying capacity, individuals start dying).
]:
$
  P'(t) = P(t) dot (100 - P(t))
$
It has two equilibrium solutions: $P(t)=0$ and $P(t)=100$ (shown in solid colors). All other solutions are non-constant (dotted lines).

#{
  let xs = lq.linspace(0, .1, num: 40)
  let P0(p_0) = 100 / p_0 - 1
  align(
    center,
    lq.diagram(
      title: [Population vs. Time],
      xaxis: (label: [$t$], ticks: none),
      yaxis: (label: [P], tick-distance: 50),
      ..(0.3, 0.9, 2, 5, 10, 20, 30, 40, 50, 60, 70, 80, 90, 110, 120, 130, 140).map(p_0 => {
        lq.plot(
          xs,
          xs.map(x => 100 * calc.exp(100 * x) / (P0(p_0) + calc.exp(100 * x))),
          mark: none,
          stroke: (thickness: .5pt, paint: black, dash: (2pt, 1pt)),
        )
      }),
      lq.plot(xs, xs.map(x => 100), mark: none, stroke: (thickness: 1.5pt, paint: green.darken(30%))),
      lq.plot(xs, xs.map(x => 0), mark: none, stroke: (thickness: 1.5pt, paint: blue.darken(30%))),
    ),
  )
}

We call the equilibrium solution $P(t)=0$ _unstable_ and _repelling_. That is, while it is true that if the population is exactly zero, it will stay that way,
if there is even one individual (in this model at least), the population will grow substantially. Alternatively, we call
the equilibrium solution $P(t)=100$ _stable_ and _attracting_. If the population is exactly $100$, it will stay that way, but if the population is
slightly less than or slightly more than $100$, it will tend towards $100$.

In general, equilibrium solutions can be classified as attracting, repelling, stable, and/or unstable depending on the
behaviour of solutions near that equilibrium.

#show_def("equilibrium_classification_informal")

The above definition uses the term, _local_, to refer to solutions that passes through points "close to" that of the equilibrium solution. This can be made precise
using $epsilon$-$delta$ definitions.

#show_def("equilibrium_classification_formal")

Whether using the formal or informal definition, the important thing is to have an intuition about what different types of equilibrium solutions look like, both in _component
space_ and _phase space_.

=== Stable and Attracting

We've already seen that for $P'=P dot (100 - P)$, the equilibrium solution $P(t)=100$ is stable and attracting. It is stable because if a solution $P^*$ starts close to $P(t)=100$,
then it will stay close to $P(t)=100$.

XXX Figure

The equilibrium solution $P(t)=100$ is attracting because if a solution $P^*$ starts close to $P(t)=100$, its limit as $t arrow + infinity$ will actually be $100$.

=== Stable and not Attracting

Consider the differential equation $y'=0$. This equation has solutions of the form $y(t)=k$ where $k$ is a constant. These are all equilibrium solutions!

Let's focus on the equilibrium solution $y(t)=0$. This solution is stable because if a solution $y^*(t)=k$ starts close to $y(t)=0$, it will stay close to $y(t)=0$; in fact
its distance from $y(t)$ will never change. However, $y(t)=0$ is _not_ attracting, because $y^*(t) =k quad arrow.not quad 0$.

XXX Figure

=== Unstable and Repelling

XXX Finish

=== Unstable and not Repelling

XXX Finish

=== Other Classifications

There cannot be unstable and attracting equilibria, nor can there be stable and repelling equilibria. But there can be other behavior.

Consider the Van der Pol system:
$
  "XXX Finish"
$

Solutions to this system all end up with oscillatory behaviour and they all have the same period. Here solutions are not attracted to an equilibrium, but they are attracted towards
a solution which is perfectly periodic (in this situation we say that the system has a _limit cycle_). The study of what behaviour solutions can be "attracted to"
leads to concepts like fractals and chaos, and may be studied in an advanced differential equations course or a course on dynamical systems.

#example(
  prompt: [Find an classify all equilibrium solutions to XXX Finish],
  [
    XXX Finish
  ],
)


