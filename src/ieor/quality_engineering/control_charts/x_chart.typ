#import "../../../utils/examples.typ": eg
#import "../../../utils/code.typ": code
#import "../../../utils/color_math.typ": colorMath
#import "../../../utils/result.typ": result
#import "@preview/cetz:0.3.1": canvas, draw
#import "@preview/cetz-plot:0.1.0": plot
#import "@preview/suiji:0.3.0": *


== $overline(X)$-chart

Used to monitor the average of a continuous quality characteristic (e.g., weight, length, temperature), assuming constant sample size per subgroup.

$
  "UCL"_overline(x) = overline(x) + A_2 dot overline(R) \
  "UCL"_overline(x) = overline(x) - A_2 dot overline(R) \
$

Where:
- $overline(x)_i$: average of subgroup $i$
- $overline(x)$: grand mean of all subgroup means
- $overline(R)$: average range of all subgroups
- $A_2$: constant dependent on sample size $n$ (e.g., $A_2 = 0.577$ for $n = 5$)

#eg[
  
  #align(center)[
    #canvas({
      import draw: *

      let k = 25      // number of subgroups
      let n = 5       // sample size per subgroup
      let A2 = 0.577  // constant for n = 5

      // Generate k subgroups of size n
      let data = range(k).map(i => {
        let rng = gen-rng(i)
        let (_, ints) = integers(rng, low: 15, high: 25, size: n)
        ints.map(x => float(x))
      })

      // Compute means and ranges for each subgroup
      let x_bars = data.map(group => group.sum() / group.len())
      let ranges = data.map(group => group.sorted().at(-1) - group.sorted().at(0))

      let x_bar_bar = x_bars.sum() / x_bars.len()
      let r_bar = ranges.sum() / ranges.len()

      let ucl = x_bar_bar + A2 * r_bar
      let lcl = x_bar_bar - A2 * r_bar

      let series = range(1, k).zip(x_bars)

      plot.plot(
        size: (8, 4),
        axis-style: "school-book",
        x-label: [Sample],
        y-label: [Mean\ Measurement],
        x-tick-step: 5,
        y-tick-step: 1,
        legend: "north-east",
        {
          plot.add(series, style: (stroke: blue), mark: "o")

          plot.add-hline(ucl, label: $"UCL"$, style: (stroke: red))
          plot.add-hline(x_bar_bar, label: $overline(x)$, style: (stroke: green))
          plot.add-hline(lcl, label: $"LCL"$, style: (stroke: red))
        })
    })
  ]

]

