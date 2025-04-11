
/// Create a marker of a given color with a bullet inside of it
/// so its content can be copy-and-pasted and still appear as a list.
#let make_marker(color: blue) = move(
  dy: 2pt,
  box(
    fill: color,
    width: 4.5pt,
    height: 4.5pt,
    move(dy: -2pt, text(fill: color, [•])),
  ),
)


/// Accept any number of arguments and return only the content in positional arguments.
/// This is used as a default "pass through everything" function.
#let noop(..args) = {
  args.pos().filter(c => type(c) == content).join()
}

#let setup(
  serif_font: ("New Computer Modern", "DejaVu Sans Mono", "Bitstream Charter"),
  sans_font: ("Droid Sans", "DejaVu Sans"),
  mono_font: ("Droid Sans Mono", "DejaVu Sans Mono"),
  def_color: color.rgb("#8dc73e"),
  thm_color: color.rgb("#ed9537"),
  title_color: color.rgb("#00a2cb"),
  banner_color: color.rgb("#8900b3"),
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
    box(
      fill: ex_color.lighten(90%),
      stroke: (left: ex_color + 1.5pt),
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
        box(prompt)
        v(.2em)
        box(content)
      },
      width: 100%,
    )
  }

  // We need to keep track of the page where a module starts so we can format the first page differently.
  let module_start_page = state("module_start_page", 0)

  /// Define a module containing the given content.
  /// Modules have a big banner along the side.
  let module(title: [], content) = {
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
      block(
        width: 100%,
        align(center, move(dx: 5pt, it)),
      )
    }
    show heading: it => {
      set text(fill: title_color, weight: "light")
      move(
        dx: -5pt,
        sans(it),
      )
    }
    set page(
      numbering: "1",
      margin: (inside: 1in, outside: banner_width + 10pt, bottom: .55in, top: .35in),
    )

    // Make sure modules always start on the "right" page (i.e., on the front of a two-sided page).
    pagebreak(to: "odd", weak: true)
    // Increment the module counter.
    context counter("module").step()
    // Save the page of where the module starts. This allows us to format the first page differently than the others.
    context module_start_page.update(here().page())
    set page(
      background: context {
        let banner_side = if calc.even(counter(page).get().at(0)) { "left" } else { "right" }
        let pos = if banner_side == "left" { top + left } else { top + right }
        let is_first = here().page() == module_start_page.get()
        let module_label = if is_first {
          text(size: 1.5em, [Module #counter("module").display()])
        } else {
          [Module #counter("module").display() --- #title]
        }

        place(
          pos,
          dy: 3pt,
          dx: if banner_side == "left" { 3pt } else { -3pt },
          box(
            fill: banner_color,
            width: banner_width - 3pt,
            height: 100% - 6pt,
            {
              set text(
                fill: white,
                size: 1.25em,
              )
              place(
                top + center,
                dy: 20%,
                sans(
                  rotate(
                    -90deg,
                    reflow: true,
                    {
                      module_label
                    },
                  ),
                ),
              )
            },
          ),
        )
      },
    )
    heading(level: 1, [#title <module_start>])

    show link: mono
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
      block(
        width: 100%,
        align(center, move(dx: 5pt, it)),
      )
    }
    show heading: it => {
      set text(fill: title_color, weight: "light")
      move(
        dx: -5pt,
        sans(it),
      )
    }
    set page(
      numbering: "1",
      margin: (inside: 1in, outside: banner_width + 10pt, bottom: .55in, top: .35in),
    )

    // Make sure modules always start on the "right" page (i.e., on the front of a two-sided page).
    pagebreak(to: "odd", weak: true)

    show link: mono
    content
  }

  let question_counter = counter("question")
  /// Create a new core exercise.
  let question(content, include_start_marker: true) = {
    question_counter.step()
    if include_start_marker {
      v(4em, weak: true)
      place(
        dx: -.5in,
        dy: -.8em,
        box({
          line(length: 2in, stroke: .5pt)
          place(
            dy: 6pt,
            sans(
              text(
                [#context question_counter.display()],
                fill: color.rgb("#aaa"),
                size: 1em,
              ),
            ),
          )
        }),
      )
    }
    set enum(
      numbering: (..n) => {
        let n = n.pos()
        // If this is a top-level enumeration, we want to display a "question-style" counter.
        if n.len() == 1 {
          sans(
            text(
              [#context question_counter.display().#n.at(0)],
              fill: color.rgb("#666666"),
              size: .85em,
            ),
          )
        } else {
          // We display sub-enumerations as usual.
          let n = n.slice(1)
          let number_format = ("(a)", "i.", "(A)", "(I)").at(n.len() - 1, default: "(a)")
          numbering(number_format, n.at(-1))
        }
      },
      spacing: 1em,
      full: true,
    )
    set terms(indent: 1.5em)
    show terms: it => aligned_terms(..it.children, separator: it.separator, tight: it.tight, spacing: it.spacing)
    set list(
      indent: 1.5em,
      spacing: 1em,
    )

    show link: mono
    content
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
    definition: definition,
    example: example,
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
    enum(..questions.map(q => enum.item(q.statement))),
  )
}

/// Display solutions for exercises.
///
/// - questions ( ((statement: content, solution: content | none, citation: content | none),) ): A list of questions (possibly with solutions).
#let solutions(questions, module_number: 0) = {
  [== Solutions for Module #module_number]
  columns(
    2,
    enum(
      ..questions.map(q => enum.item(
        text(
          fill: blue,
          q.at("solution", default: []),
        ),
      )),
    ),
  )
}

/// Display a term list with each items contents aligned.
/// Use
/// ```
/// #show terms: it => aligned_terms(..it.children, separator: it.separator, tight: it.tight, spacing: it.spacing)
/// ```
/// to activate.
#let aligned_terms(..items, separator: [], spacing: auto, tight: true) = context {
  pad(
    left: 1.5em,
    grid(
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
    ),
  )
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
