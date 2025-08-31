#let questions = (
  (
    statement: [
      Guess a solution to $y'' + y' + y=5$.
    ],
    solution: [$y=5$],
    citation: [_Notes on Diffy Q's_ by Jiří Lebl 2.6.103]
  ),
  (
    statement: [
      Find the general solution to $x y'' + y' = 0$.
      _Hint: It is a first order ODE in $y'$._
    ],
    solution: [$y=C_1 ln(x) + C_2$#v(1em)],
    citation: [_Notes on Diffy Q's_ by Jiří Lebl 2.6.104]
  ),
  (
    statement: [
      Find and classify the equilibrium point(s) for the following equations:

      + $x''+x+x^3=0$
      + $theta '' + sin(theta)=0$
      + $z''+(z-1)(z+1)=0$
      + $x''+x^2+1=0$
    ],
    citation: [_Notes on Diffy Q's_ by Jiří Lebl 3.2.2]
  ),
  (
    statement: [
      For the equation $x^2 y''-x y'=0$. Find two solutions and show that they are linearly independent, then find the general solution.

      _Hint: Try $y=x^r$._
    ],
    citation: [_Notes on Diffy Q's_ by Jiří Lebl 2.6.5]
  ),
  (
    statement: [
      Find a particular solution to:

      $arrow(x)''= mat(-3, 1; 2, -2) arrow(x)+ mat(0;2)cos(2t)$
    ],
    citation: [_Notes on Diffy Q's_ by Jiří Lebl 2.7.3]
  ),
  (
    statement: [
      Find the general solution to:

      $mat(1, 0, 0; 0, 2, 0; 0, 0, 3)arrow(x)'' = mat(-3, 0, 0; 2, -4, 0; 0, 6, -3)arrow(x) + mat(cos(2t); 0; 0)$
    ],
    solution: [
      $arrow(x) = mat(1; -1; 1)(a_1 cos(t sqrt(3))+b_1 sin(t sqrt(3))) + $#v(0.5em)
      $mat(0; 1; -2)(a_2 cos(t sqrt(2)) + b_2 sin(t sqrt(2))) + $#v(0.5em)
      $mat(0; 0; 1)(a_3 cos(t)+b_3 sin(t)) + mat(-1; 1/2; 2/3)cos(2t)$#v(1em)
    ],
    citation: [_Notes on Diffy Q's_ by Jiří Lebl 2.7.101]
  ),
  (
    statement: [
      Suppose there are three carts of equal mass $m$ and connected by two springs of constant $k$ (and no connections to walls). Set up the system and find its general solution.
    ],
    solution: [
      - The system: $mat(m, 0, 0; 0, m, 0; 0, 0, m) arrow(x)''= mat(-k, k, 0; k, -2k, k; 0, k, -k) arrow(x)$

      - The solution: $arrow(x) = mat(1; -2; 1)(a_1 cos(t sqrt((3k)/m)) + $
      $b_1 sin(t sqrt((3k)/m)))+mat(1; 0; -1)(a_2 cos(t sqrt(k/m)) + $
      
      $b_2 sin(t sqrt(k/m))) + mat(1; 1; 1)(a_3 t+b_3)$
    ],
    citation: [_Notes on Diffy Q's_ by Jiří Lebl 2.7.102]
  )
)