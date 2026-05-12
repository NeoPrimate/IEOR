#import "/lib/imports.typ": *
#show: formatting

#let cm(x) = text(fill: red, [$#x$])

The *measured* frequency of stockouts. A KPI for assessing how well an inventory system is actually performing — distinct from the *target* service level used to design the policy.

Three common formulations:

#table(
  columns: 3,
  inset: 0.7em,
  align: (left, left, left),
  [*Variant*], [*Formula*], [*What it measures*],
  [*Cycle stockout rate*], [(cycles with stockout) / (total cycles)], [Frequency of stockout *events*],
  [*Time stockout rate*], [Time out of stock / total time], [Fraction of *time* out of stock],
  [*Item stockout rate*], [(SKUs out of stock at moment $t$) / (total SKUs)], [Snapshot view across the catalog],
)

=== Cycle stockout rate (target = $alpha$)

Tracks the fraction of replenishment cycles that hit stockout at least once. Measures the same quantity that *cycle service level* (CSL) targets:

$ "Cycle stockout rate" = "# cycles with stockout" / "total cycles" = 1 - "CSL"_"actual" $

Use when designing policies around the target $alpha$ and verifying you hit it in operation.

=== Time stockout rate (target ≈ $1 - gamma$)

Tracks time fraction out of stock. Equivalent to $1 -$ ready rate (see [ready_rate.typ](../service_levels/ready_rate.typ)).

$ "Time stockout rate" = "Days out of stock" / "Total days" $

Easy to compute from ERP data — just sum the duration of zero-on-hand periods.

=== Item stockout rate (catalog-level)

Snapshot of *how many* SKUs are out of stock at a given moment, expressed as a fraction:

$ "Item stockout rate"(t) = ("# SKUs with on-hand" = 0) / ("# active SKUs") $

Tracked over time as a daily / weekly time series. Common retail KPI, sometimes called *out-of-stock rate* or *fill-rate-on-shelf*.

=== Why measure it

The target service level (CSL = 95%, fill rate = 99%) is what you *aim for* during policy design. *Actual stockout rate* tells you whether the system is performing as designed. Common reasons for divergence:

- Demand forecast wrong → safety stock too low.
- Lead times longer than assumed → reorder point too low.
- Demand more variable than assumed → $sigma_L$ underestimated.
- Operational errors — late ordering, miscounts, supplier delivery issues.

If actual stockout rate >> target, the *physical* operation is breaking, not the *design*. Different remedy.

=== Connection to other metrics

#table(
  columns: 3,
  inset: 0.7em,
  align: (left, center, center),
  [*Metric*], [*Counts*], [*Stockout-rate equivalent*],
  [CSL ($alpha$)], [Cycles], [Cycle stockout rate],
  [Fill rate ($beta$)], [Units], [1 - Fill rate (unit stockout rate)],
  [Ready rate ($gamma$)], [Time], [Time stockout rate],
)

Different denominators measuring "how often things go wrong" — choose what your stakeholders care about.

=== Diagnostic combinations

- *High cycle stockout rate, low time stockout rate*: stockouts are *frequent but short*. Replenishment is reactive but fast.
- *Low cycle stockout rate, high time stockout rate*: stockouts are *rare but long*. When they happen, they linger — usually a supply-side problem (lead time, supplier issue).
- *Item stockout rate growing over time*: catalog-wide degradation — could be a forecasting drift, a supplier-base issue, or demand surge across products.

#example[
  *Given* (one quarter of inventory data):
  - 100 SKUs, monitored daily for 90 days.
  - Combined: 27 stockout *events*. Total stockout *days*: 45 (across all events and SKUs).
  - Average number of active SKUs: 100. Snapshot at end of each day shows on average 1.2 SKUs out of stock.

  *Step 1 — cycle stockout rate*

  Total cycles: each SKU experiences ~12 cycles per quarter (assuming monthly replenishment). Across 100 SKUs: ~1200 cycles.

  $ "Cycle stockout rate" = 27 / 1200 approx cm(2.25%) $

  Equivalent: actual CSL = 97.75%. If the *target* CSL was 95%, the operation *exceeds* its target.

  *Step 2 — time stockout rate*

  Each SKU has 90 SKU-days; total SKU-days = 9,000. Stockout SKU-days = 45.

  $ "Time stockout rate" = 45 / 9000 = cm(0.5%) $

  Equivalent: actual ready rate = 99.5%.

  *Step 3 — item stockout rate*

  Average daily snapshot: 1.2 SKUs out of 100 are out of stock.

  $ "Item stockout rate" = 1.2 / 100 = cm(1.2%) $

  *Step 4 — interpret*

  Cycle rate (2.25%) is *higher* than time rate (0.5%) — the stockouts are short. On average, $45 / 27 approx 1.7$ days each. The team responds quickly.

  Item rate of 1.2% means at any given snapshot, about 1 SKU in 100 is unavailable. For 100 SKUs that's noticeable; for a 100,000-SKU retailer, that's 1,200 missing items.

  *Step 5 — drill down*

  Which SKUs account for the 27 stockout events? If concentrated in 5 SKUs (each stockout 5–6 times), they have policy issues — investigate forecasting, safety stock, lead time. If spread across all 100, the problem is systemic.

  *Always cross-tab stockout rate against ABC and VED*: an A or V class item being out is much more costly than a C or D class.
]
