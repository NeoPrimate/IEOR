#import "/lib/imports.typ": *
#show: formatting

#let cm(x) = text(fill: red, [$#x$])

== Fill Rate (Type II, $beta$)

The expected *fraction of demand* satisfied directly from on-hand inventory. Counts *units*, not events.

$ "Fill rate" = beta = E["units served"] / E["units demanded"] = 1 - E["units short"] / E["units demanded"] $

=== Why fill rate, not CSL?

Cycle service level (CSL) treats every stockout — small or large — as a single failure. Fill rate is *unit-weighted*: a cycle that's 1 unit short is treated very differently from a cycle that's 100 units short. Most operational service-level promises to customers (e.g., "we fulfill 99% of unit demand") refer to fill rate.

CSL → frequency of stockout incidents.
Fill rate → fraction of demand met.

=== Computing fill rate (continuous demand)

For a (Q, r) policy with normal lead-time demand:

$ "Expected shortage per cycle" = E[(D_L - r)^+] = sigma_L dot L(z) $

where $z = (r - mu_L) \/ sigma_L$ and $L(z) = phi(z) - z(1 - Phi(z))$ is the *standard normal loss function* (see [newsvendor expected_profit](../newsvendor/expected_profit.typ) for the derivation).

Each cycle covers $Q$ units of demand on average. So:

$ beta = 1 - E["shortage per cycle"] / E["demand per cycle"] = 1 - cm(sigma_L L(z)) / Q $

Equivalently:

$ "Required" sigma_L L(z) = (1 - beta) Q $

To hit fill rate $beta$, choose $r$ such that $L(z) = (1 - beta) Q \/ sigma_L$.

=== Why fill rate is usually higher than CSL

For the same $r$:
- *CSL* = $P(D_L lt.eq r) = 1 - alpha$
- *Fill rate* = $1 - sigma_L L(z) \/ Q$

Whenever $Q$ is much larger than $sigma_L$, the fill rate exceeds the CSL. Reason: most cycles run no stockout at all (contributing 100% fill); the few that *do* stock out are usually short by only a few units (each contributing > 99% fill on its own cycle).

Practical ranges:
- Lean inventory ($Q \/ sigma_L approx 5$): fill rate $approx$ CSL.
- Standard ($Q \/ sigma_L approx 20$): fill rate $approx$ CSL + 5%.
- Bulk ($Q \/ sigma_L approx 50$): fill rate can be 99% even at CSL = 80%.

=== Setting $r$ for target fill rate

Iterative or table-based. Algorithm:

+ Given target $beta$, solve $L(z) = (1 - beta) Q \/ sigma_L$ for $z$.
+ Use a normal loss function table (or numerically solve $z$).
+ Set $r = mu_L + z sigma_L$.

Most software does this automatically.


#example[
  *Given* (same params as CSL example):
  - $Q = 775$, $mu_L = 462$, $sigma_L = 18.7$
  - Target fill rate: $beta = 99%$ (more demanding than CSL = 95%)

  *Step 1 — required loss-function value*

  $ L(z) = (1 - beta) Q / sigma_L = (1 - cm(0.99)) dot 775 / 18.7 = 0.414 $

  *Step 2 — invert the loss function*

  Looking up: $L(0.10) approx 0.351$, $L(0.05) approx 0.378$, $L(0.00) approx 0.399$, $L(-0.05) approx 0.421$.

  So $z approx -0.04$ gives $L(z) approx 0.414$. (For high fill rate, we'd usually expect $z > 0$ — but since $Q$ is much larger than $sigma_L$, even a *small* safety stock yields high fill rate. In some cases $z$ even goes *negative* for moderate fill rates.)

  *Step 3 — reorder point*

  $ r = mu_L + z sigma_L = 462 + (-0.04) dot 18.7 approx 461 $

  Almost no safety stock! Setting $r approx 461$ achieves 99% fill rate because the order quantity 775 is so large compared to lead-time variability 18.7 that stockouts are rare and small.

  *Step 4 — same setup, target CSL = 95%*

  Compare: CSL 95% would set $r = 493$ (safety stock 31). Fill rate at $r = 493$:
  $ z = (493 - 462) / 18.7 approx 1.66, quad L(1.66) approx 0.0207 $
  $ beta = 1 - 18.7 dot 0.0207 / 775 approx 1 - 0.0005 approx 99.95% $

  *Implication*: setting CSL to 95% gives a fill rate of essentially 100% in this regime. The CSL target is *much* more demanding than the fill-rate target for moderate-Q regimes.

  This explains why retailers usually quote fill rate (99%) rather than CSL (which would have to be e.g. 70% to give the equivalent operational meaning).
]
