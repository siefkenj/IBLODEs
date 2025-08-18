
// This file is meant to be imported and not compiled on its own.
#import "../libs/_workbook.typ": label_module, simple_table
#import "../common/settings-book.typ": show_def, workbook
#import "../libs/_graphics.typ": slope_field
#import "../libs/_ode_solvers.typ": solve_2d_ivp
#import "@preview/tiptoe:0.3.1"
#import "@preview/lilaq:0.4.0" as lq
#let (sans, serif, module, definition, example) = workbook

#label_module(<mod:equilibrium>)

In this module you will learn
- What equilibrium solutions and equilibrium points are.
- How equilibrium points relate to the long term behavior of a differential equation/system of
  differential equations.

Models built from differential equations tell you how quantities _change_. Equally important,
though, are the conditions under which quantities _do not_ change. In science and engineering, when
a system is in a state that doesn't change, we say it is at _equilibrium_. In the context of
differential equations, solutions that don't change are called _equilibrium solutions_.

#show_def("equilibrium_solution")

Suppose you are modelling a leaf falling from a balcony onto the ground. Let $h(t)$ represent the
height of the leaf above the ground at time $t$. Assume that air resistance causes the leaf to fall
at a constant speed of $1$ $m slash s$. With this assumption, the leaf's motion can be modeled by
the differential equation
$
  h' = cases(
    -1 & " if " h > 0,
    0 & " if " h <= 0,
  ).
$
Looking at a slope field for this equation, we can see that most solutions look "L"-shaped, first
decreasing to zero and then remaining constant.

#{
  align(center, slope_field(
    (x, y) => if y > 0 { -1 } else { 0 },
    xlim: (-.3, 3.1),
    ylim: (-.7, 3.3),
    width: 5cm,
    height: 6cm,
    spacing: .3,
    scale_segments: .15,
    yaxis: (
      position: 0,
      tip: tiptoe.stealth,
      filter: ((v, d) => calc.round(v, digits: 2) in (1., 2., 3.)),
    ),
    xaxis: (position: 0, tip: tiptoe.stealth, tick-distance: 1.0),
    xlabel: $t$,
    ylabel: lq.label($h$, dx: -0cm),
    lq.plot((0, 1, 3), (1, 0, 0), mark: none, stroke: 1.5pt, z-index: 100),
    lq.plot(
      (0, 2, 3),
      (2, 0, 0),
      mark: none,
      stroke: (thickness: 1.5pt, dash: (4pt, 1pt)),
      z-index: 100,
    ),
  ))
}

But, there is one solution that is qualitatively different: $h(t)=0$. Indeed, the function $h(t)=0$
satisfies $h'(t)=0$, and so is a solution to the differential equation. It is the _equilibrium
  solution_ to the differential equation corresponding to the leaf resting on the ground (not
actually falling at all).

#v(1em)

Let's consider a more complicated example.

Two ponds, Pond $A$ and Pond $B$, each with a volume of 1 million litres, are connected by canals.
Pond $A$ is fed by a stream with contaminated with pesticides from a nearby farm. Pond $B$ is fed by
a mountain stream of clean water. The ponds exchange water through their canals at a rate of 0.1
million litres per day. Additionally, the ponds have spill-gates that allow any excess water to flow
out of each pond so they maintain a constant volume.

We will assume:
- The ponds are well-mixed.
- Contaminated water flows into Pond $A$ at a rate of $0.05$ million litres per day with $1$
  kilogram of pesticide per million litres.
- Clean water flows into Pond $B$ at a rate of $0.02$ million litres per day.

