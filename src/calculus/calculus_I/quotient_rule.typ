#import "../../utils/examples.typ": eg
#import "../../utils/code.typ": code
#import "../../utils/color_math.typ": colorMath
#import "../../utils/result.typ": result
#import "@preview/cetz:0.3.1": canvas, draw
#import "@preview/cetz-plot:0.1.0": plot


#import "@preview/cetz:0.3.4"

== Quotient Rule

$
  d / (d x) [colorMath(f(x), #blue) / colorMath(g(x), #red)] = (colorMath(f'(x), #blue) colorMath(g(x), #red) - colorMath(f(x), #blue) colorMath(g'(x), #red)) / [colorMath(g(x), #red)]^2
$

#eg[
  $
    d / (d x) [colorMath(x^2, #blue) / colorMath(cos(x), #red)]
  $

  $
    colorMath(f(x) = x^2, #blue) quad quad colorMath(g(x) = cos(x), #red) \
    colorMath(f'(x) = 2x, #blue) quad quad colorMath(g'(x) = -sin(x), #red) \
  $

  $
    d / (d x) [colorMath(x^2, #blue) / colorMath(cos(x), #red)] = (colorMath(2x, #blue) colorMath(cos(x), #red) - colorMath(x^2, #blue) (colorMath(-sin(x), #red))) / [colorMath(cos(x), #red)]^2
  $
]

#let tangent(x) = (
  calc.sin(x) / calc.cos(x)
)

#let secant(x) = (
  1 / calc.pow(calc.cos(x), 2)
)

#let cosecant(x) = (
  1 / calc.sin(x)
)

#let cotangent(x) = (
  calc.cos(x) / calc.sin(x)
)

#let secant(x) = (
  1 / calc.cos(x)
)

#let secant_prime(x) = (
  tangent(x) * secant(x)
)

#let cosecant_prime(x) = (
  cotangent(x) * cosecant(x)
)

=== *$tan(x)$*

$
  d / (d x) [tan(x)] 
  &= d / (d x) [sin(x) / cos(x)] \
  &= (cos(x) dot cos(x) - sin(x) dot -sin(x)) / (cos^2(x)) \
  &= (cos^2(x) + sin^2(x)) / (cos^2(x)) \
  &= result(1 / (cos^2(x))) \
  &= result(sec^2(x)) \
$

#align(center)[
    #canvas({
      import draw: *
      
      plot.plot(
        size: (8, 8),
        axis-style: "school-book",
        x-tick-step: 1,
        x-min: -5., 
        x-max: 5.,
        y-tick-step: 1, 
        y-min: -5, 
        y-max: 5,
        legend: "inner-south-east",
        legend-style: (
          padding: 5pt,
          item: (
            spacing: 0.25,
          )
        ),
        {
          plot.add(
            calc.tan,
            domain: (-5, 5), 
            style: (stroke: blue),
            label: $tan(x)$
          )
          plot.add(
            secant, 
            domain: (-5, 5), 
            style: (stroke: red),
            label: $sec^2(x)$
          )
        })
    })
  ]

=== *$cot(x)$*

$
  d / (d x) [cot(x)] 
  &= d / (d x) [cos(x) / sin(x)] \
  &= (cos(x) dot cos(x) - sin(x) dot -sin(x)) / (cos^2(x)) \
  &= (-sin^2(x) -cos^2(x)) / () \
  &= result(- 1 / sin^2(x)) \
  &= result(- csc^2(x)) \
$

#align(center)[
    #canvas({
      import draw: *
      
      plot.plot(
        size: (8, 8),
        axis-style: "school-book",
        x-tick-step: 1,
        x-min: -5., 
        x-max: 5.,
        y-tick-step: 1, 
        y-min: -5, 
        y-max: 5,
        legend: "inner-south-east",
        legend-style: (
          padding: 5pt,
          item: (
            spacing: 0.25,
          )
        ),
        {
          plot.add(
            cotangent,
            domain: (-5, 5), 
            style: (stroke: blue),
            label: $cot(x)$
          )
          plot.add(
            secant, 
            domain: (-5, 5), 
            style: (stroke: red),
            label: $csc^2(x)$
          )
        })
    })
  ]


=== *$sec(x)$*

$
  d / (d x) [sec(x)] 
  &= d / (d x) [1 / cos(x)] \
  &= (0 dot cos(x) - 1 dot -sin(x)) / (cos^2(x)) \
  &= (0 + 1 dot sin(x)) / (cos^2(x)) \
  &= result(sin(x) / (cos^2(x))) \
  &= sin(x) / cos(x) dot 1 / cos(x) \
  &= result(tan(x) dot sec(x)) \
$

#align(center)[
    #canvas({
      import draw: *
      
      plot.plot(
        size: (8, 8),
        axis-style: "school-book",
        x-tick-step: 1,
        x-min: -5., 
        x-max: 5.,
        y-tick-step: 1, 
        y-min: -5, 
        y-max: 5,
        legend: "inner-south-east",
        legend-style: (
          padding: 10pt,
          item: (
            spacing: 0.30,
          )
        ),
        {
          plot.add(
            secant,
            domain: (-5, 5), 
            style: (stroke: blue),
            label: $sec(x)$
          )
          plot.add(
            secant_prime, 
            domain: (-5, 5), 
            style: (stroke: red),
            label: $sin(x) / (cos^2(x))$
          )
        })
    })
  ]

=== *$csc(x)$*

$
  d / (d x) [csc(x)] 
  &= d / (d x) [1 / sin(x)] \
  &= (0 dot sin(x) - 1 dot cos(x)) / (sin^2(x)) \
  &= (0 - 1 dot cos(x)) / (sin^2(x)) \
  &= result((-cos(x)) / (sin^2(x))) \
  &= - cos(x) / sin(x) dot 1 / sin(x) \
  &= result(cot(x) dot csc(x)) \
$

#align(center)[
  #canvas({
    import draw: *
    
    plot.plot(
      size: (8, 8),
      axis-style: "school-book",
      x-tick-step: 1,
      x-min: -5., 
      x-max: 5.,
      y-tick-step: 1, 
      y-min: -5, 
      y-max: 5,
      legend: "inner-south-east",
      legend-style: (
        padding: 10pt,
        item: (
          spacing: 0.30,
        )
      ),
      {
        plot.add(
          cosecant,
          domain: (-5, 5), 
          style: (stroke: blue),
          label: $csc(x)$
        )
        plot.add(
          cosecant_prime, 
          domain: (-5, 5), 
          style: (stroke: red),
          label: $(-cos(x)) / (sin^2(x))$
        )
      })
  })
]
