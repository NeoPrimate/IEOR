#import "/src/imports.typ": *

#let cm(x) = text(fill: red, [$#x$])

== Capacity-constrained multi-product newsvendor

Relax two dimensions from basic newsvendor: *number of items* > 1 *and* *capacity* is constrained. Each product has its own demand and cost structure, but they share a budget, warehouse space, or other resource.

Without the constraint, each product is its own newsvendor — $Q_i^* = mu_i + z_i^* sigma_i$ at its own critical ratio $"CR"_i = C_u^i \/ (C_u^i + C_o^i)$. With a shared constraint, those individual optima may not all be achievable — the constraint forces *trade-offs*.

=== Setup

$n$ products. For each $i$:
- Demand $D_i tilde cal(N)(mu_i, sigma_i^2)$
- Costs: $P_i, C_i, S_i$ → $C_u^i = P_i - C_i$, $C_o^i = C_i - S_i$
- Resource consumption: $v_i$ per unit of product $i$ (e.g., \$ if budget-constrained, ft³ if space-constrained)

Constraint:

$ sum_(i = 1)^n v_i Q_i lt.eq V $

If individual optima already satisfy the constraint, use them. The interesting case is when $sum_i v_i Q_i^"ind" > V$ — must shrink.

=== Lagrangian

Maximize total expected profit subject to the capacity constraint:

$ max_(Q_i) sum_i E[Pi_i (Q_i)] quad "s.t." quad sum_i v_i Q_i lt.eq V $

where $E[Pi_i(Q_i)]$ is the basic newsvendor expected profit for product $i$.

Lagrangian (with multiplier $lambda gt.eq 0$):

$ L = sum_i E[Pi_i(Q_i)] - cm(lambda) (sum_i v_i Q_i - V) $

=== Modified critical ratio

Take $partial L \/ partial Q_i = 0$ for each $i$:

$ partial / (partial Q_i) E[Pi_i] = cm(lambda) v_i $

For continuous demand, $partial E[Pi_i] \/ partial Q_i = (1 - F_i(Q_i)) C_u^i - F_i(Q_i) C_o^i$ (from the marginal-analysis derivation in basic newsvendor). Setting equal to $lambda v_i$:

$ (1 - F_i(Q_i)) C_u^i - F_i(Q_i) C_o^i = cm(lambda v_i) $
$ C_u^i - F_i(Q_i) (C_u^i + C_o^i) = cm(lambda v_i) $
$ F_i(Q_i^*) = (C_u^i - cm(lambda v_i)) / (C_u^i + C_o^i) $

Compare to basic: $F_i(Q_i^"basic") = C_u^i \/ (C_u^i + C_o^i)$. The constraint *reduces* each product's effective critical ratio by $lambda v_i \/ (C_u^i + C_o^i)$ — products that consume more capacity per unit get *bigger* CR cuts, ordering less.

Effective per-product CR:

$ "CR"_i (lambda) = (C_u^i - lambda v_i) / (C_u^i + C_o^i) $

When $lambda v_i gt.eq C_u^i$, the effective CR goes negative — that product is *not worth ordering at all* given the constraint.

=== Find $lambda$

$lambda$ is chosen so that $sum_i v_i Q_i^*(lambda) = V$. One equation, one unknown — bisection works (the LHS is monotone decreasing in $lambda$).

=== Algorithm

+ Compute unconstrained $Q_i^"basic" = mu_i + Phi^(-1)("CR"_i^"basic") sigma_i$.
+ Check $sum_i v_i Q_i^"basic" lt.eq V$. If yes, done.
+ Else, find $lambda > 0$ such that $sum_i v_i Q_i^*(lambda) = V$ (bisection).
+ Each $Q_i^* = mu_i + Phi^(-1)("CR"_i(lambda)) sigma_i$.


