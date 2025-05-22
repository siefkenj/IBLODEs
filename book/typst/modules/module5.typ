
// This file is meant to be imported and not compiled on its own.
#import "../common/settings-book.typ": workbook, show_def
#import "../libs/_graphics.typ": slope_field, vector_field
#import "../libs/_ode_solvers.typ": solve_2d_ivp
#import "@preview/lilaq:0.2.0" as lq
#import "@preview/tiptoe:0.3.0"
#let (sans, serif, module, definition, example) = workbook

In this module you will learn
- How slope fields can be used to analyze a differential equation.
- How phase portraits can be used to analyze a system of differential equations.

Sometimes we are interested in the precise behaviour of a solution to a differential equation,
but more often than not, we're more interested in the _qualities_ of
solutions. For example, we may want to know if an equilibrium solution is stable,
or if a solution is periodic/initially increasing/unbounded/etc.. Much of this information
can be deduced without actually solving or simulating solutions to the differential equation.

== Analyzing Slope Fields

In @mod:simulation we already saw _slope fields_.

#show_def("slope_field")

By looking at a slope field, we can visualize what whole ranges of solutions look like.

Consider the differential equation
$
  y' = y (1 - y) + x
$
#let F(x, y) = y * (1 - y) + x

and its slope field below.

#{
  align(
    center,
    slope_field(
      F,
      scale_segments: .25,
      xlim: (-2.5, 3),
      ylim: (-3, 3),
    ),
  )
}

From the slope field, we can see there are two qualitatively different types of solutions: those that decrease forever, and
those that eventually increase. We can roughly divide the slope field into regions where initial conditions in one region lead to decreasing
solutions, and initial conditions in the other region lead to eventually increasing solutions.

#{
  align(
    center,
    slope_field(
      F,
      scale_segments: .25,
      xlim: (-2.5, 3),
      ylim: (-3, 3),
      lq.plot(
        (-2.54, -2.37, -2.255, -2.1, -1.8, -1.45, -.8, -.1, 2.16, 4.04),
        (5.65, 2.16, 1.7, 1.3, .76, .34, -0.1, -.43, -1.13, -1.6),
        mark: none,
        stroke: (dash: (5pt, 2pt), thickness: 2pt, paint: green.darken(30%)),
      ),
      lq.fill-between(
        (-2.54, -2.37, -2.255, -2.1, -1.8, -1.45, -.8, -.1, 2.16, 4.04),
        (5.65, 2.16, 1.7, 1.3, .76, .34, -0.1, -.43, -1.13, -1.6),
        y2: (-4, -4, -4, -4, -4, -4, -4, -4, -4, -4),
        fill: green.darken(30%).transparentize(60%),
      ),
      lq.place(50%, -2, box(fill: white.transparentize(20%), inset: 4pt, [Decreasing])),
      lq.place(50%, 2, box(fill: white.transparentize(20%), inset: 4pt, [Eventually Increasing])),
    ),
  )
}

We can also see that increasing solutions tend towards a particular increasing solution.


#{
  align(
    center,
    slope_field(
      F,
      scale_segments: .3,
      xlim: (-2.5, 7),
      ylim: (-3, 4),
      lq.plot(
        lq.arange(1.7, 8, step: .3),
        lq.arange(1.7, 8, step: .3).map(x => 0.5 + calc.sqrt(.25 + x)),
        mark: none,
        stroke: (dash: (5pt, 2pt), thickness: 2pt, paint: red.darken(30%)),
      ),
      lq.place(
        2,
        -0.5,
        box(
          //         width: 8em,
          fill: white.transparentize(20%),
          inset: 4pt,
          text(size: 0.8em)[Increasing solutions\ tend towards the\ dashed line],
        ),
      ),
    ),
  )
}


== Systems of Differential Equations and Phase Portraits

Consider a modified version of the Ants-and-Aphids model from @mod:systems, where ants are removed by a farmer at a constant rate (10 per day).
#let Pant = $P_"ant"$
#let Paph = $P_"aphid"$
#let F(Pant, Paph) = (Pant + 0.5 * Paph - 10, 0.8 * Pant - 0.5 * Paph)
$
  &Pant' &=& Pant &+& 0.5 dot Paph space space &-& space 10\
  &Paph' &=& 0.5 dot Pant &-& 0.5 dot Paph &&
