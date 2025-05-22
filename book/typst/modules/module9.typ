
// This file is meant to be imported and not compiled on its own.
#import "../common/settings-book.typ": workbook, show_def
#import "../libs/_workbook.typ": label_module
#import "../libs/_graphics.typ": vector_field
#import "../libs/_ode_solvers.typ": solve_2d_ivp
#import "@preview/tiptoe:0.3.0"
#import "@preview/lilaq:0.3.0" as lq
#let (sans, serif, module, definition, example, theorem) = workbook

//== kkk

In this module you will learn
- How to use _linearization_, the process of finding an affine approximation to a system of differential equations,
  to analyze the equilibrium solutions of non-linear systems of differential equations.
- When using linearization to study equilibrium solutions is appropriate.

We have a complete theory, based on eigenvalues, for
classifying the equilibria of systems of differential equations that can be written in matrix or affine form.
Unfortunately, most equations that come from real-world models cannot be written in matrix or affine form!

== Linearization

Recall the Fox and Rabbit model from @ex:fox_and_rabbit:

$
  F'(t) &= 0.01 dot R(t) dot F(t) - 1.1 dot F(t) \
  R'(t) &= 1.1 dot R(t) - 0.1 dot F(t) dot R(t)
$
where $F(t)$ is the population of foxes (in millions) at year $t$ and $R(t)$ is the
population of rabbits (in millions) at year $t$.

Based on the phase portrait, there appears to be an unstable equilibrium at $(F, R) = (0, 0)$ and a stable equilibrium at $(F, R) = (11, 110)$.


#let F(x, y) = ((0.01 * y - 1.1) * x, (1.1 - 0.1 * x) * y)
#align(
  center,
  vector_field(
    F,
    xlim: (-5, 40),
    ylim: (-30, 310),
    spacing: (3, 19),
    scale_segments: 20.0,
    width: 6.5cm,
    height: 6.5cm,
    yaxis: (position: 0, tip: tiptoe.stealth, tick-distance: 50),
    xaxis: (position: 0, tip: tiptoe.stealth),
    title: [Foxes vs. Rabbits #v(.3em)],
  ),
)

We cannot use eigenvalue analysis to classify the equilibrium solutions because non-linear systems do not have eigenvalues. However,
we may be able to find a matrix/affine system that is "close to" the Fox-and-Rabbit model and apply eigen analysis to our approximation.

#v(1em)
Let's focus on the equilibrium $(F, R) = (0,0)$. Zooming in, the phase portrait looks familiar---very similar to the phase portrait for a matrix equation.
#align(
  center,
  vector_field(
    F,
    xlim: (-5, 5),
    ylim: (-30, 30),
    spacing: (3 / 5, 19 / 4),
    scale_segments: 20.0,
    width: 6.5cm,
    height: 6.5cm,
    yaxis: (position: 0, tip: tiptoe.stealth),
    xaxis: (position: 0, tip: tiptoe.stealth),
  ),
)

We will try to figure out an approximating matrix equation via hand-wavy methods first.
A useful heuristic is that if a quantity is small, then that quantity squared is very small and can be ignored.#footnote[Look back at proofs for the derivative of
  $x^2$; using limits formalizes the rule, but all higher-order terms go to zero in the limit.]
Recall our system:
$
  F' &= 0.01 dot F dot R - 1.1 dot F \
  R' &= 1.1 dot R - 0.1 dot F dot R
