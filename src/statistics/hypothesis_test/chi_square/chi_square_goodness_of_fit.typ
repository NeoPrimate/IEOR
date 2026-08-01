#import "/lib/imports.typ": *
#show: formatting

= Chi-Square Goodness of Fit <statistics_hypothesis_test_chi_square_chi_square_goodness_of_fit>

== Goodness of Fit Test

Compares an *observed* categorical distribution to a *theoretical* categorical distribution.

$
Chi^2 = sum_(i = 1)^k (o_i - e_i)^2 / e_i
$

- $o_i$: observed frequency in category $i$
- $e_i$: expected frequency in category $i$

#example[
  Complaints by Quarter (testing for a uniform distribution)

  #table(
    columns: 6,
    align: center + horizon,
    inset: 1em,
    [], [Q1], [Q2], [Q3], [Q4], [$sum$],
    [$o_i$], [43], [52], [54], [40], [189],
  )

  Under $H_0$ all four quarters are equally likely, so
  $e_i = N \/ k = 189 \/ 4$ for every $i$.

  #table(
    columns: 6,
    align: center + horizon,
    inset: 1em,
    [], [Q1], [Q2], [Q3], [Q4], [$sum$],
    [$o_i$], [43], [52], [54], [40], [189],
    [$e_i$],
      [$189 / 4$], [$189 / 4$], [$189 / 4$], [$189 / 4$], [189],
  )

  #table(
    columns: 6,
    align: center + horizon,
    inset: 1em,
    [], [Q1], [Q2], [Q3], [Q4], [$sum$],
    [$o_i$], [43], [52], [54], [40], [189],
    [$e_i$], [$47.25$], [$47.25$], [$47.25$], [$47.25$], [189],
  )

  #table(
    columns: 6,
    align: center + horizon,
    inset: 1em,
    [],
      [$(43 - 47.25)^2 / 47.25$],
      [$(52 - 47.25)^2 / 47.25$],
      [$(54 - 47.25)^2 / 47.25$],
      [$(40 - 47.25)^2 / 47.25$],
      [$sum$],
    [], [$0.38$], [$0.48$], [$0.96$], [$1.11$], [$bold(2.94)$],
  )

  $
    Chi^2 = 0.38 + 0.48 + 0.96 + 1.11 = 2.94
  $

  $"df" = k - 1 = 3$, and $Chi^2_(0.05, 3) = 7.815$. Since
  $2.94 < 7.815$ we fail to reject $H_0$ ($p approx 0.40$):
  the complaints are consistent with a uniform distribution
  across quarters.
]

#code(
  "chi2_got.py",
  ```python
  from scipy import stats
  f_obs = np.array([43, 52, 54, 40])
  f_exp = np.array([47, 47, 47, 47])
  stats.chisquare(f_obs=f_obs, f_exp=f_exp)
  ```
)