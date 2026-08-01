#import "/lib/imports.typ": *
#show: formatting

= Confidence Intervals <statistics_hypothesis_test_model_diagnostics_confidence_intervals>

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
      "CI" = macron(x) plus.minus z_(alpha\/2) sigma / sqrt(n)
    $
  ],
  [
    *Unknown* population standard deviation ($sigma$):

    $
      "CI" = macron(x) plus.minus t_(alpha\/2, n-1) s / sqrt(n)
    $
  ],
  [
    - $macron(x)$: sample mean
    - $z_(alpha\/2)$: upper $alpha\/2$ quantile of $N(0, 1)$
    - $sigma$: population standard deviation (known)
    - $n$: sample size
    - $1 - alpha$: confidence level
  ],
  [
    - $macron(x)$: sample mean
    - $t_(alpha\/2, n-1)$: upper $alpha\/2$ quantile of $t_(n-1)$
    - $s$: sample standard deviation, $"ddof" = 1$
    - $n - 1$: degrees of freedom
    - $1 - alpha$: confidence level
  ]
)

#v(1em)

Both assume an i.i.d. sample from a normal population; the first is
also valid for large $n$ by the CLT, and the second is approximately
so. Note $t_(alpha\/2, n-1) -> z_(alpha\/2)$ as $n -> infinity$.

== Where the confidence interval comes from

*What we know.* If $X_1, ..., X_n$ are i.i.d. draws from a population with
mean $mu$ and standard deviation $sigma$, then the sample mean $obar(X)$ has

$
  E[obar(X)] = mu quad quad "SE" := sigma_(obar(X)) = sigma / sqrt(n)
$

and its shape is normal — exactly if the population is normal, approximately
by the CLT otherwise. We write $"SE"$ (the _standard error_) for $sigma \/ sqrt(n)$
from here on.

*The question.* How far can $obar(X)$ stray from $mu$? Pick a distance $b$ and
ask for the $b$ that makes the sample mean land within $b$ of the truth 90% of
the time:

$
  P(mu - b lt.eq obar(X) lt.eq mu + b) = 0.90
$

Note what is random here: $mu$ is a fixed (unknown) number and $obar(X)$ is the
quantity that varies from sample to sample.

=== Step 1 — Standardise

We cannot look up probabilities for $obar(X)$ directly, but we can for the
standard normal $Z$. So rewrite the event until the middle term _is_ a $Z$:

#grid(
  columns: 3,
  inset: (x: 0.5em, y: 1em),
  [$P(mu - b lt.eq obar(X) lt.eq mu + b)$], [$= P(-b lt.eq obar(X) - mu lt.eq b)$], [subtract the mean from all three parts],
  [], [$= P(-b/(sigma \/ sqrt(n)) lt.eq (obar(X) - mu)/(sigma \/ sqrt(n)) lt.eq b/(sigma \/ sqrt(n)))$], [divide all three parts by SE (positive, so the inequalities keep their direction)],
  [], [$= P(-z lt.eq Z lt.eq z)$], [the middle term is now (value - its mean) / (its sd), i.e. standard normal, so $z = b\/(sigma \/ sqrt(n))$],
  [], [$= P(- (z sigma) / sqrt(n) lt.eq obar(X) - mu lt.eq (z sigma) / sqrt(n))$], [substitute $b = z sigma\/sqrt(n)$ into line 2],
  [], [$= P(- (z sigma) / sqrt(n) - obar(X) lt.eq -mu lt.eq (z sigma) / sqrt(n) - obar(X))$], [subtract $obar(X)$ from all three parts],
  [], [$= P((z sigma) / sqrt(n) + obar(X) gt.eq mu gt.eq - (z sigma) / sqrt(n) + obar(X))$], [multiply by $-1$, so the inequalities flip],
  [], [$= P(obar(X) - (z sigma) / sqrt(n) lt.eq mu lt.eq obar(X) + (z sigma) / sqrt(n))$], [rewrite reading right-to-left],
)

