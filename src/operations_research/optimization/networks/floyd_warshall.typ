#import "/lib/imports.typ": *
#show: formatting

*All-pairs shortest path* algorithm — finds the shortest distance from every node to every other node in $O(V^3)$.

Useful when you need the distance matrix for *many* queries, vs running #link(<algorithms-dijkstra>)[Dijkstra] from each source ($O(V (V+E) log V)$).

== Algorithm

Dynamic programming. Let $d_k (i, j)$ = shortest path from $i$ to $j$ using only intermediate nodes from $\{1, dots, k\}$:

$
  d_k (i, j) = min(d_(k-1) (i, j), #h(0.5em) d_(k-1) (i, k) + d_(k-1) (k, j))
$

Either use node $k$ as a stop (split at $k$) or don't (same path).

```
Initialize D[i][j] = edge weight (or ∞ if no edge), D[i][i] = 0
For k = 1, 2, …, V:
    For i = 1, …, V:
        For j = 1, …, V:
            D[i][j] ← min(D[i][j], D[i][k] + D[k][j])
Return D
```

Three nested loops → $O(V^3)$. Space $O(V^2)$ (the matrix). Update in place — no need for separate "old" and "new" matrices.

== Edge cases

- *Negative edges*: handled (unlike Dijkstra)
- *Negative-cycle detection*: after the run, if any $D[i][i] < 0$, the graph has a negative cycle reachable from $i$
- *Disconnected nodes*: stay at $infinity$

== Compared to single-source alternatives

#table(
  columns: 4,
  align: (left, center, center, center),
  stroke: none,
  table.header([], [*Floyd-Warshall*], [*$V$ × Dijkstra*], [*$V$ × Bellman-Ford*]),
  [All-pairs cost], [$O(V^3)$], [$O(V (V+E) log V)$], [$O(V^2 E)$],
  [Negative edges?], [yes], [no], [yes],
  [Memory], [$O(V^2)$], [$O(V^2)$], [$O(V^2)$],
  [Dense graphs ($E approx V^2$)], [$O(V^3)$ — best], [$O(V^3 log V)$], [$O(V^4)$],
  [Sparse graphs ($E approx V$)], [$O(V^3)$], [$O(V^2 log V)$ — best], [$O(V^3)$],
)

Floyd-Warshall is best for *dense* graphs with potentially negative edges.

== Path reconstruction

To recover paths (not just distances), maintain a *predecessor* matrix $pi[i][j]$ alongside $D$:

```
When updating D[i][j] via D[i][k] + D[k][j]:
    π[i][j] ← π[k][j]
```

Then trace back from $j$ to $i$ via $pi$.

== Applications

- *Network routing*: distance tables for routing protocols
- *Logistics*: precompute shipping costs between all warehouses
- *Game AI / graph queries*: when distance matrix is queried millions of times
- *Transitive closure*: same algorithm with boolean OR / AND replaces min / +

== See also

- *#link(<algorithms-dijkstra>)[Dijkstra]* — single-source, non-negative edges
- *#link(<operations-research-optimization-dynamic-programming>)[Dynamic Programming]* — the framework
- *#link(<operations-research-optimization-min-spanning-tree>)[Min Spanning Tree]* — different problem, related techniques
