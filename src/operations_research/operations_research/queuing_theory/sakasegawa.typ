#import "/lib/imports.typ": *
#show: formatting

Generalization of the #link(<operations-research-queuing-theory-kingman-vut>)[VUT formula] to *G/G/c* — multi-server queues with general arrival and service distributions.

== Formula

$
  W_q approx (c_a^2 + c_s^2)/2 dot rho^(sqrt(2(c+1)) - 1) / (c(1 - rho)) dot 1/mu
$

where now:
- $c$: number of servers
- $rho = lambda / (c mu)$: per-server utilization
- $W_q$: expected wait time

The factor $rho^(sqrt(2(c+1)) - 1) / (c(1 - rho))$ replaces the single-server $rho/(1-rho)$.

== Why the exponent

For $c = 1$: $sqrt(2 dot 2) - 1 = sqrt(4) - 1 = 1$ → $rho^1 = rho$, recovering Kingman VUT.

For $c -> infinity$: $sqrt(2(c+1)) - 1 -> infinity$, and $rho^("large")$ goes to $0$ rapidly → queues vanish at fixed $rho$. As you add servers, you absorb variability *more efficiently* than just dividing the work — a fundamental insight.

== Practical impact

Two M/M/1 servers handling $lambda/2$ each vs one M/M/2 server handling $lambda$:

#table(
  columns: 4,
  align: (left, center, center, center),
  stroke: none,
  table.header([Setup], [$rho$], [$W_q / (1/mu)$], [Comparison]),
  [Two separate M/M/1], [$rho_1 = lambda/(2 mu)$], [$rho_1/(1 - rho_1)$], [each server has own queue],
  [Pooled M/M/2], [$rho_2 = lambda/(2 mu)$], [$rho_2^(sqrt(6)-1)/(2(1 - rho_2))$ — lower], [shared queue, better],
)

Pooling reduces waiting time even at the same per-server utilization. This is the queueing analog of #link(<supply-chain-risk-pooling-risk-pooling>)[risk pooling].

== Limitations

- *Approximation*: tight in heavy traffic, less accurate when $rho$ is small
- *Identical servers* assumed
- *No abandonment*: customers can't leave; for that see #link(<operations-research-queuing-theory-mmc-abandonment>)[Erlang A]

== Where used

- *Call center sizing*: how many agents for given call volume and service-time distribution
- *Web service capacity planning*: request handlers
- *Bank teller / DMV staffing*
- *Manufacturing*: multiple parallel machines

== See also

- *#link(<operations-research-queuing-theory-kingman-vut>)[Kingman VUT]* — single-server case
- *#link(<operations-research-queuing-theory-linking-equation>)[Linking Equation]* — variance propagation across stations
- *#link(<operations-research-queuing-theory-erlang-c>)[Erlang C]* — exact M/M/c waiting probability
- *#link(<operations-research-queuing-theory-erlang-b>)[Erlang B]* — exact M/M/c/c (loss)
