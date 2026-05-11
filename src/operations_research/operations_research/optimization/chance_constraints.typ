#import "/lib/imports.typ": *

Constraints required to hold *with high probability* rather than always. Useful when:

- Always-feasibility is too expensive
- The data is uncertain and 100% reliability isn't needed (or even possible)
- Service-level requirements are stated probabilistically ("95% of orders shipped on time")

== Formulation

For uncertain parameters $xi$:

$
  P(a(xi)^T x <= b(xi)) >= 1 - alpha
$

The constraint $a(xi)^T x <= b(xi)$ must hold with probability at least $1 - alpha$. $alpha$ is the *risk level* — typically $alpha = 0.05$ or $0.01$.

Equivalent: violate the constraint with probability at most $alpha$.

== Joint vs individual chance constraints

*Individual*: each constraint $i$ holds with high probability, separately:

$
  P(a_i^T x <= b_i) >= 1 - alpha_i, #h(1em) forall i
$

*Joint*: *all* constraints hold simultaneously with high probability:

$
  P(a_i^T x <= b_i, #h(0.2em) forall i) >= 1 - alpha
$

Joint is stronger — and harder to handle. Often individual is what's actually intended.

== Reformulation under normality

If $a^T x - b$ is normally distributed (with mean $mu(x)$ and variance $sigma^2(x)$):

$
  P(a^T x <= b) = Phi((b - mu(x)) / sigma(x)) >= 1 - alpha
$

$
  arrow.r.double mu(x) + Phi^(-1)(1 - alpha) sigma(x) <= b
$

The chance constraint becomes a *deterministic* constraint involving $sigma(x)$ — possibly convex (e.g., if $sigma(x)$ is linear in $x$ and $alpha <= 0.5$). This is a *second-order cone constraint*, solvable by interior-point methods.

== Reformulation via sampling

Without normality, use scenarios $xi^1, dots, xi^N$:

$
  P({a(xi)^T x <= b(xi)}) approx 1/N |{s : a(xi^s)^T x <= b(xi^s)}|
$

Enforcing the chance constraint $>= 1 - alpha$ on the sample becomes an MILP with binary indicators per scenario — exponential growth, manageable up to $N approx 1000$.

== Equivalence to VaR / CVaR

In risk management, chance constraints relate to:

- *Value at Risk (VaR)*: the $(1-alpha)$-quantile of the loss distribution. The chance constraint $P("loss" <= V) >= 1 - alpha$ is essentially $V >= "VaR"_alpha$.
- *Conditional VaR (CVaR)*: expected loss beyond VaR. Tighter, convex, easier to optimize.

In practice, CVaR-based reformulations of chance constraints are more numerically tractable.

== Where chance constraints matter

- *Service-level inventory*: 95% in-stock probability per cycle
- *Robust facility location*: feasible under high-probability demand realizations
- *Portfolio optimization*: $P("loss" >= V) <= alpha$
- *Power systems*: probabilistic generation-load balance
- *Network design*: links carry expected traffic with high probability

== See also

- *#link(<operations-research-optimization-stochastic-programming>)[Stochastic Programming]*
- *#link(<operations-research-optimization-two-stage-recourse>)[Two-stage Recourse]*
- *#link(<operations-research-optimization-sample-average-approximation>)[SAA]*
- *#link(<supply-chain-service-levels-cycle-service-level>)[Cycle Service Level]* — inventory application
