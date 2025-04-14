#import "../../utils/examples.typ": eg
#import "../../utils/code.typ": code
#import "../../utils/color_math.typ": colorMath
#import "../../utils/result.typ": result
#import "@preview/cetz:0.3.1": canvas, draw
#import "@preview/cetz-plot:0.1.0": plot
#import "../../utils/blob.typ": draw-blob

#import "@preview/cetz:0.3.1"

== Inverse Functions

*1. Definition*

$
  colorMath(f(colorMath(f^(-1)(colorMath(x, #black)), #blue)), #red) = x \
  colorMath(f^(-1)(colorMath(f(colorMath(x, #black)), #red)), #blue) = x \
$

#align(center)[
  #cetz.canvas({
    draw-blob(
      2, (0, 0), 1.5,
      stroke: green,
      name: "blob1"
    )
    draw-blob(
      8, (5, 0), 1.5,
      n-pts: 10,
      stroke: orange,
      name: "blob2"
    )
    cetz.draw.circle(
      "blob1.center",
      radius: .05,
      fill: black,
      stroke: none,
      name: "x"
    )
    cetz.draw.circle(
      "blob2.center",
      radius: .05,
      fill: black,
      stroke: none,
      name: "y"
    )
    cetz.draw.content(
      "x", [$x$],
      anchor: "east",
      padding: 3pt
    )
    cetz.draw.content(
      "y", [$f(x)$],
      anchor: "west",
      padding: 3pt
    )
    let mid = (2.5, .5)
    cetz.draw.bezier-through(
      "x.north-east", mid, "y.north-west",
      stroke: blue + .5pt,
      mark: (end: ">", fill: blue),
      name: "arrow"
    )
    cetz.draw.content(
      mid, [$f$],
      anchor: "south",
      padding: 3pt
    )
    let mid = (2.5, -.5)
    cetz.draw.bezier-through(
      "y.north-east", mid, "x.north-west",
      stroke: blue + .5pt,
      mark: (end: ">", fill: blue),
      name: "arrow"
    )
    cetz.draw.content(
      mid, [$f^(-1)$],
      anchor: "north",
      padding: 3pt
    )
  })
]

A function $f: A arrow B$ has an inverse function $f^(-1)$ if and only if $f$ is *bijective* (i.e., both one-to-one and onto):

- *Injective (One-to-One)*: 
  
  $f(x_1) = f(x_2)$ implies $x_1 = x_2$

  No two inputs map to the same output 

- *Surjective (Onto)*:

  Every element in $B$ is mapped from some element in $A$

*2. Finding Inverse Function*

To determine $f^(-1)$:
- Express $y$ in terms of $x$: $y = f(x)$
- Solve for $x$ in terms of $y$
- Swap $x$ and $y$, remaining $y$ as $f^(-1)(x)$

*3. Graphical Representation*

The graph of $f^(-1)$ is a reflection of the graph of $f$ accress the line $x = y$

#let lin(x) = x

#let f(x) = 2 * x + 3
#let f_inv(x) = (x - 3) / 2

#align(center)[
  #canvas({
    import draw: *
    
    plot.plot(
      size: (5, 5),
      axis-style: "school-book",
      x-tick-step: 1,
      x-min: -3., 
      x-max: 3.,
      y-tick-step: 1, 
      y-min: -3., 
      y-max: 3.,
      legend: "north-east",
      {
        plot.add(
          f, 
          domain: (-3, 3), 
          style: (stroke: blue),
          label: $f(x) = 2x + 3$
        )
        plot.add(
          f_inv, 
          domain: (-3, 3), 
          style: (stroke: red),
          label: $f^(-1)(x) = (x - 3) / 2$
        )
        plot.add(
          lin, 
          domain: (-3, 3), 
          style: (stroke: gray),
          label: $x = y$
        )
      })
  })
]

#let f(x) = calc.pow(x, 2)
#let f_inv(x) = calc.sqrt(x)

#align(center)[
  #canvas({
    import draw: *
    
    plot.plot(
      size: (5, 5),
      axis-style: "school-book",
      x-tick-step: 1,
      x-min: 0., 
      x-max: 3.,
      y-tick-step: 1, 
      y-min: 0., 
      y-max: 3.,
      legend: "north-east",
      {
        plot.add(
          f, 
          domain: (-3, 3), 
          style: (stroke: blue),
          label: $f(x) = x^2$
        )
        plot.add(
          f_inv, 
          domain: (0, 3), 
          style: (stroke: red),
          label: $f^(-1)(x) = sqrt(x)$
        )
        plot.add(
          lin, 
          domain: (0, 3), 
          style: (stroke: gray),
          label: $x = y$
        )
      })
  })
]

#let f(x) = calc.pow(x, 3)
#let f_inv(x) = calc.root(x, 3)

#align(center)[
  #canvas({
    import draw: *
    
    plot.plot(
      size: (5, 5),
      axis-style: "school-book",
      x-tick-step: 1,
      x-min: -3., 
      x-max: 3.,
      y-tick-step: 1, 
      y-min: -3., 
      y-max: 3.,
      legend: "north-east",
      {
        plot.add(
          f, 
          domain: (-3, 3), 
          style: (stroke: blue),
          label: $f(x) = x^3$
        )
        plot.add(
          f_inv, 
          domain: (-3, 3), 
          style: (stroke: red),
          label: $f^(-1)(x) = root(3, x)$
        )
        plot.add(
          lin, 
          domain: (-3, 3), 
          style: (stroke: gray),
          label: $x = y$
        )
      })
  })
]

