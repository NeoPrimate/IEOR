#import "../../utils/color_math.typ": colorMath

== Differentiation Rules

#table(
  columns: (auto, auto),
  inset: 10pt,
  align: horizon,
  [Power], [$d / (d x)[x^n] = n dot x^(n-1)$],
  [Sum], [$d / (d x) [colorMath(f(x), #red) + colorMath(g(x), #blue)] = colorMath(f'(x), #red) + colorMath(g'(x), #blue)$],
  [Product], [$d / (d x)[colorMath(f(x), #red) dot colorMath(g(x)], #blue) = colorMath(f'(x), #red) colorMath(g(x), #blue) + colorMath(f(x), #red) colorMath(g'(x), #blue)$],
  [Quotient], [$d / (d x)[colorMath(f(x), #red) / colorMath(g(x), #blue)] = (colorMath(f'(x), #red) colorMath(g(x), #blue) - colorMath(f(x), #red) colorMath(g'(x), #blue)) / [colorMath(g(x), #blue)]^2$],
  [Chain], [$d / (d x)[colorMath(f(colorMath(g(x), #blue)), #red)] = colorMath(f'(colorMath(g(x), #blue)), #red) dot colorMath(g'(x), #blue)$],
  
)