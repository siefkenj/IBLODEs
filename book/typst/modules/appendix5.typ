// This file is meant to be imported and not compiled on its own.
#import "../common/settings-book.typ": workbook, show_def
#import "../libs/_workbook.typ": simple_table, label_appendix
#let (sans, serif, module, definition, example, theorem) = workbook

#label_appendix(<app:reduction_of_order>)

This appendix is adapted from #link("https://www.jirka.org/diffyqs/")[Jiri Lebl's book "Notes on Diffy Qs"].

In general finding solutions to differential equations is difficult, if not impossible.

However, if we already know one solution to a differential equation, we can use that solution to simplify the differential equation and make it easier to find the other solutions. The method for doing this is called *reduction of order*.

This is an analgous procedure to finding the divisors of a number. For example if I want to find the divisors of 364 and I already know that 7 is a divisor, then I can divide 364 by 7 to get 52. 
Now I know that all the other divisors of 364 must also be divisors of 52, so I can focus on 52 (which is smaller and more manageable) instead of 364.

The idea is that if we somehow found $y_1$ as a solution of
$y'' + p(x) y' + q(x) y = 0$, then we could simplify this differential to a first order equation by assuming that a second solution is of the form $y_2(x) = y_1(x) v(x)$, where $v(x)$ is some function we need to find.

#example(
  prompt: [Find $y_2(x)$.],
  [
    We just need to find $v$. We plug $y_2$ into the equation:

    $ 
      0 = 
      y''_2 + p(x) y'_2 + q(x) y_2
      &= 
      (y''_1 v + 2 y'_1 v' + y_1 v'') 
      + p(x) (y'_1 v + y_1 v') 
      + q(x) (y_1 v) \
      &= 
      y_1 v'' 
      + (2 y'_1 + p(x) y_1) v' 
      + cancel((y''_1 + p(x) y'_1 + q(x) y_1)) v 
    $

    In other words,
    $y_1 v'' + (2 y'_1 + p(x) y_1) v' = 0$. Using $w = v'$, we have the
    first order linear equation
    $ y_1 w' + (2 y'_1 + p(x) y_1) w = 0. $
    
    To find the solution $y_2(x)$, we only need to solve this differential equation, which is a first-order differential equation in $w$.

     After solving this equation for $w$ (using integrating factor or separation of variables),
    we find $v$ by anti-differentiating $w$. We then form $y_2$ by computing $y_1 v$. 
    
    Since we have a formula for the solution to the first order linear equation, we can write a formula for $y_2$:
    $
      y_2(x) = y_1(x) integral( e^(-integral( p(x) d x ) ) / ( y_1(x)^2 ) d x ).
    $
  ]
)

Note that this formula is only valid for a linear second-order differential equation.

However, it is much easier to remember that we just need to try $y_2(x) =
y_1(x) v(x)$ and find $v(x)$ as we did above. Also, the technique
works for higher order equations too: You get to reduce the order for each solution you find. So it is better to remember how to do
it rather than a specific formula.



