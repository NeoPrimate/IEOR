#import "/lib/imports.typ": *
#show: formatting

== Z-Statistic

$
  z = (hat(p) - p) / sqrt((p (1 - p)) / n)
$

$
  z = (obar(x) - mu) / (sigma / sqrt(n))
$

#let x = lq.linspace(-3, 3, num: 300)
#let norm(x) = tystats.norm.pdf(x)
#let y = x.map(norm)

#lq.diagram(
  width: 10cm,
  height: 5cm,
  yaxis: (ticks: none),
  xaxis: (ticks: none),
  lq.plot(x, y, mark: none, stroke: black),
)

== T-Statistic

$
  (obar(x) - mu) / (s / sqrt(n))
$

#let x = lq.linspace(-3, 3, num: 300)
#let norm(x) = tystats.t.pdf(x, 1)
#let y = x.map(norm)

#lq.diagram(
  width: 10cm,
  height: 5cm,
  yaxis: (ticks: none),
  xaxis: (ticks: none),
  lq.plot(x, y, mark: none, stroke: black),
)

== $cal(chi)^2$-Statistic

$
  cal(chi)^2 = sum_i z_i^2
$

#let x = lq.linspace(0, 200, num: 300)
#let norm(x) = tystats.chi2.pdf(x, 100)
#let y = x.map(norm)

#lq.diagram(
  width: 10cm,
  height: 5cm,
  yaxis: (ticks: none),
  xaxis: (ticks: none),
  lq.plot(x, y, mark: none, stroke: black),
)

== F-Statistic

$
  F = (cal(chi)^2_1 \/ "df"_1) / (cal(chi)^2_2 \/ "df"_2)
$

// #let x = lq.linspace(0, 200, num: 300)
// #let norm(x) = tystats.f.pdf(x, 100)
// #let y = x.map(norm)

// #lq.diagram(
//   width: 10cm,
//   height: 5cm,
//   yaxis: (ticks: none),
//   xaxis: (ticks: none),
//   lq.plot(x, y, mark: none, stroke: black),
// )
