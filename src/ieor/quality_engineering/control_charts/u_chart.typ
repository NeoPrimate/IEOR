#import "../../../utils/examples.typ": eg
#import "../../../utils/code.typ": code
#import "../../../utils/color_math.typ": colorMath
#import "../../../utils/result.typ": result
#import "@preview/cetz:0.3.1": canvas, draw
#import "@preview/cetz-plot:0.1.0": plot
#import "@preview/suiji:0.3.0": *


== U-charts (Unit)

Defects per unit (variable unit size)

$
  "UCL"_u = overline(u) + 3 sqrt(overline(u) / n_i) \
  "LCL"_u = overline(u) - 3 sqrt(overline(u) / n_i) \
$

Where:

- $c_i$: number of defects in sample $i$
- $n_i$: sample size of group $i$
- $u_i$: defects per unit

$
  u_i = c_i / n_i
$

- $overline(u)$:

$
  (sum c_i) / (sum n_i)
$

#align(center)[
  #canvas({
    import draw: *

    let k = 25
    let rng = gen-rng(42)

    // Variable sample sizes (e.g., units inspected)
    let (_, n) = integers(rng, low: 20, high: 100, size: k)
    let (_, c) = integers(rng, low: 0, high: 12, size: k)

    let u = c.zip(n).map(cn => cn.at(0) / cn.at(1))
    let series = range(1, k).zip(u)

    let c_sum = c.sum()
    let n_sum = n.sum()
    let u_bar = c_sum / n_sum

    let ucl = range(0, k).map(i => u_bar + 3 * calc.sqrt(u_bar / n.at(i)))
    let lcl = range(0, k).map(i => calc.max(0, u_bar - 3 * calc.sqrt(u_bar / n.at(i))))

    plot.plot(
      size: (8, 4),
      axis-style: "school-book",
      x-label: [Sample],
      y-label: [Defects\ per Unit],
      x-tick-step: 5,
      y-tick-step: 0.05,
      legend: "north-east",
      {
        plot.add(series, style: (stroke: blue), mark: "o")

        plot.add(range(1, k).zip(ucl), style: (stroke: red), label: $"UCL"_u$)
        plot.add-hline(u_bar, label: $overline(u)$, style: (stroke: green))
        plot.add(range(1, k).zip(lcl), style: (stroke: red), label: $"LCL"_u$)
      })
  })
]