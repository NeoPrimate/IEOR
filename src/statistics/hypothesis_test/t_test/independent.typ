#import "../../../utils/examples.typ": eg
#import "../../../utils/code.typ": code

=== Independent

Compares the means of two independent samples.

$
t = (overline(x)_1 - overline(x)_2) / sqrt((s_1^2 / n_1) + (s_2^2 / n_2))
$

- $overline(x)_1$ and $overline(x)_2$: sample means
- $s_1^2$ and $s_2^2$: sample variances
- $s_1$ and $n_2$: sample sizes

#eg[

]

#code(
  "t_test_independent",
  ```python
  from scipy import stats
  rvs1 = stats.norm.rvs(loc=5, scale=10, size=500)
  rvs2 = stats.norm.rvs(loc=5, scale=10, size=500)
  stats.ttest_ind(rvs1, rvs2)
  ```
)