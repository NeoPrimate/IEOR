#import "/lib/imports.typ": *
#show: formatting

A simple but effective *local search* heuristic for the #link(<operations-research-optimization-tsp>)[TSP]. Iteratively replaces pairs of edges with a *cheaper* pair until no improvement is possible.

== The 2-opt move

Given a tour $dots -> A -> B -> dots -> C -> D -> dots$, the 2-opt move *reverses* the segment $B -> dots -> C$, giving $dots -> A -> C -> dots -> B -> D -> dots$.

Geometrically: it removes two non-adjacent edges $(A, B)$ and $(C, D)$, and adds $(A, C)$ and $(B, D)$ — *uncrossing* the tour.

*Improvement condition*: do the swap iff

$
  c(A, C) + c(B, D) < c(A, B) + c(C, D)
$

== Algorithm

```
T ← initial tour (e.g., nearest neighbor)
Repeat:
    For each pair of non-adjacent edges (A,B), (C,D) in T:
        If c(A,C) + c(B,D) < c(A,B) + c(C,D):
            Perform 2-opt swap
            Break (or continue to next pair)
Until no improvement found
Return T
```

== Complexity

- *Per pass*: $O(n^2)$ pairs to check
- *Number of passes*: typically $O(n)$ in practice
- *Total*: $O(n^3)$ to reach a 2-opt local optimum

== Why it works

Each successful swap strictly decreases tour length. Since there are finitely many tours and the objective is bounded below, the process terminates.

== 2-opt vs 3-opt vs Lin-Kernighan

#table(
  columns: 3,
  align: (left, left, left),
  stroke: none,
  table.header([Heuristic], [Move type], [Quality]),
  [2-opt], [reverse one segment], [~5% above optimal],
  [3-opt], [3-edge swap, multiple reconnections], [~3% above optimal],
  [Lin-Kernighan], [variable-depth swaps], [~1% above optimal — gold standard],
)

Lin-Kernighan dynamically tries 2-opt, 3-opt, …, $k$-opt moves with backtracking. *LKH-3* (Helsgaun's variant) is the state-of-the-art heuristic.

== Practical tips

- *Start from a good initial tour* (savings algorithm, nearest-neighbor + 2-opt is standard)
- *Use neighborhood lists* — limit to $k$ nearest neighbors per node to avoid $O(n^2)$ pair checks
- *First-improvement vs best-improvement* — first-improvement (take the first beneficial swap) is usually faster
- *Restart from multiple initial tours* — local optima vary; multiple runs improve average quality

== See also

- *#link(<operations-research-optimization-tsp>)[TSP]* — problem
- *#link(<operations-research-optimization-christofides>)[Christofides]* — approximation with worst-case guarantee
- *#link(<operations-research-optimization-clarke-wright>)[Clarke-Wright]* — good initial tour for TSP / VRP
- *#link(<operations-research-optimization-heuristic-algorithms>)[Heuristics]* — broader local-search family
