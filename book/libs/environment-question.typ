#import "./common.typ": *
#import "./settings.typ": *
#import "./settings-question.typ": *
#import "./environments.typ": *
#import "./utils.typ": *
#import "environment-only.typ": book_only
#import "settings-slides.typ": *

#let _question_label_state = state("question_label", "??")
#let _question_label_metadata = metadata("question_part_label")

/// Draw a horizontal line with the question number dangling below it.
#let _draw_start_marker(question_counter) = {
  v(4em, weak: true)
  place(dx: -.5in, dy: -.8em, box({
    line(length: 2in, stroke: .5pt)
    place(dy: 6pt, sans(text(
      [#context question_counter.display()],
      fill: color.rgb("#aaa"),
      size: 1em,
    )))
  }))
}

/// Function to explicitly reference a core exercise directly. You probably want to use
/// the `@ref` syntax with the appropriate `show ref: ...` rule instead of this function.
#let _ref_core_exercise(name, supplement: auto, form: "normal") = {
  // Normalize supplement
  if _is_empty(supplement) {
    supplement = none
  }
  if supplement == auto {
    supplement = "Core Exercise"
  }

  let ex_label = if type(name) == label {
    name
  } else if type(name) == str {
    label(name)
  } else {
    assert(false, "ref_core_exercise: name must be a label or a string")
  }
  context {
    let referent = query(ex_label).at(0)
    let display_label = _question_label_state.at(referent.location())
    if supplement != none {
      link(referent.location(), [#supplement~#display_label])
    } else {
      link(referent.location(), display_label)
    }
  }
}

/// Generate a full question address. For example `("4.2", "(a)")` for the subpart (a) of question 4.2.
/// This function is for internal use. It should be joined for a full address, or the last element of the array should be used for a partial address.
#let _generate_question_part_address(question_num, enum_nums) = {
  (
    (str(question_num) + "." + str(enum_nums.at(0)),)
      + enum_nums
        .slice(1)
        .zip(
          ("(a)", "i.", "(A)", "(I)"),
        )
        .map(((n, format)) => numbering(format, n))
  )
}

// Ideas borrowed from https://github.com/typst/typst/issues/779
/// Use to label part of a question for future reference. Regular `<...>` labels
/// cannot be used directly. Instead you must use this function.
///
/// ```typst
/// + Do this
///   + #label_question_part(<first>) Try that
///   + If your answer in @first didn't work, try again.
/// ```
#let label_question_part(name) = {
  let ex_label = if type(name) == label {
    name
  } else if type(name) == str {
    label(name)
  } else {
    assert(false, "label_question_part: name must be a label or a string")
  }

  [#_question_label_metadata#ex_label]
}

/// Create a Core Exercise question.
///
/// Note: for references to work correctly, you must do
/// ```typst
/// #show: e.prepare(question)
/// ```
/// at the start of your document.
#let question = e.element.declare(
  "question",
  prefix: PREFIX,
  doc: "Create a question",
  display: it => e.get(get => {
    let global_config = get(global_settings)
    let question_config = get(question_settings)
    let slide_config = get(slide_settings)
    let question_counter = e.counter(it)

    // Show a copyright footer, unless slides are active, in which case the slides will handle it
    set page(footer: _footer_with_copyright(global_config.copyright)) if (
      slide_config.active == false
    )

    if question_config.include_start_marker {
      _draw_start_marker(question_counter)
    }

    set enum(
      numbering: (..n) => {
        let n = n.pos()
        context {
          let labels = _generate_question_part_address(question_counter.display(), n)
          _question_label_state.update(labels.join(" "))
          // If this is a top-level enumeration, we want to display a "question-style" counter.
          if n.len() == 1 {
            set text(
              fill: color.rgb("#666666"),
              size: .85em,
            )
            show: sans
            labels.at(0)
          } else {
            // We display sub-enumerations as usual.
            labels.at(-1)
          }
        }
      },
      spacing: 1em,
      full: true,
    )
    set terms(indent: 1.5em)
    show terms: it => aligned_terms(
      ..it.children,
      separator: it.separator,
      tight: it.tight,
      spacing: it.spacing,
    )
    set list(
      indent: 1.5em,
      spacing: 1em,
    )

    show pagebreak: it => {
      if slide_config.active {
        it
      } else {
        book_only(
          colbreak(weak: it.weak),
        )
      }
    }
    {
      // Put an invisible header that only shows up in the PDF outline with the question number.
      show heading: none
      heading(
        level: 3,
        outlined: false,
        bookmarked: true,
        numbering: none,
        [#question_counter.display()],
      )
    }
    it.body
  }),
  reference: (
    custom: it => {
      let label = it.at("label", default: none)
      if label == none {
        return
      }
      link(label, [Core Exercise #e.counter(it).display()])
    },
  ),
  prepare: (elem, it) => {
    // Show rule to make references to parts of questions work.
    show ref: it => {
      let el = it.element
      if el == none {
        return it
      }
      if el == _question_label_metadata {
        return _ref_core_exercise(it.target, supplement: it.supplement, form: it.form)
      }
      it
    }
    it
  },
  fields: (
    e.field("body", content, required: true, doc: "The body of the question."),
  ),
)
