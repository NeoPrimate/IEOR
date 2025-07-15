#import "../../utils/examples.typ": eg
#import "../../utils/code.typ": code
#import "../../utils/color_math.typ": colorMath
#import "../../utils/result.typ": result
#import "@preview/cetz:0.3.1": canvas, draw
#import "@preview/cetz-plot:0.1.0": plot


#import "@preview/cetz:0.3.4"

== Gaussian (Normal) distribution

$
f(x bar mu, sigma^2) = 1 / (sqrt(2 pi sigma^2)) e^(-((x - mu)^2)/(2 sigma^2))
$

#let mu = 0
#let sigma = 1

#let norm(x, mu: mu, sigma: sigma) = (
  (1 / calc.sqrt(2 * calc.pi * calc.pow(sigma, 2))) * calc.exp(-(calc.pow(x - mu, 2)) / (2 * calc.pow(sigma, 2)))
)

#align(center)[
  #canvas({
    import draw: *
    
    plot.plot(
      size: (10, 3),
      axis-style: "school-book",
      x-tick-step: none,
      y-tick-step: none, 
      x-min: -4., 
      x-max: 4.,
      y-min: 0., 
      y-max: 0.4,
      legend: "inner-north-west",
      {
        plot.add(
          norm, 
          domain: (-5, 5), 
          style: (stroke: blue),
        )
      })
  })
]