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
      Suppose $y_1$ is a solution to $y'' + p(x) y' + q(x) y = 0$. By directly plugging into the equation, show that
      $
        y_2(x) = y_1(x) integral( e^(-integral( p(x) d x ) ) / ( y_1(x)^2 ) d x )
      $
      is also a solution.
    ],
  ),
  (
    statement: [
      Take $2 x^2 y'' + x y' - 3 y = 0$ for $x>0$.
      + Show that $y=1/x$ is a solution.
      + Use reduction of order to find a second linearly independent solution.
      + Write down the general solution.
    ],
  ),
  (
    statement: [
      (Chebyshev's equation of order 1) 
      Take $(1-x^2) y''-x y' + y = 0$.
      + Show that $y=x$ is a solution.
      + Use reduction of order to find a second linearly independent solution.
      + Write down the general solution.
    ],
  ),
  (
    statement: [
      (Hermite's equation of order 2) 
      Take $y''-2 x y' + 4 y = 0$.
      + Show that $y=1-2x^2$ is a solution.  
      + Use reduction of order to find a second linearly independent solution.
        (It's OK to leave a definite integral in the formula.)
      + Write down the general solution.
    ],
  ),
  (
    statement: [
      Take $(2-x)y'''  + (2 x-3)y'' - x y' + y=0$ for $x<2$.
      + Show that $y=e^x$ is a solution.
      + Use reduction of order to reduce this differential equation to a lower order differential equation.
      + Write down the general solution.
      + Why did we need the condition $x<2$?

      // - $z = e^x v(x)$
      // - $z' = e^x (v' + v)$
      // - $z'' = e^x (v'' + 2v' + v)$
      // - $z''' = e^x (v''' + 3v'' + 3v' + v)$

      // Then we can substitute these expressions into the original equation to obtain a second-order differential equation for $v(x)$.
      // $ (2-x) e^x (v''' + 3v'' + 3v' + v) + (2 x-3) e^x (v'' + 2v'+v) - x e^x (v' + v) + e^x v = 0 $
      
      // We re-organize this equation to get:
      // $ cancel(((2-x) e^x + (2 x - 3) e^x) - x e^x + e^x) v + (2-x) e^x (v''' + 3v'' + 3v') + (2 x-3) e^x (v'' + 2v') - x e^x v' = 0 $

      // This simplifies to:
      // $ (2-x) (v''' + 3v'' + 3v') + (2 x-3) (v'' + 2v') - x v' = 0 $

      // Which can be written as:
      // $ (2-x) v''' + (3-x) v'' = 0 $

      // If we let $w = v''$, then we have a first-order linear equation:
      // $ (2-x) w' + (3-x) w = 0 $.
    ],
  ),
)