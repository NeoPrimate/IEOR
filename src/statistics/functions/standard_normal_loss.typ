#import "/lib/imports.typ": *
#show: formatting

The *standard normal loss function*, denoted $L(z)$ or $G(z)$, is the *expected shortfall above a threshold $z$* for a standard normal random variable $Z ~ cal(N)(0, 1)$:

$
  L(z) = E[(Z - z)^+] = integral_z^infinity (t - z) phi(t) #h(0.1em) d t
$

where $phi$ is the standard normal PDF and $(x)^+ = max(x, 0)$.

== Closed form

Integration by parts gives:

$
  L(z) = phi(z) - z [1 - Phi(z)]
$

where $Phi$ is the standard normal CDF. Both $phi(z)$ and $Phi(z)$ are tabulated; combining them gives $L(z)$.

#example[
  $
    L(0) = phi(0) - 0 = 1/sqrt(2 pi) approx 0.3989 \
    L(1) = phi(1) - 1 dot [1 - Phi(1)] = 0.2420 - 0.1587 approx 0.0833 \
    L(2) = phi(2) - 2 dot [1 - Phi(2)] = 0.0540 - 2 dot 0.0228 approx 0.0085
  $

  $L(z)$ decreases rapidly with $z$ — large thresholds have negligible expected shortfall.
]

== Table of values

#table(
  columns: 6,
  align: (center, center, center, center, center, center),
  stroke: none,
  table.header([$z$], [$L(z)$], [$z$], [$L(z)$], [$z$], [$L(z)$]),
  $0.0$, $0.3989$, $1.0$, $0.0833$, $2.0$, $0.0085$,
  $0.1$, $0.3509$, $1.1$, $0.0686$, $2.1$, $0.0065$,
  $0.2$, $0.3069$, $1.2$, $0.0561$, $2.2$, $0.0049$,
  $0.3$, $0.2668$, $1.3$, $0.0455$, $2.3$, $0.0037$,
  $0.4$, $0.2304$, $1.4$, $0.0367$, $2.4$, $0.0027$,
  $0.5$, $0.1978$, $1.5$, $0.0293$, $2.5$, $0.0020$,
  $0.6$, $0.1687$, $1.6$, $0.0232$, $2.6$, $0.0015$,
  $0.7$, $0.1429$, $1.7$, $0.0183$, $2.7$, $0.0011$,
  $0.8$, $0.1202$, $1.8$, $0.0143$, $2.8$, $0.0008$,
  $0.9$, $0.1004$, $1.9$, $0.0111$, $2.9$, $0.0005$,
)

For $z < 0$: $L(z) = L(-z) + (-z) = L(|z|) - z$ (use symmetry of $phi$).

== Use case: safety-stock derivations

The reason this function is everywhere in supply-chain math: the expected shortfall (in stock units) per replenishment cycle, when demand during lead time is $cal(N)(mu_L, sigma_L^2)$ and the reorder point is $r = mu_L + z sigma_L$:

$
  "E[shortfall per cycle]" = sigma_L #h(0.2em) L(z)
$

So $L(z)$ converts "how many sigma above the mean did I stock" into "expected units short per replenishment." This drives:

- *Fill rate*: $beta = 1 - (sigma_L #h(0.2em) L(z))/Q$ — see #link(<supply-chain-service-levels-fill-rate>)[Fill Rate]
- *Safety stock*: solve $L(z) = ((1 - beta) Q) / sigma_L$ for $z$, then $"SS" = z sigma_L$
- *Newsvendor expected lost sales*: $sigma #h(0.2em) L(z^*)$ at the optimal critical-ratio quantile
- *Newsvendor expected leftover*: $sigma #h(0.2em) [L(z) + z]$

== Properties

- *Non-increasing*: $L(z)$ decreases monotonically as $z$ increases (more inventory → less expected shortfall)
- *Asymptotic*: $L(z) -> 0$ as $z -> infinity$; $L(z) ~ -z$ as $z -> -infinity$
- *Derivative*: $L'(z) = -[1 - Phi(z)] = -P(Z > z)$ (note: $L'(z) <= 0$, confirming monotonicity)
- *Convexity*: $L(z)$ is convex — second derivative $L''(z) = phi(z) >= 0$

== Connection to standard normal PDF / CDF

$
  L(z) = phi(z) - z #h(0.2em) overline(Phi)(z), #h(2em) overline(Phi)(z) = 1 - Phi(z)
$

— see #link(<statistics-functions-pdf>)[PDF], #link(<statistics-functions-cdf>)[CDF], #link(<statistics-functions-sf>)[SF].

== See also

- *#link(<statistics-probability-distributions-gaussian>)[Gaussian Distribution]*
- *#link(<supply-chain-service-levels-fill-rate>)[Fill Rate]*
- *#link(<supply-chain-stocks-safety-stock>)[Safety Stock]*
- *#link(<supply-chain-newsvendor-overview>)[Newsvendor]*
