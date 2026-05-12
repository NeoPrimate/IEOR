#import "/lib/imports.typ": *
#show: formatting

For any production line with bottleneck rate $r_b$, raw processing time $T_0$, and WIP level $w$, throughput is bounded by three curves (Hopp & Spearman). Real lines fall between these curves.

== Three curves

#table(
  columns: 3,
  align: (left, center, left),
  stroke: none,
  table.header([Curve], [Throughput TH$(w)$], [Cycle Time CT$(w)$]),
  [*Best case* (deterministic)], $min(w/T_0, r_b)$, $max(T_0, w/r_b)$,
  [*Worst case* (max variability)], $1/T_0$, $w T_0$,
  [*Practical-Worst-Case* (balanced)], $(w/(W_0 + w - 1)) r_b$, $T_0 + (w-1)/r_b$,
)

where $W_0 = r_b T_0$ is the *critical WIP*.

== Interpretation

*Best case*: deterministic line, no variability. Throughput grows linearly until hitting bottleneck rate. Cycle time stays at $T_0$ until WIP exceeds capacity then grows linearly.

*Worst case*: pathological — all work at one station, batched. Throughput stays at $1/T_0$ no matter how much WIP. Useless line.

*PWC*: a "balanced random" baseline. Each station equally loaded with exponential variability. Real production lines should land near PWC if well-managed.

== Critical WIP

$
  W_0 = r_b T_0
$

The WIP at which best-case throughput reaches $r_b$ and best-case cycle time equals $T_0$. Above $W_0$:
- Best case: cycle time grows linearly with $w$, throughput stays at $r_b$
- PWC: cycle time grows linearly too, throughput approaches $r_b$ asymptotically

== Take-aways

- If your real line's throughput is well below the PWC curve, you have *more* variability than even PWC assumes — improve setups, breakdowns, batching
- If real cycle time is well above PWC, same — variability is the culprit
- Critical WIP $W_0$ is the sweet spot for #link(<supply-chain-manufacturing-conwip>)[CONWIP] (constant WIP) control

== Plot intuition

```
Throughput
 r_b ┤  best ───────────────────────────────────────────────
     │ /  ╱ PWC asymptote
     │/  ╱
     │  ╱
     │ ╱
     │╱  worst  ──────────────────────────────────────────
 1/T_0
     └─────────────────────────────────────────── WIP w
                W_0
```

== See also

- *#link(<supply-chain-manufacturing-critical-wip>)[Critical WIP]*
- *#link(<supply-chain-manufacturing-factory-physics>)[Factory Physics overview]*
- *#link(<operations-research-queuing-theory-kingman-vut>)[VUT]* — the underlying variability driver
- *#link(<supply-chain-manufacturing-conwip>)[CONWIP]*
