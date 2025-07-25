#let questions = (
  (
    statement: [
      
    ],
    solution: [
      
    ],
  ),
  (
    statement: [
      
    ],
    solution: [

    ],
  ),
  (
    statement: [
      A sample of Uranium is decaying. Make the follwing assumptions about the decay of the Uranium sample:
      - When the sample if first observed, it has a mass of 1 kilograms.
      - Initially the sample is decaying at a rate of 0.1 kilograms per year. $1.55 * 10^-10$ kilograms per year. 
      - The rate of decay is proportional to the mass of the sample.
      + Build a differential equation that pairs with these assumptions to make a differential equation model for the mass of the sample. Use Euler's method in excel with a step size of 1 million years to approximate the half life of the sample.
      + The differential equation that you came up with in part (a) is most likely seperable. Use this to find the solution to your differential equation, then use that solution to find exactly the half life of the sample of Uranium. How close what your approximation to the true value?
      + Would it have been possible to find the half life without the solution to the the differential equation? In this case, parhaps you could use only the differential equation itself and not its soluation. 
      + Get the solution approximation with euler's method. This should be done by by hand this time, so there must be a way to incentivize this.
      + Graph the solution you just found by hand.
      + Use desmos (or maybe find the graph of the true solution on this page of the textbook or something). Is the graph that you came up with with eulers method an understestimate? Why?
    ],
    solution: [
      + Way 1 is good
      + Way 2 is better
    ],
  ),
  (
    statement: [
      /* Pair the differential equation with a slope field and then pair that slope field with a graph of the solution kinda question. */

    ],
  ),
  (
    statement: [
      True or false: 
      + Since particular solutions to a differential equation differ by a constant, they are all parallel to each other on a slope feild.
      + There is a differential equation for which Euler's method is perfectly accurate.
      + Assume that you are given a differential equation with initial condition $(t, P(t)) = (a,b)$. Euler's method has a starting point of the initial condition and only goes forward in time, it can only be used to approximate solutions for $t > a$.
      + When using Euler's method on a differential equation, a smaller step size will always yield a more accurate approximation.
      + It is possible to use Euler's method to approximate a solution to a differential equation with an initial condition. (My mathematics mind is telling me that this might be false barring some special case, but I can't think of one. It is probably true because of the existance and uniqueness theorem.) (This one might be kinda weak.)
      + Other than the initial condition itself which we know are correct, the points given to use by Euler's method always have the least error in the point closest to the initial condition.
      + Euler's method only works for autonomous differential equations.
    ],
  ),
  (
    statement: [
      (This time build a model with some wavy behaviour. That if 
      delta is too big you get really really bad stuff, but if delta is small it is not so bad.)
      + Model with euler's method with a large delta. Using computer this time. 
      + Qualitatively do you expect this ?
      + How does this error chenge if you use a smaller delta?
      + why does the bigger delta give you such a bad reasult?
      + For the smaller delta, do we still get an underestimate like in the first question? What is different, and what annalogous behaviour can we notice about our model that is not not an over or underestimate?
    ],
    solution: [
      The answer to the second question.
    ],
  ),
  (
    statement: [
      (They shouldn't have to model for this one, I think we should just give then the differential equation, but importantly it is a differential equation such that if the step is too big, then Euler's method will overshoot an equalibrium solution and go into space where as the actual solution is bounded.))
    ],
  ),
  (
    statement: [
      (Maybe we could have a very simple
      + draw a slope field of this DE by hand
      + draw some solution curve on that slope field given some initial conditions by hand
      + confirm you answer on desmos
      + maybe a qualitative question "without proof does it feel like any solutions will ever cross each other?"
      kinda question)
    ],
  ),
  (
    statement: [
      (Another modeling question. This one should be a little more challenging to model. Similar to module 1, but this time I would like them to use Euler's method.)
    ],
  ),
  (
    statement: [
      (Question that uses second derivative euler's method, They shouldn't have to model for this this one.)
    ],
  ),
  (
    statement: [
      (Better Euler's method question. This question and the previous one I am not sure if this is what we want, but I do like the idea of challenging the students in this way.)
    ],
  ),
  (
    statement: [
      Notes from Jake while reading the book:
      + Once Jason likened defining a new function to be "that which solves some differential equation" to defining "e" to be "that number that is the limit of $(1 + 1/n)^n$ as $n$ approaches infinity" or "$e^x$" as "that function that is it's own derivative". I think this is a good analogy, and furthermore I think that it might be cool to somehow incorporate this into the first few paragraph of this chapter.
      + In my opinion, the words "linear appoximation" must be said if introducing Euler's method. I believe students coming out of calculus have linear appoximation etched into their brains, and so it is a good idea to use this term.
      + In the first example of the use of Euler's method I think that it is also important to mention that we do not know the value of $P'(0.5)$, not just that we do not know $P(0.5)$.
      + In example 1 in the chapter, I think the visuals could be workshopped to be a bit better.
      + This might be too meny question in the problem set here. 
    ],
  )
)