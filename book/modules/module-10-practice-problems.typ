#import "../libs/lib.typ": *
#set align(center)
#set enum(spacing: .7em)
#show: e.prepare()
#show ref: allow_missing_refs

#let questions = (
  (
    statement: [
      A student is new to higher order differential equations, answer the following questions they have:

      + Is higher order differential equation simply one with derivative order greater than one?

      + What should be on the phase portrait? For example, what corresponds to which axis?

      + Wouldn't higher-order differential equations be non-linear? How are we able to find the eigenvalues?

      + Would the stability of equilibrium solution(s) change after conversion of higher-order to first-order differential equation?
    ],
    solution: [
      + Yes. For a differential equation involving only functions $y,y'$ it is a first-order differential equation. Whereas for one involving functions $y,y',dots,y^((n))$, it is a higher-order differential equation.

      + For an $n$-th order differential equation, we need to transform it to a $n times n$ system of first-order differential equations, so the phase portrait will have as axes, the unknown function and all its derivatives up to order $n−1$ (which are the auxiliary functions).
      
        We often use phase portrait to gain insight into the behaviour of solutions. This is especially useful when the phase space is two-dimensional, so this will be especially useful for 2nd-order differential equations, where the phase portrait will have the unknown function $u$ as the horizontal axis and its first derivative $u′$ as the vertical axis.

      + Order and linearity are different ideas. It is very helpful to convert higher-order differential equations into first-order differential equations. Then we can apply the eigenvalue approach. Linearization near an equilibrium can also help with dealing with non-linear expressions.

      + No, they are the same.
    ]
  ),
  (
    statement: [
      Guess a solution to $y'' + y' + y=5$.
    ],
    solution: [$y=5$],
    citation: [_Notes on Diffy Q's_ by Jiří Lebl 2.6.103],
  ),
  (
    statement: [
      Find the general solution to $x y'' + y' = 0$.
      _Hint: It is a first order ODE in $y'$._
    ],
    solution: [$y=C_1 ln|x| + C_2$, where $C_1,C_2$ are parameters.],
    citation: [_Notes on Diffy Q's_ by Jiří Lebl 2.6.104],
  ),
  (
    statement: [
      For the following second-order differential equations, simulate the solution to the initial conditions using Euler's method.

      + $y''=-4y-y'$, with $y(0)=1,y'(0)=0$ and a step size of $Delta=0.1$.
      + $x''-5x'+2x+6=0$, with $x(0)=2,x'(0)=1$, and a step size of $Delta=0.05$.
    ],
    solution: [
      + With $y(0)=1$ and $y'(0)=0$ and a step size of $Delta = 0.1$ gives us
        #let F(x, y) = (y, -4*x - y)
        #let sims = solve_2d_ivp(F, (1, 0), 6, Delta: 0.1)
        #let table = range(6).map(i => (i * .1, sims.at(i))).flatten()

        #align(center, simple_table(headers: ($t$, $y(t)$, $y'(t)$), content: table.map(
          v => [#calc.round(
              v,
              digits: 2,
            )
          ],
        )))
      + With $x(0)=2$ and $x'(0)=1$ and a step size of $Delta = 0.05$ gives us
        #let F(x, y) = (y, 5*y - 2*x -6)
        #let sims = solve_2d_ivp(F, (2, 1), 6, Delta: 0.05)
        #let table = range(6).map(i => (i * .05, sims.at(i))).flatten()

        #align(center, simple_table(headers: ($t$, $x(t)$, $x'(t)$), content: table.map(
          v => [#calc.round(
              v,
              digits: 2,
            )
          ],
        )))
    ]
  ),
  (
    statement: [
      Write the following third-order differential equation as a system of first order differential equations.

      $ u'''+2u'-(u')^2+e^u=cos(t) $

      Then simulate the solution to the initial conditions $u(0)=1,u'(0)=0,u''(0)=-1$ using Euler's Method, with a step size of $Delta=0.1$.
    ],
    solution: [
      Suppose that $u$ is a function of $t$. Let's introduce new functions $v_1(t)=u'(t), v_2(t)=u''(t)=v_1'(t)$, so $v_2(t)'=u'''(t)$. By substituting the new functions, our original differential equation becomes
      $ v_2'+2v_1-v_1^2+e^u=cos(t) $
      this means that the original differential equation is equivalent to
      $ cases(u'=v_1, v_1'=v_2, v_2'=v_1^2-2v_1-e^u+cos(t)) $

      Then follow @mod:simulation to simulate this third-order differential equation using Euler's Method.

      //XXX Manual values to be checked later
      #let values = (0, 1, 0, -1, 0.1, 1, -0.1, -1.171828183, 0.2, 0.99, -0.217182818, -1.323155949, 0.3, 0.968281718, -0.349498413, -1.446119337, 0.4, 0.933331877, -0.494110347, -1.531812654, 0.5, 0.883920842, -0.647291612, -1.570766775)
      #align(center, simple_table(headers: ($t$, $u(t)$, $v_1(t)=u'(t)$, $v_2(t)=u''(t)$), content: values.map(
          v => [#calc.round(
              v,
              digits: 2,
            )
          ],
        )))
    ]
  ),
  (
    statement: [
      For each of the following second order differential equations: convert them to first-order systems, find all equilibrium solution(s), and use linearization to classify the stability of each equilibrium.

      + $y''=-2y'-3 sin(y)$
      + $x''=sin(x)+2x+5x'$
      + $x''+cos(x)-2x'+3x-5=0$
      + $f''(t)-f(t)+6-7f'(t)=0$
    ],
    solution: [
      + Let $z=y'$, then $cases(y'=z,z'=-2z-3 sin(y))$. The equilibrium solution is located at $(n pi,0), n in ZZ$. The Jacobian is $ D_(arrow(F))(y,z)=mat(0,1;-3 cos(y),-2) $ evaluated at the equilibrium we get: 
        - Odd $n$: $D_(arrow(F))(arrow(E))=mat(0,1;3,-2)$ with eigenvalues $lambda_(o d d)=1,-3$ 
        - Even $n$: $D_(arrow(F))(arrow(E))=mat(0,1;-3,-2)$ with $lambda_(e v e n)=-1 plus.minus i sqrt(2)$.
        Therefore using linearization, we can classify equilibrium solutions $(n pi, 0)$ by: unstable but not repelling at odd $n$, and stable and attracting spirals at even $n$.
      + Let $y=x'$, then $cases(x'=y,y'=sin(x)+2x+5y)$. The equilibrium solution is at $(0,0)$. The Jacobian is $ D_(arrow(F))(x,y)=mat(0,1;cos(x)+2,5) $ evaluated at the equilibrium we get $D_(arrow(F))(arrow(E))=mat(0,1;3,5)$. This has eigenvalues $lambda=(5 plus.minus sqrt(37))/2$, hence this equilibrium solution is unstable but not repelling.
      + First $x''+cos(x)-2x'+3x-5=0 arrow.r.double x''=-cos(x)+2x'-3x+5$. Let $y=x'$, then $cases(x'=y,y'=-cos(x)+2y-3x+5)$. The equilibrium is located at $approx (1.7144,0)$. The Jacobian is $ D_(arrow(F))(x,y)=mat(0,1;sin(x)-3,2) $ evaluated at the equilibrium, we get $D_(arrow(F))(arrow(E))approx mat(0,1;-2.0103,2)$. This has eigenvalues $lambda approx 1 plus.minus i sqrt(1.0103)$, hence this equilibrium solution is unstable and repelling.
      + First $f''(t)-f(t)+6-7f'(t)=0 arrow.r.double f''(t)=f(t)-6+7f'(t)$. Let $g(t)=f'(t)$, then $cases(f'(t)=g(t), g'(t)=f(t)-6+7g(t))$. The equilibrium solution is located at $(6,0)$. The Jacobian is $ D_(arrow(F))(f(t),g(t))=mat(0,1;1,7) $, which is the same matrix when evaluated at the equilibrium. This matrix has eigenvalues $lambda=(7 plus.minus sqrt(53))/2$, hence this equilibrium is unstable but not repelling.
    ]
  ),
  (
    statement: [
      Find and classify the equilibrium point(s) for the following equations:

      + $x''+x+x^3=0$
      + $theta '' + sin(theta)=0$
      + $z''+(z-1)(z+1)=0$
      + $x''+x^2+1=0$
    ],
    solution: [
      Note: for all of these following questions, you should strongly consider the limitations of equilibrium classification using Linearization, see @mod:linearization.

      + Let $y=x'$, then $cases(x'=y,y'=-x-x^3)$. The equilibrium is located at $(0,0)$. Following linearization, we obtain the Jacobian $ D_(arrow(F))(x,y)=mat(0,1;-1-3x^2,0) $ evaluated at the equilibrium, the Jacobian is $D_(arrow(F))(arrow(E))= mat(0,1;-1,0)$, which has eigenvalues $lambda=plus.minus i$. This is a periodic solution (stable but not attracting).
      + Let $phi=theta'$, then $cases(theta'=phi,phi'=-sin(theta))$. The equilibrium is located at $(n pi,0), n in ZZ$. The Jacobian is $ D_(arrow(F))(theta,phi)=mat(0,1;-cos(theta),0) $
        - For odd $n$: $D_(arrow(F))(arrow(E))= mat(0,1;1,0)$, with eigenvalues $lambda_(o d d)=plus.minus 1$. These equilibrium solutions are unstable but not repelling.
        - For even $n$: $D_(arrow(F))(arrow(E))= mat(0,1;-1,0)$, with eigenvalues $lambda_(e v e n)=plus.minus i$. These equilibrium solutions are periodic, and are stable but not attracting.
      + Let $w=z'$, then $cases(z'=w,w'=-(z-1)(z+1))$. The equilibrium solutions are located at $(1,0),(-1,0)$. The Jacobian is $ D_(arrow(F))(z,w)=mat(0,1;-2z,0) $
        - For equilibrium solution at $(1,0)$, the Jacobian evaluated here is $D_(arrow(F))(arrow(E))= mat(0,1;-2,0)$, with eigenvalues $lambda_((1,0))=plus.minus i sqrt(2)$. This is a periodic solution (stable but not attracting).
        - For equilibrium solution at $(-1,0)$, the Jacobian evaluated here is $D_(arrow(F))(arrow(E))= mat(0,1;2,0)$, with eigenvalues $lambda_((-1,0))=plus.minus sqrt(2)$. This is an unstable but not repelling equilibrium.
      + Let $y=x'$, then $cases(x'=y,y'=-x^2-1)$. The equilibrium solution does not exist.
    ],
    citation: [_Notes on Diffy Q's_ by Jiří Lebl 3.2.2],
  ),
  (
    statement: [
      Consider the following higher-order differential equations:

      + $x'''+x''+x'+x=0$
      + $x^((5))+x^((4))+x'''+x''+x'+x=0$
      + $x^((n))+x^((n-1))+dots+x'''+x''+x'+x=0$

      For each:
      - Convert the equation into a system of first-order differential equations.
      - Find the corresponding matrix and eigenvalues.
    ],
    solution: [
      + Let $y=x'$, $z=y'=x''$. Then we have the system $ cases(x'=y,y'=z,z'=-z-y-x) $ with corresponding matrix $ mat(0,1,0;0,0,1;-1,-1,-1) $ and eigenvalues $lambda_1=-1, lambda_2=i, lambda_3=-i$.
      + Let $y=x'$, $z=y'=x''$, $w=z'=y''=x'''$, $v=w'=z''=y'''=x''''$. Then we have the system $ cases(x'=y,y'=z,z'=w,w'=v,v'=-v-w-z-y-x) $ with corresponding matrix $ mat(0,1,0,0,0;0,0,1,0,0;0,0,0,1,0;0,0,0,0,1;-1,-1,-1,-1,-1) $ with eigenvalues $lambda_1=-1, lambda_(2,3)=(-1 plus.minus i sqrt(3))/2, lambda_(4,5)=(1 plus.minus i sqrt(3))/2$.
      + We are free to choose the notation of the new functions. For example, let $x_1=x', x_2=x_1'=x'',dots x_(n-1)=x_(n-2)'=dots=x^((n-1))$. Then we have the system
        $ cases(x'=x_1,x_1'=x_2, dots.v ,x'_(n-2)=x_(n-1),x'_(n-1)=-x_(n-1)-dots-x_2-x_1-x) $
      corresponding to the matrix $ mat(0,1,0,dots,0;0,0,1,dots,0;dots.v,dots.v,dots.v,dots.down,dots.v;-1,-1,-1,dots,-1) $
      with eigenvalues $lambda_j=e^((2 pi i j)/(n+1))$ for $j=1,...,n$.
    ]
  ),
  (
    statement: [
      For the equation $x^2 y''-x y'=0$. Find two solutions and show that they are linearly
      independent, then find the general solution.

      _Hint: Try $y=x^r$._
    ],
    solution: [
      Assuming that $x>0$ (you might check what happens otherwise). Let $y=x^r$ for some finite parameter $r$. Then the equation becomes $r(r-1)x^r-r x^r=x^r (r^2-2r)=0$. Since $x^r !=0$ for finite $r$. Then $(r^2-2r)=0$ implies $r=0$ or $r=2$.

      Hence two solutions are $y_1(x)=1$ and $y_2(x)=x^2$.

      To check they are linearly independent, suppose we have parameters $alpha,beta$, such that
      $ alpha y_1+beta y_2=0 arrow.l.r.double alpha+beta x^2=0 $
      this is possible if and only if $alpha=beta=0$ for all values of $x$.

      The general solution is therefore $ y(x)=C_1 x^2+C_2 $ for some parameters $C_1,C_2$.

      Note: this type of ODEs is called Cauchy-Euler differential equations.
    ],
    citation: [_Notes on Diffy Q's_ by Jiří Lebl 2.6.5],
  ),
  (
    statement: [
      Find a particular solution to:

      $arrow(x)''= mat(-3, 1; 2, -2) arrow(x)+ mat(0; 2)cos(2t)$
    ],
    solution: [
      You may combine this module with @mod:affine to find a particular solution
      $ arrow(x)_p(t)=vec(-2/9 cos(2t)-1/6 t sin(2t),-4/9 cos(2t)+1/6 t sin(2t)) $
    ],
    citation: [_Notes on Diffy Q's_ by Jiří Lebl 2.7.3],
  ),
  (
    statement: [
      Find the general solution to:

      $mat(1, 0, 0; 0, 2, 0; 0, 0, 3)arrow(x)'' = mat(-3, 0, 0; 2, -4, 0; 0, 6, -3)arrow(x) + mat(cos(2t); 0; 0)$
    ],
    solution: [
      $arrow(x) = mat(1; -1; 1)(a_1 cos(t sqrt(3))+b_1 sin(t sqrt(3))) +$#v(0.5em)
      $mat(0; 1; -2)(a_2 cos(t sqrt(2)) + b_2 sin(t sqrt(2))) +$#v(0.5em)
      $mat(0; 0; 1)(a_3 cos(t)+b_3 sin(t)) + mat(-1; 1/2; -1/3)cos(2t)$#v(1em)
    ],
    citation: [_Notes on Diffy Q's_ by Jiří Lebl 2.7.101],
  ),
  (
    statement: [
      Suppose there are three carts of equal mass $m$ and connected by two springs of constant $k$
      (and no connections to walls). Set up the system and find its general solution.
    ],
    solution: [
      - The system:
        $mat(m, 0, 0; 0, m, 0; 0, 0, m) arrow(x)''= mat(-k, k, 0; k, -2k, k; 0, k, -k) arrow(x)$

      - The solution: $arrow(x) = mat(1; -2; 1)(a_1 cos(t sqrt((3k)/m)) +$
      $b_1 sin(t sqrt((3k)/m)))+mat(1; 0; -1)(a_2 cos(t sqrt(k/m)) +$

      $b_2 sin(t sqrt(k/m))) + mat(1; 1; 1)(a_3 t+b_3)$
    ],
    citation: [_Notes on Diffy Q's_ by Jiří Lebl 2.7.102],
  ),
  (
    statement: [
      For the following higher-order differential equations (or system), find the corresponding system of first-order differential equations, the equilibrium solution(s) and their classifications, and the general solution.

      + $x'''+4x'+x=0$
      + $y'''+4y''+5y'+2y=0$
      + $y^((4))+3y'''+5y''+y'-10y=0$
      + $y^((4))+4y'''+6y''+4y'+y=16$
      
      + $cases(x''=y,y''=x)$
    ],
    solution: [
      + Let $x_1=x',x_2=x_1'=x''$, then $ cases(x'=x_1,x_1'=x_2,x_2'=-4 x_1 -x) $ the equilibrium solution is at $(0,0,0)$ and is unstable but not repelling. The general solution is $ x(t)approx C_1e^(-0.2463t) +(C_2 cos(2.0123t)+C_3 sin(2.0123t))e^(0.1231t) $ where $C_1,C_2,C_3$ are parameters.
      + Let $z=y',w=z'=y''$, then $ cases(y'=z,z'=w,w'=-4w-5z-2y) $ the equilibrium is at $(0,0,0)$ and is stable and attracting. The general solution is $ y(t)=(C_1 +C_2 t)e^(-t) +C_3e^(-2t) $ where $C_1,C_2,C_3$ are parameters.
      + Let $z=y',w=z'=y'',u=w'=y'''$, then $ cases(y'=z,z'=w,w'=u,u'=-3u-5w-z+10y) $ with equilibrium at $(0,0,0,0)$ that is unstable but not repelling. The general solution is $ y(t)=C_1e^t +C_2e^(-2t) +e^(-t) (C_3 cos(2t)+C_4 sin(2t)) $ where $C_1,C_2,C_3,C_4$ are parameters.
      + Let $z=y',w=z'=y'',u=w'=y'''$, then $ cases(y'=z,z'=w,w'=u,u'=-4u-6w-4z-y+16) $ the equilibrium solution is located at $(16,0,0,0)$ that is stable and attracting. The general solution is $ y(t)=(C_1 +C_2 t+C_3 t^2 + C_4 t^3)e^(-t) + 16 $ where $C_1,C_2,C_3,C_4$ are parameters.
      + Let $u=x',v=y'$. Then we have $ cases(x'=u,u'=y,y'=v,v'=x) $ with equilibrium solution at $(0,0,0,0)$ that is unstable but not repelling. The general solution is
        $ arrow(r)(t)=vec(x(t),y(t))=vec(1,1)(C_1e^t+C_2e^(-t)) $$ +vec(1,-1)(C_3 cos(t)+C_4 sin(t)) $ where $C_1,C_2,C_3,C_4$ are parameters.
    ]
  ),
  (
    statement: [
      For the following matrices, write the corresponding third-order differential equation and find the general solution.

      + $vec(x'_1,x'_2,x'_3)=mat(0, 1, 0; 0, 0, 1; -6, -11, -6)vec(x_1,x_2,x_3)$, with $x_1=y,x_2=y',x_3=y''$

      + $vec(x'_1,x'_2,x'_3)=mat(0,1,0;0,0,1;-4,-4,-1)vec(x_1,x_2,x_3)$, with $x_1=y,x_2=y',x_3=y''$

      + $vec(x'_1,x'_2,x'_3)=mat(0,1,0;0,0,1;8,-12,6)vec(x_1,x_2,x_3)$, with $x_1=y,x_2=y',x_3=y''$

      + $vec(x'_1,x'_2,x'_3)=mat(0,1,0;0,0,1;-6,-11,-6)vec(x_1,x_2,x_3)+vec(0,0,12)$, with $x_1=y,x_2=y',x_3=y''$
    ],
    solution: [
      + $cases(x_1'=x_2,x_2'=x_3,x_3'=-6x_1 -11x_2 -6x_3)$, therefore the corresponding third-order differential equation is $ y'''=-6y-11y'-6y'' $ The matrix has eigenvalues $lambda=-1,-2,-3$, then the general solution is $ y(t)=C_1e^(-t)+C_2e^(-2t)+C_3e^(-3t) $ where $C_1,C_2,C_3$ are parameters.
      + $cases(x_1'=x_2,x_2'=x_3,x_3'=-4x_1 -4x_2 -x_3)$, corresponding to $ y'''=-4y-4y'-y'' $ The matrix has eigenvalues $lambda=-1, plus.minus 2i$. The general solution is $ y(t)=C_1e^(-t)+C_2 cos(2t)+C_3 sin(2t) $ where $C_1,C_2,C_3$ are parameters.
      + $cases(x_1'=x_2,x_2'=x_3,x_3'=8x_1 -12x_2 +6x_3)$, corresponding to $ y'''=8y-12y'+6y'' $ The matrix has eigenvalue $lambda=2$, with multiplicity 3, so we include powers of $t$. Then the general solution is $ y(t)=(C_1+C_2 t+C_3 t^2)e^(2t) $ where $C_1,C_2,C_3$ are parameters.
      + $cases(x_1'=x_2,x_2'=x_3,x_3'=-6x_1 -11x_2 -6x_3 +12)$, corresponding to $y'''=-6y-11y'-6y''+12$. The general solution is $ y(t)=C_1e^(-t)+C_2e^(-2t) +C_3e^(-3t)+2 $ where $C_1,C_2,C_3$ are parameters.
    ]
  ),
  (
    statement: [
      A fellow classmate is currently working on the following higher order differential equations

      $ y^((3))+3y''+3y'+y=0; y(0)=1,y'(0)=0,y''(0)=2 $

      They claim that:
      + The equation is of the form $r^3+3r^2+3r+1$, so we can solve for this because $r^3+3r^2+3r+1=(r+1)^3=0$.
      + The corresponding system of first-order differential equations is
        $ cases(y'=y_1,y_1'=y_2,y_2'=3y_2+3y_1+y) $and its matrix is $ mat(0,1,0;0,0,1;3,3,1) $
      + The equilibrium solution is along the line $y'(t)=1/3 y(t)$.
      + The eigenvalues are $lambda approx 2.5987, -0.7993 plus.minus 0.7180i$, so the equilibrium solution is unstable but repelling.
      + The general solution is $ y(t)= e^(2.5987t)+e^(-0.7993 + 0.7180i t)+e^(-0.7993- 0.7180i t) $

      Do you agree with their response? If not, justify your answer.
    ],
    solution: [
      + The characteristic polynomial is valid.
      + The error lies with the coefficients and their signs. Also, the student should first define $y_1(t)=y'(t)$, and $y_2(t)=y'_1(t)=y''(t)$. Then we get
        $ cases(y'=y_1,y_1'=y_2,y_2'=-3y_2 -3y_1-y) $and the corresponding matrix is $ mat(0,1,0;0,0,1;-1,-3,-3) $
      + Equilibrium is at $(0,0,0)$.
      + The eigenvalue is $lambda=-1$ with multiplicity 3. It is stable and attracting.
      + The general solution is $y(t)=(C_1+C_2 t+C_3 t^2)e^(-t)$ where $C_1,C_2,C_3$ are parameters. Evaluated at the given initial conditions, we get $C_1=1,C_2=1,C_3=3/2$. Hence we have $ y(t)=(1+t+3/2 t^2)e^(-t) $
    ]
  ),
  (
    statement: [
      For a second-order differential equation of the form $x''=alpha x+beta x'$, where $alpha, beta$ are parameters.

      + Convert to a system of first-order differential equations.
      + Show that to classify the equilibrium solution, you only need to compute the eigenvalues (assuming they are distinct) of the matrix. You don't need to compute the eigenvectors.
      + What happens for the following values of the parameters:
        - $alpha=beta=0$
        - $alpha=0,beta!=0$
        - $alpha=-beta^2/4$
    ],
    solution: [
      + By introducing a new function $y$, where $y=x'$, we can convert this to a system of first-order differential equations $ cases(x'=y,y'=alpha x+beta y) $and the corresponding matrix is $ M=mat(0,1;alpha,beta) $
    ]
  ),
)
