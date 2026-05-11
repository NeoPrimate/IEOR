#import "/lib/imports.typ": *

The *guaranteed-service* multi-echelon inventory model (Graves & Willems 2000). Each stage promises a *service time* (max lead time it'll deliver in) to its downstream customer. Safety stocks are placed to make those service times achievable given bounded demand.

Used by Procter & Gamble, Hewlett-Packard, Intel, and most modern supply-chain network design software.

== Setup

A network of stages (general topology — serial, assembly, distribution, or mixed). For each stage $i$:

- $T_i$: internal processing / production time at the stage
- $s_i$: *outbound service time* to downstream — what stage $i$ commits to deliver in
- $S_i$: *inbound service time* from upstream — what stage $i$'s suppliers commit to deliver in

Customer-facing stages have $s = 0$ (instant fulfillment) typically.

== Net replenishment time

Stage $i$'s *net replenishment time* — how long it must cover with safety stock:

$
  tau_i = S_i + T_i - s_i
$

— inbound time + processing time − outbound promise time. If you can absorb supplier and processing delays without breaking your downstream promise, $tau_i$ is small (less safety stock needed).

Constraint: $tau_i >= 0$ (can't promise faster than the work takes).

== Safety stock at each stage

Assume demand at the customer-facing stage is bounded by some upper-tail quantile (typical: $mu + z sigma$ over the relevant interval). Then *safety stock at stage $i$*:

$
  "SS"_i = z #h(0.2em) sigma_i #h(0.2em) sqrt(tau_i)
$

— the standard square-root-of-lead-time form, but with $tau_i$ (net replenishment time) instead of pure lead time. The $sqrt$ comes from the variance of demand over a time interval scaling linearly.

Total #link(<supply-chain-stocks-safety-stock>)[safety-stock] cost across the network:

$
  C = sum_i h_i #h(0.2em) z #h(0.2em) sigma_i #h(0.2em) sqrt(tau_i)
$

== Optimization

*Decision variables*: the inbound / outbound service times $s_i, S_i$ at every stage.

*Constraints*:
- $s_i, S_i >= 0$
- $tau_i = S_i + T_i - s_i >= 0$
- $S_i = max_(j in "upstream"(i)) s_j$ (the inbound time at $i$ is the slowest outbound from any upstream feeder)
- Customer-facing $s$ fixed (often $s = 0$)

*Objective*: minimize $sum h_i sqrt(tau_i)$.

*Algorithm*:
- For *trees / serial systems* — dynamic programming, $O(|V|^2)$ time
- For *general networks* — Magnanti et al. extension; MILP

== Geometric intuition

Two extreme strategies for each stage:
- $tau_i = 0$ — hold *no* safety stock here, just pass the delay through (you must trust upstream / promise slower downstream)
- $tau_i = S_i + T_i$ — hold *enough* safety stock to fully decouple from upstream (you can promise $s_i = 0$)

Optimal placement: tradeoff $sqrt(tau_i)$ costs across all stages — concentrate inventory where holding is cheap (upstream, low $h_i$) and decoupling pays off most.

== Risk pooling appears naturally

If two downstream stages share an upstream stage, the upstream stage's safety stock covers their combined variability — naturally captures #link(<supply-chain-risk-pooling-risk-pooling>)[risk pooling].

== When to use

- Generally — anywhere you have a multi-stage supply network and need safety-stock placement
- Works for *assembly* (multiple upstream feed one downstream)
- Works for *distribution* (one upstream feeds multiple downstream)
- Works for *general DAG* networks

== Limitations vs Clark-Scarf

- *Bounded (not stochastic) demand*: the cost of $z$-quantile coverage rather than full distributional optimality
- *Service-time commitment assumed*: real supply chains have stochastic delays even within commitments
- See #link(<supply-chain-multi-echelon-stochastic-service>)[Stochastic-service] for the relaxation

== See also

- *#link(<supply-chain-multi-echelon-multi-echelon>)[Multi-Echelon]* — overview
- *#link(<supply-chain-multi-echelon-clark-scarf>)[Clark-Scarf]* — stochastic-demand alternative
- *#link(<supply-chain-multi-echelon-stochastic-service>)[Stochastic-service]*
- *#link(<supply-chain-stocks-safety-stock>)[Safety Stock]*
- *#link(<supply-chain-risk-pooling-risk-pooling>)[Risk Pooling]*
