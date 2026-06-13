#import "/lib/imports.typ": *
#show: formatting

== Gaussian (Normal) distribution

$
f(x bar mu, sigma^2) = 1 / (sqrt(2 pi sigma^2)) e^(-((x - mu)^2)/(2 sigma^2))
$

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
  )
]

=== Derivative

We want $f'(x) = dif / (dif x) f(x)$, treating $mu, sigma$ as constants.

The constant factor pulls out, leaving the exponential:

$
  f'(x) = 1 / sqrt(2 pi sigma^2) dot dif / (dif x) exp(- (x - mu)^2 / (2 sigma^2))
$

*Chain rule.* Let $u(x) = - (x - mu)^2 / (2 sigma^2)$, so the exponential is $exp(u(x))$ and

$
  dif / (dif x) exp(u(x)) = exp(u(x)) dot u'(x)
$

*Differentiate $u$.* Pull out $-1 / (2 sigma^2)$, then chain-rule $(x - mu)^2$:

$
  u'(x) = - 1 / (2 sigma^2) dot 2 (x - mu) = - (x - mu) / sigma^2
$

*Assemble.* The last two factors reconstruct $f(x)$ itself:

$
  f'(x) = underbrace(1 / sqrt(2 pi sigma^2) dot exp(- (x - mu)^2 / (2 sigma^2)), f(x)) dot (- (x - mu) / sigma^2)
$

#result[
$
  f'(x) = - (x - mu) / sigma^2 dot f(x)
$
]

Setting $mu = 0$, $sigma = 1$ collapses $f$ to the standard normal $phi.alt$:

#table(
  columns: 2,
  inset: 1em,
  [Distribution], [Derivative],
  [General normal $f(x)$], [$ f'(x) = - (x - mu) / sigma^2 dot f(x) $],
  [Standard normal $phi.alt(z)$], [$ phi.alt'(z) = - z dot phi.alt(z) $],
)