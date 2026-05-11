#import "/lib/imports.typ": *

A foundational approximation for the *G/G/1* queue (general arrival distribution, general service distribution, single server). The VUT equation:

$
  W_q approx underbrace((c_a^2 + c_s^2)/2, V)
  underbrace(rho / (1 - rho), U)
  underbrace(1/mu, T)
$

— $V$ariability × $U$tilization × $T$ime.

== Components

- $c_a$: coefficient of variation of inter-arrival times ($"std"/"mean"$)
- $c_s$: coefficient of variation of service times
- $rho = lambda / mu$: utilization (arrival rate / service rate)
- $1/mu$: mean service time
- $W_q$: expected wait in queue (before service starts)

== Three factors — three levers

1. *Variability* $V = (c_a^2 + c_s^2)/2$
   - Reduce arrival variability (smooth incoming flow, level-load production)
   - Reduce service variability (standardize, reduce setup-time variation)
   - Halve variability → halve queue time

2. *Utilization* $U = rho/(1 - rho)$
   - Critical: $U -> infinity$ as $rho -> 1$
   - Going from $rho = 0.8$ to $rho = 0.9$ doubles the queue
   - Going to $rho = 0.95$ doubles again

3. *Time* $T = 1/mu$
   - Faster service rate (lower $1/mu$) shrinks queues directly
   - Both reduces $T$ and lowers $rho$ at fixed $lambda$

== Why it's an approximation

The VUT formula is *exact* only for *M/M/1* (Poisson arrivals + exponential service, $c_a = c_s = 1$):

$
  W_q^("M/M/1") = (1 + 1)/2 dot rho/(1-rho) dot 1/mu = rho/(mu(1-rho)) ✓
$

For other distributions, VUT is a *Kingman approximation* — derived from upper bounds (Kingman 1962). Tight when traffic is heavy ($rho -> 1$); less accurate when load is light.

== Generalization: G/G/c (multi-server)

For $c$ identical servers, the *Sakasegawa approximation*:

$
  W_q^("G/G/c") approx (c_a^2 + c_s^2)/2 dot rho^(sqrt(2(c+1)) - 1) / (c (1 - rho)) dot 1/mu
$

See #link(<operations-research-queuing-theory-sakasegawa>)[Sakasegawa].

== Variability-Utilization-Time intuition

This is the *single most important formula* in factory physics. It says:

- *Queues grow non-linearly in utilization* — 80% utilization is dramatically different from 95%
- *Variability is half the battle* — even at high utilization, low variability keeps queues small
- *Capacity and demand both matter* — but variability multiplies their effect

== Common applications

- *Manufacturing lines*: setup variability, breakdown variability dominate
- *Call centers*: arrival peaks + service-time spread
- *Hospitals*: patient arrival randomness + variable treatment times
- *Computer systems*: request bursts + response-time variance

== See also

- *#link(<operations-research-queuing-theory-sakasegawa>)[Sakasegawa]* — multi-server extension
- *#link(<operations-research-queuing-theory-linking-equation>)[Linking Equation]* — variance propagation
- *#link(<operations-research-queuing-theory-m-m-1>)[M/M/1]* — exact case
- *#link(<operations-research-queuing-theory-littles-law>)[Little's Law]* — $L = lambda W$
- *#link(<supply-chain-manufacturing-factory-physics>)[Factory Physics]*
