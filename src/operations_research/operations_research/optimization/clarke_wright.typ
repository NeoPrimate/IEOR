#import "/lib/imports.typ": *
#show: formatting

The *savings algorithm* (Clarke & Wright, 1964) — the classical constructive heuristic for #link(<operations-research-optimization-vrp>)[VRP]. Simple, fast, surprisingly good for capacitated VRP.

== The savings concept

Two single-customer routes: depot $-> i ->$ depot and depot $-> j ->$ depot. Cost = $2 c_(0 i) + 2 c_(0 j)$.

Merge into depot $-> i -> j ->$ depot. Cost = $c_(0 i) + c_(i j) + c_(0 j)$.

*Saving*:

$
  s_(i j) = (2 c_(0 i) + 2 c_(0 j)) - (c_(0 i) + c_(i j) + c_(0 j)) = c_(0 i) + c_(0 j) - c_(i j)
$

By triangle inequality $s_(i j) >= 0$. Large savings → customers $i$ and $j$ are close to each other and far from the depot.

== Algorithm

```
Initialize: one route per customer (depot → i → depot)
Compute s[i,j] for all pairs and sort descending
For each (i, j) in sorted order:
    If merging routes containing i and j is feasible:
        - i and j must be on the same "endpoint" of their routes
        - i and j must be on different routes (not the same one)
        - Merged route's total demand ≤ Q (capacity)
    Then merge them
Return routes
```

Sort: $O(n^2 log n)$. Merge checks: $O(n^2)$ pairs. Total: $O(n^2 log n)$.

== Two variants

*Parallel* (the original): consider all savings in one sorted list; merge eagerly. Multiple routes grow simultaneously.

*Sequential*: process one route at a time; finish growing it before starting another. Tends to produce longer routes; sometimes better, sometimes worse than parallel.

== Variants & enhancements

- *Modified savings*: $s_(i j) = c_(0 i) + c_(0 j) - lambda c_(i j)$ with $lambda > 1$ — biases toward shorter inter-customer edges
- *Probabilistic Clarke-Wright*: randomize merge order to find better solutions
- *Followed by 2-opt within routes*: standard polish

== Real-world significance

For 60 years (1964–today), Clarke-Wright + 2-opt has been the standard *quick-and-dirty* VRP heuristic:
- Implementable in 100 lines of code
- Fast on 1000+ customer instances
- Within 5-10% of optimum for capacitated VRP
- Easy to adapt for time windows, heterogeneous fleets, etc.

Modern heuristics (#link(<operations-research-optimization-vrp>)[ALNS, HGS]) do better but at significantly more complexity.

== Daganzo continuous-approximation alternative

For very large fleets, instead of optimizing each route, use Daganzo's continuous-approximation formulas to design route structure. See #link(<operations-research-optimization-daganzo-continuous>)[Daganzo].

== See also

- *#link(<operations-research-optimization-vrp>)[VRP]* — problem solved
- *#link(<operations-research-optimization-tsp>)[TSP]* — single-vehicle ancestor
- *#link(<operations-research-optimization-vrp-time-windows>)[VRPTW]* — extension to time windows
- *#link(<operations-research-optimization-daganzo-continuous>)[Daganzo]* — large-scale alternative
