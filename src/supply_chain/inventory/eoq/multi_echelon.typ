#import "/lib/imports.typ": *

#let cm(x) = text(fill: red, [$#x$])

== Multi-echelon EOQ

Relax one dimension from basic EOQ: *number of echelons* is no longer one. Inventory is held at multiple stages of a supply chain (warehouse → retailer, supplier → factory → distributor, etc.). Orders cascade up the chain, and each stage has its own setup and holding costs.

Key concept: *echelon inventory* $-$ at each stage, count not just on-hand but also all downstream inventory you've already paid to put in motion.

=== Setup (two-echelon: warehouse $arrow.r$ retailer)

- $d$ = customer demand rate at the retailer
- *Retailer*: setup $S_r$, holding $h_r$ per unit per year, cycle time $T_r$
- *Warehouse*: setup $S_w$, *echelon* holding $h_w$ per unit per year (the *added* cost of holding at the warehouse vs nowhere), cycle time $T_w$

The retailer pulls from the warehouse every $T_r$. The warehouse re-orders from the upstream supplier every $T_w$. *Nesting* requirement: $T_w$ must be an integer multiple of $T_r$ (otherwise the warehouse stocks fractionally, which is wasteful).

=== Cost model

Annual cost = sum across stages:

$
  "TC"(T_r, T_w) = underbrace((S_r) / T_r + h_r d T_r / 2, "retailer") + underbrace((S_w) / T_w + h_w d T_w / 2, "warehouse")
$

Constraint: $T_w = k T_r$ for some integer $k gt.eq 1$.

=== Unconstrained optimum (relax integer $k$)

If we *ignored* nesting, each stage would independently optimize:

$ T_r^"basic" = sqrt((2 S_r) / (h_r d)) quad T_w^"basic" = sqrt((2 S_w) / (h_w d)) $

This is just basic EOQ at each stage. But a non-integer ratio $T_w \/ T_r$ wastes capacity — the warehouse would carry partial cycles. *Nesting* is required for clean operation.

=== Roundy's power-of-two policies

*Restrict cycle times to powers of two of a base period*: $T_i = 2^(k_i) T_0$ for integer $k_i gt.eq 0$, where $T_0$ is fixed (e.g., 1 day).

Then *any two cycles are nested*: a stage with $k_i = 3$ orders 8 base periods; another with $k_i = 5$ orders every 32 base periods $-$ the second is always a multiple of the first.

*Roundy's 98% theorem*: the best power-of-two policy achieves *at least 98%* of the unconstrained optimum (worst-case cost ratio $lt.eq sqrt(2 \/ ln(2)) \/ (1 + 1\/sqrt(2)) approx 1.06$). So a 6% penalty is the worst case for using powers of two.

=== Algorithm

1. Compute unconstrained $T_i^"basic"$ at each stage.
2. Round each to the nearest power of two: $T_i^* = 2^(k_i^*) T_0$ where $k_i^* = "round"(log_2(T_i^"basic" \/ T_0))$.
3. Compute resulting cost $"TC"^*$ and verify it's within 6% of $sum_i sqrt(2 S_i h_i d)$.

=== Final formulas (two-stage, nested with $T_w = k T_r$)

Substitute $T_w = k T_r$ into TC:

$ "TC"(T_r, k) = (S_r + S_w \/ k) / T_r + (h_r + k h_w) d T_r / 2 $

Optimize over $T_r$ for fixed $k$:

$ T_r^*(k) = sqrt((2 (S_r + S_w \/ k)) / ((h_r + k h_w) d)) $
$ "TC"^*(k) = sqrt(2 (S_r + S_w \/ k) (h_r + k h_w) d) $

Now optimize over integer $k gt.eq 1$ — small search (typically $k in {1, 2, 4, 8}$).


#example[
  *Given* (two-echelon: warehouse $arrow.r$ retailer):
  - Retail demand: $d = 12000$ units/year
  - Retailer: $S_r$ = \$50 / order, $h_r$ = \$2 / unit / year
  - Warehouse: $S_w$ = \$200 / order, $h_w$ = \$1 / unit / year (echelon — added cost over nothing)

  *Step 1 — unconstrained $T_i^"basic"$ at each stage*

  $
    T_r^"basic" = sqrt((2 dot 50) / (2 dot 12000)) approx 0.0645 "yr" approx cm(24) "days"
  $
  $
    T_w^"basic" = sqrt((2 dot 200) / (1 dot 12000)) approx 0.1826 "yr" approx cm(67) "days"
  $

  Ratio $T_w^"basic" / T_r^"basic" approx 67 \/ 24 approx 2.83$ — roughly 3, but not an integer.

  *Step 2 — search nested integer $k$*

  Try $k = 1, 2, 3, 4$:

  $"TC"^*(k) = sqrt(2 (S_r + S_w \/ k)(h_r + k h_w) d)$:

  #table(
    columns: 4,
    inset: 0.7em,
    align: center,
    [*$k$*], [*$S_r + S_w \/ k$*], [*$h_r + k h_w$*], [*$"TC"^*(k)$*],
    [1], [50 + 200 = 250], [2 + 1 = 3], [$sqrt(2 dot 250 dot 3 dot 12000) approx 4243$],
    [2], [50 + 100 = 150], [2 + 2 = 4], [$sqrt(2 dot 150 dot 4 dot 12000) approx 3795$],
    [3], [50 + 67 = 117], [2 + 3 = 5], [$sqrt(2 dot 117 dot 5 dot 12000) approx 3742$],
    [4], [50 + 50 = 100], [2 + 4 = 6], [$sqrt(2 dot 100 dot 6 dot 12000) approx 3795$],
  )

  Optimal $k^* = cm(3)$ (warehouse cycle is 3× the retailer cycle).

  *Step 3 — cycle times at $k^* = 3$*

  $
    T_r^* = sqrt((2 (50 + 200\/3)) / ((2 + 3 dot 1) dot 12000)) = sqrt((2 dot 117) / (5 dot 12000)) approx 0.0625 "yr" approx 23 "days"
  $
  $
    T_w^* = 3 dot T_r^* approx 68 "days"
  $

  Order quantities: retailer $Q_r^* = d T_r^* approx 750$, warehouse $Q_w^* = d T_w^* approx 2280$.

  *Step 4 — compare to basic EOQ at each stage independently*

  Treating the two stages independently (no nesting):
  - Retailer: $"TC"_r = sqrt(2 dot 50 dot 2 dot 12000) approx 1549$
  - Warehouse: $"TC"_w = sqrt(2 dot 200 dot 1 dot 12000) approx 2191$
  - Sum (independent): \$3740/year

  Multi-echelon nested: $"TC"^*(3) approx 3742$.

  *They almost coincide!* The 6% Roundy bound is achieved here at 0.05% — the integer-$k$ constraint costs almost nothing because $T_w^"basic" \/ T_r^"basic" approx 2.83$ was already close to a small integer (3). *This is the Roundy theorem at work*: with two stages, the worst-case nesting penalty is bounded by 6%, and in practice it's usually much less.

  The deeper takeaway: *power-of-two policies generalize this beyond two stages* — at any number of echelons, restrict each cycle to $T_i = 2^(k_i) T_0$ and the worst-case penalty stays below 6%. Predictable, nestable, near-optimal.
]
