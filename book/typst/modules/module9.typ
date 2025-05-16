
// This file is meant to be imported and not compiled on its own.
#import "../common/settings-book.typ": workbook, show_def
#import "../libs/_graphics.typ": vector_field
#import "../libs/_ode_solvers.typ": solve_2d_ivp
#import "@preview/tiptoe:0.3.0"
#import "@preview/lilaq:0.3.0" as lq
#let (sans, serif, module, definition, example) = workbook

In this module you will learn
- How to use _linearization_, the process of finding an affine approximation to a system of differential equations,
  to analyze the equilibrium solutions of non-linear systems of differential equations.
- Some of the limits of using linearization to study equilibrium solutions.

We have a complete theory, based on eigenvalues, for
classifying the equilibria of systems of differential equations that can be written in matrix form.
Eigen techniques also apply to affine systems.
Unfortunately, most equations that come from real-world models cannot be written in matrix or affine form!

== Linearization

Recall the Fox and Rabbit model from Core Exercise XXX:

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

We cannot use eigenvalue analysis to classify the equilibrium solutions because non-linear systems do not have eigen solutions. However,
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
A useful heuristic when approximating is that if a quantity is small, then that quantity squared is very small and can be ignored.#footnote[Look back at proofs for the derivative of
  $x^2$; using limits formalizes the rule, but all higher-order terms go to zero in the limit.]
Recall our system:
$
  F' &= 0.01 dot R dot F - 1.1 dot F \
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
Graphing phase portraits side-by-side, the original system and our approximating system look very similar (near $(F,R)=(0,0)$).
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
Since $F_"approx"$ and $R_"approx"$ can be analyzed using eigen techniques (eigenvalue of $-1.1$ and $1.1$ mean $(0,0)$ is _unstable_), and since
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
$
  f(x) quad approx quad f(E) + f'(E)(x - E).
$
There is a similar formula for multi-variable functions. Let $arrow(F)(x,y)=mat(F_1(x,y); F_2(x,y))$
and let $arrow(E) in RR^2$. Then, when $mat(x; y) approx arrow(E)$,
$
  arrow(F)(x,y) quad approx quad arrow(F)(arrow(E)) D_(arrow(F))(arrow(E))(mat(x; y)-arrow(E)).
$
Here, $D_(arrow(F))(arrow(E))$ is the _total derivative_ (also called the _Jacobian matrix_ or _Jacobian_) of $arrow(F)$ at $arrow(E)$. That is,
$
  D_(arrow(F))(arrow(E)) = mat(
    (partial F_1) / (partial x) F_1, (partial F_1) / (partial y) F_1;
    (partial F_2) / (partial x) F_2, (partial F_2) / (partial y) F_2
  ) wide "evaluated at" arrow(E).
$

These approximations are called _affine approximations_ or _first-order approximations_.

#example(
  prompt: [Let $F(x,y) = (x^2 y, y^3 - 2)$ and let $arrow(E) = (1, 1)$. Find an affine approximation to $F$ at $E$.],
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
It's important to note here that when we write $F'$ or $G'$, we mean $(dif F(t)) / (dif t)$, i.e., a derivative with respect to $t$.
The function $arrow(G)$ is a function of two variables and helps us re-write our differential equation, but it is unrelated to the variable $t$.

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

We can also linearize near the equilibrium $(F, R) = (11, 110)$.
$
  mat(F'_"approx"; R'_"approx") &= arrow(G)(11, 110) + D_(arrow(G))(11, 110) (mat(F_"approx"; R_"approx") - mat(11; 110))\
  &= mat(0; 0) + mat(0, .11; -11, 0) (mat(F_"approx"; R_"approx") - mat(11; 110))\
  &= mat(0, .11; -11, 0) mat(F_"approx"; R_"approx") + mat(-12.1; 121).
$
Comparing phase portraits near $(F, R) = (11, 110)$, we see they are quite similar *near the point $(11, 110)$*.

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

Continuing with the Fox-and-Rabbit example, let's focus on the linearization near $(F, R)=(11, 110)$. We have the exact model
$
  F' = 0.01 dot R dot F - 1.1 dot F \
  R' = 1.1 dot R - 0.1 dot F dot R
