#import "../libs/_graphics.typ": slope_field
#import "../libs/_workbook.typ": label_module, simple_table
#import "../libs/_ode_solvers.typ": solve_1d_ivp
#import "../libs/_spreadsheet.typ": draw_spreadsheet
#import "@preview/lilaq:0.2.0" as lq
#import "@preview/tiptoe:0.3.0"

#label_module(<mod:simulation>)


// This file is meant to be imported and not compiled on its own.
#import "../common/settings-book.typ": workbook, show_def
#let (sans, serif, module, definition, example) = workbook

In this module you will learn
- How to use slope fields and Euler's method to approximate solutions to differential equations.

Most differential equations do not have explicit _elementary_ solutions. That is, solutions which can be written in
terms of polynomials, exponentials, logarithms, etc..
Put another way: most differential equations do not have "nice" solutions. However, most ordinary differential equations
that you will encounter _will have solutions_ (even though you cannot write them down).

There are two approaches when a differential equation cannot be explicitly "solved":
1. Make up a new name for a function _defined_ to be the solution.
2. Approximate the solution.

Before the days of computers, approach 1 was commonplace. If you've heard of Bessel functions or Airy functions, these are functions defined to be the solutions
to particular differential equations.#footnote[Even the humble exponential is often defined to be the solution to $f'(t)=f(t)$ which satisfies $f(0)=1$.]

In this course, we will focus on approach 2.

== Visual Estimation

Suppose that $P(t)$ models the number of bacteria (in billions) in a petri dish at time $t$. (Since the bacteria are so numerous,
it makes sense to think of $P(t)$ as continuous.) Further, suppose that $P$ satisfies
// The F below makes a reasonable picture, but it is complicated. An alternative is
//#let F(x, y) =  -y + 1/2
// but maybe that is too simple?
#let F(x, y) = calc.sin(calc.pi / 2 * y - x) - 1.5
#let y_0 = 3
#let approx_val = (
  solve_1d_ivp(
    F,
    (
      0,
      y_0,
    ),
    100,
    Delta: 0.01,
    method: "rk4",
  )
    .last()
    .at(1)
)
#let approx_rounded = calc.round(approx_val, digits: 1)
#let formula = $sin(space.hair pi / 2 dot P(t) - t space.hair) - 1.5$
$
  P'(t) = formula wide "and" wide P(0) = #(y_0).
$
Our task is to approximate $P(1)$.

We may not know exactly what our solution curve is, but the differential equation tells us what tangent lines
to the solution curve look like. It stands to reason that if we
draw little segments of tangent lines all over the $(t,P)$--plane, we can visually guess at the shape of the solution curve.

#{
  align(
    center,
    slope_field(
      F,
      xlim: (-.3, 1.1),
      ylim: (-.3, 3.3),
      width: 7cm,
      height: 3cm,
      spacing: (.06, .25),
      scale_segments: .05,
      yaxis: (position: 0, tip: tiptoe.stealth, filter: ((v, d) => calc.round(v, digits: 2) in (1., 2., 3.))),
      xaxis: (position: 0, tip: tiptoe.stealth, filter: ((v, d) => calc.round(v, digits: 2) in (0, 1.))),
      xlabel: $t$,
      ylabel: lq.label($P$, dx: -1cm),
    ),
  )
}

The above diagram, where small segments of tangent lines to solutions populate the plane, is called a _slope field_.

#show_def("slope_field")

Starting at $(t,P(t)) = (0,#(y_0))$, we can trace out what an approximate solution curve looks like.

#{
  let soln = solve_1d_ivp(
    F,
    (
      0,
      y_0,
    ),
    20,
    Delta: 0.05,
    method: "rk4",
  )
  let xs = soln.map(((x, y)) => x)
  let ys = soln.map(((x, y)) => y)

  align(
    center,
    slope_field(
      F,
      xlim: (-.3, 1.1),
      ylim: (-.3, 3.3),
      width: 7cm,
      height: 3cm,
      spacing: (.06, .25),
      scale_segments: .05,
      // yaxis: (position: 0, tip: tiptoe.stealth, filter: ((v, d) => false)),
      yaxis: (position: 0, tip: tiptoe.stealth, filter: ((v, d) => calc.round(v, digits: 2) in (1., 2., 3.))),
      xaxis: (position: 0, tip: tiptoe.stealth, filter: ((v, d) => calc.round(v, digits: 2) in (0, 1.))),
      xlabel: $t$,
      ylabel: lq.label($P$, dx: -1cm),
      lq.plot(
        xs,
        ys,
        mark: none,
        stroke: (paint: gray.darken(20%), thickness: 1pt, dash: (2pt, .5pt)),
      ),
    ),
  )
}

