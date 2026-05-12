#import "/lib/imports.typ": *
#show: formatting

Tests for confirming that a #link(<system-dynamics-system-dynamics>)[system-dynamics] model represents reality usefully. Sterman (2000, Ch. 21) gives a canonical 12-test battery, divided into *structure-oriented* and *behavior-oriented* tests.

== Structure-oriented tests (does the model capture what it should?)

- *Boundary adequacy*: are the right things inside vs outside the model?
- *Structure assessment*: do the relationships match real-world causal structure?
- *Dimensional consistency*: units balance in every equation
- *Parameter assessment*: parameter values consistent with literature and expert estimates
- *Extreme conditions test*: behavior at extremes (zero inventory, infinite capacity) sensible
- *Integration error test*: refine $Delta t$; if behavior changes, integrator is too coarse

== Behavior-oriented tests (does the model produce realistic output?)

- *Behavior reproduction*: match historical / observed data
- *Behavior anomaly*: if you simulate a known anomaly (delay, shock), the model exhibits it
- *Family member*: same structure should explain same phenomena across similar systems
- *Surprise behavior*: model should reveal *new* dynamic patterns not built-in
- *Sensitivity analysis*: behavior changes "reasonably" with parameter perturbations
- *System improvement*: model leads to useful policy insight

== Quantitative fit: Theil's U decomposition

For predicted $hat(y)_t$ vs actual $y_t$:

$
  U = sqrt(("MSE") / (sigma_(hat(y))^2 + sigma_y^2 + (bar(y) - bar(hat(y)))^2))
$

Decomposes MSE into three components:

- $U^M$ (bias): systematic mean error
- $U^S$ (variance): scale of variability
- $U^C$ (covariance): direction / phase

$U^M + U^S + U^C = 1$. Ideal model: $U^M$ and $U^S$ small, $U^C$ large — model captures direction even if magnitudes slightly off.

== Behavior modes matter more than point fits

For SD models, *qualitative behavior* (does it overshoot? oscillate? saturate?) is usually more valuable than precise fit. A model that predicts the *right pattern* of bullwhip with the *wrong amplitude* is better than one with right amplitude but no pattern.

Sterman emphasizes: don't fixate on RMSE; check that the *behavior modes* match.

== Calibration methods

For data-fitting:

- *FIMLOF* (Full Information Maximum Likelihood with Optimal Filtering): rigorous statistical calibration including Kalman-filter-style observation noise
- *Vensim Powell search*: gradient-based optimization on RMSE
- *Bayesian calibration*: posterior distributions over parameters given data

For *decision-rule parameters* (e.g., beer-game $alpha_S, alpha_(S L)$): typically estimated by least-squares from gameplay data.

== Common pitfalls

- *Over-fitting* to historical data — many degrees of freedom in an SD model
- *Ignoring extreme tests* — model "fits" but breaks at boundaries
- *Skipping unit checks* — about half of model bugs are unit errors
- *Confidence over-reach* — SD models are *insightful*, not *predictive* in the forecasting sense

== Sensitivity analysis types

- *Univariate*: vary one parameter at a time; identify high-leverage variables
- *Monte Carlo / Latin Hypercube*: sample parameter combinations; build envelopes of model behavior
- *Tornado diagram*: rank parameters by impact on a metric

== See also

- *#link(<system-dynamics-system-dynamics>)[System Dynamics overview]*
- *#link(<system-dynamics-numerical-integration>)[Numerical Integration]* — integration-error test
- *#link(<statistics-monte-carlo-simulation>)[Monte Carlo Simulation]* — for sensitivity
