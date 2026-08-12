#import "/lib/imports.typ": *
#show: formatting

= One-Way ANOVA <statistics_hypothesis_test_anova_one_way_anova>

Compares the means of three or more groups based on one independent variable

- $H_0$: $mu_1 = mu_2 = ... = mu_k$
- $H_1$: At least one $mu_i$ differs from the others

#let n = 5

#let y1 = tystats.norm.rvs(mean: 10, std_dev: 3, size: n, seed: 1)
#let y2 = tystats.norm.rvs(mean:  9, std_dev: 3, size: n, seed: 2)
#let y3 = tystats.norm.rvs(mean:  8, std_dev: 3, size: n, seed: 3)
#let y4 = tystats.norm.rvs(mean: 12, std_dev: 3, size: n, seed: 4)
#let y5 = tystats.norm.rvs(mean: 13, std_dev: 3, size: n, seed: 5)

#let (c1, c2, c3, c4, c5) = (1, 2, 3, 4, 5)
#let x1 = range(n).map(_ => c1)
#let x2 = range(n).map(_ => c2)
#let x3 = range(n).map(_ => c3)
#let x4 = range(n).map(_ => c4)
#let x5 = range(n).map(_ => c5)

#let x = (x1, x2, x3, x4, x5).flatten()
#let y = (y1, y2, y3, y4, y5).flatten()

#let y_mean = y.sum() / y.len()

#let y1_mean = y1.sum() / y1.len()
#let y2_mean = y2.sum() / y2.len()
#let y3_mean = y3.sum() / y3.len()
#let y4_mean = y4.sum() / y4.len()
#let y5_mean = y5.sum() / y5.len()

#let group_means = (y1_mean, y2_mean, y3_mean, y4_mean, y5_mean)

// Total variation: every observation against the grand mean
#let ss_total = y.map(v => calc.pow(v - y_mean, 2)).sum()

// Within-group variation: every observation against its own group mean
#let ss1 = y1.map(v => calc.pow(v - y1_mean, 2)).sum()
#let ss2 = y2.map(v => calc.pow(v - y2_mean, 2)).sum()
#let ss3 = y3.map(v => calc.pow(v - y3_mean, 2)).sum()
#let ss4 = y4.map(v => calc.pow(v - y4_mean, 2)).sum()
#let ss5 = y5.map(v => calc.pow(v - y5_mean, 2)).sum()

#let ss_within = ss1 + ss2 + ss3 + ss4 + ss5

// Between-group variation: each group mean against the grand mean
#let ss_between = group_means.map(m => n * calc.pow(m - y_mean, 2)).sum()

#let k = 5              // number of groups
#let N = y.len()        // total number of observations

#let df_between = k - 1
#let df_within = N - k

#let ms_between = ss_between / df_between
#let ms_within = ss_within / df_within

#let f_stat = calc.round(ms_between / ms_within, digits: 2)

#let ymin = calc.min(..y) - 2
#let ymax = calc.max(..y) + 2
#let w = 0.3
#let (k1, k2, k3, k4, k5) = (blue, orange, olive, red, purple)
#let resid = (paint: gray, thickness: .6pt, dash: "dashed")
#let ticks = ((c1, [A]), (c2, [B]), (c3, [C]), (c4, [D]), (c5, [E]))

== The data

#lq.diagram(
  width: 10cm,
  height: 5cm,
  xlim: (0.5, 5.5),
  ylim: (ymin, ymax),
  xaxis: (ticks: ticks, subticks: none),
  yaxis: (ticks: none, subticks: none),

  lq.scatter(x1, y1, size: 8pt, color: k1),
  lq.scatter(x2, y2, size: 8pt, color: k2),
  lq.scatter(x3, y3, size: 8pt, color: k3),
  lq.scatter(x4, y4, size: 8pt, color: k4),
  lq.scatter(x5, y5, size: 8pt, color: k5),
)

== Variation around the grand mean

Total Variation ($"SS"_"total"$): every observation measured against the grand mean.

$
  "SS"_"total" = sum_(i=1)^k sum_(j=1)^(n_i) (X_(i j) - macron(X)_"overall")^2
$

- $X_(i j)$: Observation $j$ in group $i$
- $macron(X)_"overall"$: Overall mean of all groups

It splits into two parts, which the next two sections build up separately:

$
  "SS"_"total" = "SS"_"between" + "SS"_"within"
$

#let bw = 1.6pt
#let off = 0.10
#let step = 0.05

#let bars(ys, c, k, base) = ys.enumerate().map(((i, v)) =>
  lq.vlines(c + off + step * i, min: base, max: v,
            stroke: (paint: k, thickness: bw))
)

