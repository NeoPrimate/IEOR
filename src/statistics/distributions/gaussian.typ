#import "/lib/imports.typ": *
#show: formatting

== Gaussian (Normal) distribution

$
f(x bar mu, sigma^2) = 1 / (sqrt(2 pi sigma^2)) e^(-((x - mu)^2)/(2 sigma^2))
$

#align(center)[
  #frame(cetz.canvas({
    import draw: *

    set-style(
      axes: (
        x: (stroke: 0pt), 
        y: (stroke: 0pt),
        shared-zero: false
      )
    )

    let mu = 0
    let sigma = 1
    
    plot.plot(
      size: (10, 3),
      axis-style: "school-book",
      x-tick-step: none,
      y-tick-step: none, 
      x-label: [],
      y-label: [],
      x-min: -4., 
      x-max: 4.,
      y-min: 0., 
      y-max: 0.4,
      legend: "inner-north-west",
      {
        plot.add(
          x => gaussian_pdf(x, mu, sigma), 
          domain: (-5, 5), 
          style: (stroke: black),
        )
      })
  }))
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