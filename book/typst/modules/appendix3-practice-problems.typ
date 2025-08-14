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
  (
    statement: [
      Solve $y' + x y = x$.
    ],
  ),
  (
    statement: [
      Solve $y' + 6 y = e^x$.
    ],
  ),
  (
    statement: [
      Solve $y' + 3 x^2 y = sin(x) e^{ - x^3 }$, with $y(0) = 1$.
    ],
  ),
  (
    statement: [
      Solve $y' + cos(x) y = cos(x)$.
    ],
  ),
  (
    statement: [
      Solve $1 / (x^2 + 1) y' + x y = 3$, with $y(0) = 0$.
    ],
  ),
  (
    statement: [
      Suppose there are two lakes located on a stream. Clean water flows into the first lake, then the water from the first lake flows into the second lake, and then water from the second lake flows further downstream. The in and out flow from each lake is 500 litres per hour. The first lake contains 100 thousand litres of water and the second lake contains 200 thousand litres of water. A truck with 500 kg of toxic substance crashes into the first lake. Assume that the water is being continually mixed perfectly by the stream.
      + Find the concentration of toxic substance as a function of time in both lakes.
      + When will the concentration in the first lake be below 0.001 kg per litre?
      + When will the concentration in the second lake be maximal?
    ],
  ),
  (
    statement: [
      Newton's law of cooling states that $(d x)/(d t) = -k (x - A)$ where $x$ is the temperature, $t$ is time, $A$ is the ambient temperature, and $k > 0$ is a constant. Suppose that $A = A_0 cos(omega t)$ for some constants $A_0$ and $omega$. That is, the ambient temperature oscillates (for example night and day temperatures).
      + Find the general solution.
      + In the long term, will the initial conditions make much of a difference? Why or why not?
    ],
  ),
  (
    statement: [
      Initially 5 grams of salt are dissolved in 20 litres of water. Brine with concentration of salt 2 grams of salt per litre is added at a rate of 3 litres a minute. The tank is mixed well and is drained at 3 litres a minute. How long does the process have to continue until there are 20 grams of salt in the tank?
    ],
  ),
  (
    statement: [
      Initially a tank contains 10 litres of pure water. Brine of unknown (but constant) concentration of salt is flowing in at 1 litre per minute. The water is mixed well and drained at 1 litre per minute. In 20 minutes there are 15 grams of salt in the tank. What is the concentration of salt in the incoming brine?
    ],
  ),
  (
    statement: [
      Solve $y' + 3 x^2 y = x^2$.
    ],
    solution: [
      $y = C e^(- x^3) + 1/3$ where $C$ is a parameter.
    ],
  ),
  (
    statement: [
      Solve $y' + 2 sin(2 x) y = 2 sin(2 x)$, $y(pi / 2) = 3$.
    ],
    solution: [
      $y = 2 e^(cos(2 x) + 1) + 1$
    ],
  ),
  (
    statement: [
      Suppose a water tank is being pumped out at 3 L/min. The water tank starts at 10 L of clean water. Water with toxic substance is flowing into the tank at 2 L/min, with concentration $20 t$ g/L at time $t$. When the tank is half empty, how many grams of toxic substance are in the tank (assuming perfect mixing)?
    ],
    solution: [
      $250$ grams
    ],
  ),
(
    statement: [
      There is bacteria on a plate and a toxic substance is being added that slows down the rate of growth of the bacteria.
      That is, suppose that $(d P)/(d t) = (2 - 0.1 t) P$.  If $P(0) = 1000$, find the population at $t=5$.
    ],
    solution: [
      $P(5) = 1000 e^(2 times 5 - 0.05 times 5^2) = 1000 e^(8.75) approx 6.31 times 10^6$
    ],
  ),
  (
    statement: [
      A cylindrical water tank has water flowing in at $I$ cubic meters
per second.
      Let $A$ be the area of the cross section of the tank in square meters.
      Suppose water is flowing out from the bottom of the tank at a rate proportional to the height of the water level.  Set up the differential equation for $h$, the height of the water, introducing and naming constants that you need.  You should also give the units for your constants.
    ],
    solution: [
      $A h' = I - k h$, where $k$ is a constant with units $(m^2)/(s)$.
    ],
  ),
)