#lq.diagram(
  width: 10cm,
  height: 5cm,
  xlim: (0.5, 5.5),
  ylim: (ymin, ymax),
  xaxis: (ticks: ticks, subticks: none),
  yaxis: (ticks: none, subticks: none),

  lq.stem(x, y, base: y_mean, stroke: resid, mark: none),
  lq.hlines(y_mean, stroke: (paint: black, thickness: 1pt)),

  lq.scatter(x1, y1, size: 8pt, color: k1),
  lq.scatter(x2, y2, size: 8pt, color: k2),
  lq.scatter(x3, y3, size: 8pt, color: k3),
  lq.scatter(x4, y4, size: 8pt, color: k4),
  lq.scatter(x5, y5, size: 8pt, color: k5),

  ..bars(y1, c1, k1, y_mean),
  ..bars(y2, c2, k2, y_mean),
  ..bars(y3, c3, k3, y_mean),
  ..bars(y4, c4, k4, y_mean),
  ..bars(y5, c5, k5, y_mean),
  
)

#let bscale = 2pt      // length per data unit
#let bwid = 1.6pt

#let sqbar(v, base, k) = math.attach(
  box(
    baseline: 0pt,
    rect(width: bwid, height: calc.abs(v - base) * bscale, fill: k, stroke: none),
  ),
  t: [2],
)

#let sqterms(ys, base, k) = ys.map(v => sqbar(v, base, k))

$
  "SS"_"total" = &#sqterms(y1, y_mean, k1).join($+$) \
               + &#sqterms(y2, y_mean, k2).join($+$) \
               + &#sqterms(y3, y_mean, k3).join($+$) \
               + &#sqterms(y4, y_mean, k4).join($+$) \
               + &#sqterms(y5, y_mean, k5).join($+$) \
               &approx #calc.round(ss_total, digits: 1)
$

== Variation around the group means

Within-Group Variation ($"SS"_"within"$): every observation measured against its own group mean.

$
  "SS"_"within" = sum_(i=1)^k sum_(j=1)^(n_i) (X_(i j) - macron(X)_i)^2
$

- $macron(X)_i$: Mean of group $i$

#lq.diagram(
  width: 10cm,
  height: 5cm,
  xlim: (0.5, 5.5),
  ylim: (ymin, ymax),
  xaxis: (ticks: ticks, subticks: none),
  yaxis: (ticks: none, subticks: none),

  lq.stem(x1, y1, base: y1_mean, stroke: resid, mark: none),
  lq.stem(x2, y2, base: y2_mean, stroke: resid, mark: none),
  lq.stem(x3, y3, base: y3_mean, stroke: resid, mark: none),
  lq.stem(x4, y4, base: y4_mean, stroke: resid, mark: none),
  lq.stem(x5, y5, base: y5_mean, stroke: resid, mark: none),

  lq.hlines(y1_mean, min: c1 - w, max: c1 + w, stroke: (paint: k1, thickness: 1.5pt)),
  lq.hlines(y2_mean, min: c2 - w, max: c2 + w, stroke: (paint: k2, thickness: 1.5pt)),
  lq.hlines(y3_mean, min: c3 - w, max: c3 + w, stroke: (paint: k3, thickness: 1.5pt)),
  lq.hlines(y4_mean, min: c4 - w, max: c4 + w, stroke: (paint: k4, thickness: 1.5pt)),
  lq.hlines(y5_mean, min: c5 - w, max: c5 + w, stroke: (paint: k5, thickness: 1.5pt)),

  ..bars(y1, c1, k1, y1_mean),
  ..bars(y2, c2, k2, y2_mean),
  ..bars(y3, c3, k3, y3_mean),
  ..bars(y4, c4, k4, y4_mean),
  ..bars(y5, c5, k5, y5_mean),

  lq.scatter(x1, y1, size: 8pt, color: k1),
  lq.scatter(x2, y2, size: 8pt, color: k2),
  lq.scatter(x3, y3, size: 8pt, color: k3),
  lq.scatter(x4, y4, size: 8pt, color: k4),
  lq.scatter(x5, y5, size: 8pt, color: k5),
)

$
  "SS"_"within" = &#sqterms(y1, y1_mean, k1).join($+$) \
                + &#sqterms(y2, y2_mean, k2).join($+$) \
                + &#sqterms(y3, y3_mean, k3).join($+$) \
                + &#sqterms(y4, y4_mean, k4).join($+$) \
                + &#sqterms(y5, y5_mean, k5).join($+$) \
                &approx #calc.round(ss_within, digits: 1)
$

== Variation between the group means

Between-Group Variation ($"SS"_"between"$): each group mean measured against the grand mean, weighted by group size.

$
  "SS"_"between" = sum_(i=1)^k n_i (macron(X)_i - macron(X)_"overall")^2
$

- $n_i$: Number of observations in group $i$

