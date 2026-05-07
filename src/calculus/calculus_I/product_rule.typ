#import "/lib/imports.typ": *

== Product Rule

$
  d / (d x) [colorMath(f(x), #blue) colorMath(g(x), #red)] = colorMath(f'(x), #blue) colorMath(g(x), #red) + colorMath(f(x), #blue) colorMath(g'(x), #red)
$

#example[
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
