
// This file is meant to be imported and not compiled on its own.
#import "../common/settings-book.typ": workbook, show_def
#import "../libs/_workbook.typ": simple_table, label_module
#let (sans, serif, module, definition, example, theorem) = workbook

#label_module(<mod:complex>)

In this module you will learn
- How to find real analytic solutions to systems of differential equations with constant coefficients when the eigenvalues of the coefficient matrix are complex.
- How the complex, distinct eigenvalues of a system of differential equations with constant coefficients are related to the stability of the equilibrium solutions.



=== Complex Numbers Pre-requisites

In this module, you will need to be somewhat comfortable handling complex numbers. We will assume that you are familiar with the following concepts:
- Adding, subtracting, multiplying and dividing complex numbers.
- Complex conjugate of a complex number.
- Euler's formula.

You will find a review of these topics in APPENDIX XXX. If you are not familiar with them, we recommend that you review them before continuing with this module.


=== Finding an analytic Solution

In the previous two modules we have seen how to find analytic solutions to systems of differential equations with constant coefficients when the eigenvalues of the coefficient matrix are real and distinct. 

We will now follow the same steps to find an analytic solution to a system of differential equations with constant coefficients when the eigenvalues of the coefficient matrix are complex.

Consider the system of differential equations
$ (dif x) / (dif t) &= 0.11 y \
(dif y) / (dif t) &= - 11 x $
which can be written in matrix form as
$ (dif arrow(r))/ (dif t) = mat(0, 0.11; -11, 0 ) arrow(r), $
where $arrow(r)(t) = mat(x(t); y(t))$.

Following the same steps as in XXX MODULE 6, we first find the eigenvalues and eigenvectors of the coefficient matrix $mat(0, 0.11; -11, 0)$, which are:

- Eigenvalue $lambda_1 = 0.11 i$ with eigenvector $v_1 = mat(1; 0.11 i)$.

- Eigenvalue $lambda_2 = -0.11 i$ with eigenvector $v_2 = mat(1; -0.11 i)$.

We can then construct two linearly independent solutions to the system of differential equations using the eigenvalues and eigenvectors.

$ arrow(r)_1(t) &= mat(1;0.11i) e^(0.11 t i) \
arrow(r)_2(t) &= mat(1;-0.11i) e^(-0.11 t i) $

The problem with these solutions is that they are complex and we are looking for solutions that give us real numbers.


=== Finding Real Solutions

First, recall Euler's formula.

#theorem(
  title: [Euler's Formula],
  [
    For any real number $t$, $e^(i t) = cos(t) + i sin(t)$.
  ],
)

Using it, we can rewrite the solutions we found as
$ arrow(r)_1(t) &= mat(1;0.11i) (cos(0.11 t) + i sin(0.11 t)) \
    &= mat(cos(0.11 t) + i sin(0.11 t); -0.11 sin(0.11 t)+0.11 i cos(0.11 t) ) $
and
$ arrow(r)_2(t) &= mat(cos(0.11 t) - i sin(0.11 t); -0.11 sin(0.11 t)-0.11 i cos(0.11 t) ). $

Notice that these solutions are complex conjugates of each other. 

If we add to this the fact that linear combinations of solutions to a system of differential equations are also solutions to the system, we can obtain real solutions by taking clever linear combinations of the two complex solutions.

Consider the following linear combinations of the two complex solutions:
$ arrow(s)_1(t) &= arrow(r)_1(t) + arrow(r)_2(t) \
&= mat(2 cos(0.11 t); -0.22 sin(0.11 t)) $
and 
$ arrow(s)_2(t) &= i (arrow(r)_1(t) - arrow(r)_2(t)) \
&= mat(-2 sin(0.11 t); -0.22 cos(0.11 t) ). $

We can check that these two solutions are linearly independent, and they are real-valued, so we have found a real-valued basis of the solution space of the system of differential equations.

We conclude that the general solution to the system of differential equations is
$ arrow(r)(t) = c_1 arrow(s)_1(t) + c_2 arrow(s)_2(t) $
where $c_1$ and $c_2$ are arbitrary constants.

#example(
  prompt: [What is the solution of the following system of differential equations
    $ (dif x) / (dif t) &= 0.11 y \
(dif y) / (dif t) &= - 11 x $
    that satisfies $x(0) = 1$ and $y(0) = -1$?],
  [
   From the calculations above, we know that the general solution to the system of differential equations is
$ arrow(r)(t) = c_1 arrow(s)_1(t) + c_2 arrow(s)_2(t). $

We only need to find the constants $c_1$ and $c_2$ that satisfy the initial conditions $arrow(r)(0)=mat(1;-1)$.
We have
$ mat(1;-1) = & arrow(r)(0) = c_1 arrow(s)_1(0) + c_2 arrow(s)_2(0) \
&= c_1 mat(2; 0) + c_2 mat(0; -0.22) \
&= mat(2 c_1; -0.22 c_2) $

We get $c_1 = 1/2$ and $c_2 = 50/11$ and the solution is
$ arrow(r)(t) 
  &= (1/2) arrow(s)_1(t) + (50/11) arrow(s)_2(t) \
  &= mat( cos(0.11 t) - (50/11) sin(0.11 t); \
    -0.11 sin(0.11 t) - cos(0.11 t) ). $
  ],
)


