#import "../../utils/examples.typ": eg
#import "../../utils/code.typ": code
#import "../../utils/color_math.typ": colorMath
#import "../../utils/result.typ": result
#import "@preview/cetz:0.3.1": canvas, draw
#import "@preview/cetz-plot:0.1.0": plot
#import "../../utils/blob.typ": draw-blob

#import "@preview/cetz:0.3.1"

== Implicit Differentiation

When a function is not explicitly solved for one variable in terms of another. E.g.: \

$
  x^2 + y^2 = 1
$ 

Instead of solving for $y$ explicitly in terms of $x$, implicit differentiation allows you to differentiate both sides of an equation directly, treating $y$ as an implicit function of $x$.

*Steps for Implicit Differentiation*

1. Differentiate both sides of the equation with respect to $x$, treating y as a function of $x$

2. Apply the chain rule whenever differentiating $y$, since $y = y(x)$

2. Solve for $(d x) / (d y)$

#eg[
  $
    x^2 + y^2 = 1
  $

  1. Differentiate both sides

  $
    d / (d x) [colorMath(x^2, #red) + colorMath(y^2, #red)] &= d / (d x) [colorMath(1, #red)] \
    d / (d x) [colorMath(x^2, #red)] + d / (d x) [colorMath(y^2, #red)] &= d / (d x) [colorMath(1, #red)] \
    d / (d x) [colorMath(x^2, #red)] + d / (d x) [colorMath(y^2, #red)] &= 0 \
  $
  
  2. Apply the chain rule to $y^2$

  $
    2x + 2y (d y) / (d x) &= 0
  $

  3. Slove for $(d y) / (d x)$

  $ 
    2y dot (d y) / (d x) &= -2x \
    (d y) / (d x) &= (-2x) / (2y) \
    (d y) / (d x) &= - x / y \
  $
]

#let f(x) = calc.sqrt(calc.pow(5, 2) - calc.pow(x, 2))
#let g(x) = -calc.sqrt(calc.pow(5, 2) - calc.pow(x, 2))
#let point = (3, 4)
#let tangent(x) = -(3/4) * x + (25 / 4)

#align(center)[
  #canvas({
    import draw: *
    
    plot.plot(
      size: (5, 5),
      axis-style: "school-book",
      x-tick-step: 2,
      x-min: -6., 
      x-max: 6.,
      y-tick-step: 2, 
      y-min: -6., 
      y-max: 6.,
      legend: "north-east",
      {
        plot.add(
          f, 
          domain: (-5, 5), 
          style: (stroke: blue),
          label: none
        )
        plot.add(
          g, 
          domain: (-5, 5), 
          style: (stroke: blue),
          label: $x^2 + y^2 = 5^2$
        )
        plot.add(
          tangent, 
          domain: (-5, 6), 
          style: (stroke: red),
          label: none
        )
        plot.add(
          (point,),
          mark: "o",
          mark-size: 0.2,
          mark-style: (fill: blue, stroke: none),
        )
      })
  })
]

$
  x^2 + y^2 = 5^2 \

  2x d x + 2y d y = 0 \

  (d y) / (d x) = - x / y
$

