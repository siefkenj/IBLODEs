
// This file is meant to be imported and not compiled on its own.
#import "../libs/_workbook.typ": label_module, simple_table
#import "../common/settings-book.typ": show_def, workbook
#let (sans, serif, module, definition, example) = workbook

#label_module(<mod:modelling>)

In this module you will learn
- What a differential equation is.
- What a solution to a differential equation is.
- The difference between a discrete model and a differential-equation based model.

== Modelling
Suppose you are observing some green ants walking on the sidewalk. In the first minute, you record
10 ants; in the second, you record 20; in the third, 40. This continues until there are too many
ants for you to count.

#align(center, simple_table(
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
))

Since you lost count of the ants, you decide to use mathematics to predict how many ants walked by
on minutes $5$, $6$, $dots$. You notice a pattern:
$
  "Green ants per minute" n = 2^(n-1) · 10.
$
Stupendous! Mathematics now predicts there were $160$ ants during minute $5$. But something else
catches your eye. Across the sidewalk are brown ants. You count these ants every minute.

#align(center, simple_table(
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
))

The pattern is slightly different. This time,
$
  "Brown ants per minute" n = 2^(n-1) · 3.
$
Your friend, who was watching you the whole time, looks confused. They question: “Why come up with
two complicated equations when you can describe both types of ant at once?”
$
  "#Ants at minute" n = 2 · ("#Ants at " & "minute" n − 1) \
               "#Green ants at minute" 1 & = 10 \
               "#Brown ants at minute" 1 & = 3
$
Your friend has a point. Their model is elegant, but your model can predict how many ants pass by at
minute $3.222$! (Though, your friend would probably complain that $46.654$ is not a number of
ants#sym.dots.) You and your friend have just come up with two different mathematical models for the
number of ants that walk across the sidewalk. They happen to make similar predictions for each
minute; they each have strengths and weaknesses. In this text, we will focus on third type of
mathematical model---one that uses differential equations at its core.

== Types of Models

#show_def("model")

In the previous situation, the _question_ you were trying to answer was "how many ants are there at
a given minute?". We sidestepped difficult issues like, "Is an ant that is missing three legs still
an ant?" by using common-sense conventions and so
// that "the number of ants is a whole number and one colored blob that moves under its own power corresponds to one ant"; thus,
we could use single numbers to represent our quantity of interest (the ants).

You and your friend already came up with two types of models.
- An *explicit* model based on known functions.
- A *recursive* model where subsequent terms are based on previous terms and initial conditions.

If we define $A(n)$ to be the number of ants crossing the sidewalk at minute $n$, the _explicit_
model presented for green ants is
$A(n)=2^(n-1) dot 10$
and the _recursive_ model presented is
$A(n) = 2 dot A(n-1)$
with $A(1) = 10$.

Each model has pros and cons. For example, the explicit model allows you to calculate the number of
ants at any minute with few button presses on a calculator, whereas the recursive model is more
difficult to calculate but makes it clear that the number of ants is doubling every minute.

Often times recursive models are easier to write down than explicit models#footnote([In fact, in
  many real-world situations, an explicit model in terms of already known functions doesn't
  exist.]), but they may be harder to analyze. A third type of model has similarities to both
explicit and recursive models but adds more by bringing the power of calculus to modeling.
- A *differential-equations* model is a model based on a relationship between a function’s
  derivative(s), its values, and an initial condition.


_Differential-equations_ models are useful because derivatives correspond to rates of change, and
things in the world are always changing. Let's try to come up with a differential equations model
for _brown_ ants.

We'd like an equation relating $A(n)$, the number of brown ants at minute $n$, to $A'(n)$, the
_instantaneous rate of change_ of the number of ants at minute $n$. Making a table, we see

#align(center, block(breakable: false, simple_table(
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
)))

*or*

#align(center, block(breakable: false, simple_table(
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
)))

depending on whether we record the change from the previous minute or up to the subsequent minute.
Neither table gives the _instantaneous_ rate of change, but in both tables, the change is
proportional to the number of ants. So, we can set up a model
$
  A'(n) = k A(n)
$
where $k$ is a constant of proportionality that we will try to determine later. We've just written
down a _differential equation_ with an undetermined parameter $k$.

#show_def("diffeq")

