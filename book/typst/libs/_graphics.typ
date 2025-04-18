#import "@preview/lilaq:0.2.0" as lq

/// Merge to `stroke` objects with any properties defined on the second one taking precedence.
/// For example, `merge_strokes(1pt + green, red)` will produce `1pt + red`.
#let merge_strokes(stroke1, stroke2) = {
  let stroke1 = stroke(stroke1)
  let stroke2 = stroke(stroke2)
  stroke(
    paint: if stroke2.paint != auto {
      stroke2.paint
    } else {
      stroke1.paint
    },
    thickness: if stroke2.thickness != auto {
      stroke2.thickness
    } else {
      stroke1.thickness
    },
    cap: if stroke2.cap != auto {
      stroke2.cap
    } else {
      stroke1.cap
    },
    join: if stroke2.join != auto {
      stroke2.join
    } else {
      stroke1.join
    },
    dash: if stroke2.dash != auto {
      stroke2.dash
    } else {
      stroke1.dash
    },
    miter-limit: if stroke2.miter-limit != auto {
      stroke2.miter-limit
    } else {
      stroke1.miter-limit
    },
  )
}

/// Plot a slope field for `y' = F(x, y)`. Additional arguments can be passed to the underlying `lq.diagram`
/// to add to the plot.
///  - `xlim`: The x-axis limits.
///  - `ylim`: The y-axis limits.
///  - `spacing`: The spacing between the slopes drawn for the slope field.
///  - stroke_style: The stroke style for the slopes.
///  - `scale_segments`: Additional scaling factor to change the length of the slope segments.
#let slope_field(F, xlim: (0, 1), ylim: (0, 1), spacing: auto, stroke_style: .5pt, scale_segments: 1, ..lq_args) = {
  let stroke_style = stroke(stroke_style)
  let xmin = xlim.at(0)
  let xmax = xlim.at(1)
  let ymin = ylim.at(0)
  let ymax = ylim.at(1)
  let width = lq_args.named().at("width", default: 6cm)
  let height = lq_args.named().at("height", default: 4cm)

  let (x_spacing, y_spacing) = if type(spacing) == array {
    (spacing.at(0), spacing.at(1))
  } else if type(spacing) != float {
    let spacing = calc.min((xmax - xmin) / 20, (ymax - ymin) / 20)
    (spacing, spacing)
  } else {
    (spacing, spacing)
  }
  // Limit the total number of slopes graphed to 100x100
  let x_spacing = if (xmax - xmin) / x_spacing > 100 {
    (xmax - xmin) / 100
  } else {
    x_spacing
  }
  let y_spacing = if (ymax - ymin) / y_spacing > 100 {
    (ymax - ymin) / 100
  } else {
    y_spacing
  }

  // We want all segments to be the same length regardless of orientation.
  // Thus, we need to correct for the aspect ratio of the plot.
  // There is both a logical aspect ratio coming from xlim and ylim and a
  // display aspect ratio coming from the width and height of the plot.
  let x_scale = (xmax - xmin) / width.cm()
  let y_scale = (ymax - ymin) / height.cm()
  // Compute an optimal segment length
  let segment_length = calc.min(x_spacing, y_spacing) * .15

  let base_points = lq
    .arange(xmin, xmax + x_spacing, step: x_spacing)
    .map(x => lq.arange(ymin, ymax + y_spacing, step: y_spacing).map(y => (x, y)))
    .join()
  if base_points == none {
    base_points = ((0., 0.),)
  }

  let slope_angles = base_points.map(((x, y)) => ((x, y), calc.atan2(1, F(x, y))))
  let segments = slope_angles.map((((x, y), angle)) => {
    let delta_x = x_scale * segment_length * calc.cos(angle) * scale_segments
    let delta_y = y_scale * segment_length * calc.sin(angle) * scale_segments


    (
      (x - delta_x / 2, y - delta_y / 2),
      (x + delta_x / 2, y + delta_y / 2),
      angle,
    )
  })

  let color_func(angle) = {
    if type(stroke_style.paint) != type(auto) {
      // If a color was specified in the stroke style, we will use that instead of computing a color.
      return stroke_style
    }
    let raw_angle = angle.rad()
    let color_angle = ((calc.tanh(raw_angle / 1.8) + 1) * 180deg)
    color.hsv(color_angle, 100%, 100%).darken(20%)
  }

  lq.diagram(
    width: width,
    height: height,
    xlim: xlim,
    ylim: ylim,
    ..segments.map((((x1, y1), (x2, y2), angle)) => lq.line(
      (x1, y1),
      (x2, y2),
      stroke: merge_strokes(stroke_style, color_func(angle)),
    )),
    ..lq_args,
  )
}
