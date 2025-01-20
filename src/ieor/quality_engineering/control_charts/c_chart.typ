#import "../../../utils/examples.typ": eg
#import "../../../utils/code.typ": code
#import "../../../utils/color_math.typ": colorMath
#import "../../../utils/result.typ": result
#import "@preview/cetz:0.3.1": canvas, draw
#import "@preview/cetz-plot:0.1.0": plot
#import "@preview/suiji:0.3.0": *

== C-charts (Count)

Count of defects (fixed unit size)

Number of defects observed in each sample or inspection unit

$
  overline(c) = (sum_(i=1)^k c_i) / k
$

$
  "UCL"_c = overline(c) + 3 sqrt(overline(c)) \
  "LCL"_c = overline(c) - 3 sqrt(overline(c)) \
$

Where:

- $c$: number of defects

- $k$: number of samples

#let k = 25

#let rng = gen-rng(42)

#let (_, c) = integers(rng, low: 0., high: 10., size: k)

#let series = range(1, k).zip(c)

#let c_bar = c.sum() / k
#let ucl = c_bar + 3 * calc.sqrt(c_bar)
#let lcl = calc.max(0, c_bar - 3 *calc.sqrt(c_bar))

#align(center)[
  #canvas({
    import draw: *

    plot.plot(
      size: (11, 8),
      axis-style: "school-book",
      x-tick-step: 5,
      y-tick-step: 1, 
      legend: "inner-north-east",
      {
        plot.add(
          series, 
          style: (stroke: blue),
          mark: "o",
        )
        
        plot.add-hline(ucl, label: $"UCL"$, style: (stroke: red))
        plot.add-hline(c_bar, label: $overline(c)$, style: (stroke: green))
        plot.add-hline(lcl, label: $"LCL"$, style: (stroke: red))
      })
  })
]