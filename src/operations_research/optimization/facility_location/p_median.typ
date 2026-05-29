#import "/lib/imports.typ": *
#show: formatting

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

== Picture

Customer disc size $prop$ demand weight $d_i$ — $p = 2$ facilities chosen to minimize total weighted distance.

#let f1_color = blue
#let f2_color = green

#let customer = (x, y, name, w: 1, r: 5pt, col: gray.lighten(50%), bd: black) => node(
  (x, y), none,
  shape: circle, radius: (3 + w * 0.9) * 1pt,
  fill: col, stroke: bd + 0.4pt,
  name: name,
)

#let facility = (x, y, col, label, name) => node(
  (x, y),
  text(fill: col.darken(25%))[#label],
  shape: rect,
  width: 16pt,
  height: 16pt,
  corner-radius: 0.25em,
  fill: col.lighten(70%),
  stroke: col + 0.5pt,
  inset: 1pt,
  name: name
)

#frame(fletcher.diagram(spacing: 8pt,
  edge(<f1>,<c1>, stroke: f1_color),
  edge(<f1>,<c2>, stroke: f1_color),
  edge(<f1>,<c3>, stroke: f1_color),
  edge(<f1>,<c4>, stroke: f1_color),
  edge(<f1>,<c5>, stroke: f1_color),
  edge(<f2>,<c6>, stroke: f2_color),
  edge(<f2>,<c7>, stroke: f2_color),
  edge(<f2>,<c8>, stroke: f2_color),
  edge(<f2>,<c9>, stroke: f2_color),

  customer(0.9,0.0, <c1>, w: 5),
  customer(0.5,2.0, <c2>, w: 3),
  customer(2.3,0.0, <c3>, w: 0.5),
  customer(2.5,2., <c4>, w: 10),
  customer(1.8,3.2, <c5>, w: 1),
  customer(4.5,1.1, <c6>, w: 4),
  customer(5.9,1.0, <c7>, w: 0.5),
  customer(6.1,2.5, <c8>, w: 10),
  customer(4.6,3.1, <c9>, w: 5),

  facility(1.7,1.6, f1_color, "F1", <f1>),
  facility(5.2,2.0, f2_color, "F2", <f2>),

  node((1.7,3.9), text(size: 8pt, fill: f1_color)[open · serves 5]),
  node((5.2,3.9), text(size: 8pt, fill: f2_color)[open · serves 4]),
))

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
