#import "/lib/imports.typ": *

A method for solving multi-stage decision problems by breaking them into overlapping sub-problems, each solved once and reused.

== When DP applies

Required ingredients:

1. *Stages* — the problem decomposes into a sequence of decisions $t = 0, 1, dots, T - 1$
2. *State* — a summary of the past sufficient for future decisions (Markov property)
3. *Additive cost* — total cost = sum of per-stage costs $sum c_t (s_t, a_t)$
4. *Known transition* — $s_(t+1) = f_t (s_t, a_t)$ deterministic, or $P_t (s' | s, a)$ stochastic
5. *Tractable state set* — table fits in memory (or use approximation)

If any breaks, plain DP doesn't apply.

== Problem class

At stage $t$ in state $s_t$:
- Choose action $a_t in cal(A)(s_t)$
- Pay immediate cost $c_t (s_t, a_t)$
- System transitions to $s_(t+1) = f_t (s_t, a_t)$

After the last decision: terminal cost $c_T (s_T)$.

Total cost of a plan $pi = (a_0, dots, a_(T-1))$:

$
  J^pi (s_0) = sum_(t=0)^(T-1) c_t (s_t, a_t) + c_T (s_T)
$

Goal: $pi^* = arg min_pi J^pi (s_0)$.

== Why naive enumeration fails

$K$ actions per stage, $T$ stages → $K^T$ plans. $K=5, T=20 → 5^(20) approx 10^(14)$. DP shrinks this to $O(T |cal(S)| |cal(A)|)$ via the #link(<operations-research-optimization-bellman-equation>)[Bellman recursion].

== Core ideas

- *#link(<operations-research-optimization-bellman-equation>)[Bellman equation]* — the recursion that breaks the problem into sub-problems
- *#link(<operations-research-optimization-backward-induction>)[Backward induction]* — solve from the end back
- *#link(<operations-research-optimization-forward-induction>)[Forward induction]* — dual direction (cost-to-arrive)
- *#link(<operations-research-optimization-stochastic-dp>)[Stochastic DP]* — random transitions, expected cost
- *#link(<operations-research-optimization-value-iteration>)[Value iteration]* / *#link(<operations-research-optimization-policy-iteration>)[Policy iteration]* — infinite-horizon MDPs

== Curse of dimensionality

State has $d$ components with $n$ values each → $|cal(S)| = n^d$. DP cost grows exponentially in *dimension*, not in $T$.

Mitigations: state aggregation, approximate DP, reinforcement learning, function approximation.

== Common applications

- *Shortest path on DAG* — $O(V + E)$
- *0-1 Knapsack* — pseudo-polynomial $O(n W)$
- *Equipment replacement*
- *Inventory*: #link(<supply-chain-eoq-wagner-whitin>)[Wagner-Whitin] lot-sizing
- *Resource allocation* across activities
- *Optimal stopping* — secretary problem, asset selling
- *Revenue management* — see #link(<operations-research-optimization-bellman-equation>)[Bellman] applied to capacity-time
- *Reinforcement learning* — MDP foundation

== See also

- *#link(<operations-research-optimization-bellman-equation>)[Bellman Equation]*
- *#link(<operations-research-optimization-backward-induction>)[Backward Induction]*
- *#link(<operations-research-optimization-stochastic-dp>)[Stochastic DP]*
- *#link(<operations-research-optimization-value-iteration>)[Value Iteration]*
- *#link(<operations-research-optimization-policy-iteration>)[Policy Iteration]*
