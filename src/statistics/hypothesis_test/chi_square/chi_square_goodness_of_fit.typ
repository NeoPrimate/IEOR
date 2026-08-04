#import "/lib/imports.typ": *
#show: formatting

= Chi-Square Goodness of Fit <statistics_hypothesis_test_chi_square_chi_square_goodness_of_fit>

Compares an *observed* categorical distribution to a *theoretical* categorical distribution.

$
Chi^2 = sum_(i = 1)^k (o_i - e_i)^2 / e_i
$

- $o_i$: *observed* frequency in category $i$
- $e_i$: *expected* frequency in category $i$

$
  "df" = k - 1
$

- $k$: number of categories

#example[
  Your professor gave a hard test. He said 45% got A's, 20% B's, 15% C's, 10% D's and 10% F's. You don't believe him. You take a simple random sample of 60 students and find 20 got A's, 15 B's, 8 O's, 12 D's and 5 F's. At $alpha = 0.05$, test.

  #table(
    columns: 7,
    inset: 1em,
    [Category], [A], [B], [C], [D], [F], [Total], 
    [Expected % ($O_i$)], [45%], [20%], [15%], [10%], [10%], [100%], 
    [Observed \# ($E_i$)], [20], [15], [8], [12], [5], [60], 
    [Expected \#], [$60 dot 0.45 = 27$], [$60 dot 0.20 = 12$], [$60 dot 0.15 = 9$], [$60 dot 0.10 = 6$], [$60 dot 0.10 = 6$], [60], 
    [$(O - E)^2 / E$], [$1.815$], [$0.750$], [$0.111$], [$6.000$], [$0.167$], [], 
  )

  1. Hypothesis

  $
    H_0 &: p_A = 0.45, p_B = 0.20, p_C = 0.15, p_D = 0.10, p_F = 0.10 \
    &wide "(the professor's claimed distribution is correct)" \
    H_a &: "at least one " p_i "differs from its claimed value"
  $

  2. Test Statistic & P-Value

  $
    cal(chi)^2 
    &= sum_(i=1)^n (o_i - e_i)^2 / e_i \
    &= z_A^2 + z_B^2 + z_C^2 + z_D^2 + z_F^2 \
    &= (20 - 27)^2 / 27 + (15 - 12)^2 / 12 + (8 - 9)^2 / 9 + (12 - 6)^2 / 6 + (5 - 6)^2 / 6 \
    &= 1.81 + 0.75 + 0.11 + 6.00 + 0.17 \
    &= 8.84 \
  $

  #let xmin = 0
  #let xmax = 15
  #let k = 5
  #let df = k - 1
  #let a = 0.05

  #let chisq = calc.round(
    calc.pow(20 - 27, 2) / 27 + 
    calc.pow(15 - 12, 2) / 12 + 
    calc.pow(8 - 9, 2) / 9 +
    calc.pow(12 - 6, 2) / 6 +
    calc.pow(5 - 6, 2) / 6,
    digits: 2
  )

  #let crit = calc.round(tystats.chi2.ppf(1 - a, df), digits: 2)

  #let chipdf(x) = tystats.chi2.pdf(x, df)

  #let xgx = lq.linspace(xmin, xmax, num: 300)
  #let xgy = xgx.map(chipdf)

  #let xtail = lq.linspace(chisq, xmax, num: 200)
  #let ytail = xtail.map(chipdf)

  #align(center)[
    #lq.diagram(
      width: 10cm,
      height: 5cm,
      xlim: (xmin, xmax),
      ylim: (0, 0.2),
      yaxis: (ticks: none, subticks: none),
      xaxis: (
        subticks: none,
        ticks: (
          (0, $0$),
          (chisq, box(text(size: 0.7em)[$chi^2$\ #chisq])),
          (crit, box(text(size: 0.7em)[#crit])),
        ),
      ),
      lq.fill-between(xtail, ytail,
        fill: rgb("#c0392b33"), stroke: none),
      lq.plot(xgx, xgy, mark: none, stroke: black),
    )
  ]

  #let p = calc.round(1 - tystats.chi2.cdf(chisq, df), digits: 4)

  $
    p"-value" &= #p \
    alpha &= #a \
    "critical value" &= chi^2_(#a, #df) = #crit \
    chi^2 &= #calc.round(chisq, digits: 3)
  $

  3. Decision

  Since $chi^2 = #calc.round(chisq, digits: 2) < #crit$ (equivalently
  $p = #p > alpha = #a$), we *fail to reject* $H_0$.

  4. Conclusion

  At the $5%$ significance level there is not enough evidence to conclude that
  the professor's claimed grade distribution differs from the true one.
]

#line(length: 100%)

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