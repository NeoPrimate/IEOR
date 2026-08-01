#import "/lib/imports.typ": *
#show: formatting


#let mu    = 10.0
#let sigma = 5.0

#let X(zz) = mu + sigma * zz          // z-score → x coordinate

#let conf = 0.95
#let zc   = tystats.norm.ppf(conf)    // exact, dimensionless
#let crit = X(zc)
#let critlab = calc.round(crit, digits: 2)
#let mulab   = calc.round(mu, digits: 2)

#let pdf(v) = tystats.norm.pdf(v, mean: mu, std_dev: sigma)

#let xmin = X(-3.5)
#let xmax = X(3.5)

#let peak = 0.5 / sigma               // ylim headroom scales with sigma
#let labh = 0.05 / sigma              // label height scales too

#let gx = lq.linspace(xmin, xmax, num: 300)
#let gy = gx.map(pdf)

#let fx = lq.linspace(xmin, crit, num: 200)
#let fy = fx.map(pdf)

#let ax = lq.linspace(crit, xmax, num: 200)
#let ay = ax.map(pdf)

#lq.diagram(
  width: 10cm,
  height: 5cm,
  ylim: (0, peak),
  yaxis: (ticks: none),
  xaxis: (ticks: ((mu, $#mulab$), (crit, $#critlab$),)),
  lq.fill-between(fx, fy, fill: green.transparentize(75%)),
  lq.fill-between(ax, ay, fill: red.transparentize(75%)),
  lq.plot(gx, gy, mark: none, stroke: black),
  lq.place(X(2.5), labh, $alpha$)
)

#let a = 1 - conf
#let p = 1 - a / 2

#let z  = tystats.norm.ppf(p)         // exact
#let hi = X(z)
#let lo = X(-z)
#let hilab = calc.round(hi, digits: 2)
#let lolab = calc.round(lo, digits: 2)

#let fx = lq.linspace(lo, hi, num: 200)
#let fy = fx.map(pdf)

#let rx = lq.linspace(hi, xmax, num: 200)
#let ry = rx.map(pdf)

#let lx = lq.linspace(xmin, lo, num: 200)
#let ly = lx.map(pdf)

#lq.diagram(
  width: 10cm,
  height: 5cm,
  ylim: (0, peak),
  yaxis: (ticks: none),
  xaxis: (ticks: ((lo, $#lolab$), (mu, $#mulab$), (hi, $#hilab$),)),
  lq.fill-between(fx, fy, fill: green.transparentize(75%)),
  lq.fill-between(lx, ly, fill: red.transparentize(75%)),
  lq.fill-between(rx, ry, fill: red.transparentize(75%)),
  lq.plot(gx, gy, mark: none, stroke: black),
  lq.place(X(2.5), labh, $alpha \/ 2$),
  lq.place(X(-2.5), labh, $alpha \/ 2$)
)

#let xbar = X(1)

#lq.diagram(
  width: 10cm,
  height: 5cm,
  ylim: (0, peak),
  yaxis: (ticks: none),
  xaxis: (ticks: ((lo, $#lolab$), (mu, $#mulab$), (xbar, $obar(x)$), (hi, $#hilab$),)),
  lq.fill-between(fx, fy, fill: green.transparentize(75%)),
  lq.fill-between(lx, ly, fill: red.transparentize(75%)),
  lq.fill-between(rx, ry, fill: red.transparentize(75%)),
  lq.plot(gx, gy, mark: none, stroke: black),
  lq.vlines(xbar),
  lq.place(X(2.5), labh, $alpha \/ 2$),
  lq.place(X(-2.5), labh, $alpha \/ 2$)
)

#let xbar = X(3)

#lq.diagram(
  width: 10cm,
  height: 5cm,
  ylim: (0, peak),
  yaxis: (ticks: none),
  xaxis: (ticks: ((lo, $#lolab$), (mu, $#mulab$), (xbar, $obar(x)$), (hi, $#hilab$),)),
  lq.fill-between(fx, fy, fill: green.transparentize(75%)),
  lq.fill-between(lx, ly, fill: red.transparentize(75%)),
  lq.fill-between(rx, ry, fill: red.transparentize(75%)),
  lq.plot(gx, gy, mark: none, stroke: black),
  lq.vlines(xbar),
  lq.place(X(2.5), labh, $alpha \/ 2$),
  lq.place(X(-2.5), labh, $alpha \/ 2$)
)

#let xbar = X(1)
#let xbarm = 2 * mu - xbar            // mirror of xbar about mu

#let pux = lq.linspace(xbar, xmax, num: 200)
#let puy = pux.map(pdf)

#let plx = lq.linspace(xmin, xbarm, num: 200)
#let ply = plx.map(pdf)

#lq.diagram(
  width: 10cm,
  height: 5cm,
  ylim: (0, peak),
  yaxis: (ticks: none),
  xaxis: (ticks: ((lo, $#lolab$), (xbarm, $-obar(x)$), (mu, $#mulab$), (xbar, $obar(x)$), (hi, $#hilab$),)),
  lq.fill-between(fx, fy, fill: green.transparentize(75%)),
  lq.fill-between(lx, ly, fill: red.transparentize(75%)),
  lq.fill-between(rx, ry, fill: red.transparentize(75%)),
  lq.fill-between(pux, puy, fill: purple.transparentize(75%)),
  lq.fill-between(plx, ply, fill: purple.transparentize(75%)),
  lq.plot(gx, gy, mark: none, stroke: black),
  lq.vlines(xbarm, xbar),
  lq.place(X(2.5), labh, $alpha \/ 2$),
  lq.place(X(-2.5), labh, $alpha \/ 2$),
  lq.place(X(1.5), labh, $p \/ 2$),
  lq.place(X(-1.5), labh, $p \/ 2$)
)


#let conf = 0.90    // confidence level
#let mu0  = 100.0   // H0 mean
#let s    = 15.0    // sample standard deviation
#let n    = 36      // sample size
#let xbar = 104.6   // observed sample mean

// =====================================================================
//  DERIVED (computed once)
// =====================================================================
#let se    = s / calc.sqrt(n)              // standard error of the mean
#let alpha_ = 1 - conf
#let tail  = alpha_ / 2
#let zcrit = tystats.norm.ppf(1 - tail)
#let zobs  = (xbar - mu0) / se
#let lo    = mu0 - zcrit * se              // critical values, raw scale
#let hi    = mu0 + zcrit * se
#let pval  = 2 * (1 - tystats.norm.cdf(calc.abs(zobs), mean: 0, std_dev: 1))
#let reject = calc.abs(zobs) > zcrit

#let r(v, d: 3) = calc.round(v, digits: d)
#let tick(v, lbl) = (v, text(size: 7pt, lbl))

// area under the standard normal between a and b
#let area(a, b) = tystats.norm.cdf(b, mean: 0, std_dev: 1) - tystats.norm.cdf(a, mean: 0, std_dev: 1)

// colors
#let keep-c = rgb("#2a9d8f").transparentize(78%)
#let rej-c  = rgb("#e63946").transparentize(72%)
#let p-c    = rgb("#457b9d").transparentize(60%)
#let neut-c = luma(60%).transparentize(75%)
#let blue-s = rgb("#457b9d")
#let red-s  = rgb("#e63946")

// =====================================================================
//  CURVE DATA — standard normal, defined once
// =====================================================================
#let zmin = -3.6
#let zmax = 3.6
#let x  = lq.linspace(zmin, zmax, num: 400)
#let y  = x.map(t => tystats.norm.pdf(t, mean: 0, std_dev: 1))

// left tail region, beyond -zcrit
#let x-lt = lq.linspace(zmin, -zcrit, num: 200)
#let y-lt = x-lt.map(t => tystats.norm.pdf(t, mean: 0, std_dev: 1))
// central region, between the two critical values
#let x-mid = lq.linspace(-zcrit, zcrit, num: 300)
#let y-mid = x-mid.map(t => tystats.norm.pdf(t, mean: 0, std_dev: 1))
// right tail region, beyond +zcrit
#let x-rt = lq.linspace(zcrit, zmax, num: 200)
#let y-rt = x-rt.map(t => tystats.norm.pdf(t, mean: 0, std_dev: 1))

// p-value regions, beyond +-|zobs|
#let za = calc.abs(zobs)
#let x-pl = lq.linspace(zmin, -za, num: 200)
#let y-pl = x-pl.map(t => tystats.norm.pdf(t, mean: 0, std_dev: 1))
#let x-pr = lq.linspace(za, zmax, num: 200)
#let y-pr = x-pr.map(t => tystats.norm.pdf(t, mean: 0, std_dev: 1))

// =====================================================================
//  CURVE DATA — raw scale, the sampling distribution of Xbar
// =====================================================================
#let rmin = mu0 - 3.6 * se
#let rmax = mu0 + 3.6 * se
#let xr = lq.linspace(rmin, rmax, num: 400)
#let yr = xr.map(t => tystats.norm.pdf(t, mean: mu0, std_dev: se))

#let xr-lt = lq.linspace(rmin, lo, num: 200)
#let yr-lt = xr-lt.map(t => tystats.norm.pdf(t, mean: mu0, std_dev: se))
#let xr-mid = lq.linspace(lo, hi, num: 300)
#let yr-mid = xr-mid.map(t => tystats.norm.pdf(t, mean: mu0, std_dev: se))
#let xr-rt = lq.linspace(hi, rmax, num: 200)
#let yr-rt = xr-rt.map(t => tystats.norm.pdf(t, mean: mu0, std_dev: se))

// =====================================================================
//  DOCUMENT
// =====================================================================
// #set page(margin: 2cm)
// #set par(justify: true)

= Two-tailed test, step by step

*Data.*
$ mu_0 = #r(mu0, d: 1), quad s = #r(s, d: 1), quad n = #n, quad overline(x) = #r(xbar, d: 2) $
$ H_0: mu = #r(mu0, d: 1) quad quad H_1: mu != #r(mu0, d: 1) $

The $!=$ makes this *two-tailed*: a departure from $mu_0$ in either direction
counts as evidence, so the rejection region must sit on both sides.

== Step 1 — Confidence level $arrow.r$ risk budget $alpha$

$ alpha = 1 - "conf" = 1 - #r(conf, d: 2) = #r(alpha_, d: 2) $

The area under the whole curve is $1$ — that is the entire probability, not
$#r(conf, d: 2)$. What we are doing is *carving* $alpha = #r(alpha_, d: 2)$ out
of that $1$ and setting it aside as the region where we agree to reject $H_0$
even though it is true. At this point $alpha$ is only a number; nothing on the
axis has been chosen yet.

#lq.diagram(
  width: 11cm,
  height: 3.2cm,
  xlim: (zmin, zmax),
  ylim: (0, 0.46),
  yaxis: (ticks: none, stroke: none),
  xaxis: (mirror: false, ticks: (tick(-1, $-1$), tick(0, $0$), tick(1, $1$))),
  lq.fill-between(x, y, fill: neut-c),
  lq.plot(x, y, mark: none, stroke: 0.9pt + black),
  lq.place(0, 0.18, text(size: 8pt, [total area $= 1$])),
)

== Step 2 — Split the budget in two

Two tails, so the budget is shared equally:

$ alpha / 2 = #r(alpha_, d: 2) / 2 = #r(tail, d: 3) quad "per tail" $

Shown as proportions of the total area (widths below are exactly to scale):

#grid(
  columns: (tail * 100%, conf * 100%, tail * 100%),
  rows: 1.1cm,
  align: center + horizon,
  fill: (col, _) => if col == 1 { keep-c } else { rej-c },
  text(size: 7pt, $alpha\/2$),
  text(size: 8pt, [$1 - alpha$]),
  text(size: 7pt, $alpha\/2$),
)

This is deliberately *not* drawn on the bell curve yet: to place these regions
on the axis we first need the $z$ values that cut them off.

== Step 3 — Turn each tail area into a critical value

The critical value is the $z$ leaving exactly $alpha\/2$ to its right, i.e.
$1 - alpha\/2$ to its left. That is the inverse CDF:

$ z_(alpha\/2) = Phi^(-1)(1 - alpha/2) = Phi^(-1)(#r(1 - tail, d: 3)) = #r(zcrit, d: 4) $

By symmetry the left one is $-#r(zcrit, d: 4)$.

#lq.diagram(
  width: 11cm,
  height: 3.2cm,
  xlim: (zmin, zmax),
  ylim: (0, 0.46),
  yaxis: (ticks: none, stroke: none),
  xaxis: (
    mirror: false,
    ticks: (
      tick(-zcrit, $-z_(alpha\/2) = #r(-zcrit, d: 3)$),
      tick(0, $0$),
      tick(zcrit, $z_(alpha\/2) = #r(zcrit, d: 3)$),
    ),
  ),
  lq.fill-between(x-lt, y-lt, fill: rej-c),
  lq.fill-between(x-mid, y-mid, fill: keep-c),
  lq.fill-between(x-rt, y-rt, fill: rej-c),
  lq.plot(x, y, mark: none, stroke: 0.9pt + black),
  lq.vlines(-zcrit, stroke: (paint: red-s, thickness: 0.8pt)),
  lq.vlines(zcrit, stroke: (paint: red-s, thickness: 0.8pt)),
  lq.place(0, 0.18, text(size: 8pt, [do *not* reject])),
  lq.place(-2.8, 0.055, text(size: 7pt, $alpha\/2 = #r(tail, d: 2)$)),
  lq.place(2.8, 0.055, text(size: 7pt, $alpha\/2 = #r(tail, d: 2)$)),
)

*Area check* (computed from the CDF, not asserted):

#table(
  columns: 4,
  stroke: 0.4pt + luma(70%),
  inset: 5pt,
  align: (left, center, center, center),
  text(size: 8pt)[region],
  text(size: 8pt)[left tail],
  text(size: 8pt)[centre],
  text(size: 8pt)[right tail],
  text(size: 8pt)[bounds],
  text(size: 8pt)[$(-oo, #r(-zcrit, d: 3))$],
  text(size: 8pt)[$(#r(-zcrit, d: 3), #r(zcrit, d: 3))$],
  text(size: 8pt)[$(#r(zcrit, d: 3), +oo)$],
  text(size: 8pt)[area],
  text(size: 8pt)[#r(area(-40, -zcrit), d: 4)],
  text(size: 8pt)[#r(area(-zcrit, zcrit), d: 4)],
  text(size: 8pt)[#r(area(zcrit, 40), d: 4)],
)

They sum to #r(area(-40, -zcrit) + area(-zcrit, zcrit) + area(zcrit, 40), d: 4).

== Step 4 — Standardise the observation

The curve above lives on the $z$ scale, but the data does not. On its *own*
scale the sample mean is centred at $mu_0 = #r(mu0, d: 1)$ with spread

// $ "SE" = s / sqrt(n) = #r(s, d: 1) / sqrt(#n) = #r(se, d: 3) $

#grid(
  columns: (1fr, 1fr),
  gutter: 8pt,
  [
    #text(size: 8pt, weight: "bold")[Raw scale: $overline(X) tilde N(#r(mu0, d: 1), #r(se, d: 2)^2)$]
    #lq.diagram(
      width: 100%,
      height: 3.2cm,
      xlim: (rmin, rmax),
      ylim: (0, auto),
      yaxis: (ticks: none, stroke: none),
      xaxis: (
        mirror: false,
        ticks: (
          tick(lo, $#r(lo, d: 2)$),
          tick(mu0, $mu_0$),
          tick(xbar, text(fill: blue-s, $overline(x)$)),
        ),
      ),
      lq.fill-between(xr-lt, yr-lt, fill: rej-c),
      lq.fill-between(xr-mid, yr-mid, fill: keep-c),
      lq.fill-between(xr-rt, yr-rt, fill: rej-c),
      lq.plot(xr, yr, mark: none, stroke: 0.9pt + black),
      lq.vlines(xbar, stroke: (paint: blue-s, thickness: 0.8pt, dash: "dashed")),
    )
  ],
  [
    #text(size: 8pt, weight: "bold")[Standardised: $Z tilde N(0, 1)$]
    #lq.diagram(
      width: 100%,
      height: 3.2cm,
      xlim: (zmin, zmax),
      ylim: (0, 0.46),
      yaxis: (ticks: none, stroke: none),
      xaxis: (
        mirror: false,
        ticks: (
          tick(-zcrit, $#r(-zcrit, d: 2)$),
          tick(0, $0$),
          tick(zobs, text(fill: blue-s, $z_"obs"$)),
        ),
      ),
      lq.fill-between(x-lt, y-lt, fill: rej-c),
      lq.fill-between(x-mid, y-mid, fill: keep-c),
      lq.fill-between(x-rt, y-rt, fill: rej-c),
      lq.plot(x, y, mark: none, stroke: 0.9pt + black),
      lq.vlines(zobs, stroke: (paint: blue-s, thickness: 0.8pt, dash: "dashed")),
    )
  ],
)

Same picture, relabelled axis. Every landmark maps across:

$ z_"obs" = (overline(x) - mu_0) / "SE"
  = (#r(xbar, d: 2) - #r(mu0, d: 1)) / #r(se, d: 3) = #r(zobs, d: 4) $
$ "upper cutoff:" quad #r(hi, d: 3) = mu_0 + z_(alpha\/2) dot "SE"
  quad arrow.l.r.long quad #r(zcrit, d: 3) $

== Step 5 — Compare and decide

*(a) Critical value.*

$ |z_"obs"| = #r(za, d: 3)
  #if reject [$>$] else [$<=$]
  z_(alpha\/2) = #r(zcrit, d: 3) $

#lq.diagram(
  width: 11cm,
  height: 1.5cm,
  xlim: (zmin, zmax),
  ylim: (0, 1),
  yaxis: (ticks: none, stroke: none),
  xaxis: (
    mirror: false,
    ticks: (
      tick(-zcrit, $#r(-zcrit, d: 2)$),
      tick(zcrit, $#r(zcrit, d: 2)$),
      tick(zobs, text(fill: blue-s, $z_"obs" = #r(zobs, d: 2)$)),
    ),
  ),
  lq.fill-between((zmin, -zcrit), (1, 1), fill: rej-c),
  lq.fill-between((-zcrit, zcrit), (1, 1), fill: keep-c),
  lq.fill-between((zcrit, zmax), (1, 1), fill: rej-c),
  lq.scatter((zobs,), (0.5,), color: blue-s, size: 5pt),
)

*(b) $p$-value.* Area at least as extreme as what we saw, both tails:

$ p = 2 dot (1 - Phi(|z_"obs"|)) = 2 dot #r(1 - tystats.norm.cdf(za, mean: 0, std_dev: 1), d: 4)
  = #r(pval, d: 4) #if reject [$<$] else [$>=$] alpha = #r(alpha_, d: 2) $

#lq.diagram(
  width: 11cm,
  height: 3.2cm,
  xlim: (zmin, zmax),
  ylim: (0, 0.46),
  yaxis: (ticks: none, stroke: none),
  xaxis: (
    mirror: false,
    ticks: (
      tick(-za, $-|z_"obs"| = #r(-za, d: 2)$),
      tick(0, $0$),
      tick(za, $|z_"obs"| = #r(za, d: 2)$),
    ),
  ),
  lq.fill-between(x-pl, y-pl, fill: p-c),
  lq.fill-between(x-pr, y-pr, fill: p-c),
  lq.plot(x, y, mark: none, stroke: 0.9pt + black),
  lq.place(-2.9, 0.055, text(size: 7pt, $p\/2 = #r(pval / 2, d: 3)$)),
  lq.place(2.9, 0.055, text(size: 7pt, $p\/2 = #r(pval / 2, d: 3)$)),
)

*Area check:* left #r(area(-40, -za), d: 4) $+$ right #r(area(za, 40), d: 4)
$= #r(pval, d: 4)$, matching $p$ above.

#block(
  width: 100%,
  inset: 10pt,
  radius: 4pt,
  fill: if reject { rgb("#e63946").transparentize(88%) } else { rgb("#2a9d8f").transparentize(88%) },
  [
    *Decision:* #if reject [
      $z_"obs"$ falls in a rejection tail and $p < alpha$, so *reject* $H_0$ at
      the #r(conf * 100, d: 0)% confidence level.
    ] else [
      $z_"obs"$ falls inside the acceptance region and $p >= alpha$, so *fail to
      reject* $H_0$ at the #r(conf * 100, d: 0)% confidence level.
    ]
  ],
)

#text(size: 8pt, style: "italic")[
  (a) and (b) always agree: one compares positions on the $z$ axis, the other
  compares the areas those positions cut off.
]