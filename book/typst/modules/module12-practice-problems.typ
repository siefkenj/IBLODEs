#let questions = (
  // (
  //   statement: [
  //     Explain what you need to do in two different ways.
  //     + Way 1
  //     + Way 2
  //   ],
  //   solution: [
  //     + Way 1 is good
  //     + Way 2 is better
  //   ],
  //   citation: [X]
  // ),
  // (
  //   statement: [
  //     A second question.
  //   ],
  //   solution: [
  //     The answer to the second question.
  //   ],
  // ),
  (
    statement: [
      Sketch slope field for $y'=e^(x-y)$. How do the solutions behave as $x$ grows? Can you guess a
      particular solution by looking at the slope field?
    ],
  ),
  (
    statement: [
      Sketch slope field for $y'=x^2$.
    ],
  ),
  (
    statement: [
      Sketch slope field for $y'=y^2$.
    ],
  ),
  (
    statement: [
      Is it possible to solve the equation $y' = (x y)/(cos x)$ for $y(0) = 1$? Justify.
    ],
  ),
  (
    statement: [
      Is it possible to solve the equation $y' = y sqrt(abs(x))$ for $y(0) = 0$? Is the solution
      unique? Justify.
    ],
  ),
  // (
  //   statement: [
  //     Match equations $y' = 1 - x$, $y' = x - 2 y$, $y' = x (1 - y)$ to slope fields. Justify.
  //     XXXX ADD SLOPE FIELDS
  //   ],
  // ),
  (
    statement: [
      (Challenging) Take $y' = f(x,y)$, $y(0) = 0$, where $f(x,y) > 1$ for all $x$ and $y$. If the
      solution exists for all $x$, can you say what happens to $y(x)$ as $x$ goes to positive
      infinity? Explain.
    ],
  ),
  (
    statement: [
      (Challenging) Take $(y-x)y' = 0$, $y(0) = 0$.
      + Find two distinct solutions.
      + Explain why this does not violate Picard's theorem.
    ],
  ),
  (
    statement: [
      Suppose $y' = f(x,y)$. What will the slope field look like, explain and sketch an example, if
      you know the following about $f(x,y)$:
      + $f$ does not depend on $y$.
      + $f$ does not depend on $x$.
      + $f(t,t) = 0$ for any number $t$.
      + $f(x,0) = 0$ and $f(x,1) = 1$ for all $x$.
    ],
  ),
  (
    statement: [
      Find a solution to $y' = abs(y)$, $y(0) = 0$. Does Picard's theorem apply?
    ],
  ),
  (
    statement: [
      Take an equation $y' = (y - 2 x) g(x,y) + 2$ for some function $g(x,y)$. Can you solve the
      problem for the initial condition $y(0) = 0$, and if so what is the solution?
    ],
  ),
  (
    statement: [
      Suppose $y' = f(x,y)$ is such that $f(x,1) = 0$ for every $x$, $f$ is continuous and
      $(diff f)/(diff y)$ exists and is continuous for every $x$ and $y$.
      + Guess a solution given the initial condition $y(0) = 1$.
      + Can graphs of two solutions of the equation for different initial conditions ever intersect?
      + Given $y(0) = 0$, what can you say about the solution. In particular, can $y(x) > 1$ for any
        $x$? Can $y(x) = 1$ for any $x$? Why or why not?
    ],
  ),
  (
    statement: [
      Sketch the slope field of $y'=y^3$. Can you visually find the solution that satisfies
      $y(0)=0$?
    ],
  ),
  (
    statement: [
      Is it possible to solve $y' = x y$ for $y(0) = 0$? Is the solution unique?
    ],
    solution: [
      Yes a solution exists. The equation is $y' = f(x,y)$ where $f(x,y) = x y$. The function
      $f(x,y)$ is continuous and $(diff f)/(diff y) = x$, which is also continuous near $(0,0)$. So
      a solution exists and is unique. (In fact, $y=0$ is the solution.)
    ],
  ),
  (
    statement: [
      Is it possible to solve $y' = x/(x^2-1)$ for $y(1) = 0$?
    ],
    solution: [
      No, the equation is not defined at $(x,y) = (1,0)$.
    ],
  ),
  // (
  //   statement: [
  //     Match equations $y'= sin x$, $y'=cos y$, $y' = y cos(x)$ to slope fields. Justify.
  //     XXX ADD SLOPE FIELDS
  //   ],
  //   solution: [
  //     + $y' = cos y$
  //     + $y' = y cos(x)$
  //     + $y' = sin x$.
  //     Justification left to reader.
  //   ],
  // ),
  (
    statement: [
      Suppose
      $
        f(y) = cases(
          0 " if " y > 0,
          1 " if " y <= 0
        )
      $
      Does $y' = f(y)$, $y(0) = 0$ have a continuously differentiable solution? Does Picard apply?
      Why, or why not?
    ],
    solution: [
      Picard does not apply as $f$ is not continuous at $y=0$. The equation does not have a
      continuously differentiable solution. Suppose it did. Notice that $y'(0) = 1$. By the first
      derivative test, $y(x) > 0$ for small positive $x$. But then for those $x$, we have
      $y'(x) = f(y(x)) = 0$. It is not possible for $y'$ to be continuous, $y'(0)=1$ and $y'(x) = 0$
      for arbitrarily small positive $x$.
    ],
  ),
  (
    statement: [
      Consider an equation of the form $y' = f(x)$ for some continuous function $f$, and an initial
      condition $y(x_0) = y_0$. Does a solution exist for all $x$? Why or why not?
    ],
    solution: [
      The solution is $y(x) = integral_(x_0)^x f(s) d s + y_0$, and this does indeed exist for every
      $x$.
    ],
  ),
)














