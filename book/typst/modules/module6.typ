
// This file is meant to be imported and not compiled on its own.
#import "../common/settings-book.typ": workbook, show_def
#let (sans, serif, module, definition, example, theorem) = workbook

In this module you will learn
- How to find analytic solutions to systems of differential equations with constant coefficients by using the eigenvalues and eigenvectors of the coefficient matrix.
- How the real and distinct eigenvalues of a system of differential equations with constant coefficients are related to the stability of the equilibrium solutions.





// + Matrix from of the system
// + Diagonal matrix $arrow.double$ solution
// + linear combination of solutions $arrow.double$ solution
// + Definition of linear (in)dependence of solutions
// + Only need basis of solutions
// + Idea of eigen solutions
// + What is the dimension of the solution space?
//   - Theorem (Existence & Uniqueness 1) ...
// + Solve systems with real eigenvalues



== Linear Algebra Pre-requisites

Starting with this module, we will be using several results from linear algebra. We will assume that you are familiar with the following concepts:
- The definition of vector spaces and subspaces.
- The definition of a linear transformation and the kernel and image of a linear transformation.
- The definition of linear independence.
- The notions of span, basis, and dimension of a vector space.
- The eigenvalues and eigenvectors of a matrix.

You will find a review of these topics in APPENDIX XXX. If you are not familiar with them, we recommend that you review them before continuing with this module.


== Finding analytic solutions

We can analytically find all solutions to a system of differential equations with constant coefficients by using the eigenvalues and eigenvectors of the coefficient matrix. 


=== Writing the system in matrix form

We can write the system of differential equations in _matrix form_. For example, consider the system of differential equations: 
$ (dif x) / (dif t) &= 2 x + y \
  (dif y) / (dif t) &= x + 2 y $  

We can write this system in matrix form as:
$ mat((dif x) / (dif t); (dif y) / (dif t)) 
  = mat(2,1;1,2) mat(x;y) $
and if we let $arrow(r) = mat(x;y)$ and $M = mat(2,1;1,2)$, we can write the system as:
$ (dif arrow(r)) / (dif t) = M arrow(r) $
where $arrow(r)$ is a vector of the two dependent variables and $M$ is the coefficient matrix.



=== Linear combinations and linear independence of solutions

Assume that we have two solutions $arrow(r_1)(t)$ and $arrow(r_2)(t)$ of a system of differential equations with constant coefficients
$ (dif arrow(r)) / (dif t) = M arrow(r) . $

If we form a linear combination of these two solutions
$ arrow(s)(t) = alpha arrow(r_1)(t) + beta arrow(r_2)(t) $
then we can show that this is also a solution of the system. To see this, we can differentiate $arrow(s)(t)$ with respect to $t$:
$ (dif arrow(s)(t)) / (dif t) &= alpha (dif arrow(r_1)(t)) / (dif t) + beta (dif arrow(r_2)(t)) / (dif t) \
 &= alpha M arrow(r_1)(t) + beta M arrow(r_2)(t)\
 &= M (alpha arrow(r_1)(t) + beta arrow(r_2)(t)) \
 &= M arrow(s)(t) $
where on the second equality we used the fact that $arrow(r_1)(t)$ and $arrow(r_2)(t)$ are solutions of the system. 
This shows that $arrow(s)(t)$ is also a solution of the system.

This is a very important property of systems of differential equations with constant coefficients.

It means that the *solution space of the system is a vector space*. 

As a a consequence, to find all solutions of the system, we only need to find a _basis of the solution space_. To do this, we need to have a definition of linear dependence of solutions.

#show_def("linear_dependence_solutions")



To recap what we have learned so far:
- We can form linear combinations of solutions to find other solutions of the system.
- The solution space of a system of differential equations with constant coefficients is a vector space.
- We have a definition of linear dependence of solutions.



=== Finding a basis of solutions using eigenvalues and eigenvectors


Before reading this part of the module, you should work through the core exercises XXX 32 - 36 and 38 to understand where the idea comes from.

Consider a system of differential equations with constant coefficients:
$ (dif arrow(r)) / (dif t) = M arrow(r), $
where $M$ is a matrix with real entries.

We can find the eigenvalues and eigenvectors of the matrix $M$.
An eigenvalue $lambda$ and corresponding eigenvector $arrow(v)$ of the matrix $M$ satisfy
$ M arrow(v) = lambda arrow(v). $

Now define the function 
$ arrow(r)(t) = e^(lambda t) arrow(v), $
where we recall that $(lambda, arrow(v))$ is an eigenvalue-eigenvector pair of $M$. 

We will show that this is a solution of the system of differential equations. 
To see this, we differentiate $arrow(r)(t)$ with respect to $t$:
$ (dif arrow(r)(t)) / (dif t) = e^(lambda t) lambda arrow(v) $
and we can also compute $M arrow(r)(t)$:
$ M arrow(r)(t) = M (e^(lambda t) arrow(v)) = e^(lambda t) M arrow(v) = e^(lambda t) lambda arrow(v) $
where we used the fact that $arrow(v)$ is an eigenvector of $M$ with eigenvalue $lambda$.
Thus we have
$ (dif arrow(r)(t)) / (dif t) = M arrow(r)(t). $
and we have shown that $arrow(r)(t)$ is a solution of the system of differential equations.

