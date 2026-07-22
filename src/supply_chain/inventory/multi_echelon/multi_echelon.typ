#import "/lib/imports.typ": *
#show: formatting

= Multi-Echelon <supply_chain_inventory_multi_echelon_multi_echelon>

A supply chain with *multiple stocking points* between supply and demand — e.g., factory → central warehouse → regional DCs → retail stores. Multi-echelon inventory theory studies how to position stock optimally across these levels.

== Why it's harder than single-echelon

Single-echelon models (#link(<supply_chain_inventory_eoq_eoq>)[EOQ], #link(<supply_chain_inventory_newsvendor_overview>)[Newsvendor], #link(<supply_chain_inventory_policies_q_r>)[(Q, r)]) treat each location in isolation. Multi-echelon must handle:

- *Coupled lead times*: a downstream stockout cascades upstream
- *Allocation*: when central inventory runs short, who gets it?
- *Information flow*: does each echelon see end-customer demand or just its downstream orders?
- *Risk pooling*: see #link(<supply_chain_inventory_risk_pooling_risk_pooling>)[Risk Pooling]

== Two main modeling approaches

1. *#link(<supply_chain_inventory_multi_echelon_clark_scarf>)[Clark-Scarf]* — serial system; *stochastic* customer demand; reactive policies (chase demand as it materializes). Backward DP on echelon stocks.

2. *#link(<supply_chain_inventory_multi_echelon_graves_willems>)[Graves-Willems (guaranteed-service)]* — general network (assembly, distribution, serial); *bounded* demand; each stage promises a service time. Forward optimization on safety-stock placement.

A third (less common):

3. *#link(<supply_chain_inventory_multi_echelon_stochastic_service>)[Stochastic-service]* (Lee-Billington, Ettl) — like Graves-Willems but waiting times at upstream stockouts are themselves stochastic, requiring queueing-style analysis.

For *spare parts* with Poisson demand:

4. *#link(<supply_chain_inventory_multi_echelon_metric>)[METRIC]* (Sherbrooke) — multi-echelon repairable items, uses Palm's theorem
5. *#link(<supply_chain_inventory_multi_echelon_vari_metric>)[VARI-METRIC]* (Graves) — METRIC with variance correction at the depot

== Echelon stock vs installation stock

Two ways to count inventory at stage $i$ in a serial system:

- *Installation stock* $I_i$ — what's physically at stage $i$ alone
- *Echelon stock* $E_i = I_i + sum_("downstream stages") I_j + "in-transit"_("downstream")$ — total inventory at stage $i$ *and* everything downstream

Echelon-stock policies (base-stock with echelon target) decouple the multi-echelon problem into a sum of single-echelon problems with adjusted penalty costs — the *Clark-Scarf decomposition*.

== Where it matters

- *Defense logistics* — spare parts for ships, aircraft (the original METRIC application)
- *Retail / e-commerce* — DC vs store inventory
- *Manufacturing* — raw / WIP / finished-goods buffers
- *Service-parts networks* — repair / overhaul / depot

== See also

- *#link(<supply_chain_inventory_multi_echelon_clark_scarf>)[Clark-Scarf]*
- *#link(<supply_chain_inventory_multi_echelon_graves_willems>)[Graves-Willems]*
- *#link(<supply_chain_inventory_risk_pooling_risk_pooling>)[Risk Pooling]*
- *#link(<supply_chain_inventory_policies_base_stock>)[Base Stock Policy]*
