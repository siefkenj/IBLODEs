#import "../libs/_workbook.typ": aligned_terms
#import "@preview/lilaq:0.2.0" as lq
#import "@preview/tiptoe:0.3.0"



#let MM = $upright(bold("M"))$
#let SS = $upright(bold("S"))$
#let infty = math.infinity

#let setup(env) = {
  let (sans, serif, slide, restrict, question, definition, solution: _solution, show_def, theorem) = env
  let slides_only = restrict.with(when: ("slides", "slides-solutions"))
  let book_only = restrict.with(when: ("book", "guide", "book-solutions"))
  let guide_only = restrict.with(when: "guide")
  let solution = content => restrict(
    when: ("guide", "book-solutions", "slides-solutions"),
    _solution(content),
  )
        


// Catenary Problem

let catenary = {
  let xs = lq.linspace(-1, 1.5, num: 25)
  let thickness = 1.5pt
  

  align(
    center,
    {
      show: lq.set-grid(stroke: none)
      lq.diagram(
        //width: 5cm,
        //height: 0.875cm,
        // xlim: (-2, 14),
        // ylim: (-5, 5),
        yaxis: none,
        xaxis: none,
        // Brown Ground
        lq.rect(
          -1.5,-0.1,
          width: 3.5,
          height: 0.1,
          stroke: none,
          fill: color.rgb("#8B4513"), // brown
        ),
        lq.line(
          (-1.5,0),
          (2,0),
          stroke: (paint: black, thickness: thickness),
        ),
        // Poles at the ends
        lq.line(
          (-1,0),
          (-1,calc.cosh(-1)),
          stroke: (paint: black, thickness: thickness),
        ),
        lq.line(
          (1.5,0),
          (1.5,calc.cosh(1.5)),
          stroke: (paint: black, thickness: thickness),
        ),
        // Catenary curve
        lq.plot(
          xs,
          xs.map(x => calc.cosh(x)),
          mark: none,
          stroke: (paint: blue, thickness: 1.5*thickness),
        ),
        // Straight rod S
        lq.line(
          (0,0),
          (0,1),
          stroke: (paint: gray, thickness: 0.5*thickness, dash: "dashed"),
        ),
        lq.line(
          (0.5, 0),
          (0.5,calc.cosh(0.5)),
          stroke: (paint: gray, thickness: 0.5*thickness, dash: "dashed"),
        ),
        lq.line(
          (0,1),
          (0.5,calc.cosh(0.5)),
          stroke: (paint: purple.lighten(50%), thickness: 1.5*thickness),
        ),
        lq.place(0,-0.25)[#text(fill: gray, $d$)],
        lq.place(0.5,-0.25)[#text(fill: gray, $d + Delta$)],
        // Gravitational Force
        lq.path(
          (0.25, 0.9), 
          (0.25, 0.5),
          stroke: (paint: black),
          tip: tiptoe.stealth,
        ),
        lq.place(0.25, 0.3)[$arrow(F)_g$],
        // Tension Forces
        lq.path(
          (0.5, calc.cosh(0.5)), 
          (1,2*calc.cosh(0.5)-1+0.15),
          stroke: (paint: black),
          tip: tiptoe.stealth,
        ),
        lq.place(0.7, 1.55)[$arrow(T)_R$],
        lq.path(
          (0, 1), 
          (-0.5,2-calc.cosh(0.5)+0.15),
          stroke: (paint: black),
          tip: tiptoe.stealth,
        ),
        lq.place(-0.25, 1.25)[$arrow(T)_L$],
      )               
    },
  )
}



let catenary_simple = {
  let xs = lq.linspace(-1.5, 1.5, num: 30)
  let thickness = 1.5pt
  

  align(
    center,
    {
      show: lq.set-grid(stroke: none)
      lq.diagram(
        width: 5cm,
        height: 3cm,
        // xlim: (-2, 14),
        // ylim: (-5, 5),
        yaxis: none,
        xaxis: none,
        // Brown Ground
        lq.rect(
          -1.75,-0.1,
          width: 3.5,
          height: 0.1,
          stroke: none,
          fill: color.rgb("#8B4513"), // brown
        ),
        lq.line(
          (-1.75,0),
          (1.75,0),
          stroke: (paint: black, thickness: thickness),
        ),
        // Poles at the ends
        lq.line(
          (-1.5,0),
          (-1.5,calc.cosh(-1.5)),
          stroke: (paint: black, thickness: thickness),
        ),
        lq.line(
          (1.5,0),
          (1.5,calc.cosh(1.5)),
          stroke: (paint: black, thickness: thickness),
        ),
        // Catenary curve
        lq.plot(
          xs,
          xs.map(x => calc.cosh(x)),
          mark: none,
          stroke: (paint: blue, thickness: 1.5*thickness),
        ),
      )               
    },
  )
}

  question(
    slide(force_scale: 0.87em)[

      Consider a rope hanging from two poles.

        #catenary


      $H(d) =$ height of the rope above ground at position $d$.

      We will consider the following premises and physics laws:
      - ($P_D$) The linear density of the rope is constant: $rho$ kg/m
      - ($P_G$) Gravity pulls downwards in proportion to mass (the proportionality constant is called $g$)
      - ($P_T$) Tension pulls tangentially to the rope
      // - (S) The rope is not moving (it is stationary)
      - ($P_(N L)$) Newton's First Law: a body at rest will remain at rest unless it is acted upon by a force
      // - (NL) Newton's Second Law: Force is proportional to acceleration (the proportionality constant is called mass).
      // - (ML) Laws of Motion: Velocity is the time derivative of displacement and acceleration is the time derivative of velocity.

      To model the rope, imagine it is made of *small rigid rods*.
      We will focus on one such rod, $S$, (drawn in the figure) from $d$ to $d + Delta$.

      + Given ($P_(N L)$), find a relation between the force vectors $arrow(T)_L$, $arrow(T)_R$, $arrow(F)_g$.
      + Approximate the length of the segment #SS and its mass. Approximate the vector $arrow(F)_g$.
      + Find a vector $arrow(V)_L$ in the direction of $arrow(T)_L$ (the magnitude doesn't matter at this point).

    ],
  )


  book_only(pagebreak())
  question(
    slide(force_scale: 0.78em)[

      Consider a rope hanging from two poles.

      #catenary
    
      The only forces acting on the rope are gravity and tension.

      Similarly to the previous exercise, we can find a vector $arrow(V)_R = mat(1, H'(d + Delta))$ in the direction of $arrow(T)_R$, but with possibly different magnitude.

      So far we have:
      - $arrow(T)_L = alpha arrow(V)_L$ for some $alpha > 0$, and
      - $arrow(T)_R = beta arrow(V)_R$ for some $beta > 0$.

      + Can you find approximations of the vectors $arrow(F)_g$, $arrow(T)_L$, $arrow(T)_R$ that only use $H(d)$, $H'(d)$, and $H''(d)$?

        Hint:
        - $H(d + Delta) approx H(d) + Delta dot H'(d)$,
        - $H'(d + Delta) approx H'(d) + Delta dot H''(d)$.

      + Put everything together to find a (second order) differential equation for $H$.

      + Do $alpha$ or $beta$ depend on $d$? Explain.


    ],
  )



  book_only(pagebreak())
  question(
    slide(force_scale: 0.85em)[

Recall a rope hanging from two poles.

#catenary_simple

$H(d) = $ the height of the rope at position $d$.

We have the following model for it:
$ H''(d) = k sqrt(1 + (H'(d))^2) $

Toronto Hydro is stringing some wire. The posts are 20m apart and at a height of 10m. At the lowest point, the wire is 5m above the ground.

+ Set up a boundary value problem that can be used to find the total length of the wire.

+ Using the following Desmos link, can you find a solution to the boundary value problem?

  #link("https://www.desmos.com/calculator/l4fair6454")

+ It happens that $k = frac(rho g, T)$ where $T$ is the minimum tension in the rope.

  Suppose Toronto Hydro hung the wires so that they were at minimum 9m above the ground.
  Would the tension be higher or lower? By how much?

+ Should the difference between maximum and minimum tension
  be higher or lower for low-hanging wires? What does your intuition say? What does the phase portrait say?

// The wire has a (linear) density of 1 kg/m and gravity is 9.8 m/s^2.
// For safety reasons, the wire's tensile strength needs to be 5 times the maximum tension when the wire is resting.
// What strength of wire do they need?
// Assuming the posts are both the same height, relate the length of the rope with the tension at the posts.
// Assuming the posts have different heights, relate the length of the rope with the tension at the posts.


  ],
  )







// Pendulum Problem


let pendulum = {
  let xs = lq.linspace(-1, 1.5, num: 25)
  let thickness = 1.5pt
  

  align(
    center,
    {
      show: lq.set-grid(stroke: none)
      lq.diagram(
        width: 1.6cm,
        height: 3.55cm,
        // xlim: (-2, 14),
        // ylim: (-5, 5),
        yaxis: none,
        xaxis: none,
        // Brown Ground
        lq.rect(
          -1,0,
          width: 2,
          height: 0.25,
          stroke: none,
          fill: color.rgb("#8B4513"), // brown
        ),
        lq.line(
          (-1,0),
          (1,0),
          stroke: (paint: black, thickness: thickness),
        ),
        // Pendulum
        lq.line(
          (0,0),
          (1,-4),
          stroke: (paint: black, thickness: thickness),
        ),
        lq.ellipse(
          1-0.5, -4-0.5,
          height: 1,
          width: 1,
          fill: color.rgb("#bbbbbb"), // gray
          stroke: (paint: black, thickness: thickness),
        ),
        lq.place(1,-4)[$m$],
        // y axis
        lq.line(
          (0,0),
          (0,-4),
          stroke: (paint: gray, thickness: 0.5*thickness, dash: "dashed"),
        ),
        lq.path(
          (0, -3),
          (0.2, -3),
          (0.4, -2.95),
          (0.6, -2.85),
          (0.7, -2.8),
          tip: tiptoe.stealth,
          stroke: (paint: gray, thickness: 0.5*thickness),//, dash: "dashed"),
        ),
        lq.place(0.3,-2.6)[#text(fill: gray, $theta$)],
        // Gravitational Force
        lq.path(
          (1, -4.75), 
          (1, -5.85),
          stroke: (paint: black),
          tip: tiptoe.stealth,
        ),
        lq.place(1.4, -5.2)[$arrow(F)_g$],
        // Tension Force
        lq.path(
          (1.1, -3.3), 
          (0.85,-2.3),
          stroke: (paint: black),
          tip: tiptoe.stealth,
        ),
        lq.place(1.4, -2.9)[$arrow(T)$],
      )               
    },
  )
}



  book_only(pagebreak())
  question(
    slide(force_scale: 0.74em)[

      Consider a pendulum as in the figure below.


       #align(
        center,
        table(
          columns: (1fr, 1fr),
          align: (center, center),
          stroke: none,
          {pendulum},
          [
            $theta(t) = $ the angle the pendulum makes with the vertical axis (positive in the counterclockwise direction and negative in the clockwise direction).
          ],
        )
      )

Assume the pendulum is composed of a weightless rigid rod of length $1$m and a mass of $1$kg at its end. In 
addition assume:

- ($P_G$) Gravity pulls downwards in proportion to mass (the proportionality constant is called $g$).
- ($P_T$) Tension pulls the mass in the direction of the rod.
- ($P_(N L)$) Newton's Second Law: Force is proportional to acceleration (the proportionality constant is called mass).
- ($P_(M L)$) Laws of Motion: Velocity is the time derivative of displacement and acceleration is the time derivative of velocity.

+ Let $theta(t)$ be the angle at time $t$ and let $arrow(r)(t)$ be the mass's position at time $t$.

  Find $arrow(r)(t)$ and $arrow(r)''(t)$ in terms of $theta(t)$.
+ Find the vector $arrow(F)_g$.
+ Find a vector $arrow(T)_d$ so that $arrow(T) = alpha arrow(T)_d$ for some $alpha > 0$.
//	Find the velocity and acceleration vectors for the mass.
+ Find a second-order differential equation for the pendulum.
  _Hint: ($P_(N L)$) gives you an equation for each coordinate. Solve one for $(theta')^2$ and substitute it into 
  the other equation._
//	Write the differential equation as a system of 1$^{rm st}$-order differential equations.


   ],
  )



  book_only(pagebreak())
  question(
    slide(force_scale: 0.87em)[


      Consider a pendulum as in the figure below.


       #align(
        center,
        table(
          columns: (1fr, 1fr),
          align: (center, center),
          stroke: none,
          {pendulum},
          [
            $theta(t) = $ the angle the pendulum makes with the vertical axis (positive in the counterclockwise direction and negative in the clockwise direction).
          ],
        )
      )

      If we had preserved length and mass in our derivation, we would have the following model:
      $ theta''(t) = - (g / L) sin(theta(t)) $


      Let (P) be the corresponding system of first-order differential equations.
      The following Desmos link is already set up with (P).

      #link("https://www.desmos.com/calculator/acmiingcqf")

      + If $L = 3$m, and you set the pendulum in motion at $theta = 0$ by giving it a *small* push, what does the motion look like?

      + If $L = 3$m, and you set the pendulum in motion at $theta = 0$ by giving it a *big* push, what does the motion look like?

      + Why are there infinitely many equilibrium solutions? Based on your physical intuition, which equilibria are stable and which are unstable?

      + Find an affine approximation to (P) around $(theta, theta') = (0, 0)$.

      + Physicists often claim that $theta(t)$ oscillates like a sine wave with period $2 pi sqrt(L /g)$. Under what conditions are the (mostly) correct?

      // + Show that $theta(t) = k pi$ are equilibrium solutions for all $k in mathbb{Z}$. Analyze its nature using eigen techniques.
      // 
      // #raw(block: true)[
      //   \bigskip
      // ]
      // 
      // + Using the following Desmos link, use different initial conditions to explore the different behaviours of the pendulum with $L = 3$.
      // 
      //   #link("https://www.desmos.com/calculator/5qifixelmb")
      // 
      // + If the pendulum starts vertically with a 5 m/s push to the right, is the solution periodic?
      // 
      // + Assume $theta(0) = 0$. Find an initial velocity $v^star$ such that the behaviour of the phase portrait for $theta'(0) < v^star$ is different than that for $theta'(0) > v^star$. What is the practical meaning of $v^star$?
      // 
      // + We have a pendulum with $L = 3$ m on Earth. We want to take a pendulum to the Moon that will behave exactly in the same way. What should be the specifications of that pendulum?


  ],
  )


}