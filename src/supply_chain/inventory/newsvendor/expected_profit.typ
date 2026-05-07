#import "/lib/imports.typ": *

#let cm(x) = text(fill: red, [$#x$])

== Expected profit and lost sales (newsvendor)

This file doesn't relax a dimension — it computes *additional outputs* of the standard newsvendor model. Once you have $Q^*$, what's the expected profit, expected leftovers, expected lost sales? The answer for normal demand uses the *standard normal loss function*.

=== Setup

Same as basic newsvendor: $D tilde cal(N)(mu, sigma^2)$, decision $Q$, prices $P, C, S$.

Define the *standard normal loss function*:

$ L(z) = phi(z) - z dot (1 - Phi(z)) $

where $phi$ is the standard normal density, $Phi$ the CDF. $L(z)$ measures the expected shortfall above $z$ for a standard normal — equivalently, $E[(Z - z)^+]$.

Properties:
- $L(0) approx 0.399$
- $L(z) -> 0$ as $z -> infinity$ (no shortfall expected far in the upper tail)
- $L(z) -> -z$ as $z -> -infinity$ (everything below is "missed demand" if you over-order huge)

For computation, $L(z)$ is tabulated or computed numerically.

=== Expected lost sales

For demand $D = mu + sigma Z$ where $Z tilde cal(N)(0, 1)$, lost sales when $D > Q$ amount to $D - Q$. In standard-normal units, $z = (Q - mu) / sigma$:

$ E["lost sales"] = E[(D - Q)^+] = sigma dot cm(L(z)) $

This is the *expected shortfall* in actual units — multiply $L(z)$ by $sigma$ to scale back from standard normal.

=== Expected leftovers

By symmetry, expected leftovers $= E[(Q - D)^+]$. By inventory balance:

$ E[(Q - D)^+] = (Q - mu) + E[(D - Q)^+] = (Q - mu) + sigma L(z) $

=== Expected sales

$ E["sales"] = E[min(D, Q)] = mu - sigma L(z) $

(Total demand $mu$ minus the part that wasn't satisfied.)

=== Expected profit

Per-unit revenue components:
- Sales bring in $P - C$ profit (margin) per unit sold.
- Leftovers: bought at $C$, salvaged at $S$, so loss = $C - S$ per leftover.

$
  E[Pi] = cm((P - C)) E["sales"] - cm((C - S)) E["leftovers"]
$

Expand:

$
  E[Pi] = (P - C)(mu - sigma L(z)) - (C - S)((Q - mu) + sigma L(z))
$

Plug in $Q = mu + z sigma$:

$
  E[Pi] = (P - C)(mu - sigma L(z)) - (C - S)(z sigma + sigma L(z))
$
$
  E[Pi] = (P - C) mu - sigma [(P - C) L(z) + (C - S)(z + L(z))]
$
$
  E[Pi] = (P - C) mu - sigma [(P - S) L(z) + (C - S) z]
$

The first term is the *deterministic-demand profit* (sell exactly $mu$ units at margin $P - C$). The second is the *stochastic penalty* — the cost of demand uncertainty, scaled by $sigma$.

=== Bounded loss from uncertainty

For any $z$, the penalty $sigma [(P - S) L(z) + (C - S) z]$ is *minimized* exactly when $z = z^* = Phi^(-1)("CR")$. So the optimal newsvendor minimizes the cost of uncertainty given the cost structure.


#example[
  *Given* (same newspaper baseline):
  - $P = 3$, $C = 1$, $S = 0$
  - $D tilde cal(N)(100, 20^2)$
  - $C_u = 2$, $C_o = 1$, $"CR" = 2\/3$, $z^* = 0.44$, $Q^* approx 109$

  *Step 1 — loss-function value*

  At $z = z^* = 0.44$:
  $ L(0.44) = phi(0.44) - 0.44 dot (1 - Phi(0.44)) approx 0.362 - 0.44 dot 0.330 approx 0.218 $

  *Step 2 — expected lost sales*

  $ E["lost sales"] = sigma dot L(z^*) = 20 dot cm(0.218) approx 4.4 "newspapers" $

  Even at the optimum, expect about 4 missed sales per period.

  *Step 3 — expected leftovers*

  $ E["leftovers"] = (Q^* - mu) + sigma L(z^*) = (109 - 100) + 20 dot 0.218 approx 9 + 4.4 = 13.4 $

  *Step 4 — expected sales*

  $ E["sales"] = mu - sigma L(z^*) = 100 - 4.4 approx 95.6 "newspapers" $

  *Step 5 — expected profit*

  $ E[Pi] = (P - C) E["sales"] - (C - S) E["leftovers"] $
  $ = 2 dot 95.6 - 1 dot 13.4 = 191.2 - 13.4 approx $ \$177.8 / period

  *Compare to deterministic-demand profit*

  If demand were exactly $mu = 100$ every period:
  $ Pi_"det" = (P - C) dot mu = 2 dot 100 = $ \$200 / period

  The *cost of uncertainty* is $200 - 177.8 =$ \$22.2 / period — that's the gap between what you could earn knowing demand exactly vs. what the optimal newsvendor strategy actually earns under the given $sigma = 20$. Reducing demand uncertainty (better forecasting) directly recoups this gap.
]
