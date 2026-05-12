#import "/lib/imports.typ": *
#show: formatting

#let cm(x) = text(fill: red, [$#x$])

Relax one dimension from basic EOQ: *capacity is no longer unlimited*. A shared resource — warehouse space, working-capital budget, or shelf footprint — caps the total inventory you can hold at any moment. Multiple items compete for the same budget.

=== Setup

$n$ items indexed $i = 1, dots, n$:
- $D_i$, $S_i$, $h_i$ as in basic EOQ (item-specific)
- $v_i$ = capacity consumed per unit of item $i$ (e.g., \$ per unit if budget-constrained, ft³ per unit if warehouse-constrained)
- $V$ = total capacity available

Constraint (peak inventory after a fresh order arrives):

$ sum_(i=1)^n v_i Q_i lt.eq V $

If individual EOQs already satisfy the constraint, the constraint is *not binding* — use them directly. The interesting case is when $sum_i v_i Q_i^"basic" > V$.

=== Lagrangian formulation

Minimize total cost subject to the capacity constraint:

$ min_(Q_1, dots, Q_n) sum_i [S_i (D_i \/ Q_i) + h_i (Q_i \/ 2)] quad "s.t." quad sum_i v_i Q_i lt.eq V $

Introduce Lagrange multiplier $lambda gt.eq 0$ for the constraint:

$ L(Q_1, dots, Q_n, lambda) = sum_i [S_i (D_i \/ Q_i) + h_i (Q_i \/ 2)] + cm(lambda) (sum_i v_i Q_i - V) $

=== KKT / FOC in $Q_i$

For each $i$, $partial L \/ partial Q_i = 0$:

$ -S_i D_i / Q_i^2 + h_i / 2 + cm(lambda) v_i = 0 $
$ S_i D_i / Q_i^2 = h_i / 2 + cm(lambda) v_i = (h_i + 2 lambda v_i) / 2 $
$ Q_i^*(lambda) = sqrt((2 S_i D_i) / (h_i + cm(2 lambda v_i))) $

This is *basic EOQ with an inflated holding cost* $h_i + 2 lambda v_i$. The Lagrange multiplier $lambda$ raises the effective holding cost on every item *in proportion to its capacity consumption $v_i$* — items that hog more capacity get penalized more, shrinking their $Q_i$.

=== Find $lambda$ from the constraint

If the constraint binds, $sum_i v_i Q_i^*(lambda) = V$. This is one equation in one unknown $lambda$ — solve numerically (or in closed form for some special cases).

*Special case: budget constraint with proportional holding.* If $v_i = c_i$ (capacity is dollars), $h_i = i c_i$ (carrying-rate model), and we substitute into $Q_i^*(lambda)$:

$ Q_i^* = sqrt((2 S_i D_i) / (i c_i + 2 lambda c_i)) = sqrt((2 S_i D_i) / c_i) dot 1 / sqrt(i + 2 lambda) $

Then $v_i Q_i^* = c_i Q_i^* = sqrt(2 S_i D_i c_i) \/ sqrt(i + 2 lambda)$. Sum:

$ sum_i v_i Q_i^* = (1 / sqrt(i + 2 lambda)) sum_i sqrt(2 S_i D_i c_i) = V $

Solve for $lambda$:

$ sqrt(i + 2 lambda) = (sum_i sqrt(2 S_i D_i c_i)) / V $
$ lambda = 1 / 2 [((sum_i sqrt(2 S_i D_i c_i)) / V)^2 - i] $

For other constraint forms, $lambda$ comes out of a 1-D root-finding pass over $sum_i v_i Q_i^*(lambda) - V = 0$ (monotone decreasing in $lambda$, so bisection works).

=== Algorithm

