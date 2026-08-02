#import "/lib/imports.typ": *
#show: formatting

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