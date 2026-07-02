#import "../libs/lib.typ": *
#show: e.prepare(question)

#{
  question(label: <ex:existence_uniqueness>, {
    learning_objectives(
      [Rewrite a differential equation as a level set of some function $F$.],
      [Recognize that there is a class of theorems broadly labeled as "existence and uniqueness
        theorems" relevant to the study of differential equations.],
      [Apply the Existence and Uniqueness Theorem for first-order linear ODEs.],
    )
    notes[
      The purpose of this question is to give students some of the vocabulary commonly used when
      discussing differential equations. We have not needed to talk about differential equations in
      terms of level sets of functions, nor have we needed a fully-powered existence and uniqueness
      theorem.

      They have not had much practice in this course applying precise theorems. Based on how much
      weight you put on this learning goal, spend more or less time on this question.

      - @ex:rephrase_as_level_sets[] will be very easy for them.

      - In your wrap-up, contextualize this problem:
        + If differential equations can be rephrased as level set problems, then tools from
          multivariable calculus can be brought into the study of differential equations.
        + General theorems about differential equations are _hard_. Over the last few hundred years,
          mathematicians have developed many theorems that apply to specific types of differential
          equations (usually those that arise in physics) about whether they have solutions and
          whether those solutions are unique. Since most differential equations don't have
          closed-form solutions, these theorems inform whether numerical methods have a hope of
          success.

          To a mathematician, existence and uniqueness is a "first question" to ask about a
          differential equation.
    ]
    slide(force_scale: 0.89em)[

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
        ],
      )




      + #label_question_part(<ex:rephrase_as_level_sets>) The theorem expresses differential
        equations in the form $F(t, x, x', x'', dots) = 0$ (i.e. as a level set of some function
        $F$).

        Rewrite the following differential equations in the form $F(t, x, x', x'', dots) = 0$:
        + $x'' = -k x$
          #solution[
            $F(t, x, x'') = x'' + k x = 0$.
          ]
        + $x'' = -x dot x' + x^2$
          #solution[
            $F(t, x, x', x'') = x'' + x dot x' - x^2 = 0$.
          ]
        + $x''' = (x')^2 - cos x$
          #solution[
            $F(t, x, x', x''') = x''' - (x')^2 + cos x = 0$.
          ]

      + Which of the following does the theorem say _must_ have a unique solution on an interval
        containing $0$?
        + $y' = -frac(3, 2) y^(1/3)$ with $y(0) = 0$
          #solution[
            Since the differential equation cannot be rewritten as
            $F(t, y, y') = y'(t) + p(t) y(t) + g(t)=0$, the theorem does not apply.

            However, this equation is separable. Solving it we find that there are infinitely many
            solutions on any open interval containing $0$.
          ]
        + $x'(t) = floor(t) x(t)$ with $x(0) = 0$
          #solution[
            We can rewrite the differential equation as
            $F(t, x, x') = x' - floor(t) x = x' + p(t)x + g(t) = 0$. However, in this case
            $p(t) = -floor(t)$ is not continuous on any open interval containing $0$, so the theorem
            does not apply. However, by guessing and checking, we see that $x(t)=0$ is a solution.
            Arguing by other means, this solution is unique.
          ]
        + $x'(t) = floor(t - frac(1, 2)) x(t) + t^2$ with $x(0) = 0$
          #solution[
            We can rewrite the differential equation as
            $F(t, x, x') = x' - floor(t - 1/2) x - t^2 = x' + p(t)x + g(t) = 0$. Here,
            $p(t) = -floor(t - 1/2)$ and $g(t) = -t^2$, both of which are continuous on the interval
            $(-1/2,1/2)$, and so the theorem applies: there is a unique solution satisfying $x(0)=0$
            on the interval $(-1/2,1/2)$.
          ]

        Note: $floor(x)$ is the _floor_ of $x$, i.e., the largest integer less than or equal to $x$.


    ]
  })
}