We'd like to figure out what $k$ is. One way is to solve the differential equation (that is, find an
explicit function which satisfies the differential equation) and find which values of $k$ make our
model correctly predict the data. This is called _fitting_ the model to data.

// Maybe including a formal definition of fitting is just too much here?
//#show_def("model_fit")

Note that in general, fitting a model to data doesn't necessarily produce _unique_ values for the
unknown parameters, and a fitted model (especially when the data comes from real-world observations)
usually doesn't reproduce the data exactly. However, in the case of these ants, we just might get
lucky.

== Solving Differential Equations

Our approach to fitting will be to first _solve_ the differential equation, i.e. find what functions
$A$ satisfy the equation $A'(t)=k A(t)$, and then see which values of $k$ produce solutions that fit
the data. Our primary method for finding explicit solutions to differential equations will be
guess-and-check.

#example(
  prompt: [
    Use guess-and-check to solve $A'(n)=k A(n)$.
  ],
  [

    Since $A'=k A$ is similar in form to $A'= A$, we might start with a function that is equal to
    its own derivative. There is a famous one: $e^n$. Testing, we see
    $dif / (dif n) e^n=e^n=k e^n$
    if $k=1$, but it doesn't work for other $k$'s. Trying $e^(k n)$ instead yields
    $dif / (dif n) e^(k n)=k e^(k n)$
    which holds for all $k$. Thus $A(n)=e^(k n)$ is _a_ solution to $A'(n)=k A(n)$. However, there
    are other solutions. Because
    $dif / (dif n)C e^(k n)=C (k e^(k n))=k(C e^(k n))$
    for every number $C$, the function $A(n)=C e^(k n)$ where $C in RR$ is a solution to
    $A'(n)=k A(n)$.

    By guessing-and-checking, we have found an infinite number of solutions to $A'(n)=k A(n)$.
  ],
)


It's now time to fit our model to the data.

#example(
  prompt: [
    Find values of $C$ and $k$ so that $A(n) = C e^(k n)$ best models brown ants.
  ],
  [
    Taking two rows from our brown ants table, we see
    $
      A(1) & = C e^k     & = 3 \
      A(2) & = C e^(2 k) & = 6
    $

    Since $e^k$ can never be zero, from the first equation we get $C = 3 / e^k$. Combining with the
    second equation we find
    $
      C e^(2 k) = 3 / e^k e^(2 k) = 3 e^k = 6
    $
    and so $e^k = 2$. In other words $k = ln 2$. Plugging this back in, we find $C = 3 / 2$. Thus
    our fitted model is
    $
      A(n) = inline(3 / 2) e^(n ln 2).
    $

  ],
)

Upon inspection, we can see that $3 / 2 e^(n ln 2) = 3 dot 2^(n - 1)$, which is the explicit model
that was first guessed for brown ants.

=== General Solutions

#show_def("solution")

A given differential equation can have many solutions.

The _solution set_, _complete solution_, or _general solution_ is the family of all functions that
satisfy the differential equation on a given domain.

For example, we can easily verify that the functions $y(t)=e^(2t)$ and $y(t)=17e^(2t)$ both satisfy
the differential equation $y'=2y$. Any multiple of one of these solutions is also a solution, so the
set
$
  {f: f(t)=C e^(2t) "for some" C in RR}
$
is a set of solutions to the differential equation $y'=2y$. Because there are no other
solutions#footnote[This fact is no obvious---it needs to be proved!],
${f: f(t)=C e^(2t) "for some" C in RR}$ is *the* _solution set_/_complete solution_ to the
differential equation.

==== Writing General Solutions

Because set notation can be cumbersome, we often write solutions in an abbreviated form. For
example, we might write the general solution to $y'=2y$ as
$
  y(t) = C e^(2t) wide "where" C in RR "is a parameter".
$

*Important note*: We always specify which terms/variables in a general solution are parameters
(e.g., by writing "where $...$ is a parameter"). This is because differential equations coming from
models often involve many variables. It's important to distinguish which variables come from
modelling assumptions and which are free parameters of your solution.

