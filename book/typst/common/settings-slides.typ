#import "../libs/_workbook.typ": setup
// Slides are similar to a workbook, so we use the workbook functions as a basis for the slides.
#let workbook = setup(banner_color: color.rgb("#00a2cb"), def_color: color.rgb("#8dc73e"))

#let active_env = "slides"
#import "./defaults.typ": env_lookup_all, restrict

// Bind `lookup_def` with the current definition environment so they appear boxed correctly.
#import "./definitions.typ": show_def
/// Show the definition with the given name. `name` is a string.
#let show_def = show_def.with(definition_env: workbook.definition)

#let slideshade = color.rgb("#00647d")
#let (sans, serif, question_counter) = workbook


/// Render a slide panel with the given content.
/// - `content` (content): The content to render on the slide.
/// - `autosize` (bool): Whether to attempt to automatically size the content to fit on a single slide.
#let slide(content, autosize: true, force_two_column: false, force_scale: none) = {
  let text_size = if force_scale != none { force_scale } else { 1em }
  let x_margin = 1cm
  set page(
    header: {
      place(
        top + left,
        dx: -x_margin,
        box(width: 100% + 2 * x_margin, height: 100% + 3pt, fill: slideshade),
      )
      set text(fill: white, weight: "bold")
      move(
        dx: -0pt,
        dy: -1pt,
        sans([Exercise #context question_counter.display()]),
      )
    },
    footer: {
      place(
        bottom + left,
        dx: -x_margin,
        box(width: 100% + 2 * x_margin, height: 100% + 4pt, fill: slideshade),
      )
      set text(size: .9em)
      place(top + center, [#context counter(page).display()])
      place(top + right, [_#sym.copyright Bernardo Galvão-Sousa & Jason Siefken, 2024--2025_])
    },
  )
  if autosize == false {
    content
  } else {
    layout(size => {
      // Attempt a series of layout options to try and get the content to fit on a single slide
      let adjusted_content = block(
        breakable: false,
        width: size.width,
        {
          set text(size: text_size)
          content
        },
      )
      let content_dim = measure(adjusted_content)
      if content_dim.height < 1.0 * size.height and not force_two_column {
        block(
          breakable: false,
          adjusted_content,
        )
      } else {
        let content = {
          set text(size: text_size)
          content
        }
        // We're now in two columns, but `measure` will assume infinite height. Use
        // the heuristic that columns will cut the height in half.
        content_dim = measure(block(breakable: false, width: size.width / 2, content))
        // Calculate the percentage overflow we have for a two-column layout
        let percent_over = content_dim.height / 2.05 / size.height
        if percent_over < 1 {
          block(
            breakable: false,
            columns(
              2,
              gutter: 8pt,
              content,
            ),
          )
        } else {
          let text_size = if force_scale != none { force_scale } else { calc.max(1 / percent_over, 0.85) * 1em }
          block(
            breakable: false,
            {
              set text(size: text_size)
              columns(
                2,
                gutter: 8pt,
                content,
              )
            },
          )
        }
      }
    })
  }
}



#let env = env_lookup_all(
  base_env: (
    ..workbook,
    active_env: active_env,
    restrict: restrict.with(active_env: active_env),
    slide: slide,
    question: workbook.question.with(include_start_marker: false),
    show_def: show_def,
  ),
)

