#import "../../utils/examples.typ": eg
#import "../../utils/code.typ": code
#import "../../utils/color_math.typ": colorMath

== Chain Rule

Compute the derivative of a composite function

$
  h'(x)
  &= d / (d x) [colorMath(f(colorMath(g(colorMath(x, #black)), #blue)), #red)] \
  &= colorMath(f'(colorMath(g(colorMath(x, #black)), #blue)), #red) dot colorMath(g'(colorMath(x, #black)), #blue)
$

More generally:

$
  y = f_1(f_2(f_3(...f_n (x)...)))
$

$
  (d y) / (d x) = f'_1(f_2(f_3(...f_n (x)...))) dot f'_2(f_3(...f_n (x)...)) dot f'_3(...f_n (x)...) dot dots dot f'_n (x) \
$

#eg[
  $
    d / (d x) [
      colorMath(f(colorMath(g(colorMath(x, #black)), #blue)), #red)
    ] = 
    colorMath(f'(colorMath(g(colorMath(x, #black)), #blue)), #red) dot colorMath(g'(colorMath(x, #black)), #blue)
  $

  $
    d / (d x) [colorMath(e^colorMath(sin(colorMath(x, #black)), #blue), #red)]
  $

  $
    d / (d x) [colorMath(e^colorMath(x, #black), #red)] = colorMath(1 / colorMath(x, #black), #red) quad quad quad d / (d x) [colorMath(sin(colorMath(x, #black)), #blue)] = colorMath(cos(colorMath(x, #black)), #blue)
  $

  $
    colorMath(f'(colorMath(g(colorMath(x, #black)), #blue)), #red) = colorMath(1 / colorMath(sin(colorMath(x, #black)), #blue), #red) quad quad quad colorMath(g'(colorMath(x, #black)) = cos(colorMath(x, #black)), #blue)
  $

  $
    d / (d x) [
      colorMath(underbrace(
        ln(
          colorMath(overbrace(
            sin(colorMath(x, #black)),
            g(colorMath(x, #black))
          ), #blue)
        ), 
        f(colorMath(g(colorMath(x, #black)), #blue))
      ), #red)
    ] = colorMath(1 / (colorMath(sin(colorMath(x, #black)), #blue)), #red) dot colorMath(cos(colorMath(x, #black)), #blue)
  $
]


$
  f(x) = colorMath(cos^colorMath(3, #red)(colorMath(x, #black)), #blue) = colorMath((colorMath(cos(colorMath(x, #black)), #blue))^3, #red)
$

$
  f(x) = colorMath(v(colorMath(u(colorMath(x, #black)), #blue)), #red)
$

$
  f'(x) = colorMath(v'(colorMath(u(colorMath(x, #black)), #blue)), #red) dot colorMath(u'(colorMath(x, #black)), #blue)
$

$
  f'(x) 
  &= (d colorMath(v, #red)) / (d colorMath(u, #blue)) dot (d colorMath(u, #blue)) / (d x) \
  &= (d colorMath((colorMath(cos(colorMath(x, #black)), #blue))^3, #red)) / (d colorMath(cos(colorMath(x, #black)), #blue)) dot (d colorMath(cos(colorMath(x, #black)), #blue)) / x \
  &= colorMath(3 (colorMath(cos(colorMath(x, #black)), #blue))^2, #red) dot colorMath(- sin(x), #blue) \
  &= -3(cos(x))^2 sin(x)
$

