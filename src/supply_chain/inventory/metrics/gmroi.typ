#import "/lib/imports.typ": *
#show: formatting

#let cm(x) = text(fill: red, [$#x$])

== GMROI (Gross Margin Return On Inventory Investment)

How much gross profit each dollar of inventory generates per year. The retail / merchandising metric of choice — combines *profitability* and *turnover* into one number.

$ "GMROI" = "Gross margin" / "Average inventory cost" $

Equivalently:

$ "GMROI" = "Gross margin %" times "Turnover" $

A GMROI of 3.0 means: every \$1 of inventory generates \$3 of gross profit per year.

=== Where it comes from

Standalone, *gross margin %* tells you how much profit you make per dollar of sales. *Turnover* tells you how many times you cycle inventory. Multiplying gives gross profit per dollar of inventory:

$
  underbrace("Gross margin", "$") / underbrace("Avg inventory cost", "$") = underbrace("Gross margin", "$") / underbrace("COGS", "$") times underbrace("COGS", "$") / underbrace("Avg inventory cost", "$")
$
$
  = "Gross margin %" times "Turnover"
$

Two levers: improve margins or improve turnover. Both flow to GMROI.

=== Why retailers love it

Compares wildly different products on a *per-dollar-of-shelf-investment* basis:

- *Luxury watches*: 60% margin, 1× turnover → GMROI = 0.6.
- *Cheap apparel*: 30% margin, 6× turnover → GMROI = 1.8.
- *Grocery staples*: 20% margin, 25× turnover → GMROI = 5.0.

Cheap apparel beats luxury watches *per dollar of shelf space*. Grocery staples beat both. This is why grocery and fast fashion retailers dominate inventory-efficient operations even though margins are thin.

=== When GMROI is misleading

- *Doesn't account for shelf space*: a small high-GMROI item might be space-inefficient. Pair with *GMROS* (Gross Margin per Square Foot) for retail decisions.
- *Doesn't capture cross-product effects*: a low-GMROI loss-leader might drive traffic that benefits other items.
- *Sensitive to seasonality*: averaged inventory across a year may misrepresent peak weeks.
- *Capital cost ignored*: GMROI counts only inventory carrying cost implicitly via "average inventory" — not the cost of capital used to fund it.

For executive decisions on shelf allocation, complement GMROI with: GMROS, sales velocity, contribution to traffic, customer mix.

=== Improving GMROI

Three paths:
+ *Raise margins*: better procurement, premium positioning, private label.
+ *Increase turnover*: leaner inventory (smaller $Q$, lower safety stock), faster product cycles.
+ *Both*: rare but powerful — examples include Costco (low margin, very high turnover) and luxury (high margin, low turnover).


#example[
  *Given* (a retail product line):
  - Annual sales: \$1,000,000
  - Annual COGS: \$700,000 → gross margin \$300,000 → margin % = 30%
  - Average inventory at cost: \$100,000

  *Step 1 — turnover*

  $ "Turnover" = "COGS" / "Avg inventory" = 700 / 100 = 7 $

  *Step 2 — GMROI direct calc*

  $ "GMROI" = "Gross margin" / "Avg inventory" = (cm("\\$300{,}000")) / (cm("\\$100{,}000")) = cm(3.0) $

  *Step 3 — verify via the factor identity*

  Using cost-based turnover and margin-on-COGS:

  $ "Margin on COGS" = "Margin" / "COGS" = 300 / 700 approx 0.429 $
  $ "GMROI" = "Margin on COGS" times "Turnover" = 0.429 times 7 = cm(3.0) ✓ $

  Equivalently, using margin% on sales and the relation $"Margin on COGS" = "Margin %" \/ (1 - "Margin %") = 0.30 / 0.70 approx 0.429$.

  *In practice*: state which "turnover" you mean (cost-based vs sales-based) and stick to one definition. Mixing them gives different numbers.

  *Step 4 — comparison*

  Compare to a luxury line: margin 60%, turnover 1.5 (annual rotation).
  $ "GMROI"_"luxury" = 0.60 / 0.40 times 1.5 = 2.25 $

  And to a grocery-style line: margin 20%, turnover 30.
  $ "GMROI"_"grocery" = 0.20 / 0.80 times 30 = 7.5 $

  *Grocery beats luxury per dollar of inventory* even though the per-unit margin is much lower. Volume × velocity wins.
]
