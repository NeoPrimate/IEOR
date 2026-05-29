#import "/lib/imports.typ": *
#show: formatting

*Max Covering Location Problem (MCLP)*: place exactly $p$ facilities to *maximize the demand covered*. Inversion of #link(<operations-research-optimization-set-covering>)[set covering]: fix count, maximize coverage.

== Formulation

Let $d_i$ = demand at customer $i$. Let $N_i = {j : c_(i j) <= d_("max")}$ — facilities that can cover $i$.

Decision variables:
- $y_j$ = open facility $j$?
- $z_i$ = customer $i$ covered? (auxiliary)

$
  max sum_i d_i z_i
$

s.t.:

$
  z_i <= sum_(j in N_i) y_j, #h(1em) forall i #h(2em) "(i covered only if at least one nearby facility is open)"
$

$
  sum_j y_j = p
$

$
  y_j, z_i in {0, 1}
$

== Picture

With $p = 2$ facilities and a fixed coverage radius, a low-demand outlier (red) is left uncovered — the budget is spent capturing the most demand.

#let f1_color = blue
#let f2_color = green
#let miss_color = red

#let customer = (x, y, name, w: 1, r: 5pt, col: gray.lighten(50%), bd: black) => node(
  (x, y), none,
  shape: circle, radius: (3 + w * 0.9) * 1pt,
  fill: col, stroke: bd + 0.4pt,
  name: name,
)

#let facility = (x, y, col, label, name) => node(
  (x, y),
  text(fill: col.darken(25%))[#label],
  shape: rect,
  width: 16pt, height: 16pt,
  corner-radius: 0.25em,
  fill: col.lighten(70%), stroke: col + 0.5pt,
  inset: 1pt, name: name
)

#let coverage = (x, y, col, name) => node(
  (x, y), none,
  shape: circle, radius: 50pt,
  fill: col.lighten(88%), stroke: (paint: col, dash: "dashed", thickness: 0.5pt),
  layer: -1, name: name,
)

#frame(fletcher.diagram(spacing: 8pt,
  coverage(1.7, 1.7, f1_color, <cov1>),
  coverage(4.7, 1.8, f2_color, <cov2>),

  customer(1.1, 1.1, <c1>, r: 6pt),
  customer(2.2, 1.0, <c2>, r: 6pt),
  customer(1.3, 2.2, <c3>, r: 7pt),
  customer(2.3, 2.2, <c4>, r: 5pt),
  customer(4.1, 1.2, <c5>, r: 6pt),
  customer(5.3, 1.4, <c6>, r: 7pt),
  customer(4.5, 2.4, <c7>, r: 6pt),
  customer(5.4, 2.3, <c8>, r: 5pt),
  customer(3.2, 3.4, <miss>, r: 4pt, col: miss_color.lighten(40%), bd: miss_color),

  facility(1.7, 1.7, f1_color, [F1], <f1>),
  facility(4.7, 1.8, f2_color, [F2], <f2>),
))

== Connection to $p$-center and set covering

#table(
  columns: 3,
  align: (left, left, left),
  stroke: none,
  table.header([Problem], [Objective], [Fixed]),
  [#link(<operations-research-optimization-set-covering>)[Set covering]], [minimize number of facilities], [cover all demand within $d_("max")$],
  [#link(<operations-research-optimization-p-center>)[$p$-center]], [min $d_("max")$], [$p$ facilities, cover all],
  [Max covering], [max demand covered], [$p$ facilities and $d_("max")$ fixed],
)

Picks two corners (fix $p$ and $d_("max")$) and maximizes coverage. Useful when budget *and* service distance are both constraints.

== Greedy approximation

Greedy is a $1 - 1/e approx 0.63$ approximation:

```
While p facilities not yet picked:
    Pick the facility that adds the most new covered demand
```

This is *optimal* for max-coverage problems (Nemhauser-Wolsey-Fisher 1978) — no polynomial-time algorithm exceeds $1 - 1/e$ unless P = NP.

== Submodularity

The function $f(S) =$ "demand covered by set of facilities $S$" is *monotone submodular*:

$
  f(S union {j}) - f(S) >= f(T union {j}) - f(T) #h(1em) "for" S subset T
$

— adding $j$ to a smaller set gives at least as much marginal value as adding it to a bigger set (*diminishing returns*).

The $1 - 1/e$ bound is the classical Nemhauser bound for monotone submodular maximization with a cardinality constraint.

== Applications

- *Retail* — pick $p$ store locations to capture max market share within an acceptable drive time
- *Cell towers* — $p$ towers to cover the most population
- *Recall logistics* — pick $p$ warehouses to recall product from
- *Influence maximization* — viral marketing, $p$ seed users to maximize reach

== See also

- *#link(<operations-research-optimization-set-covering>)[Set Covering]* — dual variant
- *#link(<operations-research-optimization-p-center>)[$p$-center]*
- *#link(<operations-research-optimization-facility-location>)[Facility Location overview]*