$
We are studying the behaviour when $F approx 0$ and $R approx 0$, so $F dot R$ is very, very small. Replacing all $F dot R$ terms with $0$ gives us
#align(
  center,
  grid(
    columns: 3,
    align: center + horizon,
    gutter: 2em,
    $
      F'_"approx" &= -1.1 dot F_"approx" \
      R'_"approx" &= 1.1 dot R_"approx"
    $,
    $<==>$,
    $
      mat(F_"approx"; R_"approx")' = mat(-1.1, 0; 0, 1.1)mat(F_"approx"; R_"approx")
    $,
  ),
)
Graphing phase portraits side-by-side, the original system and our approximating system look very similar near $(F,R)=(0,0)$.
#align(
  center,
  {
    let G(x, y) = (-1.1 * x, 1.1 * y)
    vector_field(
      F,
      xlim: (-5, 5),
      ylim: (-30, 30),
      spacing: (3 / 5, 19 / 4),
      scale_segments: 20.0,
      width: 6.5cm,
      height: 6.5cm,
      yaxis: (position: 0, tip: tiptoe.stealth),
      xaxis: (position: 0, tip: tiptoe.stealth),
      title: [$F$ vs. $R$ #v(.3em)],
    )
    h(2em)
    vector_field(
      G,
      xlim: (-5, 5),
      ylim: (-30, 30),
      spacing: (3 / 5, 19 / 4),
      scale_segments: 20.0,
      width: 6.5cm,
      height: 6.5cm,
      yaxis: (position: 0, tip: tiptoe.stealth),
      xaxis: (position: 0, tip: tiptoe.stealth),
      title: [$F_"approx"$ vs. $R_"approx"$ #v(.3em)],
    )
  },
)

If we simulated solutions, we would find that $F(t) approx F_"approx" (t)$ and $R(t) approx R_"approx" (t)$, when both $F(t)$ and $R(t)$ are near $0$.
Since $F_"approx"$ and $R_"approx"$ can be analyzed using eigen techniques (eigenvalues of $-1.1$ and $1.1$ mean $(0,0)$ is _unstable_), and since
$F$ and $R$ behave similarly to $F_"approx"$ and $R_"approx"$ near $(0,0)$,
we conclude that $(F, R)=(0,0)$ is an unstable equilibrium.

The process of finding a matrix/affine system that closely approximates a non-linear system near a point is called _linearization_.

=== Using Calculus to Linearize

In the previous example, we guessed our way into a linearization. But we have a more systematic tool at our disposal: _Calculus_.

Recall from Calculus that for a function $f: RR arrow RR$, the tangent line to the graph $y=f(x)$ at the point $(E, f(E))$ is given by
$
  y = f(E) + f'(E)(x - E).
$
That means that when $x approx E$, we have
#math.equation(
  numbering: "(1)",
  block: true,
  $
    f(x) quad approx quad f(E) + f'(E)(x - E).
  $,
)<eqScalar>
There is a similar formula for multi-variable functions.#footnote[Here, we give the formula for functions $arrow(F):RR arrow RR^2$, but the generalized
  formula also holds for functions $arrow(F):RR arrow RR^n$.] Let $arrow(F)(x,y)=mat(F_1(x,y); F_2(x,y))$
and let $arrow(E) in RR^2$. Then, when $mat(x; y) approx arrow(E)$,
#math.equation(
  numbering: "(1)",
  block: true,
  $
    arrow(F)(x,y) quad approx quad arrow(F)(arrow(E)) D_(arrow(F))(arrow(E))(mat(x; y)-arrow(E)).
  $,
)<eqVector>
Here, $D_(arrow(F))(arrow(E))$ is the _total derivative_ (also called the _Jacobian matrix_ or _Jacobian_) of $arrow(F)$ at $arrow(E)$. That is,
$
  D_(arrow(F))(arrow(E)) = mat(
    (partial F_1) / (partial x), (partial F_1) / (partial y);
    (partial F_2) / (partial x), (partial F_2) / (partial y)
  ) wide "evaluated at" arrow(E).
$

Approximations like in @eqScalar[Equations] and @eqVector[] called _affine approximations_ or _first-order approximations_.

#example(
  prompt: [Let $arrow(F)(x,y) = (x^2 y, y^3 - 2)$ and let $arrow(E) = (1, 1)$. Find an affine approximation to $arrow(F)$ at $arrow(E)$.],
  [
    XXX Finish
  ],
)
Affine approximations are exactly the tool we need, since they turn non-linear functions into affine ones. Let's apply affine approximations to the Fox-and-Rabbit model.

Recall:
$
  F'(t) &= 0.01 dot R(t) dot F(t) - 1.1 dot F(t) \
  R'(t) &= 1.1 dot R(t) - 0.1 dot F(t) dot R(t)
$
Define $arrow(G)(x, y) = mat(0.01 x y - 1.1 x; 1.1 y - 0.1 x y)$. Our equation can now be written as
$
  mat(F'(t); R'(t)) = arrow(G)(F(t), R(t)).
