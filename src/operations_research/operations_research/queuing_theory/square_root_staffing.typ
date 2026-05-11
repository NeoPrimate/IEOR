#import "/lib/imports.typ": *

A simple rule of thumb for sizing call-center / service-system capacity. *Halfin-Whitt* asymptotic regime (1981).

== The rule

Given offered load $a = lambda / mu$ Erlangs, optimal number of servers is approximately:

$
  c approx a + beta sqrt(a)
$

— a base of $a$ servers (deterministic capacity) plus a *safety margin* $beta sqrt(a)$ that grows as $sqrt(a)$.

== Three quality regimes (parameterized by $beta$)

- *Efficiency-driven* ($beta < 0$): servers saturated, customers wait often. Wait time scales as $1/sqrt(a)$.
- *Quality-driven* ($beta > 2$ or so): servers idle often, customers rarely wait. Wait time scales as $a^(-1/2)$ with very small constant.
- *Quality-and-Efficiency-Driven* (QED, $beta approx 0.5-1.5$): balanced — wait probability and idle probability both moderate.

For typical call centers targeting "80% of calls answered within 20 sec", $beta approx 0.7-1.0$.

== Why $sqrt(a)$?

In the heavy-traffic limit, queueing behavior is governed by *central limit-style fluctuations*. The natural fluctuation scale of an offered load $a$ is $sqrt(a)$ — same as the standard deviation of a Poisson($a$) distribution.

If you provision exactly $a$ servers, fluctuations of size $sqrt(a)$ overwhelm capacity routinely. If you provision $a + sqrt(a)$, you absorb typical fluctuations. Bigger $beta$ → more safety.

== Example

Call center: 50 calls/min, average 3 min per call → $a = 150$ Erlangs.

#table(
  columns: 4,
  align: (center, center, center, center),
  stroke: none,
  table.header([Strategy], [$beta$], [$c = a + beta sqrt(a)$], [Behavior]),
  [No safety], [0], [150], [50% chance customer waits],
  [Modest], [0.5], [156], [~30% wait probability],
  [Quality], [1.5], [168], [~10% wait probability],
  [Premium], [2.5], [181], [< 3% wait probability],
)

(Wait probabilities approximate, depend on abandonment, service distribution, etc.)

== Practical use

1. Estimate offered load $a = lambda / mu$
2. Choose target service level (e.g., 80% answered in 20 sec)
3. Look up corresponding $beta$ (or simulate to calibrate)
4. Staff $c approx a + beta sqrt(a)$

Compare to Erlang C / Erlang A exact calculations — typically very close.

== Why it's the right scale

For a fixed *fraction-of-time-waiting* target (constant probability of waiting), $beta$ stays *constant* as offered load grows. So if you double traffic ($a$ doubles), safety margin only grows as $sqrt(2) approx 1.4$x — capacity grows by $sqrt(a)$ less than linearly.

This is the *economies of scale* of pooling: big call centers need *proportionally less* slack capacity than small ones.

== See also

- *#link(<operations-research-queuing-theory-erlang-c>)[Erlang C]* — exact wait probability
- *#link(<operations-research-queuing-theory-erlang-b>)[Erlang B]* — no queue / blocking
- *#link(<operations-research-queuing-theory-mmc-abandonment>)[Erlang A]* — with abandonment
- *#link(<operations-research-queuing-theory-sakasegawa>)[Sakasegawa]* — G/G/c approximation
