// This file is meant to be imported and not compiled on its own.
#import "../common/settings-book.typ": workbook, show_def
#import "../libs/_workbook.typ": simple_table, label_appendix
#let (sans, serif, module, definition, example, theorem) = workbook

#label_appendix(<app:integrating_factor>)

This appendix is adapted from #link("https://www.jirka.org/diffyqs/")[Jiri Lebl's book "Notes on Diffy Qs"].


One of the most important types of equations we will learn to solve are the so-called *linear equations*. In fact, the majority of the course is about linear equations. In this section we focus on the *first order linear equation*. 
A first order equation is linear if we can put it into the form:
$ y' + p(x) y = f(x) . $
The word "linear" means linear in $y$ and $y'$; no higher powers nor functions of $y$ or $y'$ appear. 
The dependence on $x$ can be more complicated.

Solutions of linear equations have nice properties. For example, the solution exists wherever $p(x)$ and $f(x)$ are defined, and has essentially the same regularity (read: it is just as nice). But most importantly for us right now, there is a method for solving linear first order equations.

The trick is to rewrite the left-hand side of $y' + p(x) y = f(x)$ as a derivative of a product of $y$ with another function.
To this end, we find a function $r(x)$ such that 
$ r(x) y' + r(x) p(x) y = d/(d x) [ r(x) y ] . $
This is the left-hand side of $y' + p(x) y = f(x)$ multiplied by $r(x)$. If we multiply $y' + p(x) y = f(x)$ by $r(x)$, we obtain 
$ d/(d x) [ r(x) y ] = r(x) f(x) . $
We can now integrate both sides, which we can do as the right-hand side does not depend on $y$ and the left-hand side is written as a derivative of a function. After the integration, we solve for $y$ by dividing by $r(x)$.
The function $r(x)$ is called the *integrating factor* and the method is called the *integrating factor method*.

We are looking for a function $r(x)$, such that if we differentiate it, we get the same function back multiplied by $p(x)$.
That seems like a job for the exponential function! Let 
$ r(x) = e^( integral p(x) d x ) . $
We compute:
$ y' + p(x) y &= f(x) , \
 e^( integral p(x) d x ) y' + e^( integral p(x) d x ) p(x) y &= e^( integral p(x) d x ) f(x) , \
 d/(d x) [ e^( integral p(x) d x ) y ] &= e^( integral p(x) d x ) f(x) , \
 e^( integral p(x) d x ) y &= integral e^( integral p(x) d x ) f(x) d x + C , \
 y &= e^( - integral p(x) d x ) ( integral e^( integral p(x) d x ) f(x) d x + C ) . $

Of course, to get a closed form formula for $y$, we need to be able to find a closed form formula for the integrals appearing above.

#example(
  prompt: [
  Solve
  $ y' + 2 x y = e^( x - x^2 ), quad y(0) = -1 . $],
  [
  First note that $p(x) = 2 x$ and $f(x) = e^( x - x^2 )$.
  The integrating factor is $r(x) = e^( integral p(x) d x ) = e^( x^2 )$.
  We multiply both sides of the equation by $r(x)$ to get
  $ e^( x^2 ) y' + 2 x e^( x^2 ) y &= e^( x - x^2 ) e^( x^2 ) , \
   d/(d x) [ e^( x^2 ) y ] &= e^x . $
  We integrate
  $ e^( x^2 ) y &= e^x + C , \
   y &= e^( x - x^2 ) + C e^( - x^2 ) . $
  Next, we solve for the initial condition $-1 = y(0) = 1 + C$, so $C = -2$.
  The solution is
  $ y = e^( x - x^2 ) - 2 e^( - x^2 ) . $
  ]
)

Note that we do not care which antiderivative we take when computing $e^( integral p(x) d x )$. You can always add a constant of integration, but those constants will not matter in the end.


*_Exercise:_* 
  Try it! Add a constant of integration to the integral in the integrating factor and show that the solution you get in the end is the same as what we got above.


Advice: Do not try to remember the formula for $y$ itself, that is way too hard. It is easier to remember the process and repeat it.

Since we cannot always evaluate the integrals in closed form, it is useful to know how to write the solution in definite integral form. A definite integral is something that you can plug into a computer or a calculator. Suppose we are given 
$ y' + p(x) y = f(x) , quad y(x_0) = y_0 . $
Look at the solution and write the integrals as definite integrals.
$ y(x) = e^( - integral_( x_0 )^x p(s) d s ) ( integral_( x_0 )^x e^( integral_( x_0 )^t p(s) d s ) f(t) d t + y_0 ) . $
You should be careful to properly use dummy variables here. If you now plug such a formula into a computer or a calculator, it will be happy to give you numerical answers.

*_Exercise:_* Check that $y(x_0) = y_0$ in formula above.


*_Exercise:_* Write the solution of the following problem   as a definite integral, but try to simplify as far as you can. You will not   be able to find the solution in closed form.
  $ y' + y = e^( x^2 - x ), quad y(0) = 10 . $


