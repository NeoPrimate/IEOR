#import "/lib/imports.typ": *
#show: formatting

Let $f: [a, b] arrow RR$ be a function that satisfies the following conditions:

1. $f$ is *continuous* on the closed interval $[a, b]$

2. $f$ is *differentiable* on the open interval $(a, b)$

Then there exists at least one point $c in (a, b)$ such that

$
  f'(c) = (f(b) - f(a)) / (b - a)
$

This means that the instantaneous rate of change (derivative) at some point $c$ is equal to the average rate of change over the entire interval

#example[

  Consider $f(x) = x^2$ on $[1, 3]$

  - The average rate of change is:

  $
    (f(3) - f(1)) / (3 - 1) = (9 - 1) / 2 = 4
  $

  - The derivative for $f(x)$ is $f'(x) = 2x$

  - Setting $f'(c) = 4$, we solve:

  $
    2c = 4 arrow.double c = 2
  $

  Thus, at $c = 2$, the instantaneous rate of change matches the average rate of change

  #let f(x) = calc.pow(x, 2)
  #let df(x) = 2 * x

  #let (a, b) = (1, 3)
  #let secant_slope = (f(b) - f(a)) / (b - a)
  #let secant_line(x) = secant_slope * (x - a) + f(a)

  #let c = secant_slope / 2
  #let tangent_slope = df(c)
  #let tangent_line(x) = tangent_slope * (x - c) + f(c)

  #align(center)[
    #let xs = lq.linspace(0, 4, num: 200)
    #lq.diagram(
      width: 5cm,
      height: 5cm,
      xlim: (-1, 4),
      ylim: (-5, 12),
      xaxis: (position: 0, tip: tiptoe.triangle, filter: (value, distance) => value != 0, subticks: none, tick-args: (tick-distance: 1)),
      yaxis: (position: 0, tip: tiptoe.triangle, subticks: none, tick-args: (tick-distance: 2)),
      lq.plot(xs, f, mark: none, stroke: black, label: $f(x) = x^2$),
      lq.plot(xs, secant_line, mark: none, stroke: blue, label: [Secant Line]),
      lq.plot(xs, tangent_line, mark: none, stroke: red, label: [Tangent Line at c]),
      lq.plot((a, b), (f(a), f(b)), mark: "o", stroke: none, mark-color: blue),
      lq.plot((c,), (tangent_line(c),), mark: "o", stroke: none, mark-color: red),
    )
  ]

]
