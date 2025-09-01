#import "../libs/_graphics.typ": slope_field
#import "../libs/_workbook.typ": label_module, simple_table
#import "../libs/_ode_solvers.typ": solve_1d_ivp
#import "../libs/_spreadsheet.typ": draw_spreadsheet
#import "@preview/lilaq:0.2.0" as lq
#import "@preview/tiptoe:0.3.0"


#let questions = (
  (
    statement: [
      /* Build a model with a
      system of differential equations */
      An ecologist is measuring the population of bears in northern Ontario and the population of
      fleas that are infecting the bears. The ecologists make the following assumptions about these
      bears
      - The bear's reproduction is unaffected by the flea population, and is only affected
      - The bears die at a rate relative to the square of the current bear population.
      - The flea's reproduction and death rates are dependent only on the current flea and bear
        populations.
      + Write down a system of differential equations that encapsulates the above model.
      + Write down one or two sentences commenting on the quality of this model.
    ],
  ),
  (
    statement: [
      /* Check if these functions solve
      these differential equation. */
      For the following systems of differential equations check if the given functions solve the
      given system:
      + /* Linear and basic */
        $
          x' = 4y - 2x\
          y' = 3x - 3y
        $
        with
        $
          x(t) = - e^(-6x)\
          y(t) = e^(-6x) \
        $
      + /* Linear solved by sin and cos */
        $
          d' = -5d - 2v \
          v' = 13d + 5v
        $
        with
        $
          d(t) = 2sin(t) \
          v(t) = 5sin(t) + cos(t) \
        $
      + /* Non-linear more complicated */
        $
          (dif P_1)/(dif t) = P_1 P_2\
          (dif P_2)/(dif t) = P_1
        $
        with
        $
          P_1(t) = tan^2(
            sqrt(2)/2 t)+1\
          P_2(t) =
          sqrt(2)tan(sqrt(2)/2 t)
        $
        Note: This example highlights how challenging non-linear differential equations are. By some
        qualitative measure this system of differential equation seem close to linear formulaically,
        while clearly being non-linear. Despite that, this system is still quite harder to check
        than the previous examples. This continues with more complicated non-linear differential
        equations. Most non-linear differential equation systems do not have, to human knowledge, a
        solution that we can write with with the functions we see regularly in a calculus class.
      + /* Non-linear but system is just
        two unrelated equations. */
        $
          r'(x) = x^2 + 1\
          s'(x) = s
        $
        with
        $
          r(x) = 1/3 x^3 + x + 3\
          s(x) = 8e^s \
        $
    ],
  ),
  (
    statement: [
      /* Use Eulers method on a differential
      equation to approximate the solution to a
      differential equation. Plot what the phase
      space. */
      Consider the following system of differential equations:
      $
        x' = - x + y - 1 \
        y' = - y - x + 3
      $
      Consider this system with the initial condition $(x_0, y_0) = (4,4)$
      + Use Euler's method with $delta = 0.01$ and going up to at least $t = 500$
      + Plot your approximation to
      + It should look as though your solution approximation is settling around a specific pair of
        value of $x$ and $y$. What is this value?
    ],
  ),
  (
    statement: [
      /* Build this differential equation
      model. Use Euler's method to find
      the solution. Give the component graphs */
      A disease, which will call Finnish Undergarment Necrosis (FUN), is spreading through a
      population of $100,000$ people in Finland. Let $S(t)$ be the population of healthy people
      susceptible to the disease. Let $I(t)$ be the population of infected people. Let $R(t)$ be the
      population:
      - Once a person has contracted FUN and recovered, they are not longer susceptible to it.
      - The entire population of $100,000$ begins susceptible to FUN with the exception of the 50
        people originally to have the disease.
      - An infected person tends to infect 4 susceptible people a week.
      - It takes a person approximately 2 weeks to recover from FUN.
      - Nobody dies of FUN, or anything else during the span of the FUN pandemic.
      + Let $t$ be measured *in days*. Come up with a system of 3 differential equations, in a
        initial value problem \
        #block(
          inset: (bottom: .5em),
          [
            $cases(
              (dif S(t))/(dif t) =
              underline("                 ")\
              (dif I(t))/(dif t) =
              underline("                 ")\
              (dif R(t))/(dif t) =
              underline("                 ")\
              (0,S(0),I(0),R(0)) =
              underline("                 ")
            )$\
          ],
        )
        that corresponds with the assumptions above
      + Now change the assumptions so that:
        - People can only contract FUN after the age of 16.
        - The entire original population is above the age of 16.
        - There is a population of young people out of which people become age 16 at rate $b$.
        - Members of the total population die at rate $d$.
        - Susceptible, infected, and recovered people die at the same rate.
        based on these added/edited assumptions remake the differential equations that you made in
        part (a).
      + *Ignore* the differential equations that you made in part (b) and consider the differential
        equations that you made *in part (a)*. Use Euler's method with an appropriate $Delta$ step
        size, and enough data in $t$ to get an idea of the populations behavior, to estimate the
        maximum amount of people that are infected with FUN at one time.
      + Make 3 component graphs: one for each of $S(t)$, $I(t)$, and $R(t)$. Use these graphs to
        predict whether of not the entire population will be infected with FUN.
    ],
  ),
  (
    statement: [
      /* Here is a differential equation model.
      Use eulers to determine
      which of these graphs are for which of the
      plot. */
      #let F(x, y) = (0.02 * x + 0.005 * y, -0.003 * x + 0.04 * y)

      #let g(x) = 1

      #let v_0 = (0, 20000)
      #let steps = 100
      #let _Delta = 1

      #let soln = (v_0,)
      #for i in range(steps) {
        let (x_0, y_0) = soln.at(-1)
        let (dx, dy) = F(x_0, y_0)
        let v = (x_0 + _Delta * dx, y_0 + _Delta * dy)
        soln.push(v)
      }
      #let times = range(0, steps + 1).map(i => i * _Delta)
      #let x = soln.map(v => v.at(0))
      #let y = soln.map(v => v.at(1))

      A tech startup manufacturing industrial computers has been granted $"$20,000"$, and are trying
      to understand the cost and revenue of producing $q$ computers in the following year. They can
      only produce a maximum of $100$ computers. They find that
      $
        text("MC")(q) = 0.02C(q) + 0.005R(q)\
        text("MR")(q) = -0.003C(q) + 0.04R(q).
      $
      Here $C(q)$ is the cost of producing $q$, $R(q)$ is the revenue gotten from of producing $q$
      computers, $text("MC")(q)$ is the cost of producing the $(q+1)$th computer, and
      $text("MR")(q)$ is the revenue from $(q+1)$th computer.
      + $text("MC")$ and $text("MR")$ are essentially the derivatives of $C$ and $R$ with respect to
        $q$. Why is this the case?
      + Which of the following graphs similar to the graph of $R(q)$
        - #align(
            center,
            lq.diagram(
              width: 4cm,
              height: 2.5cm,
              yaxis: (position: 0, tip: tiptoe.stealth),
              xaxis: (position: 0, tip: tiptoe.stealth),
              xlabel: $t$,
              legend: (position: bottom + right),
              lq.plot(
                times,
                x,
                mark: none,
              ),
            ),
          )
        - #align(
            center,
            lq.diagram(
              width: 4cm,
              height: 2.5cm,
              yaxis: (position: 0, tip: tiptoe.stealth),
              xaxis: (position: 0, tip: tiptoe.stealth),
              xlabel: $t$,
              legend: (position: bottom + right),
              lq.plot(
                times,
                y,
                mark: none,
              ),
            ),
          )
        - #let x = lq.linspace(0, 100)
          #let f(x) = 2000 * (20 * calc.sin(x / 10) + x)
          #lq.diagram(
            width: 4cm,
            height: 2.5cm,
            yaxis: (position: 0, tip: tiptoe.stealth),
            xaxis: (position: 0, tip: tiptoe.stealth),
            xlabel: $t$,
            legend: (position: bottom + right),
            lq.plot(
              x,
              x.map(x => f(x)),
              mark: none,
            ),
          )
        - #let f(x) = 10000 * (20 * calc.sin(x / 10) + x) + 20000
          #lq.diagram(
            width: 4cm,
            height: 2.5cm,
            yaxis: (position: 0, tip: tiptoe.stealth),
            xaxis: (position: 0, tip: tiptoe.stealth),
            xlabel: $t$,
            legend: (position: bottom + right),
            lq.plot(
              x,
              x.map(x => f(x)),
              mark: none,
            ),
          )
        - #let g(x) = 20 * calc.sqrt(1000000 * x)
          #align(
            center,
            lq.diagram(
              width: 4cm,
              height: 2.5cm,
              yaxis: (position: 0, tip: tiptoe.stealth),
              xaxis: (position: 0, tip: tiptoe.stealth),
              xlabel: $t$,
              legend: (position: bottom + right),
              lq.plot(
                x,
                x.map(x => g(x)),
                mark: none,
              ),
            ),
          )
        - #let g(x) = 100 * calc.sqrt(1000000 * x) + 20000
          #align(
            center,
            lq.diagram(
              width: 4cm,
              height: 2.5cm,
              yaxis: (position: 0, tip: tiptoe.stealth),
              xaxis: (position: 0, tip: tiptoe.stealth),
              xlabel: $t$,
              legend: (position: bottom + right),
              lq.plot(
                x,
                x.map(x => g(x)),
                mark: none,
              ),
            ),
          )
    ],
  ),
  (
    statement: [
      /* Here are 3 differential equations,
      for each of these differential equations
      draw a vector phase plot and then some solutions.*/
      For each of the following autonomous differential equations make in phase space with
      $-4 <= y <= 4$ and $-4 <= x <= 4$ a plot so that every integer coordinate $(n,m)
      in ZZ^2$ has vector coming out of it of the form $arrow(v) =(x'(n),y'(m))$. You can scale the
      vectors down to fit on the graph better, but do so uniformly, so that the relative sizes of
      the vectors are maintained. Make at least one of them by hand with a pen/pencil and paper.
      + #block(
          inset: (bottom: .5em),
          [
            $
              x' = -2x + 6y \
              y' = 1.4x - 4.2y
            $
          ],
        )
      + #block(
          inset: (bottom: .5em),
          [
            $
              x' = -7/4 x + 5/2 y \
              y' = -13/8 x + 7/4y
            $
          ],
        )
      + #block(
          inset: (bottom: .5em),
          [
            $
              x' = 3x + 6y \
              y' = 6x + 3y
            $
          ],
        )
      + #block(
          inset: (bottom: .5em),
          [
            $
              x' = -3/2 x + 1/2 y \
              y' = 1/2 x - 3/2 y
            $
          ],
        )
    ],
  ),
  (
    statement: [
      /* Do Euler's method on this differential
      equation that has a stable solution. Now
      reduce the error. What happens? Maybe
      I give them a model here and try to get
      some implication about the actual solution
      of the model from the simulation.*/
      + Use Euler's method on the system of equations
        $
          x' = - y \
          y' = x
        $
        In order to make a phase plot on the $x y$-axis of the solution to a with initial $(0,1)$.
        Use a step size $Delta$ of $1$. Make sure you plot enough data so that the behaviour of your
        approximate solution is clear.
      + What happens to this plot when you make $Delta = 0.1$? What about $Delta = 0.01$? Make a
        conclusion about the behavior of of true solution based on this observation.
      + Consider the system of differential equations
        $
          x' = -(y^2 - 1)x - y \
          y' = x
        $
        with the initial condition $(0,1)$. Again use Euler's method to, this time with step size
        $Delta = 0.1$ to make a simulation of the solution to this differential equation. Reduce to
        $Delta = 0.01$ Describe what is difference between the vector phase plots in this system of
        differential equations example and that in the previous example in part (a) that accounts
        for the different behavior of the simulated solutions.
    ],
  ),
  (
    statement: [
      /* Here are two component graphs of
      and an autonomous differential equation.
      Can you draw the phase space.
      This one might not might not need
      need cyclical. Or maybe I give have a
      second part where I change on of the
      component graphs to be different
      so that it is not possible. Then
      maybe I could have a really hard bonus
      question where the question becomes possible
      again with more information about the
      differential equation.
      The example I am thinking of is that
      I change, in the last part of the question,
      one of the component graphs to be noncircular
      but in the bonus I give the further
      information that the differential equation
      can be written in terms of t and is
      non-dependent on y at all. I believe this is
      enough to imply on the phase space that you
      will get spirals that extrude out of the
      center or spiral into the middle.
      Maybe ask after how this is different
      from the error and emphasizes how it
      is very different.*/
      + Consider the following two _component_ graphs of a solution to the unknown system of
        autonomous differential equations $A'(t)= dots$ and $B'(t)= dots$.

        #lq.diagram(
          width: 5cm,
          height: 3cm,
          yaxis: (position: 0, tip: tiptoe.stealth),
          xaxis: (position: 0, tip: tiptoe.stealth),
          title: [$t$ vs. $A(t)$],
          lq.plot(
            (0, 2, 4, 6, 8),
            (-1, 2, 2, 0, -1),
            mark: none,
          ),
        ),

        #lq.diagram(
          width: 5cm,
          height: 3cm,
          yaxis: (position: 0, tip: tiptoe.stealth),
          xaxis: (position: 0, tip: tiptoe.stealth),
          title: [$t$ vs. $B(t)$],
          lq.plot(
            (0, 2, 6, 8),
            (0, -1, 1, 0),
            mark: none,
          ),
        ),
        + What are the initial conditions of the graphed solution?
        + Is the solution periodic or not? Explain.

          _Hint: your explanation should use the fact that the system is autonomous._
        + Sketch the solution in _phase space_.

      + Consider the differential equation _component_ graphs for the differential equation system
        $C'(t) = dots$, $D'(t) = dots$.

        #lq.diagram(
          width: 5cm,
          height: 3cm,
          yaxis: (position: 0, tip: tiptoe.stealth),
          xaxis: (position: 0, tip: tiptoe.stealth),
          title: [$t$ vs. $C(t)$],
          lq.plot(
            (0, 2, 4, 6, 8),
            (0, -0.5, 0, 1, 0),
            mark: none,
          ),
        ), #lq.diagram(
          width: 5cm,
          height: 3cm,
          yaxis: (position: 0, tip: tiptoe.stealth),
          xaxis: (position: 0, tip: tiptoe.stealth),
          title: [$t$ vs. $D(t)$],
          lq.plot(
            (0, 2, 4, 4.5, 7.5, 8),
            (0, 0.5, 0, 1, 1, 0),
            mark: none,
          ),
        ),
        + It is not possible for this system of differential equation to be autonomous. Why is this
          the case?
        + Though you cannot make a phase plot with vectors, since this equation is not autonomous,
          make a sketch of the solution to this system of differential equations in _phase space_.
    ],
  ),
  (
    statement: [
      /* Here is a phase space of
      of a solution to a differential equation
      with a solution on it. Which variable is
      which. Where is each variable maximized
      and minimized. Based on this roughly
      sketch the component graphs.*/
      The following is a graph in _phase space_ of a solution to the unknown autonomous system of
      differential equations $W'(t)= dots$ and $V'(t)= dots$ with initial conditions $W(0)=10$ and
      $V(0)=20$.

      #{
        lq.diagram(
          width: 5cm,
          height: 3cm,
          xlim: (0, 30),
          ylim: (0, 30),
          yaxis: (position: 0, tip: tiptoe.stealth),
          xaxis: (position: 0, tip: tiptoe.stealth),
          title: [$W(t)$ vs. $V(t)$],
          lq.plot(
            (10, 14, 18, 22, 26, 26, 22, 18, 14, 10),
            (20, 23, 24, 22, 21, 19, 18, 15, 16, 20),
            mark: none,
          ),
        )
      }
      + Which variable corresponds to which axis on the phase plot. Justify your answer.
      + Is the solution to this system of differential equation cyclical. Justify your answer.
      + Are there a points on the phase plot where $W(t)$, or $V(t)$ are maximized? If so, at what
        point(s)? Either way, justify your answer. Answer this question again but with "minimized"
        instead of "maximized".
      + Are there points on the phase plot of this solution for which $W(t) = V(t)$? If so, at what
        point(s)? Either way, justify your answer.
      + Draw the possible component graphs for this solution.
    ],
  ),
  (
    statement: [
      True or False:
      + A phase plot of $n$ differential equations that have the form
        $
          x_i = underline("          ")
        $
        for $1 <= i <= n$, needs $n$ dimensions to graph.
    ],
  ),
  (
    statement: [
      Bonus questions:
      + In question 3 you got values for $x$ and $y$ that your solution approximation was
        approaching as time went on. Call this point $(x_0, y_0)$ Input $(x_0,y_0)$ into the
        original differential equation of question 3. You should get a very interesting value for
        $x'$ and $y'$ at $(x_0,y_0)$. What does this value of $x'$ and $y'$ at $(x_0,y_0)$ mean
        about the point $(x_0,y_0)$.

    ],
  ),
)
