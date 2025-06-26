// This file is meant to be imported and not compiled on its own.
#import "../common/settings-book.typ": workbook, show_def
#import "../libs/_workbook.typ": simple_table, label_appendix
#let (sans, serif, module, definition, example, theorem) = workbook
#import "@preview/lilaq:0.2.0" as lq
#import "@preview/tiptoe:0.3.0"


#label_appendix(<app:separable>)

This appendix is adapted from #link("https://www.jirka.org/diffyqs/")[Jiri Lebl's book "Notes on Diffy Qs"].


When a differential equation is of the form $y' = f(x)$, we integrate: $y = integral f(x) d x + C$.
Unfortunately, simply integrating no longer works for the general form of the equation $y' = f(x, y)$.
Integrating both sides yields the rather unhelpful expression
$ y(x) = integral f(x, y(x)) d x + C. $
Notice the dependence on $y$ in the integral.

=== Separable equations

We say a differential equation is *separable* if we can write it as
$ y' = f(x) g(y), $ for some functions $f(x)$ and $g(y)$.
Let us write the equation in the Leibniz notation
$ (d y) / (d x) = f(x) g(y) . $
Then we rewrite the equation as
$ (d y) / (g(y)) = f(x) d x . $
Both sides look like something we can integrate. We obtain
$ integral (d y) / (g(y)) = integral f(x) d x + C . $
If we can find closed form expressions for these two integrals, we can, perhaps, solve for $y$.

#example(
  prompt: [
    Take the equation
    $ y' = x y . $
    Find the general solution.],
  [
    Note that $y = 0$ is a solution. We will remember that fact and
    assume $y eq.not 0$ from now on, so that we can divide by $y$.
    Write the equation as $(d y) / (d x) = x y$ or
    $(d y) / (y) = x d x$.
    Then
    $ integral (d y) / (y) = integral x d x + C . $
    We compute the antiderivatives to get
    $ ln abs(y) = (x^2) / (2) + C , $
    or
    $ abs(y) = e^((x^2) / 2 + C) = e^((x^2) / 2) e^C = D e^((x^2) / 2) , $
    where $D > 0$ is some constant. Because $y = 0$ is also a solution and because
    of the absolute value, we can write:
    $ y = D e^((x^2) / 2) , $
    for any number $D$ (including zero or negative).

    We check:
    $ y' = D x e^((x^2) / 2) = x ( D e^((x^2) / 2) ) = x y . $
    Yay!
  ],
)

You may be worried that we
integrated in two different variables.
We seemingly did a different operation to each side.
Perhaps we should be a little bit more careful
and work through this method more rigorously.
Consider
$ (d y) / (d x) = f(x) g(y) . $
We rewrite the equation as follows.
Note that $y = y(x)$ is a function of $x$ and so is
$(d y) / (d x)$!
$ (1) / (g(y)) (d y) / (d x) = f(x) . $
We integrate both sides with respect to $x$:
$ integral (1) / (g(y)) (d y) / (d x) d x = integral f(x) d x + C . $
We use the change of variables formula (substitution) on the left hand side:
$ integral 1 / (g(y)) d y = integral f(x) d x + C . $
And we are done.

== Implicit solutions

We sometimes get stuck even if we can do the
integration. Consider the separable equation
$ y' = (x y) / (y^2 + 1) . $
We separate variables,
$ ((y^2 + 1) / y) d y = (y + 1 / y) d y = x d x . $
We integrate to get
$ (y^2) / 2 + ln abs(y) = (x^2) / 2 + C , $
or perhaps the less intimidating expression (where $D = 2C$)
$ y^2 + 2 ln abs(y) = x^2 + D . $
It is not easy to find the solution explicitly---it is hard to solve
for $y$. We, therefore, leave the solution in this form and call
it an
_implicit solution_.
It is still
easy to check that an implicit solution satisfies the differential
equation. In this case, we differentiate with respect to $x$, and remember
that $y$ is a function of $x$,
to get
$ y' ( 2 y + 2 / y ) = 2 x . $
Multiply both sides by $y$ and divide by $2 ( y^2 + 1 )$ and you will
get exactly the differential equation. We leave this computation to the
reader.

If you have an implicit solution, and
you want to compute values
for $y$, you might have to be tricky. You might get multiple solutions $y$
for each $x$, so you have to pick one. Sometimes you can
graph $x$ as a function of $y$, and then turn your paper to
see a graph.
Sometimes you have to do more.

Computers are also good at some of these tricks.
More advanced mathematical software usually has some
way of plotting solutions to implicit equations.
For example, for $D = 0$, if you plot all the points $(x, y)$ that
are solutions to $y^2 + 2 ln abs(y) = x^2$,
you find the two curves in the figure below.


#{
  align(
    center,
    {
      lq.diagram(
        width: 4cm,
        height: 4cm,
        lq.contour(
          lq.linspace(-5, 5, num: 50),
          lq.linspace(-5, 5, num: 50),
          (x, y) => y * y + 2 * calc.ln(calc.abs(y)) - x * x,
          levels: (0, 0),
          map: color.map.icefire,
        ),
      )
    },
  )
}



This is not quite a graph of a function. For each $x$ there are two choices of $y$.
To find a function, you have to pick one of these two curves.
You pick the one that satisfies your initial condition if you have one.
For instance, the top curve satisfies the condition $y(1) = 1$.
So for each $D$, we really got two solutions.
As you can see, computing values from an implicit solution can be somewhat
tricky. But sometimes, an implicit solution is the best we can do.