#result[
  $
    [obar(x) - z s / sqrt(n), quad obar(x) + z s / sqrt(n)]
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

  df = n - 1
  alpha = 1 - conf
  p = 1 - alpha / 2
  crit = t.ppf(p, df=df)
  se = s / np.sqrt(n)
  moe = crit * se

  print(f"Degrees of Freedom:     {df}")
  print(f"Alpha:                  {alpha:.2f}")
  print(f"Cumulative Probability: {p:.3f}")
  print(f"Critical Value (t):     {crit:.4f}")
  print(f"Critical Value (z):     {norm.ppf(p):.4f}")
  print(f"Standard Error:         {se:.4f}")
  print(f"Margin of Error:        {moe:.4f}")

  lower, upper = xbar - moe, xbar + moe
  print(f"Confidence Interval:    [{lower:.2f}, {upper:.2f}]")
  print(f"Check:                  {t.interval(conf, df, loc=xbar, scale=se)}")
  ```
]

#code[
  ```py
  import numpy as np
  from scipy import stats

  x = np.array([12.1, 11.8, 13.4, 12.9, 12.2, 13.0, 11.5, 12.7])

  stats.t.interval(0.95, len(x) - 1, loc=x.mean(), scale=stats.sem(x))
  # (np.float64(12.005...), np.float64(13.019...))
  ```
]

// ────────────────────────────────────────────────────────────
// shared parameters
// ────────────────────────────────────────────────────────────

#let mu    = 10.0
#let sigma = 5.0
#let n     = 20
#let se    = sigma / calc.sqrt(n)   // standard error, sigma / sqrt(n)
#let zc    = 1.645                  // two-sided 90%
#let b     = zc * se                // half-width on the xbar scale

#let accent = rgb("#1D9E75")
#let W      = 8cm
#let H      = 2.1cm

// ────────────────────────────────────────────────────────────
// one panel: a normal curve with a shaded region and custom ticks
//   center / sd  : location and scale of the plotted distribution
//   lo / hi      : shaded region (none = extend to the axis limit)
//   ticks        : array of (value, label) pairs
// ────────────────────────────────────────────────────────────

#let step-plot(
  center: 0.0,
  sd: 1.0,
  lo: none,
  hi: none,
  ticks: (),
  fill: accent,
  width: W,
  height: H,
) = {
  let xlim = (center - 4 * sd, center + 4 * sd)
  let lo = if lo == none { xlim.at(0) } else { lo }
  let hi = if hi == none { xlim.at(1) } else { hi }
  let pdf = v => tystats.norm.pdf(v, mean: center, std_dev: sd)

  let gx = lq.linspace(..xlim, num: 300)
  let sx = lq.linspace(lo, hi, num: 200)

  lq.diagram(
    width: width, height: height,
    xlim: xlim, margin: 0%, grid: none,
    yaxis: (ticks: none, stroke: none),
    xaxis: (ticks: ticks, tip: none),
    // if your lq version takes fill-between(x, y1) only, drop the third argument
    lq.fill-between(sx, sx.map(pdf),
      fill: fill.transparentize(80%), stroke: none),
    lq.plot(gx, gx.map(pdf), mark: none, stroke: black + 0.8pt),
    lq.line((center, 0), (center, pdf(center)),
      stroke: (paint: black, dash: "dashed")),
  )
}

// ────────────────────────────────────────────────────────────
// layout helper: caption on the left, plot on the right
// ────────────────────────────────────────────────────────────

#let step(title, note, plot) = block(breakable: false, inset: (y: 0.4em), grid(
  columns: (1fr, auto),
  column-gutter: 1.2em,
  align: (left + horizon, center + horizon),
  [*#title* \ #text(size: 0.85em, note)],
  plot,
))

// ────────────────────────────────────────────────────────────
// the six steps
// ────────────────────────────────────────────────────────────

#step(
  [1. Sampling distribution],
  $ obar(X) tilde N(mu, sigma^2 / n) $,
  step-plot(
    center: mu, sd: se, lo: mu - b, hi: mu + b,
    ticks: ((mu - b, $mu - b$), (mu, $mu$), (mu + b, $mu + b$)),
  ),
)

#step(
  [2. Subtract $mu$],
  $ P(-b lt.eq obar(X) - mu lt.eq b) $,
  step-plot(
    center: 0, sd: se, lo: -b, hi: b,
    ticks: ((-b, $-b$), (0, $0$), (b, $b$)),
  ),
)

#step(
  [3. Divide by $sigma \/ sqrt(n)$],
  $ Z = (obar(X) - mu) / (sigma \/ sqrt(n)) $,
  step-plot(
    center: 0, sd: 1, lo: -zc, hi: zc,
    ticks: ((-zc, $-z$), (0, $0$), (zc, $z$)),
  ),
)

#step(
  [4. Look up the critical value],
  $ P(Z lt.eq z) = 1 - alpha / 2 = 0.95 $,
  step-plot(
    center: 0, sd: 1, hi: zc,
    fill: rgb("#7F77DD"),
    ticks: ((zc, $z = 1.645$),),
  ),
)

#step(
  [5. Back-substitute],
  $ b = 1.645 sigma / sqrt(n) $,
  step-plot(
    center: mu, sd: se, lo: mu - b, hi: mu + b,
    ticks: ((mu - b, $mu - b$), (mu + b, $mu + b$)),
  ),
)

// step 6 is not a density — it is the interval itself
#let flip-plot(xbar: 11.2, width: W, height: 1.4cm) = lq.diagram(
  width: width, height: height,
  xlim: (mu - 4 * se, mu + 4 * se), ylim: (0, 2),
  margin: 0%, grid: none,
  yaxis: (ticks: none, stroke: none),
  xaxis: (ticks: ((mu, $mu$), (xbar, $macron(x)$)), tip: none),
  lq.line((mu, 0%), (mu, 100%), stroke: (paint: black, dash: "dashed")),
  lq.plot((xbar,), (1,), xerr: (b,),
    stroke: accent + 1.4pt, color: accent, mark: "d", mark-size: 6pt),
)

#step(
  [6. Rearrange for $mu$],
  $ macron(x) plus.minus 1.645 s / sqrt(n) $,
  flip-plot(),
)
