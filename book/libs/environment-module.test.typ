#import "environments.typ": *
#import "settings-question.typ": *
#import "environment-module.typ": *

#set page(width: 4in, height: 5in)
#show: e.prepare()

#show: e.set_(
  global_settings,
  double_sided: false,
)
#module(title: [Test Module], label: <module-test-one>)[
  Some content from the module.

  == A heading

  + Item one
  + Item two
    + Nested item

  #lorem(90)
]

#module(title: [Second Module], label: <module-test-two>)[
  More module content.

  - First
  - Second
    - Sub-item

  #lorem(120)
]

See @module-test-one and @module-test-two.

Don't forget about @module-test-three in the appendix!

#[
  #show: e.set_(
    module_settings,
    sidebar_color: color.rgb("#7db967"),
    supplement: "Appendix",
    numbering: "A",
  )
  #e.counter(module).update(0)
  #module(title: [Custom Module], label: <module-test-three>)[
    This module has a custom sidebar color and reference format.
  ]
]

== Test double sided mode

#show: e.set_(global_settings, double_sided: true)
#set page(margin: (outside: 1in))

#module(title: [Double Sided Module], label: <module-test-four>)[
  This module is in double sided mode. It should have a different sidebar banner on odd and even
  pages.

  - Item one
  - Item two
    - Nested item

  #lorem(90)

  == Heading that shouldn't overlap on the left side with the colored bar.
]
