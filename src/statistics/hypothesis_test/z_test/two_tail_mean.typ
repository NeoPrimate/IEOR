#import "/lib/imports.typ": *
#show: formatting

= One-Sample Two-Tail Z-Test for Mean

#example[
  A café's automatic dispenser is calibrated to pour 250 mL per cup. The
  manufacturer specifies that pour volume has a known standard deviation of
  9 mL. After a maintenance visit, the owner wants to check whether the
  machine has drifted off target in either direction. A simple random sample
  of 36 pours has a mean volume of 245.8 mL. At $alpha$ = 0.05, test whether
  the mean pour volume differs from the calibrated setting.

  #let mu_ = 250
  #let xbar = 245.8
  #let sigma_ = 9
  #let n = 36
  #let a = 0.05

  #let se = sigma_ / calc.sqrt(n)
  #let z = calc.round((xbar - mu_) / se, digits: 2)

  #let cv = calc.round(tystats.norm.ppf(a / 2), digits: 2)
  #let lhs = cv
  #let rhs = -cv

  $
    H_0 &: mu = #mu_ \
    H_a &: mu != #mu_
  $

  #let dpdf(v) = tystats.norm.pdf(v, mean: mu_, std_dev: se)
  #let dxmin = mu_ - se * 4
  #let dxmax = mu_ + se * 4
  #let dpeak = dpdf(mu_) * 1.1
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
          (mu_, box(inset: (top: 0em), text(size: 0.7em)[$mu$ \ #mu_])),
        ),
      ),
      lq.plot(dgx, dgy, mark: none, stroke: black),
    )
  ]

  #let dpdf(v) = tystats.norm.pdf(v)

  #let dxmin = -4
  #let dxmax = 4
  #let dpeak = dpdf(0) * 1.1
  #let dgx = lq.linspace(dxmin, dxmax, num: 300)
  #let dgy = dgx.map(dpdf)

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
          (lhs, box(inset: (top: 0em), text(size: 0.7em)[#lhs])),
          (0, box(inset: (top: 0em), text(size: 0.7em)[0])),
          (rhs, box(inset: (top: 0em), text(size: 0.7em)[#rhs])),
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
          (z, box(inset: (top: 0em), text(size: 0.7em)[$z$\ #z])),
          (lhs, box(inset: (top: 0em), text(size: 0.7em)[#lhs])),
          (0, box(inset: (top: 0em), text(size: 0.7em)[0])),
          (rhs, box(inset: (top: 0em), text(size: 0.7em)[#rhs])),
        ),
      ),
      lq.plot(dgx, dgy, mark: none, stroke: black),
      lq.fill-between(lgx, lgy, fill: red.transparentize(75%)),
      lq.fill-between(rgx, rgy, fill: red.transparentize(75%)),
      lq.place(-2.2, 0.05, align: right, pad(0.4em, text(0.75em)[$alpha \/ 2$])),
      lq.place(2.2, 0.05, align: left, pad(0.4em, text(0.75em)[$alpha \/ 2$])),
    )
  ]

]