#import "/src/imports.typ": *

== STL Decomposition (Seasonal-Trend using Loess)

Modern alternative to classical decomposition. *Robust*, handles *changing* seasonal patterns, and produces *complete* trend/seasonal estimates with no endpoint gaps.

Developed by Cleveland, Cleveland, McRae, and Terpenning (1990). Standard tool in `statsmodels`, `R::stats`, `forecast::stl`.

=== What it does

Decompose a series additively:

$ y_t = T_t + S_t + R_t $

where $T$ is trend, $S$ is seasonal, $R$ is the remainder (noise). Multiplicative decomposition is handled by first taking $log y_t$, decomposing additively, then exponentiating.

Same components as classical decomposition, but the *estimation method* is different:

- *Loess* (Locally Estimated Scatterplot Smoothing): a non-parametric regression that fits local low-order polynomials to nearby points. Produces *smooth* trend and seasonal curves.
- *Iterative*: STL alternates between estimating trend and seasonal components, refining each pass. After ~few iterations the components stabilize.
- *Robustness option*: a robust-loess variant downweights outliers, making STL insensitive to anomalies.

=== Key parameters

#table(
  columns: 3,
  inset: 0.7em,
  align: (left, center, left),
  [*Parameter*], [*Typical value*], [*Effect*],
  [`np` (period)],
  [seasonal period $m$ (e.g., 12 for monthly, 7 for daily-with-weekly-seasonality)],
  [Defines the seasonal cycle],

  [`ns` (seasonal window)],
  [7-15 (must be odd ≥ 7)],
  [Smaller → seasonal pattern can change rapidly. Larger → seasonal pattern is locked-in over time. Set based on how stable seasonality is.],

  [`nt` (trend window)],
  [auto: $1.5 m \/ (1 - 1.5\/n s)$],
  [Larger → smoother trend. Smaller → trend tracks short-term moves.],

  [`nl` (low-pass window)], [next odd integer $gt.eq m$], [Internal; usually leave default.],
  [`robust`], [True / False], [If True, downweights outliers via a second pass. Use when there are known anomalies.],
)

=== Why STL beats classical decomposition

#table(
  columns: 3,
  inset: 0.7em,
  align: left,
  [*Issue*], [*Classical*], [*STL*],
  [Seasonal pattern], [Constant across cycles], [Can evolve gradually (controlled by `ns`)],
  [Endpoints], [Gaps of $m\/2$ at start and end], [Smooth all the way through],
  [Outliers], [Sensitive — one anomaly distorts seasonal index], [Robust mode downweights anomalies],
  [Multiplicative decomp], [Separate procedure], [Take logs, decompose additively, exponentiate],
)

=== Workflow

1. Plot the series, look at seasonality and trend.
2. Choose `np` (= seasonal period).
3. Try default STL — usually good. Inspect residuals: should be structureless.
4. If seasonal pattern is *clearly* shifting, lower `ns`. If residuals show seasonal structure (under-fit), lower `ns`.
5. If outliers, enable robust mode.
6. Use the components for: forecasting (forecast each component, recombine), anomaly detection (flag large residuals), seasonal-adjustment (subtract seasonal for trend-only view).

=== When STL doesn't work

- *Multiple seasonalities*: STL assumes one seasonal period. For daily data with both weekly and yearly seasonality, use MSTL (Multiple STL) or Fourier-based methods.
- *Non-additive structure*: if seasonality interacts with trend in a way that's not pure multiplicative, STL on $log y$ won't capture it. Use a structural state-space model.
- *Short series*: STL needs at least *two full seasonal cycles*; ideally more.


#example[
  *Given*: 5 years of monthly retail sales with growing seasonal swing.

  *Setup*:
  - $m = 12$ (monthly data with yearly seasonality)
  - $n s = 13$ (seasonal pattern can evolve slowly)
  - Robust mode on (Black-Friday-style anomalies expected)

  *Output*: three series, each of length 60.

  - *Trend* $T_t$: smooth upward curve, captures the multi-year growth.
  - *Seasonal* $S_t$: 12-month repeating pattern, but the December peak grows from year 1 (+10%) to year 5 (+18%) — that's the evolving seasonality STL captures.
  - *Remainder* $R_t$: small, mean-zero, ideally autocorrelation-free.

  *Use the output*:
  - *Forecast*: extend trend (e.g., linear extrapolation or random-walk) + use the most-recent seasonal pattern.
  - *Seasonally-adjusted series*: $y_t - S_t$. Useful for tracking underlying performance ignoring seasonal effects (Black Friday, summer, etc.).
  - *Anomaly detection*: large residuals $|R_t|$ flag anomalous months.

  *Code* (Python):

  ```python
  from statsmodels.tsa.seasonal import STL
  result = STL(y, period=12, seasonal=13, robust=True).fit()
  trend = result.trend
  seasonal = result.seasonal
  remainder = result.resid
  ```

  Plot all four (`result.plot()`) for visual diagnosis.
]
