#import "/lib/imports.typ": *

== Cumulative Average

Average of *every* observation since the start of the series. The expanding-window endpoint of the moving-averages axis.

$ s_t = 1/t sum_(i=1)^t x_i $

Forecast: $hat(x)_(t, t+1) = s_t$ — predict the long-run average.

=== Behavior

The cumulative average can also be written *recursively*:

$ s_t = ((t - 1) s_(t-1) + x_t) / t = s_(t-1) + (x_t - s_(t-1)) / t $

The second form makes the dynamics clear:
- New observation $x_t$ is compared to the running mean $s_(t-1)$.
- The error $(x_t - s_(t-1))$ is added back, scaled by $1\/t$.

So the *effective smoothing parameter* of the cumulative average is $alpha_t = 1\/t$ — *decreasing over time*. As more data arrives, the cumulative average becomes increasingly insensitive to new observations.

=== Comparison to other moving averages

- *Naïve* ($M = 1$, $alpha = 1$): only most-recent matters; ignores history.
- *SMA* (fixed $M$): finite window; weight per observation is $1\/M$.
- *SES* (fixed $alpha$): infinite window; weight on most recent is $alpha$, decaying geometrically.
- *Cumulative* ($M = t$, $alpha_t = 1\/t$): infinite window with *equal* weights.

The relationship between $M$, $alpha$, and effective memory:
- $alpha = 1\/M$ for SMA and an "average age" perspective on SES.
- For the cumulative average, $alpha_t -> 0$ as $t -> infinity$ — effectively *infinite* memory.

=== When to use

- *Estimating a long-run mean* of a stationary process: cumulative converges to the true mean by the law of large numbers.
- *Slow baseline* in regime detection or anomaly detection: a rapid moving average can be compared against the cumulative average to detect drift or shifts.
- *Online statistics*: classical "running mean" computed in a single pass.

Don't use it as a *forecast* for a non-stationary series. Cumulative gives equal weight to data from years ago and yesterday — useless if the level has shifted.

=== Connection to MLE

The cumulative average is the *maximum likelihood estimator* of the population mean for an i.i.d. process. So if you genuinely believe the data are i.i.d. with constant mean, cumulative average is *optimal* — best you can do.

If you don't believe i.i.d. (which is true of almost all real time series), use SES, ETS, or ARIMA instead.


#example[
  *Given*:

  #table(
    columns: 7,
    inset: 0.5em,
    align: center,
    [$t$], [1], [2], [3], [4], [5], [6],
    [$x_t$], [10], [20], [30], [20], [12], [24],
  )

  *Iterate*:

  #table(
    columns: 4,
    inset: 0.6em,
    align: center,
    [$t$], [$x_t$], [$s_t = 1/t sum_(i=1)^t x_i$], [$alpha_t = 1\/t$],
    [1], [10], [10/1 = 10.00], [1.00],
    [2], [20], [(10+20)/2 = 15.00], [0.50],
    [3], [30], [(10+20+30)/3 = 20.00], [0.33],
    [4], [20], [(10+20+30+20)/4 = 20.00], [0.25],
    [5], [12], [(10+20+30+20+12)/5 = 18.40], [0.20],
    [6], [24], [(10+20+30+20+12+24)/6 = 19.33], [0.17],
  )

  *Notice*:
  - $s_t$ stabilizes around 19–20 even as new data wiggles around.
  - The effective $alpha_t$ shrinks: by $t = 6$, the cumulative average reacts to a new observation with weight only 0.17. By $t = 100$, weight 0.01 — essentially frozen.
  - This means the cumulative average is a *late* indicator. If the underlying mean shifts at $t = 100$, it'll take many observations before $s_t$ catches up.
]