$
It's important to note here that when we write $F'$ or $R'$, we mean $(dif F(t)) / (dif t)$ or $(dif R(t)) / (dif t)$, i.e., the derivative with respect to $t$.
The function $arrow(G)$, on the other hand, is a function of two variables and helps us re-write our differential equation but is not directly related to the variable $t$.

To approximate our differential equation, we need to find the total derivative of $arrow(G)$.
$
  D_(arrow(G))(x,y) = mat(
    (partial ) / (partial x) space.thin (0.01 x y - 1.1 x), (partial ) / (partial y) space.thin (0.01 x y - 1.1 x); \
    (partial ) / (partial x) space.thin (1.1 y - 0.1 x y),
    (partial ) / (partial y) space.thin (1.1 y - 0.1 x y)
  ) = mat(
    0.01 y - 1.1, 0.01 x; \
    -0.1 y,
    - 0.1 x + 1.1
  )
$
Approximating near the equilibrium $(F, R) = (0, 0)$, we have
$
  mat(F'_"approx"; R'_"approx") &= arrow(G)(0, 0) + D_(arrow(G))(0, 0) (mat(F_"approx"; R_"approx") - mat(0; 0))\
  &= mat(0; 0) + mat(-1.1, 0; 0, 1.1) mat(F_"approx"; R_"approx")\
  &= mat(-1.1, 0; 0, 1.1) mat(F_"approx"; R_"approx"),
$
which is the same formula we found before.

#v(1em)
We can also linearize near the equilibrium $(F, R) = (11, 110)$.
$
  mat(F'_"approx"; R'_"approx") &= arrow(G)(11, 110) + D_(arrow(G))(11, 110) (mat(F_"approx"; R_"approx") - mat(11; 110))\
  &= mat(0; 0) + mat(0, 0.11; -11, 0) (mat(F_"approx"; R_"approx") - mat(11; 110))\
  &= mat(0, 0.11; -11, 0) mat(F_"approx"; R_"approx") + mat(-12.1; 121).
$
Comparing phase portraits, we see they are quite similar *near the point $(F,R)=(11, 110)$*.

