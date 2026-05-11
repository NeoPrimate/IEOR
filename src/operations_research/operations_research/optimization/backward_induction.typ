#import "/lib/imports.typ": *

The standard algorithm for solving finite-horizon #link(<operations-research-optimization-dynamic-programming>)[dynamic programming] problems. Computes the optimal cost-to-go $J_t (s)$ from the back ($t = T$) toward the start ($t = 0$).

== Algorithm

```
For each terminal state s ∈ S:
    J[T][s] ← c_T(s)

For t = T-1, T-2, …, 0:
    For each state s ∈ S:
        J[t][s]  ← min over a of { c_t(s,a) + J[t+1][ f_t(s,a) ] }
        π[t][s]  ← argmin over a of the same expression

Return J[0][s₀] and policy {π[t][s]}
```

== Why backward

At stage $t$ you need to know $J_(t+1)$ to evaluate the #link(<operations-research-optimization-bellman-equation>)[Bellman equation]:

$
  J_t (s) = min_a { c_t (s, a) + J_(t+1) (f_t (s, a)) }
$

So compute stages in reverse: $J_T$ first (base case), then $J_(T-1)$, then $J_(T-2)$, …, then $J_0$.

== Complexity

$
  O(T dot |cal(S)| dot |cal(A)|)
$

Polynomial in $T$, not exponential. (Naive enumeration is $|cal(A)|^T$.)

Memory: $O(T dot |cal(S)|)$ for the full table, or $O(|cal(S)|)$ if you only need $J_0$ and can discard each $J_(t+1)$ after using it (but then you lose the policy).

== When backward is the right choice

- *Finite horizon* with a clean terminal cost $c_T (s)$
- *Computing the optimal value from a known start state* $s_0$
- *Producing the optimal action at every reachable state* (policy)
- *Dense state graphs*: most states are reachable

For sparse reachable sets, *memoization* (top-down recursive DP with caching) avoids computing unreached states.

== Example: Wagner-Whitin lot-sizing

Demand $d_t$ in each period $t = 1, dots, T$. Setup cost $K$, holding cost $h$ per unit per period. Choose periods to place orders to minimize total cost.

State: $s_t in {0, 1, dots, T}$ = the period of the *last* order (so demand from $s_t + 1$ to $t$ is covered by that order).

The zero-inventory property says it's optimal to order in period $j$ iff $j$ is a previous "last-order" period: $J_T (T)$ = min total cost given the last order was in period $T$.

Backward induction over $T$ states × $T$ periods → $O(T^2)$. This is the classic *Wagner-Whitin algorithm* — see #link(<supply-chain-eoq-wagner-whitin>)[Wagner-Whitin].

== Tabulation vs memoization

Two implementations of the same logic:

#table(
  columns: 2,
  align: (left, left),
  stroke: none,
  table.header([*Tabulation (bottom-up)*], [*Memoization (top-down)*]),
  [Fill full table $J_T, J_(T-1), dots, J_0$ in order], [Recursive call from $J_0 (s_0)$, cache results],
  [Visits every state], [Only states actually reached],
  [Best for dense reachable sets], [Best for sparse reachable sets],
)

Both compute the same $J_t (s)$.

== See also

- *#link(<operations-research-optimization-bellman-equation>)[Bellman Equation]*
- *#link(<operations-research-optimization-forward-induction>)[Forward Induction]* — the dual approach
- *#link(<operations-research-optimization-dynamic-programming>)[Dynamic Programming]*
