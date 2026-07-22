#import "/lib/imports.typ": *
#show: formatting

= Facility Location <operations_research_optimization_facility_location_facility_location>

A family of combinatorial optimization problems: *where* should warehouses / stores / hospitals / cell towers be located to best serve known demand?

== Variants

The variants differ by:
- *Objective*: minimize total cost, minimize maximum distance, maximize coverage
- *Constraints*: facility capacity, customer assignment rules
- *Discrete vs continuous*: candidate locations are finite (#link(<operations_research_optimization_facility_location_p_median>)[$p$-median]) or anywhere in space (#link(<operations_research_optimization_facility_location_center_of_gravity>)[center of gravity])

#table(
  columns: 3,
  align: (left, left, left),
  stroke: none,
  table.header([Variant], [Objective], [Constraint]),
  [#link(<operations_research_optimization_facility_location_uflp>)[UFLP]], [min $sum f_j y_j + sum c_(i j) x_(i j)$], [uncapacitated],
  [#link(<operations_research_optimization_facility_location_cflp>)[CFLP]], [same], [capacity per facility],
  [#link(<operations_research_optimization_facility_location_p_median>)[$p$-median]], [min total assigned distance], [exactly $p$ facilities],
  [#link(<operations_research_optimization_facility_location_p_center>)[$p$-center]], [min max distance], [exactly $p$ facilities],
  [#link(<operations_research_optimization_facility_location_set_covering>)[Set covering]], [min number of facilities], [every demand covered],
  [#link(<operations_research_optimization_facility_location_max_covering>)[Max covering]], [max demand covered], [exactly $p$ facilities],
  [#link(<operations_research_optimization_facility_location_center_of_gravity>)[Center of gravity]], [min weighted sum of distances], [single facility, continuous],
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

- *Many facilities*: low transport cost, high fixed cost, *less* #link(<supply_chain_inventory_risk_pooling_risk_pooling>)[risk pooling]
- *Few facilities*: high transport cost, low fixed cost, more pooling benefit
- *Capacity-constrained*: forces some demand to nearer facilities even when distant ones are cheaper

== Where it shows up

- *Supply chain network design* — DC placement
- *Public service* — fire stations, ambulances, schools (#link(<operations_research_optimization_facility_location_p_center>)[$p$-center] for response time)
- *Telecom* — cell tower placement (#link(<operations_research_optimization_facility_location_set_covering>)[set covering])
- *Retail* — store location (#link(<operations_research_optimization_facility_location_max_covering>)[max covering] under budget)
- *Hub-and-spoke logistics* — depots, airports

== See also

- *#link(<operations_research_optimization_facility_location_uflp>)[UFLP]* / *#link(<operations_research_optimization_facility_location_cflp>)[CFLP]* — fixed-charge formulations
- *#link(<operations_research_optimization_facility_location_p_median>)[$p$-median]* / *#link(<operations_research_optimization_facility_location_p_center>)[$p$-center]*
- *#link(<operations_research_optimization_facility_location_set_covering>)[Set Covering]* / *#link(<operations_research_optimization_facility_location_max_covering>)[Max Covering]*
- *#link(<operations_research_optimization_facility_location_center_of_gravity>)[Center of Gravity]* — continuous case
- *#link(<operations_research_optimization_routing_daganzo_continuous>)[Daganzo Continuous]* — strategic scale
