#import "environments.typ": *
#show: e.prepare()

This text should be sans-serif: #sans[test text]

This text should be serif: #serif[test text]

This text should be monospace: #mono[test text]

#definition(title: "The Fundamental Function", label: <fundamental_func>)[
  The fundamental function
  $
    f
  $
  has the properties
  - It is nice to study
    - It is very fundamental
]

See above for @fundamental_func.

#theorem(title: "The Fundamental Theorem of Algebra", label: <fta>)[
  Every non-constant polynomial has a root.
]
See another source for a proof of @fta.

#theorem(title: "The Second Fundamental Theorem of Algebra")[
  Like @fta, but better!
]
