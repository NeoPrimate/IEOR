#import "/lib/imports.typ": *
#show: formatting

Optimization with *uncertain parameters* whose probability distribution is known. Distinguishes:

- *Here-and-now* decisions made *before* the random data is revealed
- *Wait-and-see* / recourse decisions made *after* observing the random outcome

== Two-stage stochastic LP

$
  min_x c^T x + E_xi [Q(x, xi)]
$

where:

$
  Q(x, xi) = min_y { q(xi)^T y : T(xi) x + W y = h(xi), #h(0.5em) y >= 0 }
$

- $x$: first-stage (here-and-now) decision — fixed before $xi$ is observed
- $xi$: random parameter
- $y = y(xi)$: second-stage (recourse) decision — chosen after observing $xi$
- $Q(x, xi)$: optimal recourse cost given $x$ and $xi$

The expectation $E_xi$ aggregates over the distribution of $xi$.

== Subtopics

- *#link(<operations-research-optimization-two-stage-recourse>)[Two-stage recourse]* — the core model
- *#link(<operations-research-optimization-scenario-trees>)[Scenario trees]* — multi-stage extension
- *#link(<operations-research-optimization-chance-constraints>)[Chance constraints]* — probabilistic feasibility
- *#link(<operations-research-optimization-sample-average-approximation>)[Sample average approximation]* — solve via Monte Carlo
- *#link(<operations-research-optimization-evpi-vs-vss>)[EVPI vs VSS]* — value of information / value of stochastic modeling

== When to use

- *Decisions must be made before uncertainty resolves* — capacity planning, network design, hiring
- *Some adjustments are possible later* — production levels, shipping, hiring temps
- *You want explicit risk management* not just nominal expected-value optimization

== Alternatives

- *#link(<operations-research-optimization-dynamic-programming>)[Dynamic programming]*: same as stochastic programming for sequential decisions, but explodes with state-space dimension. SP scales better in continuous variables.
- *Robust optimization*: hedges against worst-case uncertainty instead of expected case. Less data-hungry; more conservative.
- *Scenario analysis*: pick a few representative scenarios; solve each deterministically. Crude but easy.

== See also

- *#link(<operations-research-optimization-two-stage-recourse>)[Two-stage Recourse]*
- *#link(<operations-research-optimization-scenario-trees>)[Scenario Trees]*
- *#link(<operations-research-optimization-chance-constraints>)[Chance Constraints]*
- *#link(<operations-research-optimization-sample-average-approximation>)[Sample Average Approximation]*
- *#link(<operations-research-optimization-evpi-vs-vss>)[EVPI vs VSS]*
- *#link(<operations-research-optimization-dynamic-programming>)[Dynamic Programming]*
