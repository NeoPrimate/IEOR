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
