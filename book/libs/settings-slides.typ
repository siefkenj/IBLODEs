#import "./common.typ": *

/// Global settings to affect slides.
#let slide_settings = e.element.declare(
  "slide_settings",
  doc: "Global settings for the slides.",
  prefix: PREFIX,
  display: it => panic("This element is not meant to be displayed."),
  fields: (
    e.field(
      "top_bg_color",
      color,
      doc: "The color behind the title of the slide.",
      default: color.rgb("#00647d"),
    ),
    e.field(
      "bottom_bg_color",
      e.types.smart(color),
      doc: "The background color of the bottom of the slide. If `auto`, it will be the same as `title_bg_color`.",
      default: auto,
    ),
    e.field(
      "active",
      bool,
      doc: "Whether the slides should be rendered. If this is `false`, the content of the slides will be directly passed through and no border/etc. will be shown.",
      default: true,
    ),
    e.field(
      "copyright",
      content,
      doc: "The copyright notice to show on the bottom of each slide",
      default: [_#sym.copyright Bernardo Galvão-Sousa & Jason Siefken, 2024--2025_],
    ),
  ),
)