The solution curve we draw should be tangent to every line segment it passes through. In the drawing above, the solution curve is decreasing
and slightly concave up. Based on the drawing, we can estimate $P(1) approx #(approx_rounded)$.

Tracing out solutions on slope fields is a good way to see overall qualities of a solution, like whether it is increasing/decreasing or its concavity.
But, its numerical accuracy is limited. A small change in how we sketched the curve could lead to estimates
that $P(1) approx #(calc.round(approx_rounded - .2, digits: 1))$ or $P(1) approx #(approx_rounded + .2)$,
a wide range. If we're after precise numerical estimates, we can formalize this "slope field estimation" by means of Euler's method.



== Euler's Method

Recall that $P(t)$ models the number of bacteria (in billions) in a petri dish at time $t$ with
$
  P'(t) = formula quad quad "and" quad quad P(0) = #(y_0).
$

Our task is to numerically approximate $P(1)$.

A simple approach would be to approximate $P(1)$ using a tangent line through the point $(0, P(0))$. We know the slope $P'(0)= #(F(0, y_0))$, and
so we get an approximation of $ P(1) approx P(0) + P'(0)(t-0)lr(|, size: #(0pt + 150%))_(t=1)=#(y_0 + F(0, y_0)). $

#let (soln_xs, soln_ys) = {
  let soln = solve_1d_ivp(
    F,
    (
      0,
      y_0,
    ),
    20,
    Delta: 0.05,
    method: "rk4",
  )
  let xs = soln.map(((x, y)) => x)
  let ys = soln.map(((x, y)) => y)
  (xs, ys)
}

#{
  let soln = solve_1d_ivp(
    F,
    (
      0,
      y_0,
    ),
    1,
    Delta: 1,
    method: "euler",
  )
  let xs = soln.map(((x, y)) => x)
  let ys = soln.map(((x, y)) => y)

  align(
    center,
    lq.diagram(
      xlim: (-.3, 1.1),
      ylim: (-.3, 3.3),
      width: 7cm,
      height: 3cm,
      yaxis: (position: 0, tip: tiptoe.stealth, filter: ((v, d) => false)),
      xaxis: (position: 0, tip: tiptoe.stealth, filter: ((v, d) => calc.round(v, digits: 2) in (0, 1.))),
      xlabel: $t$,
      ylabel: lq.label($P$, dx: -1cm),
      lq.plot(
        soln_xs,
        soln_ys,
        mark: none,
        stroke: (paint: gray.darken(20%), thickness: 1pt, dash: (2pt, .5pt)),
      ),
      lq.plot(
        xs,
        ys,
        //mark: "square",
        //stroke: (paint: gray.darken(20%), thickness: 1pt, dash: (2pt, .5pt)),
      ),
    ),
  )
}

Our approximation is an underestimate. How can we be more accurate? By using two tangent lines!

A tangent line is a good approximation to a function near the point of tangency. So, instead of approximating $P(1)$ using a tangent line at $t=0$, let's approximate $P(0.5)$ using a tangent line at $t=0$
and then approximate $P(1)$ using a tangent line at $t=0.5$.

Unfortunately, we won't know the exact value of $P(0.5)$, so we cannot use the _true_ tangent line to the solution curve at $t=0.5$.
But, we know an approximate value of $P(0.5)$. For now, we will assume this approximate value is close enough.

