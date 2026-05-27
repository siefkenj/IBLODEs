#import "environments.typ": *
#import "settings.typ": *
#import "settings-question.typ": *
#import "environment-question.typ": *

#set page(paper: "us-letter")
#show: e.prepare(question)

= Tests for the definition environment.

#definition(title: "A Definition", label: <def-a>)[
  This is the body of the definition. It can contain math:
  $
    f(x) = x^2
  $
  and lists:
  - Property one
    - Sub-property
  - Property two
]

#definition(title: "Another Definition", label: <def-b>)[
  This definition references @def-a.
]

#definition[
  A definition with no title.
]

#[
  == Definitions with custom color

  #show: e.set_(global_settings, def_color: oklch(57.41%, 0.124, 230deg))

  #definition(title: "Custom Color Definition")[
    This definition is rendered with a custom color.
  ]
]

See @def-a and @def-b for the first and second definitions.

= Tests for the theorem environment.

#theorem(title: "The First Theorem", label: <thm-first>)[
  This is the first theorem. Recall @def-a.
]

#theorem(title: [Consequence of @thm-first[]], label: <thm-second>)[
  This theorem follows from @thm-first. It also involves math:
  $
    integral_0^1 f(x) dif x = 1
  $
]

#theorem[
  A theorem with no title.
]

#[
  == Theorems with custom color

  #show: e.set_(global_settings, thm_color: oklch(57.41%, 0.124, 310deg))

  #theorem(title: "Custom Color Theorem")[
    This theorem is rendered with a custom color.
  ]
]

See @thm-first and @thm-second for the theorems above.

= Definitions and theorems together.

#definition(title: "Continuity", label: <def-continuity>)[
  A function $f$ is _continuous_ at $x = a$ if
  $
    lim_(x -> a) f(x) = f(a).
  $
]

#theorem(title: "Intermediate Value Theorem", label: <ivt>)[
  If $f$ is a @def-continuity[] function on $[a, b]$ and $y$ is between $f(a)$ and $f(b)$, then
  there exists $c in [a, b]$ such that $f(c) = y$.
]

See @def-continuity and @ivt above.

= Tests for the example environment.

#example[
  An example with no prompt. It can contain math:
  $
    integral_0^1 x^2 dif x = 1/3
  $
  and lists:
  - Step one
  - Step two
]

#example(prompt: [Compute $integral_0^1 x^2 dif x$.])[
  We evaluate directly:
  $
    integral_0^1 x^2 dif x = lr([x^3/3])_0^1 = 1/3.
  $
]

#example(prompt: [A multi-step example referencing @def-continuity.])[
  Since $f$ is continuous, we can apply the @ivt[]:
  + Verify $f(a) < y < f(b)$.
  + Conclude there exists $c in [a, b]$ with $f(c) = y$.
]

#[
  == Examples with custom color

  #show: e.set_(global_settings, ex_color: oklch(57.41%, 0.124, 180deg))

  #example(prompt: [Custom colored example.])[
    This example is rendered with a custom color.

    - List
      - Deeply
  ]
]
