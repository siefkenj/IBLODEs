#let questions = (
  (
    statement: [
      Find the equilibrium points and linearizations of the following systems:

      + $cases(x' = x^2-y^2, y'=x^2+y^2-1)$

      + $cases(x'=-y, y'=3x+y x^2)$

      + $cases(x'=x^2+y, y'=y^2+x)$#v(.7em)
    ],
    citation: [_Notes on Diffy Q's_ by Jiří Lebl 3.1.3]
  ),
  (
    statement: [
      Take $cases(x'=(x-y)^2, y'=(x+y)^2)$
      + Find the set of equilibrium points.
      + Sketch a phase diagram and describe the behaviour near the equilibrium point(s).
      + Find the linearization. Is it helpful in understanding the system?
    ],
    citation: [_Notes on Diffy Q's_ by Jiří Lebl 3.1.5]
  ),
  (
    statement: [
      Find the linearizations of the following systems:

      + $cases(x'= sin(pi y)+(x-1)^2, y'=y^2-y)$

      + $cases(x'=x+y+y^2, y'=x)$

      + $cases(x'=(x-1)^2+y, y'=x^2+y)$#v(.5em)
    ],
    solution: [
      + At $(1,0)$, using $u=x-1,v=y$. The linearization is $u'=pi v, v'=-v$. At $(1,1)$, using $u=x-1, v=y-1$, the linearization is $u'=-pi v,v'=v$.
      + Using $u=x, v=y$, the linearization is $u'=u+v,v'=u$. At $(0,0)$, using $u=x,v=y$, the linearization is $u'=u+v,v'=u$. At $(0, -1)$, using $u=x,v=y+1$, the linearization is $u'=u-v, v'=v$.
      + Using $u=x-1/2,v=y+1/4$, the linearization of the equilibrium/critical point at $(1/2, (-1)/4)$ is $u'=-u+v, v'=u+v$.
    ],
    citation: [_Notes on Diffy Q's_ by Jiří Lebl 3.1.101]
  ),
  (
    statement: [The idea of equilibrium/critical points and linearization works in higher dimensions as well. You simply make the Jacobian matrix bigger by adding more functions and more variables. For the following system of 3 equations find the critical points and their linearizations:
    
    $cases(x'=x+z^2, y'=z^2-y, z'=z+x^2)$],
    solution: [Critical points are $(0,0,0),(-1,1,-1)$. The linearization at the origin using variables $u=x, v=y, w=z$ is $u'=u, v'=-v, z'=w$. The linearization at the point $(-1,1,-1)$ using variables $u=x+1, v=y-1, w=z+1$ is $u'=u-2w, v'=-v-2w, w'=w-2u$.],
    citation: [_Notes on Diffy Q's_ by Jiří Lebl 3.1.103]
  )
)