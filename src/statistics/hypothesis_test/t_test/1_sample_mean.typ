#import "/lib/imports.typ": *
#show: formatting

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

#line(length: 100%)

== One-sample

Tests if the mean of a single sample differs from a known or hypothesized population mean.

$
  t = (macron(x) - mu_0) / (s / sqrt(n))
$

- $macron(x)$: sample mean
- $mu_0$: hypothesized population mean
- $s$: sample standard deviation
- $n$: sample size

#example[

  $
    [78, 82, 89]
  $

  Step 1: State Hypotheses

  $
    H_0: mu = 85 "cm"
  $
  $
    H_1: mu ≠ 85 "cm"
  $

  Step 2: Summarize Data

  - Sample values:

  $ x_1 = 78, x_2 = 82, x_3 = 89 $

  - Sample size:

  $ n = 3 $

  Step 3: Calculate Sample Mean ($macron(x)$)

  $ macron(x) = (x_1 + x_2 + x_3) / n = (78 + 82 + 89) / 3 = 83 $

  Step 4: Calculate Sample Standard Deviation:

  $ s = sqrt((sum_(i=1)^n (x_i - macron(x))^2) / (n - 1)) $

  - Find the deviations from the mean and square them

  $ (x_1 - macron(x))^2 = (78 - 83)^2 = (-5)^2 = 25 $
  $ (x_2 - macron(x))^2 = (82 - 83)^2 = (-1)^2 = 1 $
  $ (x_3 - macron(x))^2 = (89 - 83)^2 = (6)^2 = 36 $

  - Sum of squared deviations

  $ "SSD" = 25 + 1 + 36 $

  - Calculate variance of sample

  $ s^2 = "SSD" / (n - 1) = 62 / (3 - 1) = 62 / 2 = 31 $

  - Calculate Sample Standard Deviation

  $ s = sqrt(s^2) = sqrt(32) = 5.57 $

  Step 5: Calculate the Test Statistic

  $
    t = (macron(x) - mu_0) / (s / sqrt(n)) = (83 - 85) / (5.57 / sqrt(3)) = -3 / 3.22 = -0.62
  $

  Step 6: Determine the Degrees of Freedom

  $
    d f = n - 1 = 15 - 1 = 14
  $

  Step 7: Find Critical t-value

  - For a two-tailed test at a significance level ($alpha$) of 0.05 and 2 degrees of freedom ($d f$)

  $ 4.303 $


  Step 8: Compare the t-Value to the Critical t-Value

  - If the absolute value of the test statistic is greater than the critical t-value, reject the null hypothesis.
  - If the absolute value of the test statistic is less than the critical t-value, fail to reject the null hypothesis.

  Step 8: Find the p-Value

  $
    t = 4.303 "and" d f = 3
  $

  $
    "p-value" = 0.58
  $


]

#code(
  "t_test_one_sample.py",
  ```python
  from scipy import stats
  rvs = stats.uniform.rvs(size=50)
  stats.ttest_1samp(rvs, popmean=0.5)

  ```,
)