=== Stability of the Equilibrium Solutions

As we have seen in MODULE 6 XXX, the stability of equilibrium solutions of a system of differential equations with constant coefficients is determined by the eigenvalues of the coefficient matrix when the eigenvalues were real and distinct.

Similarly, when the eigenvalues are complex, the stability of the equilibrium solutions is also determined by the eigenvalues of the coefficient matrix. More specifically, the stability of the equilibrium solutions is determined by the _real part of the eigenvalues_.


Before reading the remainder of this module, we recommend that you gain some intuition about the solutions of systems of differential equations with complex eigenvalues by solving the core exercises in this module.


Consider a system of differential equations
$ (dif arrow(r))/(dif t) = M arrow(r), $
where the eigenvalues of the coefficient matrix $M$ are complex: $lambda_1 = a + i b$ and $lambda_2 = a - i b$.

First, observe that the unique equilibrium solution is $arrow(r)(t) = mat(0; 0)$, so we want to establish the stability of this equilibrium solution.

Following the process described earlier in this module, we know that the solutions of the system of differential equations will have the form
$ arrow(r)_i (t) 
  = arrow(v)_i e^(lambda_i t)
  = arrow(v)_i e^(a t) e^(i b t) 
  = arrow(v)_i e^(a t) (cos(b t) + i sin(b t)), $
where $arrow(v)_i$ is the eigenvector associated with the eigenvalue $lambda_i$.

We can now study what will happen to the solutions as $t$ approaches infinity, by focusing on each term of the solution
$ arrow(r)_i (t) 
  = arrow(v)_i e^(a t) (cos(b t) + i sin(b t)). $

The first term $arrow(v)_i$ is a constant vector, so it will not affect the stability of the equilibrium solution.

The third term $cos(b t) + i sin(a t)$ is a periodic function, so it will not affect the stability of the equilibrium solution either.

The only term that can affect the stability of the equilibrium solution is the second term $e^(a t)$.

- If $a < 0$, then $e^(a t)$ will approach 0 as $t$ approaches infinity, and the equilibrium solution will be _stable_ and _attracting_.

- If $a > 0$, then $e^(a t)$ will approach infinity as $t$ approaches infinity, and the equilibrium solution will be _unstable_ and _repelling_.

- If $a = 0$, then $e^(a t)$ will be equal to 1 for all $t$, and the equilibrium solution will be _stable_ but neither attracting nor repelling.


=== Summary // of Stability of Equilibrium Solutions

Below we combine all the results obtained in the last modules about the stability of equilibrium solutions of systems of differential equations with constant coefficients.

Consider the following system of differential equations
$ (dif arrow(r))/(dif t) = M arrow(r) + arrow(b), $
where the eigenvalues of the coefficient matrix $M$ are $lambda_1$ and $lambda_2$.
The stability of the equilibrium solution $arrow(r)(t) = - M^(-1) arrow(b)$ is determined by the eigenvalues of the coefficient matrix $M$.

#align(
        center,
        simple_table(
          headers: ([Eigenvalue $lambda_1$], [Eigenvalue $lambda_2$], [Stability of Equilibrium]),
          content: (
            // real, both negative
            $lambda_1<0$,
            $lambda_2<0$,
            [Stable and Attracting],
            // real, both positive
            $lambda_1>0$,
            $lambda_2>0$,
            [Unstable and Repelling],
            // real, one positive, one negative
            $lambda_1<0$,
            $lambda_2>0$,
            [Unstable and Repelling],
            table.hline(stroke: .5pt),
            // real, 0 + negative
            $lambda_1=0$,
            $lambda_2<0$,
            [Stable],
            // real, 0 + positive
            $lambda_1=0$,
            $lambda_2>0$,
            [Unstable],
            table.hline(stroke: .5pt),
            // complex, both negative real part
            $lambda_1 = a + i b, a<0$,
            $lambda_2 = a - i b, a<0$,
            [Stable and Attracting],
            // complex, both positive real part
            $lambda_1 = a + i b, a>0$,
            $lambda_2 = a - i b, a>0$,
            [Unstable and Repelling],
            // complex, zero real part
            $lambda_1 = i b$,
            $lambda_2 = - i b$,
            [Stable],
          ),
        ),
      )

OR

#align(
        center,
        simple_table(
          headers: ([Real/Complex], [Sign of Eigenvalues], [Stability of Equilibrium]),
          content: (
            // real, both negative
            [Real],
            [Both negative],
            [Stable and Attracting],
            // real, both positive
            [Real],
            [Both positive],
            [Unstable and Repelling],
            // real, one positive, one negative
            [Real],
            [One negative, one positive],
            [Unstable and Repelling],
            table.hline(stroke: .5pt),
            // real, 0 + negative
            [Real],
            [One is zero, one is negative],
            [Stable],
            // real, 0 + positive
            [Real],
            [One is zero, one is positive],
            [Unstable],
            table.hline(stroke: .5pt),
            // complex, both negative real part
            [Complex],
            [Real parts negative],
            [Stable and Attracting],
            // complex, both positive real part
            [Complex],
            [Real parts positive],
            [Unstable and Repelling],
            // complex, zero real part
            [Complex],
            [Real parts zero],
            [Stable],
          ),
        ),
      )

XXX CHOOSE ONE TABLE!!












