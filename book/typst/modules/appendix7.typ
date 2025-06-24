// This file is meant to be imported and not compiled on its own.
#import "../common/settings-book.typ": workbook, show_def
#import "../libs/_workbook.typ": simple_table, label_appendix
#let (sans, serif, module, definition, example, theorem) = workbook

#label_appendix(<app:complex>)

In this appendix#footnote[Special thanks to Rhupert Ashmore-Sharpe for authoring the bulk of this appendix.] you will learn:
- What a complex numbers is,
- The geometry of complex numbers, and
- The basics of manipulating complex numbers.

== Preliminaries

The imaginary numbers are built from a special symbol $i$, whose square is
$i^2 = -1$. An _imaginary_ number is a pure multiple of $i$, like $b i$, where $b$ is real. A
_complex_ number is a sum of a real and imaginary number, and generally
looks like $a + b i$. The set of all complex numbers, denoted $CC$, is
$
  CC = { a + b i : a, b in RR }.
$
To add and multiply complex numbers, you can treat "$i$" like a variable, use the usual rules of arithmetic, and then simplify any occurrences of $i^2$ to $-1$.
For example,
$
  (1 + 2 i) + (3 + 4 i) = (1 + 3) + (2 + 4)i = 4 + 6 i
$
and
$
  (1 + 2 i)dot (3 + 4 i) = 3 + 4 i + 6 i + 8 i^2 = (3 - 8) + (4 + 6)i = -5 + 10 i.
$

If $z = a + b i$, we call $a$ the _real part_ of $z$ and $b$ the _imaginary part_ of $z$. Note: both the real part and the imaginary part of a complex number
are _real numbers_.

== Geometry of the Complex Numbers

The real numbers ($RR$) can be identified with a number
line. Multiplying by a real number stretches, compresses, or reflects this number line (depending on whether
the number is greater than 1, less than 1, or negative). For example,
consider the interval $[1, 2]$. The figure
on the left shows the effect of multiplication by $-1$ and on the right
multiplication by $2$:

