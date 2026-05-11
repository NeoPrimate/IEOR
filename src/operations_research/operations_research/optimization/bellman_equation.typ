#import "/lib/imports.typ": *

The recursion at the heart of #link(<operations-research-optimization-dynamic-programming>)[dynamic programming]. Defines the optimal cost-to-go $J_t (s)$ — minimum cost to complete the problem from stage $t$ in state $s$ — as a function of cost-to-go from the next stage.

== Principle of optimality (Bellman, 1957)

> "An optimal policy has the property that whatever the initial state and initial decision, the remaining decisions must constitute an optimal policy with regard to the state resulting from the first decision."

Restated: if $(a_0^*, a_1^*, dots, a_(T-1)^*)$ is optimal from $s_0$, then $(a_1^*, dots, a_(T-1)^*)$ is optimal from $s_1 = f_0 (s_0, a_0^*)$.

*Why true* (contradiction): if the suffix weren't optimal, swap it for the better one → strictly lower total cost → contradicts optimality of the full plan. ∎

== Deriving the recursion

The total cost decomposes:

$
  J^pi (s_0) = underbrace(c_0 (s_0, a_0), "stage 0") + underbrace(sum_(t=1)^(T-1) c_t (s_t, a_t) + c_T (s_T), "sub-problem of same kind, from " s_1)
$

The bracketed remainder is the same problem starting from $s_1$. By the principle of optimality, the optimal remainder is $J_1 (s_1)$ — the optimal cost-to-go from $s_1$.

So at stage $t$ in state $s$, you pay $c_t (s, a)$ now and face the optimal-remaining problem from $f_t (s, a)$:

$
  J_t (s) = min_(a in cal(A)(s)) { c_t (s, a) + J_(t+1) (f_t (s, a)) }
$

This is the *Bellman equation* — direct consequence of additivity + principle of optimality.

== Base case

$
  J_T (s) = c_T (s)
$

(no decisions left; the only cost is the terminal one.)

== Optimal action

$
  a_t^* (s) = arg min_a { c_t (s, a) + J_(t+1) (f_t (s, a)) }
$

The optimal total cost from $s_0$ is $J_0 (s_0)$.

== Worked example: shortest path through a layered graph

Stages $0 → 1 → 2 → 3$, states $\{S\}, \{A, B\}, \{C, D\}, \{G\}$. Edge costs:

#table(
  columns: 6,
  align: (center, center, center, center, center, center),
  stroke: none,
  table.header([from\\to], [A], [B], [C], [D], [G]),
  [S], [4], [2], [], [], [],
  [A], [], [], [5], [3], [],
  [B], [], [], [1], [6], [],
  [C], [], [], [], [], [2],
  [D], [], [], [], [], [4],
)

*Stage 3* (base case): $J_3 (G) = 0$.

*Stage 2*:
- $J_2 (C) = 2 + 0 = 2$
- $J_2 (D) = 4 + 0 = 4$

*Stage 1*:
- $J_1 (A) = min{5 + 2, 3 + 4} = min{7, 7} = 7$ (tie)
- $J_1 (B) = min{1 + 2, 6 + 4} = min{3, 10} = 3$, action: go to $C$

*Stage 0*:
- $J_0 (S) = min{4 + 7, 2 + 3} = min{11, 5} = 5$, action: go to $B$

Optimal path: $S → B → C → G$, cost $5$.

== Two variants

- *#link(<operations-research-optimization-backward-induction>)[Backward induction]*: solve $J_T → J_(T-1) → dots → J_0$.
- *#link(<operations-research-optimization-forward-induction>)[Forward induction]*: dual recursion on cost-to-arrive $V_t (s)$.

Both compute the same optimum — choose whichever fits the data flow.

== Stochastic case

When transitions are random ($s_(t+1) ~ P_t (dot | s_t, a_t)$), the Bellman equation becomes:

$
  J_t (s) = min_a { c_t (s, a) + sum_(s') P_t (s' | s, a) #h(0.2em) J_(t+1) (s') }
$

— expectation over the next state replaces the deterministic transition. See #link(<operations-research-optimization-stochastic-dp>)[Stochastic DP].

== See also

- *#link(<operations-research-optimization-dynamic-programming>)[Dynamic Programming]* — the broader framework
- *#link(<operations-research-optimization-backward-induction>)[Backward Induction]* — algorithm
- *#link(<operations-research-optimization-stochastic-dp>)[Stochastic DP]* — random case
