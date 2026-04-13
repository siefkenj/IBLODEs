#import "@preview/cetz:0.4.0"

/// Convert a number to a base-26 string like "AB" to a number type.
#let _base_26_to_num(num_str) = {
  // Convert a base-26 number (like "AB") to a number
  let digits = num_str.codepoints().map(l => upper(l).to-unicode() - 64)
  let result = digits.rev().enumerate().map(((i, d)) => d * calc.pow(26, i)).sum()
  result
}

/// Take the location of a cell in string for (`"A1"`) or as coordinates (`(0, 0)`)
/// and return the index of the cell (as a zero-indexed array)
#let cell_loc(loc) = {
  if type(loc) == str {
    let match = loc.match(regex("(\D+)(\\d+)")).captures
    let col_str = match.at(0)
    let row_str = match.at(1)

    let col_num = _base_26_to_num(col_str) - 1
    let row_num = int(row_str) - 1

    (col_num, row_num)
  } else if type(loc) == array {
    loc
  } else {
    panic("Cell location must be a string or an array of coordinates")
  }
}

/// Turn a `str` or a dictionary with a `value` key into a dictionary with
/// `(value: ..., bg: ..., alignment: ...)` keys.
#let _normalize_cell_content_dict(cell) = {
  let ret = (
    value: none,
    bg: auto,
    alignment: right,
  )
  if type(cell) == str or type(cell) == content {
    ret.value = cell
  } else if type(cell) == dictionary {
    ret.value = cell.at("value", default: none)
    ret.bg = cell.at("bg", default: auto)
    ret.alignment = cell.at("alignment", default: right)
  } else {
    panic("Cell content must be a string, content, or a dictionary with a 'value' key")
  }
  ret
}

/// Accepts content for a spreadsheet's cell. Can be
///  - An array of arrays
///  - A dictionary indexed by strings for cell locations (e.g. `"A1"`)
///  - An array of dictionaries with keys `bg` and `value` and `pos` (as a string or a zero-indexed tuple)
/// The contents should be a `str`, `content`, or a dictionary with keys `bg`, `value`.
#let _normalize_cell_content(cells) = {
  if type(cells) == array and cells.len() == 0 {
    cells
  } else if (
    type(cells) == array and type(cells.at(0)) == array
  ) {
    cells
      .enumerate()
      .map(((i, row)) => {
        row
          .enumerate()
          .map(((j, value)) => {
            if value == none {
              ()
            } else {
              (pos: (i, j), .._normalize_cell_content_dict(value))
            }
          })
      })
      .flatten()
  } else if type(cells) == array and type(cells.at(0)) == dictionary {
    cells.map(cell => {
      let pos = cell.at("pos", default: none)

      if pos == none {
        ()
      } else {
        (pos: cell_loc(pos), .._normalize_cell_content_dict(cell))
      }
    })
  } else if type(cells) == dictionary {
    cells
      .pairs()
      .map(((pos, value)) => {
        (pos: cell_loc(pos), .._normalize_cell_content_dict(value))
      })
  }
}

// // Just some testing code
//#_normalize_cell_content((("a", none), ("c", "d")))
//#_normalize_cell_content((
//  "A1": "a",
//  "B1": "b",
//  "A2": "c",
//  "B2": "d",
//))
//#_normalize_cell_content((
//  (pos: (0, 0), value: "a"),
//  (pos: (1, 0), value: "b"),
//  (pos: (0, 1), value: "c"),
//  (pos: (1, 1), value: "d"),
//))

