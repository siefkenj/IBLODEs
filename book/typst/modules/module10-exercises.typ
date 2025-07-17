#import "../libs/_workbook.typ": aligned_terms
#import "@preview/lilaq:0.4.0" as lq

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

let springmass = {
    let ts = lq.linspace(1.5, 30, num: 150)
    let thickness = 1.5pt
    
    
    align(
      center,
      {
        show: lq.set-grid(stroke: none)
        lq.diagram(
          width: 5cm,
          height: 0.875cm,
          // xlim: (-2, 14),
          // ylim: (-5, 5),
          yaxis: none,
          xaxis: none,
          lq.rect(
            -1,-1,
            width: 1,
            height: 2,
            stroke: none,
            fill: color.rgb("#8B4513"), // brown
          ),
          lq.line(
            (0,-1),
            (0,1),
            stroke: (paint: black, thickness: thickness),
          ),
          lq.plot(
            ts.map(t => 0.6 + 1.2 * (0.3 * t - calc.sin(t))),
            ts.map(t => 1.2 * (1 - calc.cos(t)) - 1),
            mark: none,
            stroke: (paint: black, thickness: thickness),
          ),
          lq.ellipse(
            0.6 + 1.2 * (0.3 * 30 - calc.sin(30))-1, 
            1.2 * (1 - calc.cos(30)) - 2,
            height: 2,
            width: 2,
            fill: color.rgb("#bbbbbb"), // gray
            stroke: (paint: black, thickness: thickness),
          ),
          lq.place(0.6 + 1.2 * (0.3 * 30 - calc.sin(30)), 1.2 * (1 - calc.cos(30)) - 1)[M],
        )               
      },
    )
  
}


  question(
    slide(force_scale: 0.75em)[
      

  Consider a spring with a mass attached to the end.
  
  #springmass
            

  Let $x(t) =$ displacement to the right of the spring from equilibrium at time $t$.

  Recall from Physics the following laws:

  - (HL) Hooke's Law: For an elastic spring, force is proportional to negative the displacement from equilibrium.
  - (NL) Newton's Second Law: Force is proportional to acceleration (the proportionality constant is called mass).
  - (ML) Laws of Motion: Velocity is the time derivative of displacement and acceleration is the time derivative of velocity.

  // #v(1in)

  + Model $x(t)$ with a differential equation.

    For the remaining parts, assume the elasticity of the spring is $k = 1$ and the mass is $1$.

  + Suppose the spring is stretched $0.5$m from equilibrium and then let go (at time $t = 0$).
    + At $t = 0$, what are $x$, $x'$, and $x''$?
    + Modify Euler's method to approximate a solution to the initial value problem.

  + Introduce the auxiliary equation $y = x'$. Can the second-order spring equation be rewritten as a first-order system involving $x'$ and $y'$? If so, do it.

  + Simulate the _system_ you found in the previous part using Euler's method.

      
    ],
  )

  book_only(pagebreak())
  question(
    slide[

  Recall a spring with a mass attached to the end.

  #springmass


  $x(t)$ = displacement to the right of the spring from equilibrium at time $t$

  We have two competing models

#math.equation(
  block: true,
  numbering: "(A)",
  $ x'' = -k x $,
)<eq:spring>
  

#math.equation(
  block: true,
  numbering: "(A)",
  $ mat(x; y)' = mat(0, 1; -k, 0) mat(x; y) $,
)<eq:spring_system>
where $y = x'$
  

  #v(1em)

  XXX CHANGE EQUATION LABELS TO (A) AND (B) IN THE BOOK VERSION

  + Make a phase portrait for system @eq:spring_system[]. What are the axes on the phase portrait? What do you expect general solutions to look like?
  + Use eigenvalues/eigenvectors to find a general solution to @eq:spring_system[]. (You may use a computer to compute eigenvalues/vectors.)
  + Use your solution to @eq:spring_system[] to find a general solution to @eq:spring[].

    ],
  )

book_only(pagebreak())
  question(
    slide[

      Consider the second-order differential equation
      $ x'' = - (1 + x) dot x' + x^2 - x $

      + Rewrite the second-order differential equation as a system of first-order differential equations. (Hint: you may need to introduce an auxiliary equation.)

      + The following Desmos link plots a phase portrait and draws an Euler approximation on the phase portrait:

        #link("https://www.desmos.com/calculator/fvqxqp6eds")

        Use the link to make a phase portrait for your system and answer the following questions:
        + Are there initial conditions with $x(0) < 0$ so that a solution $x(t)$ is always increasing?
        + Are there initial conditions with $x(0) < 0$ so that a solution $x(t)$ first decreases and then increases?

      + Show that $x(t) = 0$ is an equilibrium solution for this equation.

      + Use linearization and eigenvalues to classify the equilibrium $(x, x') = (0, 0)$ in phase space.

      + Let $x(t)$ be a solution to the original equation and suppose $x(0) = delta_1 approx 0$.
        + If $x'(0) = delta_2 approx 0$, speculate on the long term behaviour of $x(t)$.
        + If we put no conditions on $x'(0)$ will your answer be the same? Explain.

    ],
  )


}
