#import "../../utils/examples.typ": eg
#import "../../utils/code.typ": code
#import "../../utils/color_math.typ": colorMath
#import "../../utils/result.typ": result
#import "@preview/cetz:0.3.1": canvas, draw
#import "@preview/cetz-plot:0.1.0": plot


#import "@preview/cetz:0.3.4"

== CDF (Cumulative Distribution Function)

Gives the probability that $X$ will take a value less than or equal to $x$

$
F(x) = P(X ≤ x)
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
          style: (stroke: gray),
        )

        plot.add-fill-between(
          domain: (-4, 1),
          x => norm(x),
          x1 => 0,
          style: (fill: red.lighten(75%), stroke: none),
          label: none
        )
      })
  })
]

1. Categorical

$
F(x) = integral_(-infinity)^x f(t) d t
$

2. Continuous

$
F(x) = sum_(t ≤ x) P(X = t)
$

#code[
```python
from scipy.stats import norm

x = 1
mu = 0
sigma = 1

norm.cdf(x, loc=mu, scale=sigma)
```
]