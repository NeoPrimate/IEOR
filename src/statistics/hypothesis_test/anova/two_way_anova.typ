#import "/lib/imports.typ": *
#show: formatting

= Two-Way ANOVA <statistics_hypothesis_test_anova_two_way_anova>

Compares the means of groups formed by two independent variables, and asks whether the two effects simply add up or whether they modify each other.

$
  X_(i j k) = mu + alpha_i + beta_j + (alpha beta)_(i j) + epsilon_(i j k)
$

- $alpha_i$: effect of level $i$ of factor $A$
- $beta_j$: effect of level $j$ of factor $B$
- $(alpha beta)_(i j)$: interaction, the part of cell $(i, j)$ that the two main effects fail to explain
- $epsilon_(i j k)$: error, assumed $N(0, sigma^2)$

Three null hypotheses, tested separately:

- $H_0^A$: $alpha_1 = ... = alpha_a = 0$ (no factor $A$ main effect)
- $H_0^B$: $beta_1 = ... = beta_b = 0$ (no factor $B$ main effect)
- $H_0^(A B)$: all $(alpha beta)_(i j) = 0$ (the effects are additive)

#let n = 3   // observations per cell
#let a = 2   // levels of factor A
#let b = 3   // levels of factor B

#let y11 = tystats.norm.rvs(mean: 10, std_dev: 2, size: n, seed: 11)
#let y12 = tystats.norm.rvs(mean: 12, std_dev: 2, size: n, seed: 12)
#let y13 = tystats.norm.rvs(mean: 14, std_dev: 2, size: n, seed: 13)
#let y21 = tystats.norm.rvs(mean: 14, std_dev: 2, size: n, seed: 21)
#let y22 = tystats.norm.rvs(mean: 13, std_dev: 2, size: n, seed: 22)
#let y23 = tystats.norm.rvs(mean: 12, std_dev: 2, size: n, seed: 23)

// cells[i][j] holds the replicates for level i of A and level j of B
#let cells = ((y11, y12, y13), (y21, y22, y23))
#let y = cells.flatten()

#let avg(v) = v.sum() / v.len()

#let y_mean = avg(y)

// Cell means, one per (A, B) combination
#let cell_means = cells.map(row => row.map(avg))

// Marginal means: pool over the other factor
#let a_means = cells.map(row => avg(row.flatten()))
#let b_means = range(b).map(j => avg(cells.map(row => row.at(j)).flatten()))

// Additive prediction: what each cell mean would be with no interaction
#let fit = range(a).map(i =>
  range(b).map(j => a_means.at(i) + b_means.at(j) - y_mean))

// Total variation: every observation against the grand mean
#let ss_total = y.map(v => calc.pow(v - y_mean, 2)).sum()

// Error: every observation against its own cell mean
#let ss_e = range(a).map(i =>
  range(b).map(j =>
    cells.at(i).at(j).map(v => calc.pow(v - cell_means.at(i).at(j), 2)).sum()
  ).sum()
).sum()

// Main effects: marginal means against the grand mean
#let ss_a = a_means.map(m => b * n * calc.pow(m - y_mean, 2)).sum()
#let ss_b = b_means.map(m => a * n * calc.pow(m - y_mean, 2)).sum()

// Interaction: cell means against the additive prediction
#let ss_ab = range(a).map(i =>
  range(b).map(j =>
    n * calc.pow(cell_means.at(i).at(j) - fit.at(i).at(j), 2)
  ).sum()
).sum()

#let N = y.len()

#let df_a = a - 1
#let df_b = b - 1
#let df_ab = (a - 1) * (b - 1)
#let df_e = a * b * (n - 1)

#let ms_a = ss_a / df_a
#let ms_b = ss_b / df_b
#let ms_ab = ss_ab / df_ab
#let ms_e = ss_e / df_e

#let f_a = calc.round(ms_a / ms_e, digits: 2)
#let f_b = calc.round(ms_b / ms_e, digits: 2)
#let f_ab = calc.round(ms_ab / ms_e, digits: 2)

#let bn = b * n
#let an = a * n

#let ymin = calc.min(..y) - 2
#let ymax = calc.max(..y) + 2

#let (kA1, kA2) = (blue, orange)
#let ka = (kA1, kA2)
#let kb = (olive, red, purple)

#let resid = (paint: gray, thickness: .6pt, dash: "dashed")

// x placement: factor B sets the position, factor A dodges around it
#let bpos = (1, 2, 3)
#let dodge = 0.16
#let apos = (-dodge, dodge)
#let xpos(i, j) = bpos.at(j) + apos.at(i)
#let xs(i, j) = range(n).map(_ => xpos(i, j))

