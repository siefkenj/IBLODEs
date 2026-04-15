#import "./common.typ": *
#import "./settings.typ": *
#import "./settings-slides.typ": *
#import "./settings-question.typ": *
#import "./settings-guide.typ": *
#import "./environment-module.typ": module
#import "./environments.typ": *
#import "./utils.typ": *

#let CORNER_RADIUS = 2pt

/// A show rule to generate reasonable numbering for an enum.
#let _enum_numbering_show_rule(it) = {
  set enum(full: true, numbering: (..n) => {
    let args = n.pos()
    let depth = args.len()
    let num = args.last()
    let format = ("1.", "(a)", "i.", "(A)", "(I)").at(depth - 1, default: "1.")
    numbering(format, num)
  })
  it
}

/// A colored box to house an annotation
#let annotation_box = e.element.declare(
  "annotation_box",
  prefix: PREFIX,
  doc: "Create an annotation box with a customizable title, color, and body.",
  display: it => {
    let primary_color = it.color
    let light_color = primary_color.lighten(90%)
    let dark_color = primary_color.darken(50%)

    show: sans
    show: _enum_numbering_show_rule
    set list(
      indent: 1.0em,
      spacing: .7em,
    )
    set par(spacing: 1em)
    set list(
      marker: move(dy: -1.25pt, make_marker(color: dark_color)),
      indent: 5pt,
      body-indent: 3pt,
    )

    // Make sure this takes up no room in the original flow
    show: block.with(
      fill: light_color,
      stroke: (
        bottom: primary_color + 1pt,
        top: if it.title != none { none } else { primary_color + 1pt },
      ),
      width: 100%,
      radius: CORNER_RADIUS,
    )
    if it.title != none {
      show: block.with(
        fill: primary_color,
        width: 100%,
        inset: 3pt,
        radius: (
          top: CORNER_RADIUS,
        ),
        below: 0pt,
        sticky: true,
      )
      set text(fill: white)
      show: sans
      it.title
    }
    show: block.with(inset: 3pt, width: 100%)
    set text(size: .9em)
    it.body
  },
  fields: (
    e.field("body", content, required: true, doc: "The body of the annotation box."),
    e.field("color", color, doc: "The color of the annotation box.", default: color.rgb("#00a7d1")),
    e.field(
      "title",
      e.types.option(content),
      doc: "The title of the annotation box.",
      default: none,
    ),
  ),
)

/// Create a learning objectives annotation for a question.
#let _learning_objectives = e.element.declare(
  "learning_objectives",
  prefix: PREFIX,
  doc: "Specify learning objectives for a question.",
  display: it => e.get(get => {
    let global_config = get(global_settings)
    let guide_config = get(guide_settings)
    let module_counter = e.counter(module)
    let learning_objectives_active = if guide_config.learning_objectives_visible == auto {
      guide_config.active
    } else {
      guide_config.learning_objectives_visible
    }

    // If the slide environment is not active, pass through the content un-modified.
    if not learning_objectives_active {
      return none
    }

    import "./environment-question.typ": question
    let question_counter = e.counter(question)
    let question_num = question_counter.get().at(0, default: 0)
    let title = if question_num > 0 {
      [Objectives #h(1fr) (Exercise #question_num)]
    } else {
      [Objectives]
    }

    let primary_color = guide_config.learning_objectives_color
    let body = it.body
    if type(body) == array {
      body = list(..body.map(v => list.item(v)))
    }

    // Make sure this takes up no room in the original flow
    show: place
    marginalia.note(
      numbering: none,
      {
        annotation_box(
          title: title,
          color: primary_color,
          body,
        )
      },
    )
  }),
  fields: (
    e.field(
      "body",
      e.types.union(content, e.types.array(content)),
      required: true,
      doc: "The body of the slide.",
    ),
  ),
)

/// Create a learning objectives annotation for a question.
#let _notes = e.element.declare(
  "notes",
  prefix: PREFIX,
  doc: "Specify notes for a question.",
  display: it => e.get(get => {
    let global_config = get(global_settings)
    let guide_config = get(guide_settings)
    let module_counter = e.counter(module)
    let notes_active = if guide_config.notes_visible == auto {
      guide_config.active
    } else {
      guide_config.notes_visible
    }

    // If the slide environment is not active, pass through the content un-modified.
    if not notes_active {
      return none
    }

    import "./environment-question.typ": question
    let question_counter = e.counter(question)
    let question_num = question_counter.get().at(0, default: 0)
    let title = if question_num > 0 {
      [Notes #h(1fr) (Exercise #question_num)]
    } else {
      [Notes]
    }

    let primary_color = guide_config.notes_color
    let body = it.body
    if type(body) == array {
      body = list(..body.map(v => list.item(v)))
    }

    // Make sure this takes up no room in the original flow
    show: place
    marginalia.note(
      numbering: none,
      {
        annotation_box(
          title: title,
          color: primary_color,
          body,
        )
      },
    )
  }),
  fields: (
    e.field(
      "body",
      e.types.union(content, e.types.array(content)),
      required: true,
      doc: "The body of the notes.",
    ),
  ),
)

/// List learning objectives for a question.
/// You can pass in content blocks directly (i.e. `[...]`) or an array of content blocks (i.e. `([...], [...], ...)`).
/// If you pass in an array, the objectives will show up as a bullet list.
#let learning_objectives(..args) = {
  let pos = args.pos()
  let body = pos
  if pos.len() == 1 {
    body = pos.at(0)
  }
  _learning_objectives(body)
}

/// List notes for a question.
/// You can pass in content blocks directly (i.e. `[...]`) or an array of content blocks (i.e. `([...], [...], ...)`).
/// If you pass in an array, the notes will show up as a bullet list.
#let notes(..args) = {
  let pos = args.pos()
  let body = pos
  if pos.len() == 1 {
    body = pos.at(0)
  }
  _notes(body)
}

/// Insert a page that describes a "lesson". This will reference `questions` that come after it and before the next `lesson`.
#let lesson = e.element.declare(
  "lesson",
  prefix: PREFIX,
  doc: "Insert a lesson page that references questions that come after it.",
  display: it => e.get(get => {
    import "./environment-question.typ": question
    let global_config = get(global_settings)
    let guide_config = get(guide_settings)
    let module_counter = e.counter(module)
    let lesson_counter = e.counter(it)
    let question_counter = e.counter(question)
    let lesson_num = lesson_counter.get().at(0, default: 0)

    let lessons_after = e.query(e.func(it), after: here())
    let included_questions = e.query(question, after: here(), before: none)

    [#included_questions.len() ]
    [#lessons_after.len() ]
    [#e.func(it)]

    [ this is a lesson]
  }),
  fields: (
    e.field(
      "body",
      content,
      required: true,
      doc: "The body of the lesson.",
    ),
    e.field(
      "title",
      content,
      doc: "The title of the lesson.",
    ),
  ),
)

/// Template for making a guide. This should be used as
/// ```typst
/// #show: guide_template
/// ```
/// This will set up the margin environments, etc. suitable for a guide.
#let guide_template(it) = {
  import "./environment-question.typ": question
  // show: marginalia.show-frame
  show: marginalia.setup.with(
    book: false,
    outer: (far: 7pt, sep: 5pt, width: 5.5cm),
    top: 1.5cm,
    bottom: 1cm,
  )
  show: e.prepare(question)
  show: e.set_(global_settings, display_mode: "guide")
  show: e.set_(guide_settings, active: true)
  show link: _show_link
  it
}
