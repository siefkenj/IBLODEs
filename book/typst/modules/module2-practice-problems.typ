#let questions = (
  (
    statement: [
      (This time model a population
      that is growing exponentially.)
      + Build a model with a differential equation.
      + Get the solution approximation with euler's method. This should be done by by hand this time, so there must be a way to incentivize this.
      + Graph the solution you just found by hand.
      + Use desmos (or maybe find the graph of the true solution on this page of the textbook or something). Is the graph that you came up with with eulers method an understestimate? Why?
    ],
    solution: [
      + Way 1 is good
      + Way 2 is better
    ],
    citation: [X]
  ),
  (
    statement: [
      (Pair the differential equation with a slope field and then pair that slope field with a graph of the solution kinda question.)
    ],
  ),
  (
    statement: [
      True or false: 
      + Since particular solutions to a differential equation differ by a constant, they are all parallel to each other.
      + There is a differential equation for which Euler's method is perfectly accurate.
      + Assume that you are given a differential equation with initial condition $(t, P(t)) = (a,b)$. Euler's method has a starting point of the initial condition and only goes forward in time, it can only be used to approximate solutions for $t > a$.:q
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
      A fifth question.
    ],
  ),
  (
    statement: [
      A fourth question.
    ],
  ),
  (
    statement: [
      A fifth question.
    ],
  ),
  (
    statement: [
      A sixth question.
    ],
  ),
  (
    statement: [
      (Question that uses second derivative euler's method)
    ],
  ),
  (
    statement: [
      (Better Euler's method question)
    ],
  ),
  (
    statement: [
      Notes from Jake while reading the book:
      + Once Jason likened defining a new function to be "that which solves some differential equation" to defining "e" to be "that number that is the limit of $(1 + 1/n)^n$ as $n$ approaches infinity" or "$e^x$" as "that function that is it's own derivative". I think this is a good analogy, and furthermore I think that it might be cool to somehow incorporate this into the first few paragraph of this chapter.
      + In my opinion, the words "linear appoximation" must be said if introducing Euler's method. I believe students coming out of calculus have linear appoximation etched into their brains, and so it is a good idea to use this term.
      + In the first example of the use of Euler's method I think that it is also important to mention that we do not know the value of $P'(0.5)$, not just that we do not know $P(0.5)$.
      + In example 1 in the chapter, I think the visuals could be workshopped to be a bit better.
    ],
  )
)