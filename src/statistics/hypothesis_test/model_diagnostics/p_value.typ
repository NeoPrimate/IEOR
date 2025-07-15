#import "@preview/cetz:0.3.4"
#import "@preview/fletcher:0.5.7" as fletcher: diagram, node, edge
#import "@preview/cetz:0.3.1": canvas, draw
#import "@preview/cetz-plot:0.1.0": plot
#import "@preview/suiji:0.4.0"

#import "../../../utils/examples.typ": eg
#import "../../../utils/code.typ": code
#import "../../../utils/color_math.typ": colorMath

=== p-Values

Probability of obtaining results at least as extreme as the observed results

1. One-Tailed

$
p = P(Z > z_"observed")
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
          domain: (1.5, 4),
          x => norm(x),
          x1 => 0,
          style: (fill: red.lighten(75%), stroke: none),
          label: none
        )

        plot.add-vline(
          1.5,
          style: (stroke: 0.5pt + gray, dash: "dashed"),
        )
      })
  })
]

2. Two-Tailed

$
p = 2 dot P(Z > |z_"observed"|)
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
          domain: (2, 4),
          x => norm(x),
          x1 => 0,
          style: (fill: red.lighten(75%), stroke: none),
          label: none
        )

        plot.add-vline(
          -2,
          style: (stroke: 0.5pt + gray, dash: "dashed"),
        )
        
        plot.add-fill-between(
          domain: (-4, -2),
          x => norm(x),
          x1 => 0,
          style: (fill: red.lighten(75%), stroke: none),
          label: none
        )

        plot.add-vline(
          2,
          style: (stroke: 0.5pt + gray, dash: "dashed"),
        )
      })
  })
]

#code[
  ```python
  z = 2.1
  df = 3
  scipy.stats.norm.sf(abs(z), df=df)

  ```
]