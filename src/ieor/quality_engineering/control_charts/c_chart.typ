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
  macron(c) = 1/k sum_(i=1)^k c_i
$

$
  "UCL"_c &= macron(c) + 3 sqrt(macron(c)) \
  "LCL"_c &= macron(c) - 3 sqrt(macron(c)) \
$

Where:

- $c$: number of defects

- $k$: number of samples



#eg[

  #align(center)[
    #canvas({
      import draw: *

      let k = 25

      let rng = gen-rng(42)

      let (_, c) = integers(rng, low: 0., high: 10., size: k)

      let series = range(1, k).zip(c)

      let c_bar = c.sum() / k
      let ucl = c_bar + 3 * calc.sqrt(c_bar)
      let lcl = calc.max(0, c_bar - 3 *calc.sqrt(c_bar))

      plot.plot(
        size: (8, 4),
        axis-style: "school-book",
        x-label: [Sample],
        y-label: [Number of\ Defects],
        x-tick-step: 5,
        y-tick-step: 3, 
        legend: "north-east",
        {
          plot.add(
            series, 
            style: (stroke: blue),
            mark: "o",
          )
          
          plot.add-hline(ucl, label: $"UCL"$, style: (stroke: red))
          plot.add-hline(c_bar, label: $macron(c)$, style: (stroke: green))
          plot.add-hline(lcl, label: $"LCL"$, style: (stroke: red))
        })
    })
  ]

  This C-chart displays the number of defects identified in each of 25 inspected units, where each unit is of fixed size. The center line represents the average number of defects across all samples, calculated as:

  $
    macron(c) = 1/k sum_(i=1)^k c_i
  $

  Control limits are drawn at ±3 standard deviations from the mean, using the square root of $macron(c)$ to account for Poisson-distributed defect counts:

  $
    "UCL"_c &= colorMath(macron(c) + 3 sqrt(macron(c)), #red) 
    quad quad quad 
    "LCL"_c &= max(0, colorMath(macron(c) - 3 sqrt(macron(c)), #red)) \
  $



]
