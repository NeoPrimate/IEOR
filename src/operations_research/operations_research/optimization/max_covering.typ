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
