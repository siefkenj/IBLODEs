#import "../libs/_workbook.typ": aligned_terms

#let MM = $upright(bold("M"))$
#let SS = $upright(bold("S"))$
#let infty = math.infinity

#let setup(env) = {
  let (sans, serif, slide, restrict, question, definition, solution: _solution, show_def) = env
  let slides_only = restrict.with(when: ("slides", "slides-solutions"))
  let book_only = restrict.with(when: ("book", "guide", "book-solutions"))
  let guide_only = restrict.with(when: "guide")
  let solution = content => restrict(
    when: ("guide", "book-solutions", "slides-solutions"),
    _solution(content),
  )


  question(
    slide[

	Consider the following *FD* model of Fleas and Dogs where 
    $ F(t) & = "number of parasites (fleas) at year " t " (in millions)" \
    D(t) & = "number of hosts (dogs) at year " t " (in thousands)" $

    - (P$1_F$) Ignoring all else, the number of parasites decays in proportion to its population (with constant 1).
    - (P$2_F$) Ignoring all else, parasite numbers grow in proportion to the number of hosts (with constant 1).
    - (P$1_D$) Ignoring all else, hosts numbers grow in proportion to their current number (with constant 1).
    - (P$2_D$) Ignoring all else, host numbers decrease in proportion to the number of parasites (with constant 2).
    - (P$1_c$) Anti-flea collars remove 2 million fleas per year.
    - (P$2_c$) Constant dog breeding adds 1 thousand dogs per year.

      + Write a system of differential equations for the *FD* model.
      + Can you rewrite the system in matrix form $arrow(r)' = M arrow(r)$? What about in _affine_ form $arrow(r)' = M arrow(r) + arrow(b)$?
      + Make a phase portrait for your model.
      + What should solutions to the system look like in the phase plane? What are the equilibrium solution(s)?
    

    ],
  )


  book_only(pagebreak())
  question(
    slide[

    Recall the *FD* model of Fleas and Dogs where 
    $ F(t) &= "number of parasites (fleas) at year " t " (in millions)" \
    D(t) &= "number of hosts (dogs) at year " t " (in thousands)" \
    arrow(r)(t) &= mat(F(t); D(t)) $

    and

    $ arrow(r)'(t) = mat(-1,1; -2, 1) arrow(r)(t) + mat(-2; 1) $

    Define $arrow(s)(t)$ to be the displacement of $arrow(r)(t)$ from equilibrium at time $t$.

    + Find a formula for $arrow(s)$ in terms of $arrow(r)$.
    + Can you find a matrix $M$ so that $arrow(s)'(t) = M arrow(s)(t)$?
    + What are the eigenvalues of $M$?
    + Find an eigenvector for each eigenvalue of $M$.
    + What are the eigen solutions for $arrow(s)' = M arrow(s)$?

    ],
  )


  book_only(pagebreak())
  question(
    slide[


    Recall the *FD* model of Fleas and Dogs where 
    $ F(t) &= "number of parasites (fleas) at year " t " (in millions)" \
    D(t) &= "number of hosts (dogs) at year " t " (in thousands)" \
    arrow(r)(t) &= mat(F(t); D(t)) 
      wide wide arrow(s)(t) = arrow(r)(t) - mat(3; 5) $

    and

    $ arrow(s)'(t) = M arrow(s)(t) wide "where" wide M = mat(-1, 1; -2, 1). $

    This equation has eigen solutions
    $ arrow(s)_1(t) &= e^(i t) mat(1 - i; 2) \
    arrow(s)_2(t) &= e^(-i t) mat(1 + i; 2). $

    + Recall Euler's formula $e^(i t) = cos(t) + i sin(t)$. 
      + Use Euler's formula to expand $arrow(s)_1 + arrow(s)_2$. Are there any imaginary numbers remaining?
      + Use Euler's formula to expand $i (arrow(s)_1 - arrow(s)_2)$. Are there any imaginary numbers remaining?
    + Verify that your formulas for $arrow(s)_1 + arrow(s)_2$ and $i (arrow(s)_1 - arrow(s)_2)$ are solutions to
      $arrow(s)'(t) = M arrow(s)(t).$
    + Can you give a third _real_ solution to $arrow(s)'(t) = M arrow(s)(t)?$



    ],
  )


  book_only(pagebreak())
  question(
    slide[

    Recall the *FD* model of Fleas and Dogs where 
    $ F(t) &= "number of parasites (fleas) at year " t " (in millions)" \
    D(t) &= "number of hosts (dogs) at year " t " (in thousands)" \
    arrow(r)(t) &= mat(F(t); D(t)) 
      wide wide arrow(s)(t) = arrow(r)(t) - mat(3; 5) $

    and

    $ arrow(s)'(t) = M arrow(s)(t) wide "where" wide M = mat(-1, 1; -2, 1). $

  
    + What is the dimension of the space of solutions to $arrow(s)'(t) = M arrow(s)(t)$?
    + Give a basis for all solutions to $arrow(s)'(t) = M arrow(s)(t)$.
    + Find a solution satisfying $arrow(s)(0) = mat(1; 3)$.
    + Using what you know, find a general formula for $arrow(r)(t)$.
    + Find a formula for $arrow(r)(t)$ satisfying $arrow(r)(0) = mat(4; 8)$.


      
    ],
  )



  book_only(pagebreak())
  question(
    slide[

    Recall the *FD* model of Fleas and Dogs where 
    $ F(t) &= "number of parasites (fleas) at year " t " (in millions)" \
    D(t) &= "number of hosts (dogs) at year " t " (in thousands)" \
    arrow(r)(t) &= mat(F(t); D(t)) 
      wide wide arrow(s)(t) = arrow(r)(t) - mat(3; 5) $

    and

    $ arrow(s)'(t) = M arrow(s)(t) wide "where" wide M = mat(-1, 1; -2, 1). $

  Some research is being done on a shampoo for the dogs. It affects flea and dog reproduction:
  - (P$S_F$) Ignoring all else, the number of parasites decays in proportion to its population with constant $1 + a$.
  - (P$S_D$) Ignoring all else, hosts numbers grow in proportion to their current number with constant $1 - a$.
  - $-1 <= a <= 1$. 
  
  _These premises replace (P$1_F$) and (P$1_D$)._

  + Modify the previous  *FD* model to incorporate the effects of the shampoo.
  + Make a phase portrait for the *FD Shampoo* model.
  + Find the equilibrium solutions for the *FD Shampoo* model.
  + For each equilibrium solution determine its stability/instability/etc.
  + Analytically justify your conclusions about stability/instability/etc.

      
    ],
  )



  book_only(pagebreak())
  question(
    slide[

    Consider the differential equation
    $ arrow(s)'(t) = M arrow(s)(t) quad "where" quad M = mat(-1, -4; 2, 3) $

    + Make a phase portrait. Based on your phase portrait, classify the equilibrium solution.

    #link("https://www.desmos.com/calculator/h3wtwjghv0")
    + Find eigen solutions for this differential equation (you may use a calculator/computer to assist).
    + Find a general _real_ solution.
    + Analytically classify the equilibrium solution.

      
    ],
  )

}