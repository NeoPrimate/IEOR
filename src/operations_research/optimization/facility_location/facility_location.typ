#import "/lib/imports.typ": *
#show: formatting

A family of combinatorial optimization problems: *where* should warehouses / stores / hospitals / cell towers be located to best serve known demand?

== Variants

The variants differ by:
- *Objective*: minimize total cost, minimize maximum distance, maximize coverage
- *Constraints*: facility capacity, customer assignment rules
- *Discrete vs continuous*: candidate locations are finite (#link(<operations-research-optimization-p-median>)[$p$-median]) or anywhere in space (#link(<operations-research-optimization-center-of-gravity>)[center of gravity])

#table(
  columns: 3,
  align: (left, left, left),
  stroke: none,
  table.header([Variant], [Objective], [Constraint]),
  [#link(<operations-research-optimization-uflp>)[UFLP]], [min $sum f_j y_j + sum c_(i j) x_(i j)$], [uncapacitated],
  [#link(<operations-research-optimization-cflp>)[CFLP]], [same], [capacity per facility],
  [#link(<operations-research-optimization-p-median>)[$p$-median]], [min total assigned distance], [exactly $p$ facilities],
  [#link(<operations-research-optimization-p-center>)[$p$-center]], [min max distance], [exactly $p$ facilities],
  [#link(<operations-research-optimization-set-covering>)[Set covering]], [min number of facilities], [every demand covered],
  [#link(<operations-research-optimization-max-covering>)[Max covering]], [max demand covered], [exactly $p$ facilities],
  [#link(<operations-research-optimization-center-of-gravity>)[Center of gravity]], [min weighted sum of distances], [single facility, continuous],
)

== Common decision variables

For discrete location problems:

$
  y_j = cases(1 "if facility" j "is opened", 0 "otherwise")
$

$
  x_(i j) = "fraction of demand at" i "served by facility" j "(or 0/1 for single-source)"
$

== Trade-offs

- *Many facilities*: low transport cost, high fixed cost, *less* #link(<supply-chain-risk-pooling-risk-pooling>)[risk pooling]
- *Few facilities*: high transport cost, low fixed cost, more pooling benefit
- *Capacity-constrained*: forces some demand to nearer facilities even when distant ones are cheaper

== Where it shows up

- *Supply chain network design* — DC placement
- *Public service* — fire stations, ambulances, schools (#link(<operations-research-optimization-p-center>)[$p$-center] for response time)
- *Telecom* — cell tower placement (#link(<operations-research-optimization-set-covering>)[set covering])
- *Retail* — store location (#link(<operations-research-optimization-max-covering>)[max covering] under budget)
- *Hub-and-spoke logistics* — depots, airports

== See also

- *#link(<operations-research-optimization-uflp>)[UFLP]* / *#link(<operations-research-optimization-cflp>)[CFLP]* — fixed-charge formulations
- *#link(<operations-research-optimization-p-median>)[$p$-median]* / *#link(<operations-research-optimization-p-center>)[$p$-center]*
- *#link(<operations-research-optimization-set-covering>)[Set Covering]* / *#link(<operations-research-optimization-max-covering>)[Max Covering]*
- *#link(<operations-research-optimization-center-of-gravity>)[Center of Gravity]* — continuous case
- *#link(<operations-research-optimization-daganzo-continuous>)[Daganzo Continuous]* — strategic scale
