// This file is meant to be imported and not compiled on its own.
#import "../common/settings-book.typ": workbook, show_def
#import "../libs/_workbook.typ": simple_table, label_appendix
#import "../libs/_spreadsheet.typ": draw_spreadsheet
#let (sans, serif, module, definition, example, theorem) = workbook
#label_appendix(<app:spreadsheet>)

In this appendix you will learn:
- The basics of spreadsheet usage
- How to set up formulas in spreadsheets

_Spreadsheets_ serve as a powerful data analysis and management tool.
Commonly associated with Microsoft Excel, spreadsheets provide an interactive table
that, for us, is ideal for implementing some of the basic algorithms
for simulating solutions to differential equations.

== Spreadsheet Basics

The interface to a spreadsheet is a table of editable _cells_. Every column of the spreadsheet is
indexed by a capital letter (_A_, _B_, _C_, ..., _Z_, _AA_, _AB_, ..., with the column names turning to double letters after _Z_),
and the rows indexed by numbers, starting at _1_.

#align(
  center,
  draw_spreadsheet(
    cells: (
      "B2": (
        value: serif([_Cell "B2"_]),
        alignment: center,
      ),
      "E2": (
        value: serif([_Cell "E2"_]),
        alignment: center,
      ),
      "A4": (
        value: serif([_Cell "A4"_]),
        alignment: center,
      ),
    ),
  ),
)

Text or numbers can be entered into any cell of a spreadsheet.

=== Formulas

If a cell's contents start with an _equals sign_ `=`, what follows will be interpreted as a formula.
Formulas can include math expressions (`+`, `-`, `*`, `/`) as well as references to other cells.

For example, when the following spreadsheet is evaluated, the contents of `B2` will be `9` and the contents of `C2` will be `10`.
#align(
  center,
  stack(
    dir: ltr,
    spacing: 1em,
    draw_spreadsheet(
      cols: 3,
      cells: (
        "A1": (
          value: "4.5",
          alignment: right,
        ),
        "B2": (
          value: [`=A1*2`],
          alignment: left,
        ),
        "C2": (
          value: [`=B2+1`],
          alignment: left,
        ),
      ),
    ),
    align(horizon, sym.arrow),
    draw_spreadsheet(
      cols: 3,
      cells: (
        "A1": (
          value: "4.5",
          alignment: right,
        ),
        "B2": (
          value: "9",
          alignment: right,
        ),
        "C2": (
          value: "10",
          alignment: right,
        ),
      ),
    ),
  ),
)


Formulas can be _interpolated_ when copy/pasted or extended to other cells. In the following example,
the formula `=A1+1` is being interpolated to "add one to the previous cell".
#align(
  center,
  stack(
    dir: ltr,
    spacing: 1em,
    draw_spreadsheet(
      cols: 1,
      cells: (
        "A1": (
          value: "4.5",
          alignment: right,
        ),
        "A2": (
          value: [`=A1+1`],
          alignment: left,
        ),
      ),
      select_cells: (pos: "A2", corner_cursor: (se: true)),
      additional_draw_function: cell_extents => {
        import "@preview/cetz:0.3.4"
        import cetz.draw: *

        let (right, bottom) = cell_extents("A2")
        let (right: right2, bottom: bottom2) = cell_extents("A5")
        let color = red.darken(20%)

        circle((right, bottom), radius: 5pt, stroke: (paint: color, dash: (2pt, 2pt)), name: "circ")
        line(
          "circ.start",
          (right2, bottom2),
          stroke: (paint: color, dash: (2pt, 2pt)),
          mark: (end: (symbol: "straight")),
          name: "line",
        )
        content(
          ("line.start", 20%, "line.end"),
          angle: "line.end",
          anchor: "north",
          padding: .2,
          text(fill: color)[Drag down],
        )
      },
    ),
    align(horizon, sym.arrow),
    draw_spreadsheet(
      cols: 1,
      cells: (
        "A1": (
          value: "4.5",
          alignment: right,
        ),
        "A2": (
          value: [`=A1+1`],
          alignment: left,
        ),
        "A3": (
          value: [`=A2+1`],
          alignment: left,
        ),
        "A4": (
          value: [`=A3+1`],
          alignment: left,
        ),
        "A5": (
          value: [`=A4+1`],
          alignment: left,
        ),
      ),
      additional_draw_function: cell_extents => {
        import "@preview/cetz:0.3.4"
        import cetz.draw: *

        let (top, left) = cell_extents("A2")
        let (bottom, right) = cell_extents("A5")
        let color = green.darken(30%)

        line(
          (left, top),
          (right, top),
          (right, bottom),
          (left, bottom),
          close: true,
          stroke: color + 1.5pt,
        )
      },
    ),
    align(horizon, sym.arrow),
    draw_spreadsheet(
      cols: 1,
      cells: (
        "A1": (
          value: "4.5",
          alignment: right,
        ),
        "A2": (
          value: "5.5",
        ),
        "A3": (
          value: "6.5",
        ),
        "A4": (
          value: "7.5",
        ),
        "A5": (
          value: "8.5",
        ),
      ),
    ),
  ),
)

