#import "./common.typ": *
#import "./settings.typ": *
#import "./environments.typ": *
#import "./utils.typ": *


/// Create a Core Exercise question.
#let solution = e.element.declare(
  "solution",
  prefix: PREFIX,
  doc: "Create a solution to a question. Will be shown/hidden depending on the global settings.",
  display: it => e.get(get => {
    let global_config = get(global_settings)
    if global_config.solutions_visible {
      show: block.with(fill: blue.lighten(90%), inset: 4pt, width: 100%)
      set text(fill: blue.darken(50%))
      it.body
    }
  }),
  fields: (
    e.field("body", content, required: true, doc: "The body of the solution."),
  ),
)