#align(center, {
  import "@preview/cetz:0.4.0"
  cetz.canvas({
    import cetz.draw: *

    rect(
      (0, 0),
      (rel: (2.5, 3)),
      name: "pondA",
      radius: 1,
      stroke: blue.darken(30%),
      fill: blue.lighten(80%).mix(purple.lighten(80%)),
    )
    rect(
      (4, 0),
      (rel: (2.5, 3)),
      name: "pondB",
      radius: 1,
      stroke: blue.darken(30%),
      fill: blue.lighten(80%),
    )
    content("pondA", text("Pond A"))
    content("pondB", text("Pond B"))

    line(
      (name: "pondA", anchor: 30deg),
      (name: "pondB", anchor: 150deg),
      (name: "pondB", anchor: 165deg),
      (name: "pondA", anchor: 15deg),
      stroke: none,
      fill: blue,
      name: "canal1",
      closed: true,
    )
    line(
      (name: "pondA", anchor: -30deg),
      (name: "pondB", anchor: -150deg),
      (name: "pondB", anchor: -165deg),
      (name: "pondA", anchor: -15deg),
      stroke: none,
      fill: blue,
      name: "canal2",
    )

    content("canal1", text(fill: white, $-->$))
    content(
      (name: "canal1", anchor: 20%),
      box(inset: 2pt, text(fill: blue, [Canals\ $0.1 m l / d$])),
      anchor: "south",
    )
    content("canal2", text(fill: white, $<--$))


    // Draw inflows
    line(
      (name: "pondA", anchor: 80deg),
      (rel: (0, 1.5)),
      (rel: (-1, 0)),
      (name: "pondA", anchor: 100deg),
      stroke: blue,
      fill: purple.lighten(80%),
      name: "pondA_inflow",
    )
    line(
      (name: "pondB", anchor: 80deg),
      (rel: (.5, 1.5)),
      (rel: (-1, 0)),
      (name: "pondB", anchor: 100deg),
      stroke: blue,
      name: "pondB_inflow",
    )
    line(
      (name: "pondA", anchor: -80deg),
      (rel: (0, -1.5)),
      (rel: (-1, 0)),
      (name: "pondA", anchor: -100deg),
      stroke: blue,
      name: "pondA_outflow",
    )
    line(
      (name: "pondB", anchor: -80deg),
      (rel: (.5, -1.5)),
      (rel: (-1, 0)),
      (name: "pondB", anchor: -100deg),
      stroke: blue,
      name: "pondB_outflow",
    )

    content("pondA_inflow", text(fill: blue, $arrow.b$))
    content(
      (name: "pondA_inflow", anchor: 50%),
      box(inset: 2pt, align(center, text(fill: blue, [Contaminated Inflow\ $0.05 m l / d$]))),
      anchor: "south",
    )
    content("pondB_inflow", text(fill: blue, $arrow.b$))
    content(
      (name: "pondB_inflow", anchor: 50%),
      box(inset: 2pt, align(center, text(fill: blue, [Clean Inflow\ $0.02 m l / d$]))),
      anchor: "south",
    )
    content("pondA_outflow", text(fill: blue, $arrow.b$))
    content(
      (name: "pondA_outflow", anchor: 50%),
      box(inset: 4pt, align(center, text(fill: blue, [Outflow\ $0.05 m l / d$]))),
      anchor: "north",
    )
    content("pondB_outflow", text(fill: blue, $arrow.b$))
    content(
      (name: "pondB_outflow", anchor: 50%),
      box(inset: 4pt, align(center, text(fill: blue, [Outflow\ $0.02 m l / d$]))),
      anchor: "north",
    )
  })
})

Let $A(t)$ be the amount of pesticide in Pond $A$ at time $t$, and let $B(t)$ be the amount of
pesticide in Pond $B$ at time $t$.

We can model $A$ and $B$ with the following system of differential equations.#footnote[
  To come up with this model, notice that $A'$, the change in the amount of pesticide in Pond $A$,
  is equal to the inflow of pesticide minus the outflow of pesticide. Pond $A$ has an inflow of
  $0.05 "kg" slash "day"$ from farm runoff and an inflow of $0.1 dot B(t) "kg" slash "day"$ from
  Pond $B$. It has an outflow of $0.1 dot A(t) "kg" slash "day"$ to Pond $B$ and an outflow of
  $0.05 dot A(t) "kg" slash "day"$ to the environment. Thus
  $A'=0.05+0.1 dot B -0.1 dot A - 0.05 dot A= -0.15 dot A +0.1 dot B +0.05$. A similar argument will
  produce an equation for $B'$.
]
$
  A' & = & -0.15 dot & A & quad & + &  quad 0.1 dot & B & quad + quad & 0.05 \
  B' & = &   0.1 dot & A & quad & - & quad 0.12 dot & B &             &
$

