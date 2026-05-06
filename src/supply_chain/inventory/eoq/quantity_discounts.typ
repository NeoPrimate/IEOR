#import "/src/imports.typ": *

#let cm(x) = text(fill: red, [$#x$])

== EOQ with quantity discounts

Relax one dimension from basic EOQ: *unit price is no longer flat*. The supplier offers per-unit discounts at break quantities — buy more, pay less per unit. Now purchase cost $c D$ depends on $Q$ (via the chosen price tier), so we *cannot* drop it from TC.

Two discount rules are common; we treat both.

=== All-units discount

The discounted price applies to *every* unit once you cross the break.

Tiers indexed $k = 1, 2, dots, K$ with break quantities $0 = Q_0 < Q_1 < dots < Q_(K-1)$ and unit costs $c_1 > c_2 > dots > c_K$:

$ c(Q) = c_k quad "if" quad Q_(k-1) lt.eq Q < Q_k $

(Last tier $k = K$ has no upper bound: $Q gt.eq Q_(K-1)$.)

Holding cost is typically $h_k = i dot c_k$ where $i$ is the annual carrying-cost rate (% of unit value), so the *effective holding rate scales with the unit cost*.

=== Cost model

Total cost (now keep purchase cost — it depends on tier):

$ "TC"_k(Q) = cm(c_k D) + S (D / Q) + h_k (Q / 2) quad "where" quad h_k = i c_k $

The new term $cm(c_k D)$ is the only addition vs basic-EOQ TRC, but it's the dominant one.

=== Algorithm (all-units case)

1. *For each tier $k$*, compute the within-tier EOQ:
  $ Q_k^* = sqrt((2 S D) / h_k) = sqrt((2 S D) / (i c_k)) $
2. *Feasibility*: is $Q_k^* in [Q_(k-1), Q_k)$?
  - If yes: candidate $Q_k = Q_k^*$.
  - If $Q_k^* < Q_(k-1)$ (EOQ too small for this tier): candidate $Q_k = Q_(k-1)$ (snap up to the break).
  - If $Q_k^* gt.eq Q_k$ (EOQ too large for this tier): tier $k$ is dominated by a lower tier ($k+1$ at least), skip it.
3. *Evaluate $"TC"_k$* at each candidate.
4. *Pick the candidate with the smallest $"TC"_k$* — that's $Q^*$.

Geometric intuition: each tier has its own U-shaped TRC curve, sitting on top of a tier-specific constant $c_k D$. Lower tiers have a higher floor but the same shape. The optimum is the lowest *feasible* point across all tiers' curves.

=== Incremental discount (briefly)

Each break only discounts *units beyond* the threshold. So the cost is piecewise linear in $Q$ (no jump at breaks):

$ "Purchase"(Q) = sum_(k=1)^K c_k dot max(0, min(Q, Q_k) - Q_(k-1)) $

The TC curve is continuous (no jumps). Optimization is similar but there's no need to snap to break quantities — you just minimize TC$(Q)$ piecewise within each segment.

=== Final formulas

For the *all-units* case, no closed-form $Q^*$ — must enumerate tiers as above.

Sanity check: with a single tier ($K = 1$), the algorithm reduces to basic EOQ exactly.


#example[
  *Given* (shared EOQ params + a 3-tier discount schedule):
  - Annual demand: $D = 12000$ units/year
  - Order cost: $S$ = \$50 / order
  - Carrying-cost rate: $i = 0.20$ (20%/year)
  - Discount schedule:

  #table(
    columns: 3,
    inset: 0.7em,
    align: center,
    [*Tier $k$*], [*Quantity range*], [*Unit cost $c_k$*],
    [1], [$Q < 500$], [\$10.00],
    [2], [$500 lt.eq Q < 1000$], [\$9.50],
    [3], [$Q gt.eq 1000$], [\$9.00],
  )

  *Step 1 — within-tier EOQ for each tier*

  Holding cost is $h_k = i c_k$:

  $
    Q_1^* = sqrt((2 dot 50 dot 12000) / (cm(0.2 dot 10))) = sqrt(600000) approx 775
  $
  $
    Q_2^* = sqrt((2 dot 50 dot 12000) / (cm(0.2 dot 9.5))) = sqrt(631579) approx 794
  $
  $
    Q_3^* = sqrt((2 dot 50 dot 12000) / (cm(0.2 dot 9))) = sqrt(666667) approx 816
  $

  *Step 2 — feasibility check*

  - Tier 1 (range $Q < 500$): $Q_1^* = 775$ is *outside* (too large). Tier 1 is dominated. Skip.
  - Tier 2 (range $500 lt.eq Q < 1000$): $Q_2^* = 794$ is *inside* ✓. Candidate $Q_2 = 794$.
  - Tier 3 (range $Q gt.eq 1000$): $Q_3^* = 816$ is *outside* (below the break). Snap to break: candidate $Q_3 = 1000$.

  *Step 3 — evaluate TC at each candidate*

  $
    "TC"_2(794) = c_2 D + S (D / Q) + h_2 (Q / 2)
  $
  $
    = (cm(9.5)) dot 12000 + 50 dot (12000 / 794) + (cm(0.2 dot 9.5)) dot (794 / 2)
  $
  $
    = 114000 + 755.7 + 754.3 approx 115510
  $

  $
    "TC"_3(1000) = (cm(9.0)) dot 12000 + 50 dot (12000 / 1000) + (cm(0.2 dot 9.0)) dot (1000 / 2)
  $
  $
    = 108000 + 600 + 900 approx 109500
  $

  Tier 3 wins.

  *Step 4 — compare to basic EOQ at the cheapest flat price*

  - Basic EOQ at $c =$ \$10 (no discount available): $Q^* = 775$, $"TC" approx 120000 + 774 + 775 approx 121549$.
  - With discount (use $Q^* = 1000$): $"TC" approx 109500$. Save \$12049/year by ordering just past the break to capture the volume discount.

  The savings come almost entirely from the lower unit cost (\$9 vs \$10 saves \$12000/year on purchase alone). The order/holding penalty for ordering above the unconstrained optimum is small because EOQ is forgiving (square-root cushion).
]
