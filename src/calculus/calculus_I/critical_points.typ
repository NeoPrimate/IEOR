#import "/lib/imports.typ": *
#show: formatting

A critical point of a function $f(x)$ is a point in the domain where either:

- $f'(x) = 0$

- $f'(x)$ is undefined

#example[
  $f(x)=1/x$ on $(0,1]$ has no maximum because it keeps increasing as $x arrow 0$.

  #let f(x) = calc.pow(x, 3) - 3 * x + 1
  #let f_prime(x) = 3 * calc.pow(x, 2) - 3

  #align(center)[
    #let xs = lq.linspace(-3, 3, num: 200)
    #lq.diagram(
      width: 5cm,
      height: 5cm,
      xlim: (-3, 3),
      ylim: (-5, 5),
      xaxis: (position: 0, tip: tiptoe.triangle, filter: (value, distance) => value != 0, subticks: none, tick-args: (tick-distance: 1)),
      yaxis: (position: 0, tip: tiptoe.triangle, subticks: none, tick-args: (tick-distance: 1)),
      lq.plot(xs, f, mark: none, stroke: blue, label: $f(x)$),
      lq.plot(xs, f_prime, mark: none, stroke: red, label: $f'(x)$),
    )
  ]
]

=== Global vs. Local Extrema

- $f(c)$ is a *relative maximum* if $f(c) gt.eq f(x)$ for all $x in (c - h, c + h)$ for $h gt 0$

- $f(d)$ is a *relative minimum* if $f(d) lt.eq f(x)$ for all $x in (d - h, d + h)$ for $h gt 0$

=== First and Second Derivative Tests

First Derivative Test and the Second Derivative Test are used to classify critical points, and both aim to determine whether the point is a local maximum, local minimum, or neither