#align(
  center,
  {
    let G(x, y) = (.11 * y - 12.1, -11 * x + 121)
    let xlim = (-5, 20)
    let ylim = (-30, 160)
    vector_field(
      F,
      xlim: xlim,
      ylim: ylim,
      spacing: (3 / 2, 19 / 2),
      scale_segments: 20.0,
      width: 6.5cm,
      height: 6.5cm,
      yaxis: (position: 0, tip: tiptoe.stealth),
      xaxis: (position: 0, tip: tiptoe.stealth),
      title: [$F$ vs. $R$ #v(.3em)],
    )
    h(2em)
    vector_field(
      G,
      xlim: xlim,
      ylim: ylim,
      spacing: (3 / 2, 19 / 2),
      scale_segments: 20.0,
      width: 6.5cm,
      height: 6.5cm,
      yaxis: (position: 0, tip: tiptoe.stealth),
      xaxis: (position: 0, tip: tiptoe.stealth),
      title: [$F_"approx"$ vs. $R_"approx"$ #v(.3em)],
    )
  },
)


=== Linearized Solutions vs. True Solutions

Solutions to a linearized system closely approximate solutions to the original system _when the values of the solution are near to the point of linearization_.

Continuing with the Fox-and-Rabbit example, let's focus on the linearization near $(F, R)=(11, 110)$. We have the original model
$
  F' &= 0.01 dot F dot R &-& 1.1 dot F \
  R' &= 1.1 dot R &-& 0.1 dot F dot R
$
and the approximate model
$
  F'_"approx" &= 0.11 dot R_"approx" &-& 12.1 \
  R'_"approx" &= -11 dot F_"approx" &+& 121.0
$

Using initial conditions of $F approx 11$ and $R approx 110$, we can compare solutions to the two systems.
#{
  let G(x, y) = (.11 * y - 12.1, -11 * x + 121)
  let width = 4.5cm
  let height = 2.4cm
  let make_figure(approx_point: (9, 114)) = {
    let steps = 100
    let _Delta = 0.05
    let ts = lq.arange(0, _Delta * (steps + 1), step: _Delta)
    let F1 = solve_2d_ivp(F, approx_point, steps, Delta: _Delta, method: "rk4")
    let G1 = solve_2d_ivp(G, approx_point, steps, Delta: _Delta, method: "rk4")
    let fig_F = lq.diagram(
      //title: [Component Space],
      legend: (position: bottom + right),
      width: width,
      height: height,
      //ylim: (0, 1.5),
      lq.plot(
        ts,
        F1.map(((x, y)) => x),
        mark: none,
        label: $F$,
        stroke: (thickness: 1.5pt, dash: (2pt, 1pt), paint: black),
      ),
      lq.plot(
        ts,
        G1.map(((x, y)) => x),
        mark: none,
        stroke: (thickness: 1.5pt),
        label: $F_"approx"$,
      ),
      // Show ticks but do not show the labels
      xaxis: (ticks: lq.arange(0, 6, step: 2).map(x => (x, none))),
      yaxis: (label: text(size: 0.9em)[Foxes ($F$)]),
      title: [Component Space],
    )
    let fig_R = lq.diagram(
      //title: [Component Space],
      //legend: (position: bottom + right),
      legend: none,
      width: width,
      height: height,
      //ylim: (0, 1.5),
      lq.plot(
        ts,
        F1.map(((x, y)) => y),
        mark: none,
        stroke: (thickness: 1.5pt, dash: (2pt, 1pt), paint: black),
        label: $F$,
      ),
      lq.plot(
        ts,
        G1.map(((x, y)) => y),
        mark: none,
        stroke: 1.5pt,
        label: $F_"approx"$,
      ),
      xaxis: (label: text(size: 0.9em)[Time ($t$)]),
      yaxis: (label: text(size: 0.9em)[Rabbits ($R$)]),
    )
    let fig_FR = lq.diagram(
      //legend: (position: bottom + right),
      title: [Phase Space],
      width: 4.0cm,
      //ylim: (0, 1.5),
      //xlim: (0, 1.5),
      lq.plot(
        F1.map(((x, y)) => x),
        F1.map(((x, y)) => y),
        mark: none,
        stroke: (thickness: 1.5pt, dash: (2pt, 1pt), paint: black),
      ),
      lq.plot(G1.map(((x, y)) => x), G1.map(((x, y)) => y), mark: none, stroke: 1.5pt),
      xaxis: (label: text(size: 0.9em)[Foxes ($F$)]),
      yaxis: (label: text(size: 0.9em)[Rabbits ($R$)]),
    )
    set text(size: 0.9em)


    let comp_space = box(
      align(
        right,
        stack(spacing: .1cm, fig_F, fig_R),
      ),
    )

    table(
      columns: (1fr, auto, auto),
      stroke: none,
      align(
        horizon,
        [
          #align(
            center,
            [*$(F, R) = (#(approx_point.at(0)), #(approx_point.at(1)))$*],
          )
          Approximate solution (solid) and true solution (dashed) with
          initial conditions
          $
            F(0) &= #(approx_point.at(0))\
            R(0) &= #(approx_point.at(1))
          $
        ],
      ),
      comp_space,
      align(horizon, fig_FR),
    )
  }

  make_figure(approx_point: (9, 114))
  make_figure(approx_point: (10, 112))
  make_figure(approx_point: (10.5, 110.5))
}

In the figures, you can see that as the initial conditions get closer to $(F,R)=(10,110)$
(where we centered our approximation), the solution to the linearized system (the solid curve) matches more an more closely to the
solution to the original system (the dashed curve).#footnote[You might wonder if the reduction in error is meaningful.
  Since as $(F,R) arrow (10, 110)$, solutions
  look more and more constant, there is less oscillation overall when initial conditions are close to $(10, 110)$.
  Thus, we would expect approximations (provided that they also oscillate less) to more closely match the original system.
  This is certainly true and is an observation about _absolute error_. However, if you pay attention to the scale on the axes of the
  figures, you see that the _relative error_ is decreasing. That is, even if you zoom in (negating the lessening of oscillations), the
  approximation still more closely matches the true solution.]

