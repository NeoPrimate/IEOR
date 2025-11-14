#import "../utils/title_page.typ": title_page

#title_page("Statistics")

= Descriptive Statistics

== Central Tendency

#include("./desciptive_statistics/central_tendency/mean.typ")

#include("./desciptive_statistics/central_tendency/median.typ")

#include("./desciptive_statistics/central_tendency/mode.typ")

== Dispersion

#include("./desciptive_statistics/dispersion/range.typ")

#include("./desciptive_statistics/dispersion/variance.typ")

#include("./desciptive_statistics/dispersion/standard_deviation.typ")

#include("./desciptive_statistics/dispersion/interquartile_range.typ")

= Probability Distributions

#include("./distributions/gaussian.typ")

#include("./distributions/t.typ")

#include("./distributions/binomial.typ")

#include("./distributions/poisson.typ")

#include("./distributions/exponential.typ")

= Functions

#include("./functions/pdf.typ")

#include("./functions/pmf.typ")

// #include("./functions/cf.typ")

// #include("./functions/mgf.typ")

#include("./functions/cdf.typ")

#include("./functions/ppf.typ")

#include("./functions/sf.typ")

// #include("./functions/hf.typ")

// #include("./functions/llf.typ")

// #include("./functions/rf.typ")

= Error Metrics

#include("./error_metrics/mae.typ")

#include("./error_metrics/mse.typ")

#include("./error_metrics/rmse.typ")

#include("./error_metrics/mape.typ")

#include("./error_metrics/r_square.typ")

#include("./error_metrics/msle.typ")

// #include("./error_metrics/hinge_loss.typ")

#include("./error_metrics/cross_entropy_loss.typ")

// #include("./error_metrics/huber_loss.typ")

= Hypothesis Testing

== Hypotheses

#include("./hypothesis_test/hypotheses/null.typ")

#include("./hypothesis_test/hypotheses/alternative.typ")

== Error Types

#include("./hypothesis_test/error_types/type_1.typ")

#include("./hypothesis_test/error_types/type_2.typ")

== t-Tests

#include("./hypothesis_test/t_test/one_sample.typ")

#include("./hypothesis_test/t_test/independent.typ")

#include("./hypothesis_test/t_test/paired.typ")

== Chi-square tests

#include("./hypothesis_test/chi_square/goodness_of_fit.typ")

#include("./hypothesis_test/chi_square/independence.typ")

== ANOVA (Analysis of Variance)

#include("./hypothesis_test/anova/one_way.typ")

#include("./hypothesis_test/anova/two_way.typ")

= Regression Analysis:

#include("./regression/simple_linear_regression.typ")

#include("./regression/multiple_linear_regression.typ")

#include("./regression/logistic_regression.typ")

== Model diagnostics

#include("./hypothesis_test/model_diagnostics/p_value.typ")

#include("./hypothesis_test/model_diagnostics/f_statistic.typ")

#include("./hypothesis_test/model_diagnostics/confidence_intervals.typ")

= Correlation

#include("./correlation/pearson.typ")

#include("./correlation/spearman_rank.typ")

// #include("./correlation/cross_correlation.typ")

= Non-Parametric Statistics

#include("./non_parametric/mann_whitney_u.typ")

#include("./non_parametric/wilcoxon_signed_rank.typ")

#include("./non_parametric/komogorov_smirnov.typ")

#include("./non_parametric/kruskal_wallis.typ")

// #include("./non_parametric/friedman.typ")

= Time Series

#include("./time_series/simple_moving_average.typ")

#include("./time_series/weighted_moving_average.typ")

#include("./time_series/exponential_smoothing.typ")

#include("./time_series/seasonal_decomposition.typ")

#include("./time_series/arma.typ")

#include("./time_series/arima.typ")

