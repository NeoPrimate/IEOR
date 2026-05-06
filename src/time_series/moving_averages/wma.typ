#import "/src/imports.typ": *

== WMA (Weighted Moving Average)

Same finite-window structure as SMA, but each observation in the window gets a *custom weight* — usually with more weight on more recent observations.

$ "WMA"_t = (sum_(i=0)^(M-1) w_i dot x_(t-i)) / (sum_(i=0)^(M-1) w_i) $

where $w_i$ is the weight on the observation $i$ steps before $t$ (so $w_0$ weights the most recent value, $w_(M-1)$ the oldest in the window).

The denominator $sum w_i$ normalizes the weights so the WMA is on the same scale as the data; if the weights already sum to 1, the denominator drops out.

=== Common weight schemes

- *Linearly decreasing* (most common): $w_i = M - i$. So $w_0 = M$, $w_1 = M-1$, ..., $w_(M-1) = 1$. Most weight on the most recent.
- *Triangular*: linearly increasing then decreasing — emphasizes the *middle* of the window.
- *Custom*: any non-negative weights you choose.

=== Comparison to SMA

- *SMA*: equal weight $1\/M$ on every observation in the window.
- *WMA*: more weight on recent observations (with linearly-decreasing weights).

WMA is more responsive to recent changes than SMA at the same window size $M$, because the new observation gets a relatively large weight (e.g., $M\/(M(M+1)\/2) = 2\/(M+1)$ for linearly decreasing — compared to $1\/M$ for SMA).

=== Comparison to SES

WMA with linearly-decreasing weights is conceptually similar to SES, with two differences:
- WMA truncates at $M$; SES uses the entire history (with geometrically-decaying weights).
- WMA's most-recent weight depends on $M$ (e.g., $2\/(M+1)$); SES uses the explicit smoothing parameter $alpha$.

For $M -> infinity$ with linearly-decreasing weights, WMA approaches a *geometric-weighted* form similar to SES — but with polynomially-decaying tails rather than exponentially-decaying.


#example[
  *Data*

  - Day 1: \$10
  - Day 2: \$12
  - Day 3: \$14
  - Day 4: \$13
  - Day 5: \$15

  *Weights* (linearly decreasing, $M = 3$):

  - $w_0 = 3$ (most recent)
  - $w_1 = 2$
  - $w_2 = 1$ (oldest in window)

  Denominator: $3 + 2 + 1 = 6$.

  *Forecasts*:

  $ "WMA"_3 = (3 dot 14 + 2 dot 12 + 1 dot 10) / 6 = (42 + 24 + 10) / 6 = 12.67 $
  $ "WMA"_4 = (3 dot 13 + 2 dot 14 + 1 dot 12) / 6 = (39 + 28 + 12) / 6 = 13.17 $
  $ "WMA"_5 = (3 dot 15 + 2 dot 13 + 1 dot 14) / 6 = (45 + 26 + 14) / 6 = 14.17 $

  *Compare to SMA* with $M = 3$ on the same data:

  $ "SMA"_3 = (10 + 12 + 14) / 3 = 12.00 $
  $ "SMA"_4 = (12 + 14 + 13) / 3 = 13.00 $
  $ "SMA"_5 = (14 + 13 + 15) / 3 = 14.00 $

  WMA values are slightly higher than SMA because the most-recent (and largest) observations get more weight. On a *trending up* series, WMA tracks the trend better; on a *random* series, both are similar.
]

#code(
  "wma.py",
  ```py
  weights = [3, 2, 1]
  pl.col('X').rolling_map(
      lambda s: sum(w * x for w, x in zip(weights, s)) / sum(weights),
      window_size=len(weights),
  )
  ```,
)
