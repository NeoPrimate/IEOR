#import "../../utils/examples.typ": eg
#import "../../utils/code.typ": code
#import "../../utils/color_math.typ": colorMath

== Implicit Differentiation

*Steps for Implicit Differentiation*

1. Differentiate both sides of the equation with respect to $x$:

  - Apply the usual rules of differentiation (power rule, product rule, chain rule, etc.).

  - Remember to multiply by $(d x) / (d y)$ (or $y'$) whenever you differentiate $y$, because $y$ is a function of $x$.

2. Solve for $(d x) / (d y)$:
  
  - Rearrange the resulting equation to isolate $(d y)/(d x)$, which represents the derivative of $y$ with respect to $x$.

#eg[
  $
    x^2 + y^2 = 1
  $

  $
    d / (d x) [colorMath(x^2, #red) + colorMath(y^2, #red)] &= d / (d x) [colorMath(1, #red)] \
    d / (d x) [colorMath(x^2, #red)] + d / (d x) [colorMath(y^2, #red)] &= d / (d x) [colorMath(1, #red)] \
    d / (d x) [colorMath(x^2, #red)] + d / (d x) [colorMath(y^2, #red)] &= 0 \
    2x + (d (y^2)) / (d y) dot (d y) / (d x) &= 0 \
    2x + 2y dot (d y) / (d x) &= 0 \
    2y dot (d y) / (d x) &= -2x \
    (d y) / (d x) &= (-2x) / (2y) \
    (d y) / (d x) &= - x / y \
  $
]

