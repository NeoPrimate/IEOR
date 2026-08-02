#import "/lib/imports.typ": *
#show: formatting

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