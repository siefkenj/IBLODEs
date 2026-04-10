#import "./common.typ": *
#import "./settings.typ": *
#import "./settings-module.typ": *
#import "./environments.typ": *
#import "./utils.typ": *

#let _barred_env_metadata = metadata("_barred_env_metadata")

/// How much of a gap there is between the end of the color of the banner and the edge of the page.
#let BANNER_INSET_FROM_EDGE = 3pt

/// Draw a colored bar along the side of the page.
/// If `page.margins.outside` is set, the bar will be drawn on the outside edge of the page. Otherwise the bar will be drawn on the right edge.
/// `first_page_label` and `other_page_label` are used to show different labels overlaid on the bar. One is shown on the first barred page,
/// and the other on subsequent pages.
#let _colored_sidebar(
  it,
  bar_color: blue,
  first_page_label: [First Page],
  other_page_label: [Other Pages],
) = {
  // Put a label at the very start so that we can tell whether we are on the first page of this environment or not.
  // THIS MUST BE THE FIRST THING IN THIS ENVIRONMENT
  [#_barred_env_metadata<_barred_env_start>]
  set page(background: context {
    let margins = _compute_margins()
    let width = if margins.outside_edge == right { margins.right } else { margins.left }
    show: place.with(top + margins.outside_edge)
    show: block.with(
      width: width - 2 * BANNER_INSET_FROM_EDGE,
      height: 100%,
      fill: bar_color,
      outset: -BANNER_INSET_FROM_EDGE,
      inset: 2 * BANNER_INSET_FROM_EDGE,
    )
    let current_page = here().page()
    // Find the first location of @_barred_env_start that occurs before `here()`
    let starts = query(selector(<_barred_env_start>).before(here()))
    let start_page = if starts.len() > 0 { starts.at(-1).location().page() } else { none }

    show: place.with(top + center, dy: 20%)
    show: rotate.with(-90deg, reflow: true)
    if current_page == start_page {
      first_page_label
    } else {
      other_page_label
    }
  })
  it
}

/// Set up show rules for headings, lists, etc.
#let _heading_and_list_show_rule(it, primary_color: color.black, secondary_color: color.gray) = {
  set list(
    marker: make_marker(color: secondary_color),
    indent: 5pt,
    body-indent: 3pt,
  )
  set enum(
    numbering: (..n) => {
      let depth = n.pos().len()
      let marker = ("1.", "(a)", "i.", "A.", "I.").at(depth - 1, default: "(1)")
      numbering(marker, n.at(-1))
    },
    indent: 5pt,
    full: true,
  )
  show heading.where(depth: 1): it => {
    block(width: 100%, align(center, move(dx: 5pt, it)))
  }
  show heading: it => {
    set text(fill: primary_color, weight: "light")
    move(dx: -4pt, sans(it))
  }

  it
}


/// Create a module section containing the given content.
/// Modules start on odd pages, style headings/lists consistently, and display
/// a colored sidebar with module information.
#let module = e.element.declare(
  "module",
  prefix: PREFIX,
  doc: "Create a module section with a colored sidebar.",
  display: it => e.get(get => {
    let global_settings = get(global_settings)
    let module_settings = get(module_settings)

    if module_settings.active == false {
      return
    }


    let primary_accent_color = module_settings.sidebar_color
    let darker_color = primary_accent_color.darken(10%)
    let module_counter = e.counter(it)

    if global_settings.double_sided {
      // Make sure modules always start on the "right" page (i.e., front side).
      pagebreak(to: "odd", weak: true)
    }

    show: _heading_and_list_show_rule.with(
      primary_color: primary_accent_color,
      secondary_color: darker_color,
    )

    let first_label = it.ref_label
    let other_label = if _is_empty(it.title) {
      first_label
    } else {
      [#first_label --- #it.title]
    }
    let module_heading = if _is_empty(it.title) { [] } else { heading(level: 1, it.title) }

    show: _colored_sidebar.with(
      bar_color: primary_accent_color,
      first_page_label: text(fill: white, size: 1.5em, sans(first_label)),
      other_page_label: text(fill: white, sans(other_label)),
    )
    set page(footer: _footer_with_copyright(global_settings.copyright))


    show: pad.with(left: 3pt)
    module_heading
    it.body
  }),
  reference: (
    custom: it => {
      let label = it.at("label", default: none)
      if label == none {
        return
      }
      show: link.with(label)
      link(label, it.ref_label)
    },
  ),
  // Needed in order to use `e.ctx(it).get` in the custom reference implementation (for reading module settings at the location of declaration).
  contextual: true,
  synthesize: it => {
    let get = e.ctx(it).get
    let module_settings = get(module_settings)
    let count = e.counter(it).get().first()

    it.ref_label = module_settings.supplement + " " + numbering(module_settings.numbering, count)
    it
  },
  fields: (
    e.field("title", e.types.option(content), doc: "The title of the module."),
    e.field("body", content, required: true, doc: "The body of the module."),
    e.field(
      "supplement",
      e.types.option(content),
      doc: "The way this module is referenced. E.g. \"Module\", or \"Appendix\". Overrides the global setting for this module.",
    ),
    e.field(
      "numbering",
      e.types.option(str),
      doc: "The numbering to be used when referring to this module. E.g. \"1\", or \"A\". Overrides the global setting for this module.",
    ),
    e.field(
      "ref_label",
      str,
      doc: "The label to be used when referring to this module. E.g. \"Module 1\", or \"Appendix A\". Overrides the default reference format which is [supplement numbering].",
      synthesized: true,
    ),
  ),
)
