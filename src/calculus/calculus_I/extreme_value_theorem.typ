#import "../../utils/examples.typ": eg
#import "../../utils/code.typ": code
#import "../../utils/color_math.typ": colorMath
#import "../../utils/result.typ": result

#import "@preview/cetz:0.2.2"

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
      cetz.plot.plot(
        x-tick-step: 2, 
        y-tick-step: 2,
        y-min: -4,
        y-max: 4,
        x-min: -4,
        x-max: 4,
        mark-style: (fill: black, stroke: black),
        {
          cetz.plot.add(
            f, 
            domain: (-4, 4), 
            style: (stroke: black),
            label: none
          )
          cetz.plot.add(
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
      cetz.plot.plot(
        x-tick-step: 1, 
        y-tick-step: 50,
        y-min: 0,
        y-max: 100,
        x-min: 0,
        x-max: 1,
        mark-style: (fill: black, stroke: black),
        {
          cetz.plot.add(
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

=== Critical points

A critical point of a function $f(x)$ is a point in the domain where either:

- $f'(x) = 0$

- $f'(x)$ is undefined

#eg[
  $f(x)=1/x$ on $(0,1]$ has no maximum because it keeps increasing as $x arrow 0$.

  #let f(x) = calc.pow(x, 3) - 3 * x + 1
  #let f_prime(x) = 3 * calc.pow(x, 2) - 3


  #align(center)[
    #cetz.canvas(length: 6cm, {
      cetz.plot.plot(
        x-tick-step: 1, 
        y-tick-step: 1,
        y-min: -5,
        y-max: 5,
        x-min: -3,
        x-max: 3,
        axis-style: "school-book",
        {
          cetz.plot.add(
            f, 
            domain: (-3, 3), 
            style: (stroke: blue),
            label: $f(x)$
          )
          cetz.plot.add(
            f_prime, 
            domain: (-3, 3), 
            style: (stroke: red),
            label: $f'(x)$
          )
        }
      )
    })
  ]
]

=== Global vs. Local Extrema

- $f(c)$ is a *relative maximum* if $f(c) gt.eq f(x)$ for all $x in (c - h, c + h)$ for $h gt 0$

- $f(d)$ is a *relative minimum* if $f(d) lt.eq f(x)$ for all $x in (d - h, d + h)$ for $h gt 0$

=== First and Second Derivative Tests

First Derivative Test and the Second Derivative Test are used to classify critical points, and both aim to determine whether the point is a local maximum, local minimum, or neither

==== First Derivative Test

If $f'(x)$ changes sign around a critical point $c$, we can determine if $f(c)$ is a local maximum or minimum:

- If $f'(x)$ changes from *positive to negative* at $c$, then $f(c) $ is a *local maximum*

- If $f'(x)$ changes from *negative to positive* at $c$, then $f(c)$ is a *local minimum*

- If $f'(x) $does *not* change sign, $f(c)$ is *not* a local extremum

#eg[
  Function:

  $
    f(x) &= x^3 - 3x \ \
  $

  Derivative:
  
  $
    f'(x) 
    &= 3x^2 - 3 \
    &= 3(x - 1)(x + 1)
  $

  Critical points ($f'(x) = 0$): 
  
  - $x = -1$
  - $x = 1$ 
  
  Analysis of $f'(x)$
  - Pick point left of $-1$, say $x = -2$:

  #h(5em) $f'(-2) = 3(4-1) = 9 gt 0 arrow$ *increasing*
  
  - Pick a point between $-1$ and $1$, say $x = 0$:

  #h(5em) $f'(0) = -3 lt 0 arrow$ *decreasing*
  
  - Pick a point right of $1$, say $x = 2$:
  
  #h(5em) $f'(2) = 3(4 - 1) = 9 gt 0 arrow$ *increasing*

  Conclusion

  - At $x = -1$, $f'(x)$ changes from *positive to negative* $arrow$ *local maximum*

  - At $x = 1$, $f'(x)$ changes from *negative to positive* $arrow$ *local minimum*

  #let f(x) = calc.pow(x, 3) - 3 * x

  #align(center)[
    #cetz.canvas(length: 6cm, {
      cetz.plot.plot(
        x-min: -2.5,
        x-max: 2.5,
        y-min: -4,
        y-max: 4,
        x-tick-step: 1,
        y-tick-step: 2,
        mark-style: (fill: black),
        {
          cetz.plot.add(
            f,
            domain: (-2.5, 2.5),
            style: (stroke: black),
            label: none
          )
          cetz.plot.add(
            ((-1, 2),),
            mark: "o",
            mark-size: 0.04,
            mark-style: (fill: black, stroke: black)
          )
          cetz.plot.add(
            ((1, -2),),
            mark: "o",
            mark-size: 0.04,
            mark-style: (fill: black, stroke: black)
          )
        }
      )
    })
  ]
]

==== Second Derivative Test

If $f''(x)$ is continuous near a critical point $c$, and $f'(c) = 0$, then:

- If $f''(c) > 0$, then $f(c)$ is a *local minimum* (concave up)

- If $f''(c) < 0$, then $f(c)$ is a *local maximum* (concave down)

- If $f''(c) = 0$, the test is *inconclusive* — use the first derivative test or other methods

#eg[
  Function:

  $
    f(x) = x^4 - 4x^2
  $
  
  First Derivative:
  
  $
    f'(x) = 4x^3 - 8x
  $
  
  Second Derivative:
  
  $
    f''(x) = 12x^2 - 8
  $

  Critical points ($f'(x) = 0$):
  
  - $x = 0$

  - $x =  sqrt(2)$

  - $x = - sqrt(2)$

  Evaluate $f''(x)$ at each point

  - At $x = 0$

  #h(5em) $f''(0) = 12(0)^2 - 8 = -8 arrow$ *concave down* $arrow$ *local maximum*
  
  - At $x = sqrt(2)$ or $x = - sqrt(2)$

  #h(5em) $f''(sqrt(2)) = f''(- sqrt(2)) = 12(2)^2 - 8 = 16 arrow$ *concave up* $arrow$ *local minimum*

  #let f(x) = calc.pow(x, 4) - 4 * calc.pow(x, 2)

  #align(center)[
    #cetz.canvas(length: 6cm, {
      cetz.plot.plot(
        x-min: -3,
        x-max: 3,
        y-min: -5,
        y-max: 5,
        x-tick-step: 1,
        y-tick-step: 5,
        mark-style: (fill: black),
        {
          cetz.plot.add(
            f,
            domain: (-3, 3),
            style: (stroke: black),
            label: none
          )
          cetz.plot.add(
            ((0, 0),),
            mark: "o",
            mark-size: 0.04,
            mark-style: (fill: black, stroke: black)
          )
          cetz.plot.add(
            ((-calc.sqrt(2), -4),),
            mark: "o",
            mark-size: 0.04,
            mark-style: (fill: black, stroke: black)
          )
          cetz.plot.add(
            ((calc.sqrt(2), -4),),
            mark: "o",
            mark-size: 0.04,
            mark-style: (fill: black, stroke: black)
          )
        }
      )
    })
  ]
]
