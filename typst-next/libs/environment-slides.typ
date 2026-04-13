#import "./common.typ": *
#import "./settings.typ": *
#import "./settings-slides.typ": *
#import "./settings-question.typ": *
#import "./environment-question.typ": question
#import "./environment-module.typ": module
#import "./environments.typ": *
#import "./utils.typ": *

/// For backgrounds that go up to the very edge of the slide, make them overrun the edge by this much
/// to avoid any stripes of background seeping through.
#let FILL_BLEED = 2pt

/// Create a slide. If `slide_settings.active` is `false`, the content of the slide will be
/// directly passed through and no border/etc. will be shown.
#let slide = e.element.declare(
  "slide",
  prefix: PREFIX,
  doc: "Create a slide.",
  display: it => e.get(get => {
    let global_config = get(global_settings)
    let slide_config = get(slide_settings)
    let question_counter = e.counter(question)
    let module_counter = e.counter(module)

    // If the slide environment is not active, pass through the content un-modified.
    if not slide_config.active {
      return it.body
    }

    let top_margin_color = slide_config.top_bg_color
    let bottom_margin_color = if slide_config.bottom_bg_color == auto {
      top_margin_color
    } else {
      slide_config.bottom_bg_color
    }
    let heading_text_color = if oklch(top_margin_color).components().at(0) < 60% {
      color.white
    } else {
      top_margin_color.darken(70%)
    }
    let footer_text_color = if oklch(bottom_margin_color).components().at(0) > 50% {
      bottom_margin_color.darken(30%)
    } else {
      bottom_margin_color.darken(70%)
    }


    let text_size = if it.force_scale != none { it.force_scale } else { 1em }
    let (
      left: left_margin,
      right: right_margin,
      top: top_margin,
      bottom: bottom_margin,
    ) = _compute_margins()
    // let body_height = page.height - top_margin - bottom_margin

    set page(
      header-ascent: 0pt,
      header: {
        show: pad.with(left: -left_margin - FILL_BLEED, right: -right_margin - FILL_BLEED)
        show: block.with(
          breakable: false,
          fill: top_margin_color,
          width: 100%,
          height: 100% + FILL_BLEED,
          inset: (y: 2pt, left: left_margin + FILL_BLEED, right: right_margin + FILL_BLEED),
        )
        set text(fill: heading_text_color, weight: "bold")
        show: sans
        if it.title == none {
          [Exercise #question_counter.display()]
          // If the module counter is > 0, show the current module
          if module_counter.get().at(0, default: 0) > 0 {
            h(1fr)
            text(weight: "thin", size: .8em, baseline: -2pt)[Module #module_counter.display()]
          }
        } else {
          it.title
        }
      },
      footer-descent: 0pt,
      footer: {
        show: pad.with(left: -left_margin - FILL_BLEED, right: -right_margin - FILL_BLEED)
        show: block.with(
          breakable: false,
          fill: bottom_margin_color,
          width: 100%,
          height: 100% + FILL_BLEED,
          inset: (y: 2pt, left: left_margin + FILL_BLEED, right: right_margin + FILL_BLEED),
        )
        set text(size: .83em, fill: footer_text_color)
        place(top + center, [#context counter(page).display()])
        set align(right)
        slide_config.copyright
      },
    )
    //
    // Lay out the content
    //
    show: block.with(
      breakable: false,
      width: 100%,
      height: 100%,
      inset: (y: 3pt),
    )
    // [#body_height, #page.height]
    let content = it.body
    if it.autosize == false {
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
        if content_dim.height < 1.0 * size.height and not it.force_two_column {
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
            let text_size = if it.force_scale != none { it.force_scale } else {
              calc.max(1 / percent_over, 0.85) * 1em
            }
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
  }),
  reference: (
    custom: it => {
      let label = it.at("label", default: none)
      if label == none {
        return
      }
      link(label, it.title)
    },
  ),
  fields: (
    e.field("title", e.types.option(content), doc: "The title of the slide."),
    e.field("body", content, required: true, doc: "The body of the slide."),
    e.field(
      "autosize",
      bool,
      doc: "Whether the slide should automatically resize to fit its content.",
      default: true,
    ),
    e.field(
      "force_two_column",
      bool,
      doc: "Whether to force the slide to be two columns, even if the content would fit better in a single column.",
      default: false,
    ),
    e.field(
      "force_scale",
      e.types.option(length),
      doc: "If set, the slide will be scaled by this factor. This can be used to force the content to fit on a single slide if `autosize` is not sufficient.",
      default: none,
    ),
  ),
)

/// Template for making a slides. This should be used as
/// ```typst
/// #show: slides_template
/// ```
#let slides_template(it) = {
  show: e.prepare(question)
  show: e.set_(slide_settings, active: true)
  show: e.set_(global_settings, display_mode: "slides")
  show: e.set_(question_settings, include_start_marker: false)
  show link: _show_link
  set par(justify: true)
  set page(
    width: 17.7cm,
    height: 10cm,
    margin: (
      x: 4pt,
      top: 1.15em,
      bottom: 3cm,
    ),
  )
  it
}
