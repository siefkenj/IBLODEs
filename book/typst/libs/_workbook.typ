
/// Create a marker of a given color with a bullet inside of it
/// so its content can be copy-and-pasted and still appear as a list.
#let make_marker(color: blue) = move(dy: 2pt, box(fill: color, width: 4.5pt, height: 4.5pt, move(
  dy: -1pt,
  dx: -1pt,
  text(
    fill: color,
    [•],
  ),
)))


/// Accept any number of arguments and return only the content in positional arguments.
/// This is used as a default "pass through everything" function.
#let noop(..args) = {
  args.pos().filter(c => type(c) == content).join()
}

/// Copy from tools4typst
/// return true if value is an empty array, dictionary, string or content
#let is_empty(value) = {
  let empty-values = (
    array: (),
    dictionary: (:),
    str: "",
    content: [],
  )
  let t = repr(type(value))
  if t in empty-values {
    return value == empty-values.at(t)
  } else {
    return value == none
  }
}

#let module_counter = counter("module")
#let appendix_counter = counter("appendix")

#let _module_label_metadata = metadata("module_label")
#let _appendix_label_metadata = metadata("appendix_label")
#let _core_exercise_label_metadata = metadata("core_exercise_label")
#let _core_exercise_label_state = state("core_exercise_label", "??")

// Ideas borrowed from https://github.com/typst/typst/issues/779
/// Use to label a core exercise for future reference. Regular `<...>` labels
/// cannot be used as core exercises cannot be "attached" to regular labels.
#let label_core_exercise(name) = {
  let ex_label = if type(name) == label {
    name
  } else if type(name) == str {
    label(name)
  } else {
    assert(false, "label_core_exercise: name must be a label or a string")
  }

  [#_core_exercise_label_metadata#ex_label]
}

/// Use to label a module for future reference. Regular `<...>` labels
/// cannot be used, so you must explicitly use this function instead.
#let label_module(name) = {
  let mod_label = if type(name) == label {
    name
  } else if type(name) == str {
    label(name)
  } else {
    assert(false, "label_module: name must be a label or a string")
  }

  [#_module_label_metadata#mod_label]
}

/// Use to label an appendix for future reference. Regular `<...>` labels
/// cannot be used, so you must explicitly use this function instead.
#let label_appendix(name) = {
  let mod_label = if type(name) == label {
    name
  } else if type(name) == str {
    label(name)
  } else {
    assert(false, "appendix_module: name must be a label or a string")
  }

  [#_appendix_label_metadata#mod_label]
}


