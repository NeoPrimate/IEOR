#import "../../utils/examples.typ": eg
#import "../../utils/code.typ": code
#import "../../utils/color_math.typ": colorMath
#import "../../utils/result.typ": result

#import "@preview/cetz:0.3.4"
#import "@preview/cetz-plot:0.1.1"

== Extreme Value Theorem

The Extreme Value Theorem states that if a function $f(x)$ is continuous on a closed interval $[a,b]$, then $f(x)$ must attain both a maximum and a minimum value within that interval. This means there exist points $c, d in [a, b]$ such that:

$
  f(c) gt.eq f(x) quad "and" quad f(d) lt.eq f(x) quad "for all" quad x in [a, b]
$

1. *Continuity*: The function must be continuous on $[a, b]$. Discontinuities (jumps, asymptotes, holes) can prevent the function from attaining an extreme value

#eg[
  #let c = 3
  #let f(x) = -x * x + c

  #align(center)[
    #cetz.canvas(length: 6cm, {
      import cetz.draw: *
      import cetz-plot: *

      plot.plot(
        x-tick-step: 2, 
        y-tick-step: 2,
        y-min: -4,
        y-max: 4,
        x-min: -4,
        x-max: 4,
        mark-style: (fill: black, stroke: black),
        {
          plot.add(
            f, 
            domain: (-4, 4), 
            style: (stroke: black),
            label: none
          )
          plot.add(
            ((0,c),),
            mark: "o",
            mark-size: 0.04,
            mark-style: (fill: white)
          )
        }
      )
    })
  ]
]


2. *Closed Interval*: If the function is defined on an open interval $(a,b)$, an extremum may not exist

#eg[
  $f(x)=1/x$on $(0,1]$ has no maximum because it keeps increasing as $x arrow 0$.

  #let f(x) = 1 / x

  #align(center)[
    #cetz.canvas(length: 6cm, {
      import cetz.draw: *
      import cetz-plot: *

      plot.plot(
        x-tick-step: 1, 
        y-tick-step: 50,
        y-min: 0,
        y-max: 100,
        x-min: 0,
        x-max: 1,
        mark-style: (fill: black, stroke: black),
        {
          plot.add(
            f, 
            domain: (0.001, 1), 
            style: (stroke: black),
            label: none
          )
        }
      )
    })
  ]
]
