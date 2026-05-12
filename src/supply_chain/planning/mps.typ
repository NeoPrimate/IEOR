#import "/lib/imports.typ": *
#show: formatting

*Master Production Schedule* (MPS): the *disaggregated* version of #link(<supply-chain-planning-aggregate-planning>)[aggregate planning]. Specifies how many of *each individual product* to make in each *week* (or shorter bucket).

== What it specifies

For each end-item $i$ and time bucket $t$ (typically weekly for 6–12 weeks ahead):

- *Planned production quantity* — how many units to start production of
- *Scheduled receipts* — orders already in process
- *Projected on-hand inventory* — running balance
- *Available-to-promise* (ATP) — quantity uncommitted, available for new orders

== Time-phased records

A typical MPS row for product $i$:

#table(
  columns: 8,
  align: (left, center, center, center, center, center, center, center),
  stroke: none,
  table.header([Week], [1], [2], [3], [4], [5], [6], [7]),
  [Forecast], [100], [120], [110], [100], [130], [120], [110],
  [Customer orders], [80], [95], [40], [10], [0], [0], [0],
  [Projected on-hand], [50], [50], [70], [120], [70], [100], [100],
  [MPS quantity], [100], [120], [130], [150], [80], [150], [110],
  [ATP], [20], [25], [90], [140], [80], [150], [110],
)

ATP at week $t$ = production scheduled for that week minus already-committed customer orders.

== How MPS relates to aggregate plan

The aggregate plan says "produce $X$ units total in October." The MPS distributes $X$ across:
- Specific products (model A, B, C)
- Specific weeks (week 1, 2, 3, 4)

Constraint: $sum_i "MPS"_(i, t) <= $ capacity granted by aggregate plan for period containing $t$.

== Frozen / liquid / planning zones

The MPS is typically divided into three horizons:

- *Frozen zone* (week 1-2): no changes allowed; orders are firm, production committed
- *Slushy / firm zone* (week 3-4): changes require approval
- *Liquid / planning zone* (week 5-8+): can be re-planned freely as new demand information arrives

Frozen-zone duration matches *production lead time* — once you've started making it, you can't easily change.

== MPS feasibility: Rough-Cut Capacity Planning (RCCP)

Before committing to an MPS, check that capacity (workforce, machines, materials) is sufficient. See #link(<supply-chain-planning-rccp>)[RCCP].

== Feeding MRP

The MPS is the *input* to #link(<supply-chain-planning-mrp>)[MRP], which explodes each MPS quantity into component requirements via the bill of materials.

== Common pitfalls

- *Schedule nervousness*: small forecast changes ripple through MPS → MRP → vendor orders. Solution: stable frozen zone + change-control rules
- *Optimistic MPS*: planning to produce more than capacity allows. Solution: RCCP early
- *Ignoring lead times*: scheduling production for week $t$ without checking material arrives by then

== See also

- *#link(<supply-chain-planning-aggregate-planning>)[Aggregate Planning]* — feeds MPS
- *#link(<supply-chain-planning-mrp>)[MRP]* — fed by MPS
- *#link(<supply-chain-planning-rccp>)[RCCP]* — feasibility check
- *#link(<supply-chain-planning-drp>)[DRP]* — distribution-side counterpart
