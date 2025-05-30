
// This file is meant to be imported and not compiled on its own.
#import "../libs/_workbook.typ": simple_table, label_module
#import "../common/settings-book.typ": workbook, show_def
#let (sans, serif, module, definition, example) = workbook

#label_module(<mod:modelling>)

In this module you will learn
- What a differential equation is.
- What a solution to a differential equation is.
- The difference between a discrete model and a differential-equation based model.

== Modelling
Suppose you are observing some green ants walking on the sidewalk. In the first minute you record 10 ants. In
the second minute you record 20. In the third minute, you record 40 ants. This continues until there are too
many ants for you to count.

#align(
  center,
  simple_table(
    headers: ([Minute], [\#Green Ants]),
    content: (
      $1$,
      $10$,
      $2$,
      $20$,
      $3$,
      $40$,
      $4$,
      $80$,
      $dots.v$,
      $dots.v$,
    ),
  ),
)

Since you lost count of the ants, you decide to use mathematics to try and figure out how many ants walked by
on minutes $5$, $6$, $dots$. You notice the pattern that
$
  "Green ants per minute" n = 2^(n-1) · 10.
$
Stupendous! Mathematics now predicts there were $160$ ants during minute $5$. But something else catches your
eye. Across the sidewalk are brown ants. You count these ants every minute.

#align(
  center,
  simple_table(
    headers: ([Minute], [\#Brown Ants]),
    content: (
      $1$,
      $3$,
      $2$,
      $6$,
      $3$,
      $12$,
      $4$,
      $24$,
      $dots.v$,
      $dots.v$,
    ),
  ),
)

The pattern is slightly different. This time,
$
  "Brown ants per minute" n = 2^(n-1) · 3.
$
Your friend, who was watching you the whole time, looks confused. “Why come up with two complicated
equations when you can describe both types of ant at once?” they declare.
$
  "#Ants at minute" n = 2 · ("#Ants at "&"minute" n − 1) \
  "#Green ants at minute" 1 &= 10 \
  "#Brown ants at minute" 1 &= 3
$
Your friend has a point. Their model is elegant, but your model can predict how many ants pass by at minute
$3.222$! Though, your friend would probably complain that $46.654$ is not a number of ants#sym.dots.
You and your friend have just come up with two different mathematical models for the number of ants that walk
across the sidewalk. They happen to make similar predictions for each minute and each have their strengths
and weaknesses. In this text, we will be focused on another type of mathematical model---one that uses
differential equations at its core.

== Types of Models

#show_def("model")

In the previous situation, the _question_ you were trying to answer was "how many ants are there at a given minute?".
We sidestepped difficult issues like, "Is an ant that is missing three legs still an ant?" by using the common-sense
conventions and so
// that "the number of ants is a whole number and one colored blob that moves under its own power corresponds to one ant"; thus,
we could use single numbers to represent our quantity of interest (the ants).

You and your friend already came up with two types of models.
- An *explicit* model based on known functions.
- A *recursive* model where subsequent terms are based on previous terms and initial conditions.

If we define $A(n)$ to be the number of ants crossing the sidewalk at minute $n$, the _explicit_ model presented for green ants is
$A(n)=2^(n-1) dot 10$
and the _recursive_ model presented is
$A(1) = 10$ and
$A(n) = 2 dot A(n-1)$

Each type of model has pros and cons. For example, the explicit model allows you to calculate the number of ants at any minute
with few button presses on a calculator, whereas the recursive model is more difficult to calculate but
makes it clear that the number of ants is doubling every minute.

Often times recursive models are easier to write down than explicit models#footnote(
  [In fact, in many real-world situations, an explicit model
    doesn't exist],
), but they may be harder to analyze. A third type of model has similarities to both explicit and recursive models, and
brings the power of calculus to modeling.
- A *differential-equations* model is a model based on a relationship between a function’s derivative(s), its
  values, and an initial condition.


_Differential-equations_ models are useful because derivatives correspond to rates of change, and things in the world are always changing.
Let's try to come up with a differential equations model for _brown_ ants.

We'd like an equation relating $A(n)$, the number of brown ants at minute $n$, to $A'(n)$, the _instantaneous rate of change_ of the number of ants at minute $n$.
Making a table, we see

#align(
  center,
  block(
    breakable: false,
    simple_table(
      headers: ([Minute], [\#Brown Ants], [Change (from prev. minute)]),
      content: (
        $1$,
        $3$,
        $?$,
        $2$,
        $6$,
        $3$,
        $3$,
        $12$,
        $6$,
        $4$,
        $24$,
        $12$,
      ),
    ),
  ),
)

*or*

#align(
  center,
  block(
    breakable: false,
    simple_table(
      headers: ([Minute], [\#Brown Ants], [Change (from next minute)]),
      content: (
        $1$,
        $3$,
        $3$,
        $2$,
        $6$,
        $6$,
        $3$,
        $12$,
        $12$,
        $4$,
        $24$,
        $?$,
      ),
    ),
  ),
)

depending on whether we record the change from the previous minute or up to the subsequent minute. Neither table gives the _instantaneous_ rate of
change, but in both tables, the change is proportional to the number of ants. So, we can set up a model
$
  A'(n) = k A(n)
$
where $k$ is a constant of proportionality that we will try to determine later. We've just written down a _differential equation_ with an undetermined parameter $k$.

#show_def("diffeq")

We'd like to figure out what $k$ is. One way is to solve the differential equation and find which values of $k$ make our model
correctly predict the data. This is called _fitting_ the model to data.

#show_def("model_fit")

Note that in general, fitting a model to data doesn't necessarily produce _unique_ values for the unknown parameters, and a fitted model
(especially when the data comes from real-world observations) usually doesn't reproduce the data exactly. However, in the case of these ants, we
just might get lucky.

== Solving Differential Equations

In general, _there is no algorithm for solving differential equations_. Fortunately, it is easy to check whether any particular
function is a solution to a differential equation, since there _is_ an algorithm to differentiate functions
#footnote(
  [
    More specifically, there is an algorithm
    to differentiate the _elementary_ functions, those functions formed by compositions,
    sums, products, and quotients of polynomials, trig, exponentials, and logs.
  ],
).
Because of this, _guess and check_ will be our primary method for solving differential equations.

However, there are a few techniques to solve specific differential equations. These techniques hinge on being able to integrate some functions related to the differential equation.
Some of those algorithms are:
- _Separation of variables_: This technique is useful when the differential equation can be written in the form $x'(t) = F(x(t)) dot G(t)$. See XXX APPENDIX B for more details.
- _Integrating factor_: This technique is useful when the differential equation can be written in the form $x'(t) + f(t) dot x(t) = g(t)$. See XXX APPENDIX C for more details.
- _Series solution_: This technique is useful to describe the solution of a differential equation as a Taylor series. See XXX APPENDIX D for more details.


#example(
  prompt: [

    Use educated guessing to solve $A'(n)=k A(n)$.
  ],
  [

    Since $A'approx A$, we might start with a function that is equal to its own derivative. There is a famous one: $e^n$. Testing, we see
    $dif / (dif n) e^n=e^n=k e^n$
    if $k=1$, but it doesn't work for other $k$'s. Trying $e^(k n)$ instead yields
    $dif / (dif n) e^(k n)=k e^(k n)$
    which holds for all $k$. Thus $A(n)=e^(k n)$ is _a_ solution to $A'(n)=k A(n)$. However, there are other solutions, because
    $dif / (dif n)C e^(k n)=C (k e^(k n))=k(C e^(k n))$,
    and so for every number $C$, the function $A(n)=C e^(k n)$ is a solution to $A'(n)=k A(n)$.

    By guessing-and-checking, we have found an infinite number of solutions to $A'(n)=k A(n)$. It's now time to fit our
    model to the data.
  ],
)

#example(
  prompt: [
    Find values of $C$ and $k$ so that $A(n) = C e^(k n)$ best models brown ants.
  ],
  [
    Taking two rows from our brown ants table, we see
    $
      A(1) &= C e^k &= 3 \
      A(2) &= C e^(2 k) &= 6
    $

    Since $e^k$ can never be zero, from the first equation we get $C = 3 / e^k$. Combining with the second equation we find
    $
      C e^(2 k) = 3 / e^k e^(2 k) = 3 e^k = 6
    $
    and so $e^k = 2$. In other words $k = ln 2$. Plugging this back in, we find $C = 3 / 2$. Thus our fitted model is
    $
      A(n) = inline(3 / 2) e^(n ln 2).
    $

  ],
)

Upon inspection, we can see that $3 / 2 e^(n ln 2) = 3 dot 2^(n - 1)$, which is the explicit model
that was first guessed for brown ants.

