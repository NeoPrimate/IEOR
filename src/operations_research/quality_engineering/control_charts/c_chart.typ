#import "/lib/imports.typ": *
#show: formatting

Count of defects (fixed unit size)

Number of defects observed in each sample or inspection unit

$
  macron(c) = 1/k sum_(i=1)^k c_i
$

$
  "UCL"_c & = macron(c) + 3 sqrt(macron(c)) \
  "LCL"_c & = macron(c) - 3 sqrt(macron(c)) \
$

Where:

- $c$: number of defects

- $k$: number of samples

#example[

  #align(center)[
    #let k = 25
    #let rng = gen-rng(42)
    #let (_, c) = integers(rng, low: 0, high: 10, size: k)

    #let samples = range(1, k)
    #let cs = c.slice(0, samples.len())

    #let c_bar = c.sum() / k
    #let ucl = c_bar + 3 * calc.sqrt(c_bar)
    #let lcl = calc.max(0, c_bar - 3 * calc.sqrt(c_bar))

    #lq.diagram(
      width: 8cm,
      height: 3.5cm,
      xlabel: [Sample],
      ylabel: [Number of\ Defects],
      xaxis: (tick-args: (tick-distance: 5)),
      lq.plot(samples, cs, stroke: blue, mark: "o"),
      lq.hlines(ucl, label: $"UCL"$, stroke: red),
      lq.hlines(c_bar, label: $macron(c)$, stroke: green),
      lq.hlines(lcl, label: $"LCL"$, stroke: red),
    )
  ]

  This C-chart displays the number of defects identified in each of 25 inspected units, where each unit is of fixed size. The center line represents the average number of defects across all samples, calculated as:

  $
    macron(c) = 1/k sum_(i=1)^k c_i
  $

  Control limits are drawn at ±3 standard deviations from the mean, using the square root of $macron(c)$ to account for Poisson-distributed defect counts:

  $
    "UCL"_c & = colorMath(macron(c) + 3 sqrt(macron(c)), #red)
              quad quad quad
              "LCL"_c & = max(0, colorMath(macron(c) - 3 sqrt(macron(c)), #red)) \
  $

]
