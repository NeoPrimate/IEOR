#import "/lib/imports.typ": *

*Theory of Constraints* (TOC, Goldratt 1984): a management philosophy that says system performance is determined by the *bottleneck* (the constraint). Identify the bottleneck, exploit it, subordinate everything else.

== The five focusing steps

1. *Identify* the constraint — the bottleneck resource limiting system throughput
2. *Exploit* — maximize utilization of the bottleneck (no idle time, perfect quality, no setups)
3. *Subordinate* — every other resource serves the bottleneck (don't push more than the bottleneck can absorb)
4. *Elevate* — invest to increase bottleneck capacity (add equipment, overtime, etc.)
5. *Return to step 1* — when the bottleneck moves elsewhere, repeat

== Throughput accounting

TOC replaces traditional cost accounting (which over-emphasizes unit costs) with three measures:

- *Throughput* (T): sales revenue minus truly variable costs
- *Investment / Inventory* (I): money tied up in the system
- *Operating Expense* (OE): money to convert inventory into throughput

*Net profit*: $T - O E$

*Return on investment*: $(T - O E) / I$

Goal: increase $T$ first, decrease $I$ second, decrease $O E$ third. Traditional accounting often prioritizes OE reduction, which can hurt $T$ if you cut the bottleneck.

== Product mix problem (with constraint)

Given multiple products competing for a single bottleneck, maximize total throughput:

$
  max sum_i T_i x_i #h(2em) "s.t." sum_i b_i x_i <= "bottleneck capacity"
$

where $b_i$ is bottleneck-minutes per unit of product $i$. Optimal: produce in decreasing order of $T_i / b_i$ (*throughput per bottleneck minute*).

This is a *single-constraint LP* — explicit solution by ratio ranking.

== Drum-Buffer-Rope (DBR) scheduling

A scheduling discipline derived from TOC:

- *Drum*: the bottleneck sets the pace
- *Buffer*: small protective inventory in front of the bottleneck — never let it starve
- *Rope*: communicates bottleneck demand backward to release new work into the system (a "rope" tying the entry point to the bottleneck)

DBR is essentially #link(<supply-chain-manufacturing-conwip>)[CONWIP] but with the WIP cap chosen to keep just the *right amount* of buffer in front of the bottleneck.

== Compared to Lean

#table(
  columns: 3,
  align: (left, left, left),
  stroke: none,
  table.header([], [*TOC*], [*Lean / Toyota*]),
  [Focus], [Bottleneck — what limits throughput], [Waste — what doesn't add value],
  [Inventory at bottleneck], [Buffer (protective)], [Reduce (Just-in-Time)],
  [Improvement target], [Throughput per bottleneck-minute], [Cycle time, waste elimination],
  [Best for], [Complex job shops, bottleneck-driven systems], [Repetitive manufacturing, low variability],
)

Many production systems benefit from *both* — Lean to reduce variability and waste, TOC to manage the residual bottleneck. The two are complementary, not competing.

== See also

- *#link(<supply-chain-manufacturing-factory-physics>)[Factory Physics]* — quantitative bottleneck analysis
- *#link(<supply-chain-manufacturing-conwip>)[CONWIP]* — DBR's modern equivalent
- *#link(<supply-chain-manufacturing-line-balancing>)[Line Balancing]*
- *#link(<supply-chain-manufacturing-best-worst-pwc>)[Best/Worst/PWC]*
