#import "/lib/imports.typ": *

The *Erlang C formula*: probability that an arriving customer has to *wait* in an M/M/c queue (Poisson arrivals, exponential service, $c$ servers, infinite buffer).

The exact analog of #link(<operations-research-queuing-theory-m-m-c>)[M/M/c] queue's "no-empty-server probability" at steady state.

== Formula

$
  C(c, a) = ((c a)^c / c!) / ((c a)^c / c! + (c - c a) sum_(k=0)^(c-1) (c a)^k / k!)
$

Wait — common convention uses *offered load* $a = lambda / mu$ (in Erlangs) and *number of servers* $c$, with utilization $rho = a / c < 1$:

$
  C(c, a) = (a^c / c!) / ((1 - rho) sum_(k=0)^(c-1) a^k / k! + a^c / c!)
$

$C(c, a)$ is the *probability of waiting* (proportion who don't get served immediately).

== Expected wait

Given $C(c, a)$ is the wait probability, the *expected wait in queue*:

$
  E[W_q] = C(c, a) / (c mu - lambda)
$

Same form as M/M/1 expected wait, just multiplied by the probability of waiting (since non-waiters contribute zero).

== Where it shows up

- *Call center staffing*: how many agents to keep wait probability below threshold
- *Bank tellers / DMV staffing*
- *Help desk / IT support* sizing
- *Server farm capacity*

== Worked example

Help desk: 30 calls per hour, average call lasts 5 minutes = $1/12$ hr. Offered load: $a = 30 dot 1/12 = 2.5$ Erlangs.

#table(
  columns: 3,
  align: (center, center, center),
  stroke: none,
  table.header([$c$ (agents)], [$rho = a/c$], [$C(c, a) approx$]),
  [3], [0.83], [60%],
  [4], [0.625], [27%],
  [5], [0.5], [13%],
  [6], [0.42], [6%],
)

To keep wait probability under 10%, need $c = 6$ agents. Wait time at $c = 6$: $E[W_q] = 0.06 / (6 dot 12 - 30) = 0.06/42 approx 86$ seconds.

== Erlang C in call-center practice

The industry standard formula. Variants:

- *Square-root staffing rule* (Halfin-Whitt regime): $c approx rho + beta sqrt(rho)$ for some quality-of-service constant $beta$
- *Erlang A*: add abandonment — customers leave after waiting too long; see #link(<operations-research-queuing-theory-mmc-abandonment>)[Erlang A]
- *Skill-based routing*: agents are heterogeneous; needs simulation

== Limitations

- *Exponential service times* — real call durations are heavier-tailed (often lognormal)
- *Poisson arrivals* — works for unscheduled arrivals; not for scheduled appointments
- *Infinite buffer* — real callers abandon; use Erlang A

For most call-center sizing, Erlang C is good enough. For accuracy use simulation.

== See also

- *#link(<operations-research-queuing-theory-erlang-b>)[Erlang B]* — without queue (blocking)
- *#link(<operations-research-queuing-theory-m-m-c>)[M/M/c]* — the queue model itself
- *#link(<operations-research-queuing-theory-mmc-abandonment>)[Erlang A]* — with abandonment
- *#link(<operations-research-queuing-theory-square-root-staffing>)[Square-Root Staffing]*
