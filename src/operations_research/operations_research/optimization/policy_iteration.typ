#import "/lib/imports.typ": *

An alternative to #link(<operations-research-optimization-value-iteration>)[value iteration] for infinite-horizon MDPs. Alternates between *evaluating* the current policy and *improving* it.

== Algorithm

```
Initialize π(s) ← arbitrary action

Repeat:
    # Policy evaluation: compute J^π by solving the linear system
    #     J^π(s) = c(s, π(s)) + γ Σ_{s'} P(s' | s, π(s)) J^π(s')
    # i.e., (I - γ P_π) J^π = c_π        (|S| × |S| linear system)

    # Policy improvement: greedy w.r.t. J^π
    For each s ∈ S:
        π'(s) ← argmin over a of { c(s, a) + γ Σ_{s'} P(s' | s, a) J^π(s') }

    If π' = π: stop
    π ← π'

Return π*
```

== Two phases per iteration

1. *Policy evaluation*: solve $(I - gamma P_pi) J^pi = c_pi$ for the value function of the current policy $pi$. This is a $|cal(S)| times |cal(S)|$ linear system — exact, no approximation.

2. *Policy improvement*: greedy update — pick the action minimizing the Bellman expression *using the current* $J^pi$.

If policy improvement changes nothing, the current $pi$ is optimal (Bellman optimality is satisfied).

== Why it terminates in finite steps

Each iteration *strictly improves* the policy (in value) unless already optimal. There are only $|cal(A)|^(|cal(S)|)$ deterministic policies, so the algorithm must terminate. In practice, it converges in *very few iterations* — often $O(|cal(S)|)$ or fewer, regardless of $gamma$.

== Cost per iteration

- *Policy evaluation*: $O(|cal(S)|^3)$ (solve linear system) or fewer with iterative methods
- *Policy improvement*: $O(|cal(S)|^2 dot |cal(A)|)$

So per iteration, policy iteration is *more expensive* than value iteration. But it needs *fewer iterations*. Total cost is comparable.

== Modified policy iteration

A middle ground: don't fully solve the linear system in step 1. Instead, do $k$ value-iteration-like sweeps to *approximate* $J^pi$:

```
Repeat k times:
    For each s ∈ S:
        J(s) ← c(s, π(s)) + γ Σ_{s'} P(s' | s, π(s)) J(s')
```

Then improve. With $k = 1$: equivalent to value iteration. With $k = infinity$: full policy iteration. Tuning $k$ trades off per-iteration cost vs number of iterations.

== Comparison with value iteration

#table(
  columns: 3,
  align: (left, center, center),
  stroke: none,
  table.header([], [*Value iteration*], [*Policy iteration*]),
  [Per-iter cost], [low], [high],
  [Number of iterations], [many], [few],
  [Convergence], [asymptotic ($J -> J^*$)], [exact terminator (finite policy space)],
  [Memory], [$|cal(S)|$ for $J$], [$|cal(S)|$ for $J$ and $pi$],
  [Practical], [simpler, more common in DP literature], [favored for small / mid state spaces],
)

== Why policy iteration converges fast

The *policy improvement theorem* says that greedy update produces a policy with value at least as good *componentwise* — strictly better at some state if the policy wasn't already optimal. In high-discount problems, value iteration can take thousands of iterations; policy iteration usually takes 10–50.

== Linear-programming reformulation

Both value iteration and policy iteration solve the *same* fixed-point problem:

$
  min_(J) #h(0.2em) sum_s mu_0 (s) J(s) #h(1em) "s.t." #h(0.5em) J(s) <= c(s, a) + gamma sum_(s') P(s' | s, a) J(s'), #h(0.5em) forall (s, a)
$

This LP has $|cal(S)|$ variables and $|cal(S)| dot |cal(A)|$ constraints. Solving it directly is a third approach (and the connection to LP duality reveals deep structure of MDPs).

== See also

- *#link(<operations-research-optimization-value-iteration>)[Value Iteration]* — the alternative
- *#link(<operations-research-optimization-bellman-equation>)[Bellman Equation]*
- *#link(<operations-research-optimization-stochastic-dp>)[Stochastic DP]*
- *#link(<operations-research-optimization-linear-programming>)[Linear Programming]* — LP reformulation
