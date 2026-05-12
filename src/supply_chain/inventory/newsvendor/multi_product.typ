#import "/lib/imports.typ": *
#show: formatting

#let cm(x) = text(fill: red, [$#x$])

== Multi-product newsvendor (risk pooling)

Relax one dimension from basic newsvendor: *number of items* is no longer one. Multiple products $i = 1, dots, n$ with random demands $D_i tilde cal(N)(mu_i, sigma_i^2)$.

Two cases, dramatically different:
+ *Independent decisions, independent inventories.* Each product is its own newsvendor. Solve $n$ separate problems.
+ *Pooled inventory.* All products share the same physical pool (interchangeable, or shipped from one location to many destinations). One newsvendor problem on the *aggregate* demand $D_"agg" = sum_i D_i$.

Pooling is often *much better* — *risk pooling* / *demand aggregation* reduces relative uncertainty.

=== Independent newsvendors (case 1)

Just $n$ separate basic newsvendors. Each has its own $C_u^i$, $C_o^i$, $"CR"_i$, $Q_i^*$. Total expected profit is the sum.

=== Pooled inventory (case 2): aggregate demand statistics

If $D_i tilde cal(N)(mu_i, sigma_i^2)$ with pairwise correlation $rho_(i j)$:

$ mu_"agg" = sum_(i = 1)^n mu_i $

$ sigma_"agg"^2 = cm(sum_(i = 1)^n sigma_i^2 + 2 sum_(i < j) rho_(i j) sigma_i sigma_j) $

For *independent* products ($rho_(i j) = 0$):

$ sigma_"agg" = sqrt(sum_(i = 1)^n sigma_i^2) $

For *identical, independent* products ($mu_i = mu$, $sigma_i = sigma$):

$ mu_"agg" = n mu, quad sigma_"agg" = sqrt(n) dot sigma $

=== Pooling reduces relative uncertainty

Coefficient of variation (CV = $sigma\/mu$) for the aggregate vs. individual:

$ "CV"_"agg" = sigma_"agg" / mu_"agg" = (sqrt(n) sigma) / (n mu) = "CV"_"individual" / sqrt(n) $

*Pooling $n$ identical products cuts relative uncertainty by $sqrt(n)$.* Pool 4 products → half the relative noise. Pool 100 → 10× less.

This translates directly into safety stock savings: the buffer above $mu$ scales with $sigma$, not $mu$, so doubling $n$ adds inventory only as $sqrt(2)$, while demand grows as 2.

=== Pooled order decision

Same newsvendor structure, but on aggregate:

$ Q_"agg"^* = mu_"agg" + z^* dot sigma_"agg" $

where $z^* = Phi^(-1)("CR")$ uses the pooled cost structure.

=== When pooling is worse

Risk pooling is *not always* beneficial:
- *Correlated demands* with $rho_(i j) > 0$: aggregation doesn't reduce variance much. Worst case, perfect correlation ($rho = 1$): $sigma_"agg" = sum_i sigma_i$, no benefit.
- *Heterogeneous service-level requirements*: pooling forces a single CR; if products need different service levels, separate inventories may be better.
- *Substitution / customization*: physical pooling requires items to be substitutable. A red and blue jersey can't be pooled if the customer wants a specific color.


#example[
  *Given* (4 identical-ish newspaper variants, independent demands):
  - 4 products, each: $P_i = 3$, $C_i = 1$, $S_i = 0$, $D_i tilde cal(N)(100, 20^2)$
  - Demands independent across products

  *Step 1 — independent newsvendors (no pooling)*

  Each product is its own newsvendor, identical to the basic example:
  - $"CR" = 2\/3$, $z^* = 0.44$, $Q_i^* = 100 + 0.44 dot 20 approx 109$
  - Total inventory: $4 dot 109 = bold(436)$

  *Step 2 — pooled (case 2)*

  Aggregate:
  - $mu_"agg" = 4 dot 100 = 400$
  - $sigma_"agg" = sqrt(4) dot 20 = 40$ (only $sqrt(n)$, not $n$)
  - $"CR" = 2\/3$, $z^* = 0.44$
  - $Q_"agg"^* = 400 + 0.44 dot 40 approx bold(418)$

  *Step 3 — compare*

  - Independent: 436 units total
  - Pooled: 418 units total
  - *Save 18 units (≈ 4%)* with the same service level.

  *Step 4 — see the $sqrt(n)$ scaling*

  At $n = 100$ identical products:
  - Independent: $100 dot 109 = 10900$ units
  - Pooled: $mu_"agg" + z^* sigma_"agg" = 10000 + 0.44 dot 200 = 10088$ units
  - *Save ~7%* and the relative savings *grow with $n$* — at large $n$, pooled inventory approaches just $mu_"agg"$ (deterministic limit), while independent inventory still carries each product's full safety buffer.

  *Why pooling works*: when one product over-sells, another likely under-sells. Net demand is more predictable than any one product's demand. Pooling captures this — independent stocks can't.

  *Real-world consequence*: distribution center designs, online retailers vs. physical stores, fungible commodities — all driven by the $sqrt(n)$ risk-pooling math.
]