$
and the approximate model
$
  F'_"approx" = 0.11 dot R_"approx" - 12.1 \
  R'_"approx" = -11 dot F_"approx" + 121
$

Using initial conditions of $F=11$ and $R approx 110$, we can compare solutions to the two systems.
#let G(x, y) = (.11 * y - 12.1, -11 * x + 121)

#{
  let steps = 200
  let _Delta = 0.05
  let ts = lq.arange(0, _Delta * (steps + 1), step: _Delta)
  let F1 = solve_2d_ivp(F, (11, 112), steps, Delta: _Delta, method: "rk4")
  let G1 = solve_2d_ivp(G, (11, 112), steps, Delta: _Delta, method: "rk4")
  let F2 = solve_2d_ivp(F, (11, 115), steps, Delta: _Delta, method: "rk4")
  let G2 = solve_2d_ivp(G, (11, 115), steps, Delta: _Delta, method: "rk4")
  let F3 = solve_2d_ivp(F, (11, 100), steps, Delta: _Delta, method: "rk4")
  let G3 = solve_2d_ivp(G, (11, 100), steps, Delta: _Delta, method: "rk4")
  align(
    center,
    {
      let width = 4.8cm
      lq.diagram(
        title: [Component Space],
        //legend: (position: bottom + right),
        width: width,
        //ylim: (0, 1.5),
        lq.plot(
          ts,
          F1.map(((x, y)) => x),
          mark: none,
          stroke: 1.5pt, //label: $F$
        ),
        lq.plot(
          ts,
          G1.map(((x, y)) => x),
          mark: none,
          stroke: 1.5pt, //label: $F_"approx"$
        ),
        lq.plot(
          ts,
          F2.map(((x, y)) => x),
          mark: none,
          stroke: 1.5pt, //label: $F$
        ),
        lq.plot(
          ts,
          G2.map(((x, y)) => x),
          mark: none,
          stroke: 1.5pt, //label: $F_"approx"$
        ),
        lq.plot(
          ts,
          F3.map(((x, y)) => x),
          mark: none,
          stroke: 1.5pt, //label: $F$
        ),
        lq.plot(
          ts,
          G3.map(((x, y)) => x),
          mark: none,
          stroke: 1.5pt, //label: $F_"approx"$
        ),
        //xaxis: (label: [$t$ (days)]),
        //yaxis: (label: [Pesticide (kg)]),
      )
      lq.diagram(
        title: [Component Space],
        //legend: (position: bottom + right),
        width: width,
        //ylim: (0, 1.5),
        lq.plot(
          ts,
          F1.map(((x, y)) => y),
          mark: none,
          stroke: 1.5pt, //label: $F$
        ),
        lq.plot(
          ts,
          G1.map(((x, y)) => y),
          mark: none,
          stroke: 1.5pt, //label: $F_"approx"$
        ),
        lq.plot(
          ts,
          F2.map(((x, y)) => y),
          mark: none,
          stroke: 1.5pt, //label: $F$
        ),
        lq.plot(
          ts,
          G2.map(((x, y)) => y),
          mark: none,
          stroke: 1.5pt, //label: $F_"approx"$
        ),
        lq.plot(
          ts,
          F3.map(((x, y)) => y),
          mark: none,
          stroke: 1.5pt, //label: $F$
        ),
        lq.plot(
          ts,
          G3.map(((x, y)) => y),
          mark: none,
          stroke: 1.5pt, //label: $F_"approx"$
        ),
        //xaxis: (label: [$t$ (days)]),
        //yaxis: (label: [Pesticide (kg)]),
      )
      //h(3em)
      //lq.diagram(
      //  //legend: (position: bottom + right),
      //  title: [Phase Space],
      //  width: width,
      //  ylim: (0, 1.5),
      //  xlim: (0, 1.5),
      //  lq.plot(As, Bs, mark: none, stroke: 1.5pt, color: red.darken(20%)),
      //  //lq.plot(As2, Bs2, mark: none, stroke: 1.5pt),
      //  //lq.plot(As3, Bs3, mark: none, stroke: 1.5pt),
      //  xaxis: (label: [A], tick-distance: 0.2),
      //  yaxis: (label: [B], tick-distance: 0.2),
      //)
    },
  )
}


== When Linearization Fails
