#import "../../utils/examples.typ": eg
#import "../../utils/code.typ": code
#import "../../utils/color_math.typ": colorMath
#import "../../utils/result.typ": result
#import "@preview/cetz:0.3.1": canvas, draw
#import "@preview/cetz-plot:0.1.0": plot
#import "../../utils/blob.typ": draw-blob

#import "@preview/cetz:0.3.1"

#set math.vec(delim: "[")
#set math.mat(delim: "[")

== Derivatives of Inverse Functions

$
  d / (d x)[f^(-1)(x)] = 1 / (f'(f^(-1)(x)))
$

*1. Definition of Inverse Function*

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

*2. Differentiate Both Sides*

Differenatiate both sides with respect to $x$

$
  d / (d x) [ colorMath(f(colorMath(f^(-1)(colorMath(x, #black)), #blue)), #red)] = d / (d x)[x]
$

The right-hand side simplifies to:

$
  d / (d x) [ colorMath(f(colorMath(f^(-1)(colorMath(x, #black)), #blue)), #red)] = 1
$

Using chain-rule: 

$
  d / (d x) [colorMath(f(colorMath(g(colorMath(x, #black)), #blue)), #red)] = colorMath(f'(colorMath(g(colorMath(x, #black)), #blue)), #red) dot colorMath(g'(colorMath(x, #black)), #blue)
$

The left side expands as:

$
  d / (d x) [colorMath(f(colorMath(f^(-1)(colorMath(x, #black)), #blue)), #red)] = colorMath(f'(colorMath(f^(-1)(colorMath(x, #black)), #blue)), #red) dot colorMath(d / (d x) [f^(-1)(colorMath(x, #black))], #blue)
$

This we get:

$
  colorMath(f'(colorMath(f^(-1)(colorMath(x, #black)), #blue)), #red) dot colorMath(d / (d x) [f^(-1)(colorMath(x, #black))], #blue) = 1
$

*3. Solve for $d / (d x) [f^(-1)(x)]$*

Rearrange to isolate $d / (d x) [f^(-1)(x)]$:

$
  colorMath(d / (d x)[f^(-1)(colorMath(x, #black))], #blue) = 1 / colorMath(f'(colorMath(f^(-1)(colorMath(x, #black)), #blue)), #red)
$

#eg[
  Given the function: 
  
  $
    f(x) = x^3
  $ 
  
  We want to find $d / (d x) f^(-1)(x)$ at $x = 2$ using the inverse function derivative formula:
  
  $
    d / (d x) f^(-1)(x) = 1 / (f'(f^(-1)(x)))
  $

  #line(length: 100%)

  *1. Compute $f'(x)$*

  Differenatiate $f(x)$:

  $
    f'(x) = 3x^2 + 1
  $

  #line(length: 100%)

  *2. Solve for $x$ such that $f(x) = 2$*

  We need to find $x$ such that:

  $
    x^3 + x = 2
  $

  Checking $x = 1$:

  $
    1^3 + 1 = 2
  $

  So, 
  
  $
    f^(-1)(2) = 1
  $

  #line(length: 100%)

  *3. Compute $f'(1)$*

  Evaluate the derivative at $x = 1$:

  $
    f'(1) 
    &= 3 (1)^2 + 1 \
    &= 4
  $

  #line(length: 100%)

  *4. Use the formula*

  $
    d / (d x) f^(-1) (2)
    &= 1 / (f'(1)) \
    &= 1 / 4 \
  $

  #line(length: 100%)

  *5. Interpretation*

  #let f(x) = calc.pow(x, 3)
  #let f_inv(x) = calc.root(x, 3)
  #let lin(x) = x

  #let df(x) = 3 * calc.pow(x, 2)

  #let x0 = 2

  #let y0 = f(x0)
  #let x1 = f_inv(y0)

  #let m_f = df(x0)
  #let m_f_inv = 1 / m_f

  #let tangent_f(x) = m_f * (x - x0) + y0
  #let tangent_f_inv(x) = m_f_inv * (x - y0) + x0


  #align(center)[
    #canvas({
      import draw: *
      
      plot.plot(
        size: (10, 10),
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
          plot.add(
            ((x0, y0),),
            mark: "o",
            mark-size: 0.2,
            mark-style: (fill: black, stroke: none),
          )
          plot.add(
            ((y0, x0),),
            mark: "o",
            mark-size: 0.2,
            mark-style: (fill: black, stroke: none),
          )
          plot.add(
            tangent_f, 
            domain: (x0 - 1, x0 + 1), 
            style: (stroke: green),
            label: none
          )
          plot.add(
            tangent_f_inv, 
            domain: (y0 - 0.75, y0 + 0.75), 
            style: (stroke: purple),
            label: none
          )
        })
    })
  ]
]

#code[
  ```py
  from sympy import symbols, solve

  # y = x**3 + x

  x, y = symbols('x y')

  f = x**3 + x - y

  inverse = solve(f, x)

  print(inverse)
  ```
]
