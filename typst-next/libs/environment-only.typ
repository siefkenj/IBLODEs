#import "./common.typ": *
#import "./settings.typ": *
#import "./environments.typ": *
#import "./utils.typ": *


/// Things that should be rendered only when in book mode.
#let book_only = e.element.declare(
  "book_only",
  prefix: PREFIX,
  doc: "Show content only in when in book or guide mode.",
  display: it => e.get(get => {
    let global_config = get(global_settings)
    if global_config.display_mode == "book" or global_config.display_mode == "guide" {
      it.body
    } else if it.otherwise != none {
      it.otherwise
    }
  }),
  fields: (
    e.field("body", content, required: true, doc: "The body of the content."),
    e.field(
      "otherwise",
      e.types.option(content),
      doc: "Content to show when the main content is not visible.",
    ),
  ),
)

/// Things that should be rendered only when in slide mode.
#let slide_only = e.element.declare(
  "slide_only",
  prefix: PREFIX,
  doc: "Show content only in when in slide mode.",
  display: it => e.get(get => {
    let global_config = get(global_settings)
    if global_config.display_mode == "slides" {
      it.body
    } else if it.otherwise != none {
      it.otherwise
    }
  }),
  fields: (
    e.field("body", content, required: true, doc: "The body of the content."),
    e.field(
      "otherwise",
      e.types.option(content),
      doc: "Content to show when the main content is not visible.",
    ),
  ),
)
