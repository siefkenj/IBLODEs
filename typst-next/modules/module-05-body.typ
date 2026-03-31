
// This file is meant to be imported and not compiled on its own.
#import "../common/settings-book.typ": show_def, workbook
#import "../libs/_graphics.typ": slope_field, vector_field
#import "../libs/_ode_solvers.typ": solve_2d_ivp
#import "@preview/lilaq:0.4.0" as lq
#import "@preview/tiptoe:0.3.1"
#let (sans, serif, module, definition, example) = workbook

In this module you will learn
- How slope fields can be used to analyze a differential equation.
- How phase portraits can be used to analyze a system of differential equations.

Sometimes we are interested in the precise behaviour of a solution to a differential equation, but
more often than not, we're interested in the _qualities_ of solutions. For example, we may want to
know if an equilibrium solution is stable, or if a solution is periodic/initially
increasing/unbounded/etc.. Much of this information can be deduced without actually solving or
simulating solutions to the differential equation.

== Analyzing Slope Fields

In @mod:simulation we saw _slope fields_.

#show_def("slope_field")

By looking at a slope field, we can visualize whole ranges of solutions.

#v(1em)
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

From the slope field, we can see there are two qualitatively different types of solutions: those
that decrease forever, and those that eventually increase. We can roughly divide the slope field
into regions where initial conditions in one region lead to decreasing solutions, and initial
conditions in the other region lead to eventually increasing solutions.

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

Consider a modified version of the Ants-and-Aphids model from @mod:systems. In this model, there is
a farmer that removes ants at a constant rate (10 thousand per day).
#let Pant = $P_"ant"$
#let Paph = $P_"aphid"$
#let F(Pant, Paph) = (Pant + 0.5 * Paph - 10, 0.8 * Pant - 0.5 * Paph)
$
  & Pant' & = & Pant         & + & 0.5 dot Paph space space & - & space 10 \
  & Paph' & = & 0.5 dot Pant & - & 0.5 dot Paph             &   &
$
How can we make a slope field for this system? If we make slope fields in component space, we miss
out on important information. For example, to compute $Pant'$ we need a value of $Paph$, but because
the number of ants and the number of aphids affect each other, we cannot just choose a value for
$Paph$. The same issue arises for $Paph'$. The conclusion is that a "slope field" for this system
must have a $Pant$ axis, a $Paph$ axis, and a time axis. I.e., it is three-dimensional.

// https://www.desmos.com/3d/xd9x9gilsk
#{
  show: align.with(center)
  image("../images/ant-aphid-3d.png", width: 3in)
}

// XXX make correct 3d slope field Figure
// #{
//   import "@preview/plotsy-3d:0.1.0": plot-3d-vector-field

//   let size = 20
//   let scale_factor = 0.05
//   let scale_len = 0.5
//   let (xscale, yscale, zscale) = (0.3, 0.3, 0.3)
//   let _i_func(P_ant, P_aphid, t) = (P_ant + 0.5 * P_aphid - 10)
//   let _j_func(P_ant, P_aphid, t) = (0.8 * P_ant - 0.5 * P_aphid)
//   let _k_func(P_ant, P_aphid, t) = 1
//   let _norm(x, y, z) = calc.sqrt(
//     _i_func(x, y, z) * _i_func(x, y, z) + _j_func(x, y, z) * _j_func(x, y, z) + _k_func(x, y, z) * _k_func(x, y, z),
//   )
//   let i_func(x, y, z) = _i_func(x, y, z) / _norm(x, y, z) * scale_len
//   let j_func(x, y, z) = _j_func(x, y, z) / _norm(x, y, z) * scale_len
//   let k_func(x, y, z) = _k_func(x, y, z) / _norm(x, y, z) * scale_len

//   let i_func(x, y, z) = 0
//   let j_func(x, y, z) = 0
//   let k_func(x, y, z) = 1

//   let color-func(x, y, z, x_lo, x_hi, y_lo, y_hi, z_lo, z_hi) = {
//     return purple
//   }


