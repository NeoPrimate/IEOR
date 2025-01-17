#import "../../utils/examples.typ": eg
#import "../../utils/code.typ": code
#import "../../utils/color_math.typ": colorMath
#import "../../utils/result.typ": result
#import "@preview/cetz:0.3.1": canvas, draw
#import "@preview/cetz-plot:0.1.0": plot


#import "@preview/cetz:0.2.2"

== Binomial distribution

Discrete probability distribution that describes the number of successes in a fixed number of independent Bernoulli trials, each with the same probability of success

$
P(X = k) = binom(n, k) p^k (1-p)^(n-k)
$

#figure(image("../../vis/binomial_distribution.png", width: 30%))

#let k = 4

#let points = range(0, 10).map((n) => (n, calc.binom(k, n)))

#align(center)[
  #canvas({
    import draw: *
    
    plot.plot(
      size: (8, 8),
      axis-style: "school-book",
      x-tick-step: 1,
      x-min: 0., 
      x-max: 10.,
      y-tick-step: 1, 
      y-min: 0., 
      y-max: 1.,
      legend: "inner-north-west",
      {
        plot.add(
          points, 
          domain: (1, 10), 
          style: (stroke: blue),
          label: $ binom(n, k) $
        )
      })
  })
]

#points


