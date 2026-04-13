#import "environment-slides.typ": *
#import "environments.typ": *
#import "environment-question.typ": *
#show: e.prepare()

#set page(
  width: 16cm,
  height: 9cm,
  margin: (
    top: 1.2em,
    bottom: 3cm,
    left: .5cm,
    right: .5cm,
  ),
)
#set text(size: 10pt)

#slide(title: "Custom title slide")[
  This is a custom title slide.
]

#slide[
  Lots of content.

  #lorem(50)

  #lorem(50)
]

#slide[
  Lots *more 1* content.

  #lorem(50)

  #lorem(50)

  #lorem(30)
]

#slide[
  Lots *more 2* content.

  #lorem(50)

  #lorem(50)

  #lorem(50)
]

#slide[
  Lots *more 3* content.

  #lorem(50)

  #lorem(50)

  #lorem(70)
]

= Set the colors

#[
  #show: e.set_(slide_settings, top_bg_color: oklch(57.41%, 0.124, 55.4deg))
  #slide[
    This slide has different colors of margins.

    If only the top background color is set, both backgrounds get that color.
  ]
]

#[
  #show: e.set_(slide_settings, top_bg_color: oklch(57.41%, 0.124, 55.4deg), bottom_bg_color: oklch(
    100%,
    0,
    90deg,
  ))
  #slide[
    This slide has different colors of margins.

    If both the top and bottom background colors are set, they will be used accordingly.
  ]
]
#[
  #show: e.set_(slide_settings, top_bg_color: oklch(92.93%, 0.106, 128.88deg))
  #slide[
    Testing a light title color
  ]
]
#[
  #show: e.set_(slide_settings, top_bg_color: white)
  #slide[
    White for both backgrounds.
  ]
]

= Test forcing of the auto-sizer, sizing, etc.

#slide(title: "Testing auto-sizer", force_scale: 2em)[
  This slide should have its text scaled up significantly, and the title should also be larger than
  normal.
]

#slide(title: "No auto-sizing", autosize: false)[
  This slide should not be auto-sized, and instead should just be rendered at the normal text size,
  which will likely cause overflow.

  #lorem(60)

  #lorem(60)
]


#slide(title: "Force two columns", force_two_column: true)[
  This slide should have its text scaled up significantly, and the title should also be larger than
  normal.

  #colbreak()

  There also should be two columns no matter what.
]

= Inactive slide

#[
  #show: e.set_(slide_settings, active: false)
  #slide[
    This slide should not have any special formatting, and should just be rendered as normal
    content.
  ]
]

#pagebreak()

= Slide inside a question

#pagebreak()
#show: e.prepare(question)
#show: e.set_(question_settings, include_start_marker: false)
#question[
  #slide[
    This slide is inside a question, so it should be formatted like a normal slide, but there should
    be no question number or "question-style" counter.

    #lorem(50)

    #lorem(50)
  ]
]

#question({
  slide[
    Two slides for one question (A)
  ]
  slide[
    Two slides for one question (B)

    The counter should be the same as the previous slide.
  ]
})
