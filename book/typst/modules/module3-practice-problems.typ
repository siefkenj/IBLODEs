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
      An ecologist is measuring the population
      of bears in northern Ontario
      and the population of 
      feas that are inffecting the bears.
      The ecologists make the following 
      assumptions about these bears
      - The bears reproduction is 
        uneffected by the flea population, 
        and is only affected 
      - The bears die at a rate
        relative to the square of
        the current bear population.
      - The flea's reproduction and 
        death rates are dependent
        only on the current flea and bear 
        populations.
      + Write down a system of differential 
        equations that encapsulates 
        the above model.
      + Write down one or two sentances 
        commenting on the quality of this model.
    ],
  ),
  (
    statement: [
      /* Check if these functions solve
      these differential equation. */
      For the following systems of 
      differential equations check 
      if the given functions solve the 
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
          (dif P_1)/(dif t) = P_2\
          (dif P_2)/(dif t) = -(P_1^2 - 1)P_2 - P_1 
        $
        with 
        $
          P_1(t) = y(x-1))\
          P_2(t) = x - y \
        $
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
      Consider the following system of differential
      equations:
      $
        x' = - x + y - 1 \
        y' = - y - x + 3
      $
      Consider this system with the inital 
      condition $(x_0, y_0) = (4,4)$
      + Use Euler's method with $delta = 0.01$
        and going up to at least $t = 500$
      + Polt your approximation to 
      + It should look as though your 
        solution approximation is settling around 
        a specific pair of value of $x$ and $y$.
        What is this value?
    ],
  ),
  (
    statement: [
      /* Build this differential equation 
      model. Use Euler's method to find 
      the solution. Give the component graphs */
      A desease, which will call Finnish
      Undergarment Necrosis (FUN), is  spreading through a population
      of $100,000$ people in Finland.
      Let $S(t)$ be the population
      of healthy people susceptible to the 
      desease. Let $I(t)$ be the population of 
      infected people. Let $R(t)$ be the population:
      - Once a person has contracted FUN and 
        recovered, they are not longer susceptible
        to it.
      - The entire population of $100,000$ begins 
        susceptible to FUN with the exception 
        of the 50 people originally to have 
        the desease.
      - An infected person tends to infect 
        4 susceptible people a week. 
      - It takes a person appoximately 2 weeks
        to recover from FUN.
      - Nobody dies of FUN, or anything else
        during the span of the FUN pandemic.
      + Let $t$ be measured *in days*. 
        Come up with a system of 3 differential 
        equations, in a initial value problem \ 
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
          ]
        )
        that corresponds with the assumptions above
      + Now change the assumptions so that:
        - People can only contract FUN after the age 
          of 16.
        - The entire original population is above 
          the age of 16. 
        - There is a population of young people out of 
          which people become age 16 at rate $b$.
        - Members of the total population die at rate 
          $d$.
        - Susceptible, infected, and recovered people
          die at the same rate.
        based on these added/edited assumptions 
        remake the differential equations that you 
        made in part (a). 
      + *Ignore* the differential equations that you 
        made in part (b) and consider the differential
        equations that you made *in part (a)*. 
        Use Euler's method with an approriate $Delta$
        step size, and enouph 
        data in $t$ to get an idea of the populations 
        behavior, to estimate the maximum amount of 
        people that are infected with FUN at one 
        time. 
      + Make 3 component graphs: one for each of 
        $S(t)$, $I(t)$, and $R(t)$. Use these 
        graphs to predict whether of not 
        the entire population will be infected with 
        FUN/
    ],
  ),
  (
    statement: [
      /* Here is a differential equation model.
      Use eulers to determine 
      which of these graphs are for which of the
      plot. */
      #let F(x, y) = (0.02*x + 0.005*y, -0.003*x+0.04*y)

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

      A tech startup manufacturing industrial
      computers
      has been granted $\$20,000$, and 
      are trying to understand the cost 
      and revenue of producing $q$ computers 
      in the following year. They can only
      produce a maximum of $100$ computers.
      They find that
      $
        text("MC")(q) = 0.02C(q) + 0.005R(q)\
        text("MR")(q) = -0.003C(q) + 0.04R(q).
      $
      Here $C(q)$ is the cost of producing 
      $q$, $R(q)$ is the revenue gotten 
      from of producing $q$ computers, 
      $text("MC")(q)$ is the cost of 
      producing the $(q+1)$th computer, 
      and $text("MR")(q)$ is the revenue from $(q+1)$th
      computer. 
      + $text("MC")$ and $text("MR")$ are essentially the 
        derivatives of $C$ and $R$ with repect to 
        $q$. Why is this the case?
      + Which of the following graphs similar to 
        the graph of $R(q)$
        - #align(
            center,
            lq.diagram(
              width: 4cm,
              height: 3cm,
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
              height: 3cm,
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
        - #let f(x) = calc.sin(x) + x
          #align(
            center,
            lq.diagram(
              width: 4cm,
              height: 3cm,
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
        - #let g(x) = calc.sqrt(x)
          #align(
            center,
            lq.diagram(
              width: 4cm,
              height: 3cm,
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
    ],
  ),
  (
    statement: [
      /* Here are 3 differential equations, 
      for each of these differential equations 
      draw a vector plase plot and then some solutions.*/
      For each of the following autonomous
      differential 
      equations make in phase space a make 
      a plot so that at every point 

      Make at least one of them by hand with a pen/
      pensil 
      and paper. 
      + #block(
          inset: (bottom: .5em),
          [
            $cases(y' + ln(5) = t, y(5) = 4)$ and\
            $y = t^2 - ln(5)t - 25$
          ],
        )
      +
      + 
      + 
    ],
  ),
  (
    statement: [
      /* Do Euler's method on this differenetial 
      equation that has a stable solution. Now 
      reduce the error. What happens? Maybe 
      I give them a model here and try to get
      some implication about the actual solution
      of the model from the simulation.*/

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
      on of the component graphs to be nonciclical
      but in the bonus I give the further
      information that the differential equation 
      can be written in terms of t and is 
      non-dependent on y at all. I believe this is
      enouph to imply on the phase space that you 
      will get spirals that exsume out of the 
      center or spiral into the middle. 
      Maybe ask after how this is different 
      from the error and emphisies how it 
      is very different.*/
    ],
  ),
  (
    statement: [
      /* Here is a phase space of 
      of a solution to a differential equation
      with a solution on it. Which variable is 
      which. Where is each variable maximized
      and minimized. Based on this rouphly
      sketch the component graphs.*/
    ],
  ),
  (
    statement: [
      True or False: 
      + A phase plot of 
        $n$ differential equations
        that have the form
        $
          x_i = underline("          ")
        $
        for $1 <= i <= n$, 
        needs $n$ dimensions to graph.
    ],
  ),
  (
    statement: [
      Bonus questions:
      + In question 3 you got values 
        for $x$ and $y$ that your 
        solution approximation was approuching 
        as time when on. Call this point 
        $(x_0, y_0)$ Input $(x_0,y_0)$ 
        into the original 
        differential equation of question 3.
        You should get a very interesting 
        value for $x'$ and $y'$ at $(x_0,y_0)$. 
        What does 
        this value of $x'$ and $y'$ at $(x_0,y_0)$
        mean about the point $(x_0,y_0)$.

    ],
  )
)