#import "/lib/imports.typ": *
#show: formatting

#let cm(x) = text(fill: red, [$#x$])

Classify items by *annual consumption value* (annual demand × unit cost). The Pareto principle says a small fraction of items dominates total value — so spend management effort proportionally.

=== The Pareto split

- *A items*: top ~70–80% of total value, typically ~10–20% of SKUs.
- *B items*: next ~15–25% of total value, ~30% of SKUs.
- *C items*: remaining ~5–10% of total value, ~50–70% of SKUs.

Exact thresholds vary by industry — pick what makes sense for your inventory.

=== Why classify

A items deserve tight control: precise demand forecasts, frequent reviews, low safety stock margin, supplier negotiations. Mistakes on A items have outsized financial impact.

C items deserve light control: simple rules (two-bin, periodic review), generous safety stock, automated reorder. Time spent fine-tuning C items earns very little.

B items get medium attention.

=== Procedure

+ Compute each item's *annual consumption value* = annual demand × unit cost.
+ Sort items by consumption value, descending.
+ Compute *cumulative percentage* of total value down the list.
+ Cut at the chosen thresholds (e.g., 80% / 95% / 100%).

=== Differential treatment summary

#table(
  columns: 4,
  inset: 0.7em,
  align: left,
  [*Class*], [*% of value*], [*% of SKUs*], [*Inventory policy*],
  [A], [~70-80%], [~10-20%], [Tight: $(s, S)$ or $(Q, r)$ with low safety stock; weekly review; supplier integration],
  [B], [~15-25%], [~30%], [Standard: $(R, S)$ with monthly review; modest safety stock],
  [C], [~5-10%], [~50-70%], [Loose: two-bin or fixed periodic order; generous safety stock],
)

#example[
  *Given*: 6 SKUs in a small electronics warehouse.

  #table(
    columns: 4,
    inset: 0.6em,
    align: (left, center, center, center),
    [*Item*], [*Annual demand*], [*Unit cost*], [*Annual value*],
    [Laptop charger], [240], [\$50], [\$12,000],
    [Keyboard], [360], [\$30], [\$10,800],
    [Gaming chair], [60], [\$200], [\$12,000],
    [Cable], [600], [\$5], [\$3,000],
    [Sticker pack], [1,200], [\$1], [\$1,200],
    [Phone case], [200], [\$5], [\$1,000],
  )

  *Step 1 — sort by annual value (descending)*

  #table(
    columns: 4,
    inset: 0.6em,
    align: (left, center, center, center),
    [*Item*], [*Annual value*], [*% of total*], [*Cumulative %*],
    [Laptop charger], [\$12,000], [30.0%], [30.0%],
    [Gaming chair], [\$12,000], [30.0%], [60.0%],
    [Keyboard], [\$10,800], [27.0%], [87.0%],
    [Cable], [\$3,000], [7.5%], [94.5%],
    [Sticker pack], [\$1,200], [3.0%], [97.5%],
    [Phone case], [\$1,000], [2.5%], [100.0%],
  )

  Total: \$40,000.

  *Step 2 — cut at thresholds*

  Using thresholds *80% / 95% / 100%*:
  - *A* (cumulative ≤ 80%): Laptop charger, Gaming chair, Keyboard *(3 items, 87% of value, but stop at 80% threshold)* — tighter rule: include the keyboard since it pushes the cumulative just past 80%.
  - *B* (next, ≤ 95%): Cable
  - *C* (rest): Sticker pack, Phone case

  *Step 3 — interpret*

  3 SKUs (50% of item count) carry 87% of inventory value. These are the items where forecasting accuracy and inventory-management precision pay off.

  The bottom 3 SKUs (50% of items) carry just 6.5% of value — automate, two-bin, don't waste planning effort.

  *Why two ties at \$12,000?*

  Laptop charger and gaming chair have *the same total value* but very different demand profiles (240 vs 60 units/year). ABC alone doesn't see this — both look identical. Adding *XYZ analysis* (by demand variability) separates them; combining the two gives the *ABC-XYZ matrix*.
]
