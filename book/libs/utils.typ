/// Create a marker of a given color with a bullet inside of it
/// so its content can be copy-and-pasted and still appear as a list.
#let make_marker(color: blue) = move(dy: 2pt, box(fill: color, width: 4.5pt, height: 4.5pt, move(
  dy: -1.75pt,
  dx: 1pt,
  text(
    fill: color,
    [•],
  ),
)))

/// Display a term list with each items contents aligned.
/// Use
/// ```
/// #show terms: it => aligned_terms(..it.children, separator: it.separator, tight: it.tight, spacing: it.spacing)
/// ```
/// to activate.
#let aligned_terms(..items, separator: [], spacing: auto, tight: true) = context {
  pad(left: 1.5em, grid(
    columns: 2,
    align: (right, left),
    row-gutter: if spacing != auto { spacing } else if tight { par.leading } else { par.spacing },
    column-gutter: 8pt,
    // note: 'box(width: 0pt)' is to ensure weak spacing is not collapsed
    ..items
      .pos()
      .map(it => (
        [
          #it.term#separator#box(width: 0pt);
        ],
        it.description,
      ))
      .join()
  ))
}

/// Create a simple table with a header row and centered columns.
#let simple_table(headers: (), columns: none, content: ()) = {
  if columns == none {
    columns = headers.len()
  }
  table(
    columns: columns,
    align: center,
    stroke: none,
    ..range(columns - 1).map(x => table.vline(x: x + 1, stroke: .5pt)),
    table.header(..headers),
    table.hline(stroke: .5pt),
    ..content,
  )
}

/// Compute the left/right/top/bottom margins. Even if some margins are set to `auto`,
/// this function will return a length.
#let _compute_margins() = {
  let default_margin = calc.min(page.width, page.height) * 2.5 / 21
  if page.margin == auto {
    // https://typst.app/docs/reference/layout/page/#parameters-margin
    // The margins are set automatically to 2.5/21 times the smaller dimension of the page
    return (
      left: default_margin,
      right: default_margin,
      top: default_margin,
      bottom: default_margin,
      inside: auto,
      outside: auto,
      outside_edge: right,
    )
  }
  if type(page.margin) != dictionary {
    // If the margin is a single length, all margins are set to that length
    return (
      left: page.margin,
      right: page.margin,
      top: page.margin,
      bottom: page.margin,
      inside: auto,
      outside: auto,
      outside_edge: right,
    )
  }
  let margin_dict = (
    left: page.margin.at("left", default: auto),
    right: page.margin.at("right", default: auto),
    top: page.margin.at("top", default: auto),
    bottom: page.margin.at("bottom", default: auto),
    inside: page.margin.at("inside", default: auto),
    outside: page.margin.at("outside", default: auto),
  )
  // Page numbers start at 0 not 1, so we check for `odd` here.
  let left_binding = calc.odd(here().page())
  if page.binding == right {
    left_binding = not left_binding
  }
  // If inside/outside are set, they override left/right for the respective sides
  // This won't be completely accurate because we don't know which page we're on, but...
  if margin_dict.inside != auto {
    if left_binding {
      margin_dict.left = margin_dict.inside
    } else {
      margin_dict.right = margin_dict.inside
    }
  }
  if margin_dict.outside != auto {
    if left_binding {
      margin_dict.right = margin_dict.outside
    } else {
      margin_dict.left = margin_dict.outside
    }
  }
  return (
    left: if margin_dict.left == auto { default_margin } else { margin_dict.left },
    right: if margin_dict.right == auto { default_margin } else { margin_dict.right },
    top: if margin_dict.top == auto { default_margin } else { margin_dict.top },
    bottom: if margin_dict.bottom == auto { default_margin } else { margin_dict.bottom },
    inside: margin_dict.inside,
    outside: margin_dict.outside,
    outside_edge: if left_binding { right } else { left },
  )
}

/// Copy from tools4typst
/// return true if value is an empty array, dictionary, string or content
#let _is_empty(value) = {
  let empty-values = (
    array: (),
    dictionary: (:),
    str: "",
    content: [],
  )
  let t = repr(type(value))
  if t in empty-values {
    return value == empty-values.at(t)
  } else {
    return value == none
  }
}

/// Render a footer with the supplied copyright notice.
/// Usage:
/// ```typst
/// #set page(footer: _footer_with_copyright("Copyright 2024"))
/// ```
#let _footer_with_copyright(copyright) = {
  if page.numbering != none {
    context {
      show: place.with(center)
      numbering(page.numbering, ..counter(page).get())
    }
  }
  show: place.with(right)
  text(copyright, size: 0.75em, fill: gray)
}

/// Only show `content` when the `active_env` equals the `when` condition.
#let restrict(when: "", active_env: "", content, otherwise: none) = {
  if (type(when) == array and when.contains(active_env)) or when == active_env {
    content
  } else if otherwise != none {
    otherwise
  }
}