$
  P_"approx" (0.5) &= P(0) &+& P'(0)dot (t-0)lr(|, size: #(0pt + 150%))_(t=1 / 2) &= underbrace(#(str(y_0 + F(0, y_0) * .5)), #[Estimate from tangent line\ at $(0, P(0))$]) \
  P_"approx" (1) &= P_"approx" (0.5) &+& P'_"approx" (0.5)dot (t - 0.5)lr(|, size: #(0pt + 150%))_(t=1) & \
  &=#(y_0 + F(0, y_0) * .5) &+& (#(calc.round(F(0.5, (y_0 + F(0, y_0) * .5)), digits: 2)))dot (t - 0.5)lr(|, size: #(0pt + 150%))_(t=1) &=
  underbrace(#(str(calc.round(y_0 + F(0, y_0) * .5 + F(0.5, (y_0 + F(0, y_0) * .5)) * .5, digits: 2))), #[Estimate from tangent line\ at $(0.5, P_"approx" (0.5))$])
$

#{
  let soln = solve_1d_ivp(
    F,
    (
      0,
      y_0,
    ),
    2,
    Delta: .5,
    method: "euler",
  )
  let xs = soln.map(((x, y)) => x)
  let ys = soln.map(((x, y)) => y)

  align(
    center,
    lq.diagram(
      xlim: (-.3, 1.1),
      ylim: (-.3, 3.3),
      width: 7cm,
      height: 3cm,
      yaxis: (position: 0, tip: tiptoe.stealth, filter: ((v, d) => false)),
      xaxis: (position: 0, tip: tiptoe.stealth, filter: ((v, d) => calc.round(v, digits: 2) in (0, 1.))),
      xlabel: $t$,
      ylabel: lq.label($P$, dx: -1cm),
      lq.plot(
        soln_xs,
        soln_ys,
        mark: none,
        stroke: (paint: gray.darken(20%), thickness: 1pt, dash: (2pt, .5pt)),
      ),
      lq.plot(
        xs,
        ys,
        //mark: "square",
        //stroke: (paint: gray.darken(20%), thickness: 1pt, dash: (2pt, .5pt)),
      ),
    ),
  )
}

This process becomes more accurate the more (approximate) tangent lines we use. Here is a picture showing what happens if we use four tangent lines.

#{
  let soln = solve_1d_ivp(
    F,
    (
      0,
      y_0,
    ),
    4,
    Delta: .25,
    method: "euler",
  )
  let xs = soln.map(((x, y)) => x)
  let ys = soln.map(((x, y)) => y)

  align(
    center,
    lq.diagram(
      xlim: (-.3, 1.1),
      ylim: (-.3, 3.3),
      width: 7cm,
      height: 3cm,
      yaxis: (position: 0, tip: tiptoe.stealth, filter: ((v, d) => false)),
      xaxis: (position: 0, tip: tiptoe.stealth, filter: ((v, d) => calc.round(v, digits: 2) in (0, 1.))),
      xlabel: $t$,
      ylabel: lq.label($P$, dx: -1cm),
      lq.plot(
        soln_xs,
        soln_ys,
        mark: none,
        stroke: (paint: gray.darken(20%), thickness: 1pt, dash: (2pt, .5pt)),
      ),
      lq.plot(
        xs,
        ys,
        //mark: "square",
        //stroke: (paint: gray.darken(20%), thickness: 1pt, dash: (2pt, .5pt)),
      ),
    ),
  )
}

The process of using many tangent lines to iteratively approximate a solution to a differential equation is called
_Euler's method_, and the resulting approximation is called an _Euler approximation_.

#show_def("eulers_method")

When applying Euler's method, the big decision is how many tangent lines to use. This is often expressed in terms of a _step size_, typically
denoted by $Delta$, where $Delta = "domain of approximation" / "# of tangent lines used"$.

