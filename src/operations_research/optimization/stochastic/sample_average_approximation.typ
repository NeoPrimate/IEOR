#import "/lib/imports.typ": *
#show: formatting

*Sample Average Approximation* (SAA) — replace an intractable expectation in a #link(<operations-research-optimization-stochastic-programming>)[stochastic program] with a Monte Carlo average over scenarios.

== Problem

Original stochastic program:

$
  z^* = min_x f(x) + E_xi [Q(x, xi)]
$

The expectation is hard (high-dimensional integral; complex distribution).

== SAA approximation

Generate $N$ i.i.d. samples $xi^1, dots, xi^N$ from the distribution of $xi$. Solve:

$
  hat(z)_N = min_x f(x) + 1/N sum_(s=1)^N Q(x, xi^s)
$

This is just a *deterministic* mathematical program — with $N$ scenarios. Solvable by standard tools (simplex, branch-and-bound, etc.).

== Convergence

As $N -> infinity$:

$
  hat(z)_N -> z^* #h(1em) "(strong law of large numbers)"
$

with the optimal solution $hat(x)_N$ also converging to the true optimum $x^*$. Rate: $O(1/sqrt(N))$ by CLT — the error variance decays as $1/N$, standard error as $1/sqrt(N)$.

== Confidence intervals

The objective value $hat(z)_N$ from a single SAA run is a *random* estimate. Standard confidence interval:

$
  "CI" = [hat(z)_N - 1.96 sigma_N / sqrt(N), hat(z)_N + 1.96 sigma_N / sqrt(N)]
$

where $sigma_N$ is the sample standard deviation of the recourse values $Q(hat(x)_N, xi^s)$.

== Practical SAA algorithm

1. Generate $N$ samples
2. Solve SAA problem → $hat(x)_N$
3. Independently evaluate $hat(x)_N$ on $M$ fresh samples (out-of-sample, $M >> N$) to estimate true $f(hat(x)_N) + E[Q(hat(x)_N, xi)]$
4. Compare in-sample $hat(z)_N$ vs out-of-sample estimate. If similar, $hat(x)_N$ is a good solution. If much worse out-of-sample, increase $N$.

This *out-of-sample validation* is essential — in-sample optimization can over-fit to the scenarios used.

== Choosing $N$

Trade-off:

- *Larger $N$*: better approximation, but exploding problem size (number of recourse variables = $|y| dot N$)
- *Smaller $N$*: faster solve, more sample error

Heuristics:

- *Replication*: solve SAA with several smaller $N$'s, take the best. Cheaper than one huge $N$.
- *Adaptive sampling*: start small, grow $N$ until confidence interval is tight enough
- *Stratified sampling*: sample more from high-impact regions of the distribution to reduce variance

== Variance reduction

Plain Monte Carlo has variance $sigma^2 / N$. Tricks to do better:

- *Antithetic variates* — use $xi$ and $-xi$ together
- *Importance sampling* — sample more from rare-but-impactful scenarios
- *Common random numbers* — across optimization iterations
- *Quasi-Monte Carlo* (Halton, Sobol sequences) — $O(1/N)$ convergence instead of $O(1/sqrt(N))$ for smooth integrands

== When SAA shines

- *Continuous distributions* of $xi$ (chance-constrained SP can be cumbersome)
- *Distributions without closed-form moments*
- *Black-box simulators* — easy to sample, hard to integrate analytically

== See also

- *#link(<operations-research-optimization-stochastic-programming>)[Stochastic Programming]*
- *#link(<operations-research-optimization-scenario-trees>)[Scenario Trees]*
- *#link(<statistics-monte-carlo-simulation>)[Monte Carlo Simulation]*
- *#link(<operations-research-optimization-two-stage-recourse>)[Two-stage Recourse]*
