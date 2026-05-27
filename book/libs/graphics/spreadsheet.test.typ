#import "spreadsheet.typ": *

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
