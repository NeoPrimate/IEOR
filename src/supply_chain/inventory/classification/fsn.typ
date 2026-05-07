#import "/lib/imports.typ": *

#let cm(x) = text(fill: red, [$#x$])

== FSN Analysis (Fast / Slow / Non-moving)

Classify items by *movement frequency* — how often they're picked, issued, or sold. Independent of value (ABC) and variability (XYZ).

=== The frequency split

- *F items* (Fast-moving): picked frequently — multiple times per week or daily.
- *S items* (Slow-moving): picked occasionally — a few times per month or quarter.
- *N items* (Non-moving): no issue activity for an extended period (typically 6+ months); effectively *dead stock*.

Thresholds depend on context. Common rules:

#table(
  columns: 3,
  inset: 0.7em,
  align: (left, center, left),
  [*Class*], [*Typical threshold*], [*Operational meaning*],
  [F], [≥ 1 issue / week (or > 12 issues / year)], [Place near pickers; standard replenishment cycle.],
  [S], [1 issue / month to 1 / week], [Place mid-warehouse; periodic review with longer cycles.],
  [N], [< 1 issue / 6 months], [Quarantine; review for write-off or liquidation.],
)

=== Why classify by movement

FSN is about *operational friction*, not financial impact:
- *Warehouse layout*: F items go into the pick-face / golden zone; N items go into deep storage or get culled.
- *Cycle counting frequency*: F items counted often; N items counted rarely.
- *Obsolescence detection*: a creeping shift from S to N is an early warning that an SKU is dying.
- *Working capital cleanup*: N items tie up cash with zero return — periodic FSN review forces a write-off conversation.

ABC tells you "where is the money sitting?". FSN tells you "what's actually moving?". Both are needed: an *A but N* item (high value, no movement) is *high-priority dead stock* — sell it off, don't ignore it.

=== Procedure

+ Pull issue / pick / sales records over a window (typically 6–12 months).
+ For each SKU, count the number of issues (or compute *days since last issue*).
+ Classify by your chosen thresholds.
+ Cross-reference with ABC: high-value non-movers are urgent.

=== Adjacent metrics

- *Inventory turnover* = annual demand / average inventory. High = F-class; low = S or N.
- *Days of supply* = average inventory / daily demand. The inverse view.
- *Last-issue date*: most direct test for N-class.


#example[
  *Given*: 6-month issue history for 7 SKUs in a small warehouse.

  #table(
    columns: 4,
    inset: 0.6em,
    align: (left, center, center, left),
    [*Item*], [*Issues in 6 months*], [*Days since last issue*], [*Notes*],
    [Laptop charger], [120], [0], [Daily seller],
    [Cable], [80], [0], [Frequent stock-up],
    [Keyboard], [30], [3], [Moderate],
    [Gaming chair], [10], [12], [Occasional],
    [Phone case], [6], [25], [Slow],
    [Sticker pack], [3], [60], [Slow / sporadic],
    [Old printer cartridge], [0], [240], [Non-moving — likely obsolete],
  )

  *Step 1 — annualize the issue count*

  Multiply by 2 (since the window was 6 months) for a yearly rate:

  #table(
    columns: 3,
    inset: 0.6em,
    align: (left, center, center),
    [*Item*], [*Issues / year (annualized)*], [*Class*],
    [Laptop charger], [240], [F (≥ 12 / year)],
    [Cable], [160], [F],
    [Keyboard], [60], [F],
    [Gaming chair], [20], [F (just barely; or S if threshold is daily)],
    [Phone case], [12], [F / S boundary],
    [Sticker pack], [6], [S],
    [Old printer cartridge], [0], [N (no movement in 8 months)],
  )

  *Step 2 — interpret*

  - *F items* (Laptop charger, Cable, Keyboard, Gaming chair): place in the pick-face. Daily / weekly cycle counts. Standard replenishment.
  - *S items* (Phone case, Sticker pack): mid-warehouse storage. Monthly cycle counts. Slower review cadence.
  - *N items* (Old printer cartridge): quarantine. Investigate why no movement — discontinued product line? Replaced by a newer SKU? *This is where dead stock hides.*

  *Step 3 — cross-reference with ABC*

  From ABC, the laptop charger is A-class. From FSN, F-class. *AF* — high value, fast-moving — is the textbook "manage tightly" cell. Make sure the inventory policy (e.g., (Q, r)) is well-tuned for it.

  The old printer cartridge: if it was originally A-class (high unit cost, several cartridges in stock), it's a *high-value non-mover* — write it off or liquidate before the value drops further.

  *Why FSN matters operationally*

  Two SKUs with *identical annual value* (ABC = same class) can need very different *physical handling*:
  - Laptop charger: 240 issues/year, ~1 per day. Pick-face slot, often-replenished.
  - Gaming chair: 20 issues/year, ~weekly. Bulk-storage slot, infrequent picks.

  ABC alone misses this distinction. FSN catches it.
]
