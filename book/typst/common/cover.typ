#import "@preview/cetz:0.3.4"
#import "../libs/_ode_solvers.typ": solve_2d_ivp, draw_vec, linspace, scale_cap

#let coverorange = color.rgb("#ffd33c")
#let covershade = color.rgb("#00214a")

/// Function for Vander Pol oscillator.
#let f(x, y) = (0.08 * (1 - y * y) * x - y, x)

/// Make a fade from the given color to 100% transparent. The direction of the fade is given by the `direction` parameter.
/// This returns `image` content. The caller is responsible for placing it on the page as they want.
#let make_fade(color: red, direction: "ltr", width: auto, height: auto) = {
  let grad_string = if direction == "ltr" {
    `x1="100%" x2="0%" y1="50%" y2="50%"`.text
  } else if direction == "rtl" {
    `x1="0%" x2="100%" y1="50%" y2="50%"`.text
  } else if direction == "ttb" {
    `x1="50%" x2="50%" y1="0%" y2="100%"`.text
  } else if direction == "btt" {
    `x1="50%" x2="50%" y1="100%" y2="0%"`.text
  } else {
    assert(false, message: "Unknown direction: \"" + str(direction) + "\"")
  }
  let rbg = color.rgb().to-hex()
  let gradient_svg = `<svg xmlns="http://www.w3.org/2000/svg" width="100px" height="100px">
    <defs>
      <linearGradient id="lgrad" GRAD_STRING >
        <stop offset="0%" style="stop-color:#ffffff;stop-opacity:0" />
        <stop offset="100%" style="stop-color:#ffffff;stop-opacity:1" />
      </linearGradient>
    </defs>
    <rect x="0" y="0" width="100" height="100" fill="url(#lgrad)" />
  </svg>`
    .text
    .replace("#ffffff", rbg)
    .replace("GRAD_STRING", grad_string)
  image(bytes(gradient_svg), width: width, height: height, fit: "stretch")
}
#{

#let make_cover(title, subtitle: [], authors: ([],)) = {
  let font = ("NimbusSanL",) //"Helonia", "Droid Sans", "DejaVu Sans")
  set text(font: font)
  let title_displacement = 1in
  let title_height = 0.8in

  set page(
    background: {
      place(
        top,
        image("../images/blueback.jpg", width: 100%, height: 11in),
      )
    },
  )
  set page(
    foreground: {
      // Draw the arrows of the phase portrait first, so that they can be covered by the gradient background.
      let phase_portrait_displacement_y = title_displacement + title_height + 1.5in
      let phase_portrait_displacement_x = 100% - 21cm
      place(
        top,
        dy: phase_portrait_displacement_y,
        //dx: phase_portrait_displacement_x,
        cetz.canvas({
          import cetz.draw: *
          rect((-11, 7), (11, -7), fill: none, stroke: none)
          let scale = 1.2
          for x in linspace(-10, 10, 0.6) {
            for y in linspace(-6, 6, 0.6) {
              let (dx, dy) = scale_cap(f(x, y))
              draw_vec((x, y), (scale * dx, scale * dy), color: white.darken(10%))
            }
          }
          //let path = solve_2d_ivp(f, (-10, 6), 400, Delta: .1, method: "rk4")
          //catmull(..path, stroke: coverorange)
        }),
      )

      let additional_top_displacement = 1.5in
      place(
        top,
        dy: -additional_top_displacement,
        {
          // https://github.com/typst/typst/issues/2546 means we need to use an SVG rather than a gradient here.
          make_fade(
            color: covershade,
            direction: "ttb",
            width: 100%,
            height: title_displacement + 1pt + additional_top_displacement,
          )
          //box(
          //  width: 100%,
          //  height: title_displacement + 1pt,
          //  fill: gradient.linear(covershade, covershade.opacify(-30%), dir: btt),
          //)
        },
      )
      place(
        top,
        dy: title_displacement + title_height - 1pt,
        {
          make_fade(color: covershade, direction: "btt", width: 100%, height: 60%)
          //box(
          //  width: 100%,
          //  height: 60%,
          //  fill: gradient.linear(covershade, covershade.opacify(-100%), dir: ttb),
          //)
        },
      )
      place(top, dy: title_displacement, box(width: 100%, height: title_height, fill: covershade))
      place(
        top,
        dy: phase_portrait_displacement_y,
        cetz.canvas({
          import cetz.draw: *
          rect((-11, 7), (11, -7), fill: none, stroke: none)
          let path = solve_2d_ivp(f, (-11, 6.4), 400, Delta: .1, method: "rk4")
          catmull(..path, stroke: coverorange + 1.5pt)
        }),
      )
      place(
        top + center,
        dy: title_displacement + .2in,
        text(
          title,
          size: 50pt,
          fill: coverorange.opacify(-50%),
          stroke: coverorange,
          weight: "bold",
        ),
      )
      place(
        top,
        dy: title_displacement + title_height + .07in,
        dx: 50% + 1.25in,
        text(
          subtitle,
          size: 17pt,
          fill: white,
        ),
      )
      place(
        bottom + left,
        dy: -10%,
        layout(size => {
          let content = text(
            align(right, stack(..authors, spacing: .5em)),
            size: 20pt,
            fill: white,
            weight: "bold",
          )
          let text_height = measure(content).height
          box(
            {
              // We have to fake the gradient with an SVG gradient, otherwise the gradient won't show up correctly
              // in the generated PDF. https://github.com/typst/typst/issues/2546
              place(
                top + left,
                dy: -10pt,
                make_fade(color: covershade, direction: "rtl", width: 100% + 10pt, height: 100% + 20pt),
              )
              content
            },
            stroke: (y: covershade + 1.5pt, right: covershade + 1.5pt),
            width: 50%,
            height: text_height + 2 * 10pt,
            inset: 10pt,
            //fill: gradient.linear(covershade.opacify(-100%), covershade.opacify(-20%)),
            fill: none,
          )
        }),
      )
    },
  )
  hide([.])
}

#make_cover(
  "Differential Equations",
  authors: ([Jason Siefken], [Bernardo Galvão-Sousa]),
  subtitle: align(
    left,
    stack(
      [MAT244 Workbook],
      text([#datetime.today().display("[year]/[month]/[day] Edition")], size: 12pt),
      spacing: .6em,
    ),
  ),
)