The equation above also has the solution $y = 0$.
So the general solution is
$ y^2 + 2 ln abs(y) = x^2 + D, quad "and" quad y = 0. $
Sometimes these extra solutions that came up
due to division by zero such as
$y = 0$
are called _singular solutions_.

== Examples of separable equations

#example[
  Solve $x^2 y' = 1 - x^2 + y^2 - x^2 y^2$, $y(1) = 0$.

  Factor the right-hand side
  $ x^2 y' = (1 - x^2) (1 + y^2) . $
  Separate variables, integrate, and solve for $y$:
  $
    (y') / (1 + y^2) &= (1 - x^2) / (x^2) ,\
    (y') / (1 + y^2) &= 1 / (x^2) - 1 ,\
    arctan(y) &= -1 / x - x + C ,\
    y &= tan(-1 / x - x + C)
  $
  Solve for the initial condition, $0 = tan(-2 + C)$ to get $C = 2$ (or $C = 2 +
  pi$, or $C = 2 + 2 pi$, etc.). The particular solution we seek is, therefore,
  $ y = tan((-1 / x) - x + 2) . $
]

#example(
  prompt: [

    Bob made a cup of coffee, and
    Bob likes to drink coffee only once reaches 60 degrees Celsius and will not burn him.
    Initially at time $t = 0$ minutes,
    Bob measured the temperature and the coffee was 89 degrees Celsius.
    One minute later, Bob measured the coffee again and it had 85 degrees.
    The temperature of the room (the ambient temperature) is 22 degrees.
    When should Bob start drinking?],
  [
    Let $T$ be the temperature of the coffee in degrees Celsius, and let $A$ be
    the ambient (room) temperature, also in degrees Celsius.
    Newton's law of cooling states that the rate at which the
    temperature of the coffee is changing
    is proportional to the difference between the
    ambient temperature and the temperature of the coffee. That is,
    $ (d T) / (d t) = k (A - T) , $
    for some positive constant $k$.
    For our setup $A = 22$, $T(0) = 89$, $T(1) = 85$.
    We separate variables and integrate (let $C$ and $D$ denote arbitrary
    constants):
    $
      (1 / (T - A)) (d T) / (d t) & = -k,\
      ln(T - A) &= -k t + C , quad "note that " T - A > 0 ,\
      T - A &= D e^(-k t),\
      T &= A + D e^(-k t)
    $
    That is,
    $T = 22 + D e^(-k t)$. We plug in the first condition: $89 = T(0) = 22 +
    D$,
    and hence $D = 67$. So
    $T = 22 + 67 e^(-k t)$. The second condition says $85 = T(1) =
    22 + 67 e^(-k)$. Solving for $k$, we get
    $k = - ln ((85 - 22) / 67) approx 0.0616$. Now we solve for the time $t$
    that gives us a temperature of 60 degrees. Namely, we solve
    $ 60 = 22 + 67 e^(-0.0616 t) $
    to get
    $t = - (ln ((60 - 22) / 67)) / (0.0616) approx 9.21$ minutes. So Bob can
    begin to drink the coffee at just over 9 minutes from the time Bob made
    it. That is probably about the amount of time it took us to calculate how long it would take.


    #{
      align(
        center,
        {
          let x = lq.linspace(0, 10)
          let y = x.map(x => 22 + 67 * calc.exp(-0.0616 * x))
          let xticks = lq.linspace(0, 9, num: 10)
          let yticks = lq.linspace(55, 85, num: 7)
          lq.diagram(
            xlim: (0, 10),
            ylim: (55, 90),
            // width: 5cm,
            // height: 5cm,
            yaxis: (position: 0, tip: tiptoe.stealth, ticks: yticks),
            xaxis: (position: 55, tip: tiptoe.stealth, ticks: xticks),
            lq.plot(
              x,
              y,
              mark: none,
              stroke: (paint: blue),
            ),
            // lq.line(
            //     (1, 55),
            //     (1, 90),
            //     stroke: (paint: gray, dash: "dashed")
            // ),
            lq.line(
              (9.21, 55),
              (9.21, 90),
              stroke: (paint: gray, dash: "dashed"),
            ),
          )
        },
      )
    }



    // #figure(
    //     image("coffeefig-1-2", width: 9in),
    //     caption: [
    //         Graphs of the coffee temperature function $T(t)$.
    //         On the left, horizontal
    //         lines are drawn at temperatures 60, 85, and 89. Vertical lines
    //         are drawn at $t = 1$ and $t = 9.21$. Notice that the
    //         temperature of the coffee hits 85 at $t = 1$, and 60 at
    //         $t approx 9.21$. On the right, the graph is over a longer period of time,
    //         with a horizontal line at the ambient temperature 22.
    //         (label: sintro:coffeefig)
    //     ]
    // )
    // ]
  ],
)<ex_coffee>

#example(
  prompt: [
    Find the general solution to $y' = (-x y^2) / 3$
    (including any singular solutions).],
  [
    First note that $y = 0$ is a solution (a singular solution).
    Now assume that $y not = 0$.
    $
      -3 / y^2 y' &= x,\
      3 / y &= x^2 / 2 + C,\
      y &= 3 / ((x^2) / 2 + C)\
      &= 6 / (x^2 + 2C)
    $
    So the general solution is
    $ y = 6 / (x^2 + 2C) quad "and" quad y = 0 . $
  ],
)


