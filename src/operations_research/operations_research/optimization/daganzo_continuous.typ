#import "/lib/imports.typ": *

A *continuous-approximation* approach to large-scale routing and logistics design (Daganzo, 1984+). Replaces discrete combinatorial optimization with closed-form formulas — sacrifices exactness for *insight* and *fast strategic design*.

== The key formula: route length

For $n$ customers uniformly distributed in a region of area $A$, the *expected length of an optimal TSP tour* satisfies:

$
  L approx k sqrt(n A)
$

with $k approx 0.71$ (the *Beardwood-Halton-Hammersley constant*). For uniform Euclidean instances, this constant has been studied extensively.

For *VRP*: each vehicle visits $approx Q$ customers (where $Q$ is capacity in number of customers). Number of routes $= n / Q$. Each route length:

$
  L_("route") approx 2 r + 0.57 sqrt(Q A_("zone"))
$

where $r$ is depot-to-zone distance and $A_("zone")$ is the area of the zone the route covers.

== Why useful

- *Strategic design*: how many vehicles? How big should zones be? Optimal depot location?
- *Sensitivity analysis*: $d L / d n$, etc.
- *Fast benchmarking*: compare network designs without solving thousands of VRPs

== Square-root facility-location model

For a region with demand density $rho$ and warehouse fixed cost $f$, the optimal *number of facilities* $N^*$ minimizes:

$
  N f + 0.71 sqrt(rho A / N) #h(0.5em) "(transport cost per customer scaled by sqrt(area / N))"
$

Differentiating and solving:

$
  N^* prop sqrt(rho A f^(-2/3))
$

— larger regions / denser demand / lower facility cost → more facilities. *Square-root scaling*: doubling demand doesn't double facility count; it multiplies by $sqrt(2)$.

== Other Daganzo formulas

- *Headway design* in transit / dispatching: $H^* = sqrt(2 (c_s + c_h) / (lambda c_w))$ for cost-of-waiting / dispatch trade-off
- *Hub-spoke vs direct shipping*: cost crossover conditions
- *One-to-many vs many-to-many distribution*

These give *order-of-magnitude correct* answers in seconds, useful when:
- The detailed instance isn't known yet (strategic phase)
- Quick comparison of network designs is needed
- Sensitivity to a parameter matters more than exact cost

== Limitations

- *Uniform / smooth demand* assumed — clustering breaks formulas
- *Continuous approximation* — discrete fleet sizes round
- *No time windows / capacities* in basic forms (extensions exist)
- Less useful for *operational* (day-to-day) routing than for *strategic* design

== Where it shows up

- *Logistics network design* — placing DCs, sizing warehouses
- *Public transit planning* — bus / rail / paratransit
- *Last-mile design* — Amazon, UPS strategic network choices
- *Reference for VRP heuristic benchmarking*

== See also

- *#link(<operations-research-optimization-vrp>)[VRP]* — operational counterpart
- *#link(<operations-research-optimization-clarke-wright>)[Clarke-Wright]* — operational heuristic
- *#link(<supply-chain-risk-pooling-location-pooling>)[Location Pooling]* — strategic trade-off Daganzo formalizes
