#import "./common.typ": *

/// Global settings to affect questions.
#let question_settings = e.element.declare(
  "question_settings",
  doc: "Global settings for the questions.",
  prefix: PREFIX,
  display: it => panic("This element is not meant to be displayed."),
  fields: (
    e.field(
      "include_start_marker",
      bool,
      doc: "Whether a horizontal line with the question number should be drawn before the question. This is used when displaying a question in the context of a book, but not when displaying as slides.",
      default: true,
    ),
  ),
)
