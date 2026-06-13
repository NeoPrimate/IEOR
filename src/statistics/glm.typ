#import "/lib/imports.typ": *
#show: formatting

Three components:

1. Random Component

Specifies the distribution of the response variable $Y$.

$Y$ can come from the exponential family of distributions (which includes Normal, Binomial, Poisson, Gamma, etc.)

2. Systematic Component

Specifies the linear predictor, a linear combination of explanatory variables:

$
  eta = beta_0 + beta_1 x_1 + beta_2 x_2 + dots + beta_p x_p
$

3. Link Function

Connects the expected value of $Y$, denoted $mu = E[Y]$, to the linear predictor $eta$:

$
  g(mu) - eta
$

Where $g(dot)$ is called the link function

#align(center)[
  #table(
    columns: 4,
    inset: 1em,
    align: left,
    [*Model*], [*Response\ Type*], [*Distribution*], [*Link\ Function*],
    [Linear\ Regression], [Continuous], [Normal], [$g(mu) = mu$\ (identity)],
    [Logistic\ Regression], [Binary\ (0, 1)], [Binomial], [$g(mu) = log(mu / (1 - mu))$\ (logit)],
    [Poisson\ Regression], [Count], [Poisson], [$g(mu) = log(mu)$],
    [Gamma\ Regression], [Positive\ continuous], [Gamma], [$g(mu) = log(mu)$],
    [], [], [], [],
  )
]

#example[
  Logistic Regression

  #let data = (
    (1, 0),
    (2, 0),
    (3, 0),
    (4, 1),
    (5, 1),
    (6, 1),
  )

  #let xs = ()
  #let ys = ()
  #for (x, y) in data {
    xs.push(x)
    ys.push(y)
  }

  #let xbar = xs.sum() / xs.len()

  #let ybar = ys.sum() / ys.len()

  #let x_deviation = xs.map(x => x - xbar)
  #let y_deviation = ys.map(y => y - ybar)

  #let numerator = (
    x_deviation
      .zip(y_deviation)
      .map(xy => {
        let (x, y) = xy
        x * y
      })
      .sum()
  )

  #let denominator = xs.map(x => calc.pow(x - xbar, 2)).sum()

  #let b1 = numerator / denominator
  #let b0 = ybar - b1 * xbar

  #let b0 = calc.round(b0, digits: 3)
  #let b1 = calc.round(b1, digits: 3)

  #let f(x) = b0 + b1 * x

  #let probit(x) = 1 / (1 + calc.exp(-f(x)))

  #align(center)[
    #table(
      columns: 2,
      inset: (x: 3em, y: 1em),
      align: center,
      [*x*], [*y*],
      ..for (x, y) in data {
        (str(x), str(y))
      },
    )
  ]

  #align(center)[
    #lq.diagram(
      width: 5cm,
      height: 5cm,
      xlim: (0, 6.1),
      ylim: (0, 1.1),
      xlabel: [$x$],
      ylabel: [$y$],
      xaxis: (position: 0, tip: tiptoe.triangle, filter: (value, distance) => value != 0, subticks: none, tick-args: (tick-distance: 1)),
      yaxis: (position: 0, tip: tiptoe.triangle, subticks: none, tick-args: (tick-distance: 0.5)),
      lq.plot(xs, ys, mark: "o", stroke: none, mark-color: black),
    )
  ]

  Fit linear model

  $
    eta = beta_0 + beta_1 x
  $

  $
    beta_0 & = #b0 \
    beta_1 & = #b1 \
  $

  #align(center)[
    #let curve_xs = lq.linspace(0, 7, num: 200)
    #lq.diagram(
      width: 5cm,
      height: 5cm,
      xlim: (0, 6.1),
      ylim: (0, 1.1),
      xlabel: [$x$],
      ylabel: [$y$],
      xaxis: (position: 0, tip: tiptoe.triangle, filter: (value, distance) => value != 0, subticks: none, tick-args: (tick-distance: 1)),
      yaxis: (position: 0, tip: tiptoe.triangle, subticks: none, tick-args: (tick-distance: 0.5)),
      lq.plot(curve_xs, x => f(x), mark: none, stroke: (paint: red, thickness: 1pt)),
      lq.plot(xs, ys, mark: "o", stroke: none, mark-color: black),
    )
  ]

  Logit link function:

  $
    g(p) = log p / (1 - p) = eta
  $

  Model

  $
    log p / (1 - p) = beta_0 + beta_1 x
  $

  Equivalently

  $
    p = 1 / (1 + e^(-(beta_0 + b_1 x)))
  $

  #align(center)[
    #let curve_xs = lq.linspace(0, 7, num: 200)
    #lq.diagram(
      width: 5cm,
      height: 5cm,
      xlim: (0, 6.1),
      ylim: (0, 1.1),
      xlabel: [$x$],
      ylabel: [$y$],
      xaxis: (position: 0, tip: tiptoe.triangle, filter: (value, distance) => value != 0, subticks: none, tick-args: (tick-distance: 1)),
      yaxis: (position: 0, tip: tiptoe.triangle, subticks: none, tick-args: (tick-distance: 0.5)),
      lq.plot(curve_xs, x => probit(x), mark: none, stroke: (paint: red, thickness: 1pt)),
      lq.plot(xs, ys, mark: "o", stroke: none, mark-color: black),
    )
  ]

]
