#import "../../utils/examples.typ": eg
#import "../../utils/code.typ": code

== R-squared

Proportion of variance explained by the model

$
R^2 = 1 - (sum_(i=1)^n (y_i - hat(y)_i)^2) / (sum_(i=1)^n (y_i - overline(y)_i)^2)
$

- 1: model explains all the variance in the dependent variable

- 0: model explains none of the variance in the dependent variable


#eg[
  *Step 1*: Fit the Regression Model

  *Step 2*: Compute *Total Sum of Squares* (SST)

  $
  "SST" = sum_(i=1)^n (y_i - overline(y))^2
  $

  #figure(image("../../vis/total_sum_squares.png", width: 50%))

  *Step 3*: Compute *Regression Sum of Squares* (SSR)

  $
  "SSR" = sum_(i=1)^n = (hat(y)_i - overline(y))^2
  $

  #figure(image("../../vis/regression_sum_squares.png", width: 50%))

  *Step 4*: Compute *Residual Sum of Squares* (SSE)

  $
  "SSE" = sum_(i=1)^n = (y_i - hat(y)_i)^2
  $

  #figure(image("../../vis/residual_sum_squares.png", width: 50%))

  *Step 5*: Calculate *$R^2$*

  $
  R^2 = "SSR" / "SST" = 1 - "SSE" / "SST"
  $
]

== Adj R-squared

Adjusts the  $R^2$  value based on the number of predictors (penalty for adding non-informative variables)

$
"Adj" R^2 = 1 - (1 - R^2) (n - 1) / (n - p - 1)
$


