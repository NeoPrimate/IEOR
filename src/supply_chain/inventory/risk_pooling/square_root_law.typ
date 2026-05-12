#import "/lib/imports.typ": *
#show: formatting

For $N$ independent demand sources with identical mean $mu$ and standard deviation $sigma$, the standard deviation of total demand grows with $sqrt(N)$ (not $N$). This is the *square-root law* — the central result of #link(<supply-chain-risk-pooling-risk-pooling>)[risk pooling].

== Statement

Let $D_1, dots, D_N$ be independent, identically distributed random variables with $E[D_i] = mu, "Var"(D_i) = sigma^2$. Then for $S = sum_(i=1)^N D_i$:

$
  E[S] = N mu
$

$
  "Var"(S) = N sigma^2 #h(2em) ("variance is additive")
$

$
  sigma_S = sigma sqrt(N) #h(2em) ("standard deviation grows as" sqrt(N))
$

== Why variance is additive (proof sketch)

For independent random variables:

$
  "Var"(D_1 + D_2 + dots + D_N) = sum_(i=1)^N "Var"(D_i) + 2 sum_(i < j) "Cov"(D_i, D_j)
$

Independence forces $"Cov"(D_i, D_j) = 0$, so:

$
  "Var"(S) = sum_(i=1)^N sigma^2 = N sigma^2
$

Taking square root: $sigma_S = sigma sqrt(N)$. ∎

(The non-i.i.d. case with general covariances is the *#link(<supply-chain-risk-pooling-correlated-pooling>)[correlated pooling]* formula.)

== Safety-stock implication

If safety stock is $z sigma$ for each of $N$ separate facilities, total:

$
  "SS"_("separate") = N z sigma
$

If pooled into one facility:

$
  "SS"_("pool") = z #h(0.2em) sigma_S = z sigma sqrt(N)
$

Reduction factor:

$
  "SS"_("pool") / "SS"_("separate") = sqrt(N) / N = 1 / sqrt(N)
$

#table(
  columns: 4,
  align: (center, center, center, center),
  stroke: none,
  table.header([$N$], [SS separate], [SS pooled], [reduction]),
  [4], [$4 z sigma$], [$2 z sigma$], [50%],
  [9], [$9 z sigma$], [$3 z sigma$], [67%],
  [25], [$25 z sigma$], [$5 z sigma$], [80%],
  [100], [$100 z sigma$], [$10 z sigma$], [90%],
)

== Numerical example

A retailer with $N = 16$ stores. Each store: weekly demand $mu = 100$, $sigma = 30$.

*Each store needs* safety stock $z sigma = 1.65 dot 30 = 49.5$ units for 95% service.

*Separate total*: $16 dot 49.5 = 792$ units.

*Pooled (one warehouse covering all)*:

$
  sigma_("pool") = 30 sqrt(16) = 120 \
  "SS"_("pool") = 1.65 dot 120 = 198 #h(2em) "units"
$

Reduction: $198 / 792 = 25%$ of original safety stock. *75% savings on safety stock*.

== Generalization to non-identical demands

If $sigma_i$'s differ:

$
  sigma_("pool") = sqrt(sum_i sigma_i^2)
$

If correlations $rho_(i j) eq.not 0$:

$
  sigma_("pool")^2 = sum_i sigma_i^2 + 2 sum_(i < j) rho_(i j) sigma_i sigma_j
$

See #link(<supply-chain-risk-pooling-correlated-pooling>)[Correlated Pooling].

== Why this is "square-root"

Demand is *sum* of $N$ random variables. By CLT-like arguments, the sum grows as $N$ (in mean) but the *fluctuation* about the mean grows only as $sqrt(N)$. The fluctuation is what safety stock covers. Hence the savings.

This is the *same* phenomenon as the standard error of a sample mean shrinking as $1/sqrt(n)$.

== Limitations

- *Independence assumed* — positively correlated demands give less benefit
- *Identical $sigma$'s assumed* — partial concentration in high-variance locations matters
- *Service level unchanged* — but pooling might allow higher service for same cost
- *Ignores transport cost* — central stock is farther from some customers

See #link(<supply-chain-risk-pooling-risk-pooling>)[Risk Pooling] for trade-offs.

== See also

- *#link(<supply-chain-risk-pooling-risk-pooling>)[Risk Pooling]* — overview
- *#link(<supply-chain-risk-pooling-correlated-pooling>)[Correlated Pooling]* — non-independent case
- *#link(<supply-chain-risk-pooling-location-pooling>)[Location Pooling]* — application
- *#link(<supply-chain-stocks-safety-stock>)[Safety Stock]*
