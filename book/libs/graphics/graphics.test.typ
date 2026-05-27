#import "graphics.typ": *

#slope_field(
  (x, y) => 1 / (x + if calc.abs(x) < 0.001 { 0.001 } else { 0 }),
  slope_color: red,
  xlim: (-.3, 1.1),
  ylim: (-.3, 3.3),
  width: 7cm,
  height: 3cm,
  spacing: (.06, .25),
  scale_segments: .05,
  xlabel: $t$,
  ylabel: lq.label($P$, dx: -1cm),
),

#let F(x, y) = ((0.01 * y - 1.1) * x, (1.1 - 0.1 * x) * y)
#vector_field(
  F,
  xlim: (-5, 40),
  ylim: (-30, 310),
  spacing: (3, 19),
  scale_segments: 20.0,
  width: 6.5cm,
  height: 6.5cm,
)
