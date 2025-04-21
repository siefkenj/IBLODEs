#import "../libs/_workbook.typ": aligned_terms
#import "@preview/lilaq:0.2.0" as lq
#import "../libs/_graphics.typ": vector_field, slope_field

#let MM = $upright(bold("M"))$
#let SS = $upright(bold("S"))$
#let OO = $upright(bold("O"))$
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




  book_only(pagebreak())
  question(
    slide[
      #align(center, block[
        #image("../images/slope-field-3d.png",width: 2in)

        #link("https://www.desmos.com/3d/kvyztvmp0g")[https://www.desmos.com/3d/kvyztvmp0g]
      ]
      )

      3d slope fields are possible, but hard to interpret.
      This is a slope field for the Foxes--Rabbits model.


      + What are the three dimensions in the plot?
      + What should the graph of an equilibrium solution look like?
      + What should the graph of a typical solution look like?
      + What are ways to simplify the picture so we can more easily analyze solutions?

    ],
  )



  book_only(pagebreak())
  question(
    slide[

    //https://www.desmos.com/calculator/wdgtznxndp
    //
    // Without Euler's built in:
    // https://www.desmos.com/calculator/vrk0q4espx

    #let F(x,y) = ( 0.01 * y - 1.1 ) * x
    #let G(x,y) = ( 1.1 - 0.1 * x ) * y

    #align(center, 
      vector_field(
        F, 
        G, 
        xlim:(0,40), 
        ylim:(0,300),
        spacing: (2, 10),
        scale_segments: 0.075,
        width: 8cm,
        height: 8cm
      )
    )

    #show_def("phase_portrait")

    This is a phase portrait for the Foxes--Rabbits model.

    #link("https://www.desmos.com/calculator/vrk0q4espx")[https://www.desmos.com/calculator/vrk0q4espx]

    
      + What do the $x$ and $y$ axes correspond to?
      + Identify the equilibria in the phase portrait. What are the lengths of the vectors at those points?
      + Classify each equilibrium as stable/unstable.
      + Copy and paste data from your simulation spreadsheet into the Desmos plot. Does the resulting
      curve fit with the picture?
      // + Why is the vector at $(5,100)$ longer than the vector at $(10,100)$? Justify numerically.


    ]
  )



  book_only(pagebreak())
  question(
    slide[

	// % https://www.desmos.com/calculator/wdgtznxndp
	// %
	// % Without Euler's built in:
	// % https://www.desmos.com/calculator/vrk0q4espx

    Sketch your own vector field where the corresponding system of differential equations:

		+ Has an attracting equilibrium solution.
		+ Has a repelling equilibrium solution.
		+ Has no equilibrium solutions.

    ]
  )


  book_only(pagebreak())
  question(
    slide[

    #let F(x, y) = 1.1 * y * (1 - 0.1 / 1 * y)

    #align(
      center,
      slope_field(
        F,
        xlim: (-3, 20),
        ylim: (-6.2, 15),
        spacing: 1.1,
        width: 7cm,
        height: 5cm,
        scale_segments: 1.5,
      ),
    )
  

    Recall the slope field for model $OO$.

      + What would a phase portrait for model $OO$ look like? Draw it.
      + Where are the arrows the longest? Shortest?
      + How could you tell from a 1d phase portrait whether an equilibrium solution is attracting/repelling/etc.?
    ]
  )

  book_only(pagebreak())
  question(
    slide[
    // Completed phase portrait in desmos:
    // https://www.desmos.com/calculator/tvjag852ja
  	
    The following differential equation models the life cycle of a tree.
    In the model
    
      - $H(t) =$ height (in meters) of tree trunk at time $t$
      - $A(t) =$ surface area (in square meters) of all leaves at time $t$
    
  
    $ H'(t) &= 0.3 dot.c A(t)-b dot.c H(t) \
      A'(t) &= -0.3 dot.c (H(t))^2 + A(t) $
    
    and $0 lt.eq b lt.eq 2$.

      + Modify #link("https://www.desmos.com/calculator/vrk0q4espx")[https://www.desmos.com/calculator/vrk0q4espx]. <partphase> 
      to make a phase portrait for the tree model.
      + What do equilibrium solutions mean in terms of tree growth?
      + For $b=1$ what are the equilibrium solution(s)?

    ]
  )




  book_only(pagebreak())
  question(
    slide[
      
    #slides_only(block[
      The following differential equation models the life cycle of a tree.
      In the model
    
        - $H(t) =$ height (in meters) of tree trunk at time $t$
        - $A(t) =$ surface area (in square meters) of all leaves at time $t$
    
  
      $ H'(t) &= 0.3 dot.c A(t)-b dot.c H(t) \
        A'(t) &= -0.3 dot.c (H(t))^2 + A(t) $
    
      and $0 lt.eq b lt.eq 2$.
    ]
    )

	
		+ Fix a value of $b$ and use a spreadsheet to simulate some solutions with different initial conditions.
		Plot the results on your phase portrait from #link(<partphase>)[28.1].
		+ What will happen to a tree with $(H(0), A(0))=(20,10)$? Does this depend on $b$?
		+ What will happen to a tree with $(H(0), A(0))=(10,10)$? Does this depend on $b$?




    ]
  )




}