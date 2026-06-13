#import "/lib/imports.typ": *
#show: formatting

$
  #math.cal("L") (theta | x) = f(x | theta)
$

Where:
- $theta$: model parameters
- $x$: observed data

#align(center)[
  #let xs = lq.linspace(-5, 5, num: 200)
  #lq.diagram(
    width: 6cm,
    height: 3cm,
    xlim: (-4, 4),
    ylim: (0, 0.4),
    xaxis: (position: 0, tip: tiptoe.triangle, ticks: none),
    yaxis: (position: 0, tip: tiptoe.triangle, ticks: none),
    lq.plot(xs, x => norm.pdf(x, mean: 0, std_dev: 1), mark: none, stroke: black),
    lq.vlines(1, max: norm.pdf(1, mean: 0, std_dev: 1), stroke: (paint: red, dash: "dashed")),
    lq.plot((1,), (norm.pdf(1, mean: 0, std_dev: 1),), mark: "o", stroke: none, mark-color: red),
  )
]

== PDF vs. Likelihood

Same formula, read two ways — what is held *fixed* and what *varies* swap:

$
  phi.alt (x; mu, sigma) = 1 / (sigma sqrt(2 pi)) exp(- (x - mu)^2 / (2 sigma^2))
$

#table(
  columns: 4,
  inset: 1em,
  [Quantity], [Fixed], [Varies], [Integrates / sums to 1],
  [PDF $phi.alt (x; mu_, sigma_)$], [$mu, sigma$], [$x$], [Yes],
  [Likelihood $cal(L)(mu, sigma | x)$], [$x$], [$mu, sigma$], [No],
)

- *PDF*: parameters fixed, sweep $x$ — a curve over outcomes that integrates to 1.
- *Likelihood*: data fixed, sweep the parameters — *not* a density in $mu, sigma$, so it need not integrate to 1.

For $n$ independent observations the likelihood is the product of per-point densities:

$
  cal(L)(mu, sigma | x_1, dots, x_n) = product_(i=1)^n phi.alt (x_i; mu, sigma)
$
