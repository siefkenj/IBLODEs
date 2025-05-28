#import "../libs/_workbook.typ": aligned_terms

#let MM = $upright(bold("M"))$
#let SS = $upright(bold("S"))$
#let infty = math.infinity

#let setup(env) = {
  let (sans, serif, slide, restrict, question, definition, theorem, solution: _solution, show_def) = env
  let slides_only = restrict.with(when: ("slides", "slides-solutions"))
  let book_only = restrict.with(when: ("book", "guide", "book-solutions"))
  let guide_only = restrict.with(when: "guide")
  let solution = content => restrict(
    when: ("guide", "book-solutions", "slides-solutions"),
    _solution(content),
  )


  question(
    slide(force_scale: 0.87em)[

      #slides_only([*Existence and Uniqueness*])



      Whether a solution to a differential equation exists or is unique is a #emph[hard] question
      with many partial answers.


      #book_only([Recall the Theorem:])

      #theorem(
          title: [Existence and Uniqueness II],
          [
          Let $F(t, x, x') = 0$ with $x(t_0) = x_0$ describe an initial value problem.

          - IF $F(t, x, x') = x'(t) + p(t) x(t) + g(t)$ for some functions $p$ and $g$
          - AND $p$ and $g$ are continuous on an open interval $I$ containing $t_0$
          - THEN the initial value problem has a unique solution on $I$.
          ]
        )
      

      

      + The theorem expresses differential equations in the form $F(t, x, x', x'', dots) = 0$
        (i.e. as a level set of some function $F$).

        Rewrite the following differential equations in the form $F(t, x, x', x'', dots) = 0$:
        + $x'' = -k x$  
        + $x'' = -x dot x' + x^2$  
        + $x''' = (x')^2 - cos x$

      + Which of the following does the theorem say _must_ have a unique solution on
        an interval containing $0$?
        + $y' = frac(3, 2) y^(1/3)$ with $y(0) = 0$
        + $x'(t) = floor(t) x(t)$ with $x(0) = 0$
        + $x'(t) = floor(t - frac(1, 2)) x(t) + t^2$ with $x(0) = 0$

        Note: $floor(x)$ is the _floor_ of $x$, i.e., the largest integer less than or equal to $x$.


    ],
  )

}