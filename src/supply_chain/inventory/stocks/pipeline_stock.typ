#import "/lib/imports.typ": *

#let cm(x) = text(fill: red, [$#x$])

== Pipeline Stock

Inventory that is *in transit* — already ordered and paid for, but not yet received. Sometimes called "in-transit inventory" or "work-in-progress" (WIP) when between production stages.

$ "Pipeline stock" = bar(d) dot bar(L) $

Average lead-time demand. By Little's Law applied to the inventory system.

=== Where it comes from

Once you place an order, those units are *yours* (you've paid, they're in the supply chain) — even though they're not on your shelf yet. They're physically held by:
- The supplier (after order placement, before shipment)
- The carrier (in trucks, ships, planes during transit)
- Customs (during import processing)

The financial cost is real: working capital is tied up the entire time.

=== Derivation via Little's Law

For any stable queue:

$ "Average # in queue" = "Arrival rate" times "Average time in queue" $

Apply to the "in-transit" queue:
- Arrival rate into transit: $bar(d)$ (units/time, equal to average demand rate).
- Time in transit: $bar(L)$ (the lead time).

$ "Pipeline stock" = bar(d) dot bar(L) $

Independent of the order quantity $Q$ or the policy used. *Every* unit you ever consume passes through the pipeline for $L$ time, so on average $bar(d) bar(L)$ units are always in flight.

=== Cost of pipeline stock

Holding cost depends on whether you're charged carrying cost on in-transit inventory:
- *Yes* (you've paid the supplier — common with prepay terms): annual cost $h dot bar(d) bar(L)$.
- *No* (consignment / pay-on-receipt): pipeline stock has zero holding cost to you. Common with VMI.

=== Reduce pipeline stock

The *only* way to reduce pipeline stock is to reduce lead time $L$:
- Shorter shipping (air vs ocean)
- Closer suppliers (reshoring / nearshoring)
- Skip intermediate inspection / customs steps
- Compress production lead times (lean manufacturing within the supplier)

Cycle stock and safety stock can be tuned by changing $Q$ or $z$. *Pipeline stock cannot* — it's locked in by lead time and demand rate.

=== How it composes with other stock types

#table(
  columns: 3,
  inset: 0.7em,
  align: left,
  [*Component*], [*Magnitude*], [*Reduce by*],
  [Cycle stock], [$Q\/2$], [Smaller $Q$ (reduce setup cost $S$)],
  [Safety stock], [$z sigma_"LD"$], [Higher service or lower variance],
  [*Pipeline stock*], [$bar(d) bar(L)$], [Shorter lead time *only*],
  [Anticipation stock], [planned], [Smoother demand or flexible capacity],
  [Decoupling stock], [planned], [Tighter inter-stage coordination],
)


#example[
  *Given* (shared params):
  - Daily demand: $bar(d) = 33$ units / day
  - Lead time: $bar(L) = 14$ days
  - Unit value $c$ = \$10, holding rate $i = 0.20$/year so $h = i dot c$ = \$2/unit/year

  *Step 1 — pipeline stock*

  $ "Pipeline" = bar(d) dot bar(L) = cm(33) dot cm(14) approx 462 "units" $

  This is the average number of units in transit at any moment.

  *Step 2 — annual cost (assuming you pay upfront)*

  $ "Annual cost"_"pipeline" = h dot 462 = $ \$924 / year

  *Step 3 — compare to total inventory*

  At a (Q, r) policy with $Q = 775$ and 95% CSL ($r = 493$):
  - Cycle stock: $Q\/2 = 388$ units
  - Safety stock: $z sigma_L = 31$ units
  - Pipeline stock: 462 units (this!)
  - Total average inventory: $388 + 31 + 462 = 881$ units

  *Pipeline is the largest component* — bigger than cycle stock or safety stock. It's invisible on warehouse counts but very real on the balance sheet.

  *Step 4 — what does halving lead time do?*

  Shrink $L$ from 14 days to 7 days (e.g., switch to air freight):
  - Pipeline: $33 dot 7 = 231$ units (-50%, *-231 units*)
  - Safety stock: $1.65 dot 5 sqrt(7) approx 22$ units (slight reduction from $sqrt(L)$ effect)
  - Cycle stock: unchanged (still $Q\/2 = 388$)

  Halving lead time *cut pipeline + safety stock by ~38%*. The savings on holding cost: $h dot (462 - 231 + 31 - 22) = 2 dot 240 =$ \$480 / year.

  *Trade-off*: air freight may cost \$3000/year more. Whether it's worth it depends on the unit value (high-value goods → easier to justify shorter lead time).

  *Lean / Toyota argument*: lead-time reduction simultaneously cuts pipeline AND safety stock AND working capital tied up. That's why "compress the value stream" is a core lean principle.
]
