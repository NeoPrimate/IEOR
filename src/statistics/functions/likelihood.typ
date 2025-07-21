#import "../../utils/examples.typ": eg
#import "../../utils/code.typ": code
#import "../../utils/color_math.typ": colorMath
#import "../../utils/result.typ": result
#import "../../utils/distributions/gaussian.typ": gaussian_pdf, gaussian_cdf
#import "@preview/cetz-plot:0.1.0": plot

#import "@preview/cetz:0.3.4":  canvas, draw

== Likelihood

$
  #math.cal("L") (theta | x) = f(x | theta)
$

Where:
- $theta$: model parameters
- $x$: observed data

#align(center)[
  #canvas({
    import draw: *

    set-style(
      axes: (
        x: (stroke: 0pt),
        y: (stroke: 0pt, tick: (label: (offset: 1em))),
        shared-zero: false
      )
    )

    let mu = 0
    let sigma = 1
    
    plot.plot(
      size: (10, 3),
      axis-style: "school-book",
      x-tick-step: none,
      y-tick-step: none, 
      x-label: [],
      y-label: [],
      x-min: -4., 
      x-max: 4.,
      y-min: 0., 
      y-max: 0.4,
      legend: "inner-north-west",
      {
        plot.add(
          x => gaussian_pdf(x, mu, sigma), 
          domain: (-5, 5), 
          style: (stroke: black),
        )
        
        plot.add(
          ((1, gaussian_pdf(1, mu, sigma)),),
          mark: "o",
          mark-size: 0.2,
          mark-style: (fill: red, stroke: 1pt),
        )

        plot.add-vline(
          1, 
          max: gaussian_pdf(1, mu, sigma),
          style: (stroke: (paint: red, dash: "dashed")),
        )
      })
  })
]