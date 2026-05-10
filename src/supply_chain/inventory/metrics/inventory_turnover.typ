#import "/lib/imports.typ": *

#let cm(x) = text(fill: red, [$#x$])

How many times the inventory "turns over" (is sold and replaced) per year. The single most-cited inventory metric.

$ "Turnover" = "Annual COGS" / "Average inventory value" $

Higher = leaner; lower = stagnant.

=== Definition variants

Three common formulations, depending on what data you have:

#table(
  columns: 3,
  inset: 0.7em,
  align: (left, left, left),
  [*Variant*], [*Formula*], [*Use when*],
  [*Cost-based* (most common)], [Annual COGS / Avg inventory at cost], [You have COGS data — most accurate],
  [*Sales-based*],
  [Annual sales / Avg inventory at sales price],
  [You only have revenue, not COGS — less precise but works],

  [*Unit-based*], [Annual demand / Avg inventory units], [Single-product analysis or ratio comparisons],
)

Cost-based is the standard for financial reporting; sales-based shows up in retail KPIs; unit-based is operational.

=== Why turnover matters

Turnover combines *demand* and *inventory level* into one number that captures *capital efficiency*:

- High turnover → inventory cycles quickly → low working capital tied up.
- Low turnover → inventory sits → cash trapped, risk of obsolescence.

Compare across products, sites, or time periods to spot trends.

=== Industry benchmarks

#table(
  columns: 3,
  inset: 0.7em,
  align: (left, center, left),
  [*Industry*], [*Typical turnover*], [*Why*],
  [Grocery / fresh food], [15-25], [Perishable, high-frequency replenishment],
  [Apparel retail], [4-6], [Seasonal cycles, slow-moving items],
  [Electronics retail], [6-8], [Moderate cycle, fast obsolescence],
  [Industrial distribution], [4-8], [B2B, slower cycles],
  [Heavy manufacturing], [3-5], [Long lead times, large WIP],
  [Pharmaceuticals], [3-4], [Long shelf life, regulatory inventory],
  [Luxury goods], [1-2], [Low volume, high margin per unit],
)

Use the benchmark to flag outliers. *Far below benchmark* → likely overstocked. *Far above* → may be understocked (frequent stockouts).

=== Connection to days of supply

The most natural "human-readable" interpretation of turnover is its inverse:

$ "Days of supply" = 365 / "Turnover" $

If turnover = 12, you hold ~30 days of inventory. If turnover = 4, you hold ~91 days. See [days_of_supply.typ](days_of_supply.typ).

=== What turnover doesn't tell you

- *Why* the number is what it is — could be high turnover from good management OR understocking.
- *Distribution across SKUs* — total turnover hides which SKUs are dead stock vs fast movers (use FSN classification).
- *Seasonality* — annual averages mask quarterly swings (use seasonally adjusted turnover or rolling windows).

Turnover is a *summary* metric. Pair with stockout rate, FSN analysis, and days-of-supply distribution for diagnosis.

#example[
  *Given*:
  - Annual COGS: \$2,400,000
  - Average inventory at cost (taken at month-ends, averaged): \$200,000

  *Step 1 — turnover*

  $ "Turnover" = (cm("\\$2{,}400{,}000")) / (cm("\\$200{,}000")) = cm(12) $

  *Step 2 — interpret*

  Inventory turns over 12 times per year — once per month on average. Working capital tied up: \$200K, cycling 12× → supports \$2.4M in COGS.

  Days of supply: $365 / 12 approx 30$ days.

  *Step 3 — compare to benchmark*

  Industry: industrial distribution, benchmark 4-8.

  This company at 12 is *well above* benchmark. Two interpretations:
  + *Lean operations*: tight forecasts, fast replenishment, low safety stock. Excellent.
  + *Understocked*: frequent stockouts, lost sales. Bad.

  Diagnose with stockout rate and customer-feedback data. If stockout rate is < 2% → great efficiency. If > 10% → being lean is costing sales.

  *Step 4 — improve turnover (if it's the goal)*

  Lever 1: shrink average inventory (numerator unchanged). Tighten safety stock, reduce cycle stock (smaller $Q$, more frequent orders), eliminate dead stock.

  Lever 2: grow COGS without growing inventory proportionally — i.e., grow the business.

  Lever 1 hits a floor (you need *some* safety stock). Lever 2 is where high-turnover companies actually win — Walmart, Costco, fast fashion all run high turnover by selling a lot from a small inventory footprint.
]
