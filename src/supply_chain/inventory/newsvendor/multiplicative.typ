#import "/lib/imports.typ": *

#let cm(x) = text(fill: red, [$#x$])

== Newsvendor with multiplicative demand

Relax one dimension from basic newsvendor: the *demand model* is no longer additive. Instead of $D = mu + epsilon$ with additive noise of fixed scale $sigma$, the demand multiplies a deterministic baseline:

$ cm(D = mu dot Z) $

where $Z$ is a positive random factor with mean 1 and known distribution $G$. In additive form, $sigma_D = sigma_Z$ (independent of mean). In multiplicative form, $sigma_D = mu sigma_Z$ — *uncertainty scales with the baseline*.

When does multiplicative make sense? Whenever demand uncertainty is *proportional* — sales of a product 10× as popular have 10× the absolute swing, not the same. Common in retail, fashion, and seasonal goods.

=== Setup

Same costs as basic newsvendor:
- $C_u = P - C$, $C_o = C - S$
- $"CR" = C_u \/ (C_u + C_o)$

Demand: $D = mu dot Z$, where $Z tilde G$ with $E[Z] = 1$.

Decision: $Q$, but it's natural to write $Q = mu dot z$ (factor relative to baseline).

=== Critical-ratio derivation (unchanged)

The marginal-analysis logic from basic newsvendor is unchanged. Order one more unit while expected marginal profit is positive. The condition $F_D(Q^*) = "CR"$ still holds, just rewritten in terms of $Z$:

$ F_D(Q) = P(D lt.eq Q) = P(mu Z lt.eq Q) = P(Z lt.eq Q\/mu) = G(Q\/mu) $

Set $G(Q^*\/mu) = "CR"$:

$ Q^* = mu dot cm(G^(-1)("CR")) $

=== Form of the answer

Write $z^* = G^(-1)("CR")$. Then:

$ Q^* = mu dot z^* quad ("multiplicative") $

Compare to additive form:
$ Q^* = mu + sigma_Z z^* quad ("additive") $

Same critical ratio, same $z^*$ logic, but *multiplicative scales $Q^*$ as a fraction of $mu$* instead of adding to it.

=== Lognormal demand specialization

Common choice: $Z tilde "Lognormal"(mu_Z = 0, sigma_Z^2)$ with $E[Z] = e^(sigma_Z^2 \/ 2)$. Note $E[Z] eq.not 1$ in general — if you want $E[Z] = 1$ exactly, use $mu_Z = -sigma_Z^2 \/ 2$.

In log-space, $log Z tilde cal(N)(mu_Z, sigma_Z^2)$. Then:

$ z^* = exp(mu_Z + sigma_Z dot Phi^(-1)("CR")) $


#example[
  *Given* (same newspaper baseline but multiplicative noise):
  - $P = 3$, $C = 1$, $S = 0$ → $C_u = 2$, $C_o = 1$, $"CR" = 2\/3$
  - Baseline demand: $mu = 100$
  - Multiplicative noise: $Z$ has $E[Z] = 1$, coefficient of variation $"CV" = sigma_Z = 0.2$ (i.e., 20% relative noise)
  - Specifically: $log Z tilde cal(N)(-0.02, 0.2^2)$ (so $E[Z] approx 1$)

  *Step 1 — critical ratio*

  $ "CR" = 2 / 3 approx 0.667 $
  (Same as basic newsvendor — the critical ratio depends on costs only.)

  *Step 2 — quantile in $Z$-space*

  $ z^* = exp(-0.02 + 0.2 dot Phi^(-1)(cm(0.667))) = exp(-0.02 + 0.2 dot cm(0.430)) $
  $ z^* = exp(-0.02 + 0.086) approx exp(0.066) approx 1.068 $

  *Step 3 — order quantity*

  $ Q^* = mu dot z^* = cm(100) dot cm(1.068) approx 107 "newspapers" $

  *Step 4 — compare to basic (additive) newsvendor*

  In the basic example, $sigma_D = 20$ (absolute), so $Q^* approx 100 + 0.44 dot 20 approx 109$.

  In multiplicative form with $"CV" = 0.2$, $sigma_D = mu dot 0.2 = 20$ (same absolute uncertainty *at $mu = 100$*). $Q^* approx 107$.

  Slight difference (109 vs 107) comes from the lognormal having a different shape than normal — same coefficient of variation, but right-skewed (long right tail). The lognormal puts more probability on the right, so the upper quantile is actually less far above the mean than for a normal of the same $sigma$.

  *Why multiplicative matters at scale*

  If baseline demand grows to $mu = 1000$, additive-form predicts $sigma_D = 20$ still (a 2% relative swing — implausibly small). Multiplicative-form predicts $sigma_D = 200$ (a 20% swing, structurally consistent).

  At $mu = 1000$:
  - Additive: $Q^* approx 1000 + 0.44 dot 20 = 1009$ (essentially deterministic).
  - Multiplicative: $Q^* approx 1000 dot 1.068 = 1068$ (still 6.8% above baseline).

  *Choose multiplicative when uncertainty is proportional to the baseline*; additive when it's a fixed scale (e.g., shipping noise, fixed measurement error).
]