#{
  import "@preview/cetz:0.4.0"
  let left_diagram = cetz.canvas({
    import cetz.draw: *

    let draw_axis() = {
      line(
        (-2.7, 0),
        (2.7, 0),
        mark: (start: "stealth", end: "stealth", fill: black),
        stroke: .5pt,
      )

      for x in range(-2, 3) {
        line((x, -.1), (x, 0.1), stroke: .5pt)
        content(
          (x, -.2),
          anchor: "north",
          text($#x$),
        )
      }
    }

    group({
      draw_axis()

      // The interval [1, 2]
      line((1, 0), (2, 0), stroke: 2pt + blue)
    })

    group({
      translate((0, -3))

      draw_axis()

      arc(
        (1, .2),
        start: 0deg,
        stop: 180deg,
        mark: (end: "stealth", fill: black),
        stroke: (dash: (2pt, 2pt)),
      )

      // The interval [1, 2]
      line((-2, 0), (-1, 0), stroke: 2pt + blue)
    })
  })

  let right_diagram = cetz.canvas({
    import cetz.draw: *

    let draw_axis() = {
      line(
        (-.7, 0),
        (4.7, 0),
        mark: (start: "stealth", end: "stealth", fill: black),
        stroke: .5pt,
      )

      for x in range(-0, 5) {
        line((x, -.1), (x, 0.1), stroke: .5pt)
        content(
          (x, -.2),
          anchor: "north",
          text($#x$),
        )
      }
    }

    group({
      draw_axis()

      // The interval [1, 2]
      line((1, 0), (2, 0), stroke: 2pt + blue)
    })

    line(
      (1.1, -.2),
      (2, -2.8),
      mark: (end: "stealth", fill: black),
      stroke: (dash: (2pt, 2pt)),
    )
    line(
      (2.1, -.2),
      (4, -2.8),
      mark: (end: "stealth", fill: black),
      stroke: (dash: (2pt, 2pt)),
    )
    line(
      (1.6, -.2),
      (3, -2.8),
      mark: (end: "stealth", fill: black),
      stroke: (dash: (2pt, 2pt)),
    )

    group({
      translate((0, -3))

      draw_axis()

      // The interval [1, 2]
      line((2, 0), (4, 0), stroke: 2pt + blue)
    })
  })

  align(
    center,
    stack(
      dir: ltr,
      spacing: 1cm,
      left_diagram,
      right_diagram,
    ),
  )
}

Just like the real numbers, the complex numbers have a geometric meaning.
A complex number $1 + 2 i$ can be thought of as a point in the complex plane (with one axis the _real axis_
and the other axis the _imaginary axis_).

#{
  import "@preview/cetz:0.4.0"
  let left_diagram = cetz.canvas({
    import cetz.draw: *

    let draw_axis() = {
      line(
        (-2.7, 0),
        (2.7, 0),
        mark: (start: "stealth", end: "stealth", fill: black),
        stroke: .5pt,
      )
      line(
        (0, -2.7),
        (0, 2.7),
        mark: (start: "stealth", end: "stealth", fill: black),
        stroke: .5pt,
      )

      for x in range(-2, 3) {
        if x == 0 {
          continue
        }
        line((x, -.1), (x, 0.1), stroke: .5pt)
        content(
          (x, -.2),
          anchor: "north",
          text($#x$),
        )
      }
      content(
        (2.9, 0),
        anchor: "west",
        text("Real Axis"),
      )
      for x in range(-2, 3) {
        if x == 0 {
          continue
        }
        line((-.1, x), (0.1, x), stroke: .5pt)
        content(
          (-.2, x),
          anchor: "east",
          text($#x$),
        )
      }
      content(
        (0, 2.9),
        anchor: "south",
        text("Imaginary Axis"),
      )
    }

    group({
      draw_axis()

      // The interval [1, 2]
      circle((1, 2), fill: blue, radius: 2.5pt, stroke: none)
      content(
        (1.2, 2),
        anchor: "west",
        $1 + 2 i$,
      )
    })
  })


  align(
    center,
    stack(
      dir: ltr,
      spacing: 1cm,
      left_diagram,
    ),
  )
}

If we multiply $1 + 2 i$ by $i$, we get $i dot (1 + 2 i) = i + 2 i^2 = -2 + i$, which geometrically corresponds to a rotation counter-clockwise by 90 degrees.

#{
  import "@preview/cetz:0.4.0"
  let draw_axis() = {
    import cetz.draw: *
    line(
      (-2.7, 0),
      (2.7, 0),
      mark: (start: "stealth", end: "stealth", fill: black),
      stroke: .5pt,
    )
    line(
      (0, -2.7),
      (0, 2.7),
      mark: (start: "stealth", end: "stealth", fill: black),
      stroke: .5pt,
    )

    for x in range(-2, 3) {
      if x == 0 {
        continue
      }
      line((x, -.1), (x, 0.1), stroke: .5pt)
      content(
        (x, -.2),
        anchor: "north",
        text($#x$),
      )
    }
    for x in range(-2, 3) {
      if x == 0 {
        continue
      }
      line((-.1, x), (0.1, x), stroke: .5pt)
      content(
        (-.2, x),
        anchor: "east",
        text($#x$),
      )
    }
  }

  let left_diagram = cetz.canvas({
    import cetz.draw: *


    group({
      draw_axis()

      circle((1, 2), fill: blue, radius: 2.5pt, stroke: none)
      content(
        (1.2, 2),
        anchor: "west",
        $1 + 2 i$,
      )
      circle((-2, 1), fill: blue, radius: 2.5pt, stroke: none)
      content(
        (-2.2, 1.2),
        anchor: "south",
        $-2 + i$,
      )
      line(
        (0, 0),
        (-2, 1),
        stroke: (dash: (2pt, 2pt)),
      )
      line(
        (0, 0),
        (1, 2),
        stroke: (dash: (2pt, 2pt)),
      )

      arc(
        (.65, 1.5),
        start: calc.atan2(1, 2),
        delta: 90deg,
        mark: (end: "stealth", fill: black),
        stroke: .5pt,
        radius: 1.5,
      )
    })
  })

  align(
    center,
    stack(
      dir: ltr,
      spacing: 1cm,
      left_diagram,
    ),
  )
}


For a complex number $z = a + b i$, we define the *complex conjugate* as $macron(z) = a - b i$.
Geometrically, taking the complex conjugate of a complex number reflects it over the real axis. For example, take $z = 2 + 2 i$ and its complex conjugate $macron(z) = 2 - 2 i$.

#{
  import "@preview/cetz:0.4.0"
  let draw_axis() = {
    import cetz.draw: *
    line(
      (-2.7, 0),
      (2.7, 0),
      mark: (start: "stealth", end: "stealth", fill: black),
      stroke: .5pt,
    )
    line(
      (0, -2.7),
      (0, 2.7),
      mark: (start: "stealth", end: "stealth", fill: black),
      stroke: .5pt,
    )

    for x in range(-2, 3) {
      if x == 0 {
        continue
      }
      line((x, -.1), (x, 0.1), stroke: .5pt)
      content(
        (x, -.2),
        anchor: "north",
        text($#x$),
      )
    }
    for x in range(-2, 3) {
      if x == 0 {
        continue
      }
      line((-.1, x), (0.1, x), stroke: .5pt)
      content(
        (-.2, x),
        anchor: "east",
        text($#x$),
      )
    }
  }

  let left_diagram = cetz.canvas({
    import cetz.draw: *


    group({
      draw_axis()

      circle((2, 2), fill: blue, radius: 2.5pt, stroke: none)
      content(
        (2.2, 2),
        anchor: "west",
        $z = 2 + 2 i$,
      )
      circle((2, -2), fill: blue, radius: 2.5pt, stroke: none)
      content(
        (2.2, -2),
        anchor: "west",
        $macron(z) = -2 + i$,
      )
      line(
        (0, 0),
        (2, 2),
        stroke: (dash: (2pt, 2pt)),
      )
      line(
        (0, 0),
        (2, -2),
        stroke: (dash: (2pt, 2pt)),
      )
    })
  })

  align(
    center,
    stack(
      dir: ltr,
      spacing: 1cm,
      left_diagram,
    ),
  )
}

If $z = a + b i$, then $z dot macron(z) = a^2 + b^2$, which is a real number.
The *absolute value* or *modulus* of a complex number $z = a + b i$ is
$
  |z| = sqrt(a^2 + b^2) = sqrt(z dot macron(z)).
$
Here is a list of other nice properties of the complex conjugate (verify these by working out the algebra yourself):

- $overline(z^n) = macron(z)^n$ #v(.4em)
- $overline(z_1 / z_2) = macron(z)_1 / macron(z)_2$ #v(.4em)
- $overline(z_1 + z_2) = macron(z)_1 + macron(z)_2$

The reciprocal, $1 / z$, of a complex number can be simplified by multiplying the numerator and denominator by $macron(z)$:

$
  1 / z = macron(z) / (z macron(z)) = macron(z) / abs(z)^2
$

In this way, you can simplify a complex division problem. For example
$
  (2i) / (2 + 3 i) = ((2i) dot (2-3i)) / ((2+3i)dot (2-3i))= (4i - 6i^2) / (13) = 6 / 13 + 4 / 13 i.
$

== Euler's Formula and Polar Form for Complex Numbers

A complex number written in the form "$a+b i$" is said to be written in _rectangular form_.
However, similarly to how we can represent any point in the plane in polar coordinates, we
can also write a complex number in _polar form_. For any complex number $z$,
there is a real number $r$ and
angle $theta$ so that
$
  z = r (cos(theta) + i sin(theta)).
$

We call $theta$ the *argument* of $z$ and write $theta = arg(z)$. The number $r$
is usually positive, but is is not required to be. When it is positive, it
is equal to $abs(z)$.

#{
  import "@preview/cetz:0.4.0"
  let draw_axis() = {
    import cetz.draw: *
    line(
      (-2.7, 0),
      (2.7, 0),
      mark: (start: "stealth", end: "stealth", fill: black),
      stroke: .5pt,
    )
    line(
      (0, -2.7),
      (0, 2.7),
      mark: (start: "stealth", end: "stealth", fill: black),
      stroke: .5pt,
    )

    for x in range(-2, 3) {
      if x == 0 {
        continue
      }
      line((x, -.1), (x, 0.1), stroke: .5pt)
      content(
        (x, -.2),
        anchor: "north",
        text($#x$),
      )
    }
    for x in range(-2, 3) {
      if x == 0 {
        continue
      }
      line((-.1, x), (0.1, x), stroke: .5pt)
      content(
        (-.2, x),
        anchor: "east",
        text($#x$),
      )
    }
  }

  let left_diagram = cetz.canvas({
    import cetz.draw: *


    group({
      draw_axis()

      circle((2, 2), fill: blue, radius: 2.5pt, stroke: none)
      content(
        (2.2, 2),
        anchor: "west",
        $z = 2 + 2 i$,
      )
      line(
        (0, 0),
        (2, 2),
        stroke: (dash: (2pt, 2pt)),
      )

      arc(
        (1.5, 0),
        start: 0deg,
        delta: 45deg,
        mark: (end: "stealth", fill: black),
        stroke: .5pt,
        radius: 1.5,
        name: "arc",
      )
      content(
        ("arc.end", 40%, "arc.start"),
        anchor: "west",
        padding: .3,
        $theta = pi / 4$,
      )

      cetz.decorations.brace((0, 0), (2, 2), name: "r")
      content(
        "r.spike",
        anchor: "south-east",
        box($r = sqrt(8)$, fill: white, inset: 3pt),
      )
    })
  })

  align(
    center,
    stack(
      dir: ltr,
      spacing: 1cm,
      left_diagram,
    ),
  )
}


//#align(center)[
//  #diagram[
//    grid((-3.1, -3.1), (3.1, 3.1), dotted)
//    line((-3.3, 0), (3.3, 0), arrow: both)
//    line((0, -3.3), (0, 3.3), arrow: both)
//    point((2, 2), label: "z = 2 + 2 i")
//    line((0, 0), (2, 2))
//    arc(center: (0.5, 0.5), radius: 0.7, start: 45, end: 0)
//    text("theta", position: (0.6, 0.4))
//  ]
//]

_Euler's formula_ gives a valuable connection between a complex numbers and complex exponentials,
and it's closely related to polar form.

#show_def("eulers_formula")

Suppose $z_1 = e^(i theta_1)$ and $z_2 = e^(i theta_2)$ are two complex numbers. By the rules of exponents,
we know
$
  z_1 dot z_2 =
  e^(i theta_1) e^(i theta_2) = e^(i (theta_1 + theta_2)).
$
More generally, if $z_1 = r_1 e^(i theta_1)$ and
$z_2 = r_2 e^(i theta_2)$, then
$
  z_1 z_2 = r_1 r_2 e^(i (theta_1 + theta_2)) .
$

This shows that when two complex numbers are multiplied, their angles are added adn their moduli are multiplied. (If $theta = 0$ or $pi$, then the complex number is real;
test your intuition to make sure this formula does what you think for real numbers.)

== Applying Complex Numbers

When solving quadratics $a x^2 + b x +c=0$, we have a general solution in terms of the quadratic formula:
$
  x = (-b plus.minus sqrt(b^2 - 4 a c)) / (2 a).
$
If $b^2-4 a c < 0$, there is no real solution to the equation, however, there is _always_ a complex solution.

#example(
  prompt: [
    Solve the quadratic equation $x^2 + x + 2 = 0$.
  ],
  [
    Using the quadratic formula, we have #h(1fr)
    $
      x = (-6 plus.minus sqrt(1^2 - 4 dot 1 dot 2)) / (2 dot 1) = (-6 plus.minus sqrt(-7)) / 2 = -3 plus.minus sqrt(7) / 2 i.
    $
  ],
)

In fact, all non-constant polynomials have roots in the complex numbers.
#theorem(
  title: "Fundamental Theorem of Algebra",
  [
    Every non-constant polynomial with complex coefficients has roots in the complex plane and the sum of the multiplicity of those
    roots is equal to the degree of the polynomial.
  ],
)

Because of the Fundamental Theorem of Algebra, complex numbers are useful in situations involving polynomials, like eigenvalue/eigenvector problems
in linear algebra.

#example(
  prompt: [Find all eigenvalues and eigenvectors of $M=mat(0, -1; 1, 0)$],
  [
    Computing $det(M- lambda I) = lambda^2+1=0$, we see the eigenvalues of $M$ are $lambda=plus.minus i$.

    To find the eigenvectors corresponding to $lambda =i$, we compute
    $
      "null"(M- i I) = "null"(mat(-i, -1; -1, -i)) = "span"{mat(1; -i)}.
    $
    Thus, the eigenvectors corresponding to $lambda = i$ are non-zero multiples of $mat(1; -i)$.

    Similarly, the eigenvectors corresponding to $lambda = -i$ are non-zero multiples of $mat(1; i)$.
  ],
)

Note, when dealing with complex matrices, it can be more difficult to spot by eye when two vectors are linearly dependent. For example,
${mat(-2; -1), mat(-1, -2)}$ is a linearly _independent_, but the set ${mat(-i; -1), mat(-1; -i)}$ is linearly _dependent_. (Verify this yourself by row reducing!)
