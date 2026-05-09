#import "/lib/imports.typ": *

== SMA (Simple Moving Average)

For a time series $y_t$, the SMA of window size $k$ at time $t$ is:

$ s_t = 1/k sum_(i=0)^(k-1) y_(t-i) $

The average of the last $k$ values. Equal weights $1\/k$ on each. The forecast is $hat(x)_(t, t+1) = s_t$.

=== Choosing the window size $k$

The window size trades two effects:

- *Small $k$* (1–3): forecast tracks recent observations closely. Responsive to changes; noisy.
- *Large $k$* (10+): forecast smooths out short-term noise. Stable; lags behind real changes.

Rules of thumb:
- For *non-trending, smooth* series: $k$ around 5–10 typically works.
- For *high-frequency noise*: bigger $k$ to filter the noise.
- For *responsive forecasting* (regime detection): smaller $k$.

=== Lag

SMA *lags* the true level. If the underlying series is rising linearly, the SMA tracks roughly $k\/2$ time steps behind — because the average of the last $k$ values has a center of mass at $t - (k-1)\/2$. Larger $k$ → larger lag.

This is why SMA is poor for *trending* series — it's structurally late. Use ETS or ARIMA when there's trend.

=== Visualization

The SMA filters the high-frequency noise and produces a smoother curve, but with a horizontal lag relative to the data.

#align(center)[
  #frame(cetz.canvas({
    import cetz.draw: *
    import cetz-plot: *

    let rng = suiji.gen-rng(42)
    let data = suiji.normal(rng, loc: 0, scale: 1, size: 100).at(1)

    let k = 5
    let sma = data.windows(k).map(a => a.sum() / k)

    let data = range(data.len()).zip(data)
    let sma = range(sma.len()).zip(sma)

    set-style(
      axes: (
        x: (stroke: 0pt),
        y: (stroke: 0pt),
        shared-zero: false,
      ),
    )

    plot.plot(
      size: (10, 5),
      axis-style: "school-book",
      x-label: none,
      y-label: none,
      y-tick-step: none,
      x-tick-step: none,
      {
        plot.add(data, style: (stroke: 1pt + black.lighten(75%)))
        plot.add(sma, style: (stroke: 1pt + red.lighten(25%)))
      },
    )
  }))
]

- *Model parameters*
  - $k in bb(Z)_(>=1)$: window size (number of past observations to average)
- *Observation*
  - $y_i$: observed value at time $i$, for $i in {t-k+1, ..., t}$
- *Output*
  - $s_t = hat(x)_(t, t+1)$: one-step-ahead forecast for time $t+1$, given information up to $t$


#example[
  $k = 3$.

  *Data*

  #align(center)[
    #table(
      columns: 9,
      inset: 0.6em,
      align: center,
      [$t$], [1], [2], [3], [4], [5], [6], [7], [8],
      [$x_t$], [10], [20], [30], [20], [12], [24], [36], [24],
    )
  ]

  *Init* — no parameters to seed; the first forecast is at $t = 4$ once we have $k = 3$ observations.

  *First forecast* — at $t = 4$, using $x_1, x_2, x_3$:

  $ hat(x)_(3, 4) = (10 + 20 + 30) / 3 = 20, quad e_4 = 20 - 20 = 0 $

  *Iterate*:

  #align(center)[
    #table(
      columns: 4,
      inset: 0.8em,
      align: center + horizon,
      [$t$], [$x_t$], [$hat(x)_(t-1, t)$], [$e_t$],
      [4], [20], [(10 + 20 + 30) / 3 = 20.00], [0.00],
      [5], [12], [(20 + 30 + 20) / 3 = 23.33], [-11.33],
      [6], [24], [(30 + 20 + 12) / 3 = 20.67], [3.33],
      [7], [36], [(20 + 12 + 24) / 3 = 18.67], [17.33],
      [8], [24], [(12 + 24 + 36) / 3 = 24.00], [0.00],
      [9], [—], [(24 + 36 + 24) / 3 = 28.00], [—],
    )
  ]
]

#code(
  "sma.py",
  ```py
  pl.col('X').rolling_mean(window_size)
  ```,
)