#example[
  *Given* (2 newspapers competing for budget):
  - Newspaper 1: $D_1 tilde cal(N)(100, 20^2)$, $P_1 = 3$, $C_1 = 1$, $S_1 = 0$ → $C_u^1 = 2$, $C_o^1 = 1$
  - Newspaper 2: $D_2 tilde cal(N)(50, 15^2)$, $P_2 = 5$, $C_2 = 2$, $S_2 = 0.5$ → $C_u^2 = 3$, $C_o^2 = 1.5$
  - Capacity (budget): $sum_i C_i Q_i lt.eq V$ where $V$ = \$150 (so $v_i = C_i$)

  *Step 1 — unconstrained per-product newsvendors*

  $
    "CR"_1 = 2 / 3 approx 0.667 quad arrow.r quad z_1^* approx 0.44 quad arrow.r quad Q_1^"ind" approx 100 + 0.44 dot 20 = 108.8
  $
  $
    "CR"_2 = 3 / 4.5 approx 0.667 quad arrow.r quad z_2^* approx 0.44 quad arrow.r quad Q_2^"ind" approx 50 + 0.44 dot 15 = 56.6
  $

  Budget required: $1 dot 108.8 + 2 dot 56.6 = 108.8 + 113.2 =$ \$222 — *exceeds \$150 budget*. Constraint binds.

  *Step 2 — solve for $lambda$*

  Effective critical ratios as a function of $lambda$:
  $ "CR"_1(lambda) = (2 - lambda dot 1) / 3, quad "CR"_2(lambda) = (3 - lambda dot 2) / 4.5 $

  Try $lambda = 0.4$:
  - $"CR"_1(0.4) = 1.6 / 3 approx 0.533$ → $z_1^* approx 0.082$ → $Q_1 approx 100 + 1.65 = 101.6$
  - $"CR"_2(0.4) = 2.2 / 4.5 approx 0.489$ → $z_2^* approx -0.028$ → $Q_2 approx 50 - 0.42 = 49.6$
  - Total budget: $1 dot 101.6 + 2 dot 49.6 = 200.8$ — still over.

  Try $lambda = 0.7$:
  - $"CR"_1(0.7) = 1.3 / 3 approx 0.433$ → $z_1^* approx -0.168$ → $Q_1 approx 96.6$
  - $"CR"_2(0.7) = 1.6 / 4.5 approx 0.356$ → $z_2^* approx -0.370$ → $Q_2 approx 44.5$
  - Total budget: $96.6 + 89 = 185.6$ — still over.

  Try $lambda = 1.0$:
  - $"CR"_1(1.0) = 1 / 3 approx 0.333$ → $z_1^* approx -0.431$ → $Q_1 approx 91.4$
  - $"CR"_2(1.0) = 1 / 4.5 approx 0.222$ → $z_2^* approx -0.764$ → $Q_2 approx 38.5$
  - Total budget: $91.4 + 77.0 = 168.4$ — close.

  Try $lambda = 1.15$ (interpolating):
  - $"CR"_1(1.15) = 0.85 / 3 approx 0.283$ → $z_1^* approx -0.572$ → $Q_1 approx 88.6$
  - $"CR"_2(1.15) = 0.7 / 4.5 approx 0.156$ → $z_2^* approx -1.013$ → $Q_2 approx 34.8$
  - Total budget: $88.6 + 69.6 = 158.2$ — closer.

  Try $lambda = 1.25$:
  - $"CR"_1(1.25) = 0.75 / 3 = 0.25$ → $z_1^* approx -0.674$ → $Q_1 approx 86.5$
  - $"CR"_2(1.25) = 0.5 / 4.5 approx 0.111$ → $z_2^* approx -1.221$ → $Q_2 approx 31.7$
  - Total budget: $86.5 + 63.4 = 149.9 approx 150$ ✓

  $ cm(lambda^* approx 1.25) $

  *Step 3 — final order quantities*

  $ Q_1^* approx 87, quad Q_2^* approx 32 $

  Both shrink below their individual optima (109, 57). Newspaper 2 shrinks proportionally more because its $v_i = 2$ is twice that of newspaper 1 — *the constraint penalizes resource-hungry items more*.

  *Step 4 — compare to unconstrained*

  - Unconstrained spend: \$222, both products near their individual optimal CR (~0.667).
  - Constrained spend: \$150, both products *below* their optimal CR — accepting more risk to fit the budget.

  The Lagrange multiplier $lambda^* approx 1.25$ is the *shadow price*: each additional dollar of budget would increase total expected profit by approximately \$1.25 (until $lambda$ falls back to zero, at which point the constraint stops binding).
]
