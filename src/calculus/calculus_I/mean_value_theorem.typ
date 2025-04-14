#import "../../utils/examples.typ": eg
#import "../../utils/code.typ": code
#import "../../utils/color_math.typ": colorMath
#import "../../utils/result.typ": result
#import "@preview/cetz:0.3.1": canvas, draw
#import "@preview/cetz-plot:0.1.0": plot
#import "../../utils/blob.typ": draw-blob

#import "@preview/cetz:0.3.1"

== Mean Value Theorem

Let $f: [a, b] arrow RR$ be a function tha satifies the following conditions:

1. $f$ is *continuous* on the closed interval $[a, b]$

2. $f$ is *differentiable* on the open interval $(a, b)$

Then there exists at least one point $c in (a, b)$ such that

$
  f'(c) = (f(b) - f(a)) / (b - a)
$

This means that the instantaneous rate of change (derivative) at some point $c$ is equal to the average rate of change over the entire interval

#eg[

  Consider $f(x) = x^2$ on $[1, 3]$

  - The average rate of change is:

  $
    (f(3) - f(1)) / (3 - 1) = (9 - 1) / 2 = 4
  $

  - The derivative for $f(x)$ is $f'(x) = 2x$

  - Setting $f'(c) = 4$, we solve:

  $
    2c = 4 arrow.double c = 2
  $

  Thus, at $c = 2$, the instantaneous rate of change matches the average rate of change

  #let f(x) = calc.pow(x, 2)
  #let df(x) = 2 * x

  #let (a, b) = (1, 3)
  #let secant_slope = (f(b) - f(a)) / (b - a)
  #let secant_line(x) = secant_slope * (x - a) + f(a)

  #let c = secant_slope / 2
  #let tangent_slope = df(c)
  #let tangent_line(x) = tangent_slope * (x - c) + f(c)

  #align(center)[
    #canvas({
      import draw: *
      
      plot.plot(
        size: (10, 10),
        axis-style: "school-book",
        x-tick-step: 1,
        x-min: -1., 
        x-max: 4.,
        y-tick-step: 2, 
        y-min: -5., 
        y-max: 12.,
        legend: "north-east",
        {
          plot.add(
            f, 
            domain: (0, 4), 
            style: (stroke: black),
            label: $f(x) = x^2$
          )
          plot.add(
            ((a, f(a)),),
            mark: "o",
            mark-size: 0.2,
            mark-style: (fill: blue, stroke: none),
          )
          plot.add(
            ((b, f(b)),),
            mark: "o",
            mark-size: 0.2,
            mark-style: (fill: blue, stroke: none),
          )
          plot.add(
            ((b, f(b)),),
            mark: "o",
            mark-size: 0.2,
            mark-style: (fill: blue, stroke: none),
          )
          plot.add(
            ((c, tangent_line(c)),),
            mark: "o",
            mark-size: 0.2,
            mark-style: (fill: red, stroke: none),
          )
          plot.add(
            secant_line, 
            domain: (0, 4), 
            style: (stroke: blue),
            label: "Secant Line"
          )
          
          plot.add(
            tangent_line, 
            domain: (0, 4), 
            style: (stroke: red),
            label: "Tangent Line at c"
          )
        })
    })
  ]

]