== Classifying Equilibria using Linearization

For suitably nice differential equations, linearization can be used to classify equilibrium solutions so long as
corresponding equilibrium solution in the linearized system is *attracting or repelling*.

#theorem(
  title: [Classification via Linearization],
  [
    Suppose $arrow(G): RR^n arrow RR^n$ is differentiable and consider the system of differential equations
    define dby
    #math.equation(
      block: true,
      numbering: "(1)",
      $
        arrow(F)' = arrow(G)(arrow(F)).
      $,
    ) <eqMultivar>
    Let $arrow(F)(t)=arrow(E)$ be an equilibrium solution to @eqMultivar
    and let $arrow(F)'_"approx" = dots$ be the linearization of @eqMultivar centered at $arrow(E)$.

    Then, the following hold.
    - If $arrow(F)_"approx" = arrow(E)$ is an *attracting* equilibrium solution
      then $arrow(F) = arrow(E)$ is an *attracting* equilibrium solution.
    - If $arrow(F)_"approx" = arrow(E)$ is an *repelling* equilibrium solution
      then $arrow(F) = arrow(E)$ is an *repelling* equilibrium solution.
    - If $arrow(F)_"approx" = arrow(E)$ is neither attracting nor repelling,
      the nature of $arrow(F) = arrow(E)$ cannot be determined from the linearization.
  ],
)

Why is the above theorem limited? What can go wrong in the case of stable/unstable but not attracting/repelling equilibria?

=== Identical Linearization for Different Systems.

Consider the following two systems of differential equations:
#math.equation(
  block: true,
  numbering: "(1)",
  $
    x'_"lin" &= -y_"lin" \
    y'_"lin" &= x_"lin"
  $,
)<eqLinCircular>
and
#math.equation(
  block: true,
  numbering: "(1)",
  $
    x'_"nonlin" &= -y_"nonlin" -x_"nonlin"^3 \
    y'_"nonlin" &= x_"nonlin"
  $,
)<eqNonLinAttracting>

The both have an equilibrium solutions $(x(t),y(t))=(0,0)$. Since @eqLinCircular can be rewritten as a matrix equation, we can
solve it explicitly:

#align(
  center,
  grid(
    columns: 2,
    align: horizon,
    gutter: 2em,
    $
      x_"lin" (t) = A cos(t) - B sin(t) \
      y_"lin" (t) = A sin(t) + B cos(t)
    $,
    [where $A,B in RR$ are parameters.],
  ),
)
From this, we see that the equilibrium solution at the origin for @eqLinCircular is _stable_ and _not attracting_.

#let F(x, y) = (-y - x * x * x, x)
Unfortunately, @eqNonLinAttracting is not so easily solved, so we use our other tools.


#{
  let steps = 500
  let _Delta = 0.1
  let ts = lq.arange(0, _Delta * (steps + 1), step: _Delta)
  let F1 = solve_2d_ivp(F, (1, .5), steps, Delta: _Delta, method: "rk4")

  figure(
    caption: [A phase portrait for @eqNonLinAttracting overlayed with a simulated solution\
      starting at $x_"nonlin" (0)=1$ and $y_"nonlin" (0) = 1 / 2$.],
    numbering: none,
    vector_field(
      F,
      xlim: (-1, 1),
      ylim: (-1, 1),
      //spacing: (1, 1),
      scale_segments: 20.0,
      width: 6.5cm,
      height: 6.5cm,
      xaxis: (label: $x_"nonlin"$, tick-distance: .5),
      yaxis: (label: $y_"nonlin"$, tick-distance: .5),
      lq.plot(
        F1.map(((x, y)) => x),
        F1.map(((x, y)) => y),
        mark: none,
        stroke: (thickness: 1.5pt),
      ),
      //   title: [Phase Portrait for $x_"nonlin"$ and $y_"nonlin"$],
    ),
  )
}

Looking at a phase portrait for @eqNonLinAttracting, it looks like the arrows might be spiralling in, but it is hard to tell. Overlaying with a simulated solution,
the solution appears to spiral towards the origin.

XXX Finish


== When Linearization Fails to Classify Equilibria
