#import "/lib/imports.typ": *
#show: formatting

$
  L(theta) = product_(i=1)^n f(x_i | theta)
$

Where:
- $f(x | theta)$: probability density (or mass) function for each observation

#let rng = gen-rng-f(10)

#let mu = 5
#let sigma = 2
#let n = 25

#let (rng, data) = normal(rng, loc: mu, scale: sigma, size: n)

#let xbar = data.sum() / data.len()
#let s = calc.sqrt(data.map(x => calc.pow(x - xbar, 2)).sum() / (data.len() - 1))

#let data_tup = data.zip(range(data.len()).map(_ => 0))

#let mus = range(mu - 3*sigma, mu + 4*sigma, step: 2)

#let likelihoods = mus.map(mu => {
  data.map(x => norm.pdf(x, mean: mu, std_dev: sigma)).product()
})

#let likelihoods_tup = mus.zip(likelihoods)

#let xs_mle = lq.linspace(mu - 3 * sigma, mu + 3 * sigma, num: 200)
#let data_xs = data_tup.map(p => p.at(0))
#let data_ys = data_tup.map(p => p.at(1))

#align(center)[
  #grid(
    inset: 0em,
    gutter: 0.5em,
    [
      #lq.diagram(
        width: 8cm,
        height: 3cm,
        xlabel: [$μ$],
        ylabel: [$L(theta)$],
        xlim: (mu - 3 * sigma, mu + 3 * sigma),
        ylim: (0, calc.max(..likelihoods) + 1e-26),
        xaxis: (ticks: none),
        yaxis: (ticks: none),
        ..mus.map(mu_ => lq.vlines(mu_, stroke: (paint: black, thickness: 1pt, dash: "dashed"))),
        lq.plot(xs_mle, mu => data.map(x => norm.pdf(x, mean: mu, std_dev: sigma)).product(), mark: none, stroke: (paint: red, thickness: 1pt)),
        lq.plot(mus, likelihoods, mark: "o", stroke: none, mark-color: red),
      )
    ],
    [
      #lq.diagram(
        width: 8cm,
        height: 3cm,
        xlim: (mu - 3 * sigma, mu + 3 * sigma),
        ylim: (0, 0.25),
        xaxis: (ticks: none),
        yaxis: (ticks: none),
        ..mus.map(mu_ => lq.vlines(mu_, stroke: (paint: black, thickness: 1pt, dash: "dashed"))),
        ..mus.map(mu_ => lq.plot(xs_mle, x => norm.pdf(x, mean: mu_, std_dev: sigma), mark: none, stroke: (paint: red, thickness: 1pt))),
      )
    ],
    [
      #lq.diagram(
        width: 8cm,
        height: 3cm,
        xlim: (mu - 3 * sigma, mu + 3 * sigma),
        ylim: (-0.5, 0.5),
        xaxis: (ticks: none),
        yaxis: (ticks: none),
        lq.hlines(0, stroke: (paint: black, thickness: 1pt)),
        ..mus.map(mu_ => lq.vlines(mu_, stroke: (paint: black, thickness: 1pt, dash: "dashed"))),
        lq.plot(data_xs, data_ys, mark: "o", stroke: none, mark-color: red),
      )
    ]
  )

]

Log Likelihood

$
  cal(l) (theta) = log L(theta) = sum_(i=1)^n log f(x_i | theta)
$
