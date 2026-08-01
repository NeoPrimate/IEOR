#import "/lib/imports.typ": *
#show: formatting

= Standard Error

$
  sigma / sqrt(n) quad quad quad s / sqrt(n)
$

*Standard deviation* of a statistic's sampling distribution

Fix $n$. For each $k = 1, 2, 3, ...$:

+ Draw a sample $x_1^((k)), ..., x_n^((k))$ of size $n$ from the population.
+ Compute its mean $obar(x)^((k))$.

The values $obar(x)^((1)), obar(x)^((2)), ...$ are draws from the *sampling
distribution* of the mean. Its standard deviation is the standard error.

*SE* is the *standard deviation* of those means. How much $obar(x)$ bounces around from sample to sample.

#table(
  columns: 3,
  inset: (x: 2em, y: 1em),
  stroke: none,
  table.hline(),
  [Population / single draw $X$], [$mu$], [$sigma$],
  table.hline(stroke: black.transparentize(75%)),
  [Sampling distribution of $obar(X)$], [$mu$], [$sigma \/ sqrt(n)$],
  table.hline(stroke: black.transparentize(75%)),
)

#code[
  ```py
  import numpy as np

  rng = np.random.default_rng(0)
  x = rng.normal(5.0, 2.0, 30)

  boot = rng.choice(x, size=(100_000, len(x)), replace=True).mean(axis=1)

  print(boot.std(ddof=1))                # 0.35
  print(x.std(ddof=1) / np.sqrt(len(x))) # 0.35
  print(stats.sem(x, ddof=1))            # 0.35
  ```
]

$
  s &= sqrt((sum_(i=1)^n (x_i - obar(x))^2) / (n - 1)) \
  \
  "SE" 
  &= s / sqrt(n) \
  &= sqrt((sum_(i=1)^n (x_i - obar(x))^2) / (n - 1)) dot 1 / sqrt(n) \
  &= sqrt((sum_(i=1)^n (x_i - obar(x))^2) / (n (n - 1))) \
$

== Derivation

Let $X_1, ..., X_n$ be i.i.d. with mean $mu$ and variance $sigma^2$.

$
  "Var"(obar(X))
  &= "Var"(1/n sum_(i=1)^n X_i) \
  &= 1/n^2 "Var"(sum_(i=1)^n X_i) \
  &= 1/n^2 sum_(i=1)^n "Var"(X_i)   quad &&"(uncorrelated)" \
  &= 1/n^2 sum_(i=1)^n sigma^2      quad &&"(identically distributed)" \
  &= (n sigma^2) / n^2 \
  &= sigma^2 / n
$

Taking the square root to get back to the units of $X$:

$
  "SE"(obar(X)) = sqrt("Var"(obar(X))) = sqrt(sigma^2 / n) = sigma / sqrt(n)
$

== Estimating $sigma$

The result above is exact, but $sigma$ is a property of the population and
is not observed. Estimate it with the sample standard deviation:

$
  s^2 = 1/(n - 1) sum_(i=1)^n (x_i - obar(x))^2, quad s = sqrt(s^2)
$

Substituting $s$ for $sigma$ gives the estimated standard error:

$
  hat("SE")(obar(X)) = s / sqrt(n) approx sigma / sqrt(n)
$