#import "/lib/imports.typ": *

A relaxation of #link(<supply-chain-multi-echelon-graves-willems>)[Graves-Willems guaranteed-service] that allows *random wait times* upstream when stockouts occur. Originated with Lee & Billington (1993) and Ettl et al. (2000).

== Why relax guaranteed service?

Graves-Willems assumes each stage *always* meets its promised service time, achieved by holding "enough" safety stock for bounded demand. Real supply chains miss promises:

- Demand exceeds the bounded model occasionally
- Suppliers stock out and you wait
- Capacity constrained

Stochastic-service models accept that *upstream stockouts cause downstream delays*, then compute the resulting waiting-time distribution.

== The trade-off

#table(
  columns: 3,
  align: (left, left, left),
  stroke: none,
  table.header([], [*Guaranteed-service*], [*Stochastic-service*]),
  [Service times], [deterministic / committed], [random waiting times],
  [Demand model], [bounded ($z$-quantile)], [full distribution],
  [Tractability], [easy (DP on trees, MILP for nets)], [hard — queueing-style analysis],
  [Safety stock], [closed form $z sigma sqrt(tau)$], [must solve queueing model at each stage],
)

== Modeling waiting times

At each upstream stage, when inventory is exhausted, downstream orders wait. The waiting-time distribution depends on:

- Replenishment lead time at the upstream stage
- Demand distribution (downstream orders arriving at upstream)
- Base-stock level at the upstream stage

For each stage $i$, the *effective lead time* downstream sees is:

$
  L_i^("eff") = L_i^("nominal") + W_i^("upstream stockout wait")
$

where $W_i$ is random. Compute $E[W_i]$ and $"Var"(W_i)$ via queueing approximations (typically Poisson-process / $M / M / 1$-style models on the order arrival stream).

== METRIC as a special case

For Poisson demand on repairable items, the *#link(<supply-chain-multi-echelon-metric>)[METRIC]* model gives closed-form expressions for expected backorders at each echelon — see that page for the details. METRIC is the canonical example of a stochastic-service multi-echelon model.

== When to use

- *Service-parts networks* — Poisson demand, repair pipelines, low-volume / high-value items
- *Long-lead-time supply chains* — upstream delays are material and frequent
- When guaranteed-service over-promises and you need realistic waiting-time estimates

== When NOT to use

- Mass-market consumer goods where guaranteed-service is "close enough"
- Network design phase — guaranteed-service is much faster to optimize
- When you don't have good lead-time / demand distribution data

== See also

- *#link(<supply-chain-multi-echelon-graves-willems>)[Graves-Willems]* — guaranteed-service
- *#link(<supply-chain-multi-echelon-metric>)[METRIC]* / *#link(<supply-chain-multi-echelon-vari-metric>)[VARI-METRIC]* — Poisson demand repairables
- *#link(<supply-chain-multi-echelon-multi-echelon>)[Multi-Echelon overview]*
