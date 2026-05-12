#import "/lib/imports.typ": *
#show: formatting

A $3/2$-approximation algorithm for the *metric* #link(<operations-research-optimization-tsp>)[TSP] — produces tours guaranteed within $1.5 times$ optimal.

For 40 years, this was the best-known approximation ratio. In 2020, Karlin-Klein-Gharan improved it slightly (to $1.5 - 10^(-36)$). Christofides' algorithm remains the standard reference point.

== The algorithm

Given a complete graph with distances satisfying the *triangle inequality* ($c_(i k) <= c_(i j) + c_(j k)$):

1. *Build MST* — minimum spanning tree $T$ of the graph
2. *Find odd-degree nodes* in $T$ — call this set $O$. (By handshake lemma, $|O|$ is even.)
3. *Min-weight perfect matching* on $O$ — solve a matching problem on the subgraph induced by $O$
4. *Combine MST + matching* — gives a multigraph where every vertex has even degree
5. *Find Eulerian circuit* on this multigraph — visits every edge exactly once
6. *Shortcut* — convert the Eulerian circuit to a TSP tour by skipping repeated visits (uses triangle inequality)

The output is a Hamiltonian tour with total length $<= 1.5 dot $ OPT.

== Why $3/2$?

- *MST cost*: $<= $ OPT (any TSP tour minus one edge is a spanning tree)
- *Matching cost*: $<= 1/2 $ OPT (a TSP tour on the odd-degree nodes can be decomposed into two perfect matchings; the cheaper is $<= 1/2$ OPT)
- *Total*: MST + matching $<= $ OPT $+ 1/2$ OPT $= 1.5$ OPT
- *Shortcutting only shortens* — under triangle inequality, replacing $A -> B -> C$ with $A -> C$ doesn't increase length

== Complexity

- MST: $O(E log V)$ — see #link(<operations-research-optimization-min-spanning-tree>)[MST]
- Min-weight matching: $O(|O|^3)$ — most expensive step in practice
- Eulerian circuit: $O(E)$
- *Total*: $O(V^3)$, dominated by matching

The matching step makes Christofides slower than simpler heuristics like #link(<operations-research-optimization-tsp-2opt>)[2-opt] on large instances.

== When triangle inequality fails

If the graph doesn't satisfy triangle inequality (e.g., asymmetric TSP with arbitrary costs):
- No constant-factor approximation exists unless P = NP
- Christofides doesn't apply

For *Euclidean TSP* in the plane:
- Better approximations exist (PTAS by Arora 1998)
- Christofides is rarely the best practical choice (LKH-3 is usually better)

== Worth knowing in 2026

- *#link(<operations-research-optimization-tsp-2opt>)[2-opt / LK]* heuristics give better solutions in practice (no guarantee but tighter results)
- Christofides is the *theoretical benchmark* — used in proofs, complexity arguments
- *Metric TSP*: still the only easy worst-case bound to cite

== See also

- *#link(<operations-research-optimization-tsp>)[TSP]* — problem
- *#link(<operations-research-optimization-tsp-2opt>)[TSP 2-opt]* — heuristic alternative
- *#link(<operations-research-optimization-min-spanning-tree>)[MST]* — used in step 1
