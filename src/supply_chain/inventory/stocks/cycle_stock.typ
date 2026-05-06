#import "/src/imports.typ": *

#let cm(x) = text(fill: red, [$#x$])

== Cycle Stock

The portion of inventory that exists *because we order in batches instead of unit-by-unit*. Pure consequence of fixed ordering costs and the EOQ trade-off.

$ "Cycle stock (average)" = Q / 2 $

=== Where it comes from

Order $Q$ units. Drain at rate $d$ until empty. Order again. Repeat.

Inventory profile is a sawtooth: peaks at $Q$ just after each order, drops linearly to 0, jumps back to $Q$. Average over the cycle: $Q\/2$.

If we ordered each unit immediately as needed, cycle stock would be 0 — but ordering has a fixed setup cost $S$, so we batch.

=== Why $Q\/2$?

Linear drainage from $Q$ to $0$ over time $Q\/d$. The *time-average* is the area under the triangle divided by the cycle length:

$ "Average inventory" = (1/2) Q dot (Q/d) / (Q/d) = Q / 2 $

Always exactly half the order quantity for *deterministic* demand. For stochastic demand, the expected on-hand mid-cycle is approximately $Q\/2$ plus the safety stock buffer.

=== Cost of cycle stock

Annual holding cost from cycle stock alone:

$ "HC"_"cycle" = h dot Q / 2 $

This is the standard EOQ holding-cost term. The basic-EOQ optimum balances this against ordering cost $S D \/ Q$ → gives $Q^* = sqrt(2 S D \/ h)$.

=== Reduce cycle stock by shrinking $Q$

Two ways to reduce cycle stock:
1. *Shrink $Q$* directly — accept more frequent orders, more setup cost.
2. *Reduce setup cost $S$* — then EOQ shrinks naturally (lean / SMED — single-minute exchange of die — work targets exactly this).

Lean inventory practice = drive $S$ toward zero so $Q$ can shrink, ideally toward 1 unit (just-in-time ordering).

=== How it composes with other stock types

Cycle stock is just one of *five* inventory components in a typical operation:

#table(
  columns: 3,
  inset: 0.7em,
  align: left,
  [*Component*], [*Magnitude*], [*Reason*],
  [*Cycle stock*], [$Q\/2$], [Batched ordering],
  [Safety stock], [$z sigma_L$], [Demand uncertainty],
  [Pipeline stock], [$d L$], [In-transit during lead time],
  [Anticipation stock], [planned], [Forecasted demand spikes],
  [Decoupling stock], [planned], [Buffer between production stages],
)

Total average inventory = sum of all components.


#example[
  *Given* (the same shared params as EOQ / policies):
  - Annual demand: $D = 12000$, daily $d = 33$
  - Order cost: $S$ = \$50, holding $h$ = \$2/unit/yr
  - Order quantity: $Q^"EOQ" = 775$

  *Step 1 — average cycle stock*

  $ "Cycle stock" = Q / 2 = 775 / 2 approx 388 "units" $

  *Step 2 — annual holding cost from cycle stock*

  $ "HC"_"cycle" = h dot Q / 2 = cm(2) dot cm(388) approx $ \$775 / year

  This *equals* the annual ordering cost $S D / Q = 50 dot 12000 / 775 approx$ \$775 — a property of basic EOQ (the two costs balance at the optimum).

  *Step 3 — reduce cycle stock*

  If we halve setup cost ($S$ → \$25 via process improvement), new EOQ:
  $ Q^* = sqrt(2 dot 12000 dot 25 / 2) approx 548 "units" $

  Cycle stock drops to $548\/2 = 274$ — a 30% reduction. Total holding cost falls to $h dot 274 =$ \$548/yr.

  Halving setup → 30% smaller cycle stock. (Square-root law: cycle stock scales with $sqrt(S)$.)

  *Step 4 — driving toward JIT*

  In the limit $S -> 0$: $Q^* -> 1$, cycle stock $-> 0.5$ unit, you order one (or near-one) unit at a time. This is the JIT / lean ideal.

  Real lean operations don't achieve $S = 0$ but get close enough that cycle stock becomes a small fraction of total inventory — most of the remaining inventory is safety stock and pipeline stock.
]
