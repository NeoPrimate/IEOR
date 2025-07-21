#import "../../utils/examples.typ": eg
#import "../../utils/code.typ": code
#import "../../utils/color_math.typ": colorMath
#import "../../utils/result.typ": result
#import "../../utils/distributions/poisson.typ": poisson_pmf
#import "@preview/cetz:0.3.1": canvas, draw
#import "@preview/cetz-plot:0.1.0": plot
#import "@preview/cetz:0.3.4"

== Poisson distribution

Used to model the number of events that occur within a fixed interval of time or space, given a constant mean rate and assuming that these events occur independently of each other

$
P(X = k) = (lambda^k e^(- lambda)) / k!
$

#align(center)[
  #canvas({
    import draw: *

    set-style(
      axes: (
        x: (stroke: 0pt), 
        y: (stroke: 0pt),
        shared-zero: false
      )
    )

    let n = 13
    let lambda = 3
    
    plot.plot(
      size: (5, 5),
      axis-style: "school-book",
      x-tick-step: none,
      y-tick-step: none, 
      x-label: [],
      y-label: [],
      x-min: 0., 
      x-max: n,
      y-min: 0., 
      y-max: 0.4,
      legend: "inner-north-west",
      {

        for k in range(n) {
          plot.add-vline(
            k,
            max: poisson_pmf(k, lambda),
            style: (stroke: (paint: black))
          )
        }

        plot.add(
          range(n).map(k => (k, poisson_pmf(k, lambda))), 
          mark: "o",
          domain: (-5, 5), 
          style: (stroke: none),
          mark-style: (fill: gray, stroke: 1pt),
        )

      })
  })
]