#let x = range(a).map(i => range(b).map(j => xs(i, j))).flatten()

#let w = 0.11
#let bticks = ((1, [B1]), (2, [B2]), (3, [B3]))

#let pts = range(a).map(i =>
  range(b).map(j =>
    lq.scatter(xs(i, j), cells.at(i).at(j), size: 7pt, color: ka.at(i))
  )
).flatten()

#let cellbars = range(a).map(i =>
  range(b).map(j =>
    lq.hlines(cell_means.at(i).at(j),
              min: xpos(i, j) - w, max: xpos(i, j) + w,
              stroke: (paint: ka.at(i), thickness: 1.5pt))
  )
).flatten()

#let bw = 1.6pt
#let off = 0.04
#let step = 0.04

#let bars(ys, c, k, base) = ys.enumerate().map(((i, v)) =>
  lq.vlines(c + off + step * i, min: base, max: v,
            stroke: (paint: k, thickness: bw))
)

#let allbars(base) = range(a).map(i =>
  range(b).map(j =>
    bars(cells.at(i).at(j), xpos(i, j), ka.at(i), base)
  )
).flatten()

#let cellwisebars = range(a).map(i =>
  range(b).map(j =>
    bars(cells.at(i).at(j), xpos(i, j), ka.at(i), cell_means.at(i).at(j))
  )
).flatten()

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

== The data

Six cells: two levels of factor $A$ (colour) crossed with three levels of factor $B$ (position), three replicates each.

#lq.diagram(
  width: 10cm,
  height: 5cm,
  xlim: (0.5, 3.5),
  ylim: (ymin, ymax),
  xaxis: (ticks: bticks, subticks: none),
  yaxis: (ticks: none, subticks: none),

  ..pts,
)

== Variation around the grand mean

Total Variation ($"SS"_"total"$): every observation measured against the grand mean, ignoring both factors.

$
  "SS"_"total" = sum_(i=1)^a sum_(j=1)^b sum_(k=1)^n (X_(i j k) - macron(X)_"overall")^2
$

- $X_(i j k)$: replicate $k$ in cell $(i, j)$
- $macron(X)_"overall"$: overall mean of all observations

It splits into four parts, which the next sections build up separately:

$
  "SS"_"total" = "SS"_A + "SS"_B + "SS"_(A B) + "SS"_"error"
$

#lq.diagram(
  width: 10cm,
  height: 5cm,
  xlim: (0.5, 3.5),
  ylim: (ymin, ymax),
  xaxis: (ticks: bticks, subticks: none),
  yaxis: (ticks: none, subticks: none),

  lq.stem(x, y, base: y_mean, stroke: resid, mark: none),
  lq.hlines(y_mean, stroke: (paint: black, thickness: 1pt)),

  ..pts,
  ..allbars(y_mean),
)

$
  "SS"_"total" = &#sqterms(y11, y_mean, kA1).join($+$) \
               + &#sqterms(y12, y_mean, kA1).join($+$) \
               + &#sqterms(y13, y_mean, kA1).join($+$) \
               + &#sqterms(y21, y_mean, kA2).join($+$) \
               + &#sqterms(y22, y_mean, kA2).join($+$) \
               + &#sqterms(y23, y_mean, kA2).join($+$) \
               &approx #calc.round(ss_total, digits: 1)
$

== Variation around the cell means

Error Variation ($"SS"_"error"$): every observation measured against its own cell mean. Nothing about $A$ or $B$ can explain this, so it becomes the yardstick for all three tests.

$
  "SS"_"error" = sum_(i=1)^a sum_(j=1)^b sum_(k=1)^n (X_(i j k) - macron(X)_(i j))^2
$

- $macron(X)_(i j)$: mean of cell $(i, j)$

#lq.diagram(
  width: 10cm,
  height: 5cm,
  xlim: (0.5, 3.5),
  ylim: (ymin, ymax),
  xaxis: (ticks: bticks, subticks: none),
  yaxis: (ticks: none, subticks: none),

  lq.stem(xs(0, 0), y11, base: cell_means.at(0).at(0), stroke: resid, mark: none),
  lq.stem(xs(0, 1), y12, base: cell_means.at(0).at(1), stroke: resid, mark: none),
  lq.stem(xs(0, 2), y13, base: cell_means.at(0).at(2), stroke: resid, mark: none),
  lq.stem(xs(1, 0), y21, base: cell_means.at(1).at(0), stroke: resid, mark: none),
  lq.stem(xs(1, 1), y22, base: cell_means.at(1).at(1), stroke: resid, mark: none),
  lq.stem(xs(1, 2), y23, base: cell_means.at(1).at(2), stroke: resid, mark: none),

  ..cellbars,
  ..cellwisebars,
  ..pts,
)

