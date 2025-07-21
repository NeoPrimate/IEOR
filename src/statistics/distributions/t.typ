#import "../../utils/examples.typ": eg
#import "../../utils/code.typ": code
#import "../../utils/color_math.typ": colorMath
#import "../../utils/result.typ": result
#import "../../utils/distributions/t.typ": t_pdf
#import "@preview/cetz:0.3.1": canvas, draw
#import "@preview/cetz-plot:0.1.0": plot
#import "@preview/cetz:0.3.4"


== t-Distribution

$
f(t | nu) = (Gamma ((nu + 1) / 2)) / (sqrt(nu pi) Gamma (nu / 2)) (1 + t^2 / nu)^(-(nu + 1) / 2)
$

Where:
- $t$: t-statistic
- $nu$ (or $d f$): degrees of freedom
- $Gamma$: Gamma function (generalizes the factorial function)

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

    let nu = 10
    
    plot.plot(
      size: (7.5, 3),
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
          x => t_pdf(x, nu), 
          domain: (-5, 5), 
          style: (stroke: black),
        )
      })
  })
]

Continuous probability distribution for estimating the mean of a normally distributed population in situations where:

- Sample size is small 

- Population standard deviation is unknown

Similar in shape to the normal distribution but has heavier tails, which means it gives more probability to values further from the mean



