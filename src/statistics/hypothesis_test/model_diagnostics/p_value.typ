#import "/lib/imports.typ": *
#show: formatting

Probability of obtaining results at least as extreme as the observed results

1. One-Tailed

$
p = P(Z > z_"observed")
$

#align(center)[
  #let xs = lq.linspace(-5, 5, num: 200)
  #let xs_fill = lq.linspace(1.5, 4, num: 200)
  #lq.diagram(
    width: 6cm,
    height: 3cm,
    xlim: (-4, 4),
    ylim: (0, 0.4),
    xaxis: (position: 0, tip: tiptoe.triangle, ticks: none),
    yaxis: (position: 0, tip: tiptoe.triangle, ticks: none),
    lq.fill-between(xs_fill, xs_fill.map(x => norm.pdf(x, mean: 0, std_dev: 1)), y2: xs_fill.map(x => 0), fill: red.lighten(75%), stroke: none),
    lq.plot(xs, x => norm.pdf(x, mean: 0, std_dev: 1), mark: none, stroke: gray),
    lq.vlines(1.5, stroke: (paint: gray, thickness: 0.5pt, dash: "dashed")),
  )
]

2. Two-Tailed

$
p = 2 dot P(Z > |z_"observed"|)
$

#align(center)[
  #let xs = lq.linspace(-5, 5, num: 200)
  #let xs_right = lq.linspace(2, 4, num: 200)
  #let xs_left = lq.linspace(-4, -2, num: 200)
  #lq.diagram(
    width: 6cm,
    height: 3cm,
    xlim: (-4, 4),
    ylim: (0, 0.4),
    xaxis: (position: 0, tip: tiptoe.triangle, ticks: none),
    yaxis: (position: 0, tip: tiptoe.triangle, ticks: none),
    lq.fill-between(xs_right, xs_right.map(x => norm.pdf(x, mean: 0, std_dev: 1)), y2: xs_right.map(x => 0), fill: red.lighten(75%), stroke: none),
    lq.fill-between(xs_left, xs_left.map(x => norm.pdf(x, mean: 0, std_dev: 1)), y2: xs_left.map(x => 0), fill: red.lighten(75%), stroke: none),
    lq.plot(xs, x => norm.pdf(x, mean: 0, std_dev: 1), mark: none, stroke: gray),
    lq.vlines(-2, stroke: (paint: gray, thickness: 0.5pt, dash: "dashed")),
    lq.vlines(2, stroke: (paint: gray, thickness: 0.5pt, dash: "dashed")),
  )
]

#code(
  "p_value.py",
  ```python
  z = 2.1
  df = 3
  scipy.stats.norm.sf(abs(z), df=df)
  ```
)
