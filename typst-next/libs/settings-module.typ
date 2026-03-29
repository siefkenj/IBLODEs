#import "./common.typ": *

/// Global settings to affect modules.
#let module_settings = e.element.declare(
  "module_settings",
  doc: "Global settings for the modules.",
  prefix: PREFIX,
  display: it => panic("This element is not meant to be displayed."),
  fields: (
    e.field(
      "sidebar_color",
      color,
      doc: "The color of the sidebar banner",
      default: color.rgb("#00a2cb"),
    ),
    e.field(
      "active",
      bool,
      doc: "Whether the module is active. If false, the content of the module is hidden.",
      default: true,
    ),
    e.field(
      "supplement",
      content,
      doc: "The way this module is referenced. E.g. \"Module\", or \"Appendix\"",
      default: "Module",
    ),
    e.field(
      "numbering",
      str,
      doc: "The numbering to be used when referring to this module. E.g. \"1\", or \"A\"",
      default: "1",
    ),
  ),
)
