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

#columns(2)[
  _Current Calendar Description_:
  - First order ordinary differential equations:
    - Direction fields,
    - Integrating factors,
    - Separable equations,
    - Homogeneous equations,
    - Exact equations,
    - Autonomous equations,
    - Modelling.
    - Existence and uniqueness theorem.
  - Higher order equations:
    - Constant coefficient equations,
    - Reduction of order,
    - Wronskian,
    - Method of undetermined coefficients,
    - Variation of parameters.
    - Solutions by series and integrals.
  - First order linear systems, fundamental matrices.
  - Non-linear equations, phase plane, stability. Applications in life and physical sciences and economics.
]

// == Current Status

// - \~ 700 students/semester
// - 2nd Year Course for _non_-specialists

// #columns(2)[
//   _Current Calendar Description_:
//   - First order ordinary differential equations:
//     - Direction fields,
//     - #text(fill: orange)[Integrating factors],
//     - #text(fill: orange)[Separable equations],
//     - Homogeneous equations,
//     - #text(fill: red)[Exact equations],
//     - Autonomous equations,
//     - Modelling.
//     - #text(fill: orange)[Existence and uniqueness theorem].
//   - Higher order equations:
//     - Constant coefficient equations,
//     - #text(fill: red)[Reduction of order],
//     - #text(fill: red)[Wronskian],
//     - #text(fill: red)[Method of undetermined coefficients],
//     - #text(fill: red)[Variation of parameters].
//     - #text(fill: red)[Solutions by series and integrals].
//   - First order linear systems, fundamental matrices.
//   - Non-linear equations, phase plane, stability. Applications in life and physical sciences and economics.
// ]

== Current Status

- \~ 700 students/semester
- 2nd Year Course for _non_-specialists

#columns(2)[
  _Current Calendar Description_:
  - First order ordinary differential equations:
    - Direction fields,
    - #text(fill: orange)[Integrating factors],
    - #text(fill: orange)[Separable equations],
    - Homogeneous equations,
    - #text(fill: red)[Exact equations],
    - Autonomous equations,
    - #text(fill: green.darken(20%))[Modelling].
    - #text(fill: orange)[Existence and uniqueness theorem].
  - Higher order equations:
    - Constant coefficient equations,
    - #text(fill: red)[Reduction of order],
    - #text(fill: red)[Wronskian],
    - #text(fill: red)[Method of undetermined coefficients],
    - #text(fill: red)[Variation of parameters].
    - #text(fill: red)[Solutions by series and integrals].
  - First order linear systems, fundamental matrices.
  - #text(fill: green.darken(20%))[Non-linear equations], #text(fill: green.darken(20%))[phase plane], #text(fill: green.darken(20%))[stability]. #text(fill: green.darken(20%))[Applications in life and physical sciences and economics].
]

== Course Focus

- Modelling with ODEs
- Solving via Simulation
- Long-Term Behaviour and Stability
  - Emphasis on linearization of systems

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
