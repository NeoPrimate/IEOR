#import "/lib/imports.typ": *
#show: formatting

*Capacitated Facility Location Problem*: like #link(<operations-research-optimization-uflp>)[UFLP], but each facility has a maximum capacity it can serve.

== Formulation

Add capacity $u_j$ for each facility $j$. Customer $i$ has demand $d_i$.

$
  min sum_j f_j y_j + sum_i sum_j c_(i j) x_(i j)
$

s.t.:

$
  sum_j x_(i j) = 1, #h(1em) forall i #h(2em) "(customer fully served)"
$

$
  sum_i d_i x_(i j) <= u_j y_j, #h(1em) forall j #h(2em) "(capacity)"
$

$
  y_j in {0, 1}, #h(0.5em) x_(i j) in [0, 1] #h(0.5em) ("split delivery") "or" {0, 1} #h(0.5em) ("single sourcing")
$

== Picture

#let f1_color = blue
#let f2_color = green
#let over_color = red

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

#let cap_bar = (frac, col) => box(width: 64pt, height: 8pt, stroke: col + 0.4pt, radius: 1pt,
  clip: true, fill: white, inset: 0pt,
  align(left)[#box(width: 64pt * frac, height: 8pt, fill: col.lighten(20%))])

#frame(fletcher.diagram(spacing: 8pt,
  edge(<f1>,<c1>, stroke: f1_color),
  edge(<f1>,<c2>, stroke: f1_color),
  edge(<f1>,<c3>, stroke: f1_color),
  edge(<f2>,<c4>, stroke: over_color),
  edge(<f1>,<c5>, stroke: f1_color),
  edge(<f2>,<c6>, stroke: f2_color),
  edge(<f2>,<c7>, stroke: f2_color),
  edge(<f2>,<c8>, stroke: f2_color),
  edge(<f2>,<c9>, stroke: f2_color),

  customer(0.9,0.0, <c1>),
  customer(0.5,2.0, <c2>),
  customer(2.3,0.0, <c3>),
  customer(2.5,2., <c4>),
  customer(1.8,3.2, <c5>),
  customer(4.5,1.1, <c6>),
  customer(5.9,1.0, <c7>),
  customer(6.1,2.5, <c8>),
  customer(4.6,3.1, <c9>),

  facility(1.7,1.6, f1_color, "F1", <f1>),
  facility(5.2,2.0, f2_color, "F2", <f2>),

  node((1.7, 4.0), cap_bar(1.0, f1_color)),
  node((1.7, 4.45), text(size: 8pt, fill: f1_color)[capacity]),
  node((5.2, 4.0), cap_bar(0.6, f2_color)),
  node((5.2, 4.45), text(size: 8pt, fill: f2_color)[capacity]),
))

The red link marks an over-capacity assignment that forces a customer onto a farther facility.

== Two variants

*Split-delivery CFLP*: $x_(i j) in [0, 1]$ — a customer can be served by multiple facilities. LP relaxation is tractable.

*Single-source CFLP* ($x_(i j) in {0, 1}$): each customer goes to exactly one facility. *Much harder* — even checking feasibility is NP-hard.

== Why harder than UFLP

- *Capacity coupling*: opening a small far facility might be forced just to handle overflow from a nearby capacitated one
- *LP relaxation weaker* — capacity constraints reduce the integrality of the LP
- *No simple greedy approximation*

== Lagrangian relaxation

Standard solution approach (Geoffrion 1974):

1. *Dualize the customer-assignment constraints* $sum_j x_(i j) = 1$
2. The relaxed problem *decomposes* by facility — each facility solves a simple knapsack
3. Iteratively update Lagrange multipliers via subgradient method
4. Combine with branch-and-bound for the integer $y$

Gives strong bounds (often within 1-2% of optimum) and a feasible primal heuristic.

== Approximation

For *metric* CFLP, constant-factor approximations exist:

- *Local search* — Korupolu, Plaxton, Rajaraman: 7-approximation
- *Improved local search* — $5.83$-approximation (Chudak, Williamson)
- Current best (LP-rounding): $5$-approximation (Bansal-Garg-Gupta 2012)

Practical solvers (MIP, Lagrangian) usually beat the worst-case approximation by far on real instances.

== Where it shows up

- *Warehouse network design* — each DC has capacity (workforce, square footage, throughput)
- *Plant location* — plants have production limits
- *Cloud / data center sizing* — placement + capacity
- *Healthcare networks* — hospital bed capacity drives location choice

== See also

- *#link(<operations-research-optimization-uflp>)[UFLP]* — uncapacitated case
- *#link(<operations-research-optimization-facility-location>)[Facility Location overview]*
- *#link(<operations-research-optimization-lagrange-relaxation>)[Lagrange Relaxation]* — standard solution method
