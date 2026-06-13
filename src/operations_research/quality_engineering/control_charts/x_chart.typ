#import "/lib/imports.typ": *
#show: formatting

== $macron(X)$-chart

Used to monitor the average of a continuous quality characteristic (e.g., weight, length, temperature), assuming constant sample size per subgroup.

$
  "UCL"_macron(x) = macron(x) + A_2 dot macron(R) \
  "UCL"_macron(x) = macron(x) - A_2 dot macron(R) \
$

Where:
- $macron(x)_i$: average of subgroup $i$
- $macron(x)$: grand mean of all subgroup means
- $macron(R)$: average range of all subgroups
- $A_2$: constant dependent on sample size $n$ (e.g., $A_2 = 0.577$ for $n = 5$)

#example[

  #align(center)[
    #let k = 25 // number of subgroups
    #let n = 5 // sample size per subgroup
    #let A2 = 0.577 // constant for n = 5

    // Generate k subgroups of size n
    #let data = range(k).map(i => {
      let rng = gen-rng(i)
      let (_, ints) = integers(rng, low: 15, high: 25, size: n)
      ints.map(x => float(x))
    })

    // Compute means and ranges for each subgroup
    #let x_bars = data.map(group => group.sum() / group.len())
    #let ranges = data.map(group => group.sorted().at(-1) - group.sorted().at(0))

    #let x_bar_bar = x_bars.sum() / x_bars.len()
    #let r_bar = ranges.sum() / ranges.len()

    #let ucl = x_bar_bar + A2 * r_bar
    #let lcl = x_bar_bar - A2 * r_bar

    #let samples = range(1, k + 1)

    #lq.diagram(
      width: 8cm,
      height: 3.5cm,
      xlabel: [Sample],
      ylabel: [Mean\ Measurement],
      xaxis: (tick-args: (tick-distance: 5)),
      lq.plot(samples, x_bars, stroke: blue, mark: "o"),
      lq.hlines(ucl, label: $"UCL"$, stroke: red),
      lq.hlines(x_bar_bar, label: $macron(x)$, stroke: green),
      lq.hlines(lcl, label: $"LCL"$, stroke: red),
    )
  ]

]
