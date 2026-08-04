#import "/lib/imports.typ": *
#show: formatting

= Chi-Square Independence <statistics_hypothesis_test_chi_square_chi_square_independence>

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

$
  "df" = ("rows" - 1)("cols" - 1)
$

#example[
  You own a café, and you think you can make more money by getting people to buy larger drinks in the morning. You want to see if the time of day and coffee size are related, so you collect a simple random sample of last month's orders. The observed data is below. At $alpha = 0.05$ test if they are related.

  #table(
    columns: 5,
    inset: 1em,
    [*Observed*], [Small], [Medium], [Large], [Total],
    [Morning], [7], [14], [29], [50],
    [Afternoon], [7], [7], [15], [29],
    [Evening], [10], [7], [4], [21],
    [Total], [24], [28], [48], [100],
  )

  $
    "expected" = ("row total" times "col total") / "table total"
  $
  
  #table(
    columns: 5,
    inset: 1em,
    [*Expected*], [Small], [Medium], [Large], [Total],
    [Morning], [$(50 dot 24) / 100 = 12$], [$(50 dot 28) / 100 = 14$], [$(50 dot 48) / 100 = 24$], [50],
    [Afternoon], [$(29 dot 24) / 100 = 6.96$], [$(29 dot 28) / 100 = 8.12$], [$(29 dot 48) / 100 = 13.92$], [29],
    [Evening], [$(21 dot 24) / 100 = 5.04$], [$(21 dot 28) / 100 = 5.88$], [$(21 dot 48) / 100 = 10.08$], [21],
    [Total], [24], [28], [48], [100],
  )


  $
    H_0 &: "the two variables are independent" \
    H_a &: "the 2 variables are related" \
  $

  $
    cal(chi)^2 
    &= &&(7 - 12)^2 / 12 + 
    (14 - 14)^2 / 14 + 
    (29 - 24)^2 / 24 + \
    & &&(7 - 6.96)^2 / 6.96 + 
    (7 - 8.12)^2 / 8.12 +
    (15 - 13.92)^2 / 13.92 + \
    & &&(10 - 5.04)^2 / 5.04 + 
    (7 - 5.88)^2 / 5.88 + 
    (4 - 10.08)^2 / 10.08 \
    &= && 12.13
  $

  #let xmin = 0
  #let xmax = 15
  #let k = 5
  #let rows = 3
  #let cols = 3
  #let df = (rows - 1) * (cols - 1)
  #let a = 0.05

  #let crit = calc.round(tystats.chi2.ppf(1 - a, df), digits: 2)

  #let chisq = calc.round(
    calc.pow(7 - 12, 2) / 12 + 
    calc.pow(14 - 14, 2) / 14 + 
    calc.pow(29 - 24, 2) / 24 + 
    calc.pow(7 - 6.96, 2) / 6.96 + 
    calc.pow(7 - 8.12, 2) / 8.12 +
    calc.pow(15 - 13.92, 2) / 13.92 + 
    calc.pow(10 - 5.04, 2) / 5.04 + 
    calc.pow(7 - 5.88, 2) / 5.88 + 
    calc.pow(4 - 10.08, 2) / 10.08
    ,
    digits: 2
  )

  #let p = calc.round(1 - tystats.chi2.cdf(chisq, df), digits: 4)

  #let chipdf(x) = tystats.chi2.pdf(x, df)

  #let xgx = lq.linspace(xmin, xmax, num: 300)
  #let xgy = xgx.map(chipdf)

  #let xtail = lq.linspace(crit, xmax, num: 200)
  #let ytail = xtail.map(chipdf)
  
  #let xp = lq.linspace(chisq, xmax, num: 200)
  #let yp = xp.map(chipdf)

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
      lq.fill-between(xtail, ytail, fill: rgb("#c0392b33"), stroke: none),
      lq.fill-between(xp, yp, fill: rgb("#c0392b33"), stroke: none),
      lq.plot(xgx, xgy, mark: none, stroke: black),
    )
  ]
  
  #let rejection_region = calc.round(1 - tystats.chi2.cdf(crit, df), digits: 4)

  p-value < alpha
  
  #p < #rejection_region

  Critical value < Chi^2 statistic

  #crit < #chisq

]


#line(length: 100%)

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