/// Draw a spreadsheet populated with the data in `cells`.
///
/// `cells` parameter can be:
///  - An array of arrays, where each inner array is a row of cells
///  - A dictionary indexed by strings for cell locations (e.g. `"A1"`)
///  - An array of dictionaries with keys `bg`, `value`, and `pos` (as a string or a zero-indexed tuple)
///
/// `select_cells` parameter can be used to highlight cells, and it is a dictionary with keys
///  - `pos`: `string` or zero-indexed tuple of coordinates
///  - `corner_cursor`: a dictionary with keys `nw`, `sw`, `se`, `ne` to indicate which corners should have a cursor (small square in the corner)
///
/// `additional_draw_function` is a function that takes a `cell_extent` parameter (a function that can be called to find the bounds of a cell)
/// and can issue additional `cetz.draw` commands to draw on top of the spreadsheet.
///
#let draw_spreadsheet(
  rows: 5,
  cols: 5,
  cells: (),
  select_cells: (),
  additional_draw_function: cell_extent => { },
  sans: it => text(font: "NimbusSanL", it),
) = {
  let cell_width = 5.3em
  let cell_height = 1.5em
  let left_gutter = 2em
  let top_gutter = 1.3em
  let grid_color = color.rgb(80%, 80%, 80%)
  let grid_line_width = 0.5pt

  select_cells = if type(select_cells) == dictionary {
    (select_cells,)
  } else if type(select_cells) == array {
    select_cells
  } else {
    panic("select_cells must be a dictionary or an array of dictionaries")
  }

  /// Find the extents (width and height, position of corners) of a cell.
  /// If either of the coordinates is negative, extents of the cells in the gutter
  /// are returned.
  let cell_extent(coords) = {
    coords = cell_loc(coords)
    let (x, y) = coords
    let _cell_width = if x < 0 {
      left_gutter
    } else { cell_width }
    let _cell_height = if y < 0 {
      top_gutter
    } else { cell_height }

    let left = x * _cell_width
    let top = y * _cell_height

    (
      width: _cell_width,
      height: _cell_height,
      left: left,
      top: top,
      right: left + _cell_width,
      bottom: top + _cell_height,
    )
  }

  /// Draw contents to a cell. Clip contents if it's too big.
  let draw_in_cell(coords, value, alignment: right, bg_fill: none) = {
    import cetz.draw: *
    bg_fill = if bg_fill == auto { none } else { bg_fill }
    let (
      width: _cell_width,
      height: _cell_height,
      left: x_pos,
      top: y_pos,
    ) = cell_extent(coords)

    content(
      anchor: "north-west",
      (x_pos, y_pos),
      box(
        inset: 4pt,
        width: _cell_width,
        height: _cell_height,
        clip: true,
        fill: bg_fill,
        align(
          alignment + horizon,
          box(sans(value), width: 100em),
        ),
      ),
    )
  }

  /// Draw contents to a cell. Clip contents if it's too big.
  let draw_highlight_box(
    coords,
    color: auto,
    corner_cursor: (nw: false, sw: false, se: false, ne: false),
  ) = {
    import cetz.draw: *
    color = if color == auto { green.darken(30%) } else { color }
    let (
      width,
      height,
      left,
      top,
      right,
      bottom,
    ) = cell_extent(coords)

    line(
      (left, top),
      (right, top),
      (right, bottom),
      (left, bottom),
      close: true,
      stroke: color + 1.5pt,
    )
    let corner_thickness = 2.25pt
    // Draw little squares in the corners
    for corner in ("nw", "ne", "se", "sw") {
      if corner_cursor.at(corner, default: false) {
        let (x, y) = (
          "nw": (left, top),
          "ne": (right, top),
          "se": (right, bottom),
          "sw": (left, bottom),
        ).at(corner)
        line(
          (x - corner_thickness, y - corner_thickness),
          (x - corner_thickness, y + corner_thickness),
          (x + corner_thickness, y + corner_thickness),
          (x + corner_thickness, y - corner_thickness),
          close: true,
          fill: color,
          stroke: white + 1pt,
        )
      }
    }
  }


  //
  // WHERE THE ACTUAL DRAWING HAPPENS
  //
  cetz.canvas({
    import cetz.draw: *
    // Traditional computer-graphics coordinates, please
    set-transform(none)

    // Draw the content of the cells. Do this before we draw the grid so
    // the grid lines are drawn on top of any background colors.
    let normalized_cells = _normalize_cell_content(cells)
    for cell in normalized_cells {
      draw_in_cell(
        cell.pos,
        cell.value,
        alignment: cell.alignment,
        bg_fill: cell.bg,
      )
    }


    // Draw the gutters
    line(
      (-left_gutter, -top_gutter),
      (-left_gutter, rows * cell_height),
      (0, rows * cell_height),
      (0, 0),
      (cols * cell_width, 0),
      (cols * cell_width, -top_gutter),
      close: true,
      stroke: none,
      fill: grid_color.lighten(85%),
    )

    // Draw a little triangle in the top-left corner
    let space = 1.5pt
    line(
      (-space, -space),
      (-space, -top_gutter + space),
      (-top_gutter + space, -space),
      close: true,
      stroke: none,
      fill: grid_color.darken(20%),
    )

    // Draw the grid
    for row in range(0, rows + 1) {
      line(
        (-left_gutter, row * cell_height),
        (cols * cell_width, row * cell_height),
        stroke: grid_line_width + grid_color,
      )
    }
    for col in range(0, cols + 1) {
      line(
        (col * cell_width, -top_gutter),
        (col * cell_width, rows * cell_height),
        stroke: grid_line_width + grid_color,
      )
    }
    // Draw the thick lines around the grid
    line((0, rows * cell_height), (0, 0), (cols * cell_width, 0), stroke: 1pt + grid_color.darken(20%))

    // Label the gutters
    for row in range(0, rows) {
      draw_in_cell(
        (-1, row),
        text(fill: grid_color.darken(35%))[#(row + 1)],
        alignment: center,
      )
    }
    for col in range(0, cols) {
      draw_in_cell(
        (col, -1),
        text(fill: grid_color.darken(35%))[#(numbering("A", col + 1))],
        alignment: center,
      )
    }

    // Draw the selected cells
    for cell in select_cells {
      let pos = cell.at("pos", default: none)
      if pos == none {
        continue
      }
      let corner_cursor = cell.at("corner_cursor", default: (nw: false, sw: false, se: false, ne: false))
      let color = cell.at("color", default: auto)
      draw_highlight_box(
        cell_loc(pos),
        color: color,
        corner_cursor: corner_cursor,
      )
    }

    // Draw anything extra
    if type(additional_draw_function) == function {
      additional_draw_function(cell_extent)
    }
  })
}


#draw_spreadsheet(
  cells: (
    (pos: (0, 0), value: "A1", bg: color.rgb(100%, 100%, 100%)),
    (pos: (1, 0), value: "B1", bg: color.rgb(90%, 20%, 90%)),
    (pos: (0, 1), value: "A2", bg: color.rgb(80%, 80%, 10%), alignment: left),
    (pos: (1, 1), value: "B2", bg: color.rgb(10%, 70%, 70%)),
  ),
)
#draw_spreadsheet(
  cells: (
    "A1": (value: "=A2+B2", alignment: left),
  ),
  select_cells: (pos: "A1", corner_cursor: (se: true)),
)
