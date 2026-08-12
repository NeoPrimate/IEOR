#import "/lib/imports.typ": *
#show: formatting

= One-Way ANOVA <statistics_hypothesis_test_anova_one_way_anova>

Compares the means of three or more groups based on one independent variable

- $H_0$: $mu_1 = mu_2 = ... = mu_k$
- $H_1$: At least one $mu_i$ differs from the others

*Step 1*: Calculate Between-Group Variation ($S S_"between"$)

$
  S S_"between" = sum_(i=1)^k n_i (macron(X)_i - macron(X)_("overall"))^2
$

- $n_1$: Number of observations in group $i$
- $macron(X)_i$: Mean of group $i$
- $macron(X)_"overall"$: Overall mean of all groups

*Step 2*: Calculate Within-Group Variation ($S S_"within"$)

$
  S S_"within" = sum_(i=1)^k sum_(j=1)^(n_i) (X_(i j) - macron(X)_i)^2
$

- $X_(i j)$: Observation $j$ in group $i$

*Step 3*: Calculate Total Variation ($S S_"total"$)

$
  S S_"total" = S S_"between" + S S_"within"
$

*Step 4*: Calculate Mean Squares

- Mean Square Between ($M S_("between")$)

$
  M S_("between") = (S S_("between")) / (k - 1)
$

- Mean Square Within ($M S_("within")$)

$
  M S_("within") = (S S_("within")) / (N - k)
$

- $N$: total number of observations
- $k$: number of groups

*Step 5*: Calculate the F-statistic

$
  F = (M S_("between")) / (M S_("within"))
$

*Step 6*: Decision Rule

- Compare the F-statistic to the critical value from the F-distribution table (based on chosen significance level $alpha$).
- Alternatively, compare the p-value to the significance level $alpha$.
- Reject $H_0$ if the F-statistic is greater than the critical value or if the p-value is less than $alpha$, indicating that at least one group mean is significantly different.

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

#let ss_mean = y.map(v => calc.pow(v - y_mean, 2)).sum()

#let ss1 = y1.map(v => calc.pow(v - y1_mean, 2)).sum()
#let ss2 = y2.map(v => calc.pow(v - y2_mean, 2)).sum()
#let ss3 = y3.map(v => calc.pow(v - y3_mean, 2)).sum()
#let ss4 = y4.map(v => calc.pow(v - y4_mean, 2)).sum()
#let ss5 = y5.map(v => calc.pow(v - y5_mean, 2)).sum()

#let ss_fit = ss1 + ss2 + ss3 + ss4 + ss5

#let p_mean = 1
#let p_fit = 5
#let N = y.len()

#let f_stat = calc.round(((ss_mean - ss_fit) / (p_fit - p_mean)) / (ss_fit / (N - p_fit)), digits: 2)

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

$ "SS"_"mean" = sum_(i) (y_i - macron(y))^2 $

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
  "SS"_"mean" = &#sqterms(y1, y_mean, k1).join($+$) \
              + &#sqterms(y2, y_mean, k2).join($+$) \
              + &#sqterms(y3, y_mean, k3).join($+$) \
              + &#sqterms(y4, y_mean, k4).join($+$) \
              + &#sqterms(y5, y_mean, k5).join($+$) \
              &approx #calc.round(ss_mean, digits: 1)
              
$

== Variation around the group means

$ "SS"_"fit" = sum_(j) sum_(i in j) (y_i - macron(y)_j)^2 $

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
  "SS"_"fit" = &#sqterms(y1, y1_mean, k1).join($+$) \
             + &#sqterms(y2, y2_mean, k2).join($+$) \
             + &#sqterms(y3, y3_mean, k3).join($+$) \
             + &#sqterms(y4, y4_mean, k4).join($+$) \
             + &#sqterms(y5, y5_mean, k5).join($+$) \
             &approx #calc.round(ss_fit, digits: 1)
$

== P-Fit & P-Mean

- $p_"mean" = 1$: one grand mean
- $p_"fit" = k$: one mean per group
- $p_"fit" - p_"mean"$: always k - 1
- $N - p_"fit"$

== F statistic

$
  F = (("SS"_"mean" - "SS"_"fit") / (p_"fit" - p_"mean"))
      / ("SS"_"fit" / (N - p_"fit"))
    = ((#calc.round(ss_mean, digits: 1) - #calc.round(ss_fit, digits: 1)) / #(p_fit - p_mean))
      / (#calc.round(ss_fit, digits: 1) / #(N - p_fit))
    approx #calc.round(f_stat, digits: 2)
$

#let (xmin, xmax) = (0, f_stat + 1)
#let a = 0.05 
#let (dfn, dfd) = (4, 20)

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