For example, when finding the general solution to $y'=k y$, if we wrote
"$space.thin y(t) = C e^(k t)space.thin$", it wouldn't be clear if every choice of $C$ gives a valid
solution, if every choice of $k$ gives a valid solution, or both. Here, $k$ comes from the
equation/model and we are not allowed to choose it when solving. However, $C$ can be chosen by us
and every choice results in a valid solution.#footnote[
  You might be thinking, "But didn't we choose $k$ when we fitted the model to data?" Yep! Sometimes
  we change the role of a symbol from a fixed value to a parameter during the modelling process.
  When we're done, though, every symbol has a specific meaning.
]

=== Initial Value Problems

Out of the infinitely many solutions to a differential equation, we usually only want a few of them.
One way to winnow down the solution set is to specify an _initial condition_: a value that the
solution to the differential equation attains at some point/time.

For example, suppose $P'=2P$ models a population and we know the population starts at $100$ at time
$t=0$ (i.e., $P(0)=100$). The general solution to $P'=2P$ is $P(t)=C e^(2t)$ where $C$ is a
parameter, but only one solution in this family satisfies $P(0)=100$. (Stop now and figure out what
value of $C$ leads to a solution satisfying $P(0)=100$.) We call that one solution the solution to
the _initial value problem_
$
    P' & = 2P \
  P(0) & = 100.
$

The term _initial value problem_ is often abbreviated _IVP_.

=== Types of Differential Equations

There are several ways to classify differential equations. The most important for us will be
first-order vs higher-order and autonomous vs non-autonomous.

#show_def("orderdiffeq")

#example(
  prompt: [
    Classify the differential equation $y'' + 2y' + y = 0$.
  ],
  [
    The highest derivative in the equation is $y''$, so this is a _second-order_ differential
    equation.
  ],
)

We will primarily study first order differential equations and systems of first order differential
equations because, as shown in @mod:higher_order, higher-order differential equations can be
transformed into systems of first order differential equations.

#show_def("autonomous")

Equations like $y'(t) =2y(t)$ or $P'(t) = P(t) dot (1 - P(t))$ are said to be _autonomous_ while
equations like $y'(t) = t dot y(t)$ and $P'(t)=(1-P(t))+sin(t)$ are _non-autonomous_.

Autonomous equations, where the independent variable does not appear in the equation, can be thought
of as "time independent" equations because solutions to initial value problems for autonomous
equations do not depend on the starting time. This encompasses most equations of physics: if you're
modelling the motion of a pendulum, it doesn't matter whether "t=0" is the start of the day, the
start of the year, or the instant our sun started having fusion reactions. The pendulum will have
the same motion regardless.

There are other classifications commonly encountered in the study of differential equations:
- _Linear differential equations_: a differential equation that can be written as
  $a_0(t) dot y(t) + a_1(t)dot y'(t) + dots.c + a_n (t) dot y^((n))(t) = b(t)$ where $a_0$,
  #sym.dots, $a_n$, and $b$ are functions of $t$.
- _Homogeneous linear differential equations_: a linear differential equation where $b(t)$ is zero.

While we will be studying linear and homogeneous linear differential equations, classifying
equations as linear/non-linear and homogeneous/non-homogeneous won't be important to us.

=== Solving Methods


There are a number of algorithms and techniques to find explicit solutions to particular classes of
differential equations. These include:
- _Separation of variables_, a technique applicable to differential equations of the form
  $x'(t) = F(x(t)) dot G(t)$. (See @app:separable)
- _Integrating factors_, a technique applicable to first-order linear differential equations, i.e.,
  of the form $x'(t) + f(t) dot x(t) = g(t)$. (See @app:integrating_factor)
- _Series solutions_, a technique to express the solution to a differential equation as a power
  series (e.g., $x(t) = sum_(n=0)^infinity a_n t^n$). (See @app:series_solution)

Unfortunately, despite these techniques, *there is no algorithm for explicitly solving a general
  differential equation*. But, it is easy to check whether a particular function is a solution to a
differential equation, since there _is_ an algorithm to differentiate functions.
#footnote([
  More specifically, there is an algorithm to differentiate the _elementary_ functions, those
  functions formed by compositions, sums, products, and quotients of polynomials, trigonometric
  functions, exponentials, and logarithms.
])
This means *guess and check* is the only universally applicable method for finding explicit
solutions to differential equations, and, though we will learn some other solving techniques, guess
and check will be our go-to method.
