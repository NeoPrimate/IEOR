
#import "./utils/code.typ": code
#import "./utils/examples.typ": eg

#set heading(numbering: "1.1.")
#set list(indent: 30pt)

#outline(indent: true)

#pagebreak()

= Linear Algebra 

#include "linear_algebra/vectors.typ"

#include "linear_algebra/matrices.typ"

#include "linear_algebra/eigenvectors_eigenvalues.typ"

= Calculus

#include "calculus/fundamental_theorem.typ"

#include "calculus/differential/rules.typ"

#include "calculus/integral/rules.typ"

= Causes of variation

#include "industrial_engineering/quality_engineering/variation_causes/common.typ"

#include "industrial_engineering/quality_engineering/variation_causes/special.typ"

= Probability Theory

#include "statistics/probability_theory/axioms.typ"

#include "statistics/probability_theory/rules.typ"

#include "statistics/probability_theory/bayes_theorem.typ"

= Descriptive Statistics

== Central Tendency

#include "statistics/desciptive_statistics/central_tendency/mean.typ"

#include "statistics/desciptive_statistics/central_tendency/median.typ"

#include "statistics/desciptive_statistics/central_tendency/mode.typ"

== Dispersion

#include "statistics/desciptive_statistics/dispersion/range.typ"

#include "statistics/desciptive_statistics/dispersion/variance.typ"

#include "statistics/desciptive_statistics/dispersion/standard_deviation.typ"

#include "statistics/desciptive_statistics/dispersion/interquartile_range.typ"

= Probability Distributions

#include "statistics/distributions/gaussian.typ"

#include "statistics/distributions/t.typ"

#include "statistics/distributions/binomial.typ"

#include "statistics/distributions/poisson.typ"

#include "statistics/distributions/exponential.typ"

= Functions

#include "statistics/functions/pdf.typ"

#include "statistics/functions/pmf.typ"

// #include "statistics/functions/cf.typ"

// #include "statistics/functions/mgf.typ"

#include "statistics/functions/cdf.typ"

#include "statistics/functions/ppf.typ"

#include "statistics/functions/sf.typ"

// #include "statistics/functions/hf.typ"

// #include "statistics/functions/llf.typ"

// #include "statistics/functions/rf.typ"

= Error Metrics

#include "statistics/error_metrics/mae.typ"

#include "statistics/error_metrics/mse.typ"

#include "statistics/error_metrics/rmse.typ"

#include "statistics/error_metrics/mape.typ"

#include "statistics/error_metrics/r_square.typ"

#include "statistics/error_metrics/msle.typ"

// #include "statistics/error_metrics/hinge_loss.typ"

#include "statistics/error_metrics/cross_entropy_loss.typ"

// #include "statistics/error_metrics/huber_loss.typ"

= Hypothesis Testing

== Hypotheses

#include "statistics/hypothesis_test/hypotheses/null.typ"

#include "statistics/hypothesis_test/hypotheses/alternative.typ"

== Error Types

#include "statistics/hypothesis_test/error_types/type_1.typ"

#include "statistics/hypothesis_test/error_types/type_2.typ"

== t-Tests

#include "statistics/hypothesis_test/t_test/one_sample.typ"

#include "statistics/hypothesis_test/t_test/independent.typ"

#include "statistics/hypothesis_test/t_test/paired.typ"

== Chi-square tests

#include "statistics/hypothesis_test/chi_square/goodness_of_fit.typ"

#include "statistics/hypothesis_test/chi_square/independence.typ"

== ANOVA (Analysis of Variance)

#include "statistics/hypothesis_test/anova/one_way.typ"

#include "statistics/hypothesis_test/anova/two_way.typ"

= Regression Analysis:

#include "statistics/regression/simple_linear_regression.typ"

#include "statistics/regression/multiple_linear_regression.typ"

#include "statistics/regression/logistic_regression.typ"

== Model diagnostics

#include "statistics/hypothesis_test/model_diagnostics/p_value.typ"

#include "statistics/hypothesis_test/model_diagnostics/f_statistic.typ"

#include "statistics/hypothesis_test/model_diagnostics/confidence_intervals.typ"

