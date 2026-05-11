#import "/lib/imports.typ": *

*Erlang A* (also written M/M/c+M): M/M/c queue with *abandonment* — customers leave after waiting too long. More realistic for call centers, where impatient callers hang up.

== Setup

- $lambda$: arrival rate (Poisson)
- $mu$: service rate per server (exponential)
- $c$: number of servers
- $theta$: abandonment rate (exponential patience time, mean $1/theta$)

== Why it matters

#link(<operations-research-queuing-theory-erlang-c>)[Erlang C] assumes infinite patience — every customer eventually gets served. Erlang A models the *real* situation where customers hang up at some rate.

Without abandonment: a slightly-overloaded system has *unbounded* waits.
With abandonment: a slightly-overloaded system has bounded waits *and* some abandonment rate.

== Approximate formulas

Exact Erlang A is nonelementary — uses incomplete gamma function. The most useful results:

*Abandonment probability*:

$
  P("abandon") approx C(c, a) dot (rho - 1) / ...
$

(Specific formulas are technical; key insight is monotonicity: more $theta$ → faster abandonment → less waiting.)

*Expected wait* given service:

$
  E[W_q] approx C(c, a) / (c mu - lambda + theta(c - rho c))
$

(Approximate; sharper formulas in queueing texts.)

== Garnett-Mandelbaum-Reiman scaling

In heavy traffic ($rho approx 1$), Erlang A admits a clean scaling limit (Halfin-Whitt regime extended). Lets you size:

- Quality-driven regime ($beta > 0$): wait > 0 rare; small abandonment
- Efficiency-driven regime ($beta < 0$): wait probable, abandonment substantial
- Quality-and-efficiency-driven (QED, $beta approx 0$): balanced

Used in modern call-center capacity planning.

== Call-center application

Erlang A predicts *service level* (= P(answered within X seconds, before abandoning)) directly. For typical inbound centers:

- Target: SL = 80% of calls answered within 20 seconds
- Erlang A converts agent count + abandonment rate + call duration into SL

This is what tools like Genesys, Five9, and Erlang calculators compute.

== Compared to Erlang C

#table(
  columns: 3,
  align: (left, center, center),
  stroke: none,
  table.header([], [*Erlang C (M/M/c)*], [*Erlang A (M/M/c+M)*]),
  [Abandonment], [no], [yes],
  [Customers behavior], [infinite patience], [exponential patience with mean $1/theta$],
  [Overload regime], [unbounded queue], [bounded by abandonment],
  [Realism], [optimistic on staffing], [closer to reality],
  [Computation], [closed form], [more complex, often approximated],
)

Erlang A *recommends fewer agents* than Erlang C at the same target SL, because abandonment shortens queues — closer to reality.

== Patience modeling

Real patience is rarely exponential — often:

- *Lognormal* — most calls abandon quickly, but a tail waits long
- *Mixture* — different customer segments with different patience
- *Time-varying* — patience changes with wait

These need simulation. Erlang A with exponential patience is the analytical starting point.

== See also

- *#link(<operations-research-queuing-theory-erlang-c>)[Erlang C]* — without abandonment
- *#link(<operations-research-queuing-theory-erlang-b>)[Erlang B]* — no queue at all
- *#link(<operations-research-queuing-theory-square-root-staffing>)[Square-Root Staffing]*
