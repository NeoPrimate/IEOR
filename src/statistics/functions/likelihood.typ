#import "/lib/imports.typ": *
#show: formatting

$
  #math.cal("L") (theta | x) = f(x | theta)
$

Where:
- $theta$: model parameters
- $x$: observed data

#align(center)[
  #frame(cetz.canvas({
    import draw: *

    set-style(
      axes: (
        x: (stroke: 0pt),
        y: (stroke: 0pt, tick: (label: (offset: 1em))),
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
        
        plot.add(
          ((1, gaussian_pdf(1, mu, sigma)),),
          mark: "o",
          mark-size: 0.2,
          mark-style: (fill: red, stroke: 1pt),
        )

        plot.add-vline(
          1, 
          max: gaussian_pdf(1, mu, sigma),
          style: (stroke: (paint: red, dash: "dashed")),
        )
      })
  }))
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
  [PDF $phi.alt(x; mu, sigma)$], [$mu, sigma$], [$x$], [Yes],
  [Likelihood $cal(L)(mu, sigma | x)$], [$x$], [$mu, sigma$], [No],
)

- *PDF*: parameters fixed, sweep $x$ — a curve over outcomes that integrates to 1.
- *Likelihood*: data fixed, sweep the parameters — *not* a density in $mu, sigma$, so it need not integrate to 1.

For $n$ independent observations the likelihood is the product of per-point densities:

$
  cal(L)(mu, sigma | x_1, dots, x_n) = product_(i=1)^n phi.alt (x_i; mu, sigma)
$