#lq.diagram(
  width: 10cm,
  height: 5cm,
  xlim: (0.5, 5.5),
  ylim: (ymin, ymax),
  xaxis: (ticks: ticks, subticks: none),
  yaxis: (ticks: none, subticks: none),

  lq.stem((c1, c2, c3, c4, c5), group_means, base: y_mean,
          stroke: resid, mark: none),
  lq.hlines(y_mean, stroke: (paint: black, thickness: 1pt)),

  lq.hlines(y1_mean, min: c1 - w, max: c1 + w, stroke: (paint: k1, thickness: 1.5pt)),
  lq.hlines(y2_mean, min: c2 - w, max: c2 + w, stroke: (paint: k2, thickness: 1.5pt)),
  lq.hlines(y3_mean, min: c3 - w, max: c3 + w, stroke: (paint: k3, thickness: 1.5pt)),
  lq.hlines(y4_mean, min: c4 - w, max: c4 + w, stroke: (paint: k4, thickness: 1.5pt)),
  lq.hlines(y5_mean, min: c5 - w, max: c5 + w, stroke: (paint: k5, thickness: 1.5pt)),
)

Equivalently, it is whatever the group means account for out of the total:

$
  "SS"_"between" = "SS"_"total" - "SS"_"within"
    approx #calc.round(ss_total, digits: 1) - #calc.round(ss_within, digits: 1)
    approx #calc.round(ss_between, digits: 1)
$

== Degrees of freedom

- $k = #k$: number of groups, one mean each
- $N = #N$: total number of observations
- $k - 1 = #df_between$: between-group degrees of freedom (one grand mean is fixed)
- $N - k = #df_within$: within-group degrees of freedom (one mean fixed per group)

== Mean squares

Dividing each sum of squares by its degrees of freedom turns it into a variance estimate.

$
  "MS"_"between" = ("SS"_"between") / (k - 1)
    approx #calc.round(ss_between, digits: 1) / #df_between
    approx #calc.round(ms_between, digits: 2)
$

$
  "MS"_"within" = ("SS"_"within") / (N - k)
    approx #calc.round(ss_within, digits: 1) / #df_within
    approx #calc.round(ms_within, digits: 2)
$

== F statistic

$
  F = ("MS"_"between") / ("MS"_"within")
    = (("SS"_"between") / (k - 1)) / (("SS"_"within") / (N - k))
    approx (#calc.round(ss_between, digits: 1) / #df_between)
      / (#calc.round(ss_within, digits: 1) / #df_within)
    approx #f_stat
$

#let (xmin, xmax) = (0, f_stat + 1)
#let a = 0.05 
#let (dfn, dfd) = (df_between, df_within)

#let crit = calc.round(tystats.f.ppf(1 - a, dfn, dfd), digits: 2)

#let fpdf(x) = tystats.f.pdf(x, dfn, dfd)

#let xgx = lq.linspace(xmin, xmax, num: 300)
#let xgy = xgx.map(fpdf)

#let xtail = lq.linspace(crit, xmax, num: 200)
#let ytail = xtail.map(fpdf)

#align(center)[
  #lq.diagram(
    width: 10cm,
    height: 5cm,
    xlim: (xmin, xmax),
    ylim: (0, 0.75),
    yaxis: (ticks: none, subticks: none),
    xaxis: (
      subticks: none,
      ticks: (
        (0, $0$),
        (f_stat, box(text(size: 0.7em)["F-statistic"\ #f_stat])),
        (crit, box(text(size: 0.7em)[#crit])),
      ),
    ),
    lq.fill-between(xtail, ytail,
      fill: rgb("#c0392b33"), stroke: none),
    lq.plot(xgx, xgy, mark: none, stroke: black),
  )
]

== Decision rule

- Compare the F-statistic to the critical value from the F-distribution table with $k - 1 = #df_between$ and $N - k = #df_within$ degrees of freedom (based on chosen significance level $alpha$).
- Alternatively, compare the p-value to the significance level $alpha$.
- Reject $H_0$ if the F-statistic is greater than the critical value or if the p-value is less than $alpha$, indicating that at least one group mean is significantly different.

#code[
  ```py
  from scipy import stats

  rng = np.random.default_rng(0)
  groups = [rng.normal(loc, 3, 5) for loc in (10, 9, 8, 12, 13)]

  f, p = stats.f_oneway(*groups)
  ```
]

#code[
  ```py
  import pandas as pd, statsmodels.api as sm
  from statsmodels.formula.api import ols

  rng = np.random.default_rng(0)
  groups = [rng.normal(loc, 3, 5) for loc in (10, 9, 8, 12, 13)]

  df = pd.DataFrame({
      "y": np.concatenate(groups),
      "g": np.repeat(list("ABCDE"), 5),
  })

  model = ols("y ~ C(g)", data=df).fit()
  sm.stats.anova_lm(model, typ=2)
  ```
]