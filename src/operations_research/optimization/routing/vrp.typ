#import "/lib/imports.typ": *
#show: formatting

= VRP <operations_research_optimization_routing_vrp>

The *Vehicle Routing Problem*: given a fleet of vehicles based at a depot, serve a set of customers with minimum total cost (distance / time). Generalization of #link(<operations_research_optimization_routing_tsp>)[TSP] to multiple vehicles.

Core supply-chain problem: last-mile delivery, beverage distribution, waste collection, school bus routing, mobile maintenance.

== Capacitated VRP (CVRP)

Standard formulation. Each vehicle has capacity $Q$. Each customer $i$ has demand $q_i$.

Decision variable $x_(i j k)$: $1$ if vehicle $k$ traverses arc $(i, j)$.

$
  min sum_k sum_(i, j) c_(i j) x_(i j k)
$

s.t.:

- Each customer visited exactly once
- Vehicle starts and ends at the depot
- Total demand on each vehicle's route $<= Q$
- Subtour elimination (like TSP)

== Why it's harder than TSP

- *NP-hard* even worse than TSP (TSP is the single-vehicle case)
- *Combinatorial explosion*: must simultaneously partition customers into routes *and* route each
- *Exponential* number of subtour constraints, plus capacity constraints

== Variants

- *VRP-TW (with time windows)* — each customer has a delivery window $[a_i, b_i]$; see #link(<operations_research_optimization_routing_vrp_time_windows>)[VRPTW]
- *Pickup-and-delivery VRP* (PDVRP) — pickups must precede deliveries on the same route
- *Heterogeneous fleet VRP* — vehicles with different capacities / costs
- *Stochastic VRP* — random demand or travel times
- *Periodic VRP* — multi-day delivery schedules with frequency constraints
- *Open VRP* — vehicles don't return to depot (typical for last-mile contractors)
- *Multi-depot VRP* — vehicles from multiple depots

== Solution methods

*Exact* (small instances, $n <= 200$):
- *Branch-and-cut* on the LP formulation
- *Branch-and-price* (column generation)
- *Dynamic programming* for very small fleets

*Heuristics*:
- *Constructive*: #link(<operations_research_optimization_routing_clarke_wright>)[Clarke-Wright savings] (the classic), Sweep, Fisher-Jaikumar
- *Improvement*: 2-opt, Or-opt, 3-opt within routes; inter-route swaps
- *Metaheuristics*: tabu search, simulated annealing, genetic algorithms, large-neighborhood search
- *Modern*: Adaptive Large Neighborhood Search (ALNS), HGS (Hybrid Genetic Search)

*Open-source solvers*:
- *OR-Tools* (Google) — fast LS-based heuristics
- *VROOM* — open-source CVRP / VRPTW solver
- *VRPSolver* — academic branch-cut-price

== Continuous approximation

For large-scale VRP design (how many vehicles? how big are routes?), *Daganzo's continuous approximation* gives clean formulas. See #link(<operations_research_optimization_routing_daganzo_continuous>)[Daganzo].

== See also

- *#link(<operations_research_optimization_routing_tsp>)[TSP]* — single-vehicle case
- *#link(<operations_research_optimization_routing_vrp_time_windows>)[VRPTW]* — with time windows
- *#link(<operations_research_optimization_routing_clarke_wright>)[Clarke-Wright]* — standard heuristic
- *#link(<operations_research_optimization_routing_daganzo_continuous>)[Daganzo Continuous Approximation]*
- *#link(<operations_research_optimization_networks_assignment_problem>)[Assignment Problem]* — sub-problem in some methods
