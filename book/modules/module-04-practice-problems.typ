#import "../libs/lib.typ": *
#set align(center)

#let f1(A, B) = (calc.sin(B), A - B)
#let path1 = solve_2d_ivp(f1, (0.0, 5.0), 600, Delta: .1, method: "rk4")
#let pi_axis = ("0", $pi/2$, $pi$, $(3pi)/2$)

#let questions = (
  (
    statement: [
      Based on the signs of $x'$, find and classify all equilibrium points.

      + #align(center, simple_table(
        headers: ($x$, $(-infinity, 0)$, $0$, $(0,infinity)$),
        content: (
          [$x'$],
          [+],
          [0],
          [-]
        ),
        ))

      + #align(center, simple_table(
        headers: ($x$, $(-infinity, 5)$, $5$, $(5, 10)$, $10$, $(10,infinity)$),
        content: (
          [$x'$],
          [+],
          [0],
          [-],
          [0],
          [+]
        ),
        ))

      + #align(center, simple_table(
        headers: ($x$, $(-infinity, 3)$, $3$, $(3, 4)$, $4$, $(4,infinity)$),
        content: (
          [$x'$],
          [-],
          [0],
          [-],
          [0],
          [-]
        ),
        ))
    ],
    solution: [
      + Equilibrium solution at $x=0$ (stable and attracting).
      + Equilibrium solution at $x=5$ (stable and attracting), $x=10$ (unstable and repelling).
      + Equilibrium solutions at $x=3$ and $x=4$ (both are unstable but not repelling).
    ],
  ),
  (
    statement: [
      Are the following statements true or false? Provide an example to justify your answer.

      + There can be a system of differential equations with no equilibrium solution of any sort.
      + There can be a one-dimensional autonomous differential equation with infinitely many repelling equilibrium solutions and no other type of equilibrium solution.
      + An equilibrium solution must be either attracting or unstable.
      + For a differential equation, the graph in the component space can cross the equilibrium solution.
      + For a system of differential equations $x'=..., y'=...$. The graph in the component space of $x$ can not cross the line for which $x'=0$.
    ],
    solution: [
      + True.
      + False.
      + False, it can be stable and not attracting.
      + False.
      + False, just because $x$ is crossing $x'=0$, in its component space, does not necessarily mean $y$ is crossing $y'=0$ at the same time.
    ]
  ),
  (
    statement: [
      Find and classify the equilibrium solutions to the following equations:
      + $x'=x^2$
      + $x'=sin(x)$
      + $x'=(x-1)(x-2)x^2$
      + $x'=e^(-x)$
    ],
    solution: [
      + Equilibrium solution at $x=0$ (unstable but not repelling).
      + Equilibrium solutions at $x=n pi$ for $n in ZZ$. For even $n$, the equilibrium solutions are unstable and repelling, and for odd $n$, the equilibrium solutions are stable and attracting.
      + For $x'=(x-1)(x-2)x^2$, the equilibrium points are: $x = 0$ (unstable, but not repelling), $x = 1$ (stable and attracting), $x = 2$ (unstable and repelling).
      + For $x'=e^(-x)$, there are no equilibrium points.],
    citation: [_Notes on Diffy Q's_ by Jiří Lebl 1.6.3, 1.6.4, 1.6.101, 1.6.102],
  ),
    (
    statement: [
      Construct one-dimensional autonomous differential equations with the following equilibrium solutions and classifications:

      + $x=0$ (stable and attracting), $x=1$ (unstable and repelling).
      + $x=-1$ (unstable and repelling), $x=0$ (stable and attracting), $x=1$ (unstable and repelling).
      + $x=-1$ (stable and attracting), $x=0$ (unstable and repelling), $x=1$ (stable and attracting).
      + $x=1$ (unstable but not repelling)
    ],
    solution: [
      Possible solutions:
      + $x'=x(x-1)$
      + $x'=x(x+1)(x-1)$
      + $x'=-x(x+1)(x-1)$
      + $x'=(x-1)^2$
    ],
  ),
  (
    statement: [
      Consider the following differential equation:

      $x'=-x^4 + 4x^3 + 3x^2 - 14x + 8$

      + Find and classify all of the equilibrium solutions.
      + For which initial condition(s) does the solution approach $x=4$ as $t -> infinity$?
      + What happens qualitatively to solutions if $x(0)< -2$?
    ],
    solution: [
      + We can factor this into $x'=-(x+2)(x-1)^2(x-4)$. We can find that the equilibrium solutions are $x=-2$ (unstable and repelling), $x=1$ (unstable but not repelling), and $x=4$ (stable and attracting).
      + Since $x=4$ is a stable and attracting equilibrium solution, the initial condition $x(0)>1$ converges to $x=4$ as $t -> infinity$.
      + If $x(0)< -2$, then $x'<0$ and the solution moves away to the left from $x=-2$.
    ],
  ),
  (
    statement: [
      A student is finding and classifying the equilibrium solutions of 

      $x'=x^2(x+1)(x-1)$

      They claim that: "The equilibrium solutions are at $x=0$, $x=−1$, and $x=1$ because that is where $x'=0$. Since $x=0$ has higher order, then it must be stable and attracting. $x=−1$ is negative, then it must be stable and attracting. Finally, $x=1$ is positive, then it must be unstable and repelling."

      Is the student correct? If not, explain the mistake(s) and give the correct solution.
    ],
    solution: [
      The student had found the correct equilibrium solutions. While the classifications for $x=plus.minus 1$ was correct, their justification was wrong. Then for $x=0$, their classification was incorrect. The sign approach should instead be that of $x'$ used on the neighbourhood of the equilibrium solutions. One can find that:
      - $x< -1$ has $x'>0$, and $-1 < x < 0$ has $x'< 0$. Indicating that $x=-1$ is a stable and attracting equilibrium solution.
      - Similarly, $-1 < x < 0$ has $x'< 0$, and $0 < x < 1$ has $x'< 0$. Indicating that $x=0$ is an unstable but not repelling equilibrium solution.
      - Finally, $0 < x < 1$ has $x'< 0$, and $x > 1$ has $x'> 0$. Indicating that $x=1$ is an unstable and repelling equilibrium solution.
    ],
  ),
  (
    statement: [
      Consider a family of differential equations

      $x'=(x-2)^2+A$

      where $A$ is a real parameter.

      + For which value(s) of $A$ are there no equilibrium solutions?
      + For which value(s) of $A$ are there exactly one equilibrium solution? Then classify it.
      + For which value(s) of $A$ are there 2 equilibrium solutions? Classify them.
      + Could there be an infinite number of equilibrium solutions? Justify your answer.
    ],
    solution: [
      Given that equilibrium solution(s) occur at $x'=(x-2)^2+A=0$, we can solve for $(x-2)^2=-A$.

      + For there to be no equilibrium solution, the square root must be complex. Implying that for the values of $A>0$, we have no equilibrium solution.
      + Similarly, for there to be exactly 1 equilibrium solution. We want the square root to vanish. We get that for the value of $A=0$, we have exactly 1 equilibrium solution located at $x=2$, and is unstable but not repelling.
      + To obtain exactly 2 equilibrium solutions, we require the square root to be real and non-zero. This means that for the values of $A<0$, we have equilibrium solutions at $x=2 plus.minus sqrt(-A)$, where $x=2-sqrt(-A)$ is stable and attracting, and $x=2+sqrt(-A)$ is unstable and repelling.
      + Not possible, as $A$ is a real parameter rather than a function. Furthermore, for each fixed value of $A$, the equation $(x-2)^2+A=0$ is quadratic in $x$, so it can have at most 2 real equilibrium solutions.
    ],
  ),
  (
    statement: [
      Consider the following systems of differential equations, find and classify all of their equilibrium solutions.

      + $cases(x'=2x,y'=5y)$

      + $cases(x'=x y, y'=4y-1)$

      + $cases(x'=y,y'=x)$

      + $cases(x'=x^2-y^2,y'=x y+2)$

      + $cases(x'=sin(2x),y'=cos(y))$

      + $cases(x'=x+y, y'=5x+5y)$

      + $cases(x'=x-y+10, y'=x-y)$

      + $cases(x'=0, y'=0)$
    ],
    solution: [
      + Unstable and repelling equilibrium at $x=0,y=0$.
      + Unstable and repelling equilibrium at $x=0,y=1/4$.
      + Unstable but not repelling equilibrium at $x=0,y=0$.
      + Stable and attracting equilibrium at $x= -sqrt(2), y=sqrt(2)$, and unstable and repelling equilibrium at $x=sqrt(2),y=-sqrt(2)$.
      + Infinitely many equilibrium solutions at $x=(pi n)/2, y=pi/2+pi m$ where $m,n in ZZ$. In fact, this system contains: stable and attracting, unstable and repelling, unstable and not repelling types of equilibrium solutions. It is up to the reader to find out the specific nature of each equilibrium solution. Hint: The next module will provide a visual representation of their natures using a very powerful tool (Phase Portraits).
      + Infinitely many unstable but not repelling equilibrium solutions at the line $y=-x$.
      + There are no equilibrium solutions to this system.
      + All solutions are constant.
    ]
  ),
  (
    statement: [
      Construct a system of differential equations with the following equilibrium solutions and classifications. Then justify your answer:

      + $(0,0)$ (unstable and repelling), $(1,1)$ (stable and attracting), $(1,0)$ and $(0,1)$ (unstable but not repelling).
      + $(1,2)$ (unstable but not repelling)
      + $(0,0)$ (stable but not attracting)
      + Infinitely many stable but not attracting equilibrium solutions on the line $x=0$.
      + No equilibrium solutions anywhere.
    ],
    solution: [
      Possible solutions:
      + $cases(x'=x(1-x), y'=y(1-y))$

      + $cases(x'=(x-1)^2, y'=2-y)$

      + $cases(x'=y, y'=-x)$

      + $cases(x'=-x, y'=0)$

      + $cases(x'=1, y'=2)$
    ],
  ),
  (
    statement: [
      Assume that a population of fish in a lake satisfies $(dif x)/(dif t) = k x (M − x)$. Now
      suppose that fish are continually added at $𝐴$ fish per unit of time.
      + Find the differential equation for $x$.
      + Find and classify the equilibrium point(s).
      + What is the new limiting population?
    ],
    solution: [
      + $(dif x)/(dif t) = k x (M - x) + A$, where $A$ is a parameter.
      + The equilibrium solution satisfy $(dif x)/(dif t) = k x (M - x) + A=0$, or equivalently $k x^2 - k M x - A=0$, therefore we have the equilibrium solution(s) at
      
      $x=(k M plus.minus sqrt((k M)^2 +4 A k))/(2 k)$. The classification can be obtained by plugging in the values of $x$ and checking the signs of $x'$ depending on the choice of the parameters $k, M,$ and $A$.
      + The new limiting population can be expressed as: $(k M + sqrt((k M)^2 +4 A k))/(2 k)$.
      ],
    citation: [_Notes on Diffy Q's_ by Jiří Lebl 1.6.103],
  ),
  // XXX: add a question asking for the first-degree Taylor approximation to a solution given initial conditions. And, how does this relate to the slope field?
  /*
  (
    statement: [
      Below is the phase space showing the path travelled by a bee when it ventured out of the hive this morning. Find and classify the equilibrium point, can you tell if the bee is attracted to a flower or running away from a predator?

    #align(center,
    lq.diagram(
    //legend: (position: bottom + right),
    title: [Phase Space],
    width: 4cm,
    range(4),
    //ylim: (-1, 5),
    //xlim: (-1, 5),
    lq.plot(path1.map(((x, y)) => x), path1.map(((x, y)) => y), mark: none, stroke: 1.5pt, color: red.darken(20%)),
    //lq.plot(As2, Bs2, mark: none, stroke: 1.5pt),
    //lq.plot(As3, Bs3, mark: none, stroke: 1.5pt),
    //xaxis: (label: [$X(t)$], tick-distance: calc.pi),
    xaxis: (label: [$S(t)$],
    ticks: pi_axis.map(rotate.with(0deg, reflow: false)).enumerate(),
    subticks: none),
    yaxis: (label: [$D(t)$], tick-distance: 1),
    ),
  )
    ]
  ),
  */
  (
    statement: [
      Suppose $x'$ is positive for $0<x<1$, it is zero when $x=0$ and $x=1$, and it is negative for
      all other values of $x$.

      + Find and classify the equilibrium points.
      + Use Euler's method to find the $lim_(t-> infinity)x(t)$ with the initial condition $x(0)=1$. What does this say about the stability of the equilibrium point?
      + Repeat part (b) with the initial condition $x(0)=0.5$.
    ],
    solution: [
      + Equilibrium solutions are $x=0, x=1$.
      + For $x(0)=1$, the limit $lim_(t-> infinity)x(t)=1$, since the initial condition is already at an equilibrium. It does not say much about the stability, as we are required to analyze the behaviour of the neighbourhood around this equilibrium point to determine its stability.
      + For $x(0)=0.5$, we find that the limit $lim_(t-> infinity)x(t)=1$. We can in fact determine that this equilibrium is attracting and stable.
    ],
    citation: [_Notes on Diffy Q's_ by Jiří Lebl 1.6.5],
  ),

  (
    statement: [
      Given the following differential equations, find the first order Taylor approximation of the solution with the given initial conditions. How do they relate to the slope field?

      + $x' = x$ with $x(0) = 1$
      + $y' = 0$ with $y(0) = 5$
      + $x' = x + 2$ with $x(0) = 3$
      + $y' = -t y$ with $y(0) = 2$

    ],
    solution: [
      + Notice that $x' = x$ indicates that this is an exponential function $x(t) = A e^t$ for $A in RR$. Since $x(0)=1$, then $x(t) = e^t$. The first order Taylor approximation is $x(t) approx 1 + t$. This is approximately the linear function of slope 1 with a y-intercept $x(0)=1$, which is the tangent line to the curve $x(t) = e^t$ at $t=0$. The following is the slope field of the differential equation. Same logic can be applied to the other differential equations.
      
      #{
        align(center, slope_field(
          (x, y) => y,
          xlim: (-1.125, 2.125),
          ylim: (-0.125, 2.125),
          width: 5cm,
          height: 5cm,
          spacing: .25,
          scale_segments: .25,
          yaxis: (position: 0, tip: tiptoe.stealth, tick-distance: 1.0),
          xaxis: (position: 0, tip: tiptoe.stealth, tick-distance: 1.0),
          xlabel: $t$,
          ylabel: lq.label($x$, dx: -0cm),
          lq.plot((-1, 0, 1), (0, 1, 2), mark: none, stroke: 1.5pt, z-index: 100),
          )
        )
      }

      #set enum(numbering: "(a)", start: 2)
      + $y(t) approx 5$.
      + $x(t) approx 3 + 5t$
      + $y(t) approx 2$.
    ]
  ),

)
