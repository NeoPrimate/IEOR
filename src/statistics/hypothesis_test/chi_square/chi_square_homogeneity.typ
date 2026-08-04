#import "/lib/imports.typ": *
#show: formatting

= Chi-Square Homogeneity <statistics_hypothesis_test_chi_square_chi_square_homogeneity>

$
  cal(chi)^2 = sum_(i=1)^n (O_i - E_i) / E_i
$

#example[
  There are 2 professors that teach the type of class you are taking. You think your professor is great, but your friend thinks hers is better. To decide if there is a difference in each class, you take a simple random sample of 50 students from each class. The observed grades for each class is below. At $alpha = 0.05$ test if there is a difference.

  #table(
    columns: 7,
    inset: 1em,
    [Observed], [A], [B], [C], [D], [E], [F], 
    [Professor 1], [13], [13], [9], [8], [7], [50], 
    [Professor 2], [17], [3], [17], [10], [3], [50], 
    [Total], [30], [16], [26], [18], [10], [100], 
  )

  $
    "Expected" = ("row total" times "col total") / "table total"
  $
  
  #table(
    columns: 7,
    inset: 1em,
    [Observed], [A], [B], [C], [D], [E], [F], 
    [Professor 1], [$(50 dot 30) / 100 = 15$], [$(50 dot 16) / 100 = 8$], [$(50 dot 26) / 100 = 13$], [$(50 dot 18) / 100 = 9$], [$(50 dot 10) / 100 = 5$], [50], 
    [Professor 2], [$(50 dot 30) / 100 = 15$], [$(50 dot 16) / 100 = 8$], [$(50 dot 26) / 100 = 13$], [$(50 dot 18) / 100 = 9$], [$(50 dot 10) / 100 = 5$], [50], 
    [Total], [30], [16], [26], [18], [10], [100], 
  )

  #let xmin = 0
  #let xmax = 15
  #let k = 5
  #let df = k - 1
  #let a = 0.05

  $
    H_0 &: "Grade dists. are equal" \
    H_a &: "Grade dists. are not equal" \
  $

  $
    cal(chi)^2 = 
    (13 - 15)^2 / 15 + 
    (13 - 8)^2 / 8 + 
    (9 - 13)^2 / 13 + 
    (8 - 9)^2 / 9 + 
    (7 - 5)^2 / 5 + \
    (17 - 15)^2 / 15 + 
    (3 - 8)^2 / 8 + 
    (17 - 13)^2 / 13 + 
    (10 - 9)^2 / 9 + 
    (3 - 5)^2 / 5
  $

  #let crit = calc.round(tystats.chi2.ppf(1 - a, df), digits: 2)

  #let chisq = calc.round(
    calc.pow(13 - 15, 2) / 15 + 
    calc.pow(13 - 8, 2) / 8 + 
    calc.pow(9 - 13, 2) / 13 + 
    calc.pow(8 - 9, 2) / 9 + 
    calc.pow(7 - 5, 2) / 5 +
    calc.pow(17 - 15, 2) / 15 + 
    calc.pow(3 - 8, 2) / 8 + 
    calc.pow(17 - 13, 2) / 13 + 
    calc.pow(10 - 9, 2) / 9 + 
    calc.pow(3 - 5, 2) / 5
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

  At a 5% significance level, *we reject $H_0$*, and have sufficient evidence to support the claim that the distribution of grades in each class is different from one another.
]