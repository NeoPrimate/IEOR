#import "/src/imports.typ": *

#let cm(x) = text(fill: red, [$#x$])

== Bullwhip Effect

The phenomenon where *demand variability amplifies up the supply chain*. Small fluctuations at the retail level cause progressively larger swings at the distributor, manufacturer, and raw-material supplier — like a bullwhip cracked at the handle.

Quantitatively measured by the *bullwhip ratio*:

$ "BW"_"stage" = "Var"("orders out of stage") / "Var"("demand into stage") $

If $"BW" > 1$: variability is amplified. If $"BW" = 1$: variability is preserved. *Real supply chains exhibit ratios of 2–5 per stage, compounding multiplicatively as you move upstream.*

=== Why it matters

Consequences of bullwhip:
- *Excess inventory* upstream (forced to absorb spikes).
- *Stockouts* and *firefighting* upstream.
- *Capacity over- and under-utilization* (production swings).
- *Higher logistics costs* (expedited shipping during ramp-ups).
- *Worse forecasts* — demand signals are corrupted by bullwhip itself.

Most damaging in industries with long lead times (electronics, pharmaceuticals, automotive) where amplified variance forces high safety stocks at every stage.

=== The four classical causes (Lee, Padmanabhan, Whang 1997)

==== 1. Demand-signal processing

Each stage forecasts based on *orders received*, not *true downstream demand*. When the retailer's demand spikes once, the retailer increases its safety stock — placing a *larger* order to the distributor. The distributor sees a spike and overreacts: even larger order to the manufacturer. The signal is amplified at each step.

*Math*: if each stage uses simple exponential smoothing or moving averages on *orders* (not demand), they bake the bullwhip from the previous stage into their next forecast — a positive feedback loop.

==== 2. Order batching

Retailers don't reorder every day — they batch orders into weekly or monthly shipments (driven by EOQ-style fixed costs, transportation economics, or supplier minimum order quantities).

The distributor sees a long pattern of *zero* orders followed by a single *large* order, vs the retailer's continuous demand. *Variance of batched orders >> variance of underlying demand.*

If batch size is $Q$ and underlying demand is smooth: order variance scales with $Q$ (lumpy spikes); demand variance is small. Bullwhip ratio $approx Q / (Q\/N) = N$ where $N$ is the smoothing factor — easily $10times$ amplification.

==== 3. Price fluctuations and forward buying

Promotions, volume discounts, end-of-quarter pushes — all incentivize buyers to *forward-buy* (purchase ahead of need to capture the deal). Order pattern: huge spikes at promotion times, troughs in between.

The retailer's actual sell-through is smooth; their *purchase* pattern is spiky → upstream sees the spiky pattern, not the smooth demand. Pure artifact of pricing strategy.

==== 4. Rationing and shortage gaming

When supply is constrained, the supplier rations: each customer gets a fraction of what they ordered. Rational customer response: *over-order* (order $1\/r$ × what you actually need, expecting fraction $r$ to be filled).

When supply normalizes, the inflated orders cancel or get returned, leaving the supplier with phantom demand signals. The 1990s computer-component shortages were full of this.

=== Mitigation strategies

#table(
  columns: 2,
  inset: 0.7em,
  align: left,
  [*Cause*], [*Mitigation*],
  [Demand-signal processing],
  [Share *true* downstream demand data with all stages (POS data, EDI, VMI). Each stage forecasts from real demand, not corrupted upstream orders.],

  [Order batching],
  [Reduce setup costs (lean / SMED) so $Q$ shrinks. Coordinate cycle times across stages. Cross-docking. Frequent small deliveries.],

  [Price fluctuations],
  [Everyday-low-pricing (EDLP) instead of promotional pricing. Volume contracts at flat prices. Reduce stockpiling incentives.],

  [Rationing / shortage gaming],
  [Allocate based on past demand history, not current orders (Cisco's 1990s policy). Reduce panic by transparent communication of capacity.],
)

The most effective single intervention: *information sharing*. POS-level visibility flowing upstream eliminates 60-80% of bullwhip in most studies.

=== The beer game

The MIT "beer distribution game" is a 4-stage simulation (retailer, wholesaler, distributor, factory) where players try to manage inventory and orders. Even with simple smooth demand, bullwhip emerges naturally — players aren't aware of upstream impacts and overreact based on local information.

Lessons consistently observed:
- Players over-order during ramps.
- Inventory swings grow upstream.
- Total system cost is much higher than optimal.
- Sharing demand information dramatically improves performance.


#example(title: "Bullwhip from order batching")[
  *Given* (4-stage chain: customer → retailer → wholesaler → factory):
  - True customer demand: Poisson, mean 100 units / day, std $sqrt(100) = 10$.
  - Retailer batches orders: places one order per *month* (30 days), order = 30 days of demand $approx$ 3000 units.
  - Wholesaler batches similarly to factory.

  *Stage variance comparison*

  - *Customer demand* (per day): mean 100, std 10. Daily variance 100.
  - *Retailer's order pattern* (per day): zero for 29 days, ~3000 once on day 30. Mean 100/day. *Variance much higher* — the order is lumpy.
    Approximately: variance of a Poisson-spike pattern ≈ $E["spike"]^2 / 30 approx 3000^2 / 30 = 300{,}000$.
  - *Bullwhip ratio at retailer*: $300{,}000 / 100 = cm(3000)$.

  Three orders of magnitude amplification *just from monthly batching*.

  *Cascading*

  Wholesaler sees retailer's lumpy pattern as *its* demand. Wholesaler batches too — say weekly to factory. Each lump of retailer order triggers a wholesaler order; wholesaler may also batch and order in larger lumps.

  By the time the factory sees its order signal, it's variance-amplified far beyond the original Poisson noise at the customer end.

  *Mitigation*

  If the wholesaler can see *daily customer demand* (POS data shared upstream): wholesaler forecasts from the smooth Poisson, not from the retailer's lumpy orders. Production at the factory becomes smooth. Inventory across the chain falls. *Same physical products and lead times — just less amplified noise.*

  This is the central insight of supply chain coordination: *bullwhip is a coordination failure, not a physical constraint*. Information sharing fixes it cheaply.
]
