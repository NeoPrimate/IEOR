#import "../../utils/examples.typ": eg
#import "../../utils/code.typ": code
#import "../../utils/color_math.typ": colorMath
#import "../../utils/result.typ": result


#import "@preview/fletcher:0.5.7" as fletcher: diagram, node, edge, shapes

#align(center)[

  $
    z = f(colorMath(u, #red), colorMath(v, #blue)) \
    colorMath(u, #red) = f(x, y) quad quad colorMath(v, #blue) = f(x, y)
  $

  #diagram(
    node-inset: 0pt,

    node(pos: (0,0), label: $z$, stroke: none, radius: 0.75em, name: <z>),
    
    node(pos: (1,-0.5), label: $colorMath(u, #red)$, stroke: none, radius: 0.75em, name: <u>),
    
    node(pos: (1,0.5), label: $colorMath(v, #blue)$, stroke: none, radius: 0.75em, name: <v>),
    
    node(pos: (2.5,-0.5), label: $x$, stroke: none, radius: 0.75em, name: <x>),

    node(pos: (2.5,0.5), label: $y$, stroke: none, radius: 0.75em, name: <y>),

    edge(<z>, <u>, "-|>", label: {}),
    
    edge(<z>, <v>, "-|>", label: {}),
    
    edge(<u>, <x>, "-|>", label: {}),
    
    edge(<u>, <y>, "-|>", label: {}),
    
    edge(<v>, <x>, "-|>", label: {}),
    
    edge(<v>, <y>, "-|>", label: {}),
  )
  ]

The derivative of $z$ with respect to $x$ is the sum of all possible paths from $z$ to $x$:

$
   (partial z) / (partial x) = (partial z) / (partial u) (partial u) / (partial x) + (partial z) / (partial v) (partial v) / (partial x)
$

#eg[
  Let:
  
  - $u = x + y$
  
  - $v = x y$
  
  - $z = u^2 + sin(v)$

  We want to compute:

  $
    (partial z) / (partial x)
  $

  *Step 1:* Apply the multivariable chain rule

  $
    (partial z) / (partial x) = (partial z) / (partial u) (partial u) / (partial x) + (partial z) / (partial v) (partial v) / (partial x)
  $

  *Step 2:* Compute partial derivatives

  - $(partial u) / (partial x) = partial / (partial x) (x + y) = 1 + 0 = result(1)$

  - $(partial v) / (partial x) = partial / (partial x) (x y) = 1 y = result(y)$

  - $(partial z) / (partial u) = partial / (partial u) (u^2 + sin(v)) = 2u + 0 = result(2u)$

  - $(partial z) / (partial v) = partial / (partial v)(u^2 + sin(v)) = 0 + cos(v) = result(cos(v))$

  *Step 3*: Plug in:

  $
    (partial z) / (partial x) 
    &= 2u dot 1 + cos(v) dot y \
    &= 2 (x + y) + y cos(x y)
  $

]