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

#let binomial(n, k, p) = (
  calc.binom(n, k) * calc.pow(p, k) * calc.pow((1 - p), n - k)
)

#let b1 = range(1, 25).map((n) => (n, binomial(n, 1, 0.3)))
#let b2 = range(1, 25).map((n) => (n, binomial(n, 1, 0.5)))
#let b3 = range(1, 25).map((n) => (n, binomial(n, 1, 0.9)))

#align(center)[
  #canvas({
    import draw: *
    
    plot.plot(
      size: (8, 8),
      axis-style: "school-book",
      x-tick-step: 5,
      x-min: 0., 
      y-tick-step: 0.1, 
      y-min: 0., 
      legend: "inner-north-west",
      {
        plot.add(
          b1, 
          domain: (1, 10), 
          style: (stroke: blue),
          mark: "o"
        )
        plot.add(
          b2, 
          domain: (1, 10), 
          style: (stroke: red),
          mark: "o"
        )
        plot.add(
          b3, 
          domain: (1, 10), 
          style: (stroke: green),
          mark: "o"
        )
      })
  })
]

