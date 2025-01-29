#import "../../utils/examples.typ": eg
#import "../../utils/code.typ": code
#import "../../utils/color_math.typ": colorMath
#import "../../utils/result.typ": result
#import "@preview/cetz:0.3.1": canvas, draw
#import "@preview/cetz-plot:0.1.0": plot


#import "@preview/cetz:0.2.2"


== Power Rule

$
  f(x) &= x^colorMath(n, #red), quad quad n eq.not 0 \
  f'(x) &= colorMath(n, #red) x^colorMath(n - 1, #red) \  
$

#eg[
  $
    f(x) &= x^colorMath(3, #red) \
    f'(x) &= colorMath(3, #red)x^colorMath(2, #red)
  $
]

#eg[
  $
    d / (d x) (root(3, x^2))
    &= d / (d x) ((x^2)^(1/3)) \
    &= d / (d x) (x^(2 times 1/3)) \
    &= d / (d x) (x^(2/3)) \
    &= d / (d x) (2/3 x^(-1/3)) \

  $
]

== Constant Rule

$
  d / (d x) [colorMath(k, #red)] = 0
$

#eg[
  $
    d / (d x) [colorMath(-3, #red)] = 0
  $
]

== Constant Multiple Rule

$
  d / (d x) [colorMath(k, #red) colorMath(f(x), #blue)] 
  &= colorMath(k, #red) d / (d x) [colorMath(f(x), #blue)] \
  &= colorMath(k, #red) colorMath(f'(x), #blue) \
$

#eg[
  $
    d / (d x) [colorMath(2, #red) colorMath(x^5, #blue)] 
    &= colorMath(2, #red) d / (d x) [colorMath(x^5, #blue)] \
    &= colorMath(2, #red) dot colorMath(5x^4, #blue) \
    &= 10x^4
  $
]

== Sum Rule

$
  d / (d x) [colorMath(f(x), #red) + colorMath(g(x), #blue)]
  &= d / (d x) [colorMath(f(x), #red)] + d / (d x) [colorMath(g(x), #blue)] \
  &= colorMath(f'(x), #red) + colorMath(g'(x), #blue)
$

#eg[
  $
    d / (d x) [colorMath(x^3, #red) + colorMath(x^(-4), #blue)] 
    &= d / (d x) [colorMath(x^3, #red)] + d / (d x) [colorMath(x^(-4), #blue)] \
    &= colorMath(3x^2, #red) + (colorMath(-4x^(-5), #blue)) \
    &= colorMath(3x^2, #red) - 4x^(-5) \
  $
]

== Difference Rule

$
  d / (d x) [colorMath(f(x), #red) - colorMath(g(x), #blue)]
  &= d / (d x) [colorMath(f(x), #red)] - d / (d x) [colorMath(g(x), #blue)] \
  &= colorMath(f'(x), #red) - colorMath(g'(x), #blue)
$

#eg[
  $
    d / (d x) [colorMath(x^4, #red) - colorMath(x^3, #blue)] 
    &= d / (d x) [colorMath(x^4, #red)] - d / (d x) [colorMath(x^3, #blue)] \
    &= colorMath(4x^3, #red) - colorMath(3x^2, #blue) \
  $
]

== Square Root

$
  
$

#eg[
  $
    d / (d x) root(4, x) 
    &= d / (d x) x^(1/4) \
    &= 1 / 4 x^(1/4 - 1) \
    &= 1 / 4 dot x^(-3/4) \
    &= 1 / 4 dot 1 / x^(3 slash 4) \
    &= 1 / (4x^(3 slash 4)) \

  $
]

== Derivative of a Polynomial

#eg[
  $
    f(x) = colorMath(2x^3, #red) colorMath(- 7x^2, #blue) + colorMath(3x, #green) - colorMath(100, #yellow) \
    f'(x) = colorMath(2 dot 3x^2, #red) colorMath(- 7 dot 2x, #blue) + colorMath(3, #green) + colorMath(0, #yellow) \   
  $
]

#eg[
  $
    h(x) = 3 f(x) + 2 g(x) \
  $

  Evaluate $d / (d x) h(x)$ at $x = 9$

  $
    d / (d x) (h(x)) 
    &= d / (d x) (3 f(x) + 2 g(x)) \
    &= d / (d x) 3 f(x) + d / (d x)2 g(x) \
    &= 3 d / (d x) f(x) + 2 d / (d x) g(x) \
  $

  Evaluate $h'(9)$

  $
    h'(9) = 3 f'(9) + 2 g'(9)
  $
]

#eg[
  $
    g(x) &= 2 / x^3 - 1 / x^2 \

    d / (d x) (g(x)) &= d / (d x) (2 x^(-3) - 1 x^(-2)) \
    g'(x) 
    &= 2 dot (-3) x^(-4) - (-2) x^(-3) \
    &= -6 x^(-4) + 2x^(-3) \
  $

  $
    g'(2) 
    &= -6 dot 2^(-4) + 2 dot 2^(-3) \
    &= -6 / 2^4 + 2 / 2^3 \
    &= -3/8 + 2/8 \
    &= -1/8
  $
]

#let f(x) = calc.pow(x, 3) - 6 * calc.pow(x, 2) + x - 5
#let f_1 = f(1)

#let f_prime(x) = 3 * calc.pow(x, 2) - 12 * x + 1

#let x = 1
#let f_prime_1 = f_prime(x)

#let tangent_f_1(x) = -8 * x -1

#eg[

  #f_1
  #f_prime_1

  $
    f(x) = x^3 - 6x^2 + x - 5 \
    y = m x + b \
    f'(1) = #f_prime_1
    
    y = #f_prime_1 x + b \
    -9 = #f_prime_1 dot 1 + b \
    -9 = #f_prime_1 + b \
    -9 colorMath(+ 8, #red) = #f_prime_1 colorMath(+ 8, #red) + b \
    b = -1 \
  $

  Tangent line to $f(x)$ at $x = 1$

  $
    y = -8 x - 1
  $

  #align(center)[
    #canvas({
      import draw: *
      
      plot.plot(
        size: (8, 8),
        axis-style: "school-book",
        x-tick-step: 2,
        x-min: -4., 
        x-max: 8.,
        y-tick-step: 10, 
        y-min: -60., 
        y-max: 20.,
        legend: "inner-north",
        {
          plot.add(
            f, 
            domain: (-4, 8), 
            style: (stroke: blue),
          )
          plot.add(
            tangent_f_1, 
            domain: (-1, 3), 
            style: (stroke: red),
          )
        })
    })
  ]
]

== Sin

$
  d / (d x) sin(x) = cos(x) \
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
        y-min: -1.5, 
        y-max: 1.5,
        legend: "inner-north-east",
        {
          plot.add(
            calc.cos, 
            domain: (-5, 5), 
            style: (stroke: blue),
            label: $cos(x)$
          )
          plot.add(
            calc.sin, 
            domain: (-5, 5), 
            style: (stroke: red),
            label: $sin(x)$
          )
        })
    })
  ]

== Cos

$
  d / (d x) cos(x) = - sin(x) \
$

#let ddx_cos(x) = - calc.sin(x)

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
        y-min: -1.5, 
        y-max: 1.5,
        legend: "inner-north-east",
        {
          plot.add(
            calc.cos, 
            domain: (-5, 5), 
            style: (stroke: blue),
            label: $cos(x)$
          )
          plot.add(
            ddx_cos, 
            domain: (-5, 5), 
            style: (stroke: red),
            label: $- sin(x)$
          )
        })
    })
  ]

  == $bold(e^x)$

  $
    d / (d x) e^x = e^x
  $

  #let x = 0

  #let m = calc.round(calc.exp(x), digits: 2)
  #let b = calc.round(m - m * x, digits: 2)
  #let f_tangent(x) = m * x + b


  #align(center)[
    #canvas({
      import draw: *
      
      plot.plot(
        size: (8, 8),
        axis-style: "school-book",
        x-tick-step: 1,
        x-min: -5., 
        x-max: 3.,
        y-tick-step: 1, 
        y-min: 0, 
        y-max: 10,
        legend: "inner-north-west",
        {
          plot.add(
            calc.exp, 
            domain: (-5, 10), 
            style: (stroke: blue),
            label: $e^x$
          )
          plot.add(
            f_tangent, 
            domain: (-5, 10), 
            style: (stroke: red),
            label: $y = #m dot #x + #b$
          )
        })
    })
  ]

== $bold(ln(x))$

$
  ln(x) = 1 / x
$

#let x = 2
#let m = calc.round(1 / x, digits: 2)
#let b = calc.round(calc.ln(x) - m * x, digits: 2)
#let f_tangent(x) = m * x + b

#align(center)[
  #canvas({
    import draw: *
    
    plot.plot(
      size: (8, 8),
      axis-style: "school-book",
      x-tick-step: 1,
      x-min: 0., 
      x-max: 10.,
      y-tick-step: 1, 
      y-min: -3., 
      y-max: 4.,
      legend: "inner-north-west",
      {
        plot.add(
          calc.ln, 
          domain: (0.0001, 10), 
          style: (stroke: blue),
          label: $ln(x)$
        )
        plot.add(
          f_tangent, 
          domain: (0.0001, 10), 
          style: (stroke: red),
          label: $y = #m dot #x + #b$
        )
      })
  })
]



