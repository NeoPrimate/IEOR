#import "/src/imports.typ": *

#let cm(x) = text(fill: red, [$#x$])

== EOQ with lost sales

Relax one dimension from basic EOQ: *excess demand* is no longer forbidden — but unlike planned backorders, customers facing a stockout *do not wait*. Each unit of unmet demand is permanently lost at penalty $pi$ per unit (lost margin + goodwill).

=== Setup

New variables (beyond basic EOQ):
- $pi$ = lost-sale cost per unit (\$ per unmet unit)
- $tau$ = stockout duration per cycle (decision variable; could be 0)

The inventory profile in each cycle is:
- Receive $Q$ units, drain at rate $D$ until empty after time $Q\/D$.
- Stay stocked-out for time $tau$ — during this period $D tau$ units of demand walk away.
- Order again. Cycle length $T = Q\/D + tau$.

=== Cost model

Per cycle:
- *Order*: $S$
- *Holding*: $h dot (Q\/2) dot (Q\/D)$ — average inventory $Q\/2$ over time $Q\/D$.
- *Lost-sales*: $cm(pi D tau)$ — $D tau$ units lost at $pi$ each.

Per unit time, divide by $T = Q\/D + tau$:

$
  "TC"(Q, tau) = (S + h Q^2 \/ (2 D) + cm(pi D tau)) / (Q \/ D + tau)
$

Two decision variables now: $Q$ and $tau$.

=== When is it optimal to plan stockouts? (FOC in $tau$)

Take $partial "TC" \/ partial tau$, quotient rule:

$
  partial / (partial tau) "TC" = (pi D dot (Q \/ D + tau) - (S + h Q^2 \/ (2 D) + pi D tau) dot 1) / (Q \/ D + tau)^2
$

Set numerator to zero, expand $pi D (Q \/ D + tau) = pi Q + pi D tau$:

$ pi Q + pi D tau - S - h Q^2 \/ (2 D) - pi D tau = 0 $
$ pi Q - S - h Q^2 \/ (2 D) = 0 $

This says: *at the boundary $tau = 0$*, lost sales become attractive only if $partial "TC" \/ partial tau lt.eq 0$ there, i.e., $pi Q lt.eq S + h Q^2 \/ (2 D)$.

Plug in $Q = Q_"basic"^* = sqrt(2 S D \/ h)$. Then $h Q^2 \/ (2 D) = S$, so the condition becomes:

$ pi dot sqrt((2 S D) / h) lt.eq 2 S quad arrow.l.r.double quad pi lt.eq sqrt((2 S h) / D) $

So lost sales has a *threshold behavior*:

#table(
  columns: 2,
  inset: 0.8em,
  align: left,
  [*Lost-sale cost $pi$*], [*Optimal action*],
  [$pi gt.eq sqrt(2 S h \/ D)$], [Operate as basic EOQ ($tau^* = 0$, no stockouts).],
  [$pi < sqrt(2 S h \/ D)$], [Don't operate — lose all demand. Inventory not worth the trouble.],
)

=== Threshold interpretation

The threshold $sqrt(2 S h \/ D)$ is exactly the *basic-EOQ cost per unit served*:

$ "TRC"^*_"basic" / D = sqrt(2 S D h) / D = sqrt((2 S h) / D) $

So the rule is intuitive: *operate iff the per-unit lost-sale cost exceeds the per-unit cost of running EOQ*. Below that, you'd rather lose the customer than pay the inventory overhead.

=== Final formulas

$
  pi gt.eq sqrt((2 S h) / D)
  quad arrow.r.double quad
  Q^* = sqrt((2 S D) / h), quad tau^* = 0
$

Below the threshold, the model degenerates — there's no interior planned-stockout solution under deterministic constant demand.

=== Why no interior solution?

Under deterministic constant demand with instantaneous replenishment, there is *no benefit* to planned stockouts — you can always order the right amount at the right time. Lost sales becomes interesting only when demand is *stochastic* (newsvendor / $(Q, r)$ models with lost sales) or when there's a *minimum order quantity* forcing you to order in lumps that don't divide annual demand cleanly.


#example[
  *Given* (shared EOQ params + a lost-sale penalty):
  - Annual demand: $D = 12000$ units/year
  - Order cost: $S$ = \$50 / order
  - Holding cost: $h$ = \$2 / unit / year
  - Lost-sale penalty: vary $pi$ to see threshold

  *Step 1 — compute the threshold*

  $ pi_"threshold" = sqrt((2 S h) / D) = sqrt((2 dot 50 dot 2) / 12000) = sqrt(200 / 12000) approx $ \$0.13 / unit

  *Step 2 — decide*

  - $pi$ = \$1 / unit (typical lost margin): $1 >> 0.13$ → operate as basic EOQ.
  - $pi$ = \$0.10 / unit (very cheap to lose): $0.10 < 0.13$ → don't operate.

  *Step 3 — compare to basic EOQ*

  - Basic EOQ assumes you always serve demand: $Q^* = 775$, $"TRC"^* approx 1549$ \$/year.
  - Lost sales adds a *test*: only operate if $pi$ exceeds the per-unit cost of EOQ. For any normal product where lost margin > a few cents per unit, basic EOQ wins and the lost-sales option is never used.

  Under deterministic demand, lost sales is a *go / no-go decision*, not a planned-shortage strategy. The interesting variants live in stochastic demand models — see newsvendor and $(Q, r)$ policies.
]
