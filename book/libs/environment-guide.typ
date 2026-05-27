#import "./common.typ": *
#import "./settings.typ": *
#import "./settings-slides.typ": *
#import "./settings-question.typ": *
#import "./settings-guide.typ": *
#import "./environment-module.typ": _colored_sidebar, module
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

/// Marker for the end of the lessons. This is used to determine which questions/modules belong to which lessons.
#let lessons_end = e.element.declare(
  "lessons_end",
  prefix: PREFIX,
  doc: "Marker for the end of the lessons. This is used to determine which questions/modules belong to which lessons.",
  display: it => none,
  fields: (),
)

/// Find all questions/modules/lessons in the document. They are split between ones that are before `here()` and ones that are after `here()`.
/// `lesson_func` must be passed in. If used inside the `lesson` display function, this should be `e.func(it)`.
///
/// If a `lessons_end` element is encountered, everything after that is ignored.
#let _find_all_questions_modules_lessons(lesson_func) = {
  import "environment-question.typ": question
  import "environment-module.typ": module
  let question_eid = e.eid(question)
  let module_eid = e.eid(module)
  let lesson_eid = e.eid(lesson_func)
  let lessons_end_eid = e.eid(lessons_end)

  let instance_to_data(instance_meta) = {
    let eid = e.eid(instance_meta.value)
    let (name, counter) = if eid == question_eid {
      ("question", e.counter(question))
    } else if eid == module_eid {
      ("module", e.counter(module))
    } else if eid == lesson_eid {
      ("lesson", e.counter(lesson_func))
    } else if eid == lessons_end_eid {
      ("lessons_end", counter("unknown"))
    } else {
      ("unknown", counter("unknown"))
    }
    let location = instance_meta.location()
    let num = counter.at(location).at(0, default: 0)
    (
      name: name,
      num: num,
      location: location,
    )
  }

  let base_selector = selector(e.selector(lesson_func, meta: true))
    .or(e.selector(question, meta: true))
    .or(e.selector(module, meta: true))
    .or(e.selector(lessons_end, meta: true))
  let before = query(base_selector.before(here())).map(qm => instance_to_data(qm))
  let after = query(base_selector.after(here())).map(qm => instance_to_data(qm))
  let self = after.at(0, default: none)
  after = if after.len() > 0 {
    after.slice(1)
  } else {
    after
  }
  after = after.slice(0, after.position(v => v.name == "lessons_end"))

  (before: before, self: self, after: after)
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
    let lesson_active = if guide_config.lessons_visible == auto {
      guide_config.active
    } else {
      guide_config.lessons_visible
    }
    if not lesson_active {
      return
    }

    let (
      before: before_items,
      self: self_item,
      after: after_items,
    ) = _find_all_questions_modules_lessons(e.func(it))

    // The included questions are those that come after us (the lesson) and before the next lesson.
    let included_questions = after_items
      .slice(0, after_items.position(v => v.name == "lesson"))
      .filter(v => v.name == "question")
    let included_question_nums = included_questions.map(q => q.num)
    // Lessons may overlap more than one module boundary. The rules are:
    //  1. A lesson includes the module immediately before it.
    //  2. A lesson includes any modules following it, but before the next lesson UNLESS
    //    - the next lesson comes directly after a module (with no questions in between), in which
    //      case, that module is omitted.
    let module_before = before_items.rev().find(v => v.name == "module")
    // Filter out any modules "after" that are immediately followed by a lesson.
    let after_filtered = after_items
      .enumerate()
      .filter(((i, v)) => {
        v.name != "module" or after_items.at(i + 1, default: (name: "")).name != "lesson"
      })
      .map(((i, v)) => v)
    let modules_after = after_filtered
      .slice(0, after_filtered.position(v => v.name == "lesson"))
      .filter(v => v.name == "module")

    let included_modules = if module_before != none {
      (module_before, ..modules_after)
    } else {
      modules_after
    }


    let question_range = if included_question_nums.len() == 0 {
      "(No exercises)"
    } else if included_question_nums.len() == 1 {
      [#included_question_nums.at(0)]
    } else {
      [#included_question_nums.at(0);--#included_question_nums.at(-1)]
    }

    let title = if it.title != none {
      [#it.ref_label: #it.title]
    } else {
      it.ref_label
    }
    let formatted_title = sans(text(title, size: 1.5em, weight: "medium", fill: white))
    show: _colored_sidebar.with(
      first_page_label: formatted_title,
      other_page_label: formatted_title,
      bar_color: guide_config.lesson_color,
    )

    heading(title)

    if included_modules.len() > 0 {
      if included_modules.len() == 1 {
        [== #text(weight: "medium")[Module:] #included_modules.at(0).num]
      } else {
        [== #text(weight: "medium")[Modules:] #included_modules.map(m => str(m.num)).join(", ")]
      }
    }

    [== #text(weight: "medium")[Core Exercises:] #question_range]

    v(1em)

    it.body
  }),
  synthesize: it => {
    let count = e.counter(it).get().first()
    it.ref_label = [Lesson #count]
    it
  },
  fields: (
    e.field(
      "body",
      content,
      required: true,
      doc: "The body of the lesson.",
    ),
    e.field(
      "title",
      e.types.option(content),
      doc: "The title of the lesson.",
    ),
    e.field(
      "ref_label",
      str,
      doc: "The label to be used when referring to this lesson.",
      synthesized: true,
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
