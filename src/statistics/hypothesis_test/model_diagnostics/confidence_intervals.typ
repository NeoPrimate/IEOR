#import "/lib/imports.typ": *
#show: formatting

Range within which we can be confident that the true value (population parameter) lies, based on the sample data

$
  E[obar(X)] = mu quad quad sigma_(obar(X)) = sigma / sqrt(n)
$

#grid(
  columns: 2,
  gutter: 2em,
  [
    *Known* population standard deviation ($sigma$):

    $
      C I = macron(x) plus.minus z sigma / sqrt(n)
    $    
  ],
  [
    *Unknown* population standard deviation ($sigma$):

    $
      C I = macron(x) plus.minus t s / sqrt(n)
    $
  ],
  [
    - $macron(x)$: sample mean
    - $z$: z-score of corresponding confidence level
    - $sigma$: population standard deviation
    - $n$: sample size
  ],
  [
    - $macron(x)$: sample mean
    - $t$: critical value from t-distribution
    - $s$: sample standard deviation
    - $n$: sample size
  ]
)

$
  p &= P(mu - b lt.eq obar(X) lt.eq mu + b) = 0.90 \
  &= P(-b lt.eq obar(X) - mu lt.eq b) \
  &= P(-b / (sigma \/ sqrt(n)) lt.eq (obar(X) - mu) / (sigma \/ sqrt(n)) lt.eq b / (sigma \/ sqrt(n))) \
  &= P(-b / (sigma \/ sqrt(n)) lt.eq Z lt.eq b / (sigma \/ sqrt(n))) \
$

#let mu_   = 0.0
#let sigma_ = 1.0
#let b     = 1.3
#let xbar  = 0.65

#let x = lq.linspace(-3, 3, num: 300)
#let y = x.map(x => tystats.norm.pdf(x, mean: mu_, std_dev: sigma_))
#let xf = lq.linspace(-b, b, num: 200)
#let yf = xf.map(x => tystats.norm.pdf(x, mean: mu_, std_dev: sigma_))

#lq.diagram(
  ylim: (0, auto),
  yaxis: (ticks: none, stroke: none),
  xaxis: (
    mirror: false,
    ticks: (
      (-b,   text(size: 7pt)[$mu - b$]),
      (b,    text(size: 7pt)[$mu + b$]),
      (xbar, text(size: 7pt)[$overline(X)$]),
      (mu_,  text(size: 7pt)[$mu$]),
    ),
  ),
  lq.fill-between(xf, yf, fill: blue.transparentize(75%)),
  lq.plot(x, y, mark: none, stroke: black),
  lq.vlines(mu_, stroke: black.transparentize(90%)),
  lq.vlines(-b,  stroke: black.transparentize(90%)),
  lq.vlines(b,   stroke: black.transparentize(90%)),
  lq.vlines(xbar, stroke: black.transparentize(90%)),
  lq.place(0, 0.3, $p$),
)

#lq.diagram(
  ylim: (0, auto),
  yaxis: (ticks: none, stroke: none),
  xaxis: (
    mirror: false,
    ticks: (
      (-b,   $-z$),
      (b,    $z$),
      // (xbar, $overline(X)$),
      (mu_, $0$),
    ),
  ),
  lq.fill-between(xf, yf, fill: blue.transparentize(75%)),
  // lq.fill-between(xf, yf, fill: blue.transparentize(75%)),
  // lq.fill-between(xf, yf, fill: blue.transparentize(75%)),
  lq.plot(x, y, mark: none, stroke: black),
  lq.vlines(mu_, stroke: black.transparentize(90%)),
  lq.vlines(-b, stroke: black.transparentize(90%)),
  lq.vlines(b, stroke: black.transparentize(90%)),
  lq.place(-0, 0.3, $90%$),
  lq.place(- (b + 0.3), 0.05, $5%$),
  lq.place(b + 0.3, 0.05, $5%$),
)

