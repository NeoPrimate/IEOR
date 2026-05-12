#import "/lib/imports.typ": *
#show: formatting

The empirical observation that *cost or time per unit decreases by a constant percentage* every time cumulative production doubles. Discovered by T. P. Wright (1936) studying aircraft production at Curtiss-Wright.

== Wright's formula

Time (or cost) for the $n$-th unit:

$
  T_n = T_1 n^(-b)
$

where:
- $T_1$: time for the first unit
- $b$: learning exponent
- $n$: cumulative unit number

The *learning rate* $L$ — the proportion of time the $2 n$-th unit takes relative to the $n$-th:

$
  L = T_(2 n) / T_n = (2 n)^(-b) / n^(-b) = 2^(-b)
$

So $b = -log_2(L) = -ln L / ln 2$.

== Common learning rates

#table(
  columns: 3,
  align: (center, center, left),
  stroke: none,
  table.header([Learning rate $L$], [Exponent $b$], [Example industry]),
  [80%], [0.322], [Aircraft assembly (Wright's original)],
  [85%], [0.234], [Automotive],
  [90%], [0.152], [Electronics, software],
  [95%], [0.074], [Highly automated; little learning],
  [70%], [0.515], [Complex assembly, lots of skill],
)

Lower $L$ → faster learning. $L = 100%$ means no learning.

== Crawford's unit model vs cumulative average

Two conventions:

*Wright (unit model)*: $T_n$ is the time for the *$n$-th unit specifically*.

*Crawford (cumulative average)*: $bar(T)_n$ is the *average* time across all units $1$ to $n$. Same $L$, but different curves and different interpretations.

#table(
  columns: 3,
  align: (left, left, left),
  stroke: none,
  table.header([], [*Wright unit*], [*Crawford cumulative average*]),
  [Formula], $T_n = T_1 n^(-b)$, $bar(T)_n = T_1 n^(-b)$,
  [Interpretation], [time of the $n$-th unit], [average time over first $n$ units],
)

Crawford's average always overstates per-unit improvement vs Wright (averaging includes early high-time units). Industries vary in which they use.

== Cumulative cost

Total time / cost for the first $n$ units:

$
  C_n = sum_(k=1)^n T_1 k^(-b) approx T_1 dot n^(1-b) / (1-b) #h(0.5em) "(continuous approximation for large" n")"
$

For Crawford model: $C_n = n bar(T)_n = T_1 n^(1-b)$.

== Strategic implications (BCG, 1960s)

*Boston Consulting Group* famously generalized learning curves to *experience curves* — all costs (not just labor) decline with cumulative volume.

Strategic implications:

- *Cost leadership through scale*: the highest-volume producer has the lowest unit cost
- *Predatory pricing*: price below current cost to grab share, ride the curve to profitability
- *First-mover advantage*: head start on the curve is hard to overtake

Famous critiques (Henderson, BCG): treat learning as a *strategic asset* and a *barrier to entry*.

== Limitations

- *Empirical, not causal*: explains pattern, doesn't explain *why* learning happens
- *Discontinuities*: new product / process resets the curve
- *Diminishing returns*: long-run learning saturates
- *Stanford-B / DeJong adjustments*: include an "incompressibility factor" — costs can't fall below some floor

DeJong's model:

$
  T_n = T_1 (M + (1 - M) n^(-b))
$

where $M in [0, 1]$ is the incompressibility floor.

== See also

- *#link(<supply-chain-manufacturing-factory-physics>)[Factory Physics]*
- *#link(<supply-chain-manufacturing-takt-time>)[Takt Time]* — performance target as learning advances
