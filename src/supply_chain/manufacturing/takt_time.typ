#import "/lib/imports.typ": *

The *pace of production* needed to match customer demand. From German *Takt* (beat, rhythm).

$
  "Takt time" = "available production time" / "customer demand"
$

If customers want 80 units in an 8-hour shift, the line must produce one unit every $480/80 = 6$ minutes.

== Why takt time matters

Takt is the *target cycle time* for each station and the line overall:

- *Slower than takt*: line can't keep up — backlogs accumulate
- *Faster than takt*: line overproduces — inventory accumulates (waste)
- *At takt*: production synchronized with demand — lean ideal

In lean manufacturing, every station is designed to complete its work *in less than or equal to* the takt time, with engineered slack absorbed by Heijunka boxes / standard WIP.

== Calculating takt

*Available time*: net production time available, after deducting:
- Breaks
- Meetings
- Changeovers (or carefully scheduled outside production)
- Planned maintenance

*Customer demand*: actual delivery requirement, including:
- Customer orders
- Forecast adjustments
- Safety / replenishment stock targets

== Worked example

Factory:
- Two shifts, 8 hours each, 1 hour total breaks per shift
- Net available time: $2 dot 7 = 14$ hours/day $= 840$ minutes/day
- Customer demand: 200 units/day

$
  "Takt time" = 840 / 200 = 4.2 #h(0.5em) "minutes per unit"
$

So each station must complete its task in 4.2 minutes or less. The overall line cadence is one unit out every 4.2 minutes.

== Takt time vs cycle time

- *Takt time*: external (driven by demand) — target cadence
- *Cycle time*: internal (driven by process) — actual time per unit

Goal: $"cycle time" <= "takt time"$. When equality holds, line runs perfectly *to demand* — no over- or under-production.

== Takt time vs throughput

#table(
  columns: 2,
  align: (left, left),
  stroke: none,
  [Takt time], [time *between* units leaving the line],
  [Throughput], [units per unit time = $1 / "takt"$],
)

Inverses. Both convey same information.

== Heijunka — level loading

Demand is rarely flat — peaks Monday, valleys Friday, etc. *Heijunka* (#link(<supply-chain-manufacturing-heijunka>)[here]) smooths production by aggregating demand and producing in a level cadence. Takt is then calculated from *average* demand, not peak.

== Limitations

- *Volatile demand* — takt changes; need flexibility to adjust
- *Mix complexity* — multiple products with different cycle times need EPEI or sequenced production
- *Setup-heavy lines* — takt time may be longer than nominal cycle time once setups are included

== See also

- *#link(<supply-chain-manufacturing-line-balancing>)[Line Balancing]* — designing stations to meet takt
- *#link(<supply-chain-manufacturing-heijunka>)[Heijunka]* — level loading
- *#link(<supply-chain-manufacturing-kanban-sizing>)[Kanban Sizing]* — pull control matching takt
- *#link(<operations-research-queuing-theory-littles-law>)[Little's Law]*