#align(center)[
  #canvas({
    import draw: *
    
    plot.plot(
      size: (5, 5),
      axis-style: "school-book",
      x-tick-step: 1,
      x-min: -1.5, 
      x-max: 1.5,
      y-tick-step: 1, 
      y-min: -1.5, 
      y-max: 1.5,
      legend: "north-east",
      {
        plot.add(
          calc.sin, 
          domain: (-1.5, 1.5), 
          style: (stroke: blue),
          label: $sin(x)$
        )
        plot.add(
          x => calc.asin(x).rad(), 
          domain: (-1, 1), 
          style: (stroke: red),
          label: $arcsin(x)$
        )
        plot.add(
          lin, 
          domain: (-1.5, 1.5), 
          style: (stroke: gray),
          label: $x = y$
        )
      })
  })
]

#align(center)[
  #canvas({
    import draw: *
    
    plot.plot(
      size: (5, 5),
      axis-style: "school-book",
      x-tick-step: 1,
      x-min: -1.5, 
      x-max: 1.5,
      y-tick-step: 1, 
      y-min: -1.5, 
      y-max: 1.5,
      legend: "north-east",
      {
        plot.add(
          calc.cos, 
          domain: (-1.5, 1.5), 
          style: (stroke: blue),
          label: $cos(x)$
        )
        plot.add(
          x => calc.acos(x).rad(), 
          domain: (-1, 1), 
          style: (stroke: red),
          label: $arccos(x)$
        )
        plot.add(
          lin, 
          domain: (-1.5, 1.5), 
          style: (stroke: gray),
          label: $x = y$
        )
      })
  })
]

#align(center)[
  #canvas({
    import draw: *
    
    plot.plot(
      size: (5, 5),
      axis-style: "school-book",
      x-tick-step: 1,
      x-min: -1.5, 
      x-max: 1.5,
      y-tick-step: 1, 
      y-min: -1.5, 
      y-max: 1.5,
      legend: "north-east",
      {
        plot.add(
          calc.tan, 
          domain: (-1.5, 1.5), 
          style: (stroke: blue),
          label: $tan(x)$
        )
        plot.add(
          x => calc.atan(x).rad(), 
          domain: (-1, 1), 
          style: (stroke: red),
          label: $arctan(x)$
        )
        plot.add(
          lin, 
          domain: (-1.5, 1.5), 
          style: (stroke: gray),
          label: $x = y$
        )
      })
  })
]