This means that we can find a solution of the system of differential equations by finding an eigenvalue-eigenvector pair of the coefficient matrix $M$. We call these solutions _eigen solutions_.

#show_def("eigensolution")


Since the set of all eigenvectors of a matrix $M in RR^(N times N)$ form a basis#footnote([This applies only if the matrix is diagnoalizable. In this course we will only consider diagnoalizable matrices. For non-diagonalizable matrices, see REFERENCE XXX.]) of $RR^N$, we now have an algorithm to find a set of $N$ linearly independent solutions of a $N times N$ system of differential equations with constant coefficients.


=== Dimension of the solution space


From the previous parts of this module, we have learned that the solution space is a vector space with _dimension greater or equal to $N$_, where $N$ is the number of dependent variables in the system.

We now want to show that the solution space is a vector space with _dimension less than or equal to $N$_.

The first step is to show that the system of differential equations has a unique solution passing through every initial condition.

#theorem(
        title: [Existence & Uniqueness 1],
        [
          The system of differential equations represented by $arrow(r)'(t) = M arrow(r)(t) + arrow(p)$ (or the single differential equation $y' = a y + b$) has a unique solution passing through every initial condition.
          Further, the domain of every solution is $RR$.
        ],
)

This implies that the solution space is a vector space with dimension less than or equal to $N+1$, since each solution is uniquely determined by its initial condition $(t_0, x_1, dots, x_N) in RR^(N+1)$.

However, the Theorem above also concludes that the domain of every solution is $RR$, which means that every solution is defined for $t=0$ and so can be uniquely determined by its initial condition $(0, x_1, dots, x_N)$, which forms a subspace of dimension $N$.

This means that the solution space is a vector space with dimension less than or equal to $N$.
Thus we have shown that the solution space is a vector space with dimension equal to $N$.

#theorem(
        title: [Solution Space Dimension],
        [
          The solution space of a system of differential equations with constant coefficients $arrow(r)'(t) = M arrow(r)(t) + arrow(p)$ is a vector space with dimension equal to the number of dependent variables in the system.
        ],
)


=== Solutions of systems with real eigenvalues

We can now use the results we have learned in this module to find the solutions of a system of differential equations with constant coefficients.

The set formed by the eigen solutions of the system of differential equations is a basis of the solution space. This means that we can find all solutions of the system by forming linear combinations of the eigen solutions.


#example(
    prompt: [Find all solutions of the system of differential equations],
    [
      $ (dif x) / (dif t) &= 2 x + y \
      (dif y) / (dif t) &= x + 2 y $

      We can write this system in matrix form as:
      $ mat((dif x) / (dif t); (dif y) / (dif t)) 
        = mat(2,1;1,2) mat(x;y) $
      and if we let $arrow(r) = mat(x;y)$ and $M = mat(2,1;1,2)$, we can write the system as:
      $ (dif arrow(r)) / (dif t) = M arrow(r), $
      where $arrow(r)$ is a vector of the two dependent variables and $M$ is the coefficient matrix.

      We can find the eigenvalues and eigenvectors of the matrix $M$:
      - $ lambda_1 = 3$ with eigenvector $arrow(v_1) = mat(1;1),$

      - $lambda_2 = 1 $ with eigenvector $arrow(v_2) = mat(1;-1).$

      We can now write the eigen solutions of the system of differential equations:
      $ arrow(r_1)(t) &= e^(3 t) arrow(v_1) = e^(3 t) mat(1;1), \
      arrow(r_2)(t) &= e^(1 t) arrow(v_2) = e^(1 t) mat(1;-1). $

      We can now form a linear combination of these two solutions to find the general solution of the system of differential equations:
      $ arrow(r)(t) = alpha e^(3 t) mat(1;1) + beta e^(1 t) mat(1;-1), $
      where $alpha$ and $beta$ are constants that depend on the initial conditions of the system.
    ]
)

#example(
    prompt: [Finding the solution that satisfies $arrow(r)(0) = mat(1;0)$.],
    [

    We are now given an initial condition $arrow(r)(0) = mat(1;0)$.
    We can find the values of $alpha$ and $beta$ by substituting $t=0$ into the general solution:
    $ arrow(r)(0) &= alpha e^(3 * 0) mat(1;1) + beta e^(1 * 0) mat(1;-1) \
    mat(1;0) &= alpha mat(1;1) + beta mat(1;-1) $
    This gives us the following system of equations that we can solve for $alpha$ and $beta$:
    $ alpha &= 1 / 2 \
      beta &= 1 / 2 $
    Thus the solution that satisfies the initial condition is:
    $ arrow(r)(t) &= (1 / 2) e^(3 t) mat(1;1) + (1 / 2) e^(1 t) mat(1;-1) \
      &= (1 / 2) mat(e^(3t) + e^t; e^(3t) - e^t). $
    ]
)



Observe that this process works for any system of differential equations with constant coefficients as long as the eigenvalues are real and distinct.
We will see in the next module that this is not the case for all systems of differential equations with constant coefficients. In particular, we will see that if the eigenvalues are complex, this method does work but will yield eigen solutions that involve complex numbers. Since we are interested in real solutions, there will be some additional steps to obtain a basis of real solutions from the complex eigen solutions.









