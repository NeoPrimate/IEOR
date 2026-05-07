#import "/lib/imports.typ": *

== Multiple Linear Regression (OLS)

#align(center)[
  #block(
    stroke: 0.5pt + luma(60%),
    radius: 4pt,
    inset: 10pt,
    width: 95%,
  )[
    #set text(size: 9pt)
    *Causal vs. extrapolative.* Time-series methods (SMA, ETS, ARIMA) build a forecast from the demand series alone — extracting level, trend, and seasonality from $x_1, ..., x_t$. *Causal* models flip the framing: demand is *driven* by exogenous regressors (price, weather, promotions, demographics, day-of-week, ...) and we fit a relationship between them.
  ]
]

$
  Y_i = beta_0 + beta_1 x_(1, i) + dots + beta_k x_(k, i) + epsilon_i, quad epsilon_i tilde "iid" cal(N)(0, sigma^2)
$

- *Model parameters* (unknown — to be estimated)
  - $beta_0 in bb(R)$: intercept
  - $beta_j in bb(R)$, $j = 1, ..., k$: slope on regressor $x_j$
  - $sigma^2 > 0$: noise variance
- *Data*
  - $(x_(1, i), ..., x_(k, i), y_i)$ for $i = 1, ..., n$: one row per observation
- *Output*
  - $hat(b)_0, hat(b)_1, ..., hat(b)_k$: fitted coefficients
  - $hat(y)_i = hat(b)_0 + sum_(j=1)^k hat(b)_j x_(j, i)$: predicted value
  - $e_i = y_i - hat(y)_i$: residual

=== Why "least squares"?

Three candidate loss functions for the residuals $e_i = y_i - hat(y)_i$:

#align(center)[
  #table(
    columns: 3,
    inset: 0.7em,
    align: (left, left, left),
    table.header([*Loss*], [*What it captures*], [*Verdict*]),
    [$sum_i e_i$], [Bias only], [Positive and negative errors cancel — useless for accuracy],
    [$sum_i abs(e_i)$], [Bias + accuracy], [No closed-form minimiser — intractable analytically (OK numerically)],
    [$sum_i e_i^2$], [Bias + accuracy + smooth], [*Closed form via calculus* ✓],
  )
]

OLS picks $hat(b)$ to minimise the *Residual Sum of Squares*:

$
  "RSS"(b_0, ..., b_k) = sum_(i=1)^n (y_i - b_0 - b_1 x_(1, i) - dots - b_k x_(k, i))^2
$

For the *univariate* case ($k = 1$), setting first-order conditions to zero gives a clean closed form:

$
  hat(b)_1 = (sum_(i=1)^n (x_i - macron(x))(y_i - macron(y))) / (sum_(i=1)^n (x_i - macron(x))^2), quad hat(b)_0 = macron(y) - hat(b)_1 macron(x)
$

For the *multivariate* case, the same exercise in matrix form yields the *normal equations*:

$
  hat(b) = (X^T X)^(-1) X^T y
$

where $X$ is the $n times (k+1)$ design matrix (a column of ones for the intercept, plus one column per regressor).

=== Goodness of fit ($R^2$)

Total variation in $y$ around its mean splits cleanly into the part the model explains and the part it leaves behind:

$
  underbrace(sum_(i=1)^n (y_i - macron(y))^2, "TSS  (total)")
  = underbrace(sum_(i=1)^n (hat(y)_i - macron(y))^2, "RSS  (regression)")
  + underbrace(sum_(i=1)^n (y_i - hat(y)_i)^2, "ESS  (residual)")
$

The *coefficient of determination* is the fraction of variation the model explains:

$
  R^2 = "RSS" / "TSS" = 1 - "ESS" / "TSS" in [0, 1]
$

- $R^2 = 1$: model fits perfectly (all residuals zero)
- $R^2 = 0$: model no better than predicting $macron(y)$ for everyone

