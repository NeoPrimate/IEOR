#import "/lib/imports.typ": *
#show: formatting

Discrete probability distribution that describes the number of successes in a fixed number of independent Bernoulli trials, each with the same probability of success

$
P(X = k) = binom(n, k) p^k (1-p)^(n-k)
$

#let ns = range(1, 25)
#let b1 = ns.map(n => tystats.binom.pmf(1, n, 0.3))
#let b2 = ns.map(n => tystats.binom.pmf(1, n, 0.5))
#let b3 = ns.map(n => tystats.binom.pmf(1, n, 0.9))

#align(center)[
  #lq.diagram(
    width: 5cm,
    height: 5cm,
    xlim: (0, 24),
    ylim: (0, 0.5),
    yaxis: (position: 0, tip: tiptoe.triangle, subticks: none, tick-args: (tick-distance: 0.1)),
    xaxis: (position: 0, tip: tiptoe.triangle, filter: (value, distance) => value != 0, subticks: none, tick-args: (tick-distance: 5)),
    lq.plot(ns, b1, mark: "o", stroke: blue),
    lq.plot(ns, b2, mark: "o", stroke: red),
    lq.plot(ns, b3, mark: "o", stroke: green),
  )
]
