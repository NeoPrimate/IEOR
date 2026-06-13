#import "/lib/imports.typ": *
#show: formatting

== CDF (Cumulative Distribution Function)

Gives the probability that $X$ will take a value less than or equal to $x$

$
F(x) = P(X ≤ x)
$

#align(center)[
  #let xs = lq.linspace(-5, 5, num: 200)
  #let xs_fill = lq.linspace(-4, 1, num: 200)
  #lq.diagram(
    width: 6cm,
    height: 3cm,
    xlim: (-4, 4),
    ylim: (0, 1),
    xaxis: (position: 0, tip: tiptoe.triangle, ticks: none),
    yaxis: (position: 0, tip: tiptoe.triangle, ticks: none),
    lq.fill-between(xs_fill, xs_fill.map(x => norm.cdf(x, mean: 0, std_dev: 1)), y2: xs_fill.map(x => 0), fill: red.lighten(75%), stroke: none),
    lq.fill-between(xs_fill, xs_fill.map(x => norm.pdf(x, mean: 0, std_dev: 1)), y2: xs_fill.map(x => 0), fill: red.lighten(75%), stroke: none),
    lq.plot(xs, x => norm.pdf(x, mean: 0, std_dev: 1), mark: none, stroke: black),
    lq.plot(xs, x => norm.cdf(x, mean: 0, std_dev: 1), mark: none, stroke: black),
  )
]

1. Categorical

$
F(x) = integral_(-infinity)^x f(t) d t
$

2. Continuous

$
F(x) = sum_(t ≤ x) P(X = t)
$

#code(
  "cdf.py",
  ```python
  from scipy.stats import norm

  x = 1
  mu = 0
  sigma = 1

  norm.cdf(x, loc=mu, scale=sigma)
  ```
)