$
How can we make a slope field for this system?
If we make slope fields in component space, we miss out on important information. For example,
to compute $Pant'$ we need a value of $Paph$, but because the number of ants and the number
of aphids affect each other, we cannot just choose a value for $Paph$. The same issue arises for $Paph'$.
The conclusion is that a "slope field" for this system must have a $Pant$ axis, a $Paph$ axis, and a time axis. I.e., it
is three-dimensional.

#{
  import "@preview/plotsy-3d:0.1.0": plot-3d-vector-field

  let size = 20
  let scale_factor = 0.05
  let scale_len = 0.5
  let (xscale, yscale, zscale) = (0.3, 0.3, 0.3)
  let _i_func(P_ant, P_aphid, t) = (P_ant + 0.5 * P_aphid - 10)
  let _j_func(P_ant, P_aphid, t) = (0.8 * P_ant - 0.5 * P_aphid)
  let _k_func(P_ant, P_aphid, t) = 1
  let _norm(x, y, z) = calc.sqrt(
    _i_func(x, y, z) * _i_func(x, y, z) + _j_func(x, y, z) * _j_func(x, y, z) + _k_func(x, y, z) * _k_func(x, y, z),
  )
  let i_func(x, y, z) = _i_func(x, y, z) / _norm(x, y, z) * scale_len
  let j_func(x, y, z) = _j_func(x, y, z) / _norm(x, y, z) * scale_len
  let k_func(x, y, z) = _k_func(x, y, z) / _norm(x, y, z) * scale_len

  let i_func(x, y, z) = 0
  let j_func(x, y, z) = 0
  let k_func(x, y, z) = 1

  let color-func(x, y, z, x_lo, x_hi, y_lo, y_hi, z_lo, z_hi) = {
    return purple
  }


  align(
    center,
    plot-3d-vector-field(
      i_func,
      j_func,
      k_func,
      color-func: color-func,
      subdivisions: 4,
      subdivision_mode: "decrease",
      scale_dim: (xscale * scale_factor, yscale * scale_factor, zscale * scale_factor),
      xdomain: (0, size),
      ydomain: (0, size),
      zdomain: (0, size),
      // pad_high: (0,0,2),
      rotation_matrix: ((-1.5, 1.2, 4), (0, -1, 0)),
      axis_label_offset: (0.4, 0.2, 0.2),
      axis_text_offset: 0.08,
      vector_size: .1em,
    ),
  )
}

XXX make correct 3d slope field Figure

It's hard to glean information from a three-dimensional slope field. What if, instead, we
tried to encode information into the two-dimensional phase space?

Suppose we want to simulate a solution with initial conditions $(Pant,Paph) = (3,21)$ at time $0$.
#let dir = $(#F(3, 21).at(0), #F(3, 21).at(1))$
We would first compute
$(Pant', Paph') = dir$ and our estimate for $(Pant, Paph)$ at time $Delta$ would be
$
  (Pant, Paph) + Delta dot (Pant', Paph') quad =quad
  (3, 21) + Delta dot dir.
$
In other words, we start at $(3, 21)$ and move slightly in the direction of $dir$ (i.e., in the direction of $(Pant', Paph')$).

XXX Figure showing simulated solution with some tangent vectors

What if, we drew the vector $(Pant', Paph')$ at many points in phase space? Doing so, we would produce a _phase portrait_.

#show_def("phase_portrait")

#align(
  center,
  vector_field(
    title: lq.title([Phase Portrait for\ Ants--Aphids Model]),
    F,
    xlim: (0, 27),
    ylim: (0, 27),
    spacing: (2.5, 2.5),
    scale_segments: 25.0,
    width: 5cm,
    height: 5cm,
    xaxis: (position: 0, tip: tiptoe.stealth, subticks: none, label: $Pant$),
    yaxis: (position: 0, tip: tiptoe.stealth, subticks: none, label: $Paph$),
  ),
)

Analyzing the phase portrait, like the slope field, we can see solutions with different qualities. For example,
we can divide phase space into sets of initial conditions where the ants population goes to zero and where the ants population
is unbounded.

