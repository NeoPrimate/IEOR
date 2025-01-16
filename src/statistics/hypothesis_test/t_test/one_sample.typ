#import "../../../utils/examples.typ": eg
#import "../../../utils/code.typ": code

=== One-sample

Tests if the mean of a single sample differs from a known or hypothesized population mean.

$
t = (overline(x) - mu_0) / (s / sqrt(n))
$

- $overline(x)$: sample mean
- $mu_0$: hypothesized population mean
- $s$: sample standard deviation
- $n$: sample size

#eg[

$
[78, 82, 89]
$

Step 1: State Hypotheses

$
H_0: mu = 85 "cm"
$
$
H_1: mu ≠ 85 "cm"
$

Step 2: Summarize Data

- Sample values: 

$ x_1 = 78, x_2 = 82, x_3 = 89 $

- Sample size:

$ n = 3 $

Step 3: Calculate Sample Mean ($overline(x)$)

$ overline(x) = (x_1 + x_2 + x_3) / n = (78 + 82 + 89) / 3 = 83 $

Step 4: Calculate Sample Standard Deviation:

$ s = sqrt((sum_(i=1)^n (x_i - overline(x))^2) / (n - 1)) $

- Find the deviations from the mean and square them

$ (x_1 - overline(x))^2 = (78 - 83)^2 = (-5)^2 = 25 $
$ (x_2 - overline(x))^2 = (82 - 83)^2 = (-1)^2 = 1 $
$ (x_3 - overline(x))^2 = (89 - 83)^2 = (6)^2 = 36 $

- Sum of squared deviations

$ "SSD" = 25 + 1 + 36 $

- Calculate variance of sample

$ s^2 = "SSD" / (n - 1) = 62 / (3 - 1) = 62 / 2 = 31 $

- Calculate Sample Standard Deviation

$ s = sqrt(s^2) = sqrt(32) = 5.57 $

Step 5: Calculate the Test Statistic

$
t = (overline(x) - mu_0) / (s / sqrt(n)) = (83 - 85) / (5.57 / sqrt(3)) = -3 / 3.22 = -0.62
$

Step 6: Determine the Degrees of Freedom

$
d f = n - 1 = 15 - 1 = 14
$

Step 7: Find Critical t-value

- For a two-tailed test at a significance level ($alpha$) of 0.05 and 2 degrees of freedom ($d f$)

$ 4.303 $


Step 8: Compare the t-Value to the Critical t-Value

- If the absolute value of the test statistic is greater than the critical t-value, reject the null hypothesis.
- If the absolute value of the test statistic is less than the critical t-value, fail to reject the null hypothesis.

Step 8: Find the p-Value

$
t = 4.303 "and" d f = 3
$

$
"p-value" = 0.58
$


]

#code[
  ```python
  from scipy import stats
  rvs = stats.uniform.rvs(size=50)
  stats.ttest_1samp(rvs, popmean=0.5)

  ```
]