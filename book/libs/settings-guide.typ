#import "./common.typ": *

/// Global settings to affect the guide.
#let guide_settings = e.element.declare(
  "guide_settings",
  doc: "Global settings for the guide.",
  prefix: PREFIX,
  display: it => panic("This element is not meant to be displayed."),
  fields: (
    e.field(
      "learning_objectives_color",
      color,
      doc: "The color used for learning objectives annotations.",
      default: color.rgb("#0088dd"),
    ),
    e.field(
      "notes_color",
      color,
      doc: "The color used for notes annotations.",
      default: color.rgb("#ed4c8a"),
    ),
    e.field(
      "lesson_color",
      color,
      doc: "Color of the sidebar used in guide pages.",
      default: color.rgb("#bb5fdf"),
    ),
    e.field(
      "learning_objectives_visible",
      e.types.smart(bool),
      doc: "Whether learning objectives annotations should be shown. If `auto`, it will be the same as `active`.",
      default: auto,
    ),
    e.field(
      "notes_visible",
      e.types.smart(bool),
      doc: "Whether notes annotations should be shown. If `auto`, it will be the same as `active`.",
      default: auto,
    ),
    e.field(
      "lessons_visible",
      e.types.smart(bool),
      doc: "Whether lessons annotations should be shown. If `auto`, it will be the same as `active`.",
      default: auto,
    ),
    e.field(
      "active",
      bool,
      doc: "Whether the guide annotations should be rendered. If this is `false`, guide-related elements will not be shown.",
      default: false,
    ),
  ),
)
