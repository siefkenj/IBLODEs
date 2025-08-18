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


Consider the following model of Social Media Usage where
$ P(t) & = "millions of social media posts at year " t \
 U(t) & = "millions of social media users at year " t $

// The units here are actually correct, but you have to think about it...
- (P$1_P$) Ignoring all else, each year posts decay proportionally to the current number of posts with proportionality constant 1.
- (P$2_P$) Ignoring all else (independent of decay), posts grow by a constant amount of 2 million posts every year.
- (P$1_U$) Ignoring all else, social media users increase/decrease in proportion to the number of posts.
- (P$2_U$) Ignoring all else, social media users increase/decrease in proportion to the number of users.
- (P$3_U$) Ignoring all else, 1 million people stop using the platform every year.


A school intervention is described by the parameter $a in [-1/2, 1]$:
- After the intervention, the proportionality constant for (P$1_U$) is $1 - a$.
- After the intervention, the proportionality constant for (P$2_U$) is $a$.

+ Model this situation using a system of differential equations. Explain
  which parts of your model correspond to which premise(s).

],
)

book_only(pagebreak())
question(
  slide[

The *SM* model of Social Media Usage is
$ P' &= -P + 2 \
 U' &= (1 - a) P + a U - 1 $
where
$ P(t) &= "millions of social media posts at year " t \
 U(t) &= "millions of social media users at year " t \
 a &in inline([-1/2, 1]) $

+ What are the equilibrium solution(s)?
+ Make a phase portrait for the system.

  #link("https://www.desmos.com/calculator/h3wtwjghv0")

+ Use phase portraits to conjecture: what do you think happens to the equilibrium
  solution(s) as $a$ transitions from negative to positive? Justify with a computation.

],
)

book_only(pagebreak())
question(
  slide[


The *SM* model of Social Media Usage is
$ P' &= -P + 2 \
 U' &= (1 - a) P + a U - 1 $
where
$ P(t) &= "millions of social media posts at year " t \
 U(t) &= "millions of social media users at year " t \
 a &in inline([-1/2, 1]) $

  + Can you rewrite the system in matrix form? I.e., in the form $arrow(r)'(t) = M arrow(r)(t)$ for some matrix $M$ where $arrow(r)(t) = mat(P(t); U(t))$.
  + Define $arrow(s)(t) = mat(S_P(t); S_U(t))$ to be the displacement from equilibrium in the *SM* model at time $t$ (provided an equilibrium exists).
    + Write $arrow(s)$ in terms of $P$ and $U$.
    + Find $arrow(s)'$ in terms of $P$ and $U$.
    + Find $arrow(s)'$ in terms of $S_P$ and $S_U$.
    + Can one of your differential equations for $arrow(s)$ be written in matrix form? Which one?
    + Analytically classify the equilibrium solution for your differential equation for $arrow(s)$ when $a = -1/2$, $a = 1/2$, and $a = 1$. (You may use a calculator for computing eigenvectors/values.)


   ],
  )

  book_only(pagebreak())
  question(
    slide[


  The *SM* model of Social Media Usage is
  $ P' &= -P + 2 \
  U' &= (1 - a) P + a U - 1 $
  where
  $ P(t) &= "millions of social media posts at year " t \
  U(t) &= "millions of social media users at year " t \
  a &in inline([-1/2, 1]) $


  Some politicians have been looking at the model. They made the following posts on social media:
  
    
    #block[
      #set enum(numbering: "1.")
      
      + _The model shows the number of posts will always be increasing. SAD!_
      + _I see the number of social media users always increases. That's not what we want!_
      + _It looks like social media is just a fad. Although users initially increase, they eventually settle down._
      + _I have a dream! That one day there will be social media posts, but eventually there will be no social media users!_
    ]

  + For each social media post, make an educated guess about what initial conditions and what
    value(s) of $a$ the politician was considering.
  + The school board wants to limit the number of social media users to fewer than 10 million.
    Make a recommendation about what value of $a$ they should target.

   ],
  )





}