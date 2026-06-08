#import "../libs/lib.typ": *
#show: e.prepare(question)

#{
  question({
    learning_objectives(
      ([Create a differential equations-based model from premises.],),
    )
    notes[
      We are building up an affine model that will be explored over the next several exercises.
      Students have created equations from premises before for the Lotka-Volterra model (with lots
      of scaffolding). They have also matched premises to equations in the Tree model. This is more
      practice and shouldn't take too long.

      - It is worth explaining what "ignoring all else" means. E.g., if you "ignore all else", you
        imagine that you are covering up all other terms in the differential equation. So, for
        example, if a tree's height, $H$, increases with sunlight but decreases with temperature,
        focusing on the sunlight and ignoring all else, $H'$ would be positive. And, ignoring all
        but temperature, $H'$ would be negative.
    ]
    slide[


      Consider the following model of Social Media Usage where
      $
        P(t) & = "millions of social media posts at year " t \
        U(t) & = "millions of social media users at year " t
      $

      // The units here are actually correct, but you have to think about it...
      - (P$1_P$) Ignoring all else, each year posts decay proportionally to the current number of
        posts with proportionality constant 1.
      - (P$2_P$) Ignoring all else (independent of decay), posts grow by a constant amount of 2
        million posts every year.
      - (P$1_U$) Ignoring all else, social media users increase/decrease in proportion to the number
        of posts.
      - (P$2_U$) Ignoring all else, social media users increase/decrease in proportion to the number
        of users.
      - (P$3_U$) Ignoring all else, 1 million people stop using the platform every year.


      A school intervention is described by the parameter $a in [-1/2, 1]$:
      - After the intervention, the proportionality constant for (P$1_U$) is $1 - a$.
      - After the intervention, the proportionality constant for (P$2_U$) is $a$.

      + Model this situation using a system of differential equations. Explain which parts of your
        model correspond to which premise(s).

        #solution[
          $
            P' &= underbrace(-P, "P1"_(P)) & &underbrace(+2, "P2"_(P)) \
            U' &= underbrace((1 - a) P, "P1"_(U)) &+ underbrace(a U, "P2"_(U)) wide &underbrace(-1, "P3"_(U))
          $
        ]

    ]
  })

  book_only(pagebreak())
  question(label: <ex:sm_start_matrix_journey>, {
    learning_objectives(
      [Find equilibrium points of a system of differential equations that has a parameter.],
      [Use phase portraits to determine the stability of an equilibrium solution for different
        values of a parameter.],
    )
    notes[
      We're visually exploring stability before we develop the algebraic tools to tackle it with
      eigen methods.

      - Many students will find $U=2-1/a$ and declare from that "there are no equilibrium solutions
        when $a=0$". This is incorrect reasoning. When their formula breaks down, they need to go
        back to the original equation to check if there is an equilibrium solution.

      - In @ex:sm_from_phase_portrait[], we don't have the tools to analytically determine
        stability. We're just looking for answers based on the phase portrait.

        It may be worth noting that the equilibrium disappears during the transition from stable to
        unstable. It never actually "transitions" from one state to the other.

    ]
    slide[

      The *SM* model of Social Media Usage is
      $
        P' & = -P + 2 \
        U' & = (1 - a) P + a U - 1
      $
      where
      $
        P(t) & = "millions of social media posts at year " t \
        U(t) & = "millions of social media users at year " t \
           a & in inline([-1/2, 1])
      $

      + What are the equilibrium solution(s)?
        #solution[
          $P=2$ and $U=2-1/a$, so long as $a != 0$. If $a=0$, there are no equilibrium solutions.
        ]
      + Make a phase portrait for the system.

        #link("https://www.desmos.com/calculator/h3wtwjghv0")

        #solution[
          #{
            h(1fr)
            let a = -1 / 2
            vector_field(
              ((x, y) => (-x + 2, (1 - a) * x + a * y - 1)),
              xlim: (-4, 4),
              ylim: (-4, 4),
              spacing: (.7, .7),
              scale_segments: 18,
              width: 4.8cm,
              height: 4.8cm,
              xaxis: (position: 0, tip: tiptoe.stealth, ticks: none, subticks: none),
              yaxis: (position: 0, tip: tiptoe.stealth, ticks: none, subticks: none),
              title: $a=-1/2$,
            )
            h(1fr)
            let a = 1 / 2
            vector_field(
              ((x, y) => (-x + 2, (1 - a) * x + a * y - 1)),
              xlim: (-4, 4),
              ylim: (-4, 4),
              spacing: (.7, .7),
              scale_segments: 18,
              width: 4.8cm,
              height: 4.8cm,
              xaxis: (position: 0, tip: tiptoe.stealth, ticks: none, subticks: none),
              yaxis: (position: 0, tip: tiptoe.stealth, ticks: none, subticks: none),
              title: $a=1/2$,
            )
            h(1fr)
          }
        ]

      + #label_question_part(<ex:sm_from_phase_portrait>) Use phase portraits to conjecture: how
        does the stability of the equilibrium solutions depend on $a$?

        #solution[
          The equilibrium solution seems to be stable and attracting when $a<0$ and unstable when
          $a>0$.
        ]

    ]
  })

  book_only(pagebreak())
  question({
    learning_objectives(
      (
        [Create a new differential equation from an affine differential equation by considering the
          displacement from equilibrium.],
      ),
      // [Analyze the stability of the equilibrium solution of an affine system by finding the
      //   stability of the equilibrium solution of the associated matrix system.],
    )
    notes[
      This question goes along with @ex:sm_model_continuation, and won't have a "punchline" until
      @ex:sm_model_continuation.

      It is time to relate affine systems to matrix systems. *This is confusing for students,* and
      when combined with @ex:sm_model_continuation takes a lot of time.

      We start by establishing that the *SM* model cannot be a matrix system. Then we study the
      related system arising by looking at displacements from equilibrium; lo and behold, this is a
      matrix system.

      - For @ex:sm_can_be_matrix_system[], students will have many good proposals, some based on
        abstract linear algebra. The "brute force" method (multiplying by a matrix of variables, as
        done in the solutions) will satisfy everyone in the class.

      - In @ex:sm_rewrite_as_matrix0[], if students are confused, ask them to sketch the vectors for
        $arrow(r)(t)$ and $arrow(E)$. They are likely not thinking about them as vectors from the
        origin.

      - In @ex:sm_rewrite_as_matrix2[], students may differentiate and have $P'$ and $U'$ in their
        answer and then forget that they can use the original differential equation to substitute in
        for an expression in terms of $P$ and $U$.

      - In @ex:sm_rewrite_as_matrix3[], the constant terms "magically" disappear. Make sure students
        recognize this.

        They are likely to solve this part by substitution. After the substitution approach is
        discussed, it is worth showing the "linear algebra" approach: The differential equation can
        be written as $arrow(r)'=M arrow(r) + arrow(B)$. The equilibrium solves
        $M arrow(E) + arrow(b) = arrow(0)$. Finally, $arrow(s) = arrow(r) - arrow(E)$, and so
        $
          arrow(s)thin' & = arrow(r)thin' - arrow(E)thin' \
                        & = arrow(r)thin' - arrow(0) \
                        & = M arrow(r) + arrow(b) \
                        & = M (arrow(s) + arrow(E)) + arrow(b) \
                        & = M arrow(s) + (M arrow(E) + arrow(b)) \
                        & = M arrow(s).
        $


    ]
    slide(force_scale: 0.9em)[


      Recall the *SM* model of Social Media Usage with equations
      $
        P' & = -P + 2 \
        U' & = (1 - a) P + a U - 1
      $

      + #label_question_part(<ex:sm_can_be_matrix_system>) Can you rewrite the system in matrix
        form? I.e., in the form $arrow(r)'(t) = M arrow(r)(t)$ for some matrix $M$ where
        $arrow(r)(t) = mat(P(t); U(t))$.
        #solution[
          No. Multiplying out by a general matrix, we see that if
          $mat(P; U)' = mat(p, q; r, s)mat(P; U)$, then the differential equation must take the form
          $
            P' & = p P + q U \
            U' & = r P + s U
          $
          which ours does not.
        ]
      + #label_question_part(<ex:sm_rewrite_as_matrix>) Define $arrow(s)(t) = mat(S_P (t); S_U (t))$
        to be the displacement from equilibrium in the *SM* model at time $t$ (provided an
        equilibrium exists).
        + #label_question_part(<ex:sm_rewrite_as_matrix0>) The accompanying graph shows a solution
          to the *SM* model in phase space with $arrow(r)(t)$ and the equilibrium $arrow(E)$. Draw
          $arrow(s)(t)$ on the graph.

          #{
            set align(center)
            let make_plot(size) = {
              let a = 1 / 1
              let E = (2, 2 - 1 / a)
              let F(x, y) = (-x + 2, (1 - a) * x + a * y - 1)
              let res = solve_2d_ivp(F, (-1, 1.5), 200, Delta: .05, method: "rk4")
              let (xs, ys) = (res.map(((x, y)) => x), res.map(((x, y)) => y))
              let t = 25
              lq.diagram(
                xlim: (-1, 5),
                ylim: (-1, 5),
                width: size,
                height: size,
                yaxis: (position: 0, tip: tiptoe.stealth, ticks: none, subticks: none),
                xaxis: (position: 0, tip: tiptoe.stealth, ticks: none, subticks: none),
                lq.plot(
                  xs,
                  ys,
                  mark: none,
                  stroke: 1.5pt,
                ),
                lq.plot((E.at(0),), (E.at(1),), mark: "o", stroke: 2pt, color: orange.darken(20%)),
                lq.plot(
                  (xs.at(t),),
                  (ys.at(t),),
                  mark: "o",
                  stroke: 2pt,
                  color: purple.darken(40%),
                ),
                lq.place(E.at(0), E.at(1), align: left, text(fill: orange.darken(20%), pad(
                  .3em,
                )[$arrow(E)$])),
                lq.place(xs.at(t), ys.at(t), align: left, text(fill: purple.darken(40%), pad(
                  .5em,
                )[$arrow(r)(t)$])),
                lq.place(4.5, -.2, align: top, $P$),
                lq.place(-0.2, 4.5, align: right, $U$),
              )
            }
            slides_only(
              make_plot(4cm),
              otherwise: make_plot(5cm),
            )
          }
        + #label_question_part(<ex:sm_rewrite_as_matrix1>) Write $arrow(s)$ in terms of $P$ and $U$.
          #solution[The equilibrium solution when $a != 0$ is $mat(2; 2-1/a)$ and so
            $arrow(s)(t) = mat(P(t) - 2; U(t) - (2-1/a))$]
        + #label_question_part(<ex:sm_rewrite_as_matrix2>) Find $arrow(s)thin'$ in terms of $P$ and
          $U$.
          #solution[
            $arrow(s)thin' = mat(P - 2; U - (2-1/a))' = mat(P'; U') = mat(-P + 2; (1 - a) P + a U - 1)$
          ]
        + #label_question_part(<ex:sm_rewrite_as_matrix3>) Find $arrow(s)thin'$ in terms of $S_P$
          and $S_U$.
          #solution[
            Since $arrow(s) = mat(S_P; S_U)= mat(P - 2; U - (2-1/a))$, we can solve the first
            coordinate to find $P=S_P+2$ and $U=S_U+(2-1/a)$. Substituting this into the right hand
            side of our solution to @ex:sm_rewrite_as_matrix2[], we get
            $
              arrow(s)thin ' = mat(-S_P; (1 - a) S_P + a S_U).
            $
          ]

    ]
  })

  book_only(pagebreak())
  question(label: <ex:sm_model_continuation>, {
    learning_objectives(
      [Create a matrix differential equation from an affine differential equation.],
      [Analyze the stability of the equilibrium solution of an affine system by finding the
        stability of the equilibrium solution of the associated matrix system.],
    )
    notes[
      The ground work for this question was laid in @ex:sm_start_matrix_journey. It's time to put
      everything together and (a) find a matrix system related to the *SM* model and (b) analyze the
      stability of the equilibrium solution for that matrix system.
    ]
    slide(force_two_column: true)[


      Recall the *SM* model of Social Media Usage with equations
      $
        P' & = -P + 2 \
        U' & = (1 - a) P + a U - 1
      $
      and assume $arrow(r)(t)$ is a solution to this system.
      // where
      // $
      //   P(t) & = "millions of social media posts at year " t \
      //   U(t) & = "millions of social media users at year " t \
      //      a & in inline([-1/2, 1])
      // $

      By defining $arrow(s)(t)=mat(S_P (t); S_U (t))$ as the displacement of
      $arrow(r)(t) = mat(P(t); U(t))$ from equilibrium, we arrived at the equations
      #let eq = $
        arrow(s)thin' = mat(-P + 2; (1 - a) P + a U - 1) " and " arrow(s)thin' = mat(-S_P; (1 - a) S_P + a S_U).
      $

      #slides_only(
        {
          set text(size: 0.83em)
          eq
        },
        otherwise: eq,
      )

      + #label_question_part(<ex:sm_rewrite_as_matrix4>) Can one of the differential equations for
        $arrow(s)$ be written in matrix form? Which one?
        #solution[
          Yes. We can write $arrow(s)thin' = mat(-1, 0; 1-a, a) mat(S_P; S_U)$.
        ]
      + #label_question_part(<ex:sm_rewrite_as_matrix5>) Analytically classify the equilibrium
        solution for the (matrix) differential equation for $arrow(s)$ when $a = -1/2$, $a = 1/2$,
        and $a = 1$. (You may use a calculator for computing eigenvalues/eigenvectors.)

        #solution[
          $a=-1/2$: negative eigen values and so stable and attracting; $a=1/2$ and $a=1$: one
          positive and one negative eigenvalue and so unstable (not repelling).
        ]

      + #label_question_part(<ex:sm_rewrite_as_matrix6>) Do your answers to
        @ex:sm_rewrite_as_matrix5[] tell you about the stability of the equilibrium solution for the
        original *SM* model? Why or why not?

        #solution[
          Yes. Every solution $arrow(s)(t)$ is a translation of $arrow(r)(t)$. If $arrow(r)(t)$
          heads towards/away from the equilibrium, then $arrow(s)(t)$ moves towards/away from the
          origin (its equilibrium).
        ]

    ]
  })

  book_only(pagebreak())
  question({
    learning_objectives(
      [???],
    )
    notes[???]
    slide[
      The *SM* model of Social Media Usage is
      $
        P' & = -P + 2 \
        U' & = (1 - a) P + a U - 1
      $
      where
      $
        P(t) & = "millions of social media posts at year " t \
        U(t) & = "millions of social media users at year " t \
           a & in inline([-1/2, 1])
      $


      Some politicians have been looking at the model. They made the following posts on social
      media:


      #block[
        #set enum(numbering: "1.")

        + _The model shows the number of posts will always be increasing. SAD!_
        + _I see the number of social media users always increases. That's not what we want!_
        + _It looks like social media is just a fad. Although users initially increase, they
          eventually settle down._
        + _I have a dream! That one day there will be social media posts, but eventually there will
          be no social media users!_
      ]

      + For each social media post, make an educated guess about what initial conditions and what
        value(s) of $a$ the politician was considering.
        #solution[???]
      + The school board wants to limit the number of social media users to fewer than 10 million.
        Make a recommendation about what value of $a$ they should target.

        #solution[???]

    ]
  })
}
