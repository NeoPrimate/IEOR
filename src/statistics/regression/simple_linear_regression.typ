#import "../../utils/examples.typ": eg
#import "../../utils/code.typ": code

== Simple linear regression

$
y = beta_0 + beta_1 x_1 + epsilon
$

- $y$: dependent variable
- $x$: independent variables
- $beta_0$: intercept (value of $y$ when $x = 0$)
- $beta_1$: slope (change in $y$ for a one-unit change in $x$)
- $epsilon$: error term (difference between the actual data points and the predicted values)

#eg[

Data

#align(
  center,
  table(
    columns: (auto, auto),
    inset: 10pt,
    align: horizon,
    table.header(
      [$x$ (Hours Studied)], [$y$ (Test Score)]
    ),
    [1], [2],
    [2], [3],
    [3], [5],
    [4], [4],
    [5], [6],
  )

)

*Step 1*: Calculate Means

$
overline(x) = 3
$
$
overline(y) = 4
$

*Step 2*: Calculating Slope $beta_1$

$
beta_1 = (sum_(i=1)^n (x_i - overline(x))(y_i - overline(y))) / (sum_(i=1)^n (x_i - overline(x))^2)
$

- The numerator

$
sum_(i=1)^n (x_i - overline(x))(y_i - overline(y)) = 9
$

- The denominator

$
sum_(i=1)^n (x_i - overline(x))^2 = 10
$

- The slope $beta_1$ is

$
beta_1 = 9 / 10 = 0.9
$

*Step 3*: Calculate Intercept $beta_0$

$
beta_1 = overline(y) - beta_1 overline(x) = 1.3
$


*Step 4*: Calculate p-Value

- Calculate Standard Error of the Slope ($S E_(beta_1)$)

$
S E_(beta_1) = sqrt((sum_(n=1)^n (y_i - hat(y)_i)^2) / ((n - 2) dot sum_(i=1)^n (x_i - overline(x))^2))
$

- Calculate the Residual Sum of Squares (RSS)

$
R S S = sum_(i=1)^n (y_i - hat(y)_i)^2
$

- Calculate the t-statistic for the Slope

$
t = beta_1 / (S E_(beta_1))
$

- Determine Degrees of Freedom

$
"df" = n - 2
$

- Look up the p-value corresponding to $t$ with 3 degrees of freedom

*Step 5*: Calculate $R^2$ ($R^2_"adj"$)

$
R^2 = "SS"_"reg" / "SS"_"total"
$

$"SS"_"reg"$ (Regression Sum of Squares): sum of the squared differences between the predicted $hat(y)$ values and the mean of the observed $y$ values.

$
"SS"_"reg" = sum_(i=1)^n (hat(y)_i - overline(y))^2
$

$"SS"_"total"$ (Total Sum of Squares): sum of the squared differences between the observed $y$ values and the mean of the observed $y$ values.

$
"SS"_"total" = sum_(i=1)^n (y_i - overline(y))^2
$

Adjusting for the numer of independent variables

$
R^2_"adj" = 1 - (((1 - R^2)(n - 1)) / (n - k - 1))
$

- $n$: number of observations
- $k$: number of independent variables

]



