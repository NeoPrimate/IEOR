#import "/lib/imports.typ": *
#show: formatting

== t-Distribution

$
f(t | nu) = (Gamma ((nu + 1) / 2)) / (sqrt(nu pi) Gamma (nu / 2)) (1 + t^2 / nu)^(-(nu + 1) / 2)
$

Where:
- $t$: t-statistic
- $nu$ (or $d f$): degrees of freedom
- $Gamma$: Gamma function (generalizes the factorial function)

#align(center)[
  #let nu = 10
  #let xs = lq.linspace(-5, 5, num: 200)
  #lq.diagram(
    width: 6cm,
    height: 3cm,
    xlim: (-4, 4),
    ylim: (0, 0.4),
    xaxis: (position: 0, tip: tiptoe.triangle, ticks: none),
    yaxis: (position: 0, tip: tiptoe.triangle, ticks: none),
    lq.plot(xs, x => tystats.t.pdf(x, nu), mark: none, stroke: black),
  )
]

Continuous probability distribution for estimating the mean of a normally distributed population in situations where:

- Sample size is small 

- Population standard deviation is unknown

Similar in shape to the normal distribution but has heavier tails, which means it gives more probability to values further from the mean



