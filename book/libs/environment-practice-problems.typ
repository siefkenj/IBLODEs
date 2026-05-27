#import "./common.typ": *
#import "./settings.typ": *
#import "./environments.typ": *
#import "./environment-module.typ": *
#import "./utils.typ": *

#let PRACTICE_PROBLEM_ENUM_SET_ARGS = (
  numbering: (..n) => {
    let depth = n.pos().len()
    // We manually create the markers for the highest level of enum, so we skip the "1." marker.
    let marker = ("(a)", "i.", "A.", "I.").at(depth - 1, default: "(1)")
    numbering(marker, n.at(-1))
  },
  indent: 5pt,
  full: true,
)

#let _GLOBAL_PRACTICE_PROBLEMS_LIST = state("global_practice_problems_list", ())

/// Show a Practice Problem.
///
/// Note: The solution for the practice problem will not be shown.
#let practice_problem = e.element.declare(
  "practice_problem",
  prefix: PREFIX,
  doc: "Show a practice problem. Will be shown/hidden depending on the global settings.",
  display: it => {
    let problem_counter = e.counter(it)
    show: block.with(inset: (left: 1.5em))
    {
      show: place.with(top)
      show: move.with(dx: -1.5em)
      problem_counter.display("1.")
      if it.citation != none {
        show: footnote.with(numbering: "*")
        text(fill: blue, [#it.citation])
      }
    }
    it.statement
  },
  fields: (
    e.field(
      "statement",
      content,
      required: true,
      named: true,
      doc: "The body of the practice problem.",
    ),
    e.field(
      "solution",
      e.types.option(content),
      doc: "The body of the solution to the practice problem.",
    ),
    e.field(
      "citation",
      e.types.option(content),
      doc: "The source that this problem is from (e.g., textbook, etc.).",
    ),
  ),
)

#let practice_problems = e.element.declare(
  "practice_problems",
  prefix: PREFIX,
  doc: "A collection of practice problems.",
  display: it => {
    [== Practice Problems]
    set enum(..PRACTICE_PROBLEM_ENUM_SET_ARGS)
    counter(footnote).update(0)
    let problem_counter = e.counter(practice_problem)
    problem_counter.update(0)

    show: columns

    context {
      // Since the module has not "ended", the module we are in should be "after" the current location.
      let after = e.query(module, after: here())
      let parent_module = after.at(0, default: none)
      let location = here()
      if parent_module != none {
        let ref_label = e.fields(parent_module).ref_label
        _GLOBAL_PRACTICE_PROBLEMS_LIST.update(s => {
          s.push((
            parent: ref_label,
            solutions: it.problems.map(p => p.at("solution", default: none)),
            location: location,
          ))
          s
        })
      }
    }
    for problem in it.problems {
      practice_problem(..problem)
    }
  },
  fields: (
    e.field(
      "problems",
      e.types.array(dictionary),
      required: true,
      doc: "The practice problems to include in this collection.",
    ),
  ),
)

/// Render the solutions for practice problems. This assumes that problems
/// have already been rendered (with their solutions suppressed). This function merely renders them.
#let practice_problem_solutions = e.element.declare(
  "practice_problem_solutions",
  prefix: PREFIX,
  doc: "Display the solutions to a collection of practice problems created with the `practice_problems` element.",
  display: it => {
    counter(footnote).update(0)
    set enum(..PRACTICE_PROBLEM_ENUM_SET_ARGS)

    show: columns
    context {
      let all_solns = _GLOBAL_PRACTICE_PROBLEMS_LIST.final()
      for (parent, solutions, location) in all_solns {
        [== Solutions for #parent]

        set text(fill: blue)

        for (i, soln) in solutions.enumerate() {
          if soln != none {
            show: block.with(inset: (left: 1.5em))
            {
              show: place.with(top)
              show: move.with(dx: -1.5em)
              show: link.with(location)
              numbering("1.", i + 1)
            }

            soln
          }
        }
      }
    }
  },
  fields: (
    // e.field(
    //   "problems",
    //   e.types.array(dictionary),
    //   required: true,
    //   doc: "The practice problems whose solutions should be displayed.",
    // ),
  ),
)
