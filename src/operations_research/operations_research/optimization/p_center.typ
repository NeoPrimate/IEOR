#import "/lib/imports.typ": *

*$p$-Center Problem*: place $p$ facilities to *minimize the maximum* distance any customer must travel to its nearest facility. A *minimax* objective — focuses on the worst-served customer, not average.

== Formulation

$
  min_(y, x, z) #h(0.5em) z
$

s.t.:

$
  z >= sum_j c_(i j) x_(i j), #h(1em) forall i #h(2em) "(z bounds max assigned distance)"
$

$
  sum_j x_(i j) = 1, #h(1em) forall i
$

$
  x_(i j) <= y_j, #h(0.5em) sum_j y_j = p, #h(0.5em) y_j in {0, 1}
$

Variable $z$ is the maximum cost; minimizing $z$ subject to constraints is *minimax*.

== Why minimax matters

- *Emergency services*: response time to the worst-located resident matters more than average
- *Equity*: avoid concentrating service in dense areas at the expense of remote customers
- *Service-level agreements*: "no customer more than $X$ miles away" is a hard constraint

vs *$p$-median* (#link(<operations-research-optimization-p-median>)[$p$-median]) which minimizes *total* (= average × N) distance.

== Solution methods

*Decision-version* of $p$-center: "is there a placement with max distance $<= r$?" This is a *#link(<operations-research-optimization-set-covering>)[set covering] problem*: each facility covers all customers within $r$, and you need $p$ facilities whose covers union to the full customer set.

*Algorithm*: binary search on $r$.

1. Sort all distinct $c_(i j)$ values
2. Binary search: for candidate $r$, check if a feasible $p$-coverage exists (set covering feasibility)
3. The smallest feasible $r$ is the optimum

Set covering itself is NP-hard, so this gives an *NP-hard subroutine* — but the binary search keeps the number of feasibility checks small.

== Approximation

For *metric* $p$-center (triangle inequality), 2-approximation is achievable (Hochbaum-Shmoys 1985): greedy farthest-first.

```
Choose first facility: any node
Repeat p-1 times:
    Choose the unselected node FARTHEST from all already-selected facilities
```

This achieves max distance $<= 2 dot $ OPT. Tight — no better than 2 is possible unless P = NP.

== Applications

- *Fire / ambulance station placement* — minimize worst-case response time
- *Distribution center location* under SLA — "all customers within 200 miles"
- *Schools* — equitable access (no child more than $X$ miles)
- *Cellular networks* with coverage radius

== See also

- *#link(<operations-research-optimization-p-median>)[$p$-median]* — total-distance variant
- *#link(<operations-research-optimization-set-covering>)[Set Covering]* — the feasibility subproblem
- *#link(<operations-research-optimization-facility-location>)[Facility Location overview]*
