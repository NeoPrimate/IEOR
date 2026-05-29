#import "/lib/imports.typ": *
#show: formatting

The special case of the #link(<operations-research-optimization-transportation-problem>)[transportation problem] where $n$ agents are assigned to $n$ tasks one-to-one.

== Formulation

Cost $c_(i j)$ to assign agent $i$ to task $j$. Decision variable $x_(i j) in {0, 1}$.

$
  min sum_(i=1)^n sum_(j=1)^n c_(i j) x_(i j)
$

s.t.:

$
  sum_j x_(i j) = 1, #h(1em) i = 1, dots, n #h(2em) "(each agent gets one task)"
$

$
  sum_i x_(i j) = 1, #h(1em) j = 1, dots, n #h(2em) "(each task gets one agent)"
$

$
  x_(i j) in {0, 1}
$

== Unbalanced (dummy)

When agents and tasks differ in number ($n$ agents, $m$ tasks, $n > m$), not everyone can be assigned. Relax the agent constraint to $lt.eq$:

$
  &min   && sum_(i j) c_(i j) x_(i j) \
  &"s.t." && sum_j x_(i j) lt.eq 1 quad forall i quad "(agent does at most one task)" \
  &       && sum_i x_(i j) = 1 quad forall j quad "(every task is covered)" \
  &       && x_(i j) gt.eq 0
$

Equivalently, restore balance with a *dummy task* (column $m + 1$, zero cost) that absorbs the $n - m$ unassigned agents:

$
  &min   && sum_(i=1)^n sum_(j=1)^(m+1) c_(i j) x_(i j) \
  &"s.t." && sum_(j=1)^(m+1) x_(i j) = 1 quad forall i in {1, dots, n} \
  &       && sum_(i=1)^n x_(i j) = 1 quad forall j in {1, dots, m} \
  &       && sum_(i=1)^n x_(i, m+1) = n - m \
  &       && x_(i j) gt.eq 0
$

== LP relaxation gives integer solution

Constraint matrix is totally unimodular → LP relaxation has integer optimum. Can drop the binary constraint and solve as an LP; equivalently use the #link(<operations-research-optimization-hungarian-algorithm>)[Hungarian algorithm] in $O(n^3)$.

== Applications

- *Job-machine assignment* — minimize total processing time
- *Crew scheduling* — assign pilots to flights
- *Bipartite matching* — pair customers to drivers
- *Image processing / computer vision* — find correspondences between point sets
- *Subproblem* in branch-and-bound for VRP, TSP

== Generalizations

- *Generalized assignment* — costs and capacities, NP-hard
- *Quadratic assignment problem* — cost depends on pairs of assignments, NP-hard
- *Bottleneck assignment* — minimize *max* assignment cost (minimax variant)

== See also

- *#link(<operations-research-optimization-hungarian-algorithm>)[Hungarian Algorithm]* — the standard solver
- *#link(<operations-research-optimization-transportation-problem>)[Transportation Problem]* — the generalization
- *#link(<linear-algebra-unimodularity>)[Unimodularity]* — why LP relaxation works
