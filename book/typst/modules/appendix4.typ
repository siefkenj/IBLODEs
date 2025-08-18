// This file is meant to be imported and not compiled on its own.
#import "../common/settings-book.typ": show_def, workbook
#import "../libs/_workbook.typ": label_appendix, simple_table
#let (sans, serif, module, definition, example, theorem) = workbook

#label_appendix(<app:series_solution>)

In this appendix you will learn
- How to find a series solution to a differential equation.

Using Euler's method, we can find _numerical_ approximations to a solution to a differential
equation. However, there are other types of useful approximations. In this appendix, we will focus
on approximating a solution to a differential equation with _polynomial_.

== Series Solutions

Consider the differential $y'=y$. What would happen if we tried to write the "Taylor series" of a
solution? The general form for a Taylor series (centered at $t=0$) is
$
  T(x) = a_0 + a_1 t + a_2 t^2 + dots.c
$
and, if $T$ is differentiable, we can compute its derivative term by term:
$
  T'(t) = a_1 + 2 a_2 t + 3 a_3 t^2 + dots.c.
$

We are trying to solve the differential equation $y'=y$, so what happens if we set $T'(x) = T(x)$
and try to solve for the coefficients $a_i$?

Let
$
  a_1 + 2 a_2 x + 3a_3 x^2+ dots.c + n a_n x^(n-1) = a_0 + a_1 x + a_2 x^2 + dots.c + a_n x^n.
$
Setting the constant terms equal gives us
$
  a_1=a_0.
$
Continuing by setting the coefficients of $x$ equal gives $2 a_2 = a_1 = a_0$, and so
$
  a_2 = 1/2 a_0.
$
Continuing with the coefficients of $x^2$, we have that $3 a_3 = a_2$ implies
$
  a_3 = 1/6 a_0.
$
A (hopefully) familiar pattern is emerging.
$
  T(x) & = a_0 + a_0 x + 1/2 a_0 x^2 + 1/6 a_0 x^3 + dots.c \
       & = a_0 (1 + x + 1/2 x^2 + 1/6 x^3 + dots.c)
$
and, we can recognize the last series as the Taylor series for $e^x$! Based on our methods, we
observe that $y(x)=a_0 e^x$ is a solution to $y'=y$ for any constant $a_0$.

In this case, after we wrote down the series, we were able to recognize it. This is a rare
occurrence, but neat when it happens.

#example(
  prompt: [
    Find a series solution to the differential equation
    $ y' = x y + 1. $
  ],
  [
    We use the same approach as before, writing down a general Taylor series
    $
      T(x) = a_0 + a_1 x + a_2 x^2 + dots.c
    $
    and computing (symbolically) $T'(x)$
    $
      T'(x) = a_1 + 2 a_2 x + 3 a_3 x^2 + dots.c
    $
    Now we solve:
    $
      x T(x) + 1 & = x dot (a_0 + a_1 x + a_2 x^2 + dots.c) + 1 \
                 & = 1 + a_0 x + a_1 x^2 + a_2 x^3 + dots.c \
                 & = a_1 + 2 a_2 x + 3 a_3 x^2 + 4 a_4 x^3 + dots.c
    $
    By setting terms equal, we find
    $
      a_1 & = 1 \
      a_2 & = 1/2 a_0 \
      a_3 & = 1/3 a_1 = 1/3 \
      a_4 & = 1/8 a_0 \
      a_5 & = 1/15 a_1 = 1/15 \
          & #h(.3em) dots.v
    $
    and so we have a series solution
    $
      T(x) & = a_0 + x + 1/2 a_0 x^2 + 1/3 x^3 + 1/8 a_0 x^4 + 1/15 x^5 + dots.c \
           & = a_0 (1 + 1/2 x^2 + 1/8 x^4 + dots.c) + (x + 1/3 x^3 + 1/15 x^5 + dots.c)
    $
    for any constant $a_0$.

    In this case, it's harder to see what the pattern in the series for $T(x)$ is, and it's not
    obvious that the series for $T(x)$ corresponds to known functions. But, that shouldn't surprise
    us because we know most differential equations don't have explicit solutions in terms of
    elementary functions.
  ],
)

