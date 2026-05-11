#import "/lib/imports.typ": *

*$p$-Median Problem*: place exactly $p$ facilities among candidates to minimize the *total* assigned distance / cost. No fixed facility cost — the constraint is "exactly $p$".

== Formulation

Choose $p$ facilities from candidate set $J$ to minimize:

$
  min sum_i d_i sum_j c_(i j) x_(i j)
$

s.t.:

$
  sum_j x_(i j) = 1, #h(1em) forall i
$

$
  x_(i j) <= y_j, #h(1em) forall i, j
$

$
  sum_j y_j = p
$

$
  y_j in {0, 1}, #h(0.5em) x_(i j) >= 0
$

(Here $d_i$ is the demand weight of customer $i$.)

== Difference from UFLP

- *#link(<operations-research-optimization-uflp>)[UFLP]*: facility costs are *variable* — pay $f_j$ to open. Optimizer picks the right number.
- *$p$-Median*: exactly $p$ facilities — number is fixed by the problem. No per-facility fixed cost.

In practice, the two are related: solving $p$-median for varying $p$ traces out the *cost-vs-number-of-facilities* trade-off curve that UFLP would balance via the fixed costs.

== Solution methods

NP-hard. Methods:

- *Branch-and-bound on MIP*
- *LP relaxation* — strong; relaxation often gives integer optima
- *Lagrangian relaxation* — dualize $sum_j y_j = p$ to get $p$-median dualizing the cardinality
- *Greedy / interchange heuristics* (Teitz-Bart, swap-based local search)
- *Approximation*: 3-approximation for *metric* $p$-median (Lin-Vitter, Charikar-Guha)

== Applications

- *Distribution center placement* — find best $p$ of $n$ candidates
- *Service location* — fire stations, branches
- *Cell phone tower placement* — when budget fixes count $p$
- *Vendor consolidation* — pick $p$ suppliers from larger pool

== Variants

- *Continuous $p$-median* (1-median = #link(<operations-research-optimization-center-of-gravity>)[center of gravity]; multi-facility versions: Weiszfeld iteration generalized)
- *$p$-center* (#link(<operations-research-optimization-p-center>)[$p$-center]) — minimize *max* distance instead of total
- *Capacitated $p$-median* — facilities have capacity limits
- *Multi-objective* — trade off coverage / equity / total cost

== See also

- *#link(<operations-research-optimization-uflp>)[UFLP]* — variable count, fixed costs
- *#link(<operations-research-optimization-p-center>)[$p$-center]* — minimax variant
- *#link(<operations-research-optimization-center-of-gravity>)[Center of Gravity]* — $p = 1$ continuous case
- *#link(<operations-research-optimization-facility-location>)[Facility Location overview]*