#example(
  prompt: [Use Euler's method to approximate $P(1)$ for the differential equation
    $
      P'(t) = formula
    $

    with initial condition $P(0) = #(y_0)$, using a step size of $Delta = .25$.
  ],
  [
    We will implement Euler's method by making a table to help us track the relevant quantities.

    #align(
      center,
      simple_table(
        headers: (
          [Step],
          $t$,
          $P_"approx" (t)$,
          $P'_"approx" (t)$,
        ),
        content: (sym.dots.v, sym.dots.v, sym.dots.v, sym.dots.v),
      ),
    )

    We can start by filling out the "Step" and $t$ columns. We start at $t=0$ and at Step $0$. Since we have a step size of $Delta = .25$, we will
    increment $t$ by $Delta$ at each step until we reach $t=1$.

    #align(
      center,
      simple_table(
        headers: (
          [Step],
          $t$,
          $P_"approx" (t)$,
          $P'_"approx" (t)$,
        ),
        content: (
          $0$,
          $0$,
          none,
          none,
          $1$,
          $0.25$,
          none,
          none,
          $2$,
          $0.5$,
          none,
          none,
          $3$,
          $0.75$,
          none,
          none,
          $4$,
          $1$,
          none,
          none,
        ),
      ),
    )

    At time $t=0$, we know the exact value of $P(t)$ and of $P'(t)$, so we can fill in the first row of the table.
    #let soln = solve_1d_ivp(
      F,
      (
        0,
        y_0,
      ),
      4,
      Delta: 0.25,
      method: "euler",
    )
    #let P_approx = soln.map(((x, y)) => y)
    #let P_prime_approx = soln.map(((x, y)) => F(x, y))
    #align(
      center,
      simple_table(
        headers: (
          [Step],
          $t$,
          $P_"approx" (t)$,
          $P'_"approx" (t)$,
        ),
        content: (
          $0$,
          $0$,
          $#(P_approx.at(0))$,
          $#(P_prime_approx.at(0))$,
          $1$,
          $0.25$,
          none,
          none,
          $2$,
          $0.5$,
          none,
          none,
          $3$,
          $0.75$,
          none,
          none,
          $4$,
          $1$,
          none,
          none,
        ),
      ),
    )

    To find $P_"approx" (0.25)$, we use a tangent line centered at $(t, P)=(0, 3)$. Thus,
    $
      P_"approx" (0.25) = P(0) + P'_"approx" (0)dot (t - 0)lr(|, size: #(0pt + 150%))_(t=0.25) = 3 + (#(P_prime_approx.at(0)))dot (0.25 - 0) = #(P_approx.at(1)).
    $
    We can now fill in the second row of the table, noting that we get $P'_"approx" (0.25)$ from the formula
    $P'(t) = formula$.

    #align(
      center,
      simple_table(
        headers: (
          [Step],
          $t$,
          $P_"approx" (t)$,
          $P'_"approx" (t)$,
        ),
        content: (
          $0$,
          $0$,
          $#(P_approx.at(0))$,
          $#(P_prime_approx.at(0))$,
          $1$,
          $0.25$,
          $#(P_approx.at(1))$,
          $#(calc.round(P_prime_approx.at(1), digits: 3))$,
          $2$,
          $0.5$,
          none,
          none,
          $3$,
          $0.75$,
          none,
          none,
          $4$,
          $1$,
          none,
          none,
        ),
      ),
    )

    We can now compute $P_"approx" (0.5)$ using a tangent line centered at $(t, P)=(0.25, #(P_approx.at(1)))$.
    $
      P_"approx" (0.5) &= P_"approx" (0.25) + P'_"approx" (0.25)dot (t - 0.25)lr(|, size: #(0pt + 150%))_(t=0.5) \
      &= #(P_approx.at(1)) + (#(calc.round(P_prime_approx.at(1), digits: 3)))dot (0.5 - 0.25) = #(calc.round(P_approx.at(2), digits: 3)).
    $
    and so

    #align(
      center,
      simple_table(
        headers: (
          [Step],
          $t$,
          $P_"approx" (t)$,
          $P'_"approx" (t)$,
        ),
        content: (
          $0$,
          $0$,
          $#(P_approx.at(0))$,
          $#(P_prime_approx.at(0))$,
          $1$,
          $0.25$,
          $#(P_approx.at(1))$,
          $#(calc.round(P_prime_approx.at(1), digits: 3))$,
          $2$,
          $0.5$,
          $#(calc.round(P_approx.at(2), digits: 3))$,
          $#(calc.round(P_prime_approx.at(2), digits: 3))$,
          $3$,
          $0.75$,
          none,
          none,
          $4$,
          $1$,
          none,
          none,
        ),
      ),
    )

    Continuing this process, we can fill in the rest of the table.
    #align(
      center,
      simple_table(
        headers: (
          [Step],
          $t$,
          $P_"approx" (t)$,
          $P'_"approx" (t)$,
        ),
        content: (
          $0$,
          $0$,
          $#(P_approx.at(0))$,
          $#(P_prime_approx.at(0))$,
          $1$,
          $0.25$,
          $#(P_approx.at(1))$,
          $#(calc.round(P_prime_approx.at(1), digits: 3))$,
          $2$,
          $0.5$,
          $#(calc.round(P_approx.at(2), digits: 3))$,
          $#(calc.round(P_prime_approx.at(2), digits: 3))$,
          $3$,
          $0.75$,
          $#(calc.round(P_approx.at(3), digits: 3))$,
          $#(calc.round(P_prime_approx.at(3), digits: 3))$,
          $4$,
          $1$,
          $#(calc.round(P_approx.at(4), digits: 3))$,
          none,
        ),
      ),
    )
    This gives an Euler estimate of
    $
      P(1) approx P_"approx" (1) = #(calc.round(P_approx.at(4), digits: 3)).
    $ (Note, there is no need to compute $P'_"approx" (1)$ since we are not using it, but there is no harm in computing it either.)

  ],
)

== Implementing Euler's Method

As seen in the previous example, Euler's method can be efficiently implemented using a table.
This processes is worth doing a few times by hand, but, in truth,
it's what computers are made for.

Though you can easily implement Euler's method using general purpose programming languages like Python, Mathlab, etc., there is
one type of software that excels#footnote[Pun intended.] at implementing table-based algorithms: spreadsheets.

@app:spreadsheet gives an overview of how to use spreadsheets. In this section we assume a basic familiarity.

