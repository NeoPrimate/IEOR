#import "/lib/imports.typ": *

#let cm(x) = text(fill: red, [$#x$])

== Newsvendor with explicit shortage penalty

Relax one dimension from basic newsvendor: *excess demand* costs more than just lost margin. In the basic model, $C_u = P - C$ is the foregone profit on a missed sale. But stockouts often have *additional* costs — customer goodwill, expedited replacement, reputation damage, contractual penalties.

Add an *explicit penalty* $pi$ per unit of unmet demand, on top of lost margin.

=== Setup

Same as basic newsvendor, plus:
- $pi$ = stockout penalty per unmet unit (dollars per unsold-due-to-stockout)

Underage cost now has *two components*:

$ C_u = cm((P - C)) + cm(pi) $

The *form* of the answer is unchanged — only the value of $C_u$ is larger.

=== Critical ratio

$ "CR" = C_u / (C_u + C_o) = ((P - C) + pi) / ((P - C) + pi + (C - S)) $

A larger $C_u$ pushes CR upward → larger $z^*$ → larger $Q^*$. *More penalty for stocking out → order more.*

=== Bounds on CR

- $pi = 0$: collapses to basic newsvendor.
- $pi -> infinity$: $"CR" -> 1$ (almost certain to satisfy demand). $Q^*$ grows without bound.
- $pi$ very large but finite: $Q^*$ saturates at the upper tail of demand.

=== Decision rule (continuous demand)

$ Q^* = F^(-1)((P - C + pi) / (P - C + pi + C - S)) $

For normal demand $D tilde cal(N)(mu, sigma^2)$:

$ Q^* = mu + Phi^(-1)("CR") sigma $


#example[
  *Given* (same newspaper baseline + a $\$1$ goodwill penalty per missed sale):
  - Sale price: $P$ = \$3 / unit
  - Purchase cost: $C$ = \$1 / unit
  - Salvage: $S$ = \$0
  - Stockout penalty: $pi$ = \$1 / unit (lost goodwill)
  - Demand: $D tilde cal(N)(mu = 100, sigma = 20)$

  *Step 1 — underage and overage*

  $ C_u = (P - C) + cm(pi) = 2 + cm(1) = 3 $
  $ C_o = C - S = 1 $

  *Step 2 — critical ratio*

  $ "CR" = 3 / (3 + 1) = 0.75 $

  Compared to basic newsvendor ($"CR" = 2\/3 approx 0.667$), the penalty pushes CR from 67% up to 75%.

  *Step 3 — quantile and order quantity*

  $ z^* = Phi^(-1)(cm(0.75)) approx 0.674 $
  $ Q^* = 100 + cm(0.674) dot 20 approx 113 "newspapers" $

  *Step 4 — compare to basic newsvendor*

  Without penalty: $Q^*_"basic" approx 109$.
  With \$1 stockout penalty: $Q^*_pi approx 113$.

  *Order 4 more units* to buy down the goodwill cost. Doubling the penalty ($pi =$ \$2) would push $z^* approx 0.84$ and $Q^* approx 117$.

  The penalty acts like a *thumb on the scale* in favor of overstocking. In settings where stockouts are existential (medical supplies, contractual deadlines), $pi$ can dwarf $P - C$ and push the optimal $Q^*$ deep into the upper tail of demand.
]
