#import "/lib/imports.typ": *
#show: formatting

*Setup*

Imagine we have 100 emails. We track two things about each one: is it spam or not, and does it contain the word "free" or not. Here's the count of every combination:

#align(center)[
  #table(
    stroke: none,
    inset: 1em,
    columns: 4,
    align: center + horizon,
    [], [$F$], [$F^c$], [margin],
    table.hline(),
    table.vline(x: 1),
    table.vline(x: 3),
    [$S$], [0.20], [0.10], [0.30],
    [$S^c$], [0.05], [0.65], [0.70],
    table.hline(),
    [margin], [0.25], [0.75], [1.00],
  )
]

== Joint Probability

$
  P(S inter F) = 0.20
$

== Marginal Probability

$
  P(A) = sum_(i=1)^n P(A inter B_i)
$

$
  P(S)
  &= P(S inter F) + P(S inter F^c)\
  &= 0.20 + 0.10 \
  &= 0.30
$

== Conditional Probability

$
  P(A | B) = P(A inter B) / P(B)
$

$
  P(S | F) = P(S inter F) / P(F) = 0.20 / 0.25 = 0.80
$

== Convolution

You have two independent random variables, $X$ and $Y$. You add them: $Z = X + Y$. What's the distribution of $Z$?

=== Discrete

$
  P(Z = z) = sum_x P(X = x) P(Y = z - x)
$

// discrete convolution: P(X + Y = z) = sum_k p_X(k) p_Y(z - k)
#let conv-pmf(z, la, lb) = {
  let total = 0.0
  for k in range(0, z + 1) { total += poisson.pmf(k, la) * poisson.pmf(z - k, lb) }
  total
}

#let lam-x = 2      // blue, fixed
#let lam-y = 3      // red, the one we flip & slide
#let kmax  = 14

#let ks = range(0, kmax + 1)

#let input-plot(z) = lq.diagram(
  width: 6cm, height: 2cm,
  xlim: (-1, kmax + 1), ylim: (0, 0.30),
  xaxis: (tick-distance: 2), yaxis: (ticks: none),
  lq.bar(
    ks, ks.map(k => poisson.pmf(k, lam-x)),
    offset: -0.2, width: 0.4, fill: blue.transparentize(50%),
  ),
  lq.bar(
    ks, ks.map(k => poisson.pmf(z - k, lam-y)),
    offset: 0.2, width: 0.4, fill: red.transparentize(50%),
  ),
  lq.vlines(z, stroke: purple + 1pt),
)

#let conv-plot(z) = {
  let js = range(0, z + 1)
  lq.diagram(
    width: 6cm, height: 2cm,
    xlim: (-1, kmax + 1), ylim: (0, 0.20),
    xaxis: (tick-distance: 2), yaxis: (ticks: none),
    lq.bar(
      js,
      js.map(j => conv-pmf(j, lam-x, lam-y)),
      fill: purple.transparentize(50%),
    ),
    lq.vlines(z, stroke: purple + 1pt),
  )
}

#let zs = (1, 3, 5, 7, 9)
#grid(columns: 2, column-gutter: 1em, row-gutter: 1em,
  ..zs.map(z => input-plot(z)).zip(zs.map(z => conv-plot(z))).flatten())

=== Continuous

$
  f_Z (z) = integral_(-infinity)^(+infinity) f_X (x) f_Y (z - x) 
$

#let x = lq.linspace(-8, 8, num: 1000)

#let density-plot(shift) = lq.diagram(
  width: 6cm, height: 2cm,
  xlim: (-8, 8), ylim: (0, 0.45),
  xaxis: (tick-distance: 2),
  yaxis: (ticks: none),
  lq.plot(x, x => norm.pdf(x, mean: 0, std_dev: 1), mark: none, stroke: red),
  lq.fill-between(
    x,
    x.map(x => norm.pdf(x, mean: 0, std_dev: 1)),
    fill: red.transparentize(75%),
  ),
  lq.plot(x, x => norm.pdf(x, mean: shift, std_dev: 1), mark: none, stroke: blue),
  lq.fill-between(
    x,
    x.map(x => norm.pdf(x, mean: shift, std_dev: 1)),
    fill: blue.transparentize(75%),
  ),
  lq.vlines(shift, stroke: blue + 1.5pt)
)

#let conv(z) = calc.exp(-calc.pow(z, 2) / 4) / (2 * calc.sqrt(calc.pi))

#let conv-plot(shift) = {
  let xs = lq.linspace(-8, shift, num: 500)
  lq.diagram(
    width: 6cm, height: 2cm,
    xlim: (-8, 8), ylim: (0, 0.45),
    xaxis: (tick-distance: 2),
    yaxis: (ticks: none),
    lq.fill-between(
      xs,
      xs.map(conv),
      fill: gray.transparentize(60%),
      stroke: black,
    ),
    lq.vlines(shift, stroke: blue + 1.5pt),
  )
}

#let shifts = range(5).map(i => -6 + i * 3)

#let col1 = shifts.map(s => density-plot(s))

#let col2 = shifts.map(s => conv-plot(s))

#grid(
  columns: 2,
  column-gutter: 1em,
  row-gutter: 1em,
  ..col1.zip(col2).flatten(),
)


