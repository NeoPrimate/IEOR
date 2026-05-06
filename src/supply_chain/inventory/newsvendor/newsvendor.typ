#import "/src/imports.typ": *

#let cm(x) = text(fill: red, [$#x$])

== Newsvendor

Single-period inventory under uncertain demand: order $Q$ *before* seeing demand. After demand realizes, leftover stock is salvaged at $S < C$, and unmet demand is lost.

The trade-off:
- Order *too much* → leftovers, lose $C - S$ per unsold unit.
- Order *too little* → stockouts, lose $P - C$ per missed sale.

=== Assumptions

- Single period (no carryover to next period)
- Single product
- Demand $D$ is random with known distribution $F$
- Lead time is zero — receive order before demand realizes
- Linear underage and overage costs

=== Setup

- $P$ = sale price per unit
- $C$ = purchase cost per unit
- $S$ = salvage value per unsold unit (with $S < C$)
- $D$ = random demand, with CDF $F(d) = P(D lt.eq d)$ and density $f$
- $Q$ = order quantity (decision variable)

Define:
- *Underage cost* (lost margin per missed sale): $C_u = cm(P - C)$
- *Overage cost* (loss per unsold unit): $C_o = cm(C - S)$

=== Derive $Q^*$ via marginal analysis

Imagine we've decided to order $Q$ units. Should we order one more?

The $(Q+1)$-th unit either *sells* or *doesn't*:
- It *sells* if demand exceeds $Q$, with probability $cm(P(D > Q)) = cm(1 - F(Q))$. Profit: $C_u$ per unit (margin we'd otherwise lose).
- It *doesn't sell* if demand $lt.eq Q$, with probability $cm(F(Q))$. Cost: $C_o$ per unit (overage).

*Expected marginal profit* of ordering one more unit:

$ Delta(Q) = cm((1 - F(Q))) C_u - cm(F(Q)) C_o $

Order more units while $Delta(Q) > 0$, stop when $Delta(Q) = 0$:

$ (1 - F(Q^*)) C_u = F(Q^*) C_o $
$ C_u - F(Q^*) C_u = F(Q^*) C_o $
$ C_u = F(Q^*) (C_u + C_o) $
$ F(Q^*) = cm(C_u / (C_u + C_o)) $

This ratio is the *critical ratio* (CR). Read it as: "What probability of *not* stocking out balances the two costs?"

=== Inverting $F$ to get $Q^*$

$ Q^* = F^(-1)("CR") = F^(-1)(C_u / (C_u + C_o)) $

For *any* demand distribution, the recipe is the same: compute CR, look up the quantile.

=== Normal demand specialization

If $D tilde cal(N)(mu, sigma^2)$, write $Q^* = mu + z^* sigma$ where $z^* = Phi^(-1)("CR")$ is the standard-normal quantile of CR.

Common $z^*$ values:
- $"CR" = 0.5$ → $z^* = 0.00$ (order the median)
- $"CR" = 0.67$ → $z^* approx 0.44$
- $"CR" = 0.84$ → $z^* approx 1.00$
- $"CR" = 0.95$ → $z^* approx 1.65$
- $"CR" = 0.99$ → $z^* approx 2.33$

When $C_u >> C_o$ (stockouts much worse than leftovers), CR $-> 1$ and $z^*$ pushes you to over-stock. Conversely when $C_o >> C_u$, CR $-> 0$ and $z^* < 0$ (under-stock the median).


#example[
  *Given* (newsstand selling newspapers):
  - Sale price: $P$ = \$3 / unit
  - Purchase cost: $C$ = \$1 / unit
  - Salvage value: $S$ = \$0 / unit (unsold papers worthless)
  - Demand: $D tilde cal(N)(mu = 100, sigma = 20)$

  *Step 1 — underage and overage*

  $ C_u = cm(P - C) = cm(3 - 1) = 2 quad ("\\$/unsold-demand-unit") $
  $ C_o = cm(C - S) = cm(1 - 0) = 1 quad ("\\$/leftover") $

  *Step 2 — critical ratio*

  $ "CR" = C_u / (C_u + C_o) = cm(2) / (cm(2) + cm(1)) = 2 / 3 approx 0.667 $

  Each unit ordered should have a $approx 67%$ chance of selling — overstocking is twice as cheap as stocking out.

  *Step 3 — quantile lookup*

  For normal demand, $z^* = Phi^(-1)(0.667) approx 0.44$:

  $ Q^* = mu + z^* sigma = cm(100) + cm(0.44) dot cm(20) approx 109 "newspapers" $

  *Step 4 — interpret*

  At $Q^* approx 109$: about a $67%$ chance of selling out (matching CR), $33%$ chance of leftovers. Sensible because the underage cost ($C_u = 2$) is twice the overage cost ($C_o = 1$) — the optimum biases toward stocking *more* than the mean (100).
]

#code(
  "newsvendor.py",
  ```py
  import scipy.stats as stats

  P, C, S = 3, 1, 0  # sale price, purchase cost, salvage value
  mu, sigma = 100, 20  # demand mean and standard deviation

  C_u = P - C  # underage cost
  C_o = C - S  # overage cost
  CR = C_u / (C_u + C_o)  # critical ratio

  z_star = stats.norm.ppf(CR)  # quantile
  Q_star = mu + z_star * sigma
  ```,
)
