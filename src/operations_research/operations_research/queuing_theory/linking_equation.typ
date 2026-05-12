#import "/lib/imports.typ": *
#show: formatting

A simple but powerful approximation for *how variability propagates through tandem queues*. The departure-process variability from one station is the arrival variability for the next.

== Formula

For a single station with utilization $rho$, arrival CoV $c_a$, and service CoV $c_s$, the *departure* CoV $c_d$ is:

$
  c_d^2 = (1 - rho^2) c_a^2 + rho^2 c_s^2
$

— a weighted average of arrival and service variability, weighted by $rho^2$ and $1 - rho^2$.

== Two extreme regimes

*Low utilization* ($rho -> 0$): $c_d approx c_a$. The station is mostly idle; departures inherit the arrival pattern.

*High utilization* ($rho -> 1$): $c_d approx c_s$. The station is always busy; departures inherit the service-time pattern.

In between: blend.

== Tandem queues: variance flows downstream

Tandem layout:

```
Station 1 → Station 2 → Station 3 → ... → Station N
```

Arrival CoV at station 2 = departure CoV from station 1 = $c_d^((1))$.

Applying the linking equation repeatedly:

$
  c_a^((k+1)) = c_d^((k))
$

So variance *propagates* downstream. Stations near the bottleneck (high $rho$) propagate their service variability strongly; idle stations pass through arrival variability.

== Why it matters: the Hopp-Spearman corollary

In a *balanced* line (all stations have similar $rho$ and $c_s$), variability builds up but stays bounded. In an *unbalanced* line, one bad station injects variance that downstream stations can't fully absorb — leading to queue blowups far from the original problem.

This is part of why *line balancing* (#link(<supply-chain-manufacturing-line-balancing>)[here]) and *variance reduction* (eliminating setups, breakdowns) are foundational manufacturing improvements.

== Bottleneck analysis

The linking equation lets you predict where queues will build *before* operations start:

1. Compute $rho$ at each station
2. Apply the linking equation from upstream to downstream
3. Combine with #link(<operations-research-queuing-theory-kingman-vut>)[VUT] / #link(<operations-research-queuing-theory-sakasegawa>)[Sakasegawa] to estimate queue lengths

Identifies bottleneck location and severity quantitatively.

== Limitations

- *Approximation* — exact only for special distributions
- *Independence assumed* — auto-correlation in service or arrivals breaks the formula
- *Open queues* — doesn't handle blocking / starvation directly (need finite-buffer extensions)

For finite buffers: see two-machine finite-buffer models (Buzacott-Shanthikumar) — more complex but capture blocking effects.

== See also

- *#link(<operations-research-queuing-theory-kingman-vut>)[Kingman VUT]*
- *#link(<operations-research-queuing-theory-sakasegawa>)[Sakasegawa]*
- *#link(<supply-chain-manufacturing-best-worst-pwc>)[Best/Worst/PWC]* — Hopp-Spearman line performance
- *#link(<supply-chain-manufacturing-line-balancing>)[Line Balancing]*
