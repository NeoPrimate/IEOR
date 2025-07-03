
#import "./utils/code.typ": code
#import "./utils/examples.typ": eg

#set heading(numbering: "1.1.")
#set list(indent: 30pt)

#include("./review.typ")

#pagebreak()

#outline(indent: 1em)

#pagebreak()

#include("linear_algebra/linear_algebra.typ")

#include("./calculus/calculus.typ")

#include("./statistics/statistics.typ")

#include("./ieor/ieor.typ")

= Causes of variation

#include "ieor/quality_engineering/variation_causes/common.typ"

#include "ieor/quality_engineering/variation_causes/special.typ"

= Design of Experiments (DOE):

// #include "design_of_experiment/factorial_designs.typ"

// #include "design_of_experiment/response_surface_methodology.typ"

// #include "design_of_experiment/analysis_of_interaction_effects.typ"

= Control Charts:

#include "ieor/quality_engineering/control_charts/p_chart.typ"

#include "ieor/quality_engineering/control_charts/np_chart.typ"

#include "ieor/quality_engineering/control_charts/c_chart.typ"

#include "ieor/quality_engineering/control_charts/u_chart.typ"

#include "ieor/quality_engineering/control_charts/x_chart.typ"

#include "ieor/quality_engineering/control_charts/r_chart.typ"

= Process Capability Analysis

#include "ieor/quality_engineering/process_capability/c_p.typ"

#include "ieor/quality_engineering/process_capability/c_pk.typ"

#include "ieor/quality_engineering/process_capability/c_pm.typ"

#include "ieor/quality_engineering/process_capability/p_p.typ"

#include "ieor/quality_engineering/process_capability/p_pk.typ"

= Inventory Management

#include "ieor/supply_chain/inventory_management/newsvendor.typ"

#include "ieor/supply_chain/inventory_management/abc_analysis.typ"

#include "ieor/supply_chain/inventory_management/fill_rate.typ"

#include "ieor/supply_chain/inventory_management/order_cycle_time.typ"

#include "ieor/supply_chain/inventory_management/reorder_point.typ"

#include "ieor/supply_chain/inventory_management/xyz_analysis.typ"

#include "ieor/supply_chain/inventory_management/eoq.typ"

#include "ieor/supply_chain/inventory_management/perfect_order_rate.typ"

#include "ieor/supply_chain/inventory_management/safety_stock.typ"

= Queuing Theory

#include "ieor/operations_research/queuing_theory/mm1.typ"

// #include "ieor/operations_research/queuing_theory/mmc.typ"

// #include "ieor/operations_research/queuing_theory/md1.typ"

// #include "ieor/operations_research/queuing_theory/mg1.typ"

= Network Optimization

== Shortest Path

#include "ieor/supply_chain/network_optimization/shortest_path/dijkstra.typ"

// #include "ieor/supply_chain/network_optimization/shortest_path/bellman_ford.typ"

== Maximum Flow

#include "ieor/supply_chain/network_optimization/maximum_flow/network_flow.typ"

#include "ieor/supply_chain/network_optimization/maximum_flow/ford_fulkerson.typ"

// #include "ieor/supply_chain/network_optimization/maximum_flow/edmonds_karp.typ"

= Optimization

#include "ieor/operations_research/optimization/cheatsheet.typ"

#include "ieor/operations_research/optimization/linear_programming.typ"

#include "ieor/operations_research/optimization/integer_programming.typ"

#include "ieor/operations_research/optimization/mixed_integer_programming.typ"

#include "ieor/operations_research/optimization/non_linear_programming.typ"

#include "ieor/operations_research/optimization/simplex_method.typ"

#include "ieor/operations_research/optimization/gradient_descent.typ"

// #include "ieor/optimization/mixed_integer_programming.typ"

// #include "ieor/optimization/non_linear_programming.typ"

== Monte Carlo

