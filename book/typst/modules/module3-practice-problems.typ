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

    ],
  ),
  (
    statement: [
      /* Here is a differential equation model.
      Use eulers to determine 
      which of these graphs are for which of the
      plot. */
    ],
  ),
  (
    statement: [
      /* Here are 3 differential equations, 
      for each of these differential equations 
      draw a vector plase plot and then some solutions.*/
    ],
  ),
  (
    statement: [
      /* Do Euler's method on this differenetial 
      equation that has a stable solulation. Now 
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