//   align(
//     center,
//     plot-3d-vector-field(
//       i_func,
//       j_func,
//       k_func,
//       color-func: color-func,
//       subdivisions: 4,
//       subdivision_mode: "decrease",
//       scale_dim: (xscale * scale_factor, yscale * scale_factor, zscale * scale_factor),
//       xdomain: (0, size),
//       ydomain: (0, size),
//       zdomain: (0, size),
//       // pad_high: (0,0,2),
//       rotation_matrix: ((-1.5, 1.2, 4), (0, -1, 0)),
//       axis_label_offset: (0.4, 0.2, 0.2),
//       axis_text_offset: 0.08,
//       vector_size: .1em,
//     ),
//   )
// }


It's hard to glean information from a three-dimensional slope field. What if, instead, we tried to
encode information into two-dimensional phase space?

Suppose we want to simulate a solution with initial conditions $(Pant,Paph) = (3,21)$ at time $0$.
#let dir = $(#F(3, 21).at(0), #F(3, 21).at(1))$
We would first compute $(Pant', Paph') = dir$ and our estimate for $(Pant, Paph)$ at time $Delta$
would be
$
  (Pant, Paph) + Delta dot (Pant', Paph') quad =quad
  (3, 21) + Delta dot dir.
$
In other words, we start at $(3, 21)$ and move slightly in the direction of $dir$; i.e. we move in
the direction of $(Pant', Paph')$. Thus, we see that $(Pant', Paph')$ shows the trajectory of a
solution curve passing through $(Pant, Paph)$.

Overlaying the vectors $(Pant', Paph')$ on a plot of a solution curve, we can see that
$(Pant', Paph')$ is always tangent to the solution curve.

