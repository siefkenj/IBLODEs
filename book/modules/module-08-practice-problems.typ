#import "../libs/lib.typ": *
#set align(center)
#set enum(spacing: .7em)

#let questions = (
  (
    statement: [Find the eigenvalues and solve $cases(x'_1=x_2, x'_2=-x_1)$.],
    solution: [
      Eigenvalues: $plus.minus i$

      Solution: $arrow(x)= C_1 mat(cos(t); -sin(t)) + C_2 mat(sin(t); cos(t))$ where $C_1,C_2$ are parameters.
    ],
    citation: [_Notes on Diffy Q's_ by Jiří Lebl 2.4.104],
  ),
  (
    statement: [
      Suppose that $arrow(x)' = A arrow(x)$, where $A$ is a 2 by 2 matrix with eigenvalues
      $2 plus.minus i$. Describe the behaviour.
    ],
    solution: [
      It has a spiral source.
    ],
    citation: [_Notes on Diffy Q's_ by Jiří Lebl 2.5.102],
  ),
  (
    statement: [Compute the eigenvalues and eigenvectors of

      $A = mat(1, 1; -1, 0)$. Then solve the system $arrow(x)' = A arrow(x)$.],
    solution: [For $A = mat(1, 1; -1, 0)$:
      - The eigenvalues are: $(1 + i sqrt(3))/2,(1 - i sqrt(3))/2$.

        The eigenvectors are: $mat(-2; 1 - i sqrt(3)), mat(-2; 1 + i sqrt(3))$#v(.7em)

      - $arrow(x) = C_1 e^(t/2) mat(-2 cos((t sqrt(3))/2); cos((t sqrt(3))/2) + sqrt(3) sin((t sqrt(3))/2)) + C_2 e^(t/2) mat(-2 sin((t sqrt(3))/2); sin((t sqrt(3))/2) - sqrt(3) cos((t sqrt(3))/2))$
    ],
    citation: [_Notes on Diffy Q's_ by Jiří Lebl 2.4.102],
  ),
  (
    statement: [
      For the following eigenvalues and their respective eigenvectors, find the complex general solution, and classify the stability of equilibrium.

      + $lambda_1=2+i, lambda_2=2-i$, $arrow(v)_1=vec(1,i), arrow(v)_2=vec(1,-i)$

      + $lambda_1=-73i, lambda_2=73i$, $arrow(v)_1=vec(1,i), arrow(v)_2=vec(1,-i)$

      + $lambda_1=5-i, lambda_2=5+i$, $arrow(v)_1=vec(1-i,2+i), arrow(v)_2=vec(1+i,2-i)$

      + $lambda_1=-11-3i, lambda_2=-11+3i$, $arrow(v)_1=vec(-6+i,1), arrow(v)_2=vec(-6-i,1)$
    ],
    solution: [
      + $arrow(r)(t)=A vec(1,i)e^((2+i)t)+B vec(1,-i)e^((2-i)t)$, where $A,B$ are parameters. Unstable and Repelling spiral.

      + $arrow(r)(t)=A vec(1,i)e^(-73i t)+ B vec(1,-i)e^(73i t)$, where $A,B$ are parameters. Stable but not Attracting (periodic solutions).

      + $arrow(r)(t)=A vec(1-i,2+i)e^((5-i)t)+ B vec(1+i,2-i)e^((5+i)t)$, where $A,B$ are parameters. Unstable and Repelling spiral.

      + $arrow(r)(t)=A vec(-6+i,1)e^((-11-3i)t)+ B vec(-6-i,1)e^((-11+3i)t)$, where $A,B$ are parameters. Stable and Attracting spiral.
    ]
  ),
  (
    statement: [
      For each of the following systems in matrix form:
      - Find the eigenvalues and eigenvectors.
      - Find and classify the equilibrium solution(s)
      - Sketch their phase portraits.

      + $A= mat(1,0;0,2)$

      + $B= mat(1,2;3,4)$
      
      + $C= mat(45,60;1,2)$

      + $D= mat(-1,-1;5,-2)$

      + $E= mat(-1,-50;5,2)$

      + $F= mat(1,0;0,-2)$
    ],
    solution: [
      + $lambda_1=1,lambda_2=2, arrow(v)_1=vec(1,0), arrow(v)_2=vec(0,1)$. Equilibrium solution is located at $(x,y)=(0,0)$ and is Unstable and Repelling.#{
        let F(x,y)=(x, 2*y)
        vector_field(
                      F,
                      xlim: (-2, 2.5),
                      ylim: (-2, 2.5),
                      spacing: (.25, .25),
                      scale_segments: 25.0,
                      width: 6cm,
                      height: 5cm,
                      xaxis: (position: 0, tip: tiptoe.stealth, subticks: none, ticks: none),
                      yaxis: (position: 0, tip: tiptoe.stealth, subticks: none, ticks: none),
                    )
      }

      + $lambda_1=(5 + sqrt(33))/2,lambda_2=(5 - sqrt(33))/2, arrow(v)_1=vec(-3+sqrt(33),6), arrow(v)_2=vec(-3-sqrt(33),6)$. Equilibrium solution is at $(x,y)=(0,0)$ and is Unstable but not Repelling.#{
        let F(x,y)=(x+2*y, 3*x+4*y)
        vector_field(
                      F,
                      xlim: (-2, 2),
                      ylim: (-2, 2),
                      spacing: (.25, .25),
                      scale_segments: 25.0,
                      width: 6cm,
                      height: 5cm,
                      xaxis: (position: 0, tip: tiptoe.stealth, subticks: none, ticks: none),
                      yaxis: (position: 0, tip: tiptoe.stealth, subticks: none, ticks: none),
                    )
      }

      + $lambda_1=(47+sqrt(2089))/2, lambda_2=(47-sqrt(2089))/2, arrow(v)_1=vec(43+sqrt(2089),2), arrow(v)_2=vec(43-sqrt(2089),2)$. Equilibrium is at $(x,y)=(0,0)$, and is Unstable and Repelling.#{
        let F(x,y)=(45*x+60*y, x+2*y)
        vector_field(
                      F,
                      xlim: (-2, 2),
                      ylim: (-2, 2),
                      spacing: (.125, .125),
                      scale_segments: 1.5,
                      width: 6cm,
                      height: 5cm,
                      xaxis: (position: 0, tip: tiptoe.stealth, subticks: none, ticks: none),
                      yaxis: (position: 0, tip: tiptoe.stealth, subticks: none, ticks: none),
                    )
      }

      + $lambda_1=(-3+i sqrt(19))/2, lambda_2=(-3-i sqrt(19))/2, arrow(v)_1=vec(1+i sqrt(19), 10), arrow(v)_2=vec(1-i sqrt(19), 10)$. Equilibrium is at $(x,y)=(0,0)$ and is a Stable and Attracting Spiral.#{
        let F(x,y)=(-x - y, 5*x - 2*y)
        vector_field(
                      F,
                      xlim: (-2, 2),
                      ylim: (-2, 2),
                      spacing: (.25, .25),
                      scale_segments: 10.0,
                      width: 6cm,
                      height: 5cm,
                      xaxis: (position: 0, tip: tiptoe.stealth, subticks: none, ticks: none),
                      yaxis: (position: 0, tip: tiptoe.stealth, subticks: none, ticks: none),
                    )
      }

      + $lambda_1=(1+ i sqrt(991))/2,lambda_2=(1- i sqrt(991))/2, arrow(v)_1=vec(-3+i sqrt(991), 10), arrow(v)_2=vec(-3-i sqrt(991), 10)$. Equilibrium is at $(x,y)=(0,0)$ and is Unstable and Repelling Spiral. #{
        let F(x,y)=(-x - 50*y, 5*x + 2*y)
        vector_field(
                      F,
                      xlim: (-2, 2),
                      ylim: (-2, 2),
                      spacing: (.25, .25),
                      scale_segments: 1.25,
                      width: 6cm,
                      height: 5cm,
                      xaxis: (position: 0, tip: tiptoe.stealth, subticks: none, ticks: none),
                      yaxis: (position: 0, tip: tiptoe.stealth, subticks: none, ticks: none),
                    )
      }

      + $lambda_1=-2, lambda_2=1, arrow(v)_1=vec(0,1), arrow(v)_2=vec(1,0)$. Equilibrium is at $(x,y)=(0,0)$ and is Unstable but not Repelling. #{
        let F(x,y)=(x, -2*y)
        vector_field(
                      F,
                      xlim: (-2, 2),
                      ylim: (-2, 2),
                      spacing: (.25, .25),
                      scale_segments: 20.0,
                      width: 6cm,
                      height: 5cm,
                      xaxis: (position: 0, tip: tiptoe.stealth, subticks: none, ticks: none),
                      yaxis: (position: 0, tip: tiptoe.stealth, subticks: none, ticks: none),
                    )
      }
    ]
  ),
  (
    statement: [
      A student is working on linear systems with complex eigenvalues, they claim the following statements. For each of them, do you agree? If not, provide justification(s).

      + "When we diagonalize a matrix, we change the determinant. Therefore, the eigenvalues and the stability might change as well."

      + For the system $arrow(x)'=mat(-1,-4;1,-1)arrow(x)$, they find the eigenvalues $lambda=-1 plus.minus 2i$, and claims "the equilibrium is unstable since the eigenvalues are both complex!"

      + They solve $arrow(x)'=mat(1,2;-2,1)arrow(x)$ and finds $lambda=1 plus.minus 2i$. For $lambda=1+2i$, they use the eigenvector $vec(i,1)$ and obtain the general real solution $arrow(x)(t)=C_1e^t mat(sin(2t);-cos(2t))+C_2e^t mat(cos(2t);sin(2t))$. 
      
      + They solve $arrow(x)'=mat(0,1;-9,0)arrow(x)$ and says: "The eigenvalues are $lambda=plus.minus 3i$, so the origin is a stable spiral."

      + They solve the affine system $vec(x',y')=mat(-1,-2;2,-1)vec(x,y)+vec(5,0)$ and says: "The equilibrium is $(0,0)$ because the coefficient matrix has eigenvalues $-1 plus.minus 2i$."
    ],
    solution: [
      + Not all matrices are diagonalizable. If one can be diagonalized, a similarity transformation can be performed, although the determinant and eigenvalues stay the same.

      + Complex eigenvalues alone do not imply that the system is unstable, we must observe their real parts to make such claim. In fact, with $lambda=-1 plus.minus 2i$, the real parts are both negative, indicating a Stable and Attracting equilibrium.

      + The mistake lies with the wrong eigenvalue and eigenvector pair. $vec(i,1)$ is for $lambda=1-2i$, not $lambda=1+2i$. For $lambda=1+2i$, one valid eigenvector is $vec(-i,1)$. A correct general real solution is $arrow(x)(t)=C_1e^t vec(sin(2t),cos(2t))+C_2e^t vec(cos(2t),-sin(2t))$, where $C_1,C_2$ are parameters.

      + The origin is Stable but not Attracting, therefore the solution moves along a closed loop and does not spiral.

      + For an affine system, the equilibrium is not automatically $(x,y)=(0,0)$. We must solve $mat(-1,-2;2,-1)vec(x,y)+vec(5,0)=vec(0,0)$. It turns out that the equilibrium is located at $(x,y)=(1,2)$.
    ],
  ),
  (
    statement: [
      For each of the following systems: 
      - Write it in matrix form.
      - Find the equilibrium solution(s).
      - Find the corresponding eigenvalues and eigenvectors.
      - Classify the equilibrium solution(s).
      - Find the complex and real general solution.
      - Determine whether or not the solutions spirals about an equilibrium solution. If it does, do solutions spiral clockwise or counter-clockwise?

      + $cases(x'=-y, y'=x)$

      + $cases(x'=-x-4y, y'=x-y)$

      + $cases(x'=-2x+3y, y'=-3x-2y)$ 
      
      + $cases(x'=x+2y, y'=-2x+y)$ 
      
      + $cases(x'=2y, y'=-8x)$ 
      
      + $cases(x'=-x-2y+5, y'=2x-y)$
    ],
    solution: [
      + $vec(x',y') = mat(0,-1;1,0)vec(x,y)$; the equilibrium solution is located at $(x,y)=(0,0)$ and is stable but not attracting; the eigenvalues are $lambda_1=i, lambda_2=-i$ with eigenvectors $arrow(v)_1=vec(1,-i)$ and $arrow(v)_2=vec(1,i)$. The general real solution is $vec(x(t),y(t))=C_1vec(cos(t),sin(t))+C_2vec(sin(t),-cos(t))$ where $C_1,C_2$ are parameters. Solutions do not spiral, but rotate counter-clockwise in closed loops.

      + $vec(x',y') = mat(-1,-4;1,-1)vec(x,y)$; the equilibrium is located at $(x,y)=(0,0)$ and is stable and attracting; the eigenvalues are $lambda_1=-1+2i, lambda_2=-1-2i$ with eigenvectors $arrow(v)_1=vec(2i,1)$ and $arrow(v)_2=vec(-2i,1)$. The general real solution is $vec(x(t),y(t))=C_1e^(-t)vec(-2sin(2t),cos(2t))+C_2e^(-t)vec(2cos(2t),sin(2t))$ where $C_1,C_2$ are parameters. The spiral is counter-clockwise.

      + $vec(x',y') = mat(-2,3;-3,-2)vec(x,y)$; the equilibrium is located at $(x,y)=(0,0)$ and is stable and attracting; the eigenvalues are $lambda_1=-2+3i, lambda_2=-2-3i$ with eigenvectors $arrow(v)_1=vec(-i,1), arrow(v)_2=vec(i,1)$. The general real solution is $vec(x(t),y(t))=C_1e^(-2t)vec(sin(3t),cos(3t))+C_2e^(-2t)vec(-cos(3t),sin(3t))$ where $C_1,C_2$ are parameters. The spiral is clockwise.

      + $vec(x',y') = mat(1,2;-2,1)vec(x,y)$; the equilibrium is located at $(x,y)=(0,0)$ and is unstable and repelling; the eigenvalues are $lambda_1=1+2i, lambda_2=1-2i$ with eigenvectors $arrow(v)_1=vec(-i,1), arrow(v)_2=vec(i,1)$. The general real solution is $vec(x(t),y(t))=C_1e^t vec(sin(2t),cos(2t))+C_2e^t vec(cos(2t),-sin(2t))$ where $C_1,C_2$ are parameters. The spiral is clockwise.

      + $vec(x',y') = mat(0,2;-8,0)vec(x,y)$; the equilibrium is located at $(x,y)=(0,0)$ and is stable but not attracting; the eigenvalues are $lambda_1=4i, lambda_2=-4i$ with eigenvectors $arrow(v)_1=vec(-i,2), arrow(v)_2=vec(i,2)$. The general real solution is $vec(x(t),y(t))=C_1vec(sin(4t),2cos(4t))+C_2vec(-cos(4t),2sin(4t))$, where $C_1,C_2$ are parameters. There is no spiral, but the solution rotate clockwise in a closed loop.

      + $vec(x',y') = mat(-1,-2;2,-1)vec(x,y)+vec(5,0)$; the equilibrium is located at $(x,y)=(1,2)$ and is stable and attracting; the eigenvalues are $lambda_1=-1+2i, lambda_2=-1-2i$ with eigenvectors $arrow(v)_1=vec(i,1), arrow(v)_2=vec(-i,1)$. The general real solution is $vec(x(t),y(t))=C_1e^(-t)vec(-sin(2t),cos(2t))+C_2e^(-t)vec(cos(2t),sin(2t))+vec(1,2)$, where $C_1,C_2$ are parameters. The spiral is counter-clockwise.
    ],
  ),
  (
    statement: [
      Consider the following system
      
      $arrow(r)'=mat(alpha, -5;5,alpha)arrow(r)$

      + Find the equilibrium solution(s)
      + Find the eigenvalues and eigenvectors in terms of $alpha$.
      + Determine the possible classifications of the equilibrium solution(s) based on the value(s) of $alpha$.
      + Find the general solution.
      + Find the general real solution.
      + Do solutions spiral about the equilibrium solution(s)? If so, in which direction?
    ],
    solution: [
      + $lambda_1=alpha+5i, lambda_2=alpha-5i$ with $arrow(v)_1=vec(i,1), arrow(v)_2=vec(-i,1)$.
      + Equilibrium solution is located at $(x,y)=(0,0)$.
      + $alpha<0$ Stable and Attracting, $alpha=0$ Stable but not Attracting, $alpha>0$ Unstable and Repelling.
      + $arrow(r)(t)=A vec(i,1)e^((alpha+5i)t)+B vec(-i,1)e^((alpha-5i)t)$, where $A,B$ are parameters.
      + $vec(x(t),y(t))=C_1e^(alpha t)vec(-sin(5t),cos(5t))+C_2e^(alpha t)vec(cos(5t),sin(5t))$, where $C_1,C_2$ are parameters.
      + Solutions spiral only if $alpha!=0$. When $alpha=0$ solution rorate in closed loops. In all cases, the direction is counter-clockwise.
    ]
  ),
  (
    statement: [
      For the following systems:
      - Find and classify the equilibrium solution(s)
      - Determine the behaviour around such equilibrium(s)
      - Find the solution satisfying the given initial condition.

      + $cases(x'=y, y'=-10x)$ with $x(0)=2, y(0)=0$

      + $cases(x'=-4x+y, y'=-9x-4y)$ with $x(0)=1, y(0)=3$

      + $vec(x',y')=mat(-2,-3;3,-2)vec(x,y)+vec(-4,-7)$ with $x(0)=2,y(0)=-2$

      + $arrow(r)'=mat(cos(pi/3), -sin(pi/3); sin(pi/3), cos(pi/3))arrow(r)$ with $arrow(r)(0)=vec(1,0)$.
    ],
    solution: [
      + Equilibrium is at $(x,y)=(0,0)$, and is Stable but not Attracting. The behaviour is a clockwise closed loop. $vec(x(t),y(t))=2vec(cos(sqrt(10)t), -sqrt(10)sin(sqrt(10)t))$.

      + Equilibrium is at $(x,y)=(0,0)$, and is Stable and Attracting. The behaviour is a clockwise spiral. $vec(x(t),y(t))=e^(-4t)vec(sin(3t)+cos(3t),3cos(3t)-3sin(3t))$.

      + Equilibrium is at $(x,y)=(1,-2)$, and is Stable and Attracting. The behaviour is a counter-clockwise spiral. $vec(x(t),y(t))=e^(-2t)vec(cos(3t),sin(3t))+vec(1,-2)$.

      + Equilibrium is at $(x,y)=(0,0)$, and is Unstable and Repelling. The behaviour is a counter-clockwise spiral. $arrow(r)(t)=e^(t/2)vec(cos(sqrt(3)/2 t), sin(sqrt(3)/2 t))$.
    ],
  ),
  (
    statement: [
      Construct a $2 times 2$ system of differential equations with the following behaviour, or explain why no such system exists:

      + 1 stable and attracting equilibrium solution at $(x,y)=(0,0)$, spirals clockwise, has angular frequency 5, and decays like $e^(-2t)$.

      + 1 stable and attracting equilibrium solution at $(x,y)=(0,0)$, spirals clockwise, has angular frequency 5, and decays like $e^(2t)$.

      + 1 unstable and repelling equilibrium solution at $(x,y)=(0,0)$, spirals clockwise, has angular frequency 5, and grows like $e^(2t)$.

      + 1 stable and attracting equilibrium solution at $(x,y)=(0,0)$, spirals counter-clockwise, has angular frequency 4, and decays like $e^(-t)$.
      
      + 1 stable and attracting equilibrium solution at $(x,y)=(0,0)$, spirals counter-clockwise, has sinusoidal entries in the coefficient matrix, has angular frequency $cos(pi/6)$, and decays like $e^(-sin(pi/6)t)$. 
      
      + 1 stable and attracting equilibrium solution at $(x,y)=(3,-1)$, spirals clockwise, has angular frequency 2, and decays like $e^(-4t)$.
    ],
    solution: [
      + Since the equilibrium is Stable and Attracting, we know that the eigenvalues must be complex, with their real parts negative. Combined with the fact that the system has an angular frequency 5, and decays like $e^(-2t)$, we can claim that the eigenvalues are $lambda_1=-2+5i, lambda_2=-2-5i$. We find that a valid system is $\ vec(x',y')=mat(-2,5;-5,-2)vec(x,y) arrow.l.r.double cases(x'=-2x+5y,y'=-5x-2y)$ with the equilibrium located at $(x,y)=(0,0)$ that spirals clockwise with an angular frequency of 5.

      + Not possible, because $e^(2t)$ does not decay as $t -> infinity$. Furthermore, a Stable and Attracting equilibrium require the real parts of the eigenvalues to be negative, yet 2 is not negative.

      + A valid system is $\ vec(x',y')=mat(2,5;-5,2)vec(x,y) arrow.l.r.double cases(x'=2x+5y,y'=-5x+2y)$ that has the equilibrium located at $(x,y)=(0,0)$ and is an Unstable and Repelling clockwise spiral with an angular frequency of 5.

      + A valid system is $\ vec(x',y')=mat(-1,-4;4,-1)vec(x,y) arrow.l.r.double cases(x'=-x-4y, y'=4x-y)$ we find the equilibrium at $(x,y)=(0,0)$ that is Stable and Attracting, and spirals counter-clockwise with an angular frequency of 4.

      + Since $sin(pi/6)=1/2$ and $cos(pi/6)=sqrt(3)/2$, one valid system is $\ vec(x',y')=mat(-1/2,-sqrt(3)/2;sqrt(3)/2,-1/2)vec(x,y) arrow.l.r.double cases(x'=-1/2x-sqrt(3)/2 y,y'=sqrt(3)/2x-1/2 y)$ with equilibrium at $(x,y)=(0,0)$ that is a stable and attracting counter-clockwise spiral with an angular frequency of $cos(pi/6)=sqrt(3)/2$.

      + A valid affine system is $\ vec(x',y')=mat(-4,2;-2,-4)vec(x,y)+vec(14,2)\ arrow.l.r.double cases(x'=-4x+2y+14, y'=-2x-4y+2)$ which has an equilibrium solution at $(x,y)=(3,-1)$ that is a stable and attracting clockwise spiral with an angular frequency of 2.
    ],
  ),
  //XXX Not sure whether or not to add this question
  /*
  (
    statement: [
      Given the matrix form of a system of differential equations, what's useful about its determinant?
    ],
    solution: [
      The determinant of the matrix could offer more information about the nature and the number of the equilibrium solution(s). Such as whether or not the system has unique and whether there are finite number of equilibrium solution(s).
    ]
  ),
  */
)
