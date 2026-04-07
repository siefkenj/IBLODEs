#import "./common.typ": *

#let global_settings = e.element.declare(
  "global_settings",
  doc: "Global settings for the textbook.",
  prefix: PREFIX,
  display: it => panic("This element is not meant to be displayed."),
  fields: (
    e.field(
      "sans_font",
      e.types.union(str, e.types.array(str)),
      doc: "A list of sans-serif fonts. The first font that is available will be used.",
      default: "NimbusSanL",
    ),
    e.field(
      "serif_font",
      e.types.union(str, e.types.array(str)),
      doc: "A list of serif fonts. The first font that is available will be used.",
      default: ("Bitstream Charter", "Libertinus Serif"),
    ),
    e.field(
      "mono_font",
      e.types.union(str, e.types.array(str)),
      doc: "A list of monospace fonts. The first font that is available will be used.",
      default: "Latin Modern Mono",
    ),
    e.field(
      "def_color",
      color,
      doc: "The color of the box surrounding a definition",
      default: color.rgb("#8dc73e"),
    ),
    e.field(
      "thm_color",
      color,
      doc: "The color of the box surrounding a theorem",
      default: color.rgb("#ed9537"),
    ),
    e.field(
      "ex_color",
      color,
      doc: "The color of the box surrounding an example",
      default: color.gray,
    ),
    e.field(
      "double_sided",
      bool,
      doc: "Whether the textbook is double-sided. If true, odd and even pages will have different margins.",
      default: true,
    ),
    e.field(
      "solutions_visible",
      bool,
      doc: "Whether solutions to core exercises are visible.",
      default: false,
    ),
    e.field(
      "display_mode",
      e.types.union("book", "guide", "slides"),
      doc: "The display mode of the textbook. This can be set to 'book', 'guide', or 'slides'. This will affect what content is shown and how it is laid out.",
      default: "book",
    ),
  ),
)