With our model defined, we can now make plots showing the amount of pesticide vs. time given
different initial conditions.

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
  stack(
    dir: ltr,
    spacing: -1.8em,
    lq.diagram(
      //legend: (position: bottom + right),
      width: width,
      ylim: (0, 1.5),
      lq.plot(ts, As, mark: none, stroke: 1.5pt, label: "Pond A"),
      lq.plot(ts, Bs, mark: none, stroke: 1.5pt, label: "Pond B"),
      xaxis: (label: [$t$ (days)]),
      yaxis: (label: [Pesticide (kg)]),
      title: [$A(0) = 0.6\ B(0)=0.1$],
    ),
    lq.diagram(
      //legend: (position: bottom + right),
      width: width,
      ylim: (0, 1.5),
      lq.plot(ts, As2, mark: none, stroke: 1.5pt),
      lq.plot(ts, Bs2, mark: none, stroke: 1.5pt),
      xaxis: (label: [$t$ (days)]),
      yaxis: (filter: (v, d) => false),
      title: [$A(0) = 1.4\ B(0)=0.5$],
    ),
    lq.diagram(
      //legend: (position: bottom + right),
      width: width,
      ylim: (0, 1.5),
      lq.plot(ts, As3, mark: none, stroke: 1.5pt),
      lq.plot(ts, Bs3, mark: none, stroke: 1.5pt),
      xaxis: (label: [$t$ (days)]),
      yaxis: (filter: (v, d) => false),
      title: [$A(0) = 0.1\ B(0)=1.4$],
    ),
  )
}

Using our physical intuition, we would expect that the amount of pesticide in each pond tends
towards a constant (i.e., an equilibrium), and that's exactly what we see in the plots. No matter
the initial conditions, the eventual amount of pesticide in Pond $A$ is slightly less than
$0.8 "kg"$ and the eventual amount of pesticide in Pond $B$ is slightly more than $0.6 "kg"$.

We can compute the equilibrium solution to this differential equation exactly. Since we know that an
equilibrium solution is constant, the derivative of an equilibrium solution is always zero. Solving
$
   0 quad=quad A' & = & -0.15 dot & A & quad & + &  quad 0.1 dot & B & quad + quad & 0.05 \
  0 quad =quad B' & = &   0.1 dot & A & quad & - & quad 0.12 dot & B &             &
$
we arrive at the unique solution $(A,B)=(0.75, 0.625)$. In other words,
$
  A(t) & = 0.75 \
  B(t) & = 0.625
$
is the only equilibrium solution to this system.

#example(
  prompt: [Differential equations may have more than one equilibrium solution. Find all equilibrium
    solutions to
    $
      P' & = P dot Q - 4 P + 3 \
      Q' & = 2 P - Q dot (P + 1)
    $
  ],
  [
    To find the equilibrium solutions, we set $P' = 0$ and $Q' = 0$ and solve the resulting system
    of equations.
    $
      0 & = P dot Q - 4 P + 3 \
      0 & = 2 P - Q dot (P + 1)
    $
    implies either $(P,Q)=(1,1)$ or $(P,Q)=(-3 / 2, 6)$.

    Therefore, the equilibrium solutions are
    #align(center + horizon, stack(
      dir: ltr,
      spacing: 1em,
      $
        P(t) & = 1 \
        Q(t) & = 1
      $,
      [and],
      $
        P(t) & = -3 / 2 \
        Q(t) & = 6
      $,
    ))
  ],
)

== Equilibrium Points

We can also examine equilibrium solutions in phase space. Using our pond example, we can make a plot
in phase space.

#align(center, {
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
})

As we noticed, all solutions tend towards the equilibrium solutions $A(t)=0.75$ and $B(t)=0.625$. In
phase space, this manifests as all solutions tending towards the point $(A,B)=(0.75, 0.625)$.
Further, if we graph the equilibrium solution $A(t)=0.75$ and $B(t)=0.625$ in phase space, instead
of a curve, we get a single point $(A,B)=(0.75, 0.625)$. We call this point an _equilibrium point_.

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

            lq.line((x1, y1), (x2, y2), tip: tiptoe.stealth, ..lq_args, stroke: (
              thickness: 2pt,
              paint: white,
            ))
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
      yaxis: (label: [#h(3em)B], tick-distance: 0.2),
      ..flow_plot(As, Bs, arrow_pos: (0.02, .3), stroke: (
        thickness: 1.5pt,
        paint: red.darken(30%),
      )),
      ..flow_plot(As2, Bs2, arrow_pos: (0.01, .06), stroke: (
        thickness: 1.5pt,
        paint: green.darken(30%),
      )),
      ..flow_plot(As3, Bs3, arrow_pos: (0.02, .001, .05), stroke: (
        thickness: 1.5pt,
        paint: blue.darken(30%),
      )),
      lq.scatter((0.75,), (0.625,), size: 6pt, color: purple.darken(30%)),
      lq.place(0.75 - .04, 0.625, align: right, [#box(fill: white, outset: 3pt, [Equilibrium Point])
        #sym.arrow]),
    )
  },
)
== Types of Equilibrium Solutions

In the mixing ponds example, all solutions tended towards the equilibrium solution (the equilibrium
solution is _attracting_). This isn't always the case.

Consider the following population model based on the assumptions of exponential growth and a
carrying capacity:#footnote[
  $100$ represents the carrying capacity of the environment. If the population exceeds the carrying
  capacity, individuals start dying.
]
$
  P'(t) = P(t) dot (100 - P(t))