To use a spreadsheet to implement Euler's method, we will recreate the table from the previous example. We start by
- labelling our columns
- inputting our initial conditions, and
- setting up a formula that increments $t$ by $Delta$ at each step.
For this example, we will use $Delta=0.25$ and our familiar initial value problem $P'(t) = formula$ with $P(0) = 3$.

#let spreadsheet_so_far = (
  "A1": (
    value: `t`,
    alignment: center,
  ),
  "B1": (
    value: `P(t)`,
    alignment: center,
  ),
  "C1": (
    value: `P'(t)`,
    alignment: center,
  ),
  "A2": (
    value: "0",
  ),
  "A3": (
    value: "0.25",
  ),
  "A4": (
    value: "0.5",
  ),
  "A5": (
    value: "0.75",
  ),
  "A6": (
    value: "1",
  ),
  "B2": (
    value: "3",
  ),
)

#align(
  center,
  stack(
    dir: ltr,
    spacing: 1em,
    draw_spreadsheet(
      cols: 3,
      rows: 6,
      cells: (
        "A1": (
          value: `t`,
          alignment: center,
        ),
        "B1": (
          value: `P(t)`,
          alignment: center,
        ),
        "C1": (
          value: `P'(t)`,
          alignment: center,
        ),
        "A2": (
          value: "0",
        ),
        "A3": (
          value: [`=A2+0.25`],
          alignment: left,
        ),
        "B2": (
          value: "3",
        ),
      ),
      select_cells: (pos: "A3", corner_cursor: (se: true)),
      additional_draw_function: cell_extents => {
        import "@preview/cetz:0.3.4"
        import cetz.draw: *

        let (right, bottom) = cell_extents("A3")
        let (right: right2, bottom: bottom2) = cell_extents("A6")
        let color = red.darken(20%)

        circle((right, bottom), radius: 5pt, stroke: (paint: color, dash: (2pt, 2pt)), name: "circ")
        line(
          "circ.start",
          (right2, bottom2),
          stroke: (paint: color, dash: (2pt, 2pt)),
          mark: (end: (symbol: "straight")),
          name: "line",
        )
        content(
          ("line.start", 20%, "line.end"),
          angle: "line.end",
          anchor: "north",
          padding: .2,
          text(fill: color)[Drag down],
        )
      },
    ),
    align(horizon, sym.arrow),
    draw_spreadsheet(
      cols: 3,
      rows: 6,
      cells: spreadsheet_so_far,
    ),
  ),
)

Next, we enter the formula for $P' (t)$, making reference to the appropriate cells to get the values of $t$ and $P(t)$.
Here, the formula we enter into `C2` is `=SIN(PI() / 2 * B2 - A2) - 1.5`.#footnote[To get the value $pi$ we must enter `PI()` with the parenthesis `()` at the end.]

#let ts = lq.arange(0, 1 + 0.25, step: .25)
#let Ps = (3, 0, 0, 0, 0)
#let incorrect_comp = ts.zip(Ps).map(((t, P)) => calc.sin(calc.pi / 2 * P - t) - 1.5)

#let spreadsheet_so_far2 = (
  ..spreadsheet_so_far.pairs(),
  ..incorrect_comp
    .enumerate()
    .map(((i, value)) => {
      let row = i + 2
      let col = "C" + str(row)
      (col, (value: str(calc.round(value, digits: 5))))
    }),
).to-dict()

#align(
  center,
  stack(
    dir: ltr,
    spacing: 1em,
    draw_spreadsheet(
      cols: 3,
      rows: 6,
      cells: (
        ..spreadsheet_so_far,
        "C2": (
          value: [`=SIN(PI() / 2 * B2 - A2) - 1.5`],
          alignment: left,
        ),
      ),
      select_cells: (pos: "C2", corner_cursor: (se: true)),
      additional_draw_function: cell_extents => {
        import "@preview/cetz:0.3.4"
        import cetz.draw: *

        let (right, bottom) = cell_extents("C2")
        let (right: right2, bottom: bottom2) = cell_extents("C6")
        let color = red.darken(20%)

        circle((right, bottom), radius: 5pt, stroke: (paint: color, dash: (2pt, 2pt)), name: "circ")
        line(
          "circ.start",
          (right2, bottom2),
          stroke: (paint: color, dash: (2pt, 2pt)),
          mark: (end: (symbol: "straight")),
          name: "line",
        )
        content(
          ("line.start", 20%, "line.end"),
          angle: "line.end",
          anchor: "north",
          padding: .2,
          text(fill: color)[Drag down],
        )
      },
    ),
    align(horizon, sym.arrow),
    draw_spreadsheet(
      cols: 3,
      rows: 6,
      cells: spreadsheet_so_far2,
    ),
  ),
)