The $z$ for $P(-z lt.eq Z lt.eq z) = 0.90$ is the same $z$ value such that $P(Z lt.eq z) = 0.90$, which is $z = 1.64$. So, if $z = 1.64 = b / (sigma / sqrt(n))$ then $b = 1.64 sigma / sqrt(n)$.

Substituting for $b$ in our original probability equation:

$
  p = P(mu - (1.64 sigma) / sqrt(n) lt.eq obar(X) lt.eq mu + (1.64 sigma) / sqrt(n)) = 0.90
$

$
  p = P(obar(X) - (1.64 sigma) / sqrt(n) lt.eq mu lt.eq obar(X) + (1.64 sigma) / sqrt(n)) = 0.90
$

#result[
  $
    obar(x) - (1.64 s) / sqrt(n) quad quad obar(x) + (1.64 s) / sqrt(n)
  $
]

#let n_samples   = 20
#let sample_size = 20
#let mu    = 10.0
#let sigma = 5.0
#let zcrit = 1.96

// draw everything from ONE stream, then split into independent samples
#let all-data = tystats.norm.rvs(mean: mu, std_dev: sigma, size: n_samples * sample_size, seed: 45.0)

#let samples = range(n_samples).map(i => {
  let data     = all-data.slice(i * sample_size, (i + 1) * sample_size)
  let m        = data.sum() / data.len()
  let variance = data.map(x => calc.pow(x - m, 2)).sum() / (data.len() - 1)
  let half     = zcrit * calc.sqrt(variance) / calc.sqrt(data.len())
  (data: data, mean: m, half: half, hit: (m - half <= mu and mu <= m + half))
})

#let xs-all = samples.map(s => s.data).flatten()
#let xmin = calc.min(mu - 4 * sigma, ..xs-all)
#let xmax = calc.max(mu + 4 * sigma, ..xs-all)
#let xpad = (xmax - xmin) * 0.03
#let xlim = (xmin - xpad, xmax + xpad)

#let W = 12cm
#let mu-line  = lq.line((mu, 0%), (mu, 100%), stroke: (paint: black, dash: "dashed"))
#let no-marks = (stroke: none)

#block(breakable: false, stack(
  {
    let gx = lq.linspace(xlim.at(0), xlim.at(1), num: 300)
    let gy = gx.map(v => tystats.norm.pdf(v, mean: mu, std_dev: sigma))
    lq.diagram(
      width: W, height: 2.6cm,
      xlim: xlim, margin: 0%, grid: none,
      yaxis: (ticks: none, stroke: none),
      xaxis: (ticks: none, mirror: false),
      lq.plot(gx, gy, mark: none, stroke: black),
      mu-line,
    )
  },
  {
    let dots = samples.enumerate().map(((i, s)) => lq.plot(
      s.data, s.data.map(_ => i + 1),
      stroke: none, color: luma(60%), mark: "o", mark-size: 2.2pt,
    ))
    let cis = samples.enumerate().map(((i, s)) => {
      let c = if s.hit { blue } else { red }
      lq.plot(
        (s.mean,), (i + 1,), xerr: (s.half,),
        stroke: c + 1.4pt, color: c, mark: "d", mark-size: 6pt,
      )
    })
    lq.diagram(
      width: W, height: 12cm,
      xlim: xlim, ylim: (0.5, n_samples + 0.5), margin: 0%,
      yaxis: (ticks: none, stroke: none),
      xaxis: (ticks: none, stroke: none),
      mu-line, ..dots, ..cis,
    )
  },
))

#example[

]

#code[
  ```py
  from scipy.stats import t, norm
  import numpy as np

  xbar = 10
  s = 5
  n = 1000

  conf = 0.90

  p = 1 - ((1 - conf) / 2)
  crit = t.ppf(p, df=n-1)
  se = s / (np.sqrt(n))

  print(f"Cumulative Probability: {p:.2f}")
  print(f"Critical Value: {crit:.2f}")
  print(f"Standard Error: {se:.2f}")

  lower = xbar - crit * se
  upper = xbar + crit * se

  print(f"Confidence Interval: [{lower:.2f}, {upper:.2f}]")
  ```
]