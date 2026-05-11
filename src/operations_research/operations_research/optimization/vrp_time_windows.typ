#import "/lib/imports.typ": *

*VRP with Time Windows* (VRPTW): each customer $i$ specifies a *time window* $[a_i, b_i]$ during which service must begin.

The most common real-world VRP variant. Models meal delivery, parcel logistics, home services, dialysis transport, etc.

== Formulation additions

On top of #link(<operations-research-optimization-vrp>)[CVRP]:

Let $t_i$ = service start time at customer $i$, $s_i$ = service duration, $t_(i j)$ = travel time from $i$ to $j$.

*Time window constraints*:

$
  a_i <= t_i <= b_i, #h(1em) forall i
$

*Time propagation*:

$
  t_j >= t_i + s_i + t_(i j) - M (1 - x_(i j k))
$

(If vehicle $k$ goes $i -> j$, then $j$ is served at least $t_i + s_i + t_(i j)$.)

*Early arrival waiting* is usually allowed: arrive before $a_i$, wait, then serve at $a_i$.

== Hard vs soft windows

- *Hard windows*: $t_i in [a_i, b_i]$ strict — infeasibility if violated
- *Soft windows*: penalty for arriving outside the window, but feasible
- *Multiple windows*: a customer has several acceptable service intervals

Soft windows are easier to solve (relaxes infeasibility); hard windows model real commitments.

== Why VRPTW is much harder than CVRP

- *Tighter feasibility*: many tours that fit capacity violate time windows
- *Sequence-dependent feasibility*: $i -> j -> k$ may be infeasible even if each pair $i -> j$ and $j -> k$ is feasible alone
- *Larger LP relaxations*: more constraints, more weakening of bounds
- *Column generation* (the standard exact method) needs *Resource-Constrained Shortest Path* sub-problems — themselves NP-hard

== Solution methods

*Constructive*:
- *Solomon's insertion heuristic* (I1): build routes by inserting customers based on a parameterized "insertion cost"
- *Time-oriented nearest neighbor*

*Improvement*:
- *2-opt-star*: 2-opt that respects time windows
- *Or-opt*: move chains of 1-3 customers
- *Cross-exchange*: swap segments between routes

*Metaheuristics*:
- *ALNS* (Adaptive Large Neighborhood Search) — typically best in benchmarks
- *Tabu search*

*Exact*:
- *Branch-and-price-and-cut* with elementary RCSP sub-problems
- Solomon benchmark instances ($n = 100$): solved to optimality

== Applications

- *Food delivery* (DoorDash, Uber Eats): tight 30-60 min windows
- *Parcel last-mile* (FedEx, UPS): standard 9-5 windows, dense urban routing
- *Healthcare logistics*: dialysis pickup, home nursing
- *Cash-in-transit*: armored car pickups
- *Field service* (HVAC, telecom): morning / afternoon appointment windows

== See also

- *#link(<operations-research-optimization-vrp>)[VRP]* — without time windows
- *#link(<operations-research-optimization-tsp>)[TSP]* — single-vehicle ancestor
- *#link(<operations-research-optimization-clarke-wright>)[Clarke-Wright]* — initial routes