Note: our spreadsheet currently has _incorrect_ values for $P'$ since the formula for $P' (t)$ in the spreadsheet is referencing
cells that have not yet been populated with values.#footnote[Spreadsheets typically interpret empty cells as the number $0$. They do this
  instead of producing an error message when you use an empty cell in a formula.
]

Finally, we can enter the formula for $P (t)$. Based on the tangent line approximation, we enter in the cell `B3` the formula
`=B2+0.25*C2` (make sure you know where this formula comes from before continuing).

#let full_spreadsheet = {
  let ret = (:)
  let soln = solve_1d_ivp(
    F,
    (
      0,
      y_0,
    ),
    4,
    Delta: .25,
    method: "euler",
  )
  let ts = soln.map(((x, y)) => x)
  let Ps = soln.map(((x, y)) => y)
  let P_primes = soln.map(((x, y)) => F(x, y))

  for i in range(5) {
    let row = i + 2
    let t = ts.at(i)
    let P = Ps.at(i)
    let P_prime = P_primes.at(i)
    ret.insert(
      "A" + str(row),
      (
        value: str(t),
      ),
    )
    ret.insert(
      "B" + str(row),
      (
        value: str(calc.round(P, digits: 5)),
      ),
    )
    ret.insert(
      "C" + str(row),
      (
        value: str(calc.round(P_prime, digits: 5)),
      ),
    )
  }
  ret
}

#align(
  center,
  stack(
    dir: ltr,
    spacing: 1em,
    draw_spreadsheet(
      cols: 3,
      rows: 6,
      cells: (
        ..spreadsheet_so_far2,
        "B3": (
          value: [`=B2+0.25*C2`],
          alignment: left,
        ),
      ),
      select_cells: (pos: "B3", corner_cursor: (se: true)),
      additional_draw_function: cell_extents => {
        import "@preview/cetz:0.3.4"
        import cetz.draw: *

        let (right, bottom) = cell_extents("B3")
        let (right: right2, bottom: bottom2) = cell_extents("B6")
        let color = red.darken(20%)

        circle((right, bottom), radius: 5pt, stroke: (paint: color, dash: (2pt, 2pt)), name: "circ")
        line(
          "circ.start",
          (right2, bottom2),
          stroke: (paint: color, dash: (2pt, 2pt)),
          mark: (end: (symbol: "straight")),
          name: "line",
        )
      },
    ),
    align(horizon, sym.arrow),
    draw_spreadsheet(
      cols: 3,
      rows: 6,
      cells: (:..spreadsheet_so_far, ..full_spreadsheet),
    ),
  ),
)

Our spreadsheet has now taken care of all the tedious calculations! It is also _reactive_. For example, if we change the initial conditions (i.e., change the value of $P(0)$ in cell `B2`),
the spreadsheet will automatically recompute the value in all other cells.


== Accuracy of Euler's Method

When using Euler's method, in general, smaller step sizes produce more accurate the approximation. And, when taking a limit towards an infinitely small step size,
the approximation converges to an exact solution.

For example, consider the initial value problem $y'(t) = sin(5 t)$ with $y(0)=0.8$. We can solve this exactly to get $y(t)=1 - 0.2 cos(5 t)$. Comparing the exact solution to Euler approximations with
different step sizes, we see that the smaller the step size, the more accurate the approximation.

#{
  let deltas = (0.3, 0.2, 0.1)
  let F(x, y) = calc.sin(5 * x)
  let x_max = 3
  let solns = deltas.map(delta => {
    let soln = solve_1d_ivp(
      F,
      (0, 0.8),
      calc.ceil(x_max / delta),
      Delta: delta,
      method: "euler",
    )
    let xs = soln.map(((x, y)) => x)
    let ys = soln.map(((x, y)) => y)
    (xs, ys)
  })

  let true_soln = solve_1d_ivp(
    F,
    (0, 0.8),
    calc.ceil(x_max / 0.01),
    Delta: 0.01,
    method: "rk4",
  )

  let x_min = -.3
  let y_min = .7
  let diagrams = deltas
    .zip(solns)
    .map(((delta, solns)) => lq.diagram(
      title: [Exact Solution vs.\ Euler Approx ($Delta=#(delta)$)],
      xlim: (x_min, x_max),
      ylim: (y_min, 1.3),
      width: 4cm,
      height: 3cm,
      lq.plot(
        true_soln.map(((x, y)) => x),
        true_soln.map(((x, y)) => y),
        mark: none,
        stroke: (paint: gray.darken(20%), thickness: 1pt, dash: (2pt, .5pt)),
        //title: $Delta = 0.01$,
      ),
      yaxis: (position: x_min, tip: tiptoe.stealth, filter: ((v, d) => false)),
      xaxis: (position: y_min, tip: tiptoe.stealth, filter: ((v, d) => false)),
      lq.plot(
        solns.at(0),
        solns.at(1),
        mark: none,
        //title: $Delta = #(delta)$,
      ),
    ))

  align(
    center,
    stack(..diagrams, spacing: 1em, dir: ltr),
  )
}

In the above example, we knew the exact solution, but what if we didn't? It is possible to get explicit bounds on the
error of an Euler approximation through Taylor's Remainder Theorem and a careful analysis of Euler's method#footnote[
  See https://math.libretexts.org/Courses/Monroe_Community_College/MTH_225_Differential_Equations/03%3A_Numerical_Methods/3.01%3A_Euler%27s_Method for a detailed exposition.
], but we will take a more experimental approach.

