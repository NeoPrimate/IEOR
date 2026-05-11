#import "/lib/imports.typ": *

The data structure that represents multi-stage uncertainty in #link(<operations-research-optimization-stochastic-programming>)[stochastic programming]. A *branching tree* where each node represents a state of information at a point in time.

== Structure

- *Root*: initial state, $t = 0$, all decisions ahead
- *Internal nodes*: information realized so far at time $t$
- *Branches*: random outcomes from each node
- *Leaves*: complete realization paths from root to leaf

Each path from root to leaf is a *scenario*. The tree assigns probabilities to outcomes; each leaf's path-probability is the product of branch probabilities.

== Example: 3-stage tree

Stage 1 (root): uncertain demand $D_1 in {"high", "low"}$
Stage 2: uncertain interest rate $R_2 in {"up", "down"}$
Stage 3: terminal payoff depending on both

```
                       ┌── high R → leaf (D=high, R=up)
       ┌── D high (.6)─┤
       │              └── low R → leaf (D=high, R=down)
root ──┤
       │              ┌── high R → leaf (D=low, R=up)
       └── D low (.4)─┤
                      └── low R → leaf (D=low, R=down)
```

4 scenarios. Decisions at each node, conditional on the information available at that point.

== Non-anticipativity

A critical constraint: decisions at a node can depend *only* on information realized *up to that node*. Two scenarios sharing a prefix must have *identical* decisions for that prefix.

Formally: $x_t^"scenario A" = x_t^"scenario B"$ if A and B agree up to stage $t$.

Implementation:
- *Per-node variables* (vs per-scenario): naturally encodes non-anticipativity
- *Per-scenario variables with explicit constraints*: $x_t^s = x_t^("s'")$ for $s, s'$ in the same subtree
- *Progressive hedging*: dualize the non-anticipativity to decompose

== Curse of dimensionality

Number of leaves = $product$ of branching factors. A 5-stage tree with 5 outcomes per stage has $5^5 = 3,125$ leaves; with 10 outcomes, $10^5 = 100,000$ leaves.

Mitigations:

- *Scenario reduction* — cluster similar scenarios, pick representative ones (Heitsch-Römisch)
- *Sampling* — Monte Carlo-style — see #link(<operations-research-optimization-sample-average-approximation>)[SAA]
- *Decomposition* — solve subproblems per scenario, coordinate via Lagrangian (PH, SDDP)
- *Approximate dynamic programming*

== Where it shows up

- *Investment planning* — multi-year capital allocation under uncertain returns
- *Power systems* — unit commitment under stochastic demand & renewables
- *Supply chain network design* — multi-year facility planning
- *Financial planning* — asset-liability matching for pensions / insurance
- *Inventory* — multi-period stochastic inventory

== See also

- *#link(<operations-research-optimization-stochastic-programming>)[Stochastic Programming]* — broader framework
- *#link(<operations-research-optimization-two-stage-recourse>)[Two-stage Recourse]* — simplest case
- *#link(<operations-research-optimization-sample-average-approximation>)[SAA]* — Monte Carlo approximation
- *#link(<operations-research-optimization-dynamic-programming>)[Dynamic Programming]* — alternative view
