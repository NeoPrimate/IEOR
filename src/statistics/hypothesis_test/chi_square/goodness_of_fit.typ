#import "../../../utils/examples.typ": eg
#import "../../../utils/code.typ": code

=== Goodness of Fit Test

Compares an *observed* categorical distribution to a *theoretical* categorical distribution.

$
Chi^2 = sum_(i = 1)^k (o_i - e_i)^2 / e_i
$

- $o_i$: observed frequency in category $i$
- $e_i$: expected frequency in category $i$

#code(
  "chi2_got.py",
  ```python
  from scipy import stats
  f_obs = np.array([43, 52, 54, 40])
  f_exp = np.array([47, 47, 47, 47])
  stats.chisquare(f_obs=f_obs, f_exp=f_exp)
  ```
)