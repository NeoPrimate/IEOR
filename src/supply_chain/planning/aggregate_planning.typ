#import "/lib/imports.typ": *

A mid-term (3–18 month) production / staffing plan that matches *aggregated* output to *aggregated* demand, deciding levels of:

- Regular-time production
- Overtime / undertime
- Hiring / layoffs (or contract labor)
- Inventory carry-over
- Backorders / lost sales

Formulated as a linear program.

== LP formulation

For periods $t = 1, dots, T$:

*Variables*:
- $P_t$: regular-time production
- $O_t$: overtime production
- $H_t$: hires this period
- $F_t$: fires this period
- $W_t$: workforce at end of period $t$
- $I_t$: inventory at end of period $t$
- $B_t$: backlog at end of period $t$

*Costs* per unit / hire / firing:
- $c_P$: regular-time labor / production cost
- $c_O$: overtime premium
- $c_H$: hiring cost
- $c_F$: firing / severance cost
- $c_I$: inventory holding cost
- $c_B$: backorder cost

*Objective*:

$
  min sum_t (c_P P_t + c_O O_t + c_H H_t + c_F F_t + c_I I_t + c_B B_t)
$

*Constraints* (workforce balance, production capacity, inventory balance):

$
  W_t = W_(t-1) + H_t - F_t #h(2em) "(workforce balance)"
$

$
  P_t <= k W_t #h(2em) "($k$ = units per worker per period)"
$

$
  O_t <= o_("max") W_t #h(2em) "(overtime cap)"
$

$
  I_t - B_t = I_(t-1) - B_(t-1) + P_t + O_t - D_t #h(2em) "(net inventory balance)"
$

$
  I_t, B_t, P_t, O_t, H_t, F_t, W_t >= 0
$

== Three pure strategies

#table(
  columns: 3,
  align: (left, left, left),
  stroke: none,
  table.header([Strategy], [Description], [Best when]),
  [*Chase*], [Match production to demand each period; vary workforce], [Low inventory cost, high hire/fire flexibility, low workforce wages],
  [*Level*], [Constant production; let inventory + backorder absorb demand fluctuations], [Stable workforce, low inventory cost, low backorder cost],
  [*Mixed*], [Combination of both, plus overtime / contract], [Real-world; what the LP discovers automatically],
)

Pure chase or pure level rarely optimal in practice — LP finds the right mixed strategy.

== Example: monthly aggregate plan

12-month plan for a manufacturer. Demand peaks in November. Cost parameters set; LP gives:

- Hire 5 workers in August
- Produce overtime in October-November
- Carry inventory September-October to smooth November peak
- Lay off 3 workers in February
- Total cost: $1.2$M

vs pure chase (high hiring/firing): $1.5$M
vs pure level (high inventory): $1.4$M

== Connection to MRP

Aggregate planning sets the *envelope* — workforce, total monthly output. The detail of *which specific products* gets handled by:

- *MPS* (Master Production Schedule) — disaggregates aggregate plan into product-week
- *MRP* (Material Requirements Planning) — explodes MPS into parts / materials

See #link(<supply-chain-planning-mps>)[MPS] and #link(<supply-chain-planning-mrp>)[MRP].

== Limitations

- *Linear costs* assumed — real overtime / hiring may have step functions
- *Aggregate units* — assumes products are interchangeable, ignores changeover times
- *Single facility* — multi-plant versions exist but more complex
- *Deterministic demand* — stochastic versions = stochastic programming (see #link(<operations-research-optimization-stochastic-programming>)[here])

== See also

- *#link(<supply-chain-planning-mps>)[MPS]* — disaggregation
- *#link(<supply-chain-planning-mrp>)[MRP]* — material planning
- *#link(<supply-chain-planning-rccp>)[Rough-Cut Capacity Planning]* — feasibility check
- *#link(<operations-research-optimization-linear-programming>)[Linear Programming]*
