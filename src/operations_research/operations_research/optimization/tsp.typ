#import "/lib/imports.typ": *

The *Traveling Salesman Problem*: visit $n$ cities exactly once and return to start, minimizing total distance.

Famous for being *easy to state, hard to solve*: NP-hard, no known polynomial-time exact algorithm. But also one of the most-studied problems in combinatorial optimization.

== Formulation (DFJ — Dantzig-Fulkerson-Johnson, 1954)

Decision variable $x_(i j) in {0, 1}$: $1$ if the tour uses edge $(i, j)$, else $0$.

$
  min sum_(i, j) c_(i j) x_(i j)
$

s.t.:

$
  sum_j x_(i j) = 1, #h(1em) forall i #h(2em) "(leave each city once)"
$

$
  sum_i x_(i j) = 1, #h(1em) forall j #h(2em) "(enter each city once)"
$

$
  sum_(i in S, j in.not S) x_(i j) >= 1, #h(1em) forall S subset V, 2 <= |S| <= n-1 #h(2em) "(subtour elimination)"
$

$
  x_(i j) in {0, 1}
$

The subtour-elimination constraints are *exponential* in number ($2^n - 2$ subsets). In practice, add them lazily as cutting planes when violated.

== Alternative formulation (MTZ — Miller-Tucker-Zemlin)

Polynomially many constraints using *node potentials* $u_i$:

$
  u_i - u_j + n x_(i j) <= n - 1, #h(1em) forall i, j in {2, dots, n}, i eq.not j
$

Forces a single tour without exponentially many cuts. LP relaxation is *weaker* than DFJ, so fewer cuts needed but worse bounds.

== Computational reality

- *Concorde solver* (Applegate, Bixby, Chvátal, Cook): exact TSP up to $~85,000$ cities
- *Practical heuristics* (LKH-3, OR-tools): near-optimal solutions for millions of cities in minutes
- *NP-hard* — but the constants are favorable in practice

== Lower bounds (for branch-and-bound)

- *MST lower bound*: total tour length $>= $ MST weight (twice the MST = upper bound, see #link(<operations-research-optimization-christofides>)[Christofides])
- *1-tree bound* (Held-Karp): drop one node, MST on the rest, plus the two cheapest edges from the dropped node
- *LP relaxation* of DFJ

== Heuristics

- *Nearest neighbor*: start anywhere, go to the closest unvisited city. Bad — often 25% above optimal
- *Greedy edge*: keep adding cheapest edge that doesn't create a cycle (until tour complete). Bad — similar quality
- *Insertion heuristics*: build tour by inserting one city at a time (cheapest, nearest, farthest)
- *2-opt, 3-opt*: local search swapping pairs / triples of edges — see #link(<operations-research-optimization-tsp-2opt>)[TSP 2-opt]
- *Lin-Kernighan*: variable-depth swap; the gold standard for *heuristic* TSP
- *#link(<operations-research-optimization-christofides>)[Christofides]*: 1.5-approximation for *metric* TSP (triangle inequality)

== Variants

- *Symmetric TSP*: $c_(i j) = c_(j i)$ — most studied
- *Asymmetric TSP* (ATSP): different costs each direction
- *Euclidean TSP*: cities are points in the plane; admits PTAS (Arora 1998)
- *Metric TSP*: triangle inequality; 1.5-approx by Christofides
- *Vehicle Routing Problem (VRP)*: multiple vehicles, capacities — see #link(<operations-research-optimization-vrp>)[VRP]

== See also

- *#link(<operations-research-optimization-tsp-2opt>)[TSP 2-opt]* — local search heuristic
- *#link(<operations-research-optimization-christofides>)[Christofides]* — 1.5-approximation
- *#link(<operations-research-optimization-vrp>)[VRP]* — multi-vehicle generalization
- *#link(<operations-research-optimization-clarke-wright>)[Clarke-Wright Savings]* — heuristic
- *#link(<operations-research-optimization-min-spanning-tree>)[MST]* — used in lower bounds
