#import "/lib/imports.typ": *

#let cm(x) = text(fill: red, [$#x$])

Periodic review, *order-up-to* $S$. The simplest periodic-review policy.

*Decision rule*: at every review point (every $R$ time units), observe the inventory position and order *just enough to bring it up to* $S$. No reorder point — order at every review whether or not inventory is depleted.

Two parameters:
- $R$ = review interval (often fixed by external factors — a weekly truck, a monthly billing cycle)
- $S$ = order-up-to level

=== When to use

Periodic review — either because continuous monitoring is expensive (manual stock-taking) or because deliveries arrive on a fixed cadence (the supplier's truck comes every Monday whether you want it to or not). (R, S) is the workhorse for this regime.

=== Inventory profile

Sawtooth, with reviews as the cycle anchor:
- At review $t$: observe position $I_t$. Order $S - I_t$. Order arrives at $t + L$.
- Between reviews: inventory drains stochastically. *No intervention even if it runs out.*
- *Stockout window*: from order placed until the *next* order arrives — that's $R + L$ (review interval plus lead time).

=== Set $S$

The protection window is $R + L$ (not just $L$ as in continuous review!). Demand during this window has:
- Mean: $mu_(R+L) = d (R + L)$
- Std: $sigma_(R+L) = sigma_d sqrt(R + L)$

For service level $1 - alpha$:

$ S = cm(mu_(R+L)) + cm(z) cm(sigma_(R+L)) $

The safety stock $z sigma_(R+L)$ is *larger* than continuous-review safety stock by factor $sqrt((R+L)\/L)$.

=== No $r$ in (R, S)

Unlike continuous review, there's no reorder point — every review triggers an order, even if inventory is still high. Order quantity varies cycle to cycle:

$ Q_"actual" = S - I_t $

Sometimes $Q_"actual" approx 0$ (just received last order); sometimes large (after a busy period). Average: $Q_"actual" = R d$ (you replace what was consumed since last review).

=== Final formulas

$
  S = mu_(R+L) + z sigma_(R+L)
  quad
  "SS" = z sigma_(R+L)
  quad
  Q_"actual" = S - I_"current"
$

#example[
  *Given* (same policy-comparison params + a 30-day review):
  - $D = 12000$/yr, $d = 33$/day, $sigma_d = 5$, $L = 14$ days
  - Review interval: $R = 30$ days (monthly review)
  - $h$ = \$2/unit/yr, $z = 1.645$

  *Step 1 — protection window*

  $ R + L = cm(30) + cm(14) = 44 "days" $

  *Step 2 — demand statistics over the window*

  $ mu_(R+L) = d (R + L) = 33 dot 44 = 1452 "units" $
  $ sigma_(R+L) = sigma_d sqrt(R + L) = 5 dot sqrt(44) approx 33.2 "units" $

  *Step 3 — order-up-to level*

  $ S = mu_(R+L) + z sigma_(R+L) = cm(1452) + cm(1.645) dot cm(33.2) approx 1452 + 54.6 approx 1507 "units" $

  Safety stock: $"SS" = 54.6$ units.

  *Step 4 — typical cycle*

  At each monthly review, suppose inventory position is around $1507 - 33 dot 30 = 517$ (steady-state, average consumption between reviews).
  - Order: $1507 - 517 = 990$ units.
  - Order arrives 14 days later. By then, inventory has drained further.
  - Next review: position is back near 517 again (steady state). Order another ~990.

  *Step 5 — compare to (Q, r)*

  (Q, r) on the same demand: $r = 493$, $Q = 775$, safety stock = 31.
  (R, S): $S = 1507$, safety stock = 55.

  *(R, S) carries 24 extra units of safety stock (almost 2x)*. Why? The protection window is $R + L = 44$ days vs $L = 14$ days. Variance scales linearly with window length, so std scales as $sqrt(44/14) = 1.77$.

  *Trade-off*: continuous review needs (Q, r) infrastructure (real-time tracking). Periodic review accepts more safety stock in exchange for simpler operations.
]
