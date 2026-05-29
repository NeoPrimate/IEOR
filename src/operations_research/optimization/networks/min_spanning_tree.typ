#import "/lib/imports.typ": *
#show: formatting

Given a connected, undirected, weighted graph, find a *spanning tree* (acyclic connected subgraph touching every vertex) of minimum total edge weight.

== Two classic algorithms

*Kruskal's algorithm* (1956): edge-based, $O(E log E)$
```
Sort edges by weight ascending
Initialize T = empty (every node is its own component)
For each edge (u, v) in sorted order:
    If u and v are in different components:
        Add (u, v) to T
        Merge their components
Return T
```

*Prim's algorithm* (1957): vertex-based, $O((V + E) log V)$ with binary heap, $O(E + V log V)$ with Fibonacci heap
```
Initialize T = {arbitrary starting vertex}
While T doesn't span the graph:
    Find min-weight edge (u, v) with u ∈ T, v ∉ T
    Add v and edge (u, v) to T
Return T
```

== Why it's MST (correctness)

The *cut property*: for any cut of the graph, the minimum-weight edge crossing the cut belongs to some MST. Both Kruskal and Prim repeatedly select such cut-crossing minimum edges.

The *cycle property*: for any cycle, the maximum-weight edge does *not* belong to any MST. (Kruskal implicitly enforces this by skipping cycle-creating edges.)

== Properties

- *Unique MST* iff all edge weights are distinct
- *Tree*: $V - 1$ edges, no cycles
- *Total weight*: sum of MST edges; minimum among all spanning trees
- *Multiple MSTs*: with ties, any choice that breaks cycles consistently gives the same total weight

== Where it shows up

- *Network design*: minimum-cost wiring / connection (telephone, power, road)
- *Clustering*: single-linkage clustering = MST then prune longest edges
- *Approximation algorithms*: 2-factor approx for metric #link(<operations-research-optimization-tsp>)[TSP] uses MST traversal; #link(<operations-research-optimization-christofides>)[Christofides] is more refined
- *Image segmentation*: graph cuts based on MST

== Comparison

#table(
  columns: 3,
  align: (left, left, left),
  stroke: none,
  table.header([], [*Kruskal*], [*Prim*]),
  [Data structure], [union-find], [priority queue],
  [Best for], [sparse graphs], [dense graphs],
  [Complexity], [$O(E log E)$], [$O(E + V log V)$ (Fibonacci)],
  [Online use], [needs all edges upfront], [grows tree from any start],
)

== See also

- *#link(<operations-research-optimization-tsp>)[TSP]* — uses MST in lower bounds & approximations
- *#link(<operations-research-optimization-floyd-warshall>)[Floyd-Warshall]* — all-pairs shortest path (related)
- *#link(<algorithms-dijkstra>)[Dijkstra]* — single-source shortest path (related, different structure)
