#import "../../utils/examples.typ": eg
#import "../../utils/code.typ": code
#import "../../utils/color_math.typ": colorMath
#import "../../utils/result.typ": result

#import "@preview/cetz:0.3.4"
#import "@preview/cetz-plot:0.1.1"


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
      import cetz.draw: *
      import cetz-plot: *

      plot.plot(
        x-tick-step: 1, 
        y-tick-step: 1,
        y-min: -5,
        y-max: 5,
        x-min: -3,
        x-max: 3,
        axis-style: "school-book",
        legend-style: (
          // spacing: 0.3,
          item: (
            spacing: 0.025,
            preview: (
              width: 0.25,
            )
          )
        ),
        {
          plot.add(
            f, 
            domain: (-3, 3), 
            style: (stroke: blue),
            label: $f(x)$
          )
          plot.add(
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