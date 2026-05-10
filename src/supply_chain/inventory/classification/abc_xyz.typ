#import "/lib/imports.typ": *

#let cm(x) = text(fill: red, [$#x$])

Combine ABC (consumption value) and XYZ (demand variability) into a *3 × 3 grid*. Each cell suggests a distinct inventory strategy.

=== The grid

#table(
  columns: 4,
  inset: 0.7em,
  align: (left + horizon,) + (center + horizon,) * 3,
  [], [*X (low CV)*], [*Y (moderate CV)*], [*Z (high CV)*],
  [*A (high value)*],
  [*AX*: lean, JIT, supplier integration, low safety stock],
  [*AY*: forecast carefully, moderate safety stock, frequent review],
  [*AZ*: high safety stock + close monitoring; consider supplier flexibility (consignment, drop-ship)],

  [*B (medium value)*],
  [*BX*: standard policy, automate],
  [*BY*: moderate attention, periodic review],
  [*BZ*: pad safety stock; review whether SKU rationalization helps],

  [*C (low value)*],
  [*CX*: two-bin / kanban, set-and-forget],
  [*CY*: simple periodic, generous buffer (cheap to overstock)],
  [*CZ*: candidate for elimination — low value AND unpredictable. If kept, build to order or accept high stockout rate],
)

=== Reading the cells

The *value axis (ABC)* sets *how much management attention* the item deserves. The *variability axis (XYZ)* sets *how much safety stock* (relative to mean demand) the item needs. Combine:

- High value + low variability → *lean*. Spend the management effort on tight forecasting; reap the savings from low safety stock.
- High value + high variability → *expensive to misjudge*. Cannot afford either over- or understock; need close monitoring and possibly contractual risk-sharing with the supplier.
- Low value + high variability → *not worth managing carefully*. Either overstock cheaply or eliminate the SKU.

=== Procedure

+ Run [ABC analysis](abc.typ): assign each SKU an A / B / C class.
+ Run [XYZ analysis](xyz.typ): assign each SKU an X / Y / Z class.
+ Place each SKU into one of the 9 cells.
+ Pick the inventory policy from the matrix above.

=== When the matrix isn't enough

The 9-cell grid is a useful starting heuristic but doesn't capture every dimension:
- *Criticality* (a $\$$1 bolt that holds together a $\$$1M machine — see [VED](ved.typ))
- *Movement frequency* / dead stock (see [FSN](fsn.typ))
- *Lead time* (long-lead items need more safety stock regardless of XYZ)

Most operations apply the matrix as a *first-pass policy assignment*, then refine on the dimensions above.

#example[
  *Given* (same 6 SKUs from ABC and XYZ):

  Combine the two classifications:

  #table(
    columns: 4,
    inset: 0.6em,
    align: (left, center, center, left),
    [*Item*], [*ABC*], [*XYZ*], [*Cell + suggested policy*],
    [Laptop charger], [A], [X], [*AX* — lean, JIT-friendly, low SS],
    [Gaming chair], [A], [Y], [*AY* — careful forecast (seasonal), moderate SS],
    [Keyboard], [A], [X], [*AX* — lean, automate replenishment],
    [Cable], [B], [X], [*BX* — standard $(R, S)$, automate],
    [Sticker pack], [C], [X], [*CX* — two-bin, set-and-forget],
    [Phone case], [C], [Y], [*CY* — periodic, generous buffer],
  )

  Resulting matrix populated:

  #table(
    columns: 4,
    inset: 0.7em,
    align: (left + horizon,) + (center + horizon,) * 3,
    [], [*X*], [*Y*], [*Z*],
    [*A*], [Laptop charger \ Keyboard], [Gaming chair], [—],
    [*B*], [Cable], [—], [—],
    [*C*], [Sticker pack], [Phone case], [—],
  )

  *Step — interpret*

  - *Top-left (AX)* — laptop charger and keyboard: highest priority, spend the analytics effort here. Lean continuous-review (Q, r) policy with tight safety stock.
  - *Center (AY)* — gaming chair: pay for a seasonal forecast; widen safety stock during peak season.
  - *Bottom-right empty*: nothing extreme in this dataset. Real catalogs typically have CZ candidates (impulse / niche / one-off items) — those are the SKU-rationalization candidates.

  *Why the matrix beats ABC alone*: if you used ABC alone, the laptop charger and gaming chair would get identical policies (both A). The matrix correctly distinguishes them — the smooth charger gets a lean policy; the lumpy chair gets safety stock and a seasonality model. Same value, different policy.
]