1. Compute unconstrained $Q_i^"basic" = sqrt(2 S_i D_i \/ h_i)$ for each $i$.
2. Check $sum_i v_i Q_i^"basic" lt.eq V$. If yes, done — constraint not binding.
3. Else, solve for $lambda$ (closed form above, or numerical).
4. Each $Q_i^* = sqrt(2 S_i D_i \/ (h_i + 2 lambda v_i))$.

=== Final formulas

$
  Q_i^*(lambda) = sqrt((2 S_i D_i) / (h_i + 2 lambda v_i))
  quad "where" quad lambda gt.eq 0 "satisfies" sum_i v_i Q_i^*(lambda) = V
$

Sanity check: if $V -> infinity$ (no constraint), $lambda -> 0$ and $Q_i^* -> sqrt(2 S_i D_i \/ h_i)$ — basic EOQs ✓.

#example[
  *Given* (2 items sharing a budget-constrained warehouse):
  - Item 1: $D_1 = 12000$, $S_1$ = \$50, $c_1$ = \$10, $i = 0.20$ → $h_1 = 2$
  - Item 2: $D_2 = 6000$, $S_2$ = \$50, $c_2$ = \$20, $i = 0.20$ → $h_2 = 4$
  - Constraint: peak inventory value $sum_i c_i Q_i lt.eq V$ where $V$ = \$10,000

  *Step 1 — unconstrained EOQs and constraint check*

  $
    Q_1^"basic" = sqrt((2 dot 50 dot 12000) / 2) = 775
  $
  $
    Q_2^"basic" = sqrt((2 dot 50 dot 6000) / 4) = 387
  $

  Peak inventory value $= cm(10) dot 775 + cm(20) dot 387 = 7750 + 7740 = cm(15490)$. Exceeds the \$10,000 budget — *constraint binds*.

  *Step 2 — find $lambda$ via the closed-form*

  $
    sum_i sqrt(2 S_i D_i c_i) = sqrt(2 dot 50 dot 12000 dot 10) + sqrt(2 dot 50 dot 6000 dot 20)
    = sqrt(12000000) + sqrt(12000000) approx 3464 + 3464 = 6928
  $
  $
    sqrt(i + 2 lambda) = 6928 / 10000 = 0.6928 quad arrow.r quad i + 2 lambda = 0.48
  $
  $
    2 lambda = 0.48 - 0.20 = 0.28 quad arrow.r quad lambda = cm(0.14)
  $

  *Step 3 — constrained order quantities*

  Effective holding cost per item: $h_i + 2 lambda v_i = h_i + 0.28 c_i$:
  - Item 1: $h_1^"eff" = 2 + 0.28 dot 10 = 4.8$
  - Item 2: $h_2^"eff" = 4 + 0.28 dot 20 = 9.6$

  $
    Q_1^* = sqrt((2 dot 50 dot 12000) / cm(4.8)) = sqrt(250000) = 500
  $
  $
    Q_2^* = sqrt((2 dot 50 dot 6000) / cm(9.6)) = sqrt(62500) = 250
  $

  *Step 4 — verify the constraint*

  $cm(10) dot 500 + cm(20) dot 250 = 5000 + 5000 = 10000$ ✓ exactly hits the budget.

  *Step 5 — total cost and comparison to basic EOQ*

  - Item 1 cost: $50 dot 12000 \/ 500 + 2 dot 500 \/ 2 = 1200 + 500 = 1700$
  - Item 2 cost: $50 dot 6000 \/ 250 + 4 dot 250 \/ 2 = 1200 + 500 = 1700$
  - Total constrained: *\$3400*

  Unconstrained (basic EOQ for each):
  - Item 1: $sqrt(2 dot 50 dot 12000 dot 2) approx 1549$
  - Item 2: $sqrt(2 dot 50 dot 6000 dot 4) approx 1549$
  - Total unconstrained: *\$3098*

  *Capacity penalty: \$302/year* (about 10% over unconstrained). The Lagrange multiplier $lambda = 0.14$ acts as a shadow price — each \$ of additional warehouse budget would save approximately $lambda$ × marginal value per year.
]
