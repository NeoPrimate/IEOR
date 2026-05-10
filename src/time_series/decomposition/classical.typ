#import "/lib/imports.typ": *

Decompose a time series $y_t$ into four components that *add up* (or *multiply*) back to the original:

- *Level* $L_t$: baseline value around which the series fluctuates
- *Trend* $T_t$: long-term progression or direction
- *Seasonal* $S_t$: regular, repeating patterns over a fixed period $m$
- *Noise* $N_t$: irregular fluctuations not explained by the other components (residuals)

Two functional forms — additive and multiplicative — depending on whether the seasonal swing is *constant* in absolute units or *proportional* to the level.

=== Additive form

$ y_t = L_t + T_t + S_t + N_t $

Use when the *amplitude* of seasonal swings is roughly constant over time, regardless of the level. Example: temperature (summer is ~10°C above average whether the long-run average is 15°C or 25°C).

=== Multiplicative form

$ y_t = L_t dot T_t dot S_t dot N_t $

Use when the seasonal amplitude *scales with* the level. Example: retail sales (December peak is 30% above the trend, whether the trend is at \$1M or \$10M).

A multiplicative decomposition can always be converted to an additive one via $log y_t = log L_t + log T_t + log S_t + log N_t$ — useful trick if your tools support only additive.

=== How to choose

Plot the series. If the seasonal swing *grows* with the level → multiplicative. If it stays roughly constant → additive. When unsure, try both and check which has more uniform residuals.

=== Procedure (additive case, integer period $m$)

The classic step-by-step:

+ *Estimate trend* via centered moving average of size $m$. For even $m$ (typical with monthly data, $m = 12$), use a 2-step MA: first an $m$-MA, then a 2-MA. Result: $hat(T)_t$.
+ *Detrend*: $y_t - hat(T)_t$.
+ *Estimate seasonal indices*: average the detrended values within each seasonal slot (e.g., all Januaries, all Februaries, etc.). Adjust so the seasonal indices sum to zero (additive) or average to 1 (multiplicative). Result: $hat(S)_t$ (depends only on $t mod m$).
+ *Residual / noise*: $hat(N)_t = y_t - hat(T)_t - hat(S)_t$.

=== Limitations of classical decomposition

- *Constant seasonal pattern*: classical decomposition assumes the seasonal effect is the *same* in every cycle. Real series often have *evolving* seasonality (Christmas effect grows over decades). Use STL ([stl.typ](stl.typ)) for those.
- *Endpoint problem*: the centered MA has gaps at the start and end (size $m\/2$ each). Modern methods (STL, X-13) handle this better.
- *Sensitivity to outliers*: a single anomalous month can distort the seasonal index for that slot. Robust methods (STL with robust loess) address this.

For a quick first pass, classical decomposition is fine. For production forecasting, prefer STL.

#example[
  *Given* (24 months of monthly sales data, additive case):

  #table(
    columns: 13,
    inset: 0.4em,
    align: center,
    [Month], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dec],
    [], [Year 1], [110], [105], [120], [130], [125], [115], [108], [112], [122], [135], [150],
    [165], [], [Year 2], [120], [115], [130], [140], [135], [125], [118], [122], [132], [145],
    [160], [175], [],
  )

  *Step 1 — trend via 12-MA (centered, requires 2-MA on top)*

  At each month $t$ (for $t in {7, ..., 18}$ where the centered window fits), compute the 12-month centered moving average. For January year 2 ($t = 13$):

  $ hat(T)_13 = ("avg of months 8..18 first, then average pairs") approx 130 $

  (rough estimate; actual computation involves a 12-MA followed by a 2-MA at each midpoint)

  *Step 2 — detrend*

  $y_t - hat(T)_t$ leaves the seasonal + noise components:

  Sample: $y_(13) - hat(T)_(13) approx 120 - 130 = -10$ (Jan year 2 is 10 below trend).

  *Step 3 — average detrended values per month*

  Pool *all* Januaries: $(110 - 116) + (120 - 130) approx -8$, average $approx -8$.
  Pool *all* Decembers: $(165 - 121) + (175 - 142) approx +37$.
  ... and so on for each month.

  Adjust so seasonal indices sum to 0:

  #table(
    columns: 13,
    inset: 0.5em,
    align: center,
    [], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dec],
    [$hat(S)$], [$-10$], [$-15$], [$0$], [$+10$], [$+5$], [$-5$], [$-12$], [$-8$], [$+2$], [$+15$], [$+30$], [$+45$],
  )

  Sum: $approx 57$ → adjust by $-4.75$ per month so they sum to 0 (skipped here for brevity).

  *Step 4 — residuals*

  $hat(N)_t = y_t - hat(T)_t - hat(S)_t$. If the model fits well, residuals are small and structureless.

  *Step 5 — interpret*

  - *Trend*: ~+10 units / year (rough slope between year-1 and year-2 averages).
  - *Seasonal*: clear December peak, January-February through.
  - *Noise*: small, well-explained.

  *Use*: forecast next month by extending the trend and adding the seasonal index. For Jan year 3: $hat(y)_(25) = hat(T)_(25) + hat(S)_("Jan") approx 145 + (-10) = 135$.
]
