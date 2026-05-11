#import "/lib/imports.typ": *

The dual of #link(<operations-research-optimization-backward-induction>)[backward induction]. Instead of computing the optimal cost-*from* each state, compute the optimal cost *to arrive at* each state from $s_0$.

== Setup

Define $V_t (s)$ = minimum cost to reach state $s$ at stage $t$ from the start state $s_0$.

*Base case*:
$
  V_0 (s_0) = 0, #h(1em) V_0 (s) = +infinity #h(0.5em) "for" s eq.not s_0
$

*Inductive step*: to land at $s'$ at stage $t+1$, you must come from some predecessor $s$ at stage $t$ and choose action $a$ with $f_t (s, a) = s'$:

$
  V_(t+1) (s') = min_((s, a) #h(0.2em) : #h(0.2em) f_t (s, a) = s') { V_t (s) + c_t (s, a) }
$

*Optimal value*: $min_s [V_T (s) + c_T (s)]$.

== Algorithm

```
V[0][s₀] ← 0; V[0][s] ← ∞ for s ≠ s₀

For t = 0, 1, …, T-1:
    For each s ∈ S:
        For each action a ∈ A(s):
            s' ← f_t(s, a)
            cost ← V[t][s] + c_t(s, a)
            if cost < V[t+1][s']:
                V[t+1][s'] ← cost
                pred[t+1][s'] ← (s, a)  # for path reconstruction

Optimal value: min over s of (V[T][s] + c_T(s))
Trace back via `pred` to recover the optimal path.
```

Cost is the same as backward induction: $O(T |cal(S)| |cal(A)|)$.

== Backward vs forward

#table(
  columns: 3,
  align: (left, left, left),
  stroke: none,
  table.header([], [*Backward*], [*Forward*]),
  [Variable], [$J_t (s)$ = cost-to-go from $s$], [$V_t (s)$ = cost-to-arrive at $s$],
  [Direction], [$T → 0$], [$0 → T$],
  [Best when], [Terminal cost known/small; want action at every state], [Starting state fixed; want best path to every state],
  [Yields], [Optimal action at every $(t, s)$], [Optimal path to every reachable state],
)

Both compute the same optimum.

== Example: shortest path on a DAG

The classic forward DP. Topologically sort the DAG; visit each node in order, computing $V[s']$ as the minimum of $V[s] + c(s, s')$ over all predecessors $s$.

This is exactly what Bellman-Ford / Dijkstra-on-DAGs does — see #link(<algorithms-dijkstra>)[Dijkstra] (which is a forward DP with priority-queue ordering).

== When forward is the right choice

- *Single source, all-targets*: e.g., shortest paths from $s_0$ to every other node
- *Streaming or layered processing*: data arrives stage by stage, can't see the end
- *Predecessor tracking is natural*: reconstruct paths via `pred[t][s]`

== See also

- *#link(<operations-research-optimization-backward-induction>)[Backward Induction]* — dual
- *#link(<operations-research-optimization-bellman-equation>)[Bellman Equation]*
- *#link(<algorithms-dijkstra>)[Dijkstra]* — forward DP with priority queue
- *#link(<algorithms-dijkstra>)[Bellman-Ford]* — forward DP, handles negative edges
