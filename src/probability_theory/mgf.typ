#import "/lib/imports.typ": *
#show: formatting

For a random variable $X$, its MGF is:

$
  G(t)
  &= sum_(i=1)^infinity (G^((k)) (0)) / k! \
  &= sum_(i=1)^infinity E[X^k] / k! t^k \
  &= E[sum_(i=1)^infinity (X^k t^k) / k!] \
  &= E[sum_(i=1)^infinity ((t X)^k) / k!] \
  &= E[e^(t X)]
$

Therefore:

$
  M_X (t) = E[e^(t X)]
$

In general $M_X^k (0) = E[X^k]$. So you turn the crank -- take $k$ derivatives, plug in $t=0$ and the $k$-th moment falls out.
The whole sequence of moments (mean via the first, variance via the second, skewness via the third, ...) is encoded in this one function, recoverable by differentiation.

#table(
  columns: 4,
  inset: 1em,
  [*Moment*], [*Name*], [*$f$*], [*Definition*],
  [1st], [Mean], [$G^1 (0) = E[X^k]$], [where the distribution sits],
  [2nd], [Variance], [$G^2 (0) = $], [How spread out it is],
  [3rd], [Skewness], [$G^3 (0) = $], [How lopsided it is (longer left or right tail)],
  [4th], [Kurtosis], [$G^4 (0) = $], [How heavy the tails are, how peaked],
  [5th ...], [No names], [$G^((k)) (0) = $], [No intuitive picture],
)

#example[
  
]

