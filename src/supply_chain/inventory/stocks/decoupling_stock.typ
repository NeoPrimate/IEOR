#import "/lib/imports.typ": *

#let cm(x) = text(fill: red, [$#x$])

== Decoupling Stock

Inventory held *between two production stages* (or between a supplier and a buyer) so each stage can operate independently — without being immediately blocked by problems in the upstream stage.

Conceptually similar to safety stock, but for *internal* stages rather than external customer demand.

=== The problem decoupling solves

Consider a two-stage line: stage A feeds stage B. If they operate strictly tied (no buffer between):
- Any *slowdown* at A immediately starves B.
- Any *defect* at A goes straight into B.
- Any *breakdown* at A halts the whole line.

Total throughput is bounded by the *minimum* of the two stages' instantaneous availability — not the average. This compounds dramatically with more stages.

Decoupling stock = a buffer between A and B. A pile up parts; B pulls from the pile.

- A stops for an hour: B keeps running off the pile.
- B stops for an hour: A keeps producing onto the pile.

Each stage can handle *its own* short-term variation independently.

=== When decoupling matters most

The cost of *not* decoupling depends on:
- Variability at each stage (downtime, scrap, cycle-time variation).
- Interaction effects (line balancing, dependence on shared resources).

Decoupling stock is most valuable when:
- Stages have *different* batch sizes or tact times.
- Upstream is unreliable (old equipment, manual operations, supplier delivery variability).
- Downstream demand is more variable than upstream production.

It's *least* valuable in a perfectly flow-balanced, ultra-reliable, automated environment — exactly the conditions Toyota engineered for, which is why TPS deliberately *reduces* decoupling stock to expose problems.

=== Toyota's view: stock hides problems

Lean / TPS treats decoupling stock as *waste*. A buffer between A and B disguises A's reliability problems — the line keeps running, but you never feel pressure to fix the root cause.

Toyota's approach:
- Reduce decoupling stock.
- Expose the variability problems that emerge.
- Fix the upstream stages until they don't need a buffer.
- Repeat with smaller buffers.

The famous "lower the water to expose the rocks" metaphor: stock = water level, problems = rocks. Lean reduces stock to surface problems and force solutions.

=== Sizing decoupling stock

Various models:
- *Insurance buffer*: cover expected downtime per cycle. If A breaks down on average $tau$ minutes per shift, hold $tau dot d_B$ units (B's consumption rate × A's expected downtime).
- *Service-level approach*: target P(B never starves) = some level → use safety-stock formulas with $sigma =$ variability of A's output.
- *Optimization*: balance holding cost of decoupling stock against the expected cost of B starving.

Closed forms exist for some special cases (e.g., M/M/1 stages); more often simulated.

=== How it composes

#table(
  columns: 3,
  inset: 0.7em,
  align: left,
  [*Component*], [*Magnitude*], [*Where it lives*],
  [Cycle stock], [$Q\/2$], [At each stocking location],
  [Safety stock], [$z sigma_"LD"$], [At each stocking location],
  [Pipeline stock], [$bar(d) bar(L)$], [In transit between stages],
  [Anticipation stock], [planned], [Centralized for known events],
  [*Decoupling stock*], [varies (insurance / SS-like)], [Between production stages — physically a queue or buffer area],
)


#example(title: "Two-stage manufacturing line")[
  *Given*:
  - Stage A: machining. Cycle time 60 sec/unit. *Average* downtime 5% (3 min/hour).
  - Stage B: assembly. Cycle time 60 sec/unit. *Reliable* (negligible downtime).
  - Both stages run 8 hours/day.

  *Step 1 — without decoupling*

  Tied stages: A's downtime *immediately* idles B. Effective throughput = $0.95$ × nominal capacity (A's availability dominates because B has no buffer).

  At 60 sec/unit: 480 units/day at full capacity → 456 units/day with 5% A-downtime.

  *Step 2 — small decoupling buffer*

  Add a 30-unit buffer between A and B.

  Now A's downtime affects B *only if* A is down longer than the buffer can sustain B (30 units × 60 sec = 30 minutes).

  In a typical day, A's downtime is split into many short events (e.g., 12 events × 15 sec each rather than one 3-minute outage). A 30-unit buffer easily absorbs all of them. Effective throughput approaches 480/day.

  *Cost*: holding 30 units of WIP at, say, \$20/unit ⇒ \$600 capital + small holding cost. *Throughput gain*: 24 units/day ⇒ over a year, $24 dot 250 = 6000$ extra units valued at margin.

  *Step 3 — Toyota approach: shrink the buffer*

  Toyota would target *zero* buffer — and then attack the 5% A-downtime root cause until it disappears (preventive maintenance, redesign, jidoka). Once A is reliable enough, the buffer can come out.

  *The general decoupling-stock decision*

  At each stage boundary:
  + Estimate the cost of stage starvation (lost throughput × margin).
  + Estimate the cost of holding the buffer.
  + Set buffer size to balance.
  + (If pursuing lean): reduce variability at upstream stages until the buffer is no longer needed, then remove it.

  Decoupling stock is the only inventory category Toyota systematically *eliminates* rather than optimizes.
]
