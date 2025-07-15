#import "@preview/cetz:0.3.4"
#import "@preview/cetz-plot:0.1.1"
#import "@preview/fletcher:0.5.7" as fletcher: diagram, node, edge
#import "@preview/suiji:0.4.0"

#import "../../utils/examples.typ": eg
#import "../../utils/code.typ": code
#import "../../utils/color_math.typ": colorMath

#set math.vec(delim: "[")
#set math.mat(delim: "[")

== Exponential Smoothing

Gives more weight to recent data points (more responsive to new information)

$
s_t = alpha x_t + (1 - alpha) s_(t-1)
$

Where:

- $s_t$: the smoothed value at time $t$
- $x_t$: actual value at time $t$
- $alpha$: smoothing factor between 0 and 1 

Common way to choose $alpha$ based on the smoothing window length $N$:

$
  alpha = 2 / (N + 1)
$

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

    let alpha = 0.1

    let dates = range(data.len()).map(i => (t0 + duration(days: i)))

    let s = (data.at(0),)
    for i in range(1, data.len()) {
      let new_s = alpha * data.at(i) + (1 - alpha) * s.at(i - 1)
      s.push(new_s)
    }

    let data = range(dates.len()).zip(data)
    let es = range(dates.len()).zip(s)

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
      x-min: 0, x-max: data.len()+1,
      y-min: -2, y-max: 2,
    {
      plot.add(
        data,
        style: (stroke: 1pt + black.lighten(75%)),
        // label: [Data],
      )
      plot.add(
        es,
        style: (stroke: 1pt + red.lighten(25%)),
        // label: [Exp],
      )
    }
  )
  })
]

#eg[
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
      [4], [13],
      [5], [15],
    )
  ]
  
  Calculate Smoothing Factor

  $
  alpha = 2 / (3 + 1) = 0.5
  $

  Calculate SMA for First Value

  $
  s_3 &= (10 + 12 + 14) / 3
  $

  Calculate EMA

  $
  s_4 &= (0.5 times 13) + (12 times 0.5) = 12.5
  \
  \
  s_5 &= (0.5 times 15) + (12.5 times 0.5) = 13.75
  $
]

#code[
  ```py
  pl.col("X").ewm_mean(span=window_size, adjust=False)
  ```
]