#import "/lib/imports.typ": *

#let cm(x) = text(fill: red, [$#x$])

Continuous review, *fixed pack size*. Like (Q, r), but the supplier requires orders in multiples of a fixed batch $Q$ (cases, dozens, pallet quantities).

*Decision rule*: monitor inventory continuously. When inventory position drops to (or below) reorder point $r$, order the *smallest integer multiple* $n Q$ that brings inventory position back above $r$.

Three parameters:
- $Q$ = fixed pack size (set by supplier, e.g., case of 24)
- $n$ = number of packs to order this cycle (a *function* of how far inventory dropped, not a free parameter)
- $r$ = reorder point

=== When does this matter?

(Q, r) assumes you can order any integer quantity $Q$. (nQ, r) handles the practical case where:
- Supplier ships only full pallets / cases / drums.
- Pack size is *fixed* by packaging or logistics; you choose how many.

If $Q$ is small relative to lead-time demand, (nQ, r) is essentially (Q, r) with rounding noise. If $Q$ is large (e.g., a pallet contains a year's worth of demand), the round-up effect inflates inventory significantly.

=== Decision logic when triggered

When inventory position falls to $r - delta$ (for some overshoot $delta gt.eq 0$):

$ n = ceil((s - "position" + Q) / Q) $

Or simpler in practice: order the smallest $n Q$ such that the post-order position exceeds some target (e.g., $r + Q$).

In the *small overshoot* case (smooth demand), $n = 1$ almost always — order one pack of $Q$. (nQ, r) reduces to (Q, r).

=== Set $r$

Same as (Q, r):

$ r = mu_L + z sigma_L $

The pack-size constraint affects $Q$, not $r$. The reorder trigger logic doesn't change.

=== Set $Q$

If $Q$ is *given* (supplier-mandated pack size), no decision. If you can choose pack-size from a discrete set (dozen, gross, case, pallet), pick the closest to $Q_"EOQ" = sqrt(2 D S_"setup" \/ h)$.

=== Average inventory

Slightly higher than (Q, r): $approx Q\/2 + "SS" + cm("expected overshoot") / 2$. Overshoot is small under continuous review of smooth demand but grows with demand lumpiness.

=== Final formulas

$
  r = mu_L + z sigma_L
  quad
  Q = "supplier-fixed pack size"
  quad
  n = ceil(("triggered position deficit" + Q) / Q)
$

#example[
  *Given* (same policy-comparison params):
  - $D = 12000$/yr, $d = 33$/day, $sigma_d = 5$, $L = 14$ days
  - $S_"setup"$ = \$50, $h$ = \$2/unit/yr, $z = 1.645$
  - Pack size: $Q = 800$ (one pallet contains 800 units; supplier won't break pallets)

  *Step 1 — reorder point*

  $ r = mu_L + z sigma_L = 462 + 30.8 approx cm(493) $

  *Step 2 — pack-size sanity check*

  Unconstrained EOQ would be $approx 775$. Forced pack of 800 is very close — pack-size penalty is negligible.

  *Step 3 — typical order*

  Inventory position drops to roughly 493 over time (smooth demand). Order $n Q$ where $n$ is the smallest integer such that the new position exceeds the next reorder cycle's needs.

  - At trigger, position $approx 493$.
  - One pack: $493 + 800 = 1293$. Above $r$, well above $r + Q\/2 = 893$. ✓
  - Order *1 pack* (800 units).

  *Step 4 — when overshoot matters*

  If a sudden burst drops inventory from 600 to 200 (a 400-unit lumpy withdrawal that crosses below $r$):
  - One pack brings position to $200 + 800 = 1000$. *Above $r$ ✓*.
  - But average inventory just after order is $1000$, which is near $S_"target" approx 1293$ for the previous cycle — still in normal range.

  Now consider $Q = 4000$ (much larger pack):
  - One pack: $200 + 4000 = 4200$. Way above $r$, but we just bought ~10 cycles of inventory in one go.
  - Average inventory: $approx Q/2 = 2000$ (vs ~$Q_"EOQ"/2 = 388$ optimal).
  - Holding cost more than 5x optimal.

  *Compare to (Q, r)*

  Under matched pack size ($Q = 800 approx Q_"EOQ"$), (nQ, r) and (Q, r) are nearly identical — same trigger, same order quantity. The difference grows when pack size diverges from the unconstrained optimum.

  *Use (nQ, r) when*: supplier mandates pack sizes; you want predictable shipping units; pack size happens to be close to EOQ. Switch to (Q, r) only if you can break packs.
]
