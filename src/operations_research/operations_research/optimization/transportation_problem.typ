#import "/lib/imports.typ": *

A classical LP: ship supply from $m$ sources to $n$ destinations at minimum cost.

== Formulation

Decision variable $x_(i j)$ = units shipped from source $i$ to destination $j$.

$
  min sum_(i=1)^m sum_(j=1)^n c_(i j) x_(i j)
$

subject to:

$
  sum_j x_(i j) = s_i, #h(1em) i = 1, dots, m #h(2em) "(supply at source" i = s_i ")"
$

$
  sum_i x_(i j) = d_j, #h(1em) j = 1, dots, n #h(2em) "(demand at destination" j = d_j ")"
$

$
  x_(i j) >= 0
$

*Balanced*: $sum s_i = sum d_j$. If unbalanced, add a dummy source / sink.

== Structure

- $m n$ decision variables, $m + n$ equality constraints (one redundant) → $m + n - 1$ basic variables in any BFS
- Constraint matrix is *totally unimodular* — LP relaxation always has integer optimum (with integer supply/demand)
- Special structure → much faster than general simplex

== Solution algorithms

1. *Northwest-corner rule* — initial BFS by greedy fill from upper-left
2. *Vogel's approximation method (VAM)* — better initial BFS using opportunity costs
3. *MODI / stepping stone* — improvement iterations on a BFS to optimality
4. *Transportation simplex* — specialized simplex exploiting structure; $O((m+n)^2)$ per pivot vs $O((m n)^2)$ for general

For large instances: just use #link(<operations-research-optimization-network-simplex>)[network simplex].

== Special cases

- *#link(<operations-research-optimization-assignment-problem>)[Assignment problem]* — $m = n$, all $s_i = d_j = 1$, $x in {0, 1}$
- *#link(<operations-research-optimization-transshipment-problem>)[Transshipment]* — allow intermediate nodes
- *MCNF* — generalization with arc capacities (#link(<operations-research-optimization-multi-commodity-network-flow>)[here])

== See also

- *#link(<operations-research-optimization-assignment-problem>)[Assignment Problem]*
- *#link(<operations-research-optimization-transshipment-problem>)[Transshipment]*
- *#link(<operations-research-optimization-network-simplex>)[Network Simplex]*
- *#link(<operations-research-optimization-linear-programming>)[Linear Programming]*