#align(
  center,
  vector_field(
    title: lq.title([Phase Portrait for\ Ants--Aphids Model]),
    F,
    xlim: (0, 27),
    ylim: (0, 27),
    spacing: (2.5, 2.5),
    scale_segments: 25.0,
    width: 5cm,
    height: 5cm,
    xaxis: (position: 0, tip: tiptoe.stealth, subticks: none, label: $Pant$),
    yaxis: (position: 0, tip: tiptoe.stealth, subticks: none, label: $Paph$),
    lq.fill-between(
      (-1, 20),
      // Line is y = 2/(3+sqrt(13)) * (x - 8.7)
      (32, -37),
      y2: (-37, -37),
      fill: green.darken(30%).transparentize(60%),
    ),
    lq.plot(
      (-1, 20),
      (32, -37),
      mark: none,
      stroke: (dash: (5pt, 2pt), thickness: 2pt, paint: green.darken(30%)),
    ),
    lq.place(0%, 5, box(fill: white.transparentize(20%), inset: 4pt, [$Pant arrow 0$])),
    lq.place(70%, 18, box(fill: white.transparentize(20%), inset: 4pt, [$Pant arrow infinity$])),
  ),
)

We could further subdivide phase space into regions where solutions (in phase space) are concave up or concave down, where ants/aphids achieve a
maximum population, etc.. How we analyze a phase portrait depends on what questions we are trying to answer.

=== Phase Portraits and Missing Time

One important piece of information that is missing from phase portraits is a sense of time.
While component space includes the independent variable, phase space does not. We partially make up for this
by adjusting the length of an arrow in a phase portrait to correspond to the speed that a solution passes through
the arrow at that point.


#let F1(x, y) = (2, 1)
#let F2(x, y) = (2 * (calc.abs(2 * x + y - 5) + .1), (calc.abs(2 * x + y - 5) + .1))
#align(
  center,
  {
    vector_field(
      title: lq.title([Constant Speed Solutions]),
      F1,
      xlim: (0, 5),
      ylim: (0, 5),
      spacing: (.5, .5),
      scale_segments: 30.0,
      width: 5cm,
      height: 5cm,
      xaxis: (position: 0, tip: tiptoe.stealth, subticks: none, ticks: none),
      yaxis: (position: 0, tip: tiptoe.stealth, subticks: none, ticks: none),
    )
    h(2em)
    vector_field(
      title: lq.title([Solutions _Slow Down_ then\ _Speed Up_]),
      F2,
      xlim: (0, 5),
      ylim: (0, 5),
      spacing: (.5, .5),
      scale_segments: 7.0,
      width: 5cm,
      height: 5cm,
      xaxis: (position: 0, tip: tiptoe.stealth, subticks: none, ticks: none),
      yaxis: (position: 0, tip: tiptoe.stealth, subticks: none, ticks: none),
    )
  },
)

In the phase portraits above, solutions (in phase space) move in a straight line up and to the right. However, in the
rightmost phase portrait, we can see that solutions slow down (almost to a stop) and then speed up again. When graphed
in component space, the difference is visible.

#{
  let _Delta = 0.05
  let steps = 35
  let soln1 = solve_2d_ivp(F1, (0, 1), steps, Delta: _Delta, method: "rk4")
  let soln2 = solve_2d_ivp(F2, (0, 1), steps, Delta: _Delta, method: "rk4")
  let xs = lq.arange(0, _Delta * (steps + 1), step: _Delta)
  align(
    center,
    {
      lq.diagram(
        title: lq.title([Constant Speed Solutions\ _Component Space_]),
        lq.plot(
          xs,
          soln1.map(((x, y)) => x),
          mark: none,
        ),
        lq.plot(
          xs,
          soln1.map(((x, y)) => y),
          mark: none,
        ),
        xaxis: (position: 0, tip: tiptoe.stealth, subticks: none, ticks: none, label: $t$),
        yaxis: (position: 0, tip: tiptoe.stealth, subticks: none, ticks: none),
      )
      h(2em)
      lq.diagram(
        title: lq.title([Solutions _Slow Down_ then\ _Speed Up_\ _Component Space_]),
        lq.plot(
          xs,
          soln2.map(((x, y)) => x),
          mark: none,
        ),
        lq.plot(
          xs,
          soln2.map(((x, y)) => y),
          mark: none,
        ),
        xaxis: (position: 0, tip: tiptoe.stealth, subticks: none, ticks: none, label: $t$),
        yaxis: (position: 0, tip: tiptoe.stealth, subticks: none, ticks: none),
      )
    },
  )
}

XXX Add example that asks, say, to draw a phase portrait for periodic solutions that are sines vs. that aren't.

An important note is that phase portraits are useful for _autonomous equations_, equations where the independent variable does not appear.
Non-autonomous must be analyzed a different way.

== Phase Portraits for Single Equations

XXX Finish - write about 1d phase portraits