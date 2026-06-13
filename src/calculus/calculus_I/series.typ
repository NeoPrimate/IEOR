#import "/lib/imports.typ": *
#show: formatting

Given the series $(a_n) = a_1 + a_2 + ...$, then

$
  sum_(n=1)^infinity a_n = a_1 + a_2 + dots
$

We form a sequence associated with the series, the sequence $(s_n)$ of its *partial sums*:

$
  s_1 & = a_1 \
  s_2 & = a_1 + a_2 \
  s_3 & = a_1 + a_2 + a_3 \
      & dots.v \
  s_n & = a_1 + a_2 + dots + a_n \
      & dots.v
$

#example[
  $
    sum_(n=1)^infinity 1 / n^2
  $

  #let series = range(1, 51).map(n => (n, range(1, n + 1).map(n => (1 / calc.pow(n, 2))).sum()))
  #let ns = series.map(p => p.at(0))
  #let ss = series.map(p => p.at(1))

  #let convergence = calc.pow(calc.pi, 2) / 6

  #align(center)[
    #lq.diagram(
      width: 8cm,
      height: 3.5cm,
      xlim: (0, 50),
      ylim: (1, 1.7),
      xaxis: (tick-args: (tick-distance: 10)),
      yaxis: (tick-args: (tick-distance: 0.1)),
      lq.plot(ns, ss, mark: "o", stroke: none, mark-color: white),
      lq.hlines(convergence, stroke: black),
    )
  ]

]

== Alternating

#example[

  $
    sum_(n=1)^infinity ((-1)^(n+1)) / n
  $

  #let series = range(1, 50).map(n => (n, range(1, n + 1).map(n => (calc.pow(-1, n + 1) / n)).sum()))
  #let ns = series.map(p => p.at(0))
  #let ss = series.map(p => p.at(1))

  #let convergence = calc.ln(2)

  #align(center)[
    #lq.diagram(
      width: 8cm,
      height: 3.5cm,
      xlim: (0, 50),
      ylim: (0.5, 1),
      xaxis: (tick-args: (tick-distance: 10)),
      yaxis: (tick-args: (tick-distance: 0.1)),
      lq.plot(ns, ss, mark: "o", stroke: none, mark-color: white),
      lq.hlines(convergence, stroke: black),
    )
  ]
]

== Non-Convergent

#example[
  $
    sum_(n=1)^infinity 1 / n
  $

  #let series = range(1, 50).map(n => (n, range(1, n + 1).map(n => (1 / n)).sum()))
  #let ns = series.map(p => p.at(0))
  #let ss = series.map(p => p.at(1))

  #align(center)[
    #lq.diagram(
      width: 8cm,
      height: 3.5cm,
      xlim: (0, 50),
      ylim: (1, 4.5),
      xaxis: (tick-args: (tick-distance: 10)),
      yaxis: (tick-args: (tick-distance: 1)),
      lq.plot(ns, ss, mark: "o", stroke: none, mark-color: white),
    )
  ]
]
