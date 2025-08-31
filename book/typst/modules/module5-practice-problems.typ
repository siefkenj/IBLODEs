#let questions = (
  (
    statement: [
      Sketch the phase portraits for the following equations:#v(.1em)
      + $cases(x'=x^2,y'=y^2)$#v(.7em)
      + $cases(x'=(x-y)^2,y'=-x)$#v(.7em)
      + $cases(x'=e^y,y'=e^x)$#v(.7em)
    ],
    citation: [_Notes on Diffy Q's_ by Jiří Lebl 3.1.1]
  ),
  (
    statement: [
      Take $cases(x'=(x-y)^2,y'=(x+y)^2)$#v(.1em)
      + Find the set of equilibrium points.
      + Sketch the phase portrait and describe the behaviour near the equilibrium points.
    ],
    citation: [_Notes on Diffy Q's_ by Jiří Lebl 3.1.5]
  ),
  (
    statement: [
      Find the equilibrium points of the following systems:#v(.25em)
      + $cases(x'=sin(pi y)+(x-1)^2,y'=y^2-y)$#v(.7em)
      + $cases(x'=x+y+y^2,y'=x)$#v(.7em)
      + $cases(x'=(x-1)^2+y,y'=x^2+y)$#v(.7em)
    ],
    solution: [
      + Equilirbium points: $(1,0),(1,1)$.
      + Equilibrium points: $(0,0),(0,-1)$.
      + Equilibrium points: $(1/2, (-1)/4)$.],
    citation: [_Notes on Diffy Q's_ by Jiří Lebl 3.1.101]
  ),
  (
    statement: [
      Match equations:
      - $y'=sin(x)$
      - $y'=cos(y)$
      - $y'=y cos(x)$ 
      to the following slope fields.
      + #image("../images/M5_Question_Plots/1.2.104(a).png")
      + #image("../images/M5_Question_Plots/1.2.104(b).png")
      + #image("../images/M5_Question_Plots/1.2.104(c).png")
    ],
    solution: [
      + $y'=cos(y)$
      + $y'=y cos(x)$
      + $y'=sin(x)$],
    citation: [_Notes on Diffy Q's_ by Jiří Lebl 1.2.104]
  ),
  (
    statement: [
      Match the following systems to the vector fields below:#v(.25em)
      - $cases(x'=y^2,y'=-x^2)$#v(.7em)
      - $cases(x'=y,y'=(x-1)(x+1))$#v(.7em)
      - $cases(x'=y+x^2,y'=-x)$#v(.7em)
      + #image("../images/M5_Question_Plots/3.1.102(a).png")
      + #image("../images/M5_Question_Plots/3.1.102(b).png")
      + #image("../images/M5_Question_Plots/3.1.102(c).png")
    ],
    solution: [#v(.7em)
      + $cases(x'=y,y'=(x-1)(x+1))$#v(.7em)
      + $cases(x'=y+x^2,y'=-x)$#v(.7em)
      + $cases(x'=y^2,y'=-x^2)$],
    citation: [_Notes on Diffy Q's_ by Jiří Lebl 3.1.102]
  )
)