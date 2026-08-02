#import "/lib/imports.typ": *
#show: formatting

= One-Sample Z-Test for Mean

*Warning*: Pipulation standard deviation, $sigma$, is known.

$
  H_0&: mu \
  H_a&: mu \
$

#example[
  Your favorite candy company claims their chocolate bars have a mean weight of 200 grams, and their population standard deviation is 5 grams. You've noticed that they've seemed lighter than usual. You take a simple random sample of 35 candy bars and find they have a mean weight of 198 grams. At $alpha$ = 0.05 test the company's claim.

  $
    H_0 &: mu gt.eq 200 \
    H_a &: mu < 200 \
  $

  // --- data -------------------------------------------------------------
  #let mu_ = 200.0
  #let sigma_ = 5.0
  #let xbar = 198.0
  #let n = 35
  #let a = 0.05
  #let cv = calc.round(tystats.norm.ppf(a), digits: 4)

  // --- statistics -------------------------------------------------------
  #let se = calc.round(sigma_ / calc.sqrt(n), digits: 4)
  #let z = calc.round((xbar - mu_) / se, digits: 4)
  #let p = calc.round(tystats.norm.cdf(z), digits: 4)

  // --- x-bar scale: N(mu, se) -------------------------------------------
  #let xpdf(v) = tystats.norm.pdf(v, mean: mu_, std_dev: se)
  #let xmin = mu_ - 3 * se
  #let xmax = mu_ + 3 * se
  #let xpeak = xpdf(mu_) * 1.1
  #let xgx = lq.linspace(xmin, xmax, num: 300)
  #let xgy = xgx.map(xpdf)
  #let xpx = lq.linspace(xmin, xbar, num: 300)
  #let xpy = xpx.map(xpdf)

  // --- z scale: N(0, 1) -------------------------------------------------
  #let zpdf(v) = tystats.norm.pdf(v, mean: 0, std_dev: 1)
  #let zxmin = -3
  #let zxmax = 3
  #let zpeak = zpdf(0) * 1.1
  #let zgx = lq.linspace(zxmin, zxmax, num: 300)
  #let zgy = zgx.map(zpdf)
  #let zpx = lq.linspace(zxmin, z, num: 300)
  #let zpy = zpx.map(zpdf)
  #let zrx = lq.linspace(zxmin, cv, num: 300)
  #let zry = zrx.map(zpdf)

  #align(center)[
    #lq.diagram(
      width: 10cm,
      height: 5cm,
      xlim: (xmin, xmax),
      ylim: (0, xpeak),
      yaxis: (ticks: none, subticks: none),
      xaxis: (
        subticks: none,
        ticks: ((mu_, box(inset: (top: 0em), text(size: 0.7em)[$mu$ \ #mu_])),),
      ),
      lq.plot(xgx, xgy, mark: none, stroke: black),
    )
  ]

  $
    z = (obar(x) - mu) / (sigma \/ sqrt(n))
  $

  Where:
  - $obar(x) = #xbar$

  - $mu = #mu_$

  - $sigma = #sigma_$

  - $n = #n$

  - $sigma \/ sqrt(n) = #sigma_ \/ sqrt(#str(n)) = #se$

  $
    z = (#xbar - #mu_) / (#sigma_ \/ sqrt(#str(n))) = #z
  $

  #align(center)[
    #lq.diagram(
      width: 10cm,
      height: 5cm,
      xlim: (xmin, xmax),
      ylim: (0, xpeak),
      yaxis: (ticks: none, subticks: none),
      xaxis: (
        subticks: none,
        ticks: (
          (xbar, box(inset: (top: 0em), text(size: 0.7em)[$obar(x)$ \ #xbar])),
          (mu_, box(inset: (top: 0em), text(size: 0.7em)[$mu$ \ #mu_])),
        )
      ),
      lq.plot(xgx, xgy, mark: none, stroke: black),
      lq.fill-between(xpx, xpy, fill: red.transparentize(75%)),
    )
  ]

  #align(center)[
    #lq.diagram(
      width: 10cm,
      height: 5cm,
      xlim: (zxmin, zxmax),
      ylim: (0, zpeak),
      yaxis: (ticks: none, subticks: none),
      xaxis: (
        subticks: none,
        ticks: (
          (0, box(inset: (top: 0em), text(size: 0.7em)[$0$])),
          (cv, box(inset: (top: 0em), text(size: 0.7em)[$z^*$\ #cv])),
          (z, box(inset: (top: 0em), text(size: 0.7em)[$z$\ #z])),
        )
      ),
      lq.plot(zgx, zgy, mark: none, stroke: black),
      lq.fill-between(zrx, zry, fill: red.transparentize(75%)),
      lq.fill-between(zpx, zpy, fill: red.transparentize(75%)),

      lq.place(-1.6, 0.3 * zpeak, align: right, pad(0.4em, text(0.75em)[rejection\ region])),
      lq.place(-2.3, 0.15 * zpeak, align: right, pad(0.4em, text(0.75em)[p-value])),
    )
  ]

  $
    P(z lt.eq #z) = #p
  $

  $
    z"-value" &< "critical-value" \
    #z &< #cv
  $

  $
    p"-value" &< alpha"-value" \
    #p &< #a
  $

  Reject $H_0$. At $alpha = #a$ there is sufficient evidence that the mean weight of the chocolate bars is less than 200 grams.
]

#code[
```py
  import numpy as np
  from scipy.stats import norm

  mu = 200.0
  sigma = 5.0
  xbar = 198
  n = 35
  alpha = 0.05

  cv = norm.ppf(alpha)

  z = (xbar - mu) / (sigma / np.sqrt(n))
  p = norm.cdf(z)

  if z <= cv:
      print("Reject null hypothesis")
  else:
      print("Fail to reject null hypothesis")
```
]