#align(center)[
  #block(
    stroke: 0.5pt + luma(60%),
    radius: 4pt,
    inset: 8pt,
    width: 95%,
  )[
    #set text(size: 9pt)
    *Cautions on $R^2$:*
    - $R^2$ never decreases when you add a regressor → use *adjusted* $R^2 = 1 - (1 - R^2)(n - 1)/(n - k - 1)$ when comparing models of different sizes.
    - High $R^2$ does not imply causality — only that variation co-moves.
    - Each coefficient still needs its own t-test / confidence interval; the F-test on $R^2$ only says "*some* coefficient is non-zero".
  ]
]

#example[
  *Trend + summer dummy on monthly demand* (20 months, Jan year 1 — Aug year 2).

  *Model* — level, linear trend, and a summer indicator:

  $ F_i = beta_0 + beta_1 dot "Period"_i + beta_2 dot "Summer"_i, quad i = 1, ..., 20 $

  where $"Period"_i in {1, ..., 20}$ is a linear time index and $"Summer"_i in {0, 1}$ flags May–Aug.

  *Data*

  #align(center)[
    #set text(size: 8pt)
    #table(
      columns: 8,
      inset: 0.4em,
      align: center + horizon,
      table.header([*Mo.*], [*$y$*], [*$t$*], [*$S$*], [*Mo.*], [*$y$*], [*$t$*], [*$S$*]),
      [Jan], [3 025], [1], [0], [Nov], [3 499], [11], [0],
      [Feb], [3 047], [2], [0], [Dec], [3 598], [12], [0],
      [Mar], [3 079], [3], [0], [Jan], [3 596], [13], [0],
      [Apr], [3 136], [4], [0], [Feb], [3 721], [14], [0],
      [May], [3 454], [5], [1], [Mar], [3 745], [15], [0],
      [Jun], [3 661], [6], [1], [Apr], [3 650], [16], [0],
      [Jul], [3 554], [7], [1], [May], [4 157], [17], [1],
      [Aug], [3 692], [8], [1], [Jun], [4 221], [18], [1],
      [Sep], [3 407], [9], [0], [Jul], [4 238], [19], [1],
      [Oct], [3 410], [10], [0], [Aug], [4 008], [20], [1],
    )
  ]

  *Fit* (e.g. `numpy.linalg.lstsq`, `statsmodels.OLS`, or Excel's regression tool):

  $ hat(F)_i = 2969.14 + 48.03 dot "Period"_i + 303.51 dot "Summer"_i $

  *Diagnostics*
  - $R^2 = 0.958$, adj. $R^2 = 0.953$, residual standard error $approx 79.21$
  - All three coefficients have $p < 0.001$ (t-stats: intercept $79.8$, period $15.0$, summer $8.05$)

  *Interpretation*
  - *Intercept* ($2969$): baseline demand at $"Period" = 0$ in a non-summer month
  - *Period* ($48$): underlying trend adds $approx 48$ units per month
  - *Summer* ($304$): summer months run $approx 304$ units above the trend, holding period fixed

  *Forecast next month* (Sep, $i = 21$, $S = 0$):

  $ hat(F)_21 = 2969.14 + 48.03 (21) + 303.51 (0) = 3977.77 $
]

=== When to reach for OLS

*Strengths:*
- Coefficients are *interpretable* — each one quantifies a specific driver
- Confidence intervals, t-tests, and F-tests come for free
- Easy to fold in exogenous regressors (weather, promotions, demographics, ...) that pure time-series methods cannot consume
- Plays nicely with categorical predictors via dummy variables

*Limitations:*
- Treats every observation equally — no down-weighting of stale data the way SES does
- Linear *in coefficients* (transformations of $x$ help, but the structure is rigid)
- Assumes residuals are iid normal; serial correlation in time-series residuals deflates standard errors (fix: Newey–West SEs, ARMA errors, or fall back to ETS)
- Forecasting future $y$ requires future $x$ — fine when "Period" is the regressor, awkward when it's "weather"