#{
  let _Delta = 0.1
  let steps = 24
  let soln = solve_2d_ivp(F, (3, 21), steps, Delta: _Delta, method: "rk4")
  let xs = lq.arange(0, _Delta * (steps + 1), step: _Delta)
  let arrow_samples = soln.chunks(5).map(v => v.at(0))
  align(
    center,
    lq.diagram(
      title: lq.title([$Pant$ vs $Paph$\ $Pant(0)=3$\ $Paph(0)=21$]),
      xaxis: (label: $Pant$),
      yaxis: (label: $Paph$),

      ..arrow_samples.map(((x, y)) => {
        lq.line(
          (x, y),
          (x + 6 * _Delta * F(x, y).at(0), y + 6 * _Delta * F(x, y).at(1)),
          tip: tiptoe.stealth,
          stroke: (thickness: 2pt, paint: orange.darken(10%)),
          label: if x == 3 { [$(Pant', Paph')$ #v(.5em)] } else { none },
        )
      }),
      lq.plot(
        soln.map(((x, y)) => x),
        soln.map(((x, y)) => y),
        mark: none,
        stroke: (thickness: 2pt, paint: blue, dash: (10pt, 2pt)),
        label: [Solution],
      ),
    ),
  )
}

What if, instead of just drawing $(Pant', Paph')$ along a single solution curve, we drew them at all
points in phase space? Doing so, we would produce a _phase portrait_.

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

Analyzing the phase portrait, like the slope field, we can see solutions with different qualities.
For example, we can divide phase space into sets of initial conditions where the ant population goes
to zero and another region where the ant population is unbounded.

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

We could further subdivide phase space into regions where solutions (in phase space) are concave up
or concave down, where ants/aphids achieve a maximum population, etc.. How we analyze a phase
portrait depends on what questions we are trying to answer.

=== Phase Portraits and Missing Time

One important piece of information that is missing from phase portraits is a sense of time. This is
why phase portraits should only be used to analyze _autonomous_ systems of equations. While
component space includes the independent variable, phase space does not. We partially make up for
this by adjusting the length of an arrow in a phase portrait to correspond to the speed that a
solution passes through the arrow at that point.


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

In the phase portraits above, solutions (in phase space) move in a straight line up and to the
right. However, in the rightmost phase portrait, we can see that solutions slow down (almost to a
stop) and then speed up again. When graphed in component space, the difference is visible.

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

All of this is to say that the length of the arrows in a phase portrait are important; they help you
to distinguish properties of differential equations that merely studying plots in phase space would
miss.

#example(
  prompt: [Draw two phase portraits. The graphs of solutions in _phase space_ should look the same
    for both phase portraits, but the graphs of solutions in _component space_ should look
    different.],
  [
    Consider the phase portraits (A) and (B) below.

    #let F1(x, y) = (-y, x)
    #let F2(x, y) = (
      -y * (1.15 + calc.sin(4 * calc.atan2(y, x))),
      x * (1.15 + calc.sin(4 * calc.atan2(y, x))),
    )
    #{
      align(
        center,
        {
          vector_field(
            title: lq.title([(A)]),
            F1,
            xlim: (-5, 5),
            ylim: (-5, 5),
            spacing: (.5, .5),
            scale_segments: 15.0,
            width: 5cm,
            height: 5cm,
            xaxis: (position: 0, tip: tiptoe.stealth, subticks: none, ticks: none),
            yaxis: (position: 0, tip: tiptoe.stealth, subticks: none, ticks: none),
          )
          h(2em)
          vector_field(
            title: lq.title([(B)]),
            F2,
            xlim: (-5, 5),
            ylim: (-5, 5),
            spacing: (.5, .5),
            scale_segments: 10.0,
            width: 5cm,
            height: 5cm,
            xaxis: (position: 0, tip: tiptoe.stealth, subticks: none, ticks: none),
            yaxis: (position: 0, tip: tiptoe.stealth, subticks: none, ticks: none),
          )
        },
      )
    }

    In both phase portraits, the graphs of solutions (in phase space) will look like circles.
    However, the component graphs for solutions look very different.

    #{
      let _Delta = 0.05
      let steps = 200
      let soln1 = solve_2d_ivp(F1, (0, 1), steps, Delta: _Delta, method: "rk4")
      let soln2 = solve_2d_ivp(F2, (0, 1), steps, Delta: _Delta, method: "rk4")
      let xs = lq.arange(0, _Delta * (steps + 1), step: _Delta)
      align(
        center,
        {
          lq.diagram(
            title: lq.title([Component Graphs for (A)]),
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
            title: lq.title([Component Graphs for (B)]),
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

  ],
)

=== Phase Portraits and Continuity

While solutions to differential equations are always continuous (they have derivatives after all),
we haven't yet discussed continuity of the differential equations themselves. While we don't require
differential equations to be continuous, most differential equations that we will study are
continuous. And, one can usually tell by looking at a phase portrait if a system of differential
equations is continuous.

For example, consider the following two phase portraits. Each phase portrait is for a system with an
equilibrium point at $(0,0)$.

#let F1(x, y) = (-y, x)
#let F2(x, y) = (
  -y * 1 / (.001 + calc.sqrt(x * x + y * y)),
  x * 1 / (.001 + calc.sqrt(x * x + y * y)),
)
#{
  align(
    center,
    {
      vector_field(
        title: lq.title([Continuous System (A)]),
        F1,
        xlim: (-5, 5),
        ylim: (-5, 5),
        spacing: (.5, .5),
        scale_segments: 15.0,
        width: 5cm,
        height: 5cm,
        xaxis: (position: 0, tip: tiptoe.stealth, subticks: none, ticks: none),
        yaxis: (position: 0, tip: tiptoe.stealth, subticks: none, ticks: none),
      )
      h(2em)
      vector_field(
        title: lq.title([Discontinuous System (B)]),
        F2,
        xlim: (-5, 5),
        ylim: (-5, 5),
        spacing: (.5, .5),
        scale_segments: 60.0,
        width: 5cm,
        height: 5cm,
        xaxis: (position: 0, tip: tiptoe.stealth, subticks: none, ticks: none),
        yaxis: (position: 0, tip: tiptoe.stealth, subticks: none, ticks: none),
      )
    },
  )
}

The phase portrait on the left, (A), is the phase portrait for a continuous system of differential
equations while the one on the right, (B), is the phase portrait for a discontinuous system of
differential equations. How can we tell? The giveaway is at the origin.

Look at phase portrait (B). All of the arrows are the same length, which means solutions always move
at the same "speed". However, the speed of the equilibrium solution at $(0,0)$ is
zero.#footnote[Equilibrium solutions don't move in phase space, so their speed in phase space is
  always zero.] Thus, the speed of a solution does not continuously vary as a function of the
position in phase space. This means that the underlying system of differential equations was not
continuous.

In contrast, in phase portrait (A), the arrows near the origin are very short, which means that
solutions near the origin move very slowly. The speed decreases to zero as one gets closer and
closer to the equilibrium point at $(0,0)$. This is compatible with having an underlying system of
differential equations which is continuous.


// == Phase Portraits for Single Equations

// XXX Finish - write about 1d phase portraits
