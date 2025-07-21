#import "../../utils/examples.typ": eg
#import "../../utils/code.typ": code
#import "../../utils/color_math.typ": colorMath
#import "../../utils/result.typ": result
#import "../../utils/distributions/exponential.typ": exponential_pdf
#import "@preview/cetz:0.3.1": canvas, draw
#import "@preview/cetz-plot:0.1.0": plot


#import "@preview/cetz:0.3.4"

== Exponential distribution

$
f(x bar lambda) = lambda e^(- lambda x)
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

    let lambda = 3
    
    plot.plot(
      size: (5, 3),
      axis-style: "school-book",
      x-tick-step: none,
      y-tick-step: none, 
      x-label: [],
      y-label: [],
      x-min: 0., 
      x-max: 2.,
      y-min: 0., 
      y-max: 3,
      legend: "inner-north-west",
      {
        plot.add(
          x => exponential_pdf(x, lambda), 
          domain: (0, 5), 
          style: (stroke: black),
        )
      })
  })
]