/// Function to explicitly reference a core exercise directly. You probably want to use
/// the `@ref` syntax with the appropriate `show ref: ...` rule instead of this function.
#let ref_core_exercise(name, supplement: auto, form: "normal") = {
  // Normalize supplement
  if is_empty(supplement) {
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
    let display_label = _core_exercise_label_state.at(referent.location())
    if supplement != none {
      link(referent.location(), [#supplement~#display_label])
    } else {
      link(referent.location(), display_label)
    }
  }
}

/// Function to explicitly reference a core exercise directly. You probably want to use
/// the `@ref` syntax with the appropriate `show ref: ...` rule instead of this function.
#let ref_module(name, supplement: auto, form: "normal") = {
  // Normalize supplement
  if is_empty(supplement) {
    supplement = none
  }
  if supplement == auto {
    supplement = "Module"
  }

  let ex_label = if type(name) == label {
    name
  } else if type(name) == str {
    label(name)
  } else {
    assert(false, "ref_module: name must be a label or a string")
  }
  context {
    let referent = query(ex_label).at(0)
    let display_label = module_counter.at(referent.location()).at(0)
    if supplement != none {
      link(referent.location(), [#supplement~#display_label])
    } else {
      link(referent.location(), [#display_label])
    }
  }
}

/// Function to explicitly reference a core exercise directly. You probably want to use
/// the `@ref` syntax with the appropriate `show ref: ...` rule instead of this function.
#let ref_appendix(name, supplement: auto, form: "normal") = {
  // Normalize supplement
  if is_empty(supplement) {
    supplement = none
  }
  if supplement == auto {
    supplement = "Appendix"
  }

  let ex_label = if type(name) == label {
    name
  } else if type(name) == str {
    label(name)
  } else {
    assert(false, "ref_module: name must be a label or a string")
  }
  context {
    let referent = query(ex_label).at(0)
    let display_label = numbering("A", appendix_counter.at(referent.location()).at(0))
    if supplement != none {
      link(referent.location(), [#supplement~#display_label])
    } else {
      link(referent.location(), [#display_label])
    }
  }
}

/// A show rule suitable for using with `show ref: _show_ref` so that `@ref` syntax works for core exercises.
#let _show_ref(it) = {
  let el = it.element
  if el == none {
    return it
  }
  if el.func() == metadata {
    // Check if the element attached to the ref is a core exercise label.
    if el == _core_exercise_label_metadata {
      ref_core_exercise(it.target, supplement: it.supplement, form: it.form)
    } else if el == _module_label_metadata {
      ref_module(it.target, supplement: it.supplement, form: it.form)
    } else if el == _appendix_label_metadata {
      ref_appendix(it.target, supplement: it.supplement, form: it.form)
    } else {
      text(fill: red, [Invalid Ref #repr(it.target) to #repr(el)])
    }
  } // Check if we are referencing an equation and use parenthesized numbering.
  else if el.func() == math.equation {
    let eq_number = numbering(el.numbering, ..counter(math.equation).at(el.location()))
    let supp = it.supplement
    if is_empty(supp) {
      supp = none
    }
    if supp == auto {
      supp = "Equation"
    }
    if supp != none {
      return link(el.location(), [#supp~#eq_number])
    } else {
      return link(
        el.location(),
        eq_number,
      )
    }
  } else {
    it
  }
}



#let setup(
  serif_font: ("New Computer Modern", "DejaVu Sans Mono", "Bitstream Charter"),
  sans_font: ("Droid Sans", "DejaVu Sans"),
  mono_font: ("Droid Sans Mono", "DejaVu Sans Mono"),
  def_color: color.rgb("#8dc73e"),
  thm_color: color.rgb("#ed9537"),
  title_color: color.rgb("#00a2cb"),
  banner_color: color.rgb("#8900b3"),
  appendix_banner_color: color.rgb("#8dc73e"),
  banner_width: 1.15in,
) = {
  let config = (serif_font: serif_font, sans_font: sans_font, mono_font: mono_font)

  /// Set the font to the serif font.
  let sans(content) = {
    set text(font: config.sans_font)
    content
  }
  /// Set the font to the sans font.
  let serif(content) = {
    set text(font: config.serif_font)
    content
  }
  /// Set the font to the mono font.
  let mono(content) = {
    set text(font: config.mono_font)
    content
  }

  /// Function to be used in the `show link: ...` rule. It shows http links in monospace, but internal document
  /// links are left unchanged.
  let _show_link(it) = {
    if type(it.dest) == str {
      return mono(it)
    }
    it
  }

  /// Create a boxed definition.
  /// - title (content): The title of the definition.
  /// - label (label | none): The label of the definition for referencing it.
  /// - content (content): The body of the definition.
  let definition(title: none, label: none, content) = {
    let darker_color = def_color.darken(30%)
    show emph: it => text(it, fill: darker_color, weight: "bold")
    set list(marker: make_marker(color: darker_color))
    box(
      fill: def_color.lighten(80%),
      stroke: (left: def_color + 3pt),
      inset: 7pt,
      {
        text(
          [#title.#if label != none { label } else { none }],
          fill: darker_color,
          weight: "bold",
          font: sans_font,
        )
        content
      },
      width: 100%,
    )
  }

  /// Create an example based on a prompt.
  let example(prompt: none, content) = {
    let ex_color = color.gray
    let darker_color = ex_color.darken(50%)
    show emph: it => text(it, fill: darker_color, weight: "bold")
    set list(marker: make_marker(color: darker_color))
    block(
      fill: ex_color.lighten(90%),
      stroke: (left: ex_color + 1.5pt),
      breakable: true,
      inset: 7pt,
      {
        text(
          [Example.],
          fill: color.black,
          weight: "bold",
          font: sans_font,
        )
        sym.space.quad
        // Use of `box` prevents excessive line breaks from being displayed.
        prompt
        parbreak()
        v(.5em)
        block(
          width: 100%,
          content,
        )
      },
      width: 100%,
    )
  }


  /// Create a theorem based on a title.
  let theorem(title: none, content) = {
    let thm_color = color.purple
    let darker_color = thm_color.darken(50%)
    show emph: it => text(it, fill: darker_color, weight: "bold")
    set list(marker: make_marker(color: darker_color))
    block(
      fill: thm_color.lighten(90%),
      stroke: (left: thm_color + 1.5pt),
      inset: 7pt,
      {
        block(sticky: true, text(
          [Theorem (#box(title))],
          fill: color.purple,
          weight: "bold",
          font: sans_font,
        ))
        block(content)
      },
      width: 100%,
    )
  }

  // We need to keep track of the page where a module starts so we can format the first page differently.
  let module_start_page = state("module_start_page", 0)
  /// Draw a banner on the left/right side of each page.
  let place_banner(
    banner_color: banner_color,
    banner_for: "module",
    title: text(fill: red, "MISSING TITLE"),
  ) = {
    context {
      let banner_side = if calc.even(counter(page).get().at(0)) { "left" } else { "right" }
      let pos = if banner_side == "left" { top + left } else { top + right }
      let is_first = here().page() == module_start_page.get()
      let label_intro = if banner_for == "module" {
        [Module #module_counter.display()]
      } else if banner_for == "appendix" {
        [Appendix #appendix_counter.display("A")]
      } else {
        assert(false, "place_banner: banner_for must be 'module' or 'appendix'")
      }
      let module_label = if is_first {
        text(size: 1.5em, label_intro)
      } else {
        [#label_intro --- #title]
      }

      place(
        pos,
        dy: 3pt,
        dx: if banner_side == "left" { 3pt } else { -3pt },
        box(fill: banner_color, width: banner_width - 3pt, height: 100% - 6pt, {
          set text(
            fill: white,
            size: 1.25em,
          )
          place(top + center, dy: 20%, sans(rotate(-90deg, reflow: true, {
            module_label
          })))
        }),
      )
    }
  }

  // The `set_args` are things to use in `set foo(...)` expressions that are common to modules and appendices.

  let module_enum_set_args = (
    numbering: (..n) => {
      let depth = n.pos().len()
      let marker = ("1.", "(a)", "i.", "A.", "I.").at(depth - 1, default: "(1)")
      numbering(marker, n.at(-1))
    },
    indent: 5pt,
    full: true,
  )
  let module_page_set_args(copyright: none) = (
    numbering: "1",
    margin: (inside: 1in, outside: banner_width + 10pt, bottom: .55in, top: .35in),
    footer: context {
      grid(
        columns: (1fr, auto, 1fr),
        align: (left, center, right),
        none, counter(page).display(), copyright,
      )
    },
  )
  let module_list_set_args(bullet_color) = (
    marker: make_marker(color: bullet_color.darken(20%)),
    indent: 5pt,
    body-indent: 3pt,
  )

  /// Define a module containing the given content.
  /// Modules have a big banner along the side.
  let module(title: [], copyright: none, content) = {
    let darker_color = title_color.darken(20%)

    // Make sure modules always start on the "right" page (i.e., on the front of a two-sided page).
    pagebreak(to: "odd", weak: true)
    // Increment the module counter.
    context module_counter.step()
    // Save the page of where the module starts. This allows us to format the first page differently than the others.
    context module_start_page.update(here().page())


    set list(..module_list_set_args(darker_color))
    set enum(..module_enum_set_args)
    set page(..module_page_set_args(copyright: copyright))
    set page(background: place_banner(
      banner_for: "module",
      banner_color: banner_color,
      title: title,
    ))
    show heading.where(depth: 1): it => {
      block(width: 100%, align(center, move(dx: 5pt, it)))
    }
    show heading: it => {
      set text(fill: title_color, weight: "light")
      move(dx: -5pt, sans(it))
    }
    show link: _show_link

    heading(level: 1, [#title <module_start>])
    content
  }

  /// Define an appendix containing the given content.
  /// Appendices have a big banner along the side.
  let appendix(title: [], copyright: none, content) = {
    let title_color = appendix_banner_color.darken(10%)
    let darker_color = title_color.darken(20%)

    // Make sure modules always start on the "right" page (i.e., on the front of a two-sided page).
    pagebreak(to: "odd", weak: true)
    // Increment the module counter.
    context appendix_counter.step()
    // Save the page of where the module starts. This allows us to format the first page differently than the others.
    context module_start_page.update(here().page())

    set list(..module_list_set_args(darker_color))
    set enum(..module_enum_set_args)
    set page(..module_page_set_args(copyright: copyright))
    set page(background: place_banner(
      banner_for: "appendix",
      banner_color: appendix_banner_color,
      title: title,
    ))
    show heading.where(depth: 1): it => {
      block(width: 100%, align(center, move(dx: 5pt, it)))
    }
    show heading: it => {
      set text(fill: title_color, weight: "light")
      move(dx: -5pt, sans(it))
    }

    heading(level: 1, [#title <appendix_start>])

    show link: _show_link
    content
  }

  let core_exercises(content) = {
    let darker_color = title_color.darken(20%)
    set list(
      marker: make_marker(color: darker_color),
      indent: 5pt,
      body-indent: 3pt,
    )
    set enum(
      numbering: (..n) => {
        let depth = n.pos().len()
        let marker = ("1.", "(a)", "i.", "A.", "I.").at(depth - 1, default: "(1)")
        numbering(marker, n.at(-1))
      },
      indent: 5pt,
      full: true,
    )
    show heading.where(depth: 1): it => {
      block(width: 100%, align(center, move(dx: 5pt, it)))
    }
    show heading: it => {
      set text(fill: title_color, weight: "light")
      move(dx: -5pt, sans(it))
    }
    set page(numbering: "1", margin: (
      inside: 1in,
      outside: banner_width + 10pt,
      bottom: .55in,
      top: .35in,
    ))

    // Make sure modules always start on the "right" page (i.e., on the front of a two-sided page).
    pagebreak(to: "odd", weak: true)

    show link: _show_link
    content
  }

  let question_counter = counter("question")
  /// Create a new core exercise.
  let question(content, include_start_marker: true) = {
    question_counter.step()
    if include_start_marker {
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
    set enum(
      numbering: (..n) => {
        let n = n.pos()
        // If this is a top-level enumeration, we want to display a "question-style" counter.
        if n.len() == 1 {
          sans(text(
            context {
              let part_label = [#question_counter.display().#n.at(0)]
              _core_exercise_label_state.update(part_label)
              part_label
            },
            fill: color.rgb("#666666"),
            size: .85em,
          ))
        } else {
          // We display sub-enumerations as usual.
          let n = n.slice(1)
          let number_format = ("(a)", "i.", "(A)", "(I)").at(n.len() - 1, default: "(a)")
          let nums = numbering(number_format, n.at(-1))
          nums
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

    show link: _show_link
    // Set the references to use the current question counter.
    context {
      let part_label = [#question_counter.display()]
      _core_exercise_label_state.update(part_label)
    }
    [
      // Inserting `metadata` here allows us to attach a label to the core exercise so that it can be referenced later.
      #metadata("core_exercise")
      <core_exercise>
      #content
    ]
  }
  /// Display the solution to a question.
  let solution(content) = {
    set text(fill: blue)
    v(-1.5em)
    quote(block: true, content)
  }


  return (
    sans: sans,
    serif: serif,
    module: module,
    appendix: appendix,
    definition: definition,
    example: example,
    theorem: theorem,
    slide: noop,
    core_exercises: core_exercises,
    question: question,
    question_counter: question_counter,
    solution: solution,
  )
}

/// Display exercises in a module. This function strips out any solutions.
///
/// - questions ( ((statement: content, solution: content | none, citation: content | none),) ): A list of questions (possibly with solutions).
#let exercises(questions, module_number: 0) = {
  [== Practice Problems]
  columns(
    2,
    questions
      .enumerate()
      .map(((i, q)) => (
        {
          show: block.with(inset: (left: 1.5em))
          {
            show: place.with(top)
            show: move.with(dx: -1.5em)
            [#(i + 1).]
            if q.at("citation", default: none) != none {
              show: footnote.with(numbering: "*")
              text(fill: blue, [#q.citation])
            }
          }
          q.statement
        }
      ))
      .join(),
  )
}

/// Display solutions for exercises.
///
/// - questions ( ((statement: content, solution: content | none, citation: content | none),) ): A list of questions (possibly with solutions).
#let solutions(questions, module_number: 0, type: "Module") = {
  [== Solutions for #type #module_number]
  columns(2, {
    enum(
      ..questions
        .enumerate()
        .map(((i, q)) => {
          let item_number = i + 1
          // Only display the solution if one is defined
          if q.at("solution", default: none) == none {
            none
          } else {
            enum.item(
              item_number,
              {
                text(fill: blue, q.at("solution"))
              },
            )
          }
        })
        .filter(it => it != none),
    )
  })
}

/// Display a term list with each items contents aligned.
/// Use
/// ```
/// #show terms: it => aligned_terms(..it.children, separator: it.separator, tight: it.tight, spacing: it.spacing)
/// ```
/// to activate.
#let aligned_terms(..items, separator: [], spacing: auto, tight: true) = context {
  pad(left: 1.5em, grid(
    columns: 2,
    align: (right, left),
    row-gutter: if spacing != auto { spacing } else if tight { par.leading } else { par.spacing },
    column-gutter: 8pt,
    // note: 'box(width: 0pt)' is to ensure weak spacing is not collapsed
    ..items
      .pos()
      .map(it => (
        [
          #it.term#separator#box(width: 0pt);
        ],
        it.description,
      ))
      .join()
  ))
}

/// Create a simple table with a header row and centered columns.
#let simple_table(headers: (), columns: none, content: ()) = {
  if columns == none {
    columns = headers.len()
  }
  table(
    columns: columns,
    align: center,
    stroke: none,
    ..range(columns - 1).map(x => table.vline(x: x + 1, stroke: .5pt)),
    table.header(..headers),
    table.hline(stroke: .5pt),
    ..content,
  )
}

