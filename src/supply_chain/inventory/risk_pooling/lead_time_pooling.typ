#import "/lib/imports.typ": *
#show: formatting

Reducing safety stock by *shortening or stabilizing lead times*, not by aggregating demand. Substitutes responsiveness for inventory — a different lever than #link(<supply-chain-risk-pooling-location-pooling>)[location pooling].

== The lever

#link(<supply-chain-stocks-safety-stock>)[Safety stock] scales with lead-time demand standard deviation:

$
  "SS" = z sqrt(L sigma_D^2 + mu_D^2 sigma_L^2)
$

where $L$ is mean lead time and $sigma_L$ is lead-time variability. If you cut $L$ or $sigma_L$, safety stock falls.

== Two distinct mechanisms

*1. Shorter lead time*: $L$ falls, lead-time demand variability falls as $sqrt(L)$. Safety stock for demand-side variability scales as $z sigma_D sqrt(L)$ → cut $L$ by $1/4$, cut SS by $1/2$.

*2. Less variable lead time*: $sigma_L$ falls toward zero. The $mu_D^2 sigma_L^2$ term shrinks. Big effect when demand is fast and lead-time variability dominated the formula.

Often both effects compound — fast & reliable.

== Numerical example

Demand: $mu_D = 100$/week, $sigma_D = 30$/week.

#table(
  columns: 5,
  align: (left, center, center, center, center),
  stroke: none,
  table.header([Scenario], [$L$], [$sigma_L$], [LT-demand $sigma$], [SS at $z = 1.65$]),
  [Slow, variable], [8 wk], [2 wk], $sqrt(8 dot 900 + 10000 dot 4) = sqrt(47200) approx 217$, $358$,
  [Fast, variable], [2 wk], [1 wk], $sqrt(2 dot 900 + 10000 dot 1) = sqrt(11800) approx 109$, $179$,
  [Slow, stable], [8 wk], [0], $sqrt(8 dot 900) = sqrt(7200) approx 85$, $140$,
  [Fast, stable], [2 wk], [0], $sqrt(2 dot 900) approx 42$, $69$,
)

Going from "slow, variable" to "fast, stable" cuts safety stock by 80%.

== How to shrink lead times

- *Air freight vs ocean* — pay premium for time
- *Domestic / near-shore* — vs offshore production
- *Vendor-managed inventory* — supplier holds inventory at your door
- *Just-in-time / Kanban* — pull-based replenishment shortens effective lead time
- *Direct-store delivery* — bypass DCs

== How to stabilize lead times

- *Multi-sourcing* — backup suppliers smooth out individual variability
- *Vendor service-level agreements* — explicit, monitored commitments
- *Production buffers* at vendor — they hold the variability, not you
- *Premium expedited service* — pay for guaranteed times

== Trade-offs

Faster / more reliable lead times cost more:

- Higher unit cost (premium shipping, near-shoring)
- Higher per-order fixed cost (smaller batches → more orders)
- Supplier relationship investment
- Reduced negotiating leverage

This is one of the core *cost-vs-responsiveness* axes in supply-chain strategy (Fisher's framework: efficient vs responsive supply chains).

== When lead-time pooling beats location pooling

If demand correlates strongly across regions (so location pooling gains little), but lead-time variability dominates safety stock, lead-time pooling is the bigger win.

Common in:
- *Fashion / seasonal goods* — short selling season, high demand uncertainty
- *Consumer electronics* — new-product launches
- *Spare parts* — slow movers where SS is dominated by lead-time variance

== See also

- *#link(<supply-chain-risk-pooling-risk-pooling>)[Risk Pooling]*
- *#link(<supply-chain-stocks-safety-stock>)[Safety Stock]*
- *#link(<supply-chain-stocks-pipeline-stock>)[Pipeline Stock]*
- *#link(<supply-chain-risk-pooling-location-pooling>)[Location Pooling]*
