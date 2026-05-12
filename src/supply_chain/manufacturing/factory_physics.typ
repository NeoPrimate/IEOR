#import "/lib/imports.typ": *
#show: formatting

A framework (Hopp & Spearman, *Factory Physics* 1996) that applies *queueing theory* + *Little's Law* + variability analysis to manufacturing. Replaces folk wisdom with quantitative laws.

== The three core insights

1. *Three buffers absorb variability* — capacity, inventory, time. You always pay one (or all) of these.

2. *#link(<operations-research-queuing-theory-kingman-vut>)[VUT equation]*: queue time = Variability × Utilization × Time. Reducing any of the three reduces flow time.

3. *#link(<supply-chain-manufacturing-best-worst-pwc>)[Best/Worst/Practical-worst-case]* performance curves: bound any manufacturing line's behavior given basic parameters.

== Foundational quantities (a single station)

- $r_b$: *bottleneck rate* — the maximum sustainable throughput (per hour)
- $T_0$: *raw processing time* — sum of mean processing times across stages
- $w$: *WIP level* — work-in-process inventory
- $W_0 = r_b T_0$: *critical WIP* — minimum WIP to achieve $r_b$ throughput

See #link(<supply-chain-manufacturing-critical-wip>)[Critical WIP].

== Little's Law applied

For a production line at steady state:

$
  text("WIP") = text("Throughput") times text("Cycle Time")
$

(See #link(<operations-research-queuing-theory-littles-law>)[Little's Law].)

Given any two, the third is determined. Manufacturing trade-offs come down to managing these three quantities.

== Best, worst, practical-worst-case

For any line:

- *Best-case TH*: $min(w/T_0, r_b)$
- *Worst-case TH*: $1/T_0$
- *Practical-worst-case TH*: $(w / (W_0 + w - 1)) r_b$

Real lines lie between best (perfectly deterministic) and worst (max variability). PWC gives a "balanced random" baseline. See #link(<supply-chain-manufacturing-best-worst-pwc>)[Best/Worst/PWC].

== Levers for improvement

1. *Reduce variability*: smaller setups (SMED), reliable equipment (TPM), uniform service times
2. *Match capacity*: balance line (avoid bottleneck migration)
3. *Right-size WIP*: just above critical WIP — see #link(<supply-chain-manufacturing-conwip>)[CONWIP]
4. *Pull system control*: #link(<supply-chain-manufacturing-kanban-sizing>)[kanban] / CONWIP / drum-buffer-rope
5. *Eliminate non-value-added activities* (lean / Toyota Production System)

== Compared to traditional cost accounting

Traditional manufacturing cost allocation overhead-rates "fully" — pretends each unit absorbs the same overhead. Factory physics shows this is misleading:

- Loading near $rho = 1$ produces *enormous* queue and cycle-time penalty
- Marginal unit at high utilization costs *much more* (time, capital tied up) than marginal unit at low utilization
- *Capacity has nonlinear value* — overcapacity is good!

== See also

- *#link(<supply-chain-manufacturing-best-worst-pwc>)[Best / Worst / PWC]*
- *#link(<supply-chain-manufacturing-critical-wip>)[Critical WIP]*
- *#link(<supply-chain-manufacturing-conwip>)[CONWIP]*
- *#link(<supply-chain-manufacturing-kanban-sizing>)[Kanban Sizing]*
- *#link(<supply-chain-manufacturing-takt-time>)[Takt Time]*
- *#link(<supply-chain-manufacturing-line-balancing>)[Line Balancing]*
- *#link(<supply-chain-manufacturing-theory-of-constraints>)[Theory of Constraints]*
- *#link(<operations-research-queuing-theory-kingman-vut>)[Kingman VUT]*
- *#link(<operations-research-queuing-theory-littles-law>)[Little's Law]*
