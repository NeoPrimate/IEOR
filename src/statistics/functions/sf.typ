#import "../../utils/examples.typ": eg
#import "../../utils/code.typ": code
#import "../../utils/color_math.typ": colorMath
#import "../../utils/result.typ": result
#import "@preview/cetz:0.3.1": canvas, draw
#import "@preview/cetz-plot:0.1.0": plot


#import "@preview/cetz:0.3.4"

== SF (Survival Function)

Probability that a certain event has not occurred by a certain time

$
S(t) = P(T > t)
$

#align(center)[
  #canvas({
    import draw: *

    let mu = 0
    let sigma = 1

    let norm(x, mu: mu, sigma: sigma) = (
      (1 / calc.sqrt(2 * calc.pi * calc.pow(sigma, 2))) * calc.exp(-(calc.pow(x - mu, 2)) / (2 * calc.pow(sigma, 2)))
    )

    set-style(
      axes: (
        x: (stroke: 0pt), 
        y: (stroke: 0pt),
        shared-zero: false
      )
    )
    
    plot.plot(
      size: (9, 3),
      axis-style: "school-book",
      x-tick-step: none,
      y-tick-step: none,
      x-label: none,
      y-label: none, 
      x-min: -4., 
      x-max: 4.,
      y-min: 0., 
      y-max: 0.4,
      legend: "inner-north-west",
      {
        plot.add(
          norm, 
          domain: (-5, 5), 
          style: (stroke: black),
        )

        plot.add-fill-between(
          domain: (1, 4),
          x => norm(x),
          x1 => 0,
          style: (fill: red.lighten(75%), stroke: none),
          label: none
        )
      })
  })
]

Relationship to PDF:

$
S(t) = 1 - F(t)
$

#code(
  "sf.py",
  ```python
  from scipy.stats import norm

  z = 3.4
  mu = 0
  sigma = 1

  norm.sf(z, loc=mu, scale=sigma)
  ```
)