$
  "SS"_"error" = &#sqterms(y11, cell_means.at(0).at(0), kA1).join($+$) \
               + &#sqterms(y12, cell_means.at(0).at(1), kA1).join($+$) \
               + &#sqterms(y13, cell_means.at(0).at(2), kA1).join($+$) \
               + &#sqterms(y21, cell_means.at(1).at(0), kA2).join($+$) \
               + &#sqterms(y22, cell_means.at(1).at(1), kA2).join($+$) \
               + &#sqterms(y23, cell_means.at(1).at(2), kA2).join($+$) \
               &approx #calc.round(ss_e, digits: 1)
$

== Variation between the levels of factor A

Main Effect of $A$ ($"SS"_A$): collapse factor $B$ entirely, average each row of the design down to one number, and measure those against the grand mean.

$
  "SS"_A = b n sum_(i=1)^a (macron(X)_(i dot) - macron(X)_"overall")^2
$

- $macron(X)_(i dot)$: mean of all observations at level $i$ of $A$, pooled over $B$
- $b n = #bn$: observations behind each row mean

#lq.diagram(
  width: 10cm,
  height: 5cm,
  xlim: (0.5, 2.5),
  ylim: (ymin, ymax),
  xaxis: (ticks: ((1, [A1]), (2, [A2])), subticks: none),
  yaxis: (ticks: none, subticks: none),

  lq.stem((1, 2), a_means, base: y_mean, stroke: resid, mark: none),
  lq.hlines(y_mean, stroke: (paint: black, thickness: 1pt)),

  lq.hlines(a_means.at(0), min: 1 - 0.3, max: 1 + 0.3,
            stroke: (paint: kA1, thickness: 1.5pt)),
  lq.hlines(a_means.at(1), min: 2 - 0.3, max: 2 + 0.3,
            stroke: (paint: kA2, thickness: 1.5pt)),
)

$
  "SS"_A = #bn (#sqbar(a_means.at(0), y_mean, kA1)
              + #sqbar(a_means.at(1), y_mean, kA2))
    approx #calc.round(ss_a, digits: 1)
$

== Variation between the levels of factor B

Main Effect of $B$ ($"SS"_B$): the mirror image, collapsing factor $A$ instead.

$
  "SS"_B = a n sum_(j=1)^b (macron(X)_(dot j) - macron(X)_"overall")^2
$

- $macron(X)_(dot j)$: mean of all observations at level $j$ of $B$, pooled over $A$
- $a n = #an$: observations behind each column mean

#lq.diagram(
  width: 10cm,
  height: 5cm,
  xlim: (0.5, 3.5),
  ylim: (ymin, ymax),
  xaxis: (ticks: bticks, subticks: none),
  yaxis: (ticks: none, subticks: none),

  lq.stem(bpos, b_means, base: y_mean, stroke: resid, mark: none),
  lq.hlines(y_mean, stroke: (paint: black, thickness: 1pt)),

  lq.hlines(b_means.at(0), min: 1 - 0.3, max: 1 + 0.3,
            stroke: (paint: kb.at(0), thickness: 1.5pt)),
  lq.hlines(b_means.at(1), min: 2 - 0.3, max: 2 + 0.3,
            stroke: (paint: kb.at(1), thickness: 1.5pt)),
  lq.hlines(b_means.at(2), min: 3 - 0.3, max: 3 + 0.3,
            stroke: (paint: kb.at(2), thickness: 1.5pt)),
)

$
  "SS"_B = #an (#sqbar(b_means.at(0), y_mean, kb.at(0))
              + #sqbar(b_means.at(1), y_mean, kb.at(1))
              + #sqbar(b_means.at(2), y_mean, kb.at(2)))
    approx #calc.round(ss_b, digits: 1)
$

== Variation left over: the interaction

If the two factors acted independently, each cell mean would be predicted by its row and column effects alone:

$
  hat(X)_(i j) = macron(X)_(i dot) + macron(X)_(dot j) - macron(X)_"overall"
$

Interaction Variation ($"SS"_(A B)$): how far the actual cell means sit from that additive prediction.

$
  "SS"_(A B) = n sum_(i=1)^a sum_(j=1)^b
    (macron(X)_(i j) - macron(X)_(i dot) - macron(X)_(dot j) + macron(X)_"overall")^2
$

