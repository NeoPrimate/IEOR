#import "/lib/imports.typ": *

#let cm(x) = text(fill: red, [$#x$])

How many days the current inventory will last at the current consumption rate. The "human-readable" cousin of turnover.

$ "DOS" = "Average inventory" / "Average daily consumption" $

Equivalently:

$ "DOS" = 365 / "Turnover" $

=== Definition variants

#table(
  columns: 3,
  inset: 0.7em,
  align: (left, left, left),
  [*Variant*], [*Formula*], [*When to use*],
  [*Unit-based*], [On-hand units / daily demand units], [Single SKU operational view],
  [*Value-based*], [Inventory value / daily COGS], [Aggregate financial view],
  [*Forward-looking*], [Inventory / *forecasted* daily demand], [When demand changes (seasonality, promos)],
)

The forward-looking version is more accurate for planning; the historical version is simpler and what most reports show.

=== Why DOS rather than turnover?

Turnover is a *ratio* (e.g., 12). DOS is a *time* (e.g., 30 days). Time is more intuitive for operational decisions:
- "We have 45 days of supply" → vivid, actionable.
- "Turnover is 8.1" → harder to feel.

Both convey the same information; just pick the one your stakeholders prefer.

=== Targets by inventory function

Different functions of inventory imply different DOS targets:

#table(
  columns: 3,
  inset: 0.7em,
  align: (left, center, left),
  [*Function*], [*Typical DOS*], [*Reasoning*],
  [Cycle stock], [$Q\/(2 d)$], [Half the cycle length; depends on EOQ],
  [Safety stock], [$z sigma_L \/ d$], [Buffer for service level],
  [Pipeline stock], [$L$], [Lead time itself],
  [Anticipation], [varies], [Days until peak demand],
)

Total DOS = sum across functions, comparable to total inventory ÷ daily demand.

=== Reading DOS distribution

A useful diagnostic: plot *DOS by SKU* (histogram).

- *Tail of high-DOS items* (e.g., > 200 days): dead stock candidates. Cross-reference with FSN — these are usually N-class (non-moving) items.
- *Spike at low DOS* (e.g., < 7 days): chronically understocked. Check stockout rate.
- *Healthy bulk*: cluster around the target DOS for the policy.

The aggregate company DOS hides this distribution — it's the average. Plot it.

=== DOS vs lead time

Compare DOS to lead time:
- *DOS < $L$*: high stockout risk. The next order won't arrive before current stock runs out.
- *DOS = $L$*: no buffer. Razor-thin operations.
- *DOS > $L$*: have at least lead-time coverage; safety stock + cycle stock above $L$.

Healthy operations target $"DOS" approx 1.5 times L$ to $2 times L$, with the excess coming from cycle stock and modest safety stock.

#example[
  *Given*:
  - Average inventory: 880 units (cycle 388 + safety 30 + pipeline 462)
  - Daily demand: 33 units / day
  - Lead time: 14 days

  *Step 1 — total DOS*

  $ "DOS" = 880 / 33 approx cm(27) "days" $

  Equivalent to turnover of $365 / 27 approx 13.5$.

  *Step 2 — DOS by component*

  - Cycle stock: $388 / 33 approx 12$ days
  - Safety stock: $30 / 33 approx 1$ day
  - Pipeline: $462 / 33 = 14$ days (= $L$)
  - Total: $12 + 1 + 14 = 27$ days ✓

  *Step 3 — sanity check*

  - Lead time = 14 days. DOS = 27 days. *Buffer above lead time*: 13 days (cycle + safety).
  - Comfortable margin. *No risk of stockout from running out before next order arrives.*

  *Step 4 — flag analysis*

  Suppose another SKU shows DOS = 8 days with $L = 14$ days. *DOS < L*: that SKU is in trouble. The next replenishment can't arrive before current stock runs out. *Stockout incoming*.

  Action: increase safety stock, reduce $Q$ for faster reorder, or expedite the inbound shipment.

  *Step 5 — flag dead stock*

  Suppose another SKU shows DOS = 365 days. That's a *year* of supply on hand. Almost certainly dead stock or vastly overstocked. Action: investigate; cross-check with FSN.

  *DOS is the diagnostic; FSN, ABC, and stockout rate are the follow-ups.*
]
