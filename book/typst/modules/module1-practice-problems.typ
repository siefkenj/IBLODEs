#let questions = (
  (
    statement: [
      Every year, Statistics Canada estimates the total population of the "rural and small town" areas of Canada. The following table shows the estimated population on Jan 1st in millions for the years 2015 to 2018:

      /*#align(
        center,
        block(
          breakable: false,
          simple_table(
            headers: ([Year], [Population (millions)], [Population Change (millions)]),
            content: (
              $2015$, $5.938$, ,
              $2016$, $5.967$, ,
              $2017$, $6.005$, ,
              $2018$, $6.044$, ,
            ),
          ),
        ),
      )*/

      + Make an assumption in the form of a sentance (M1) that will lead a function (F1)  characteristic of an explicit model. Such an function does not have to fit the data *exactly*, but should be reasonabily close.
      - (M1) 
      - (F1)
      + Make an assumption (M1) that will lead to a an equation (E1) characteristic of a recursive model.
      - (M1) 
      - (E1) 
      + Make an assumption (M1) that will lead to a linear and/or seperable differential equation. 
      - (M1) 
      - (D1)
      Note: A model needs both some applicable mathmatical analysis, and some assumptions.
      /*I didn't follow the directions of question 1 here`. I sorta think that it is good to have a question that really focuses on what a model actually is. Getting them used to having the assumptions that they make about their models also being part of their Models. I have rewritten the question 1 instructions for question 2.*/
    ],
    solution: [
    ],
    citation: [X],
  ),
  (
    statement: [
      /*(Situation with a new model)
      + Build a discrete model modelling population by year and compute pop after first three years
      + By month
      + Modify it to be a continuous model*/
    ],
  ),
  (
    statement: [
      /*(Thrid question about modelling; similar to first but not a population model)*/
    ],
    solution: [
    ],
  ),
  (
    statement: [
      (Forth question about modelling; requires some real-world judgement, e.g. maybe something involving seasons)
    ],
  ),
  (
    statement: [
      /*Give two diffeq models and ask which one
      grows faster initially; justif*/
      A biologist is measuring the population of bacteria in a petri dish. They are measuring two bacteria that grow at different rates. Population P_1 grows at a rate according to the equation $P_1'(t) = 3140 t P_1(t)$, and population P_2 grows at a rate according to the equation $P_2'(t) = 2880 t^2 P_2(t)$, where t is measured in days. The biologist biologist places exactly one cell simotaniously on each side of the petri dish at time $t=0$. The biologist know hypothesises that if one of the populations grows faster than the other of the entriety of the first day in the petry dish, then that population will eventually take over the petri dish. Will the biologist be able to test their hypothesises? If so, why? If not, why not?
    ],
  ),
  (
    statement: [
      /*(Give a diffeq model with solutions that have maxes and mins. Ask what time(s) the solution could have a max/min (they need to use calculus to
      determine where $y'(t)=0$ could occur))*/

    ],
  ),
  (
    statement: [
      /*(Show scratch-work of a "student" solving a diffeq by guess and check. Ask to write down the general solution (including indicating any parameters!))*/
      A student is trying to solve a question about a car with the instruction that "The car is moving east at a rate propotional to the square of it's distance from the origin." 
      The student writes down the following in an attempt to solve the differential equation:

      //#include "fakeStudentScratchWork.pdf"

      + Is what the student has written down correct? If not, what is wrong with it?
      + Is the student finished? If not, what else do they need to do?
      + What is the general solution to this differential equation? Please indicate any parameters in your answer.
    ],
  ),
  (
    statement: [
      A company called Swipe Date is runs a "50% discount for one month of use" promotional deal for their app as the company grows. Due to recent success, they are trying to wean off the use of the promotional deal over time but not get rid of it entriely. The following is a table of the amount of people given the deal in 2024 by month:
      /*#align(
        center,
        block(
          breakable: false,
          simple_table(
            headers: ([Month], [Given Deals]),
            content: (
              $Jan$, $7983360$,
              $Feb$, $3991680$,
              $Mar$, $2661120$,
              $Apl$, $1995840$,
              $May$, $1596672$,
              $Jun$, $1330560$,
            ),
          ),
        ),
      )*/
      Make the following assumption about the data:
      (M1) Once a person has been given the discount, they will never be given it again.
      + Make a further assumption (M2) that will lead to a seperable differential equation (D1) that measures the number of people that have been given the deal as fuction of time in 2024, and write down that differential equation.
      - (M2)
      - (D1)
      + Solve the differential equation (D1) to find a general solution (G1) //(See @app.seperable).
    ],
  ),
  (
    statement: [
      //(IVP solve with different initial conditions)
      The population of rabbits in the University of Victoria's campus is modelled by the following equation from the years 2000 to 2010:
      $P(t) = P'(t)/0.15,$
      where $P(t)$ in hundreds of rabbit is the population of rabbits at time $t$ in years since 2000. On Jan 1st 2000, there were 158 rabbits on campus. How many rabbits were there on Jan 1st 2010? (Don't use a computer beyond just a standard calculator at the end.) 
    ],
  ),
  (
    statement: [
      //(IVP solve with different initial conditions)
      Colloquially, we think of partical accelerartors as humongous machines, but they can actually by quite small! Mathis is a physics undergrad at the University of Waterloo who is doing trial and error experiments to find the optimal velocity of some electrons in campus particle accelerator, for the electrons to exibit a specific behaviour. He finds that the velocity of the electrons is modelled by the  equation
      $ta(t) + v(t) - 1 = 0$
      where $a(t)$ is the acceleration of the electrons at time $t$ in mircoseconds, and $v(t)$ is the velocity of the electrons at time $t$ in meters per microsecond. Assuming the the elections start at rest, what is a formula for the velocity of the electrons at time $t$ in microseconds? (Don't use a computer beyond just a standard calculator at the end.)
    ],
  ),
  (
    statement: [
      All of the differential equations in this question are functions of $t$. Classify the following differential equations by type: autonomous/non-autonomous, First order/Not first order, one dimensional/Higher dimensional, linear/non-linear, separable/non-separable, homogeneous/non-homogeneous:
      /*#align(
        center,
        block(
          breakable: false,
          simple_table(
            headers: ([Equation], [Autonomous], [First order], [One dimensional], [Linear], [Separable], [Homogeneous]),
            content: (
              $y' = y$, , , , , , ,
              $y' = y^2$, , , , , , ,
              $y' = y + t$, , , , , , ,
              $y'y = 1$, , , , , , ,
              $y' = 0$, , , , , , ,
              $y'' = e^{y'}$, , , , , , ,
              $y' = z$ & $z' = y$, , , , , , ,
              $y' = y + z$ & $z' = y$, , , , , , ,
              $y' = sin(xy)$ & $x'' = 0$, , , , , ,
              $y' = ln(t)$ & , , , , , , ,
            ), 
          ),
        ),
      )*/

      // I recognize that we probably don't want to have linear, seperable, or homgeneous in here. I put it as an option anyway.
    ],
  ),
  (
    statement: [
      A couple of notes Jake had
      while reading the book:
      1. Green ants? Why not make them red or black? Green ants are kinda a hard mental image other than maybe like really small green ones.
      2. 3.222 is not a number of ants. Currently it says 3.222! which kinda looks visually like 222! - a very big number. I don't know if this is a big deal, but it might be a small deal.
      3. 'An explicit model based on known functions seems a little vague to me. I think what is really trying to be said is that the functions can be written down in a closed form. 
      4. I think that maybe just before defineing what a differential equation is, it might be good to state explicitly that, in this case for $A'(n) = k A(n)$, we already had a model and so writing the differential equation is a bit superfluous. However, in the future we will not be able to write an explicit or recursive model so easily.
      5. I really like the first example. It kinda desribes the thought process one should have when guessing and checking. It might be good to follow up this example with a sanity check question of like "Is this solution the same as the one we had before?" or something like that. I guess right now you kinda do it for them, which is fine too.
      6. Small thing but I think "Solving differential equations" should be called something else like "solutions to differential equations". That is just a bit easier to look up when a student is studying. It also might be a good idea in the section to state right before defining what a general solutions is to state that "There are problems asked more than any other when studying and solving differentatial equations: What is the general solution to this differential equation? and what is the particular solution to this differential equation given this some inital condition? There are respectily two kinds of answers to these questions: a general solution to a differentatial equation that doesn't specify an initial condition, and a specific function that is the solustion to an initial value problem". I am basically saying that there is parhaps room for a into to the ideas of solutions after the first two examples.
      7. I think I am understanding the structure of the book a little more now. I think it might make sense to have a couple of exercises interspersed in the books text as well as at the end of each section. This doesn't currently seem to be the case.
    ],
  )
)