== Series for Higher Order Differential Equations

Finding a series for a higher order differential equation follows a similar process, you just
differentiate your general power series more times.

#example(
  prompt: [Find a series solution to the differential equation $y'' = -y$.
  ],
  [
    Starting with the general power series
    $
      T(x) = a_0 + a_1 x + a_2 x^2 + a_3 x^3 + dots.c
    $
    we compute the second derivative
    $
      T''(x) = 2 a_2 + 6 a_3 x + 12 a_4 x^2 + dots.c
    $
    and set it equal to $-T(x)$:
    $
      2 a_2 + 6 a_3 x + 12 a_4 x^2 + dots.c & = - (a_0 + a_1 x + a_2 x^2 + dots.c) \
                                            & = -a_0 - a_1 x - a_2 x^2 - dots.c
    $
    By matching coefficients, we find
    $
      a_2 & = -1/2 a_0 \
      a_3 & = -1/6 a_1 \
      a_4 & = -1/12 a_2 = 1/24 a_0 \
      a_5 & = -1/20 a_3 = 1/120 a_1 \
      a_6 & = -1/30 a_4 = -1/720 a_0 \
      a_7 & = -1/42 a_5 = -1/5040 a_1 \
          & #h(.3em) dots.v
    $
    and so we have a series solution
    $
      T(x) & = a_0 (1 - 1/2 x^2 + 1/24 x^4 - 1/720 x^6 + dots.c)
      & + a_1 (x - 1/6 x^3 + 1/120 x^5 - 1/5040 x^7 + dots.c)
    $
    for any constants $a_0$ and $a_1$.
  ],
)

== Convergence and what Series Solutions Mean

For those familiar with careful manipulation of power series, the previous sections should raise
some eyebrows. After all, differentiating a power series term by term should only be done when the
series _absolutely convergent_. Yet, in our previous examples, we differentiated abstractly without
checking any radius of convergence, etc. This is okay because *series solutions are a form of guess
  and check*.

So far, we have been lax on the checking. Let's try another example where we're more careful.

Consider the differential equation $(x - 1) dot y'(x) = 1$. Applying series techniques to this
equation, we see $T(x) = a_0 + a_1 x + a_2 x^2 + dots.c$ is a solution if
$
  (x-1)dot & (a_1 + 2 a_2 x + 3 a_3 x^2 + 4 a_4 x^3 + dots.c) \
           & = -a_1 + (a_1 - 2a_2)x + (2a_2 - 3 a_3)x^2 + (3 a_3 - 4 a_4)x^3 + dots.c \
           & = 1.
$
Thus,
$
  a_1 & = -1 \
  a_2 & = -1/2 \
  a_3 & = -1/3 \
  a_4 & = -1/4 \
      & #h(.3em) dots.v
$
and so we get a series solution
$
  T(x) = a_0 - x - 1/2 x^2 - 1/3 x^3 - 1/4 x^4 - dots.c
$
for any constant $a_0$. *However*, $T(x)$ is not defined when $abs(x) > 1$ and so $T(x)$ cannot be a
solution for all $x$. The series solution we found is only valid for $x in [-1, 1)$.#footnote[
  You can see this by applying convergence tests to $T(x)$. The ratio test shows that $T(x)$
  converges when $abs(x) < 1$ and the alternating series test shows that $T(x)$ converges when
  $x=-1$.
] Since this differential equation is separable, we can find explicit solutions of the form
$y(x) = c_1 + ln(x-1)$ where $c_1$ is a parameter (there are also other solutions!). In particular,
all these solutions are defined on the interval $(-infinity, 1)$.

The moral of the story is: series solutions are a powerful form of guess and check, and we must not
forget to check.
