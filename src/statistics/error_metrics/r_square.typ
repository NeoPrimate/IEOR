#import "/lib/imports.typ": *
#show: formatting

Proportion of variance explained by the model

$
  R^2 = 1 - (sum_(i=1)^n (y_i - hat(y)_i)^2) / (sum_(i=1)^n (y_i - macron(y)_i)^2)
$

- 1: model explains all the variance in the dependent variable

- 0: model explains none of the variance in the dependent variable

#example[

  #let rng = suiji.gen-rng(4)
  #let n = 25
  #let mu = 0
  #let sigma = 20
  #let a = 3
  #let b = -3
  #let noise = suiji.normal(rng, loc: mu, scale: sigma, size: n).at(1)
  #let reg_line = range(n).map(x => a * x + b)
  #let d = reg_line.zip(noise).map(tup => tup.at(0) + tup.at(1))

  #let mean = d.sum() / d.len()

  #let data = range(n).zip(d)
  #let data_xs = data.map(p => p.at(0))
  #let data_ys = data.map(p => p.at(1))
  #let line_xs = lq.linspace(-1, data.len() + 1, num: 200)

  *Step 1*: Fit the Regression Model

  *Step 2*: Compute *Total Sum of Squares* (SST)

  $
    "SST" = sum_(i=1)^n (y_i - macron(y))^2
  $

  #align(center)[
    #lq.diagram(
      width: 8cm,
      height: 3.5cm,
      xlim: (-1, data.len() + 1),
      ylim: (d.sorted().at(0) - 5, d.sorted().at(-1) + 5),
      xaxis: (ticks: none),
      yaxis: (ticks: none),
      ..data.map(p => lq.vlines(p.at(0), min: calc.min(p.at(1), mean), max: calc.max(p.at(1), mean), stroke: (paint: black, dash: "dotted"))),
      lq.hlines(mean, stroke: green),
      lq.plot(data_xs, data_ys, mark: "o", stroke: none, mark-color: black),
    )
  ]

  *Step 3*: Compute *Regression Sum of Squares* (SSR)

  $
    "SSR" = sum_(i=1)^n = (hat(y)_i - macron(y))^2
  $

  #align(center)[
    #lq.diagram(
      width: 8cm,
      height: 3.5cm,
      xlim: (-1, data.len() + 1),
      ylim: (d.sorted().at(0) - 5, d.sorted().at(-1) + 5),
      xaxis: (ticks: none),
      yaxis: (ticks: none),
      ..data.map(p => lq.vlines(p.at(0), min: calc.min(mean, a * p.at(0) + b), max: calc.max(mean, a * p.at(0) + b), stroke: (paint: black, dash: "dotted"))),
      lq.hlines(mean, stroke: black),
      lq.plot(line_xs, x => a * x + b, mark: none, stroke: red),
      lq.plot(data_xs, data_ys, mark: "o", stroke: none, mark-color: black),
    )
  ]

  *Step 4*: Compute *Residual Sum of Squares* (SSE)

  $
    "SSE" = sum_(i=1)^n = (y_i - hat(y)_i)^2
  $

  #align(center)[
    #lq.diagram(
      width: 8cm,
      height: 3.5cm,
      xlim: (-1, data.len() + 1),
      ylim: (d.sorted().at(0) - 5, d.sorted().at(-1) + 5),
      xaxis: (ticks: none),
      yaxis: (ticks: none),
      ..data.map(p => lq.vlines(p.at(0), min: calc.min(p.at(1), a * p.at(0) + b), max: calc.max(p.at(1), a * p.at(0) + b), stroke: (paint: black, dash: "dotted"))),
      lq.plot(line_xs, x => a * x + b, mark: none, stroke: red),
      lq.plot(data_xs, data_ys, mark: "o", stroke: none, mark-color: black),
    )
  ]

  *Step 5*: Calculate *$R^2$*

  $
    R^2 = "SSR" / "SST" = 1 - "SSE" / "SST"
  $
]

== Adj R-squared

Adjusts the  $R^2$  value based on the number of predictors (penalty for adding non-informative variables)

$
  "Adj" R^2 = 1 - (1 - R^2) (n - 1) / (n - p - 1)
$
