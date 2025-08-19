
#import "@preview/cetz:0.3.4"
#import "@preview/cetz-plot:0.1.1"
#import "@preview/cetz:0.4.0": canvas, draw, tree
#import "@preview/fletcher:0.5.7" as fletcher: diagram, node, edge


#import "../../utils/examples.typ": eg
#import "../../utils/code.typ": code
#import "../../utils/color_math.typ": colorMath
#import "../../utils/definition.typ": definition
#import "../../utils/titles.typ": *
#import "../../utils/resources.typ": *


#title_1[Taylor Series (Expansion)]

Taylor polynomial

Approximate a complicated function near a point $a$ by a polynomial made from the function's derivatives at that point

$
  f(x) = sum_(n=0)^infinity (f^((n))(a)) / n! (x - a)^n
$

$
  f(x) = 
    underbrace(
      underbrace(
        underbrace(
          f(a), 
          *
        ) 
        + f'(a) ((x - a)^1) / 1!, 
        **
      ) 
      + f''(a) ((x - a)^2) / 2!, 
      ***
    ) 
    + dots
$

Where:

- $*$: Ensures value of the polynomial matches with the value of $f$ when $x = a$
- $**$: Ensures slope of the polynomial matches with the slope of $f$ when $x = a$
- $***$: Ensures rate of change of the polynomial matches with the rate of change of $f$ when $x = a$

Where:
- $f^((n))(a)$: $n$-th derivative of $f$ evaluated at $a$

#eg[

  Setup

  $
    f(x) = x^2
  $

  Expand it around the point $a = 1$

  *Step 1*: Compute Derivatives

  - $f(x) = x^2$

  - $f'(x) = 2x$

  - $f''(x) = 2$

  *Step 2*: Evaluate at $x = 1$

  - $f(1) = 1^2 = 1$
  
  - $f'(1) = 2 dot 1 = 2$
  
  - $f''(1) = 2$

  *Step 3*: Write the Taylor expansion

  $
    f(x) 
    &= f(1) + f'(1)(x - 1) + (f''(1))/2! (x - 1)^2 \
    &= 1 + 2(x - 1) + 2/2 (x - 1)^2 \
    &= 1 + 2(x - 1) + (x - 1)^2
  $

  *Step 3*: Expand

  $
    1 + 2(x - 1) + (x - 1)^2 = 1 + 2x - 2 + x^2 + 1 = x^2
  $

  It gives back the original function exactly
]

#eg[

  #align(center)[

      #cetz.canvas({
        import cetz.draw: *
        import cetz-plot: *

        plot.plot(
          size: (8,8),
          axis-style: "school-book",
          x-tick-step: none, 
          y-tick-step: none, 
          x-label: [$x$],
          y-label: [$f(x)$],
          x-min: -5, x-max: 5,
          y-min: -5, y-max: 5,
          axes: (
            stroke: black,
            tick: (stroke: black),
          ),
          legend-style: (
            item: (spacing: .3),
            padding: 5pt,
            scale: 100%
          ),
        {

          plot.add(
            domain: (-5, 5),
            x => x,
            style: (stroke: (thickness: 1pt)),
          )
          
          plot.add(
            domain: (-5, 5),
            x => x - calc.pow(x, 3) / calc.fact(3),
            style: (stroke: (thickness: 1pt, paint: yellow)),
            label: $x - x^3 / 3!$
          )
          
          plot.add(
            domain: (-5, 5),
            x => x - calc.pow(x, 3) / calc.fact(3) + calc.pow(x, 5) / calc.fact(5),
            style: (stroke: (thickness: 1pt, paint: orange)),
            label: $x - x^3 / 3! + x^5 / 5!$
          )

          plot.add(
            domain: (-5, 5),
            x => x - calc.pow(x, 3) / calc.fact(3) + calc.pow(x, 5) / calc.fact(5) - calc.pow(x, 7) / calc.fact(7),
            style: (stroke: (thickness: 1pt, paint: green)),
            label: $x - x^3 / 3! + x^5 / 5! - x^7 / 7!$
          )

          plot.add(
            domain: (-5, 5),
            x => calc.sin(x),
            style: (stroke: (thickness: 2pt, paint: red)),
            label: $sin(x)$
          )
          

        }, name: "plot")
      })
    ]

    #align(center)[
      #cetz.canvas({
        import cetz.draw: *
        import cetz-plot: *

        plot.plot(
          size: (8,8),
          axis-style: "school-book",
          x-tick-step: none, 
          y-tick-step: none, 
          x-label: [$x$],
          y-label: [$f(x)$],
          x-min: -5, x-max: 5,
          y-min: -5, y-max: 5,
          axes: (
            stroke: black,
            tick: (stroke: black),
          ),
          legend-style: (
            item: (spacing: .3),
            padding: 5pt,
            scale: 100%
          ),
        {

          // Original function
          plot.add(
            domain: (-5, 5),
            x => calc.sin(x),
            style: (stroke: (thickness: 2pt, paint: red)),
            label: $sin(x)$
          )

          // 0th degree: sin(a)
          plot.add(
            domain: (-5, 5),
            x => 1,
            style: (stroke: (thickness: 1pt, paint: yellow)),
            label: $1$
          )

          plot.add(
            domain: (-5, 5),
            x => 1 - calc.pow(x - calc.pi/2, 2) / 2,
            style: (stroke: (thickness: 1pt, paint: orange)),
            label: $1 - ((x - pi/2)^2) / 2$
          )

          // 4th degree: add + (x - a)^4 / 24
          plot.add(
            domain: (-5, 5),
            x => 1 - calc.pow(x - calc.pi/2, 2)/2 + calc.pow(x - calc.pi/2, 4)/24,
            style: (stroke: (thickness: 1pt, paint: green)),
            label: $1 - ((x - pi/2)^2) / 2 + ((x - pi/2)^4 / 4!$
          )
        }, name: "plot")
      })
    ]


]

#resources[
  - #link("https://www.youtube.com/watch?v=3d6DsjIBzJ4&t=1s")[Tyler Series (3B1B)]

]

