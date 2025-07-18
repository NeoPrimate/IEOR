#import "../../../utils/examples.typ": eg
#import "../../../utils/code.typ": code
#import "../../../utils/color_math.typ": colorMath
#import "../../../utils/result.typ": result
#import "@preview/cetz:0.3.1": canvas, draw
#import "@preview/cetz-plot:0.1.0": plot
#import "@preview/suiji:0.3.0": *

== P-charts (Proportion)

The p-chart monitors the proportion of defectives in each sample, accounting for variable sample sizes.

$
  "UCL"_(p_i) = overline(p) + 3 sqrt((overline(p) (1 - overline(p))) / n_i) \
  "LCL"_(p_i) = overline(p) - 3 sqrt((overline(p) (1 - overline(p))) / n_i) \
  
$

Where:

- $d_i$: The number of defective items observed in sample $i$
- $p_i$: sample proportion defective

$
  p_i = d_i / n_i
$

- $overline(p)$: overall proportion defective

$
  overline(p) = (sum d_i) / (sum n_i)
$

- $n_i$: sample size for sample $i$

#align(center)[
  #canvas({
    import draw: *

    let k = 25
    let rng = gen-rng(42)

    // Varying sample sizes per subgroup
    let (_, n) = integers(rng, low: 40, high: 80, size: k)
    let (_, d) = integers(rng, low: 0, high: 10, size: k)

    let p = d.zip(n).map(((dn) => dn.at(0) / dn.at(1)))
    let total_d = d.sum()
    let total_n = n.sum()
    let p_bar = total_d / total_n

    let ucl = n.map(ni => p_bar + 3 * calc.sqrt(p_bar * (1 - p_bar) / ni))
    let lcl = n.map(ni => calc.max(0, p_bar - 3 * calc.sqrt(p_bar * (1 - p_bar) / ni)))

    let series = range(1, k).zip(p)
    let ucl_series = range(1, k).zip(ucl)
    let lcl_series = range(1, k).zip(lcl)

    plot.plot(
      size: (8, 4),
      axis-style: "school-book",
      x-label: [Sample],
      y-label: [Proportion\ Defective],
      x-tick-step: 5,
      y-tick-step: 0.05,
      legend: "north-east",
      {
        plot.add(series, style: (stroke: blue), mark: "o")
        plot.add(ucl_series, style: (stroke: red), label: $"UCL"$)
        plot.add-hline(p_bar, label: $overline(p)$, style: (stroke: green))
        plot.add(lcl_series, style: (stroke: red), label: $"LCL"$)
      })
  })
]
