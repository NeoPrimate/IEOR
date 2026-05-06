#import "/src/imports.typ": *

#let cm(x) = text(fill: red, [$#x$])

== (S−1, S) Policy — base stock / one-for-one

The simplest continuous-review policy: *every consumed unit triggers an immediate replenishment of one unit*. Sometimes called the *base-stock* policy.

*Decision rule*: maintain inventory position at exactly $S$. As soon as one unit is sold, place an order for one unit.

Equivalently: trigger an order at $s = S - 1$ (whenever inventory dips below $S$). Hence the name.

Single parameter:
- $S$ = base-stock level (the only decision)

=== When does this make sense?

Use base-stock when *fixed ordering cost is negligible* (or items are too critical to risk by batching):

- *Spare parts and critical components*: stockouts are catastrophic, individual items are cheap to order.
- *High-value, low-volume items*: holding cost dominates; ordering one-at-a-time is fine.
- *Vendor-managed inventory* with continuous data exchange: ordering happens automatically per consumption.

Don't use base-stock if you have meaningful per-order setup costs — the EOQ logic says batch up.

=== Inventory position vs. on-hand

In (S−1, S):
- *Inventory position* = on-hand + on-order = $S$ always (just before each consumption).
- *On-hand* = $S - "outstanding orders"$.
- An *outstanding order* is one consumed within the past $L$ time units that hasn't yet arrived.

If demand during lead time is $D_L$, outstanding orders just before the next consumption is exactly $D_L$. So:

$ "On-hand" = (S - D_L)^+ $

Stockouts occur when $D_L > S$.

=== Set $S$ — Newsvendor style

Choose $S$ to balance holding cost vs. shortage cost.

For Poisson lead-time demand $D_L tilde "Poisson"(mu_L)$:

$ S^* = "smallest integer with " P(D_L lt.eq S) gt.eq "CR" $

Critical ratio: $"CR" = C_u \/ (C_u + C_o)$ where $C_u$ is shortage cost per unit, $C_o$ is holding cost per unit per cycle.

For a *cycle service-level* requirement (probability of no stockout in lead time = $1 - alpha$):

$ S = mu_L + z sigma_L quad ("normal approximation") $

For Poisson: $sigma_L = sqrt(mu_L)$, so $S approx mu_L + z sqrt(mu_L)$.

=== Average inventory

Steady-state expected on-hand:

$ E["on-hand"] = E[(S - D_L)^+] = S - mu_L + sigma_L L(z) $

where $L(z) = phi(z) - z(1 - Phi(z))$ is the standard normal loss function (see [expected_profit.typ](../newsvendor/expected_profit.typ)).

Annual holding cost: $h dot E["on-hand"]$.

=== Final formulas

$
  S = mu_L + z sigma_L
  quad
  "SS" = z sigma_L
  quad
  E["on-hand"] approx S - mu_L + sigma_L L(z)
$


#example[
  *Given* (same policy-comparison params, but interpret as low-volume spare-part regime):
  - Demand: $d = 1$ unit / day (Poisson) — instead of $33$/day to make the spare-part case realistic
  - Lead time: $L = 14$ days
  - Service level: 95% → $z = 1.645$

  Lead-time demand: $D_L tilde "Poisson"(mu_L = 14)$, $sigma_L = sqrt(14) approx 3.74$.

  *Step 1 — base-stock level*

  Normal approximation:
  $ S = mu_L + z sigma_L = cm(14) + cm(1.645) dot cm(3.74) approx 20 "units" $

  Exact (Poisson lookup): smallest $S$ with $P(D_L lt.eq S) gt.eq 0.95$.
  - $P(D_L lt.eq 19) approx 0.923$
  - $P(D_L lt.eq 20) approx 0.952$ ✓
  - $S^* = 20$.

  *Step 2 — interpret*

  Maintain inventory position at 20 at all times. Every time a unit is consumed, immediately reorder one. Average backlog of in-transit orders is $mu_L = 14$. Average on-hand:
  $ E["on-hand"] approx 20 - 14 = 6 "units (plus loss-function correction)" $

  *Step 3 — what if demand drops to 1 unit per *month* instead of per day?*

  $mu_L = 14 dot (1/30) approx 0.47$, $sigma_L = sqrt(0.47) approx 0.68$.
  - $S = 0.47 + 1.645 dot 0.68 approx 1.6 → 2$ (round up).
  - Most of the time, on-hand = 2; very occasional stockouts.

  *Compare to (Q, r)*

  In the *high-volume case* ($d = 33$/day): (Q, r) gives $r = 493$, $Q = 775$. Base-stock would give $S = 493$, but with $S - 1 = 492$ as the trigger — meaning *15 orders per day on average*. Per-order cost dominates → use (Q, r).

  In the *low-volume spare-part case* ($d = 1$/day): per-order cost is moot (warehouse already has the receiving infrastructure), and base-stock's responsiveness wins. (S−1, S) is the right choice.

  *Rule of thumb*: base-stock is optimal when $S_"setup" -> 0$ and converges to $r$ (no batching). For any non-trivial setup cost, batched policies (Q, r) or (s, S) reduce per-unit ordering cost.
]
