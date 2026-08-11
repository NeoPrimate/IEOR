#import "/lib/imports.typ": *
#show: formatting

#let a = 0.05

== Z-Statistic

$
  z = (hat(p) - p) / sqrt((p (1 - p)) / n)
$

$
  z = (obar(x) - mu) / (sigma / sqrt(n))
$

#let x = lq.linspace(-4, 4, num: 300)
#let xs = lq.linspace(0, 4, num: 300)

#grid(
  columns: 2,
  inset: 1em,
  align: center,
  [
    PDF

    #lq.diagram(
      yaxis: (ticks: none),
      legend: (position: top + right, dx: 0pt),
      xaxis: (ticks: none),
      lq.plot(x, x.map(t => tystats.norm.pdf(t)), mark: none, stroke: black),
    )
  ],
  [
    SF

    #lq.diagram(
      ylabel: $p$,
      legend: (position: top + right, dx: 0pt),
      lq.plot(xs, xs.map(t => 2 * (1 - tystats.norm.cdf(t))),
              mark: none, stroke: black),
      lq.hlines(a, stroke: (paint: gray, dash: "dashed")),
    )
  ],
)

== T-Statistic

$
  (obar(x) - mu) / (s / sqrt(n))
$

#let dfs = (1, 4, 30)

#grid(
  columns: 2,
  inset: 1em,
  align: center,
  [
    PDF

    #lq.diagram(
      yaxis: (ticks: none),
      xaxis: (ticks: none),
      legend: (position: top + right, dx: 0pt),
      ..dfs.map(df =>
        lq.plot(x, x.map(t => tystats.t.pdf(t, df)), mark: none,
                label: $"df" = #df$)
      ),
    )
  ],
  [
    SF

    #lq.diagram(
      ylabel: $p$,
      legend: (position: top + right, dx: 0pt),
      ..dfs.map(df =>
        lq.plot(xs, xs.map(t => 2 * (1 - tystats.t.cdf(t, df))), mark: none,
                label: $"df" = #df$)
      ),
      lq.hlines(a, stroke: (paint: gray, dash: "dashed")),
    )
  ],
)

== $cal(chi)^2$-Statistic

$
  cal(chi)^2 = sum_i z_i^2
$

#let ks = (1, 3, 5)
#let xc = lq.linspace(0.0001, 12, num: 300)

#grid(
  columns: 2,
  inset: 1em,
  align: center,
  [
    PDF

    #lq.diagram(
      yaxis: (ticks: none),
      xaxis: (ticks: none),
      ylim: (0, 0.5),
      legend: (position: top + right, dx: 0pt),
      ..ks.map(k =>
        lq.plot(xc, xc.map(t => tystats.chi2.pdf(t, k)), mark: none,
                label: $k = #k$)
      ),
    )
  ],
  [
    SF

    #lq.diagram(
      ylabel: $p$,
      xlabel: $cal(chi)^2$,
      legend: (position: top + right, dx: 0pt),
      ..ks.map(k =>
        lq.plot(xc, xc.map(t => 1 - tystats.chi2.cdf(t, k)), mark: none,
                label: $k = #k$)
      ),
      lq.hlines(a, stroke: (paint: gray, dash: "dashed")),
    )
  ],
)

== F-Statistic

$
  F = (cal(chi)^2_1 \/ "df"_1) / (cal(chi)^2_2 \/ "df"_2)
$

#let dfps = ((5, 5), (5, 20), (5, 100))
#let xf = lq.linspace(0.01, 6, num: 300)

#grid(
  columns: 2,
  inset: 1em,
  align: center,
  [
    PDF

    #lq.diagram(
      yaxis: (ticks: none),
      xaxis: (ticks: none),
      legend: (position: top + right, dx: 0pt),
      ..dfps.map(((d1, d2)) =>
        lq.plot(xf, xf.map(t => tystats.f.pdf(t, d1, d2)), mark: none,
                label: $#d1, #d2$)
      ),
    )
  ],
  [
    SF

    #lq.diagram(
      ylabel: $p$,
      xlabel: $F$,
      legend: (position: top + right, dx: 0pt),
      ..dfps.map(((d1, d2)) =>
        lq.plot(xf, xf.map(t => 1 - tystats.f.cdf(t, d1, d2)), mark: none,
                label: $#d1, #d2$)
      ),
      lq.hlines(a, stroke: (paint: gray, dash: "dashed")),
    )
  ],
)
