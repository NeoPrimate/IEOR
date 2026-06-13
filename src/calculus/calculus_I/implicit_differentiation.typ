#import "/lib/imports.typ": *
#show: formatting

When a function is not explicitly solved for one variable in terms of another. E.g.: \

$
  x^2 + y^2 = 1
$

Instead of solving for $y$ explicitly in terms of $x$, implicit differentiation allows you to differentiate both sides of an equation directly, treating $y$ as an implicit function of $x$.

*Steps for Implicit Differentiation*

1. Differentiate both sides of the equation with respect to $x$, treating y as a function of $x$

2. Apply the chain rule whenever differentiating $y$, since $y = y(x)$

2. Solve for $(d x) / (d y)$

#example[
  $
    x^2 + y^2 = 1
  $

  1. Differentiate both sides

  $
                d / (d x) [colorMath(x^2, #red) + colorMath(y^2, #red)] & = d / (d x) [colorMath(1, #red)] \
    d / (d x) [colorMath(x^2, #red)] + d / (d x) [colorMath(y^2, #red)] & = d / (d x) [colorMath(1, #red)] \
    d / (d x) [colorMath(x^2, #red)] + d / (d x) [colorMath(y^2, #red)] & = 0 \
  $

  2. Apply the chain rule to $y^2$

  $
    2x + 2y (d y) / (d x) & = 0
  $

  3. Slove for $(d y) / (d x)$

  $
    2y dot (d y) / (d x) & = -2x \
           (d y) / (d x) & = (-2x) / (2y) \
           (d y) / (d x) & = - x / y \
  $
]

#let f(x) = calc.sqrt(calc.pow(5, 2) - calc.pow(x, 2))
#let g(x) = -calc.sqrt(calc.pow(5, 2) - calc.pow(x, 2))
#let point = (3, 4)
#let tangent(x) = -(3 / 4) * x + (25 / 4)

#align(center)[
  #let xs = lq.linspace(-5, 5, num: 200)
  #let xst = lq.linspace(-5, 6, num: 200)
  #lq.diagram(
    width: 5cm,
    height: 5cm,
    xlim: (-6, 6),
    ylim: (-6, 6),
    xaxis: (
      position: 0,
      tip: tiptoe.triangle,
      filter: (value, distance) => value != 0,
      subticks: none,
      tick-args: (tick-distance: 2),
    ),
    yaxis: (position: 0, tip: tiptoe.triangle, subticks: none, tick-args: (tick-distance: 2)),
    lq.plot(xs, f, mark: none, stroke: blue),
    lq.plot(xs, g, mark: none, stroke: blue, label: $x^2 + y^2 = 5^2$),
    lq.plot(xst, tangent, mark: none, stroke: red),
    lq.plot((point.at(0),), (point.at(1),), mark: "o", stroke: none, mark-color: blue),
  )
]

$
  x^2 + y^2 = 5^2 \
  2x d x + 2y d y = 0 \
  (d y) / (d x) = - x / y
$
