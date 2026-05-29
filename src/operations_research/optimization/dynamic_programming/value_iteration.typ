#import "/lib/imports.typ": *
#show: formatting

The standard algorithm for solving *infinite-horizon* Markov Decision Processes. Iteratively applies the #link(<operations-research-optimization-bellman-equation>)[Bellman equation] until the value function converges.

== Infinite-horizon discounted MDP

States $cal(S)$, actions $cal(A)$, transition $P(s' | s, a)$, immediate cost $c(s, a)$, discount factor $gamma in (0, 1)$.

Objective: minimize expected discounted total cost over an infinite horizon:

$
  J^pi (s) = E[sum_(t=0)^infinity gamma^t #h(0.2em) c(s_t, pi(s_t)) | s_0 = s]
$

Since rewards / costs in the far future are exponentially discounted, the sum converges.

== Bellman optimality equation (infinite horizon)

$
  J^* (s) = min_(a in cal(A)) { c(s, a) + gamma sum_(s') P(s' | s, a) #h(0.2em) J^* (s') }
$

This is a *fixed-point equation*: $J^* = cal(T) J^*$ where $cal(T)$ is the *Bellman operator*. The operator is a contraction (with contraction factor $gamma$), so the fixed point is unique and reachable by iteration.

== Algorithm

```
Initialize J(s) ← 0 (or any function)

Repeat until convergence:
    For each s ∈ S:
        J'(s) ← min over a of { c(s, a) + γ Σ_{s'} P(s' | s, a) J(s') }
    J ← J'

Return optimal policy:
    π*(s) ← argmin over a of { c(s, a) + γ Σ_{s'} P(s' | s, a) J(s') }
```

Convergence test: stop when $max_s |J'(s) - J(s)| < epsilon$.

== Why it converges

The Bellman operator $cal(T)$ is a *$gamma$-contraction* under the sup-norm:

$
  ||cal(T) J_1 - cal(T) J_2||_infinity <= gamma ||J_1 - J_2||_infinity
$

By Banach fixed-point theorem, iterating from any starting $J$ converges geometrically to the unique fixed point $J^*$:

$
  ||J^((k)) - J^*||_infinity <= gamma^k ||J^((0)) - J^*||_infinity
$

== Convergence rate

Geometric in $gamma$. To get within $epsilon$ of $J^*$ takes about

$
  k = (log epsilon) / (log gamma) #h(0.5em) "iterations"
$

If $gamma$ is close to 1 (long-horizon problems), convergence is slow. *Acceleration tricks*:
- *Gauss-Seidel updates* (update $J(s)$ in-place using already-updated neighbors)
- *Prioritized sweeping* (update states with large Bellman residuals first)
- *Approximate value iteration* (function approximation for large state spaces)

== Cost per iteration

$O(|cal(S)|^2 dot |cal(A)|)$ — for each state ($|cal(S)|$), for each action ($|cal(A)|$), sum over next states ($|cal(S)|$).

== Value iteration vs policy iteration

#table(
  columns: 3,
  align: (left, left, left),
  stroke: none,
  table.header([], [*Value iteration*], [*Policy iteration*]),
  [Iterates on], [Value function $J$], [Policy $pi$],
  [Per iteration cost], [Cheap ($O(|cal(S)|^2 |cal(A)|)$)], [Expensive (full policy evaluation: solve linear system)],
  [Iterations to converge], [Many (geometric in $gamma$)], [Few (often $<= |cal(S)|$ iterations)],
  [Total cost], [Comparable in practice], [Comparable],
  [Anytime?], [Yes — returns a usable $J$ at any point], [Only at policy-iteration end],
)

See #link(<operations-research-optimization-policy-iteration>)[Policy Iteration] for the alternative.

== Example application

*Inventory management with infinite horizon*: state = on-hand inventory, action = order quantity, transition = stochastic demand. Value iteration finds the optimal $(s, S)$ policy.

== See also

- *#link(<operations-research-optimization-bellman-equation>)[Bellman Equation]*
- *#link(<operations-research-optimization-stochastic-dp>)[Stochastic DP]*
- *#link(<operations-research-optimization-policy-iteration>)[Policy Iteration]*
- *#link(<statistics-markov-chains>)[Markov Chains]*