$
Here, $P(t)$ represents the population of some organism at time $t$.

There are two equilibrium solutions: $P(t)=0$ and $P(t)=100$ (shown in solid colors). All other
solutions are non-constant (dashed lines).

#{
  let xs = lq.linspace(0, .1, num: 40)
  let P0(p_0) = 100 / p_0 - 1
  align(center, lq.diagram(
    title: [Population vs. Time],
    xaxis: (label: [$t$], ticks: none),
    yaxis: (label: [P], tick-distance: 50),
    ..(0.3, 0.9, 2, 5, 10, 20, 30, 40, 50, 60, 70, 80, 90, 110, 120, 130, 140).map(p_0 => {
      lq.plot(
        xs,
        xs.map(x => 100 * calc.exp(100 * x) / (P0(p_0) + calc.exp(100 * x))),
        mark: none,
        stroke: (
          thickness: .5pt,
          paint: black,
          dash: (2pt, 1pt),
        ),
      )
    }),
    lq.plot(xs, xs.map(x => 100), mark: none, stroke: (thickness: 1.5pt, paint: green.darken(30%))),
    lq.plot(xs, xs.map(x => 0), mark: none, stroke: (thickness: 1.5pt, paint: blue.darken(30%))),
  ))
}

We call the equilibrium solution $P(t)=0$ _unstable_ and _repelling_. That is, while it is true that
a population of exactly zero will stay that way, if there is even one individual (in this model at
least), the population will grow substantially. Alternatively, we call the equilibrium solution
$P(t)=100$ _stable_ and _attracting_. If the population is exactly $100$, it will stay that way, but
if the population is slightly less than or slightly more than $100$, it will tend towards $100$.

In general, equilibrium solutions can be classified as attracting, repelling, stable, and/or
unstable depending on the behaviour of solutions near that equilibrium (i.e., solutions with initial
conditions near the equilibrium point).

#show_def("equilibrium_classification_informal")

The above definition uses the term _local_ to refer to solutions that passes through points "close
to" that of the equilibrium solution. This can be made precise using $epsilon$-$delta$ definitions.

#show_def("equilibrium_classification_formal")

Whether using the formal or informal definition, the important thing is to have an intuition about
what different types of equilibrium solutions look like, both in _component space_ and _phase
  space_.

=== Stable and Attracting

We've already seen that for $P'=P dot (100 - P)$, the equilibrium solution $P(t)=100$ is stable and
attracting.

#{
  let xs = lq.linspace(0, .1, num: 40)
  let P0(p_0) = 100 / p_0 - 1
  align(center, lq.diagram(
    title: [Population vs. Time],
    xaxis: (label: [$t$], ticks: none),
    yaxis: (label: [P], tick-distance: 50),
    ylim: (0, 120),
    xlim: (0, .1),
    ..(80, 90, 110, 120).map(p_0 => {
      lq.plot(
        xs,
        xs.map(x => 100 * calc.exp(100 * x) / (P0(p_0) + calc.exp(100 * x))),
        mark: none,
        stroke: (
          thickness: .5pt,
          paint: black,
          dash: (2pt, 1pt),
        ),
      )
    }),
    lq.plot(xs, xs.map(x => 100), mark: none, stroke: (thickness: 1.5pt, paint: green.darken(30%))),
    //     lq.plot(xs, xs.map(x => 0), mark: none, stroke: (thickness: 1.5pt, paint: blue.darken(30%))),
  ))
}

- It is _stable_ because if a solution $P^*$ (dashed curves above) starts close to $P(t)=100$, then
  it will stay close to $P(t)=100$.
- The equilibrium solution $P(t)=100$ is _attracting_ because if a solution $P^*$ (dashed curves
  above) starts close to $P(t)=100$, its limit as $t arrow + infinity$ will actually be $100$.

=== Stable and not Attracting

Consider the differential equation $y'=0$. This equation has solutions of the form $y(t)=k$, where
$k$ is a constant. These are all equilibrium solutions!

