#import "@preview/touying:0.6.1": *
#import themes.metropolis: *
#show: metropolis-theme.with(aspect-ratio: "16-9")
#show link: it => text(font: "Courier New", fill: blue, it)

//#let x = themes.

= MAT244: ODEs for the Future

Bernardo Galvão-Sousa (UTSG)\ Jason Siefken (UTSG)

== Current Status

- \~ 700 students/semester
- 2nd Year Course for _non_-specialists

/// Color corresponding to the importance of a topic from -1 to 1.
#let importance(v) = gradient.linear(red, green.darken(20%)).sample((v + 1) / 2 * 100%)
#let highlight(v, it) = alternatives(it, text(fill: importance(v), it))

#columns(2)[
  _Current Calendar Description_:
  - #highlight(.5)[Direction fields],
  - #highlight(-0.5)[Integrating factors],
  - #highlight(-0.5)[Separable equations],
  - #highlight(0)[Homogeneous equations],
  - #highlight(-1)[Exact equations],
  - #highlight(.5)[Autonomous equations],
  - #highlight(1)[Modelling].
  - #highlight(-0.5)[Existence and uniqueness theorem].
  - #highlight(.5)[Higher order equations]:
    - #highlight(.5)[Constant coefficient equations],
    - #highlight(-1)[Reduction of order],
    - #highlight(-1)[Wronskian],
    - #highlight(-1)[Method of undetermined coefficients],
    - #highlight(-1)[Variation of parameters].
    - #highlight(-1)[Solutions by series and integrals].
  - #highlight(.8)[First order linear systems, fundamental matrices].
  - #highlight(1)[Non-linear equations]
  - #highlight(1)[Phase plane],
  - #highlight(1)[Stability]
  - #highlight(.8)[Applications in life and physical sciences and economics].
]

== Course Focus

- Modelling with ODEs
- Solving via Simulation
- Long-Term Behaviour and Stability
  - Emphasis on linearization of systems

#v(1cm)
Implementation Details:
- Active learning in class (74 in-class exercises)
- Simulations in Excel (Euler's Method)
- Desmos applets for exploring slope fields/phase portraits

== Technology 1

In-class exercises: https://raw.githubusercontent.com/siefkenj/IBLODEs/refs/heads/main/dist/odes-slides.pdf
#align(center, image("images/presentation-1.png", height: 1fr))

== Technology 2

Desmos slope fields: https://www.desmos.com/calculator/e3vrgrvmqr
#align(center, image("images/presentation-2.png", height: 1fr))

== Technology 3

Desmos phase portraits: https://www.desmos.com/calculator/fvqxqp6eds
#align(center, image("images/presentation-3.png", height: 1fr))

== Technology 4

Textbook (coming Fall 2025): https://github.com/siefkenj/IBLODEs
#align(center, image("images/presentation-4.png", height: 1fr))

== Extras

We haven't talked about other aspects of the course:
- Group tests
- Homeworks/tutorials
- Capstone modelling project

== Questions?

#align(center, text(size: 2em)[Questions?])
