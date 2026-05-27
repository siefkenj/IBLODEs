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
    e.field("body", e.types.any, required: true, doc: "The body of the content."),
    e.field(
      "otherwise",
      e.types.option(e.types.any),
      doc: "Content to show when the main content is not visible.",
      default: none,
    ),
  ),
)

/// Things that should be rendered only when in slide mode.
#let slides_only = e.element.declare(
  "slides_only",
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
    e.field("body", e.types.any, required: true, doc: "The body of the content."),
    e.field(
      "otherwise",
      e.types.option(e.types.any),
      doc: "Content to show when the main content is not visible.",
      default: none,
    ),
  ),
)