Let's focus on the equilibrium solution $y(t)=0$.
#{
  let xs = lq.linspace(0, .1, num: 40)
  let P0(p_0) = 100 / p_0 - 1
  align(center, lq.diagram(
    xaxis: (label: [$t$], ticks: none),
    yaxis: (label: [$y$]),
    ylim: (-1, 1),
    xlim: (0, .1),
    ..(.2, -.2, .4, -.4).map(p_0 => {
      lq.plot(xs, xs.map(x => p_0), mark: none, stroke: (
        thickness: .5pt,
        paint: black,
        dash: (2pt, 1pt),
      ))
    }),
    //   lq.plot(xs, xs.map(x => 0), mark: none, stroke: (thickness: 1.5pt, paint: green.darken(30%))),
    lq.plot(xs, xs.map(x => 0), mark: none, stroke: (thickness: 1.5pt, paint: blue.darken(30%))),
  ))
}

- This solution is _stable_ because if a solution $y^*(t)=k$ (a dashed curve above) starts close to
  $y(t)=0$, it will stay close to $y(t)=0$; in fact its distance from $y(t)$ will never change.
- However, $y(t)=0$ is _not attracting_, because if $y^*(t)=k$ is a solution that is close to
  $y(t)=0$, then $display(lim_(t arrow infinity) y^*(t) =k quad != quad 0)$.

=== Unstable and Repelling

Consider the differential equation $y'=-y dot (100 - y)$; the equilibrium solution $y(t)=100$ is
unstable and repelling.

#{
  let xs = lq.linspace(0, .1, num: 40)
  let xs2 = lq.linspace(0, .035, num: 20)
  let P0(p_0) = 100 / p_0 - 1
  let F(t, p_0) = {
    let exp = calc.exp(100 * t)
    100 / (P0(p_0) * exp + 1)
  }
  align(center, lq.diagram(
    xaxis: (label: [$t$], ticks: none),
    yaxis: (label: [$y$], tick-distance: 50),
    ylim: (0, 140),
    xlim: (0, .1),
    ..(98, 99).map(p_0 => {
      lq.plot(xs, xs.map(x => F(x, p_0)), mark: none, stroke: (
        thickness: .5pt,
        paint: black,
        dash: (2pt, 1pt),
      ))
    }),
    ..(101, 102).map(p_0 => {
      lq.plot(xs2, xs2.map(x => F(x, p_0)), mark: none, stroke: (
        thickness: .5pt,
        paint: black,
        dash: (2pt, 1pt),
      ))
    }),
    lq.plot(xs, xs.map(x => 100), mark: none, stroke: (thickness: 1.5pt, paint: green.darken(30%))),
    //     lq.plot(xs, xs.map(x => 0), mark: none, stroke: (thickness: 1.5pt, paint: blue.darken(30%))),
  ))
}

- It is _unstable_ because if a solution $y^*$ (dashed curves above) starts close to $y(t)=100$, it
  does not stay close to $y(t)=100$.
- The equilibrium solution $y(t)=100$ is _repelling_ because there is a fixed distance $epsilon$
  such that any solution $y^*$ (dashed curves above) starting close to $y(t)=100$ will eventually
  end up at least $epsilon$ away from $y(t)=100$ for the rest of time (i.e., for all large $t$).

=== Unstable and not Repelling

Consider the differential equation $y'=1/7 t dot sin(t)dot y$. This equation has an equilibrium
solution $y(t)=0$ which is unstable but _not_ repelling. Notice that solutions that are near
$y(t)=0$ alternate between being very close to $y(t)=0$ and very far from $y(t)=0$ (dashed lines
below).

#{
  let xs = lq.linspace(0, 17, num: 200)
  let F(t, p_0) = {
    p_0 * calc.exp(1 / 7 * (calc.sin(t) - t * calc.cos(t)))
  }
  align(center, lq.diagram(
    xaxis: (label: [$t$], ticks: none),
    yaxis: (label: [$y$]),
    ylim: (-10, 10),
    xlim: (0, 17),
    ..(-1, -.5, .5, 1).map(p_0 => {
      lq.plot(xs, xs.map(x => F(x, p_0)), mark: none, stroke: (
        thickness: .5pt,
        paint: black,
        dash: (2pt, 1pt),
      ))
    }),
    //   lq.plot(xs, xs.map(x => 0), mark: none, stroke: (thickness: 1.5pt, paint: green.darken(30%))),
    lq.plot(xs, xs.map(x => 0), mark: none, stroke: (thickness: 1.5pt, paint: blue.darken(30%))),
  ))
}

