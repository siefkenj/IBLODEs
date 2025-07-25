#import "../libs/_workbook.typ": simple_table

#let questions = (
  (
    statement: [
      Every year, Statistics Canada estimates the total population of the "rural and small town" areas of Canada. The following table shows the estimated population on Jan. 1st in millions of people for the years 2015 to 2018:

      #align(
        center,
        block(
          breakable: false,
          simple_table(
            headers: ([Year], [Population (millions)], [Population Change (millions/year)]),
             
            content: (
              $2015$, $5.938$,"",
              $2016$, $5.967$,"",
              $2017$, $6.005$,"",
              $2018$, $6.044$,"",
            ),
          ),
        ),
      )

      + Make an assumption in the form of a sentence (M1) that will lead a function (F1)  characteristic of an explicit model. Such a function does not have to fit the data *exactly*, but should be reasonably close.
      - (M1) 
      - (F1)
      + Make an assumption (M1) that will lead to an equation (E1) characteristic of a recursive model.
      - (M1) 
      - (E1) 
      + Make an assumption (M1) that will lead to a linear and/or separable differential equation (D1). 
      - (M1) 
      - (D1)
      Note: As stated in the module, a model needs all of: some assumptions, some definitions of variables, and mathematical analysis of those assumptions.
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
      A small population of fish have been introduced to a large lake. Make the following assumptions about the population of fish in the lake:
      - (M1) All the population of fish in the lake are the same species.
      - (M2) The inital population of fish in the lake is 28.
      - (M3) After 1 year, the population of fish is approximately 57.
      - (M4) The year to year ratio of the population of fish in the lake is approximately constant.
      + Make a table of the population of fish in the lake by year for the first 5 years. (Use 3 decimal places for table entries.)
      + Make a table of the population of fish in the lake by month for the first 5 months. (Use 3 decimal places for table entries.)
      + Complete this discrete model, by creating a continuous equation (E1) that models the population of fish in the lake over time that is conistant with the assumptions and data above.
      - (E1)
      + List two new assumptions (M5) and (M6) that could also be presented in this model, and make a note on the advantages or dissadvantages of including them.
      - (M5)
      - (M6)
    ],
  ),
  (
    statement: [
      True or false:
      + A model can't just include a function between two variables and nothing else.
      + A model must be only one of an explicit model, a recursive model, or a differential model.
      + The only differential equation models that make sense, and that are able to give us information about the world, are models for which the differential equation is able to be solved. 
      + A model must have a finite number of assumptions, since it is impossible to write down an infinite number of assumptions.
      + The general solution to a differential equation can be found by either adding or multiplying an arbitrary constant to a particular solution of a differential equation.
      + Any autonomous linear first order differential equation can be solved by separation of variables.
      + Assume that $y' = F(y,t)$ with $y(1) = 2$ is an initial value problem that has $y(t)$ as a solution. Assume that $F(y,t)$ and $y(t)$ are continuous except at $t = 0$. In this case $y(t)$ is unique as a solution to the initial value problem on its domain.
      + The differential equation $y' = y$, when solved through seperation of variables, gives the result 
      $|y| = C e^t$ with $C > 0$. This gives rise to the general solution $y = C e^t$, for all $C in R$, after some analysis of cases, when removing the absolute value.
    ],
  ),
  (
    statement: [
      /*(Thrid question about modelling; similar to first but not a population model)*/
      Cancer researchers are modelling the effect that exercise has on remission rates of cancer patients. Make the following assumptions about the remission rate of cancer patients in the exercise group of the study:
      - (M1) At the beginning of the study 100% of cancer patients are in remission.
      - (M2) Based on their data in the exersice group, every year the change in the proportion of cancer patients in remission halves.
      - (M3) Based on previous studies, the yearly change in the proportion of cancer patients in remission is approximately $7.5 \%/y e a r$.
      - (M4) The inital rate of change of proportion of patients in remission in the exersice and non-exercise groups are the same.
      + Make a table of the proportion of cancer patients in remission by year for the first 5 years. (Use 3 decimal places for table entries.)
      + Make a table of the proportion of cancer patients in remission by month for the first 5 months. (Use 3 decimal places for table entries.)
      + Complete this discrete model, by coming up with a continuous equation (E1) that models the proportion of cancer patients in remission over time.
      - (E1)
      + Based on their data, the researchers make the additional assumption (M5) that every year the rate of change in the proportion of patients in remission is multiplied by 0.6. This seems to directly contradict (M2), until it is stated that (M5) applies to the non-exercise group instead. After 10 years, what is the difference in the proportion of cancer patients in remission between the exercise group and the non-exercise group? (Use 3 decimal places for your answer.)
    ],
    solution: [
    ],
  ),
  (
    statement: [
      /*(Forth question about modelling; requires some real-world judgement, e.g. maybe something involving seasons)*/
      Winnie the Pooh, who is notably a bear, hibernates every winter. He wakes up every spring in April, and goes back to sleep every winter in October. Worried about Winnie's heath, his friend Tigger, decides to model Winnie's weight over the year.
      Tigger makes the following assumptions about Winnie the Pooh's weight:
      - (M1) Winnie is 100 kg when he wakes up on April 15th. (Winnie told him this.)
      - (M2) Winnie is 150 kg when he goes to sleep on October 16th. (Again, Winnie told him this.)
      - (M3) While Winnie hibernates his weight is decreasing linearly.
      - (M4) While Winnie is awake, his weight is increasing linearly.
      + Based on these assumptions, make a graph by hand of Winnie's weight over the year, with the x-axis being the time $t$ of year so far in days, and the y-axis being Winnie's weight $w$ in kg.
      + Is the graph and the assumptions together sufficient to be a model for Winnies's weight? If not, what is wrong with it, or what is missing? If so, explain why? 
      + Is this model for Winnie's weight reasonable? Why or why not? (Hint: Think about the assumptions Tigger made.)
    ],
  ),
  (
    statement: [
      /*Give two diffeq models and ask which one
      grows faster initially; justif*/
      A biologist is measuring the population of bacteria in a petri dish. They are measuring two bacteria that grow at different rates. Population $P_1$ grows at a rate according to the equation $P_1'(t) = 3140 t P_1(t)$, and population $P_2$ grows at a rate according to the equation $P_2'(t) = 2880 t^2 P_2(t)$, where t is measured in days. The biologist places exactly one cell simultaneously on each side of the petri dish at time $t=0$. The biologist hypothesises that if one of the populations grows faster than the other for the entirety of the first day in the petry dish, then that population will eventually take over the petri dish. Will the biologist be able to test their hypothesis? If so, why? If not, why not?
    ],
  ),
  (
    statement: [
      /*(Give a diffeq model with solutions that have maxes and mins. Ask what time(s) the solution could have a max/min (they need to use calculus to
      determine where $y'(t)=0$ could occur))*/
      Tragically, a new disease has been sweeping through the cattle population of Ohio. Stacy Bets, a bovine disease specialist, is on the case!
      In her current model, she predicts that 5 million cattle have the disease currently, and the spread of the disease, if no action is taken, will be governed by the equation
      $
        P'(t) = P(t) - 1/9 t^2 P^3(t)
      $
      where $P(t)$ is the population in millions of cattle that have the disease, and $t$ is time in years. She must report back to the Ohio state government with the following information: (Assuming no intervension is taken to stop the spread of the disease).
      - Weither amount of cattle that get the desease is unbounded, bounded, or will achieve a maximum
      - Weither the deseased population will eventually stagnate and if so to what value
      + What will Stacy Bets find for the first of these equations? Will the solution to her differential equation be unbounded, bounded, or achieve a maximum? (Hint: Concider first if and when it is possible that $P'(t) = 0$)
      + If you answered part (a) with unbounded, when will every cattle be infected given that there are 20 million cattle in Ohio? If you answered bounded, what is the lowest upper bound possible? If maximum, when is this maximum achieved?
      //I don't know if you can actually answer this without finding the solution.
      + Is the time when this maximum is achieved affected by the starting infected population of 5 million cattle? If not, why not? If yes, come up with a function that takes in the amount of cattle initially infected, and outputs the time when the maximum amount of cattle are infected.
      // I also know know if this is possible to answer. If it is possible maybe make this a bonus question in the solutions.
      + Without doing futher calculations, what do you think Stacy Bets will find for the second question of her report? Will the population of infected cattle stagnate? If not, why not? If so, to what value and why?
    ],
  ),
  (
    statement: [
      /*(Show scratch-work of a "student" solving a diffeq by guess and check. Ask to write down the general solution (including indicating any parameters!))*/
      A student is trying to solve a question about a car with the instruction that "The car is moving East at a rate proportional to the square of its distance from the origin." 
      The student writes down the following in an attempt to solve the differential equation:

      #image("../images/presentation-1.png")

      + Is what the student has written down correct? If not, what is wrong with it?
      + Is the student finished? If not, what else do they need to do?
      + What is the general solution to this differential equation? Please indicate any parameters in your answer.
    ],
  ),
  (
    statement: [
      A company called Swipe Date is running a "50% discount for one month of use" promotional deal for their app as the company grows. Due to recent success, they are trying to wean off the use of the promotional deal over time but not get rid of it entirely. The following is a table of the amount of people given the deal in 2024 by month:
      #align(
        center,
        block(
          breakable: false,
          simple_table(
            headers: ([Month], [Given Deals]),
            content: (
              "Jan", $7983360$,
              "Feb", $3991680$,
              "Mar", $2661120$,
              "Apl", $1995840$,
              "May", $1596672$,
              "Jun", $1330560$,
            ),
          ),
        ),
      )
      Make the following assumption about the data:
      (M1) Once a person has been given the discount, they will never be given it again.
      + Make a further assumption (M2) that will lead to a seperable differential equation (D1) that measures the number of people that have been given the deal as fuction of time in 2024, and write down that differential equation.
      - (M2)
      - (D1)
      + Solve the differential equation (D1) to find a general solution (G1). //(See @app:seperable). XXX Validate reference 
    ],
  ),
  (
    statement: [
      //(IVP solve with different initial conditions)
      The population of rabbits in the University of Victoria's campus is modelled by the following equation from the years 2000 to 2010:
      $P(t) = P'(t)/0.15,$
      where $P(t)$, in hundreds of rabbit, is the population of rabbits at time $t$ in years since 2000. On Jan. 1st 2000, there were 158 rabbits on campus. How many rabbits were there on Jan. 1st 2010? (Don't use a computer beyond just a standard calculator at the end.) 
    ],
  ),
  (
    statement: [
      //(IVP solve with different initial conditions)
      Colloquially, we think of partical accelerators as humongous machines, but they can actually by quite small! Mathis is a physics undergrad at the University of Waterloo who is doing trial and error experiments to find the optimal velocity of some electrons in a campus particle accelerator. Hey he is looking for the electrons to exibit a specific behaviour. He finds that the velocity of the electrons is modelled by the  equation
      $t a(t) + v(t) - 1 = 0$
      where $a(t)$ is the acceleration of the electrons at time $t$ in mircoseconds, and $v(t)$ is the velocity of the electrons at time $t$ in meters per microsecond. Assuming the elections start at rest, write a formula for the velocity of the electrons at time $t$ in microseconds? (Don't use a computer beyond just a standard calculator at the end.)
    ],
  ),
  (
    statement: [
      All of the differential equations in this question are functions of $t$. Classify the following differential equations by type: Autonomous/non-Autonomous, First Order/non-First Order, One Dimensional/Higher Dimensional, Linear/non-Linear, Separable/non-Separable, Homogeneous/non-Homogeneous:
      #align(
        center,
        block(
          breakable: false,
          simple_table(
            headers: ([Equation], [Autonomous], [First order], [One dimensional], [Linear], [Separable], [Homogeneous]),
            content: (
              $y' = y$,"","","","","","",
              $y' = y^2$,"","","","","","",
              $y' = y + t$,"","","","","","",
              $y'y = 1$,"","","","","","",
              $y' = 0$,"","","","","","",
              $y'' = e^y'$,"","","","","","",
              //$y' = z$  $z' = y$,"","","","","","",
              //$y' = y + z$ & $z' = y$,"","","","", 
              //$y' = sin(xy)$ & $x'' = 0$,"","","","", 
              //$y' = ln(t)$ & $y'' = 0$,"","","","",
            ), 
          ),
        ),
      )

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
  ),
)
