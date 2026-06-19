#import "../libs/lib.typ": *
#show: e.prepare(question)

#{
  lesson(title: [Boundary Value Problems], include "lesson-week-11.typ")
  question({
    learning_objectives(
      [Simulate a solution to a differential equation over a fixed time interval.],
      [Interpret, in phase space, the plots of solutions to a differential equation over a fixed
        time interval.],
      // XXX: reconsider someday, do we more directly approach this goal? Right now it is indirect where we
      // have students answer questions using phase space, but we never ask them to articulate what they're looking for.
      [Restate questions about a model into questions about the trajectories of solutions in phase
        space.],
    )
    notes[
      The aim of this question is to give a motivated example of a boundary value problem and how
      the tools we have can be used to study them. This is the first instance where _time_ is
      observable in phase space (by graphing a trajectory over a specific time range), and will take
      some getting used to.

      - In @ex:bell_ring_adjust_euler[], some will need a hint. You can ask the students to change
        the $Delta$ slider and ask what happens to the graphed solution. What is the maximum value
        of $t$ graphed with this solution? Then you can tell them to adjust things so the maximum
        $t$ value is $1$.

        Note: the default $N$ is $970$. To arrange for $N times Delta=1$, they should change this to
        a nice number.

      - In @ex:bell_ring_letting_go[], students will struggle translating the question into initial
        conditions. If they are stuck, have a short discussion about initial conditions: we need to
        specify $x(0)$ and $x'(0)$. Do we know $x(0)$? What about $x'(0)$?

      - In your wrap-up, introduce the term *boundary value problem* and explain that these are
        problems where we have initial conditions _and then_ additional conditions for some other
        time value, and they come up all the time in science and engineering.

        Additionally, in your wrap-up explain how when we invented phase space, we did so by
        omitting the time variable (more broadly, the independent variable). However, by plotting
        solutions for a fixed time interval, we can observe how solutions depend on time, even
        though we are plotting in phase space.

    ]
    slide[

      #slides_only([*Boundary Value Problems*])

      Recall the spring-mass system modeled by
      $
        x'' = -x.
      $

      // XXX: add a drawing?
      We would like to use the spring-mass system to ring a bell at regular intervals, so we put a
      hammer at the end of the spring. Whenever the displacement is maximal, the hammer strikes a
      bell producing a ring.

      + Convert the spring-mass system into a system of differential equations. Make a phase
        portrait for the system using the following Desmos link:

        #link("https://www.desmos.com/calculator/fvqxqp6eds")

        #solution[
          Introducing $y = x'$, the system is
          $
            x' & = y \
            y' & = -x
          $
          #{
            set align(center)
            vector_field(
              ((x, y) => (y, -x)),
              xlim: (-1.5, 1.5),
              ylim: (-1.5, 1.5),
              spacing: (.22, .22),
              scale_segments: 15,
              width: 5cm,
              height: 5cm,
              xaxis: (position: 0, tip: tiptoe.stealth, tick-distance: 1),
              yaxis: (position: 0, tip: tiptoe.stealth, tick-distance: 1),
            )
          }
        ]
      + #label_question_part(<ex:bell_ring_adjust_euler>) In the _Options Euler_ on Desmos, adjust
        $Delta$ and the number of steps so that simulated solutions are only shown for
        $t in [0, 1]$.

        Use simulations to answer the remaining questions.

        #solution[
          Choose $Delta$ and the number of steps, $N$, so that $N times Delta = 1$. For example,
          $N=1000$ steps, we set $Delta = 0.001$.
        ]
      + #label_question_part(<ex:bell_ring_letting_go>) You start by displacing the hammer by $1$m
        and letting go. Is it possible that the bell rings every 1 second?
        #solution[
          No. In this setup we have initial conditions $x(0) = 1$ and $x'(0) = y(0) = 0$ (because we
          just let go, there should be no initial velocity).

          To ring the bell, the hammer must be at a maximum displacement, so whenever the bell rings
          in this setup, $x(t)=1$. However, our simulation shows $x(1) != 1$.
        ]

      + #label_question_part(<ex:bell_ring_initial_v>) You start by displacing the hammer by $1$m
        and impart an initial velocity by giving the hammer a push. Is it possible that the bell
        rings every 1 second?
        #solution[
          No. In this setup we have initial conditions $x(0) = 1$ and $x'(0) = y(0)= v_0 != 0$
          (because we give the hammer a push, there is some unknown initial velocity $v_0$).

          To ring every 1 second means that there is a time $t_0$ such that
          $x(t_0) =x(t_0 + 1) = x(t_0 + 2) = dots.c="maximum displacement"$. Since solutions in
          phase space trace out circles, this means that the trajectory of $x(t)$ for
          $t in [t_0,t_0 + 1]$ should be a full circle (for some initial time $t_0$). But, if $x(t)$
          for $t in [t_0,t_0 + 1]$ traces out a full circle, the so does $x(t)$ for $t in [0,1]$.

          Based on our simulation, $x(t)$ for $t in [0,1]$ traces only part of a circle (no matter
          the choice of $v_0$).
        ]

      + What is the smallest amount of time between consecutive rings (given a positive
        displacement)?
        #solution[
          Based on the argument in @ex:bell_ring_initial_v[], to ring the bell twice, we need to
          trace out a full circle in phase space. Experimentally, using $Delta =0.01$ and changing
          $N$, we see that $N approx 628$ results in an (approximate) full circle in phase space.

          Thus, the time is $approx 6.28$ seconds, which is suspiciously close to $2pi$ seconds.
        ]

    ]
  })

  book_only(pagebreak())
  question({
    learning_objectives(
      ([Analytically determine whether a boundary value problem has solutions.],),
    )
    notes[
      We primarily use numerical methods to answer boundary value problems, but when formulas are
      available, they can be used to give proofs about solutions. This question serves as practice
      reasoning analytically about solutions.

      - The form "$A cos(t + d)$" makes it easy to study the period of the solution. In previous
        iterations, $A cos(t) + B sin(t)$ was used, and this made it difficult for students to
        reason about minimum periods.

      - In @ex:bell_analytic2[], if students struggle you can prompt them to think about
        @ex:bell_analytic3[] first and then go back to @ex:bell_analytic2[].

      - The solution to the IVP in @ex:bell_analytic2[] is $A = sqrt(1+v_0^2)$ and $d=arctan(-v_0)$
        (with other solutions given by periodicity), with $v_0$ being the initial velocity.

    ]
    slide(force_scale: 0.95em)[

      #slides_only([*Boundary Value Problems*])

      Recall the spring-mass system modeled by
      $ x'' = -x $
      We would like to use the spring-mass system to ring a bell at regular intervals, so we put a
      hammer at the end of the spring. Whenever the displacement is maximal, the hammer strikes a
      bell producing a ring.

      The general solution to the spring-mass system can also be written as
      $
        x(t) = A cos(t + d)
      $
      where $A,d in RR$ are parameters.

      Analytically answer the remaining questions.
      + You start by displacing the hammer by $1$m and letting go. Is it possible that the bell
        rings every 1 second?
        #solution[
          Letting go means $x(0) = 1$ and $x'(0) = 0$ and so
          $
             x(0) & = A cos(d) = 1, \
            x'(0) & = -A sin(d) = 0.
          $
          Solving, we get $A = 1$ and $d = 0, plus.minus 2pi, ...$ or $A=-1$ and
          $d= plus.minus pi, plus.minus 3pi, ...$. Taking $A=1$ and $d=0$, the bell will ring when
          $x(t)=cos(t)=1$, which only occurs when $t$ is a multiple of $2pi$. Taking different
          values of $A$ and $d$ does not change this result.
        ]
      + #label_question_part(<ex:bell_analytic2>) You start by displacing the hammer by $1$m and
        giving the hammer a push. Is it possible that the bell rings every 1 second?
        #solution[
          We could approach this question by solving for possible values for $A$ and $d$.

          Alternatively, arguing as in @ex:bell_ring_initial_v, we know that ringing the bell every
          1 second means that the solution will be periodic with a period of 1 second (or a divisor
          of 1 second).

          Since the general solution $A cos(t + d)$ has a minimum period of $2pi$ seconds (so long
          as $A != 0$), the bell cannot ring every 1 second if $A != 0$. Since we know $x(0)=1$, we
          know $A$ cannot be $0$.
        ]
      + #label_question_part(<ex:bell_analytic3>) What is the smallest amount of time between
        consecutive rings (given a positive displacement)?
        #solution[
          For any $A != 0$ and any $d$, the function $x(t) = A cos(t + d)$ has period $2pi$ seconds.
          Thus, consecutive maxima are always separated by exactly $2pi$ seconds (so long as
          $A != 0$).
        ]

    ]
  })


  book_only(pagebreak())
  question({
    learning_objectives(
      (
        [Determine whether a boundary value problem has no solutions, exactly one solution, or
          infinitely many solutions both numerically and analytically.],
      ),
    )
    notes[
      This is the last question on boundary value problems. The punchline is:
      - Boundary value problems can have no solutions, exactly one solution, or infinitely many
        solutions.
      - Seemingly simple boundary conditions can lead to wildly different solution sets.

      This behaviour (having none/unique/infinitely many solutions) leaves us pining for an
      "existence and uniqueness theorem". Unfortunately, general theorems for boundary value
      problems are hard to come by (but we'll see an existence and uniqueness theorem in
      @ex:existence_uniqueness).

      - This question will be easy for students.

      - This question's main purpose is to set up context for future studies. If students go on to
        take classes on Partial Differential Equations, the method of separation of variables (e.g.,
        used to solve the heat or wave equations) will involve solving boundary value problems of
        this type.

    ]
    slide[

      #slides_only([*Boundary Value Problems*])


      A boundary value problem is a differential equation paired with two conditions at different
      values of $t$.

      Consider the following boundary value problems:

      #align(
        center,
        table(
          columns: 3,
          align: (center, center, center),
          stroke: none,
          column-gutter: 1em,
          table.header([(i)], [(ii)], [(iii)]),
          // Equations
          $x'' = -x$, $x'' = -x$, $x'' = -x$,
          // Boundary condition at left endpoint
          $x(0) = 1$, $x(0) = 1$, $x(0) = 1$,
          // Boundary condition at right endpoint
          $x(pi) = 1$, $x(pi) = -1$, $x(pi / 2) = 1$,
        ),
      )



      + Using phase portraits and simulations, determine how many solutions each boundary value
        problem has.
        #solution[
          In our phase portrait, we must have $x(0)=1$ but we are free to choose $x'(0)$ to attempt
          to satisfy the second boundary condition. By experimentation, we find:

          #set enum(numbering: "(i)", full: false)

          + $x(pi) = 1$: No solution (simulation always returns $-1$).
          + $x(pi) = -1$: Infinitely many solutions (every choice of $x'(0)$ works).
          + $x(pi/2) = 1$: Exactly one solution ($x'(0) = -1$).
        ]
      + Can you find analytic arguments to justify your conclusions?

        _Hint_: The general solution can be written as
        $
          x(t)=A cos t + B sin t " or " x(t) = A cos(t + d)
        $
        where $A,B,d$ are parameters. Use whichever form makes the question easier.
        #solution[
          Using $x(t) = A cos t + B sin t$. The condition $x(0) = 1$ gives $A = 1$, so
          $x(t) = cos t + B sin t$ for any $B$. Since the initial condition $x(0)=1$ is the same for
          all cases, we will argue all cases assuming $x(t)= cos t + B sin t$.

          #set enum(numbering: "(i)", full: false)

          + Observe that $x(pi) = cos(pi) + B sin(pi) = -1 + 0 = -1 != 1$ for all $B$. Therefore,
            there is *no solution.*
          + Observe that $x(pi) = cos(pi) + B sin(pi) = -1 + 0 = -1$ for every $B in RR$. Therefore,
            there are *infinitely many solutions.*
          + If $x(pi/2) = cos(pi/2) + B sin(pi/2) = 0 + B = 1$, then $B=1$. There is exactly *one
            solution*.
        ]

    ]
  })
}