= Design of Experiments (DOE):

// #include "design_of_experiment/factorial_designs.typ"

// #include "design_of_experiment/response_surface_methodology.typ"

// #include "design_of_experiment/analysis_of_interaction_effects.typ"

= Control Charts:

#include "industrial_engineering/quality_engineering/control_charts/p_chart.typ"

#include "industrial_engineering/quality_engineering/control_charts/np_chart.typ"

#include "industrial_engineering/quality_engineering/control_charts/c_chart.typ"

#include "industrial_engineering/quality_engineering/control_charts/u_chart.typ"

#include "industrial_engineering/quality_engineering/control_charts/x_chart.typ"

#include "industrial_engineering/quality_engineering/control_charts/r_chart.typ"

= Process Capability Analysis

#include "industrial_engineering/quality_engineering/process_capability/c_p.typ"

#include "industrial_engineering/quality_engineering/process_capability/c_pk.typ"

#include "industrial_engineering/quality_engineering/process_capability/c_pm.typ"

#include "industrial_engineering/quality_engineering/process_capability/p_p.typ"

#include "industrial_engineering/quality_engineering/process_capability/p_pk.typ"

= Correlation

#include "statistics/correlation/pearson.typ"

#include "statistics/correlation/spearman_rank.typ"

// #include "statistics/correlation/cross_correlation.typ"

= Non-Parametric Statistics

#include "statistics/non_parametric/mann_whitney_u.typ"

#include "statistics/non_parametric/wilcoxon_signed_rank.typ"

#include "statistics/non_parametric/komogorov_smirnov.typ"

#include "statistics/non_parametric/kruskal_wallis.typ"

// #include "statistics/non_parametric/friedman.typ"

= Time Series

#include "statistics/time_series/simple_moving_average.typ"

#include "statistics/time_series/weighted_moving_average.typ"

#include "statistics/time_series/exponential_smoothing.typ"

#include "statistics/time_series/seasonal_decomposition.typ"

#include "statistics/time_series/arma.typ"

#include "statistics/time_series/arima.typ"

= Inventory Management

#include "industrial_engineering/supply_chain/inventory_management/newsvendor.typ"

#include "industrial_engineering/supply_chain/inventory_management/abc_analysis.typ"

#include "industrial_engineering/supply_chain/inventory_management/fill_rate.typ"

#include "industrial_engineering/supply_chain/inventory_management/order_cycle_time.typ"

#include "industrial_engineering/supply_chain/inventory_management/reorder_point.typ"

#include "industrial_engineering/supply_chain/inventory_management/xyz_analysis.typ"

#include "industrial_engineering/supply_chain/inventory_management/eoq.typ"

#include "industrial_engineering/supply_chain/inventory_management/perfect_order_rate.typ"

#include "industrial_engineering/supply_chain/inventory_management/safety_stock.typ"

= Queuing Theory

#include "industrial_engineering/operations_research/queuing_theory/mm1.typ"

// #include "industrial_engineering/operations_research/queuing_theory/mmc.typ"

// #include "industrial_engineering/operations_research/queuing_theory/md1.typ"

// #include "industrial_engineering/operations_research/queuing_theory/mg1.typ"

= Network Optimization

== Shortest Path

// #include "industrial_engineering/supply_chain/network_optimization/shortest_path/dijkstra.typ"

// #include "industrial_engineering/supply_chain/network_optimization/shortest_path/bellman_ford.typ"

== Maximum Flow

#include "industrial_engineering/supply_chain/network_optimization/maximum_flow/network_flow.typ"

#include "industrial_engineering/supply_chain/network_optimization/maximum_flow/ford_fulkerson.typ"

// #include "industrial_engineering/supply_chain/network_optimization/maximum_flow/edmonds_karp.typ"

= Optimization

#include "industrial_engineering/operations_research/optimization/linear_programming.typ"

#include "industrial_engineering/operations_research/optimization/integer_programming.typ"

#include "industrial_engineering/operations_research/optimization/gradient_descent.typ"

// #include "industrial_engineering/optimization/mixed_integer_programming.typ"

// #include "industrial_engineering/optimization/non_linear_programming.typ"

== Monte Carlo

