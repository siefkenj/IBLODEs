#import "environments.typ": *
#import "settings-question.typ": *
#import "environment-module.typ": *
#import "environment-book.typ": *

#set page(width: 4in, height: 5in)
#show: e.prepare()

#show: e.set_(
  global_settings,
  double_sided: false,
)

#show: _outline_show_rule
#outline(target: e.selector(module, outline: true).or(heading))

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

#[
  #show: e.set_(
    module_settings,
    sidebar_color: color.rgb("#7db967"),
    supplement: "Appendix",
    numbering: "A",
  )
  #e.counter(module).update(0)
  #module(title: [Custom Module], label: <module-test-three>)[
    == Some more topics
    This module has a custom sidebar color and reference format.
  ]
]
