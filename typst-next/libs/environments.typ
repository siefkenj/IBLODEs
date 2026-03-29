#import "./common.typ": *
#import "./settings.typ": *
#import "./utils.typ": *

/// Set the font to the sans font.
#let sans = e.element.declare(
  "sans",
  prefix: PREFIX,
  doc: "Show text in sans serif font",
  display: it => e.get(get => {
    set text(font: get(global_settings).sans_font)
    it.body
  }),
  fields: (
    e.field("body", content, required: true),
  ),
)

/// Set the font to the serif font.
#let serif = e.element.declare(
  "serif",
  prefix: PREFIX,
  doc: "Show text in serif font",
  display: it => e.get(get => {
    set text(font: get(global_settings).serif_font)
    it.body
  }),
  fields: (
    e.field("body", content, required: true),
  ),
)

/// Set the font to the mono font.
#let mono = e.element.declare(
  "mono",
  prefix: PREFIX,
  doc: "Show text in monospace font",
  display: it => e.get(get => {
    set text(font: get(global_settings).mono_font)
    it.body
  }),
  fields: (
    e.field("body", content, required: true),
  ),
)

/// INTERNAL: Create a colored box with a title and body.
#let _colored_box(intro, body, color) = {
  let darker_color = color.darken(30%)
  show emph: it => text(it, fill: darker_color, weight: "bold")
  set list(marker: make_marker(color: darker_color))
  box(
    fill: color.lighten(80%),
    stroke: (left: color + 3pt),
    inset: 7pt,
    {
      if intro != none {
        show: sans
        text(
          intro + [.],
          fill: darker_color,
          weight: "bold",
        )
      }
      body
    },
    width: 100%,
  )
}

/// Create a boxed definition.
#let definition = e.element.declare(
  "definition",
  prefix: PREFIX,
  doc: "Create a boxed definition.",
  display: it => e.get(get => {
    let config = get(global_settings)
    _colored_box(
      it.title,
      it.content,
      config.def_color,
    )
  }),
  reference: (
    custom: it => {
      let label = it.at("label", default: none)
      if label == none {
        return
      }
      link(label, it.title)
    },
  ),
  fields: (
    e.field("title", e.types.option(content), doc: "The title of the definition."),
    e.field("content", content, required: true, doc: "The body of the definition."),
  ),
)

/// Create a boxed example with an optional prompt.
#let example = e.element.declare(
  "example",
  prefix: PREFIX,
  doc: "Create a boxed example.",
  display: it => e.get(get => {
    let config = get(global_settings)
    let ex_color = config.ex_color
    let darker_color = ex_color.darken(50%)
    show emph: it => text(it, fill: darker_color, weight: "bold")
    set list(marker: make_marker(color: darker_color))
    block(
      fill: ex_color.lighten(90%),
      stroke: (left: ex_color + 1.5pt),
      breakable: true,
      inset: 7pt,
      {
        show: sans
        text([Example.], fill: color.black, weight: "bold")
        if it.prompt != none {
          sym.space.quad
          // Use of `box` prevents excessive line breaks from being displayed.
          box(it.prompt)
        }
        parbreak()
        v(.5em)
        block(width: 100%, it.content)
      },
      width: 100%,
    )
  }),
  fields: (
    e.field("prompt", e.types.option(content), doc: "A short prompt shown inline after 'Example.'"),
    e.field("content", content, required: true, doc: "The body of the example."),
  ),
)

/// Create a boxed theorem.
#let theorem = e.element.declare(
  "theorem",
  prefix: PREFIX,
  doc: "Create a boxed theorem.",
  display: it => e.get(get => {
    let config = get(global_settings)
    _colored_box(
      it.title,
      it.content,
      config.thm_color,
    )
  }),
  reference: (
    custom: it => {
      let label = it.at("label", default: none)
      if label == none {
        return
      }
      link(label, it.title)
    },
  ),
  fields: (
    e.field("title", e.types.option(content), doc: "The title of the theorem."),
    e.field("content", content, required: true, doc: "The body of the theorem."),
  ),
)
