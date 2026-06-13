#import "/lib/imports.typ": *
#show: formatting

$
  d / (d x) [colorMath(f(x), #blue) / colorMath(g(x), #red)] = (colorMath(f'(x), #blue) colorMath(g(x), #red) - colorMath(f(x), #blue) colorMath(g'(x), #red)) / [colorMath(g(x), #red)]^2
$

#example[
  $
    d / (d x) [colorMath(x^2, #blue) / colorMath(cos(x), #red)]
  $

  $
    colorMath(f(x) = x^2, #blue) quad quad colorMath(g(x) = cos(x), #red) \
    colorMath(f'(x) = 2x, #blue) quad quad colorMath(g'(x) = -sin(x), #red) \
  $

  $
    d / (d x) [colorMath(x^2, #blue) / colorMath(cos(x), #red)] = (colorMath(2x, #blue) colorMath(cos(x), #red) - colorMath(x^2, #blue) (colorMath(-sin(x), #red))) / [colorMath(cos(x), #red)]^2
  $
]

#let tangent(x) = calc.sin(x) / calc.cos(x)

#let cotangent(x) = calc.cos(x) / calc.sin(x)

#let secant(x) = 1 / calc.cos(x)

#let cosecant(x) = 1 / calc.sin(x)

#let secant_sq(x) = 1 / calc.pow(calc.cos(x), 2)

#let cosecant_sq(x) = 1 / calc.pow(calc.sin(x), 2)

#let secant_prime(x) = secant(x) * tangent(x)

#let cosecant_prime(x) = -cosecant(x) * cotangent(x)

#let drop-asymptotes(f, lim: 15) = x => {
  let y = f(x)
  if calc.abs(y) > lim { float.nan } else { y }
}

=== *$tan(x)$*

$
  d / (d x) [tan(x)] & = d / (d x) [sin(x) / cos(x)] \
                     & = (cos(x) dot cos(x) - sin(x) dot -sin(x)) / (cos^2(x)) \
                     & = (cos^2(x) + sin^2(x)) / (cos^2(x)) \
                     & = result(1 / (cos^2(x))) \
                     & = result(sec^2(x)) \
$

#align(center)[
  #let xs = lq.linspace(-5, 5, num: 400)
  #lq.diagram(
    width: 5cm,
    height: 5cm,
    xlim: (-5, 5),
    ylim: (-5, 5),
    xaxis: (
      position: 0,
      tip: tiptoe.triangle,
      filter: (value, distance) => value != 0,
      subticks: none,
      tick-args: (tick-distance: 1),
    ),
    yaxis: (position: 0, tip: tiptoe.triangle, subticks: none, tick-args: (tick-distance: 1)),
    lq.plot(xs, drop-asymptotes(tangent), mark: none, stroke: blue, label: $tan(x)$),
    lq.plot(xs, drop-asymptotes(secant_sq), mark: none, stroke: red, label: $sec^2(x)$),
  )
]

=== *$cot(x)$*

$
  d / (d x) [cot(x)] & = d / (d x) [cos(x) / sin(x)] \
                     & = (cos(x) dot cos(x) - sin(x) dot -sin(x)) / (cos^2(x)) \
                     & = (-sin^2(x) -cos^2(x)) / () \
                     & = result(- 1 / sin^2(x)) \
                     & = result(- csc^2(x)) \
$

#align(center)[
  #let xs = lq.linspace(-5, 5, num: 400)
  #lq.diagram(
    width: 5cm,
    height: 5cm,
    xlim: (-5, 5),
    ylim: (-5, 5),
    xaxis: (
      position: 0,
      tip: tiptoe.triangle,
      filter: (value, distance) => value != 0,
      subticks: none,
      tick-args: (tick-distance: 1),
    ),
    yaxis: (position: 0, tip: tiptoe.triangle, subticks: none, tick-args: (tick-distance: 1)),
    lq.plot(xs, drop-asymptotes(cotangent), mark: none, stroke: blue, label: $cot(x)$),
    lq.plot(xs, drop-asymptotes(x => -cosecant_sq(x)), mark: none, stroke: red, label: $-csc^2(x)$),
  )
]

=== *$sec(x)$*

$
  d / (d x) [sec(x)] & = d / (d x) [1 / cos(x)] \
                     & = (0 dot cos(x) - 1 dot -sin(x)) / (cos^2(x)) \
                     & = (0 + 1 dot sin(x)) / (cos^2(x)) \
                     & = result(sin(x) / (cos^2(x))) \
                     & = sin(x) / cos(x) dot 1 / cos(x) \
                     & = result(tan(x) dot sec(x)) \
$

#align(center)[
  #let xs = lq.linspace(-5, 5, num: 400)
  #lq.diagram(
    width: 5cm,
    height: 5cm,
    xlim: (-5, 5),
    ylim: (-5, 5),
    xaxis: (
      position: 0,
      tip: tiptoe.triangle,
      filter: (value, distance) => value != 0,
      subticks: none,
      tick-args: (tick-distance: 1),
    ),
    yaxis: (position: 0, tip: tiptoe.triangle, subticks: none, tick-args: (tick-distance: 1)),
    lq.plot(xs, drop-asymptotes(secant), mark: none, stroke: blue, label: $sec(x)$),
    lq.plot(xs, drop-asymptotes(secant_prime), mark: none, stroke: red, label: $sin(x) / (cos^2(x))$),
  )
]

=== *$csc(x)$*

$
  d / (d x) [csc(x)] & = d / (d x) [1 / sin(x)] \
                     & = (0 dot sin(x) - 1 dot cos(x)) / (sin^2(x)) \
                     & = (0 - 1 dot cos(x)) / (sin^2(x)) \
                     & = result((-cos(x)) / (sin^2(x))) \
                     & = - cos(x) / sin(x) dot 1 / sin(x) \
                     & = result(cot(x) dot csc(x)) \
$

#align(center)[
  #let xs = lq.linspace(-5, 5, num: 400)
  #lq.diagram(
    width: 5cm,
    height: 5cm,
    xlim: (-5, 5),
    ylim: (-5, 5),
    xaxis: (
      position: 0,
      tip: tiptoe.triangle,
      filter: (value, distance) => value != 0,
      subticks: none,
      tick-args: (tick-distance: 1),
    ),
    yaxis: (position: 0, tip: tiptoe.triangle, subticks: none, tick-args: (tick-distance: 1)),
    lq.plot(xs, drop-asymptotes(cosecant), mark: none, stroke: blue, label: $csc(x)$),
    lq.plot(xs, drop-asymptotes(cosecant_prime), mark: none, stroke: red, label: $(-cos(x)) / (sin^2(x))$),
  )
]
