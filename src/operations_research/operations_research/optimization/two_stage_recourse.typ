#import "/lib/imports.typ": *

The simplest #link(<operations-research-optimization-stochastic-programming>)[stochastic program]: decide $x$ now, observe random $xi$, then adapt with second-stage decision $y$.

== Formulation

$
  min_x #h(0.5em) c^T x + E_xi [Q(x, xi)]
$

where the *recourse function*:

$
  Q(x, xi) = min_y { q(xi)^T y : T(xi) x + W y = h(xi), y >= 0 }
$

$x$ is *here-and-now* (e.g., build capacity); $y$ is *wait-and-see* (e.g., produce at each plant once demand is known).

== Deterministic equivalent (scenarios)

For a finite scenario set $xi^1, dots, xi^S$ with probabilities $p^s$:

$
  min_(x, y^1, dots, y^S) c^T x + sum_s p^s q(xi^s)^T y^s
$

s.t.: $T(xi^s) x + W y^s = h(xi^s)$, $#h(0.5em) y^s >= 0$, $#h(0.5em) forall s$.

A *single large LP* with $|x| + |y| dot S$ variables. Can be solved with simplex / interior-point. Problematic when $S$ is large.

== Decomposition methods

For large $S$:

- *L-shaped method (Benders decomposition)*: alternate between a master problem on $x$ and recourse subproblems for each scenario
- *Stochastic dual dynamic programming (SDDP)*: for multi-stage problems, builds piecewise-linear approximations of cost-to-go
- *Progressive hedging*: bundle scenarios and enforce non-anticipativity via Lagrangian relaxation

== Worked example

You can install solar capacity $x$ now (cost $c$ per unit). Tomorrow, demand $D$ is realized — uncertain, two scenarios:

- High demand ($p = 0.6$): $D = 100$, recourse buys grid power at $0.20$ per unit shortage
- Low demand ($p = 0.4$): $D = 40$, recourse sells excess at $0.10$ per unit

Decision: how much $x$ to install? Two-stage SP:

$
  min_x c x + 0.6 [0.20 max(0, 100 - x)] + 0.4 [-0.10 max(0, x - 40)]
$

(Recourse function is the inner min — here it's just the cost given the realized demand.)

Optimal $x^*$ balances the cost of capacity now against expected shortage/surplus cost later. Different from optimizing for the *expected* demand $0.6 dot 100 + 0.4 dot 40 = 76$.

== Why expected-demand optimization is wrong

Optimizing the expected (deterministic) problem misses the *cost asymmetry* between scenarios. Shortage at $0.20$ per unit might be much more expensive than surplus at $0.10$ per unit savings. SP captures this directly; deterministic doesn't.

This gap is the *Value of Stochastic Solution* (VSS) — see #link(<operations-research-optimization-evpi-vs-vss>)[EVPI vs VSS].

== See also

- *#link(<operations-research-optimization-stochastic-programming>)[Stochastic Programming]*
- *#link(<operations-research-optimization-scenario-trees>)[Scenario Trees]*
- *#link(<operations-research-optimization-evpi-vs-vss>)[EVPI vs VSS]*
- *#link(<operations-research-decision-analysis-decision-trees>)[Decision Trees]* — discrete-decision analog
