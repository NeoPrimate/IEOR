#import "../../utils/examples.typ": eg
#import "../../utils/code.typ": code
#import "../../utils/color_math.typ": colorMath
#import "../../utils/result.typ": result
#import "@preview/cetz:0.3.1": canvas, draw
#import "@preview/cetz-plot:0.1.0": plot


#import "@preview/cetz:0.3.4"

== Product Rule

$
  d / (d x) [colorMath(f(x), #blue) colorMath(g(x), #red)] = colorMath(f'(x), #blue) colorMath(g(x), #red) + colorMath(f(x), #blue) colorMath(g'(x), #red)
$

#eg[
  $
    d / (d x) [colorMath(x^2, #blue) colorMath(sin(x), #red)]
  $

  $
    colorMath(f(x) = x^2, #blue) quad quad colorMath(g(x) = sin(x), #red) \
    colorMath(f'(x) = 2x, #blue) quad quad colorMath(g'(x) = cos(x), #red) \
  $

  $
    d / (d x) [colorMath(x^2, #blue) colorMath(sin(x), #red)] = colorMath(2x, #blue) colorMath(sin(x), #red) + colorMath(x^2, #blue) colorMath(cos(x), #red)
  $
]