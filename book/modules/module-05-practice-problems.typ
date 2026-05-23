#import "../libs/lib.typ": *

#let questions = (
  (
    statement: [
      Consider the following differential equations, and draw their slope fields.#v(.1em)
      + $y'=5$#v(.7em)
      + $y'=x$#v(.7em)
      + $y'=y$#v(.7em)
      + $y'=x+y$#v(.7em)
      + $y'=x^2$#v(.7em)
    ],
    solution: [
      #let F0(x,y)=5
      #let F1(x,y)=x
      #let F2(x,y)=y
      #let F3(x,y)=x+y
      #let F4(x,y)=x*x
      + #{
          align(
                center,
                slope_field(
                            F0,
                            scale_segments: .75,
                            xlim: (-7, 7),
                            ylim: (-7, 7),
                            slope_color: blue,
                            spacing: 1
                          ),
                )
        }
      + #{
          align(
                center,
                slope_field(
                            F1,
                            scale_segments: .75,
                            xlim: (-7, 7),
                            ylim: (-7, 7),
                            slope_color: blue,
                            spacing: 1
                          ),
                )
        }
      + #{
          align(
                center,
                slope_field(
                            F2,
                            scale_segments: .75,
                            xlim: (-7, 7),
                            ylim: (-7, 7),
                            slope_color: blue,
                            spacing: 1
                          ),
                )
        }
      + #{
          align(
                center,
                slope_field(
                            F3,
                            scale_segments: .75,
                            xlim: (-7, 7),
                            ylim: (-7, 7),
                            slope_color: blue,
                            spacing: 1
                          ),
                )
        }
      + #{
          align(
                center,
                slope_field(
                            F4,
                            scale_segments: .75,
                            xlim: (-7, 7),
                            ylim: (-7, 7),
                            slope_color: blue,
                            spacing: 1
                          ),
                )
        }
    ],
  ),
  (
    statement: [
      Sketch the phase portraits for the following equations:#v(.1em)
      + $cases(x'=x^2, y'=y^2)$#v(.7em)
      + $cases(x'=(x-y)^2, y'=-x)$#v(.7em)
      + $cases(x'=e^y, y'=e^x)$#v(.7em)
    ],
    citation: [_Notes on Diffy Q's_ by Jiří Lebl 3.1.1],
  ),
  (
    statement: [
      Take $cases(x'=(x-y)^2, y'=(x+y)^2)$#v(.1em)
      + Find the set of equilibrium points.
      + Sketch the phase portrait and describe the behaviour near the equilibrium points.
    ],
    citation: [_Notes on Diffy Q's_ by Jiří Lebl 3.1.5],
  ),
  (
    statement: [
      Find the equilibrium points of the following systems:#v(.25em)
      + $cases(x'=sin(pi y)+(x-1)^2, y'=y^2-y)$#v(.7em)
      + $cases(x'=x+y+y^2, y'=x)$#v(.7em)
      + $cases(x'=(x-1)^2+y, y'=x^2+y)$#v(.7em)
    ],
    solution: [
      + Equilirbium points: $(1,0),(1,1)$.
      + Equilibrium points: $(0,0),(0,-1)$.
      + Equilibrium points: $(1/2, (-1)/4)$.
    ],
    citation: [_Notes on Diffy Q's_ by Jiří Lebl 3.1.101],
  ),
  (
    statement: [
      Match equations:
      - $y'=sin(x)$
      - $y'=cos(y)$
      - $y'=y cos(x)$
      to the following slope fields.
      #let F1(x,y)=calc.cos(y)
      #let F2(x,y)=calc.cos(x)*y
      #let F3(x,y)=calc.sin(x)
      + #{
          align(
                center,
                slope_field(
                            F1,
                            scale_segments: .75,
                            xlim: (-2*calc.pi, 2*calc.pi),
                            ylim: (-2*calc.pi, 2*calc.pi),
                            slope_color: blue,
                            spacing: 1
                          ),
                )
        }
      + #{
          align(
                center,
                slope_field(
                            F2,
                            scale_segments: .35,
                            xlim: (-3,3),
                            ylim: (-3,3),
                            slope_color: blue,
                            spacing: .5
                          ),
                )
        }
      + #{
          align(
                center,
                slope_field(
                            F3,
                            scale_segments: .75,
                            xlim: (-1.5*calc.pi, 2*calc.pi),
                            ylim: (-2*calc.pi, 2*calc.pi),
                            slope_color: blue,
                            spacing: 1
                          ),
                )
        }
    ],
    solution: [
      + $y'=cos(y)$
      + $y'=y cos(x)$
      + $y'=sin(x)$
    ],
    citation: [_Notes on Diffy Q's_ by Jiří Lebl 1.2.104],
  ),
  (
    statement: [
      Match the following systems to the vector fields below:#v(.25em)
      - $cases(x'=y^2, y'=-x^2)$#v(.7em)
      - $cases(x'=y, y'=(x-1)(x+1))$#v(.7em)
      - $cases(x'=y+x^2, y'=-x)$#v(.7em)
      #let F1(x,y)=(y, (x -1)*(x+1))
      #let F2(x,y)=(y+x*x, -x)
      #let F3(x,y)=(y*y, -x*x)
      + #align(
                center,
                {
                  vector_field(
                                F1,
                                xlim: (-2, 2),
                                ylim: (-2, 2),
                                spacing: (.25, .25),
                                scale_segments: 10.0,
                                width: 6.5cm,
                                height: 5cm,
                                xaxis: (position: 0, tip: tiptoe.stealth, subticks: none, ticks: none),
                                yaxis: (position: 0, tip: tiptoe.stealth, subticks: none, ticks: none),
                              )
                }
              )
      + #align(
                center,
                {
                  vector_field(
                                F2,
                                xlim: (-2, 2),
                                ylim: (-2, 2),
                                spacing: (.3, .3),
                                scale_segments: 10.0,
                                width: 6.5cm,
                                height: 5cm,
                                xaxis: (position: 0, tip: tiptoe.stealth, subticks: none, ticks: none),
                                yaxis: (position: 0, tip: tiptoe.stealth, subticks: none, ticks: none),
                              )
                }
              )
      + #align(
                center,
                {
                  vector_field(
                                F3,
                                xlim: (-2, 2),
                                ylim: (-2, 2),
                                spacing: (.25, .25),
                                scale_segments: 7.5,
                                width: 6.5cm,
                                height: 5cm,
                                xaxis: (position: 0, tip: tiptoe.stealth, subticks: none, ticks: none),
                                yaxis: (position: 0, tip: tiptoe.stealth, subticks: none, ticks: none),
                              )
                }
              )
    ],
    solution: [#v(.7em)
      + $cases(x'=y, y'=(x-1)(x+1))$#v(.7em)
      + $cases(x'=y+x^2, y'=-x)$#v(.7em)
      + $cases(x'=y^2, y'=-x^2)$
    ],
    citation: [_Notes on Diffy Q's_ by Jiří Lebl 3.1.102],
  ),
  (
    statement: [
      Match the following phase portraits to their corresponding component graphs and describe their behaviour.

      #let F0(x,y)=(x,y)
      #let F1(x,y)=(x*(y+3), y)
      #let F2(x,y)=(calc.sin(y), calc.sin(x))
      #let F3(x,y)=(calc.tan(x), calc.tan(x))
      #let _Delta = 0.005
      #let steps = 510
      #let soln0 = solve_2d_ivp(F0, (1, 2), steps, Delta: _Delta, method: "rk4")
      #let soln1 = solve_2d_ivp(F1, (-1, -0.5), steps, Delta: _Delta, method: "euler")
      #let soln2 = solve_2d_ivp(F2, (-1, 2), steps, Delta: _Delta, method: "rk4")
      #let soln3 = solve_2d_ivp(F3, (0.5, 0.25), steps, Delta: _Delta, method: "improved_euler")
      #let xs = lq.arange(0, _Delta * (steps + 1), step: _Delta)
      
      + #align(
                center,
                {
                  vector_field(
                                F0,
                                xlim: (-5, 5),
                                ylim: (-5, 5),
                                spacing: (.5, .5),
                                scale_segments: 20.0,
                                width: 6cm,
                                height: 5cm,
                                xaxis: (position: 0, tip: tiptoe.stealth, subticks: none, ticks: none),
                                yaxis: (position: 0, tip: tiptoe.stealth, subticks: none, ticks: none),
                              )
                }
              )
      + #align(
                center,
                {
                  vector_field(
                                F1,
                                xlim: (-5, 5),
                                ylim: (-5, 5),
                                spacing: (.5, .5),
                                scale_segments: 10.0,
                                width: 6cm,
                                height: 5cm,
                                xaxis: (position: 0, tip: tiptoe.stealth, subticks: none, ticks: none),
                                yaxis: (position: 0, tip: tiptoe.stealth, subticks: none, ticks: none),
                              )
                }
              )
      + #align(
                center,
                {
                  vector_field(
                                F2,
                                xlim: (-3, 3),
                                ylim: (-3, 3),
                                spacing: (.25, .25),
                                scale_segments: 25.0,
                                width: 6cm,
                                height: 5cm,
                                xaxis: (position: 0, tip: tiptoe.stealth, subticks: none, ticks: none),
                                yaxis: (position: 0, tip: tiptoe.stealth, subticks: none, ticks: none),
                              )
                }
              )
      + #align(
                center,
                {
                  vector_field(
                                F3,
                                xlim: (-1*calc.pi, 1*calc.pi),
                                ylim: (-1*calc.pi, 1*calc.pi),
                                spacing: (.35, .35),
                                scale_segments: 2.5,
                                width: 6cm,
                                height: 5cm,
                                xaxis: (position: 0, tip: tiptoe.stealth, subticks: none, ticks: none),
                                yaxis: (position: 0, tip: tiptoe.stealth, subticks: none, ticks: none),
                              )
                }
              )
      (1) #align(
        center,
        {
          lq.diagram(
            lq.plot(
              xs,
              soln0.map(((x, y)) => x),
              mark: none,
              color: purple,
            ),
            lq.plot(
              xs,
              soln0.map(((x, y)) => y),
              mark: none,
              color: red,
            ),
            xaxis: (position: 0, tip: tiptoe.stealth, subticks: none, ticks: none, label: $t$),
            yaxis: (position: 0, tip: tiptoe.stealth, subticks: none, ticks: none),
          )
        }
      )
      (2) #align(
        center,
        {
          lq.diagram(
            lq.plot(
              xs,
              soln1.map(((x, y)) => x),
              mark: none,
              color: purple,
            ),
            lq.plot(
              xs,
              soln1.map(((x, y)) => y),
              mark: none,
              color: red,
            ),
            xaxis: (position: 0, tip: tiptoe.stealth, subticks: none, ticks: none, label: $t$),
            yaxis: (position: 0, tip: tiptoe.stealth, subticks: none, ticks: none),
          )
        }
      )
      (3) #align(
        center,
        {
          lq.diagram(
            lq.plot(
              xs,
              soln2.map(((x, y)) => x),
              mark: none,
              color: purple,
            ),
            lq.plot(
              xs,
              soln2.map(((x, y)) => y),
              mark: none,
              color: red,
            ),
            xaxis: (position: 0, tip: tiptoe.stealth, subticks: none, ticks: none, label: $t$),
            yaxis: (position: 0, tip: tiptoe.stealth, subticks: none, ticks: none),
          )
        }
      )
      (4) #align(
        center,
        {
          lq.diagram(
            lq.plot(
              xs,
              soln3.map(((x, y)) => x),
              mark: none,
              color: purple,
            ),
            lq.plot(
              xs,
              soln3.map(((x, y)) => y),
              mark: none,
              color: red,
            ),
            xaxis: (position: 0, tip: tiptoe.stealth, subticks: none, ticks: none, label: $t$),
            yaxis: (position: 0, tip: tiptoe.stealth, subticks: none, ticks: none),
          )
        }
      )
    ],
    solution: [
      + (1)
      + (2)
      + (3)
      + (4)
    ],
  ),
  (
    statement: [
      Consider the phase portraits of the systems of differential equations in question 2. Draw their component graphs and describe their behaviour. Hint: are they increasing/decreasing/constant?
    ],
  ),
  (
    statement:[
      A newly constructed waterpark features a huge splashpad with multiple fountains (and drains of course). It turns out the architect took MAT244, and had modeled the layout of this splashpad using a system of differential equations.

      $cases(x'=sin(x), y'=sin(y))$
      
      sketch the phase portrait of this system, and describe the behaviour of the water flow near the equilibrium points (i.e. can you tell where the fountains and drains are at?).
    ],
    solution:[
      #let F(x,y)=(calc.sin(x), calc.sin(y))
      #align(
                center,
                {
                  vector_field(
                                F,
                                xlim: (-5, 5),
                                ylim: (-5, 5),
                                spacing: (.35,.35),
                                scale_segments: 50.0,
                                width: 6cm,
                                height: 6cm,
                                xaxis: (position: 0, tip: tiptoe.stealth, subticks: none, ticks: none),
                                yaxis: (position: 0, tip: tiptoe.stealth, subticks: none, ticks: none),
                              )
                }
              )
    ]
  ),
  (
    statement:[
      Now, Flik (an ant) is escaping from the resurrected Hopper and has to jump off from a tree. He parachutes using a leaf and lands in the splashpad in question 9. Upon touching the water, he must follow the direction of the current.

      + If he lands at the point $(0.65, 0.2)$, draw the component graph of his journey.
      + If he could land anywhere, is it possible for Flik to survive? Or will he succumb to an unavoidable fate of falling down the drain?
    ],
    solution:[
      #let F(x,y)=(calc.sin(x), calc.sin(y))
      #let _Delta = 0.005
      #let steps = 2000
      #let soln = solve_2d_ivp(F, (0.65, 0.2), steps, Delta: _Delta, method: "rk4")
      #let xs = lq.arange(0, _Delta * (steps + 1), step: _Delta)

      + #align(
        center,
        {
          lq.diagram(
            lq.plot(
              xs,
              soln.map(((x, y)) => x),
              mark: none,
              color: purple,
            ),
            lq.plot(
              xs,
              soln.map(((x, y)) => y),
              mark: none,
              color: red,
            ),
            xaxis: (position: 0, tip: tiptoe.stealth, subticks: none, ticks: none, label: $t$),
            yaxis: (position: 0, tip: tiptoe.stealth, subticks: none, ticks: none),
          )
        }
      )

      + Flik could survive if he lands on a fountain (repelling equilibrium point) and awaits rescue. However, if he misses, then his fate is sealed.
    ],
  ),
)
