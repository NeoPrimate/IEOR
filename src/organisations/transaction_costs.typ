=== Transaction Costs

// @coase1937 @williamson1975 @williamson1985



Why do firms / organizations exist? Why not many atomized individuals (market)?

Why are there hierarchies (firms / organizations) in markets?

Hierarchy or Market? Make or Buy?
Which transactions should be included in the hierarchy, which transactions should be left to the market?

Unit of analysis: Transaction
Relation (networks)

Traditional assumption:
Using the market has no cost (frictionless)

If trust there would be no cost
But the risk of opportunism, shirking exists

Therefore, there are costs:
- Search
- Bargaining
- Monitoring / Enforcement: ensuring that the terms of the agreement are being fulfilled (inspection, quality control, and supervision)
- Information: expenses incurred in acquiring, processing, and disseminating information relevant to the transaction
- Coordination
- Adaptation

Costs are a function of:
- Asset Specificity
- Uncertainty
- Frequency



Efficient alignment hypothesis:
Transactions, which vary in their characteristics, should be matched with governance structures that differ in their costs and competencies. Alignment aims to minimize transactions costs.

Questions:

- For you which transactions should be included in the hierarchy and which should be left to the market?
- Furthermore, which transactions included in hierarchies should be in public hierarchies and which in private hierarchies?
- How can this transaction sort approaches be used to predict end symbiosis?

#line(length: 100%)

Let the set of transcations be $T = {1, 2, dots, n}$
For each transaction $i in T$, define:

- $C_i^M$: transaction cost if done via *Market*
- $C_i^H$: transaction cost if done via *Hierarchy*

Then the total cost accross all transactions is:

$
  T C = sum_(i=1)^n min{C_i^M, C_i^H}
$

We want to choose the governance $g_i in {M, H}$ for each $i$ that minimized total transaction cost

Transaction costs can be modeled as a function of key characteristics

$
  C_i^g = f^g(S_i, U_i, F_i)
$

Where:
- $S_i$: asset specificity
- $U_i$: Uncertainty
- $F_i$: frequency
- $g$: governance structure ($M$, $H$)

Assumptions

$
  C_i^M &= alpha_M + beta_M S_i + gamma_M U_i + delta_M F_i \
  C_i^H &= alpha_H + beta_H S_i + gamma_H U_i + delta_H F_i \
$

Where coefficients reflect *how sensitive each governance mode is to specificity, uncertainty, and frequency*. For instance:
- Market is cheap for low specificity, low uncertainty, low frequency
- Hierarchy becomes cheaper as specificity, uncertainty, or frequency increase

Then the optimal governance for transaction $i$ is:

$
  g_i^* = arg min_(g in {M, H}) C_i^g (S_i, U_i, F_i)
$

So, for each transaction, compute the three potential costs and pick the governance mode with the lowest cost

Symbiosis prediction

Symbiosis arises when two transactions are co-dependent and jointly internalized in the hierarchy:
- Let $i$ and $j$ be linked transactions
- Joint transaction cost:

$
  C_(i j)^"joint" lt C_i^M + C_j^M
$

If this inequality holds, hierarchy creates a *net benefit*, predicting *stable interdependence*, i.e., symbiosis

