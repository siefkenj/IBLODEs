#let questions = (
  (
    statement: [
      Find the power series solution to:

      + $y'=x$
      + $y''= plus.minus x$
      + $y'=2y$
      + $y''-x y=0$
    ],
    solution: [
      + $y(x)=A+x^2/2; A$ is a parameter.
      + $y(x)=A+B x plus.minus x^3/6; A,B$ are parameters.
      + $y(x)=a_0(1+2x+2x^2+4/3x^3+2/3x^4+4/15x^5+...); a_0$ is a parameter.#v(.7em)
      + $y(x)=a_0+a_1x+a_0/6x^3+a_1/12x^4+a_0/180x^6+...; a_0,a_1$ are parameters.#v(.7em)
    ],
  ),
  (
    statement: [
      Find the power series solution (with initial conditions) to:

      + $y'=x,y(0)=2$
      + $y'-x y=0, y(0)=1$
      + $y''+x y'+y=0, y(0)=1, y'(0)=0$
      + $y''-y=x, y(0)=0,y'(0)=1$
      + $x y''+(1-x)y'-y=0,y'(0)=y(0)=1$
    ],
    solution: [
      + $y(x)=2+x^2/2$
      + $y(x)=1+(x^2)/2+(x^4)/8+(x^6)/48+...$#v(.7em)
      + $y(x)=1-(x^2)/2+(x^4)/8-(x^6)/48+(x^8)/384-...$#v(.7em)
      + $y(x)=x+(x^3)/3+(x^5)/60+(x^7)/2520+...$#v(.7em)
      + $y(x)=1+x+(x^2)/2+x^3/6+x^4/24+...=e^x$
    ],
  ),
)
