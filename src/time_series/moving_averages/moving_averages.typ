== Moving Averages

A family of *forecasting methods* that produce a forecast as a *weighted average of past observations*. Each method is a different choice of weights along a single axis: *how much should past observations count?*

=== The weighting-scheme axis

Two extremes and two interpolators. All five methods can be written in the form

$ hat(x)_(t, t+1) = sum_(i = 0)^(N - 1) w_i x_(t - i) $

— they only differ in how they choose the weights $w_i$ (and the window $N$).

#table(
  columns: 5,
  inset: 0.7em,
  align: center + horizon,
  [*Method*], [*Window*], [*Weights*], [*Formula*], [*See*],
  [*Naïve*], [1], [(1, 0, 0, ...)], [$ hat(x)_(t, t+1) = x_t $], [[naive.typ](naive.typ)],
  [*SMA*], [$M$], [$(1\/M, ..., 1\/M, 0, ...)$], [$ hat(x)_(t, t+1) = 1/M sum_(i = 0)^(M-1) x_(t-i) $], [[sma.typ](sma.typ)],
  [*WMA*], [$M$], [$(w_0, w_1, ..., w_(M-1), 0, ...)$], [$ hat(x)_(t, t+1) = (sum w_i x_(t-i)) / (sum w_i) $], [[wma.typ](wma.typ)],
  [*SES*], [all], [$alpha (1-alpha)^i$ (geometric decay)], [$ hat(x)_(t, t+1) = alpha sum_(i=0)^t (1-alpha)^i x_(t-i) $], [ETS(A,N,N)],
  [*Cumulative*], [$t$], [$(1\/t, 1\/t, ..., 1\/t)$], [$ hat(x)_(t, t+1) = 1/t sum_(i=1)^t x_i $], [[cumulative.typ](cumulative.typ)],
)

=== Reading the axis

Two endpoints and two interpolators:
- *Naïve* is the case $M = 1$: only the most recent observation matters. Maximum responsiveness, no smoothing.
- *Cumulative* is the case $M = t$: every observation since the start counts equally. Maximum smoothing, no responsiveness.

Between them, two interpolators:
- *SMA* and *WMA*: finite window of size $M$, with explicit weights (equal for SMA, custom for WMA). Choosing $M$ trades responsiveness vs smoothing.
- *SES*: infinite window with geometrically-decaying weights. Choosing $alpha$ trades responsiveness ($alpha -> 1$, looks like Naïve) vs smoothing ($alpha -> 0$, looks like Cumulative).

The full ETS family (all 30 cells, see `ets/`) generalizes SES by adding trend and seasonal components on top of the level.

=== When to use each

#table(
  columns: 2,
  inset: 0.7em,
  align: left,
  [*Method*], [*Use when*],
  [Naïve], [Random-walk demand (no structure to exploit). Useful baseline — every other method should beat it.],
  [SMA], [Smooth, slowly-changing demand without trend. Easy to explain to non-technical stakeholders.],
  [WMA], [Same as SMA, but you want to give more weight to recent observations without going to full geometric decay.],
  [SES], [Slowly-changing level + want infinite-history weighting. Most operational forecasting starts here.],
  [Cumulative], [Estimating a long-run mean (for stable processes) or as a slow-baseline in regime-detection.],
)

=== Comparing them on the same data

For a *stationary* series, SMA, WMA, SES, and Cumulative all converge to the same long-run mean — they only differ in how fast they react to changes. For a *trending* series, all of them lag behind (they're averages — they smooth out the trend); use ETS or ARIMA if you have trend.

The next four files cover Naïve, SMA, WMA, and Cumulative; SES is in [ets/a-n-n.typ](../ets/a-n-n.typ) as `ETS(A, N, N)`.
