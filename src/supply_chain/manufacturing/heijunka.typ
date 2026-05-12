#import "/lib/imports.typ": *
#show: formatting

*Heijunka* (平準化, "leveling"): a Toyota Production System technique for *smoothing* production by mixing products in a level cadence rather than running batches.

Heijunka makes #link(<supply-chain-manufacturing-takt-time>)[takt time] sustainable by absorbing demand fluctuations *inside* the production system.

== Volume leveling vs mix leveling

*Volume leveling*: produce roughly constant total output each period (week, day, shift). Inventory absorbs demand variability over time.

*Mix leveling*: produce a *mix* of products each period, in *repeating sequence*, rather than running large batches of one product at a time.

Example: producing A, B, C in ratio 4:2:1 per day.

#table(
  columns: 2,
  align: (left, left),
  stroke: none,
  table.header([*Without heijunka*], [*With heijunka*]),
  [AAAA AAAA BB BB C], [A B A A C A B A],
  [Long batches; A inventory grows then drains], [Steady draw on all parts; minimal inventory swings],
)

== EPEI (Every Part Every Interval)

A key heijunka metric. EPEI = how often the line produces each product.

If $n$ products are scheduled to run, total setup time is $sum_i s_i$, and available time per interval is $T$:

$
  text("EPEI") = T - sum_i s_i / "production rate"
$

Smaller EPEI = more frequent mix changes = more flexibility, but more setups.

Reducing setup times (SMED — Single-Minute Exchange of Dies) is the lever for reducing EPEI.

== Heijunka box (load-leveling box)

A physical (or virtual) board that schedules production:

```
Time slot  ──→
Product
A           [kanban][kanban][kanban][kanban]
B           [kanban]──────[kanban]──────
C           [kanban]──────────────────
```

Pull cards from left to right in each slot — produce the indicated product. Maintains the mix across time.

== Benefits

- *Smooth upstream demand* — suppliers see steady draws on each part
- *Low inventory swings* — no boom-bust pattern from batch runs
- *Customer-aligned* — production cadence tracks demand
- *Enables JIT* — pull system needs level loading to function

== Costs

- *More setups* — each mix change is a changeover (SMED becomes critical)
- *Less efficient* per setup vs long batches
- *Worker training* — operators must adjust between products frequently
- *Tooling cost* — quick-change fixtures, modular setups

== When heijunka is harder

- *High product variety* with infrequent demand (long-tail SKUs)
- *Long setup times* not yet reduced via SMED
- *Custom / engineered-to-order* — no repeating sequence possible
- *Volatile demand mix* — sequencing must adapt frequently

In those cases, partial heijunka (level the *high-volume* products, run rest in batches) is a pragmatic compromise.

== Implementation steps

1. Calculate average demand per product per period
2. Reduce setup times via SMED
3. Establish a *pitch* (small repeating time slot)
4. Sequence products in the heijunka box per the demand ratio
5. Pull production based on the box; replenish customer pulls

== See also

- *#link(<supply-chain-manufacturing-takt-time>)[Takt Time]*
- *#link(<supply-chain-manufacturing-kanban-sizing>)[Kanban Sizing]*
- *#link(<supply-chain-manufacturing-factory-physics>)[Factory Physics]*
