#import "/lib/imports.typ": *
#show: formatting

Generalization of the #link(<operations-research-optimization-transportation-problem>)[transportation problem] allowing *intermediate transshipment nodes* — locations that neither produce nor consume, but pass flow through.

== Formulation

Three node types:
- *Supply* nodes ($b_i > 0$): produce $b_i$ units
- *Demand* nodes ($b_i < 0$): consume $|b_i|$ units
- *Transshipment* nodes ($b_i = 0$): inflow = outflow

For each arc $(i, j) in E$, decision $x_(i j) >= 0$ = flow on arc, with cost $c_(i j)$ per unit.

$
  min sum_((i, j) in E) c_(i j) x_(i j)
$

s.t. flow conservation at each node:

$
  sum_(j: (j, i) in E) x_(j i) - sum_(j: (i, j) in E) x_(i j) = -b_i, #h(1em) forall i in V
$

(Inflow minus outflow = $-b_i$: positive for sinks, negative for sources, zero for transshipment.)

== Capacitated variant

Now cap each arc: flow can't exceed an edge's capacity $u_(i j)$. Same objective and conservation, plus a per-arc upper bound:

$
  min sum_((i, j) in E) c_(i j) x_(i j)
$

$
  sum_(j: (j, i) in E) x_(j i) - sum_(j: (i, j) in E) x_(i j) = -b_i, #h(1em) forall i in V
$

$
  colorMath(0 <= x_(i j) <= u_(i j), #red), #h(1em) forall (i, j) in E
$

- lower bound $0$: no reverse flow on the arc
- upper bound $u_(i j)$: the arc can't carry more than its capacity

== Reduction to transportation problem

Any transshipment problem with $n$ nodes can be converted into a transportation problem on a complete bipartite graph (every source potentially connects to every demand via possible transshipment paths) — at the cost of larger problem size.

In practice solve directly as an LP, or use #link(<operations-research-optimization-network-simplex>)[network simplex].

== Why it matters

The transshipment formulation is the *canonical model* for:

- *Multi-echelon distribution*: factory → DC → store
- *Hub-and-spoke networks*: airlines, parcel logistics
- *Inter-regional sourcing*: route through cheapest intermediate even when not on the direct path
- *Min-cost flow generalization* — see #link(<operations-research-optimization-multi-commodity-network-flow>)[MCNF]

== See also

- *#link(<operations-research-optimization-transportation-problem>)[Transportation Problem]* — special case (no intermediates)
- *#link(<operations-research-optimization-multi-commodity-network-flow>)[Multi-Commodity Network Flow]*
- *#link(<operations-research-optimization-network-simplex>)[Network Simplex]*