- $y(t)=0$ is _unstable_ because solutions $y^*$ (dashed curves above) that start close to $y(t)=0$
  get far from $y(t)=0$ infinitely often.
- However, $y(t)=0$ is _not repelling_, because solutions $y^*$ close to but not equal to $0$ attain
  values arbitrarily close to zero infinitely often.

=== Other Classifications

There cannot be unstable and attracting equilibria, nor can there be stable and repelling
equilibria. But there can be other behaviours.

Consider the Van der Pol system:
$
  x' & = y \
  y' & = mu dot (1 - x^2) dot y - x
$
for $mu>0$.

Solutions to this system all end up with oscillatory behaviour and they all have the same period.
Here solutions are not attracted to an equilibrium, but they are attracted towards a solution which
is perfectly periodic (in this situation we say that the system has a _limit cycle_). The study of
what behaviour solutions can be "attracted to" leads to concepts like fractals and chaos (advanced
differential equations courses touch on these topics!).

#{
  let F(x, y) = (y, 0.08 * (1 - x * x) * y - x)
  let path1 = solve_2d_ivp(F, (11, -6.4), 400, Delta: .1, method: "rk4")
  let path2 = solve_2d_ivp(F, (-11, -6.4), 400, Delta: .1, method: "rk4")
  let path3 = solve_2d_ivp(F, (5, -10.4), 400, Delta: .1, method: "rk4")

  let diag = lq.diagram(
    title: [Van der Pol System\ with $mu=0.08$ in _Phase Space_],
    xaxis: (label: $x$, tick-distance: 3.9),
    yaxis: (label: $y$, tick-distance: 3.9),
    ylim: (-10, 10),
    xlim: (-10, 10),
    lq.plot(path1.map(((x, y)) => x), path1.map(((x, y)) => y), mark: none),
    lq.plot(path2.map(((x, y)) => x), path2.map(((x, y)) => y), mark: none, stroke: (
      dash: (4pt, 1pt),
    )),
    lq.plot(path3.map(((x, y)) => x), path3.map(((x, y)) => y), mark: none, stroke: (
      dash: (2pt, 2pt),
    )),
  )

  align(center, diag)
}

In the above diagram you can see the oval-shaped limit cycle in the center to which solutions are
attracted.

#example(
  prompt: [Find an classify all equilibrium solutions to $y'=sin(y)$.],
  [
    Since equilibrium solutions are constant solutions, we can solve for when $y'=0$ to find all
    equilibrium solutions. Solving,
    $
      y'=0=sin(y)
    $
    has solutions $y(t)=k dot pi$ for $k in ZZ$. Thus, $y'=sin(y)$ has an infinite number of
    equilibrium solutions.

    We will start classifying them one by one and then see if there is a pattern.

    Case $y(t)=0$: Suppose that $y approx 0$ and that $y>0$. From the differential equation, we know
    $ y' = sin("slightly bigger than" 0) > 0 $
    so $y(t)$ will increase; i.e., solutions near $y(t)=0$ but above $y(t)=0$ will tend away from
    $y(t)=0$. This means that $y(t)=0$ is _unstable_. Now, suppose $y approx 0$ and $y < 0$. Then
    $ y' = sin("slightly smaller than" 0) < 0 $
    and so $y(t)$ will be decreasing and move away from $0$. This means that $y(t)=0$ is is an
    unstable and _repelling_ equilibrium solution.

    Case $y(t)=pi$: Suppose that $y approx pi$ and that $y>pi$. Then
    $ y' = sin("slightly bigger than" pi) < 0 $
    so $y(t)$ will decrease, heading towards $pi$. Alternatively, suppose $y approx pi$ and
    $y < pi$. Then
    $ y' = sin("slightly smaller than" pi) > 0 $
    so $y(t)$ will increase, heading towards $pi$. This means that solutions near $y(t)=pi$ are
    attracted to $y(t)=pi$. Thus, $y(t)=pi$ is a _stable_ and _attracting_ equilibrium solution.

    To conclude, notice that $y'=sin(y)$ is periodic with period $2pi$; therefore, the nature of the
    equilibrium solutions will repeat every $2pi$. This gives a final classification of:
    #align(center, simple_table(
      headers: ("Equilibrium Solution", "Classification"),
      content: (
        [$y(t)=k dot pi$ for $k$ even],
        [unstable and repelling],
        [$y(t)=k dot pi$ for $k$ odd],
        [stable and attracting],
      ),
    ))
  ],
)


