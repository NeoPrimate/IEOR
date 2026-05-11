#import "/lib/imports.typ": *

A specialization of the #link(<operations-research-optimization-simplex-method>)[simplex method] for network flow problems (transportation, transshipment, min-cost flow). Exploits the *tree structure* of basic feasible solutions for $50-100times$ speed-up over generic simplex.

== Key insight: basis = spanning tree

For a network with $n$ nodes, a basic feasible solution corresponds to a *spanning tree* of the network (plus a choice of source / sink directions). There are $n - 1$ basic variables (one per tree arc), exactly matching the LP's basis dimension.

Non-basic arcs have flow zero or equal to their capacity.

== Why this matters

Operations that are $O(n^3)$ in general simplex become $O(n)$ on a tree:

- *Pivot* (replace one basic arc with one non-basic arc) → just update the tree path
- *Dual prices* → propagate from root to leaves of the tree
- *Reduced costs* → compute from dual prices via $bar(c)_(i j) = c_(i j) - pi_i + pi_j$

== Algorithm

```
Initialize a feasible spanning tree T (e.g., via big-M or two-phase)
While there exists a non-basic arc (i, j) with reduced cost < 0:
    Add (i, j) to T forming a cycle
    Push flow around the cycle until some basic arc hits zero or capacity
    Remove that arc from T (it leaves the basis)
Return optimal flow
```

== Complexity

- *In theory*: not polynomial (can cycle in degenerate cases without Bland-style rules)
- *In practice*: extremely fast — $O(n)$ to $O(n log n)$ per pivot, sub-linear pivots needed on real instances
- *State-of-the-art* MCNF solver in CPLEX, Gurobi, MINOS, etc.

== When to use

- *Min-cost flow* problems
- *Transportation / transshipment / assignment* (which are MCNF special cases)
- Always faster than generic LP simplex for network problems

== See also

- *#link(<operations-research-optimization-simplex-method>)[Simplex Method]* — the general parent
- *#link(<operations-research-optimization-multi-commodity-network-flow>)[Min-Cost Flow]* — problem solved
- *#link(<operations-research-optimization-transportation-problem>)[Transportation Problem]* — special case
- *#link(<operations-research-optimization-min-cost-flow-algorithms>)[Min-Cost Flow Algorithms]* — alternative methods
