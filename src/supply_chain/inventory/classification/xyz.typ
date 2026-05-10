#import "/lib/imports.typ": *

#let cm(x) = text(fill: red, [$#x$])

Classify items by *demand variability*, measured via the *coefficient of variation* (CV) of demand over time:

$ "CV" = sigma / mu $

where $mu$ is mean periodic demand and $sigma$ is its standard deviation.

=== The variability split

- *X items*: low CV — predictable demand. Forecast easily, lean inventory.
- *Y items*: moderate CV — somewhat variable, perhaps with seasonality or trend.
- *Z items*: high CV — volatile, sporadic, or irregular.

Typical thresholds (industry-dependent):

#table(
  columns: 3,
  inset: 0.7em,
  align: (left, center, left),
  [*Class*], [*CV range*], [*Demand pattern*],
  [X], [< 0.50], [Smooth, predictable. Standard normal-distribution methods work.],
  [Y], [0.50 - 1.00], [Variable but trackable. Use seasonality models, careful safety stock.],
  [Z],
  [> 1.00],
  [Sporadic / lumpy. Traditional forecasting struggles; use intermittent-demand methods (Croston's, etc.) or treat as project-driven.],
)

=== Why classify by variability

ABC tells you *which items to focus on*; XYZ tells you *how predictable each item is*. Both matter for inventory policy:

- *X items*: tight forecasting works → lean inventory, low safety stock margin.
- *Y items*: forecast error grows → higher safety stock; may benefit from time-series models with seasonal terms.
- *Z items*: forecasts unreliable → either (a) carry generous safety stock and accept overstock, (b) build to order, or (c) consider eliminating the SKU.

XYZ doesn't replace ABC — they're orthogonal. Use them together in the *ABC-XYZ matrix* (next file).

=== Procedure

+ Collect periodic demand history (monthly is typical; daily for fast movers; quarterly for slow movers).
+ Compute $mu$ and $sigma$ for each item.
+ Compute $"CV" = sigma \/ mu$.
+ Cut at the chosen thresholds.

Notes:
- Use *enough* history (at least 12 periods, ideally 24+) so CV is stable.
- Detrend if you have a strong trend — otherwise CV is inflated by drift, not noise.
- For seasonal items: deseasonalize first or use within-season variability.

#example[
  *Given* (same 6 SKUs as ABC, with 12-month demand histories):

  #table(
    columns: 14,
    inset: 0.4em,
    align: (left, ..(center,) * 13),
    [*Item*], [Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dec], [*Total*],
    [Laptop charger], [18], [20], [19], [21], [20], [19], [20], [21], [19], [20], [21], [22], [240],
    [Keyboard], [20], [25], [35], [30], [28], [22], [40], [45], [30], [35], [28], [22], [360],
    [Gaming chair], [1], [0], [2], [3], [1], [5], [8], [12], [10], [8], [6], [4], [60],
    [Cable], [45], [50], [55], [50], [48], [52], [50], [53], [47], [50], [52], [48], [600],
    [Sticker pack], [50], [100], [150], [80], [120], [100], [110], [90], [100], [100], [100], [100], [1200],
    [Phone case], [10], [20], [5], [30], [0], [50], [25], [10], [20], [15], [5], [10], [200],
  )

  *Step 1 — compute $mu$ and $sigma$ for each item*

  #table(
    columns: 4,
    inset: 0.6em,
    align: (left, center, center, center),
    [*Item*], [*$mu$ (mean / month)*], [*$sigma$ (SD)*], [*CV = $sigma$/$mu$*],
    [Laptop charger], [20.0], [1.1], [*0.06*],
    [Keyboard], [30.0], [7.5], [*0.25*],
    [Gaming chair], [5.0], [3.7], [*0.74*],
    [Cable], [50.0], [2.7], [*0.05*],
    [Sticker pack], [100.0], [25.6], [*0.26*],
    [Phone case], [16.7], [13.6], [*0.81*],
  )

  *Step 2 — cut at thresholds (X < 0.5, Y < 1.0, Z ≥ 1.0)*

  #table(
    columns: 3,
    inset: 0.6em,
    align: (left, center, left),
    [*Item*], [*CV*], [*Class*],
    [Laptop charger], [0.06], [X (very predictable)],
    [Cable], [0.05], [X (very predictable)],
    [Keyboard], [0.25], [X (predictable)],
    [Sticker pack], [0.26], [X (predictable)],
    [Gaming chair], [0.74], [Y (moderately variable, summer-heavy)],
    [Phone case], [0.81], [Y (variable, on the edge of Z)],
  )

  Hmm — none of the items hit Z under these thresholds. With only 12 monthly observations, CVs around 0.7–0.8 are common; the "true Z" range (>1.0) usually shows up in *truly intermittent* demand (months of zero, occasional spikes).

  *Step 3 — interpret*

  - *Laptop charger, Cable*: stable workhorses. Forecast with simple moving averages or SES; carry minimal safety stock.
  - *Keyboard, Sticker pack*: mostly stable but with some seasonality / surge weeks. SES with seasonal adjustment, moderate safety stock.
  - *Gaming chair, Phone case*: lumpy. Watch for seasonality; carry more safety stock relative to mean. The gaming chair shows a clear summer pattern — deseasonalize to get a cleaner CV.

  *Compare to ABC*: by value alone, laptop charger and gaming chair were both A items at \$12,000/year. By variability, the laptop charger is X (smooth) but the gaming chair is Y (lumpy). They should get *different* inventory policies despite the same value rank — see the ABC-XYZ matrix.
]
