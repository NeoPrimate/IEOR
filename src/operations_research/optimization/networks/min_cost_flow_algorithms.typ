#import "/lib/imports.typ": *
#show: formatting

Algorithms that solve the *minimum-cost flow* problem more efficiently than the generic LP. Given a network with arc capacities $u_(i j)$ and costs $c_(i j)$, find feasible flow satisfying supply / demand at minimum total cost.

For the problem formulation see #link(<operations-research-optimization-multi-commodity-network-flow>)[Min-cost flow LP].

== Negative-cycle canceling

*Idea*: start with any feasible flow. If the residual graph has a negative-cost cycle, push flow around it to lower the total cost. Repeat until no negative cycle exists → optimal.

```
Initialize x with any feasible flow (e.g., zero flow if no demand)
While residual graph has a negative-cost cycle C:
    delta ← min residual capacity along C
    push delta units around C
Return x
```

- *Correctness*: optimum ⇔ no negative-cycle in residual (by LP duality / Bellman-Ford optimality)
- *Complexity*: polynomial only with careful pivot rules (e.g., minimum-mean-cycle canceling, $O(V E^2 log V)$)
- *Use*: easy to implement, slow in practice for large instances

== Successive shortest paths (SSP)

*Idea*: route the flow one unit at a time along the *shortest path* in the residual network (using current reduced costs).

```
Initialize x = 0, π = 0 (node potentials), b' = b (residual supply)
While there is unsatisfied supply:
    Find shortest path P from a remaining source to a remaining sink in residual
    delta ← min residual capacity along P
    Push delta along P, update b'
    Update node potentials π to maintain non-negative reduced costs
```

- *Correctness*: maintains *optimality of the current flow* throughout — each new path is optimal augmentation
- *Complexity*: $O(V^2 U)$ with $U$ = max supply; or $O(V^2 E)$ with Dijkstra
- *Use*: efficient when supply is small or paths are short

== Cycle-canceling vs SSP

#table(
  columns: 3,
  align: (left, left, left),
  stroke: none,
  table.header([], [*Cycle-canceling*], [*SSP*]),
  [Starts from], [feasible flow], [zero flow],
  [Maintains], [feasibility], [optimality],
  [Iteration], [find negative cycle], [find shortest path],
  [Stops when], [no negative cycle], [supply satisfied],
  [Strongly polynomial?], [yes (with care)], [yes],
)

== Other methods

- *#link(<operations-research-optimization-network-simplex>)[Network simplex]* — specialization of simplex; very fast in practice
- *Out-of-kilter algorithm* — historical, more complex
- *Push-relabel* — efficient for max flow / min-cost extensions
- *Cost-scaling* — strongly polynomial, $O(V E log(V C))$

== Practical recommendation

For most instances, use *network simplex* (in commercial solvers like CPLEX, Gurobi, or open-source libraries). It's the standard production algorithm for MCNF.

== See also

- *#link(<operations-research-optimization-multi-commodity-network-flow>)[Min-Cost Flow]* — problem formulation
- *#link(<operations-research-optimization-network-simplex>)[Network Simplex]*
- *#link(<operations-research-optimization-network-flow>)[Network Flow]* — max-flow variant
- *#link(<algorithms-dijkstra>)[Dijkstra]* — shortest-path subroutine