Dashed lines are the additive prediction, solid lines the actual cell means. Under $H_0^(A B)$ the solid lines would be parallel.

#let gap(i, j) = lq.vlines(bpos.at(j),
  min: calc.min(fit.at(i).at(j), cell_means.at(i).at(j)),
  max: calc.max(fit.at(i).at(j), cell_means.at(i).at(j)),
  stroke: (paint: ka.at(i), thickness: bw))

#lq.diagram(
  width: 10cm,
  height: 5cm,
  xlim: (0.5, 3.5),
  ylim: (ymin, ymax),
  xaxis: (ticks: bticks, subticks: none),
  yaxis: (ticks: none, subticks: none),

  lq.plot(bpos, fit.at(0), mark: none,
          stroke: (paint: kA1, thickness: 1pt, dash: "dashed")),
  lq.plot(bpos, fit.at(1), mark: none,
          stroke: (paint: kA2, thickness: 1pt, dash: "dashed")),

  lq.plot(bpos, cell_means.at(0), mark: none,
          stroke: (paint: kA1, thickness: 1.5pt)),
  lq.plot(bpos, cell_means.at(1), mark: none,
          stroke: (paint: kA2, thickness: 1.5pt)),

  ..range(a).map(i => range(b).map(j => gap(i, j))).flatten(),

  lq.scatter(bpos, fit.at(0), size: 5pt, color: gray),
  lq.scatter(bpos, fit.at(1), size: 5pt, color: gray),
  lq.scatter(bpos, cell_means.at(0), size: 8pt, color: kA1),
  lq.scatter(bpos, cell_means.at(1), size: 8pt, color: kA2),
)

$
  "SS"_(A B) = #n (
    &#range(b).map(j => sqbar(cell_means.at(0).at(j), fit.at(0).at(j), kA1)).join($+$) \
  + &#range(b).map(j => sqbar(cell_means.at(1).at(j), fit.at(1).at(j), kA2)).join($+$)
  ) \
  &approx #calc.round(ss_ab, digits: 1)
$

Equivalently, it is whatever is left once the main effects and the error are taken out:

$
  "SS"_(A B) = "SS"_"total" - "SS"_A - "SS"_B - "SS"_"error"
    approx #calc.round(ss_ab, digits: 1)
$

== Degrees of freedom

- $a = #a$: levels of factor $A$
- $b = #b$: levels of factor $B$
- $n = #n$: replicates per cell, $N = #N$ observations in total
- $a - 1 = #df_a$: one grand mean is fixed, so the row effects lose one
- $b - 1 = #df_b$: likewise for the column effects
- $(a - 1)(b - 1) = #df_ab$: the interaction is a grid of deviations whose rows and columns must each sum to zero
- $a b (n - 1) = #df_e$: one mean fixed per cell

They add up the same way the sums of squares do:

$
  N - 1 = #(N - 1) = #df_a + #df_b + #df_ab + #df_e
$

Replication is what makes $"df"_"error" > 0$. With $n = 1$ there is nothing left over inside a cell, $a b (n - 1) = 0$, and the interaction has to be sacrificed as the error term instead of being tested.

== Mean squares

Dividing each sum of squares by its degrees of freedom turns it into a variance estimate.

$
  "MS"_A = ("SS"_A) / (a - 1)
    approx #calc.round(ss_a, digits: 1) / #df_a
    approx #calc.round(ms_a, digits: 2)
$

$
  "MS"_B = ("SS"_B) / (b - 1)
    approx #calc.round(ss_b, digits: 1) / #df_b
    approx #calc.round(ms_b, digits: 2)
$

$
  "MS"_(A B) = ("SS"_(A B)) / ((a - 1)(b - 1))
    approx #calc.round(ss_ab, digits: 1) / #df_ab
    approx #calc.round(ms_ab, digits: 2)
$

$
  "MS"_"error" = ("SS"_"error") / (a b (n - 1))
    approx #calc.round(ss_e, digits: 1) / #df_e
    approx #calc.round(ms_e, digits: 2)
$

== F statistics

Each effect is compared against the same error variance. In a fixed-effects model all three denominators are $"MS"_"error"$.

