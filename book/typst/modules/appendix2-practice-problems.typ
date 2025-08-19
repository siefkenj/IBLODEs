#let questions = (
  (
    statement: [
      Solve $y' = x/y$.
    ],
    // solution: [
    //   + Way 1 is good
    //   + Way 2 is better
    // ],
    // citation: [X]
  ),
  (
    statement: [
      Solve $y' = x^2 y$.
    ],
    // solution: [
    //   The answer to the second question.
    // ],
  ),
  (
    statement: [
      Solve $(d x)/(d t) = (x^2 - 1) t$, for $x(0) = 0$.
    ],
  ),
  (
    statement: [
      Solve $(d x)/(d t) = x sin(t)$, for $x(0) = 1$.
    ],
  ),
  (
    statement: [
      Solve $(d y)/(d x) = x y + x + y + 1$. Hint: Factor the right-hand side.
    ],
  ),
  (
    statement: [
      Solve $x y' = y + 2 x^2 y$, where $y(1) = 1$.
    ],
  ),
  (
    statement: [
      Solve $(d y)/(d x) = (y^2 + 1)/(x^2 + 1)$, for $y(0) = 1$.
    ],
  ),
  (
    statement: [
      Find an implicit solution for $(d y)/(d x) = (x^2 + 1)/(y^2 + 1)$, for $y(0) = 1$.
    ],
  ),
  (
    statement: [
      Find an explicit solution for $y' = x e^(-y)$, $y(0) = 1$.
    ],
  ),
  (
    statement: [
      Find an explicit solution for $x y' = e^(-y)$, for $y(1) = 1$.
    ],
  ),
  (
    statement: [
      Find an explicit solution for $y' = y e^(-x^2)$, $y(0) = 1$. It is alright to leave a definite integral in your answer.
    ],
  ),
  (
    statement: [
      Suppose a cup of coffee is at 100 degrees Celsius at time $t = 0$, it is at 70 degrees at $t = 10$ minutes, and it is at 50 degrees at $t = 20$ minutes. Compute the ambient temperature.
    ],
  ),
  (
    statement: [
      Solve $y' = 2 x y$.
    ],
    solution: [
      The solution is $y = C e^(x^2)$ where $C$ is a parameter.
    ],
  ),
  (
    statement: [
      Solve $x' = 3 x t^2 - 3 t^2$, $x(0) = 2$.
    ],
    solution: [
      The solution is $x = e^(t^3) + 1$.
    ],
  ),
  (
    statement: [
      Find an implicit solution for $x' = 1/(3 x^2 + 1)$, $x(0) = 1$.
    ],
    solution : [
      The solution is $x^3 + x = t + 2$.
    ],
  ),
  (
    statement: [
      Find an explicit solution to $x y' = y^2$, $y(1) = 1$.
    ],
    solution: [
      The solution is $y = 1/(1 - ln(x))$.
    ],
  ),
  (
    statement: [
      Find an implicit solution to $y' = (sin(x))/(cos(y))$.
    ],
    solution: [
      The solution is $sin(y) = -cos(x) + C$ where $C$ is a parameter.
    ],
  ),
  (
    statement: [
      Take the coffee example from #ref(<ex_coffee>, form: "page") with the same numbers: 89 degrees at $t = 0$, 85 degrees at $t = 1$, and ambient temperature of 22 degrees. Suppose these temperatures were measured with precision of $plus.minus 0.5$ degrees. Given this imprecision, the time it takes the coffee to cool to (exactly) 60 degrees is also only known in a certain range. Find this range. Hint: Think about what kind of error makes the cooling time longer and what shorter.
    ],
    solution: [
      The range is approximately 7.45 to 12.15 minutes.
    ],
  ),
 (
    statement: [
      A population $x$ of rabbits on an island is modeled by $x' = x - (1/1000) x^2$, where the independent variable is time in months. At time $t = 0$, there are 40 rabbits on the island.

        + Find the solution to the equation with the initial condition.
        + How many rabbits are on the island in 1 month, 5 months, 10 months, 15 months (round to the nearest integer).
    ],
    solution: [
      + $x = (1000 e^t)/(e^t + 24)$.
      + 102 rabbits after one month, 861 after 5 months, 999 after 10 months, 1000 after 15 months.
    ],
  ),
)