
// This file is meant to be imported and not compiled on its own.
#import "../common/settings-book.typ": workbook, show_def
#import "../libs/_graphics.typ": slope_field
#import "@preview/lilaq:0.2.0" as lq
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

In module XXX we already saw _slope fields_.

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