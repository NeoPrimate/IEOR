#import "/lib/imports.typ": *

The task of allocating work to stations on a production line so each station's work time is below the #link(<supply-chain-manufacturing-takt-time>)[takt time], minimizing idle time and station count.

== Setup

- A product is assembled via $n$ *tasks* with processing times $t_1, dots, t_n$
- Tasks have *precedence constraints*: task $i$ must finish before task $j$ starts
- Tasks are grouped into *stations*; each station's total time $<= "takt"$

Goals (often trade-offs):
- *Minimize number of stations* (capital cost)
- *Minimize cycle time* (= maximum station time)
- *Smooth station loads* (workforce equity)

== Theoretical bounds

*Minimum stations*:

$
  N^* >= ceil((sum_i t_i) / "takt")
$

(Total work ÷ takt time, rounded up.)

*Minimum cycle time*: $max_i t_i$ (longest indivisible task sets a floor).

== Balance efficiency

$
  "Balance efficiency" = (sum_i t_i) / (N dot "cycle time")
$

100% means every station fully loaded — no idle time. Lower efficiency means wasted capacity.

== Heuristics

The problem (Assembly Line Balancing Problem, ALBP) is NP-hard. Common heuristics:

*Longest Task Time (LTT)*: pick assignable tasks (precedences satisfied, fits in remaining station time) in *decreasing order* of $t_i$.

*Ranked Positional Weight (RPW, Helgeson-Birnie 1961)*:
1. Compute each task's *positional weight* = $t_i$ + sum of $t_j$ for all successors $j$
2. Assign tasks in decreasing positional weight, respecting precedences

*COMSOAL* (Arcus 1966): Random assignment with backtracking. Multi-start.

== Worked example

10 tasks with times $(5, 3, 4, 6, 4, 5, 4, 3, 5, 4)$, total $= 43$ minutes. Takt time $= 8$ minutes.

Minimum stations: $ceil(43 / 8) = 6$.

LTT heuristic with simple precedence chain: place tasks into stations one at a time, picking the longest available task that fits.

Result might give 6 or 7 stations, balance efficiency 89%–100%.

== Mixed-model line balancing

Real lines produce *multiple products* with different task sets. *Mixed-model* balancing:
- Define product mix (proportion of each)
- Compute *expected* task times weighted by mix
- Balance using weighted times
- Sequence products through stations to avoid bottleneck overload

== Single-product vs U-shaped lines

#table(
  columns: 3,
  align: (left, left, left),
  stroke: none,
  table.header([Layout], [Pros], [Cons]),
  [Straight line], [simple, fast], [workers can't help each other],
  [U-shaped], [workers reach multiple stations, can help bottleneck], [more complex, requires multi-skilled workers],
  [Cell], [flexible, small batches], [coordinating multiple cells],
)

U-shaped (cellular) layout is the lean ideal — natural for #link(<supply-chain-manufacturing-conwip>)[CONWIP] / kanban control.

== Variability and balance

Even a perfectly balanced *deterministic* line behaves much worse than the formula suggests when *variability* is added (per #link(<operations-research-queuing-theory-kingman-vut>)[VUT]). Real balancing requires both:

- *Mean balance*: station load averages match
- *Variance balance*: station variability matches

Otherwise the high-variance station becomes a "virtual bottleneck" that drives queueing throughout.

== See also

- *#link(<supply-chain-manufacturing-takt-time>)[Takt Time]* — the constraint
- *#link(<supply-chain-manufacturing-best-worst-pwc>)[Best/Worst/PWC]*
- *#link(<supply-chain-manufacturing-factory-physics>)[Factory Physics]*
- *#link(<supply-chain-manufacturing-conwip>)[CONWIP]*