Consider the initial value problem
$
  y' = sin(5x + y) / (.2 + y^2) wide "and" wide y(0) = 0.8.
$

We don't have an explicit solution to this initial value problem, but we can plot Euler approximations with different step sizes and compare them.
Plotting with $Delta = 0.3$, $0.2$, $0.1$, $0.05$, $0.03$, and $0.01$ we see different $Delta$'s result in very different curves. What does the exact solution look like?

#{
  // https://www.desmos.com/calculator/xudvzk5ed4
  let deltas = (0.3, 0.2, 0.1, 0.05, 0.03, 0.01)
  let F(x, y) = calc.sin(5 * x + y) / (.2 + y * y)
  let x_max = 5
  let solns = deltas.map(delta => {
    let soln = solve_1d_ivp(
      F,
      (0, 0.8),
      calc.ceil(x_max / delta),
      Delta: delta,
      method: "euler",
    )
    let xs = soln.map(((x, y)) => x)
    let ys = soln.map(((x, y)) => y)
    (xs, ys)
  })


  align(
    center,
    lq.diagram(
      title: [Euler Approximations with $Delta=0.3$ to $0.01$],
      xlim: (-.3, 3.1),
      ylim: (-1.1, 2.3),
      width: 8cm,
      height: 5cm,
      yaxis: (
        position: 0,
        tip: tiptoe.stealth,
        filter: ((v, d) => v != 0),
        tick-distance: 1.0,
      ),
      xaxis: (
        position: 0,
        tip: tiptoe.stealth,
        filter: ((v, d) => v != 0),
        tick-distance: 1.0,
      ),
      ..deltas
        .zip(solns)
        .map(((delta, solns)) => lq.plot(
          solns.at(0),
          solns.at(1),
          mark: none,
          //stroke: (paint: gray.darken(20%), thickness: 1pt, dash: (2pt, .5pt)),
          //title: $Delta = #(delta)$,
        )),
    ),
  )
}

Initially, it may not seem like the approximations are converging to an exact solution.
However, if we keep plotting with smaller and smaller $Delta$'s, we see that the approximations start to settle down to a consistent shape.

#{
  let deltas = (0.01, 0.005, 0.001, 0.0005)
  let F(x, y) = calc.sin(5 * x + y) / (.2 + y * y)
  let x_max = 5
  let solns = deltas.map(delta => {
    let soln = solve_1d_ivp(
      F,
      (0, 0.8),
      calc.ceil(x_max / delta),
      Delta: delta,
      method: "euler",
    )
    let xs = soln.map(((x, y)) => x)
    let ys = soln.map(((x, y)) => y)
    (xs, ys)
  })


  align(
    center,
    lq.diagram(
      title: [Euler Approximations with $Delta=0.01$ to $0.0005$],
      xlim: (-.3, 3.1),
      ylim: (-1.1, 2.3),
      width: 8cm,
      height: 5cm,
      yaxis: (
        position: 0,
        tip: tiptoe.stealth,
        filter: ((v, d) => v != 0),
        tick-distance: 1.0,
      ),
      xaxis: (
        position: 0,
        tip: tiptoe.stealth,
        filter: ((v, d) => v != 0),
        tick-distance: 1.0,
      ),
      ..deltas
        .zip(solns)
        .map(((delta, solns)) => lq.plot(
          solns.at(0),
          solns.at(1),
          mark: none,
          //stroke: (paint: gray.darken(20%), thickness: 1pt, dash: (2pt, .5pt)),
          //title: $Delta = #(delta)$,
        )),
    ),
  )
}

