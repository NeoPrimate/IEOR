#import "/lib/imports.typ": *
#show: formatting

== Naïve Forecast

The simplest possible forecast: *next value equals last value*.

$ hat(x)_(t, t+1) = x_t $

For a $h$-step-ahead forecast: $hat(x)_(t, t+h) = x_t$ — flat extrapolation of the last observation.

=== When it's the right choice

The naïve forecast is *optimal* for a *random walk* — a series where each step is the previous value plus mean-zero noise:

$ x_t = x_(t-1) + epsilon_t, quad epsilon_t tilde "iid"(0, sigma^2) $

Examples of approximate random walks:
- Daily stock prices (efficient-market hypothesis)
- Daily exchange rates
- High-frequency series with no seasonality or trend

For these, *no model can beat naïve* because there's no exploitable structure. Naïve is the textbook *baseline*: any forecaster should outperform it on series with structure, and *not* outperforming it is a flag that the data is essentially a random walk.

=== Variants

#table(
  columns: 2,
  inset: 0.7em,
  align: left,
  [*Variant*], [*Formula*],
  [Naïve], [$hat(x)_(t, t+h) = x_t$],
  [Seasonal naïve],
  [$hat(x)_(t, t+h) = x_(t + h - m)$ — repeat the value from one period ago, where $m$ is the seasonal period],

  [Drift], [$hat(x)_(t, t+h) = x_t + h dot (x_t - x_1)\/(t-1)$ — naïve + average historical drift],
)

Seasonal naïve is the surprisingly-good baseline for highly seasonal series (retail, weather, energy demand). Drift is the equivalent baseline for series with a clear trend.

=== Naïve as a benchmark

Always evaluate forecasts *relative* to naïve. Define the *MASE* (mean absolute scaled error):

$ "MASE" = "MAE of model" / "MAE of naïve" $

$"MASE" < 1$: the model beats naïve. $"MASE" >= 1$: it doesn't — try a different model or accept that the series is a random walk.

The same logic applies to seasonal series with seasonal naïve as the denominator.


#example(title: "Naïve forecast and the random-walk test")[
  *Given* (last 5 days of a series):

  #table(
    columns: 6,
    inset: 0.5em,
    align: center,
    [$t$], [1], [2], [3], [4], [5],
    [$x_t$], [100], [102], [101], [104], [103],
  )

  *Step 1 — naïve 1-step forecast at $t = 5$*

  $ hat(x)_(5, 6) = x_5 = 103 $

  *Step 2 — naïve $h$-step forecasts*

  $ hat(x)_(5, 6) = hat(x)_(5, 7) = hat(x)_(5, 8) = ... = 103 $

  Flat at 103 forever.

  *Step 3 — drift variant*

  Average historical step: $(x_5 - x_1) \/ (5-1) = (103 - 100)\/4 = 0.75$.

  $ hat(x)_(5, 6) = 103 + 1 dot 0.75 = 103.75 $
  $ hat(x)_(5, 10) = 103 + 5 dot 0.75 = 106.75 $

  *Step 4 — interpret*

  Since the series wandered up and down between 100 and 104 with no clear trend, naïve's flat 103 is probably about as good as you can do. If a forecaster predicts something fancy and gets MASE > 1, the series is essentially noise — switch to naïve, save the effort.
]