=== Preventing Interpolation

What if you don't want interpolation? Or you only want it in particular places? For example, instead of adding `1` to the previous cell,
let us add the value of `A2` to the previous cell.

We can prevent interpolation of a row/column/both by adding a "`$`" before the row/column in a cell index. For example,
- `=A$1` would interpolate the column but not the row,
- `=$A1` would interpolate the row but not the column, and
- `=$A$1` would not interpolate either.

#align(
  center,
  {
    stack(
      dir: ltr,
      spacing: 1em,
      draw_spreadsheet(
        cols: 2,
        cells: (
          "A1": (
            value: "Delta",
          ),
          "A2": (
            value: "0.05",
          ),
          "B1": "t",
          "B2": "0",
          "B3": (value: [`=B2+$A$2`], alignment: left),
        ),
        select_cells: (pos: "B3", corner_cursor: (se: true)),
        additional_draw_function: cell_extents => {
          import "@preview/cetz:0.3.4"
          import cetz.draw: *

          let (right, bottom) = cell_extents("B3")
          let (right: right2, bottom: bottom2) = cell_extents("B5")
          let color = red.darken(20%)

          circle((right, bottom), radius: 5pt, stroke: (paint: color, dash: (2pt, 2pt)), name: "circ")
          line(
            "circ.start",
            (right2, bottom2),
            stroke: (paint: color, dash: (2pt, 2pt)),
            mark: (end: (symbol: "straight")),
            name: "line",
          )
          content(
            ("line.start", 20%, "line.end"),
            angle: "line.end",
            anchor: "north",
            padding: .2,
            text(fill: color)[Drag down],
          )
        },
      ),
      align(horizon, sym.arrow),
      draw_spreadsheet(
        cols: 2,
        cells: (
          "A1": (
            value: "Delta",
          ),
          "A2": (
            value: "0.05",
          ),
          "B1": "t",
          "B2": "0",
          "B3": (value: [`=B2+$A$2`], alignment: left),
          "B4": (value: [`=B3+$A$2`], alignment: left),
          "B5": (value: [`=B4+$A$2`], alignment: left),
        ),
        additional_draw_function: cell_extents => {
          import "@preview/cetz:0.3.4"
          import cetz.draw: *

          let (top, left) = cell_extents("B3")
          let (bottom, right) = cell_extents("B5")
          let color = green.darken(30%)

          line(
            (left, top),
            (right, top),
            (right, bottom),
            (left, bottom),
            close: true,
            stroke: color + 1.5pt,
          )
        },
      ),
    )
    stack(
      dir: ltr,
      spacing: 1em,
      align(horizon, sym.arrow),
      draw_spreadsheet(
        cols: 2,
        cells: (
          "A1": (
            value: "Delta",
          ),
          "A2": (
            value: "0.05",
          ),
          "B1": "t",
          "B2": "0",
          "B3": "0.05",
          "B4": "0.10",
          "B5": "0.15",
        ),
      ),
    )
  },
)

=== Pitfalls of Formulas

XXX Finish (some stuff about order of operations, `###` showing up in a cell, etc.)

== Graphing

XXX Finish