When approximations start looking consistent, this provides strong evidence that the approximations are close to the exact solution.
Of course, this evidence is not as strong as a mathematical _proof_, but it is usually sufficient for doing science (where there are likely other
sources of error far greater than the error arising from Euler's method).


// However, it's important to remember that Euler approximations are still approximations and can be misleading if not interpreted carefully.
// For example, consider the initial value problem
// $
//   y' = -y^(1 / 5) quad quad "and" quad quad y(0) = 1.
// $
//
// By examining a slope field for this differential equation, we can see solutions that start positive, decrease to zero, and then stay at zero
// (since $y'=0$ whenever $y=0$).
//
// #let F = (x, y) => -y / calc.abs(y) * calc.pow(calc.abs(y), 1. / 5)
// #{
//   align(
//     center,
//     slope_field(
//       F,
//       xlim: (-.3, 3.1),
//       ylim: (-3.3, 3.3),
//       width: 7cm,
//       height: 3cm,
//       spacing: (.1, .5),
//       scale_segments: .07,
//       yaxis: (position: 0, tip: tiptoe.stealth, filter: ((v, d) => false)),
//       xaxis: (position: 0, tip: tiptoe.stealth, filter: ((v, d) => false)),
//     ),
//   )
// }
//
// However, Euler approximations to this differential equation attain negative values. This is true no matter the step size.
//
// #{
//   align(
//     center,
//     {
//       {
//         let delta = .5
//         let soln = solve_1d_ivp(
//           F,
//           (
//             0,
//             2,
//           ),
//           20,
//           Delta: delta,
//           method: "euler",
//         )
//         let xs = soln.map(((x, y)) => x)
//         let ys = soln.map(((x, y)) => y)
//         lq.diagram(
//           xlim: (-.3, 4.1),
//           ylim: (-2.3, 2.3),
//           width: 4cm,
//           height: 3cm,
//           yaxis: (position: 0, tip: tiptoe.stealth, filter: ((v, d) => false), stroke: .3pt),
//           xaxis: (position: 0, tip: tiptoe.stealth, filter: ((v, d) => false), stroke: .3pt),
//           lq.plot(
//             xs,
//             ys,
//             mark: none,
//             //stroke: (paint: gray.darken(20%), thickness: 1pt, dash: (2pt, .5pt)),
//           ),
//           title: $Delta = #(delta)$,
//         )
//       }
//       {
//         let delta = .25
//         let soln = solve_1d_ivp(
//           F,
//           (
//             0,
//             2,
//           ),
//           20,
//           Delta: delta,
//           method: "euler",
//         )
//         let xs = soln.map(((x, y)) => x)
//         let ys = soln.map(((x, y)) => y)
//         lq.diagram(
//           xlim: (-.3, 4.1),
//           ylim: (-2.3, 2.3),
//           width: 4cm,
//           height: 3cm,
//           yaxis: (position: 0, tip: tiptoe.stealth, filter: ((v, d) => false), stroke: .3pt),
//           xaxis: (position: 0, tip: tiptoe.stealth, filter: ((v, d) => false), stroke: .3pt),
//           lq.plot(
//             xs,
//             ys,
//             mark: none,
//             //stroke: (paint: gray.darken(20%), thickness: 1pt, dash: (2pt, .5pt)),
//           ),
//           title: $Delta = #(delta)$,
//         )
//       }
//       {
//         let delta = .1
//         let soln = solve_1d_ivp(
//           F,
//           (
//             0,
//             2,
//           ),
//           200,
//           Delta: delta,
//           method: "euler",
//         )
//         let xs = soln.map(((x, y)) => x)
//         let ys = soln.map(((x, y)) => y)
//         lq.diagram(
//           xlim: (-.3, 4.1),
//           ylim: (-2.3, 2.3),
//           width: 4cm,
//           height: 3cm,
//           yaxis: (position: 0, tip: tiptoe.stealth, filter: ((v, d) => false), stroke: .3pt),
//           xaxis: (position: 0, tip: tiptoe.stealth, filter: ((v, d) => false), stroke: .3pt),
//           lq.plot(
//             xs,
//             ys,
//             mark: none,
//             //stroke: (paint: gray.darken(20%), thickness: 1pt, dash: (2pt, .5pt)),
//           ),
//           title: $Delta = #(delta)$,
//         )
//       }
//     },
//   )
// }


#example(
  prompt: [Use Euler's method to estimate whether the solution to the initial value problem ... is periodic or not],
  [
    XXX Finish. Come up with a nice example where it's not super obvious.

  ],
)