*_Remark:_*   Before we move on, we should note some interesting properties of linear equations. First, for the linear initial value problem $y' + p(x) y = f(x)$, $y(x_0) = y_0$, there is an explicit formula above for the solution. Second, it follows from the formula above that if $p(x)$ and $f(x)$ are continuous on some interval $(a, b)$, then the solution $y(x)$ exists and is differentiable on $(a, b)$. Compare with the simple nonlinear example we have seen previously, $y' = y^2$, and compare to the Picard-Lindelöf Theorem (#link("https://en.wikipedia.org/wiki/Picard-Lindelof_theorem")).


#example(
  prompt: [
  Let us discuss a common simple application of linear equations.
  Real life applications of this type of problem include figuring out the concentration of chemicals in bodies of water (rivers and lakes).

XXX

  // mywrapfigsimp is a custom LaTeX macro, so convert to a comment or image placeholder
  // #mywrapfigsimp(1.60in, 1.65in)
  // \inputpdft{lin-tank}
  // (Insert figure: lin-tank.pdf)

  A 100 litre tank contains 10 kilograms of salt dissolved in 60 litres of water. Solution of water and salt (brine) with concentration of 0.1
  kilograms per litre is flowing in at the rate of 5 litres a minute. The solution in the tank is well stirred and flows out at a rate of 3 litres a minute.
  How much salt is in the tank when the tank is full?  ],
  [
  Let us come up with the equation. Let $x$ denote the kilograms of salt in the tank,   let $t$ denote the time in minutes. For a small change $Delta t$ in time, the change in $x$ (denoted $Delta x$) is approximately
  $ Delta x approx ("rate in" dot "concentration in") Delta t - ("rate out" dot "concentration out") Delta t . $
  Dividing through by $Delta t$ and taking the limit $Delta t arrow 0$, we see that
  $ (d x)/(d t) = ("rate in" dot "concentration in") - ("rate out" dot "concentration out") . $
  In our example,
  $ "rate in" &= 5 , \
   "concentration in" &= 0.1 , \
   "rate out" &= 3 , \
   "concentration out" &= x/("volume") = x/(60 + (5 - 3) t ) . $
  Our equation is, therefore,
  $ (d x)/(d t) = (5 dot 0.1) - (3 x / (60 + 2 t)) . $
  Or in the form $y' + p(x) y = f(x)$,
  $ (d x)/(d t) + (3 / (60 + 2 t)) x = 0.5 . $

  Let us solve. The integrating factor is
  $ r(t) = exp( integral 3 / (60 + 2 t) d t ) = exp( (3 / 2) ln(60 + 2 t) ) = (60 + 2 t)^( 3 / 2 ) . $
  We multiply both sides of the equation to get
  $ (60 + 2 t)^( 3 / 2 ) (d x)/(d t) + (60 + 2 t)^( 3 / 2 ) (3 / (60 + 2 t)) x &= 0.5 (60 + 2 t)^( 3 / 2 ) , \
   d/(d t) [ (60 + 2 t)^( 3 / 2 ) x ] &= 0.5 (60 + 2 t)^( 3 / 2 ) , \
   (60 + 2 t)^( 3 / 2 ) x &= integral 0.5 (60 + 2 t)^( 3 / 2 ) d t + C , $
  So
  $ x &= (60 + 2 t)^( -3 / 2 ) integral (60 + 2 t)^( 3 / 2 ) / 2 d t + C (60 + 2 t)^( -3 / 2 ) , \
   x &= (60 + 2 t)^( -3 / 2 ) (1 / 10) (60 + 2 t)^( 5 / 2 ) + C (60 + 2 t)^( -3 / 2 ) , \
   x &= (60 + 2 t) / 10 + C (60 + 2 t)^( -3 / 2 ) . $

  //mbxSTARTIGNORE
  // #mywrapfig(3.25in)
  // \capstart
  // \diffyincludegraphics{width=3in}{width=4.5in}{linear-salt-graph}
  // \caption{Graph of the solution $x$ kilograms of salt in the tank at time $t$.\label{linear-salt-graph:fig}}
  //mbxENDIGNORE
  // (Insert figure: linear-salt-graph)

  To find $C$, note that at $t = 0$, we have $x = 10$. That is,
  $ 10 = x(0) = 60 / 10 + C (60)^( -3 / 2 ) = 6 + C (60)^( -3 / 2 ) , $
  or
  $ C = 4 (60^( 3 / 2 )) approx 1859.03 . $

  We know $5$ litres per minute are flowing in and $3$ litres per minute are flowing out, so the volume is increasing by $2$ litres a minute.
  So the tank is full when $60 + 2 t = 100$, or when $t = 20$.
  We are interested in the value of $x$ when the tank is full, that is we want to compute $x(20)$:
  $ x(20) &= (60 + 40) / 10 + C (100)^( -3 / 2 ) \
    &approx 10 + 1859.03 (100)^( -3 / 2 ) approx 11.86 . $
  There are 11.86 kg of salt in the tank when it is full.
  See the figure for the graph of $x$ over $t$. XXX

  The concentration when the tank is full is approximately
  $11.86 / 100 = 0.1186$ kg/litre, and we started
  with $1 / 6$ or approximately 0.1667 kg/litre.

  XXX Figure
  //mbxlatex \begin{myfig}
  //mbxlatex \capstart
  //mbxlatex \diffyincludegraphics{width=3in}{width=4.5in}{linear-salt-graph}
  //mbxlatex \caption{Graph of the solution $x$ kilograms of salt in the tank at time $t$.\label{linear-salt-graph:fig}}
  //mbxlatex \end{myfig}
  ]
)

In the practice problems, feel free to leave answer as a definite integral if a
closed form solution cannot be found. If you can find a closed form
solution, you should give that.
