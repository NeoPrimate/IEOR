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

= One-Sample T-Test for Mean

Population standard deviation, $sigma$, is unknown.

#example[
  An airline claims their mean departure time is 5 minutes late, but you believe their flights are more delayed than that. You take a simple random sample of 20 flights. Your sample has a mean delay of 12 mins with a sample SD of 27 mins. Assume population flight times are normally distributed. At $alpha = 0.05$ test the airline's claims.

  $
    H_0 &: mu lt.eq 5 \
    H_a &: mu > 5 \
  $

  // --- data -------------------------------------------------------------
  #let mu_ = 5
  #let s = 27
  #let xbar = 12
  #let n = 20
  #let df = n - 1
  #let a = 0.05
  #let cv = calc.round(tystats.t.ppf(1 - a, df), digits: 4)

  // --- statistics -------------------------------------------------------
  #let se = calc.round(s / calc.sqrt(n), digits: 4)
  #let t = calc.round((xbar - mu_) / se, digits: 4)
  #let p = calc.round(1 - tystats.t.cdf(t, df), digits: 4)

  // --- x-bar scale: t(df, mu, se) ---------------------------------------
  #let xpdf(v) = tystats.t.pdf(v, df, location: mu_, scale: se)
  #let xmin = mu_ - 3 * se
  #let xmax = mu_ + 3 * se
  #let xpeak = xpdf(mu_) * 1.1
  #let xgx = lq.linspace(xmin, xmax, num: 300)
  #let xgy = xgx.map(xpdf)
  #let xpx = lq.linspace(xbar, xmax, num: 300)
  #let xpy = xpx.map(xpdf)

  // --- t scale: t(df, 0, 1) ---------------------------------------------
  #let tpdf(v) = tystats.t.pdf(v, df, location: 0, scale: 1)
  #let txmin = -3
  #let txmax = 3
  #let tpeak = tpdf(0) * 1.1
  #let tgx = lq.linspace(txmin, txmax, num: 300)
  #let tgy = tgx.map(tpdf)
  #let tpx = lq.linspace(t, txmax, num: 300)
  #let tpy = tpx.map(tpdf)
  #let trx = lq.linspace(cv, txmax, num: 300)
  #let try_ = trx.map(tpdf)

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
    t = (obar(x) - mu) / (s \/ sqrt(n))
  $

  Where:
  - $obar(x) = #xbar$

  - $mu = #mu_$

  - $s = #s$

  - $n = #n$

  - $"df" = n - 1 = #df$

  - $s \/ sqrt(n) = #s \/ sqrt(#str(n)) = #se$

  $
    t = (#xbar - #mu_) / (#s \/ sqrt(#str(n))) = #t
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
          (mu_, box(inset: (top: 0em), text(size: 0.7em)[$mu$ \ #mu_])),
          (xbar, box(inset: (top: 0em), text(size: 0.7em)[$obar(x)$ \ #xbar])),
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
      xlim: (txmin, txmax),
      ylim: (0, tpeak),
      yaxis: (ticks: none, subticks: none),
      xaxis: (
        subticks: none,
        ticks: (
          (0, box(inset: (top: 0em), text(size: 0.7em)[$0$])),
          (t, box(inset: (top: 0em), text(size: 0.7em)[$t$\ #t])),
          (cv, box(inset: (top: 0em), text(size: 0.7em)[$t^*$\ #cv])),
        )
      ),
      lq.plot(tgx, tgy, mark: none, stroke: black),
      lq.fill-between(tpx, tpy, fill: red.transparentize(75%)),
      lq.fill-between(trx, try_, fill: red.transparentize(75%)),

      lq.place(1.75, 0.25 * tpeak, align: left, pad(0.4em, text(0.75em)[rejection\ region])),
      lq.place(1.07, 0.53 * tpeak, align: left, pad(0.4em, text(0.75em)[p-value])),
    )
  ]

  $
    P(t gt.eq #t) = #p
  $

  $
    t"-value" &< "critical-value" \
    #t &< #cv
  $

  $
    p"-value" &> alpha"-value" \
    #p &> #a
  $

  Fail to reject $H_0$. At $alpha = #a$ there is not sufficient evidence that the mean departure delay is more than 5 minutes.
]

#code[
  ```py
  import numpy as np
  from scipy.stats import t

  mu = 5
  s = 27
  xbar = 12
  n = 20
  df = n - 1
  alpha = 0.05

  cv = t.ppf(1 - alpha, df = df)
  
  t_statistic = (xbar - mu) / (s / np.sqrt(n))
  p = t.cdf(z)

  if cv > t_statistic:
      print("Reject null hypothesis")
  else:
      print("Fail to reject null hypothesis")
  ```
]

= Two-Sample Z-Test for Proportion

#example[
  Your friend is convinced studying doesn't help. You believe it does, so you take 2 simple random samples of your Stat course: one for students who studied > 4 hrs and one for those who studied < 4 hrs. Of the 120 students who studied > 4 hrs, 103 passed. Of the 80 who studied less, 57 passed. At a = 0.05 test your claim.

  $
    H_0 &: p_(>4) - p_(<4) lt.eq 0 \
    H_a &: p_(>4) - p_(<4) > 0 \
  $

  // --- data -------------------------------------------------------------
  #let p1 = 103
  #let n1 = 120
  #let p2 = 57
  #let n2 = 80
  #let a = 0.05
  #let cv = calc.round(tystats.norm.ppf(1 - a), digits: 4)

  // --- statistics -------------------------------------------------------
  #let phat1 = calc.round(p1 / n1, digits: 4)
  #let phat2 = calc.round(p2 / n2, digits: 4)
  #let pc = (p1 + p2) / (n1 + n2)
  #let se = calc.sqrt(pc * (1 - pc) * (1 / n1 + 1 / n2))
  #let diff = calc.round(phat1 - phat2, digits: 4)
  #let z = calc.round(diff / se, digits: 4)
  #let p = calc.round(1 - tystats.norm.cdf(z), digits: 4)

  // --- difference scale: N(0, se) ---------------------------------------
  #let dpdf(v) = tystats.norm.pdf(v, mean: 0, std_dev: se)
  #let dxmin = -3 * se
  #let dxmax = 3 * se
  #let dpeak = dpdf(0) * 1.1
  #let dgx = lq.linspace(dxmin, dxmax, num: 300)
  #let dgy = dgx.map(dpdf)
  #let dpx = lq.linspace(diff, dxmax, num: 300)
  #let dpy = dpx.map(dpdf)

  // --- z scale: N(0, 1) -------------------------------------------------
  #let zpdf(v) = tystats.norm.pdf(v, mean: 0, std_dev: 1)
  #let zxmin = -3
  #let zxmax = 3
  #let zpeak = zpdf(0) * 1.1
  #let zgx = lq.linspace(zxmin, zxmax, num: 300)
  #let zgy = zgx.map(zpdf)
  #let zpx = lq.linspace(z, zxmax, num: 300)
  #let zpy = zpx.map(zpdf)
  #let zrx = lq.linspace(cv, zxmax, num: 300)
  #let zry = zrx.map(zpdf)

  #align(center)[
    #lq.diagram(
      width: 10cm,
      height: 5cm,
      xlim: (dxmin, dxmax),
      ylim: (0, dpeak),
      yaxis: (ticks: none, subticks: none),
      xaxis: (
        subticks: none,
        ticks: ((0, box(inset: (top: 0em), text(size: 0.7em)[$0$])),),
      ),
      lq.plot(dgx, dgy, mark: none, stroke: black),
    )
  ]

  $
    z = (hat(p)_(>4) - hat(p)_(<4)) / sqrt(hat(p)_c (1 - hat(p)_c) (1/n_(>4) + 1/n_(<4)))
  $

  Where:
  - $hat(p)_(>4) = #p1 / #n1 = #phat1$

  - $hat(p)_(<4) = #p2 / #n2 = #phat2$

  - $n_(>4) = #n1$

  - $n_(<4) = #n2$

  - $hat(p)_c = (x_(>4) + x_(<4)) / (n_(>4) + n_(<4)) = (#p1 + #p2) / (#n1 + #n2) = #pc$

  $
    z = (#phat1 - #phat2) / sqrt(#pc (1 - #pc) (1 / #n1 + 1 / #n2)) = #z
  $

  $
    hat(p)_(>4) - hat(p)_(<4) = #phat1 - #phat2 = #diff
  $

  #align(center)[
    #lq.diagram(
      width: 10cm,
      height: 5cm,
      xlim: (dxmin, dxmax),
      ylim: (0, dpeak),
      yaxis: (ticks: none, subticks: none),
      xaxis: (
        subticks: none,
        ticks: (
          (0, box(inset: (top: 0em), text(size: 0.7em)[$0$])),
          (diff, box(inset: (top: 0em), text(size: 0.7em)[$#diff$])),
        )
      ),
      lq.plot(dgx, dgy, mark: none, stroke: black),
      lq.fill-between(dpx, dpy, fill: red.transparentize(75%)),
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

      lq.place(1.6, 0.35 * zpeak, align: left, pad(0.4em, text(0.75em)[rejection\ region])),
      lq.place(2.3, 0.15 * zpeak, align: left, pad(0.4em, text(0.75em)[p-value])),
    )
  ]

  $
    P(z gt.eq #z) = #p
  $

  $
    z"-value" &> "critical-value" \
    #z &> #cv
  $

  $
    p"-value" &< alpha"-value" \
    #p &< #a
  $

  Reject $H_0$. At $alpha = #a$ there is sufficient evidence that students who studied more than 4 hours passed at a higher rate.

]

= One-Sample Two-Tail Z-Test for Mean

#code[
  ```py

  ```
]

= One-Sample Two-Tail T-Test for Mean

#example[
  A snack company's energy bars are labeled as containing 20 grams of protein. A consumer group suspects the actual mean protein content differs from the label — it could be over or under. They take a simple random sample of 31 bars and measure a mean of 21.40 grams with a sample standard deviation of 2.54 grams. Assume protein content is normally distributed. At $alpha$ = 0.05, test whether the mean protein content differs from the labeled amount.

  #let mu_ = 20
  #let xbar = 21.40
  #let s = 2.54
  #let n = 31
  #let df = n - 1
  #let a = 0.05

  #let se = s / calc.sqrt(n)

  #let dpdf(v) = tystats.t.pdf(v, df)
  #let dxmin = -4
  #let dxmax = 4
  #let dpeak = dpdf(0) * 1.1
  #let dgx = lq.linspace(dxmin, dxmax, num: 300)
  #let dgy = dgx.map(dpdf)

  $
    H_0 &: mu eq #mu_  \
    H_a &: mu eq.not #mu_ \
  $

  #let cv = calc.round(tystats.t.ppf(a/2, df), digits: 2)

  #let lhs = cv
  #let rhs = (cv * -1)

  #let t = calc.round((xbar - mu_) / se, digits: 2)

  #let lgx = lq.linspace(dxmin, lhs, num: 300)
  #let lgy = lgx.map(dpdf)
  
  #let rgx = lq.linspace(rhs, dxmax, num: 300)
  #let rgy = rgx.map(dpdf)

  #align(center)[
    #lq.diagram(
      width: 10cm,
      height: 5cm,
      xlim: (dxmin, dxmax),
      ylim: (0, dpeak),
      yaxis: (ticks: none, subticks: none),
      xaxis: (
        subticks: none,
        ticks: (
          (0, box(inset: (top: 0em), text(size: 0.7em)[$0$])),
        ),
      ),
      lq.plot(dgx, dgy, mark: none, stroke: black),
    )
  ]

  #let dpdf(v) = tystats.t.pdf(v, df)
  #let dxmin = -4
  #let dxmax = 4
  #let dpeak = dpdf(0) * 1.1
  #let dgx = lq.linspace(dxmin, dxmax, num: 300)
  #let dgy = dgx.map(dpdf)
  
  #align(center)[
    #lq.diagram(
      width: 10cm,
      height: 5cm,
      xlim: (dxmin, dxmax),
      ylim: (0, dpeak),
      yaxis: (ticks: none, subticks: none),
      xaxis: (
        subticks: none,
        ticks: (
          (lhs, box(inset: (top: 0em), text(size: 0.7em)[$#lhs$])),
          (0, box(inset: (top: 0em), text(size: 0.7em)[$0$])),
          (rhs, box(inset: (top: 0em), text(size: 0.7em)[$#rhs$])),
        ),
      ),
      lq.plot(dgx, dgy, mark: none, stroke: black),
      lq.fill-between(lgx, lgy, fill: red.transparentize(75%)),
      lq.fill-between(rgx, rgy, fill: red.transparentize(75%)),
      lq.place(-2.2, 0.05, align: right, pad(0.4em, text(0.75em)[$alpha \/ 2$])),
      lq.place(2.2, 0.05, align: left, pad(0.4em, text(0.75em)[$alpha \/ 2$])),
    )
  ]
  
  #align(center)[
    #lq.diagram(
      width: 10cm,
      height: 5cm,
      xlim: (dxmin, dxmax),
      ylim: (0, dpeak),
      yaxis: (ticks: none, subticks: none),
      xaxis: (
        subticks: none,
        ticks: (
          (lhs, box(inset: (top: 0em), text(size: 0.7em)[$#lhs$])),
          (0, box(inset: (top: 0em), text(size: 0.7em)[$0$])),
          (rhs, box(inset: (top: 0em), text(size: 0.7em)[$#rhs$])),
          (t, box(inset: (top: 0em), text(size: 0.7em)[$t$\ #t])),
        ),
      ),
      lq.plot(dgx, dgy, mark: none, stroke: black),
      lq.fill-between(lgx, lgy, fill: red.transparentize(75%)),
      lq.fill-between(rgx, rgy, fill: red.transparentize(75%)),
      lq.place(-2.2, 0.05, align: right, pad(0.4em, text(0.75em)[$alpha \/ 2$])),
      lq.place(2.2, 0.05, align: left, pad(0.4em, text(0.75em)[$alpha \/ 2$])),
    )
  ]

  #let p = calc.round(2 * (1 - tystats.t.cdf(calc.abs(t), df)), digits: 4)

  Since $|t| = #calc.abs(t) > #calc.abs(lhs)$, reject $H_0$ ($p approx #p$).
  There is sufficient evidence at $alpha = #a$ that the mean protein
  content differs from #mu_ grams.


]



