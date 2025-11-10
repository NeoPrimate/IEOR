#import "../../../utils/examples.typ": eg
#import "../../../utils/code.typ": code
#import "../../../utils/color_math.typ": colorMath
#import "../../../utils/result.typ": result
#import "@preview/cetz:0.3.1": canvas, draw
#import "@preview/cetz-plot:0.1.0": plot
#import "@preview/suiji:0.3.0": *

== NP-charts (Number Proportion)

Number of defective items (constant sample size)

$
  "UCL"_(n p) = n macron(p) + 3 sqrt(n macron(p) (1 - macron(p))) \
  "LCL"_(n p) = n macron(p) - 3 sqrt(n macron(p) (1 - macron(p)))
$

Where:
- $n$: count of defective items in each sample
- $p$: proportion of defectives
- $macron(p)$: 

$
  macron(p) 
  &= 1 / k sum^k_(i=1) d_i / n \
  &= (sum^k_(i=1) d_i) / (n dot k)
$

- $macron(n p) = n macron(p)$



#align(center)[
  #canvas({
    import draw: *

    let k = 25
    let n = 50 // fixed sample size

    let rng = gen-rng(42)
    let (_, d) = integers(rng, low: 0, high: 10, size: k) // number of defective units

    let series = range(1, k).zip(d)

    let d_sum = d.sum()
    let p_bar = d_sum / (k * n)
    let np_bar = n * p_bar
    let sigma_np = calc.sqrt(n * p_bar * (1 - p_bar))
    let ucl = np_bar + 3 * sigma_np
    let lcl = calc.max(0, np_bar - 3 * sigma_np)

    plot.plot(
      size: (8, 4),
      axis-style: "school-book",
      x-label: [Sample],
      y-label: [Number of\ Defective\ Units],
      x-tick-step: 5,
      y-tick-step: 1,
      legend: "north-east",
      {
        plot.add(
          series,
          style: (stroke: blue),
          mark: "o",
        )

        plot.add-hline(ucl, label: $"UCL"$, style: (stroke: red))
        plot.add-hline(np_bar, label: $macron(n p)$, style: (stroke: green))
        plot.add-hline(lcl, label: $"LCL"$, style: (stroke: red))
      })
  })
]

