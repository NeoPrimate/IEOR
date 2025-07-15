#import "@preview/cetz:0.3.4"
#import "@preview/cetz-plot:0.1.1"
#import "@preview/fletcher:0.5.7" as fletcher: diagram, node, edge
#import "@preview/suiji:0.4.0"

#import "../../utils/examples.typ": eg
#import "../../utils/code.typ": code
#import "../../utils/color_math.typ": colorMath

== SMA (Simple Moving Averages)

For a time series $y_t$, the SMA of window size $k$ at time $t$ is:

$
  s_t = 1/k sum^(k-1)_(i=0)y_(t-i)
$

This is the average of the last $k$ values.

#align(center)[
  #cetz.canvas({
    import cetz.draw: *
    import cetz-plot: *


    let t0 = datetime(
      year: 2020,
      month: 1,
      day: 1,
    )

    let rng = suiji.gen-rng(42)
    let mu = 0
    let sigma = 1
    let data = suiji.normal(rng, loc: mu, scale: sigma, size: 100).at(1)

    let k = 5

    let dates = range(data.len()).map(i => (t0 + duration(days: i)))

    let sma = data.windows(5).map(a => a.sum() / k)

    let data = range(data.len()).zip(data)

    let sma = range(sma.len()).zip(sma)

    set-style(
      axes: (
        x: (stroke: 0pt), 
        y: (stroke: 0pt),
        shared-zero: false
      )
    )

    plot.plot(
      size: (10,5),
      axis-style: "school-book",
      x-label: none,
      y-label: none,
      y-tick-step: none,
      x-tick-step: none,
      // x-min: 0, x-max: data.len()+1,
      // y-min: -2, y-max: 2,
    {
      plot.add(
        data,
        style: (stroke: 1pt + black.lighten(75%)),
        // label: [Data],
      )
      plot.add(
        sma,
        style: (stroke: 1pt + red.lighten(25%)),
        // label: [Exp],
      )
    }
  )
  })
]

#eg[
  The $k=3$ day SMA

  Data

  #align(center)[
    #table(
      columns: (auto, auto),
      inset: (x: 30pt, y: 10pt),
      align: horizon,
      table.header(
        [$t$], [$x$ (\$)],
      ),
      [1], [10],
      [2], [12],
      [3], [14],
      [4], [16],
      [5], [18],
    )
  ]

  $
    s_3 = (x_(t_1) + x_(t_2) + x_(t_3)) / k = (10 + 12 + 14) / 3 = 12
  $

  $
   s_4 = (x_(t_2) + x_(t_3) + x_(t_4)) / k = (12 + 14 + 16) / 3 = 14
  $

  $
    s_5 = (x_(t_3) + x_(t_4) + x_(t_5)) / k = (14 + 16 + 18) / 3 = 16
  $
]

#code[
```py
pl.col('X').rolling_mean(window_size)
```
]