$
  F_A = ("MS"_A) / ("MS"_"error")
    approx #calc.round(ms_a, digits: 2) / #calc.round(ms_e, digits: 2)
    approx #f_a
  quad (#df_a, #df_e)
$

$
  F_B = ("MS"_B) / ("MS"_"error")
    approx #calc.round(ms_b, digits: 2) / #calc.round(ms_e, digits: 2)
    approx #f_b
  quad (#df_b, #df_e)
$

$
  F_(A B) = ("MS"_(A B)) / ("MS"_"error")
    approx #calc.round(ms_ab, digits: 2) / #calc.round(ms_e, digits: 2)
    approx #f_ab
  quad (#df_ab, #df_e)
$

#let alpha = 0.05

#let fplot(f_stat, dfn, dfd) = {
  let crit = calc.round(tystats.f.ppf(1 - alpha, dfn, dfd), digits: 2)
  let xmax = calc.max(f_stat, crit) + 1.5
  let fpdf(v) = tystats.f.pdf(v, dfn, dfd)

  let xgx = lq.linspace(0.05, xmax, num: 300)
  let xgy = xgx.map(fpdf)

  let xtail = lq.linspace(crit, xmax, num: 200)
  let ytail = xtail.map(fpdf)

  align(center)[
    #lq.diagram(
      width: 10cm,
      height: 4cm,
      xlim: (0, xmax),
      ylim: (0, 0.9),
      yaxis: (ticks: none, subticks: none),
      xaxis: (
        subticks: none,
        ticks: (
          (0, $0$),
          (f_stat, box(text(size: 0.7em)[$F$\ #f_stat])),
          (crit, box(text(size: 0.7em)[#crit])),
        ),
      ),
      lq.fill-between(xtail, ytail, fill: rgb("#c0392b33"), stroke: none),
      lq.plot(xgx, xgy, mark: none, stroke: black),
    )
  ]
}

Factor $A$:

#fplot(f_a, df_a, df_e)

Factor $B$:

#fplot(f_b, df_b, df_e)

Interaction $A times B$:

#fplot(f_ab, df_ab, df_e)

== ANOVA table

#table(
  columns: 5,
  align: (left, right, right, right, right),
  table.header([Source], [SS], [df], [MS], [F]),
  [$A$], [#calc.round(ss_a, digits: 1)], [#df_a],
    [#calc.round(ms_a, digits: 2)], [#f_a],
  [$B$], [#calc.round(ss_b, digits: 1)], [#df_b],
    [#calc.round(ms_b, digits: 2)], [#f_b],
  [$A times B$], [#calc.round(ss_ab, digits: 1)], [#df_ab],
    [#calc.round(ms_ab, digits: 2)], [#f_ab],
  [Error], [#calc.round(ss_e, digits: 1)], [#df_e],
    [#calc.round(ms_e, digits: 2)], [],
  [Total], [#calc.round(ss_total, digits: 1)], [#(N - 1)], [], [],
)

== Decision rule

- Compare each F-statistic to the critical value from the F-distribution with its own numerator degrees of freedom and $a b (n - 1) = #df_e$ in the denominator (based on chosen significance level $alpha$).
- Alternatively, compare each p-value to the significance level $alpha$.
- Reject an $H_0$ if its F-statistic exceeds the critical value or its p-value is below $alpha$.
- Read the interaction first. If $H_0^(A B)$ is rejected, the main effects describe averages over conditions where the effect genuinely differs, so they are usually reported as secondary to the cell means themselves.

Two assumptions the decomposition above quietly relies on:

- Balance. Equal $n$ in every cell is what makes the four sums of squares orthogonal and additive. With unequal cells they no longer sum to $"SS"_"total"$, and the order of terms starts to matter (Type I / II / III sums of squares).
- Fixed effects. If a factor is random, its main effect is tested against $"MS"_(A B)$ rather than $"MS"_"error"$.

#code[
  ```py
  import numpy as np
  from scipy import stats

  rng = np.random.default_rng(0)

  n = 3
  cell_means = np.array([[10, 12, 14],
                         [14, 13, 12]])

  y = rng.normal(np.repeat(cell_means.ravel(), n), 2)
  A = np.repeat(["A1", "A2"], 3 * n)
  B = np.tile(np.repeat(["B1", "B2", "B3"], n), 2)
  ```
]

#code[
  ```py
  import pandas as pd, statsmodels.api as sm
  from statsmodels.formula.api import ols

  df = pd.DataFrame({"y": y, "A": A, "B": B})

  # Full model: both main effects plus the interaction
  model = ols("y ~ C(A) * C(B)", data=df).fit()
  sm.stats.anova_lm(model, typ=2)
  ```
]

#code[
  ```py
  # Additive model: interaction assumed away, its SS folded into the residual
  additive = ols("y ~ C(A) + C(B)", data=df).fit()
  sm.stats.anova_lm(additive, typ=2)

  # The two models differ by exactly SS_AB on df_AB degrees of freedom
  sm.stats.anova_lm(additive, model)
  ```
]
