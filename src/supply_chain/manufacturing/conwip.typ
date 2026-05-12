#import "/lib/imports.typ": *
#show: formatting

*Constant Work-In-Process*: a production-control discipline that caps WIP at a constant level $w$. New work enters only when finished work exits — a *pull* system but with one global cap instead of per-station kanbans.

Developed at Northwestern (Spearman, Woodruff, Hopp 1990) as a generalization of #link(<supply-chain-manufacturing-kanban-sizing>)[kanban].

== Mechanic

1. Set WIP cap $w^*$ (typically $w^* > W_0$, the #link(<supply-chain-manufacturing-critical-wip>)[critical WIP])
2. Whenever a unit finishes and exits the line, *authorize* a new unit to enter
3. Total WIP stays constant at $w^*$ always

Compare:
- *Push (MRP-driven)*: release per planned schedule, WIP fluctuates
- *Kanban*: each station holds local kanbans; WIP bounded but more complex
- *CONWIP*: one global cap; simpler, often as effective

== Why CONWIP works

The #link(<supply-chain-manufacturing-best-worst-pwc>)[PWC] formula:

$
  text("TH") = (w / (W_0 + w - 1)) r_b
$

shows throughput approaches $r_b$ as $w$ grows. Setting $w$ generously above $W_0$ guarantees you're close to bottleneck-limited throughput, while keeping cycle time bounded.

vs *uncapped push*: WIP can grow without bound under variability, blowing up cycle time.

== Setting the cap

Trade-off:

- *Too low $w$*: starvation, throughput below $r_b$
- *Too high $w$*: long cycle time, lots of inventory, late deliveries

Rule of thumb: $w^* = W_0 + $ buffer. Buffer sized to cover typical variability — start with $1.5 dot W_0$ and adjust based on observed throughput / cycle time.

== Implementation

- *Cards / tokens*: physical or digital "authorizations" that flow with units
- *Heijunka box*: time-sliced authorization (with #link(<supply-chain-manufacturing-heijunka>)[level scheduling])
- *MES system*: software cap enforced on releases

== Comparison with #link(<supply-chain-manufacturing-kanban-sizing>)[Kanban]

#table(
  columns: 3,
  align: (left, left, left),
  stroke: none,
  table.header([], [*Kanban*], [*CONWIP*]),
  [WIP control], [Per-station local], [Global single cap],
  [Mix flexibility], [Limited (per-part kanbans)], [Higher (any part fills the cap)],
  [Implementation], [More complex], [Simpler],
  [Per-product visibility], [Better], [Aggregate only],
  [Best for], [Repetitive, low-mix], [Higher-mix, more flow-flexible],
)

CONWIP is simpler and adapts better to product mix; kanban gives tighter per-product control.

== See also

- *#link(<supply-chain-manufacturing-kanban-sizing>)[Kanban Sizing]*
- *#link(<supply-chain-manufacturing-critical-wip>)[Critical WIP]*
- *#link(<supply-chain-manufacturing-best-worst-pwc>)[Best/Worst/PWC]*
- *#link(<supply-chain-manufacturing-factory-physics>)[Factory Physics]*
