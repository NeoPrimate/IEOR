#import "/lib/imports.typ": *
#show: formatting

Extends #link(<operations-research-optimization-dynamic-programming>)[deterministic DP] to problems with random transitions. The framework underlying *Markov Decision Processes* (MDPs), reinforcement learning, and most multi-period stochastic optimization in operations.

== Setup

At stage $t$ in state $s_t$:
- Choose action $a_t in cal(A)(s_t)$
- Pay immediate cost $c_t (s_t, a_t)$
- *Next state is random*: $s_(t+1) ~ P_t (dot | s_t, a_t)$ — transition probability depending on current state and action

After the last decision: terminal cost $c_T (s_T)$.

== Policy (not plan)

A fixed *plan* $(a_0, a_1, dots, a_(T-1))$ no longer works — you don't know which state will realize at each step. Instead, a *policy* is a function:

$
  pi_t : cal(S) -> cal(A), #h(0.5em) pi_t (s) #h(0.2em) "is the action taken in state" s "at stage" t
$

Total cost is a random variable; we minimize its expectation:

$
  J^pi (s_0) = E[sum_(t=0)^(T-1) c_t (s_t, pi_t (s_t)) + c_T (s_T)]
$

== Stochastic Bellman equation

Same argument as the deterministic case (additivity + principle of optimality, now applied to *expected* cost):

$
  J_t (s) = min_(a in cal(A)(s)) { c_t (s, a) + sum_(s') P_t (s' | s, a) #h(0.2em) J_(t+1) (s') }
$

Equivalently:

$
  J_t (s) = min_a { c_t (s, a) + E_(s' ~ P_t (dot | s, a)) [J_(t+1) (s')] }
$

The expectation over $s'$ replaces the deterministic transition $f_t (s, a)$ from the deterministic Bellman.

== Side-by-side comparison

$
  "deterministic:" #h(1em) J_t (s) = min_a { c_t (s, a) + J_(t+1) (f_t (s, a)) }
$

$
  "stochastic:" #h(2em) J_t (s) = min_a { c_t (s, a) + E [J_(t+1) (s')] }
$

== Worked example

From state $B$ at stage $1$, action "right" leads to:
- $C$ with probability $0.7$ (immediate cost $1$, $J_2 (C) = 2$)
- $D$ with probability $0.3$ (immediate cost $6$, $J_2 (D) = 4$)

$
  Q_1 (B, "right") = 0.7 #h(0.2em) (1 + 2) + 0.3 #h(0.2em) (6 + 4) = 2.1 + 3.0 = 5.1
$

If action "left" gives $4.5$, optimal action at $(t=1, B)$ = left.

== Examples

- *(s, S) inventory policy* — order up to $S$ when inventory drops below $s$; optimality is a stochastic-DP result
- *Multi-period newsvendor* — stochastic demand each period, carry inventory between periods
- *Revenue management* — DP on (remaining capacity, time-to-go)
- *Optimal stopping* — secretary problem, asset selling, exercise of American options
- *Reinforcement learning* — model-free / sample-based stochastic DP

== Finite vs infinite horizon

- *Finite horizon*: just solve backward in time as in deterministic case
- *Infinite horizon*: leads to #link(<operations-research-optimization-value-iteration>)[value iteration] / #link(<operations-research-optimization-policy-iteration>)[policy iteration]

== Curse of dimensionality + curse of randomness

Stochastic DP inherits the dimensionality curse from deterministic DP, plus the cost of computing expectations over the next-state distribution. Approximations:

- *Sampling*: replace exact expectation with Monte Carlo estimate
- *Approximate DP / Neuro-DP*: function approximation for $J_t$
- *Reinforcement learning*: sample-based, model-free

== See also

- *#link(<operations-research-optimization-bellman-equation>)[Bellman Equation]* — deterministic version
- *#link(<operations-research-optimization-value-iteration>)[Value Iteration]*
- *#link(<operations-research-optimization-policy-iteration>)[Policy Iteration]*
- *#link(<statistics-markov-chains>)[Markov Chains]* — underlying state-transition model
