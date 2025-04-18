#import "../libs/_workbook.typ": aligned_terms

#let MM = $upright(bold("M"))$
#let SS = $upright(bold("S"))$
#let infty = math.infinity

#let setup(env) = {
  let (sans, serif, slide, restrict, question, definition, solution: _solution, show_def) = env
  let slides_only = restrict.with(when: ("slides", "slides-solutions"))
  let book_only = restrict.with(when: ("book", "guide", "book-solutions"))
  let guide_only = restrict.with(when: "guide")
  let solution = content => restrict(
    when: ("guide", "book-solutions", "slides-solutions"),
    _solution(content),
  )


  question(
    slide[

    ],
  )

  book_only(pagebreak())
  question(
    slide[
    ],
  )
}