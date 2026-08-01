#import "/lib/imports.typ": *
#show: formatting

= Chi-Square Independence <statistics_hypothesis_test_chi_square_chi_square_independence>

== Test of independence

Compares two *observed* categorical distributions.

$
Chi^2 = sum_(i=1)^k (o_(i j) - e_(i j))^2 / e_(i j)
$

- $o_(i j)$: observed frequency in cell $(i, j)$
- $e_(i j)$: expected frequency in category $(i, j)$ calculated as: 

$
E_(i j) = (R_i times C_j) / N
$

- $R_i$: Row total for row $i$
- $C_j$: Column total for column $j$
- $N$: Total number of observations

#example[
  Genre Preference by Age Group

  #table(
    columns: 5,
    align: center + horizon,
    inset: 1em,
    [], [Action], [Comedy], [Drama], [],
    [Under 30], [60], [50], [30], [140],
    [Above 30], [20], [40], [60], [120],
    [], [80], [90], [90], [260],
  )

  #table(
    columns: 5,
    align: center + horizon,
    inset: 1em,
    [], [Action], [Comedy], [Drama], [],
    [Under 30],
      [$(140 dot 80) / 260$],
      [$(140 dot 90) / 260$],
      [$(140 dot 90) / 260$],
      [140],
    [Above 30],
      [$(120 dot 80) / 260$],
      [$(120 dot 90) / 260$],
      [$(120 dot 90) / 260$],
      [120],
    [], [80], [90], [90], [260],
  )
  
  #table(
    columns: 5,
    align: center + horizon,
    inset: 1em,
    [], [Action], [Comedy], [Drama], [],
    [Under 30],
      [$43.08$],
      [$48.46$],
      [$48.46$],
      [140],
    [Above 30],
      [$36.92$],
      [$41.54$],
      [$41.54$],
      [120],
    [], [80], [90], [90], [260],
  )
  
  #table(
    columns: 5,
    align: center + horizon,
    inset: 1em,
    [], [Action], [Comedy], [Drama], [],
    [Under 30],
      [$(60 - 43.08)^2 / 43.08$],
      [$(50 - 48.46)^2 / 48.46$],
      [$(30 - 48.46)^2 / 48.46$],
      [140],
    [Above 30],
      [$(20 - 36.92)^2 / 36.92$],
      [$(40 - 41.54)^2 / 41.54$],
      [$(60 - 41.54)^2 / 41.54$],
      [120],
    [], [80], [90], [90], [260],
  )

  #table(
    columns: 5,
    align: center + horizon,
    inset: 1em,
    [], [Action], [Comedy], [Drama], [$sum$],
    [Under 30], [$6.65$], [$0.05$], [$7.03$], [$13.73$],
    [Above 30], [$7.76$], [$0.06$], [$8.21$], [$16.02$],
    [$sum$], [$14.40$], [$0.11$], [$15.24$], [$bold(29.75)$],
  )

  $
    "Chi"^2 = 6.65 + 0.05 + 7.03 + 7.76 + 0.06 + 8.21 = 29.75
  $

  Since $Chi^2 = 29.75 > Chi^2_(0.05, 2) = 5.991$, reject $H_0$: genre
  preference depends on age group, driven almost entirely by action and
  drama ($14.40$ and $15.24$) rather than comedy ($0.11$).
]