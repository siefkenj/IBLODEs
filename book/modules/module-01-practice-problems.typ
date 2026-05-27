#import "../libs/lib.typ": *

#let questions = (
  (
    statement: [
      For the following differential equations, (i) identify if the differential equation is
      autonomous or non-autonomous, and (ii) check if the given function solves the differential
      equation.
      + $P' = P^2$ and $P(x) = - 1/x$.
      + $y' dot y = t$ and $y(t) = sqrt(t^2+1)$.
      + $P' = P^2 + 5$
        and
        $P(x) = 5tan(5x)$
      + $(dif w)/(dif t) = e^t + t$ and $w(t)
        = e^t -
        pi + t^2/2$
    ],
    solution: [
      + Yes
      + Yes
      + No
      + Yes
    ],
  ),
  (
    statement: [
      For the following initial value problems, (i) identify if the differential equation is
      autonomous or non-autonomous, (ii) identify what _order_ the differential equation (or system
      of differential equations) is, and (iii) check if the given function solve the initial value
      problem.
      + #block(
          inset: (bottom: .5em),
          [
            $cases(y' + ln(5) = t, y(5) = 4)$ and\
            $y = t^2 - ln(5)t - 25$
          ],
        )
      + #block(
          inset: (bottom: .5em),
          [
            $cases(y'' + y = sin(t), y(0) = 0, y'(0) = 1/2)$
            and\ $y(t) = sin(t) - 1/2 t cos(t)$.
          ],
        )
      + $cases(x'(t) = 2 x(t) + 3 y(t), y'(t) = 2 x(t) + y(t), x(0) = 5, y(0) = 0)$ and\
        $x(t) = 3e^(4t) + 2e^(-t)$ and $y(t) = 2e^(4t) - 2e^(-t)$.
      + $cases(c' = 0, c(0) = 1)$ and $c(x) = 1$.
    ],
  ),
  (
    statement: [
      /*(Forth question about modelling; requires
      some real-world judgement, e.g. maybe
      something involving seasons)*/
      Winnie the Pooh, who is notably a bear, hibernates every winter. He wakes up every spring in
      April, and goes back to sleep every winter in October. This year he goes to sleep on October
      1st and wakes up on April 1st. Worried about Winnie's health, his friend Tigger decides to
      model Winnie's weight over his hibernation. Tigger makes the following assumptions about
      Winnie the Pooh's weight:
      - (T1) Winnie is 100 kg when he wakes up on April 1st. (Winnie told him this.)
      - (T2) Winnie is 150 kg when he goes to sleep on October 1st. (Again, Winnie told him this.)
      - (T3) While Winnie hibernates his weight is decreasing linearly.
      + Based on these assumptions, write down an _explicit_ model for Winnie's weight, $w(t)$ at
        $t$ after the start of hibernation.
      + Write down a _differential-equations based model_ for $w(t)$
        $
          w'(t) = underline("          ")
        $
      + Tigger has another friend, Donkey. Looking at Tigger's model, Donkey reminds Tigger of the
        assumptions that make up Kleiber's Law:
        - (D1) The metabolic rate of animals is proportional to the weight of the animal to the
          power of $3/4$.
        - (D2) The metabolic rate of an animal is proportional to the daily weight loss of the
          animal (if they are not eating).
        Based on Donkey's assumptions, write down a new differential-equations based model
        $
          w'(t) = underline("          ")
        $
    ],
  ),
  (
    statement: [
      Every year, Statistics Canada estimates the total population of the "rural and small town"
      areas of Canada. The following table shows the estimated population on Jan. 1st in millions of
      people for the years 2015 to 2018:

      #align(
        center,
        block(
          breakable: false,
          simple_table(
            headers: ([Year], [Population (millions)], [Population Change (millions/year)]),

            content: (
              $2015$,
              $5.938$,
              "",
              $2016$,
              $5.967$,
              "",
              $2017$,
              $6.005$,
              "",
              $2018$,
              $6.044$,
              "",
            ),
          ),
        ),
      )

      + _Assumption (M1): From 2015 to 2018, every year the population of rural and small town
        Canada increases by a factor of 1.0059._//Here is an assumption, give F1. Linear make if linear. "Immigration"

        Based on the assumption (M1), find an _explicit_ model for the population of rural and small
        towns in Canada
      + Consider the following _recursive_ model for the population of rural and small towns in
        Canada $n$ years after 2015: $P_{n+1} = P_n + 0.0353$ with $P_0 = 5.938$. //Here is the relationship what assumption. but now we also have birth rate or something.

        Identify and write down what assumptions that were made to arrive at this model.
      + Create two differential-equations based models, one using assumption(s) from part (a) and
        anther using assumption(s) from part (b).
    ],
  ),
  (
    statement: [
      /*(Situation with a new model)
      + Build a discrete model modelling population by year
        and compute pop after first three years
      + By month
      + Modify it to be a continuous model*/
      A small population of fish have been introduced to a large lake. Make the following
      assumptions about the population of fish in the lake:
      - (M1) All the population of fish in the lake are the same species.
      - (M2) The initial population of fish in the lake is 28 fish.
      - (M3) After 1 year, the population of fish is approximately 57.
      - (M4) The year to year ratio of the population of fish in the lake is approximately constant.
      + Make a table of the population of fish in the lake by year for the first 5 years.
      + Tiffany believes that the growth of the fish population in the lake can be modelled with an
        exponential function. Is Tiffany's belief consistent with the assumptions above? If not,
        which assumption is contradicted? If so, what rate $k$ will the exponential have?
      + Make a table of the population of fish in the lake by month for the first 5 months.

      //+ Complete this discrete model, by creating a continuous equation (E1) that models the population of fish in the lake over time that is consistent with the assumptions and data above. //Tiffany think that this exponential with this function .
      //  - (E1)
      //+ List two new assumptions (M5) and (M6) that could also be presented in this model, and make a note on the advantages or disadvantages of including them.
      // List assumptions that make tiffany's model wrong.
      //- (M5)
      //- (M6)
    ],
  ),
  (
    statement: [
      True or false:
      + $y = e^x$ solves both the differential equations $y' = y$ and $y' = e^x$. This means that
        both of these differential equations have the the same general solution.
      + Any differential equation in terms of $y'$, $y$, and $t$ can be written in the form
        $f(y',y,t) = 0$.
      // y' = sin(y^2)
      //
      //+ A model can just include a function between two variables and nothing else.
      //+ A model must be only one of an explicit model, a recursive model, or a differential model.
      //+ The only differential equation models that make sense, and that are able to give us information about the world, are models for which the differential equation is able to be solved.
      //+ A model must have a finite number of assumptions, since it is impossible to write down an infinite number of assumptions.
      /*+ The general solution to a differential
      equation can be found by either adding or
      multiplying an arbitrary constant to a
      particular solution of a differential
      equation.*/
      /*+ Any autonomous linear first order
      differential equation can be solved by
      separation of variables.*/
      /*+ Assume that $y' = F(y,t)$ with
      $y(1) = 2$ is an initial value
      problem that has $y(t)$ as a solution.
      Assume that $F(y,t)$ and $y(t)$ are
      continuous except at $t = 0$. In this case
      $y(t)$ is unique as a solution to the
      initial value problem on its domain.*/
      /*+ The differential equation
      $y' = y$, when solved through separation of variables, gives the result
      $|y| = C e^t$ with $C > 0$. This gives rise to the general solution $y = C e^t$, for all $C in R$, after some analysis of cases, when removing the absolute value.*/
    ],
  ),
  (
    statement: [
      Bonus questions:
      +
        + How would you write down the explicit function you found in question 7 (a) as a recursive
          relationship?
        + How would you write down the recursive relationship you found in question 7 (b) as an
          explicit function?
      + In question 5, do you have any criticisms of how student presented their work? Is their any
        way they could be better?
    ],
  ),
)
