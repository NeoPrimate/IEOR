#import "/lib/imports.typ": *
#show: formatting

The generalization of the #link(<supply-chain-risk-pooling-square-root-law>)[square-root law] to demand sources with non-zero pairwise correlation. The crucial formula:

$
  sigma_("pool")^2 = sum_(i=1)^N sigma_i^2 + 2 sum_(i < j) rho_(i j) sigma_i sigma_j
$

where $rho_(i j)$ is the correlation between demands $D_i$ and $D_j$.

== Derivation

For random variables $D_1, dots, D_N$ with $"Var"(D_i) = sigma_i^2$ and $"Cov"(D_i, D_j) = rho_(i j) sigma_i sigma_j$:

$
  "Var"(sum D_i) = sum_i "Var"(D_i) + 2 sum_(i < j) "Cov"(D_i, D_j)
$

$
  = sum_i sigma_i^2 + 2 sum_(i < j) rho_(i j) sigma_i sigma_j
$

== Three regimes

For identical $sigma_i = sigma$ and uniform $rho_(i j) = rho$:

$
  sigma_("pool")^2 = N sigma^2 + N(N-1) rho sigma^2 = sigma^2 [N + N(N-1) rho]
$

$
  sigma_("pool") = sigma sqrt(N + N(N-1) rho)
$

#table(
  columns: 3,
  align: (center, left, center),
  stroke: none,
  table.header([$rho$], [Pooled $sigma$ as $N -> infinity$], [Benefit]),
  [$= 0$], [$sigma sqrt(N)$], [classic square-root law (full pooling benefit)],
  [$> 0$], [$sigma sqrt(N + N(N-1) rho) -> sigma N sqrt(rho)$ for large $N$], [reduced benefit — pool variance grows linearly in $N$],
  [$< 0$], [$sigma sqrt(N + N(N-1) rho)$ can be smaller], [enhanced benefit — pool variance grows sub-linearly],
  [$= 1$], [$sigma N$], [no benefit — perfectly correlated demand sums proportionally],
  [$= -1/(N-1)$], [$0$], [perfect cancellation — sum is deterministic],
)

== Numerical example

$N = 4$ stores, each $sigma = 30$. Compare pooling under different correlations:

#table(
  columns: 3,
  align: (center, center, center),
  stroke: none,
  table.header([$rho$], [$sigma_("pool")$], [SS at $z = 1.65$]),
  [$0$ (independent)], [$sigma sqrt(4) = 60$], [$99$],
  [$0.3$ (somewhat positive)], [$sqrt(4 + 12 dot 0.3) dot 30 approx 86$], [$142$],
  [$0.5$], [$sqrt(4 + 12 dot 0.5) dot 30 approx 95$], [$156$],
  [$1$ (perfect positive)], [$sqrt(4 + 12) dot 30 = 120$], [$198$],
  [$-0.2$ (slight negative)], [$sqrt(4 - 12 dot 0.2) dot 30 approx 51$], [$84$],
)

Compare: separate-stock total SS = $4 dot 1.65 dot 30 = 198$.

*Independent* pooling cuts that in half.
*Highly correlated* pooling provides *no benefit*.
*Negatively correlated* pooling beats independent.

== Intuition

When demands move *together* (positive correlation):
- Peaks and troughs reinforce — combined demand is *more* variable per unit of mean
- Pooling does little; you'd need to cover the joint peak anyway

When demands move *opposite* (negative correlation):
- One source up while another down — combined demand is *smoother*
- Pooling is *more* beneficial than for independent demands

== Sources of correlation

#table(
  columns: 2,
  align: (left, left),
  stroke: none,
  table.header([*Type*], [*Typical $rho$*]),
  [Same product, different regions, no shared shocks], [near $0$],
  [Same product, similar markets / season], [moderate $+$],
  [Same product nationwide (TV ads, viral)], [high $+$],
  [Substitute products in same store], [moderate $-$],
  [Complementary products (winter / summer items)], [strong $-$],
)

== Practical consequences

- *Diversification works* like in finance: bundle products with low / negative correlation to reduce inventory volatility
- *Common cause events* (weather, holidays, economic shocks) drive correlations up — risk pooling benefit shrinks during them
- *Always estimate empirical $rho$* before claiming pooling savings — independence is rarely a safe assumption

== See also

- *#link(<supply-chain-risk-pooling-risk-pooling>)[Risk Pooling]* — overview
- *#link(<supply-chain-risk-pooling-square-root-law>)[Square-Root Law]* — independent case
- *#link(<statistics-correlation-pearson>)[Pearson Correlation]*
