#import "/lib/imports.typ": *
#show: formatting

== SF (Survival Function)

Probability that a certain event has not occurred by a certain time

$
S(t) = P(T > t)
$

#align(center)[
  #let xs = lq.linspace(-5, 5, num: 200)
  #let xs_fill = lq.linspace(1, 4, num: 200)
  #lq.diagram(
    width: 6cm,
    height: 3cm,
    xlim: (-4, 4),
    ylim: (0, 0.4),
    xaxis: (position: 0, tip: tiptoe.triangle, ticks: none),
    yaxis: (position: 0, tip: tiptoe.triangle, ticks: none),
    lq.fill-between(xs_fill, xs_fill.map(x => norm.pdf(x, mean: 0, std_dev: 1)), y2: xs_fill.map(x => 0), fill: red.lighten(75%), stroke: none),
    lq.plot(xs, x => norm.pdf(x, mean: 0, std_dev: 1), mark: none, stroke: black),
  )
]

Relationship to PDF:

$
S(t) = 1 - F(t)
$

#code(
  "sf.py",
  ```python
  from scipy.stats import norm

  z = 3.4
  mu = 0
  sigma = 1

  norm.sf(z, loc=mu, scale=sigma)
  ```
)