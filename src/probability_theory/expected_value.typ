#import "/lib/imports.typ": *
#show: formatting

The *expected value* $EE[X]$ is the probability-weighted average of a random variable — its long-run mean over many draws.

== Discrete

Weight each value $x_i$ by its probability $p_i$ and sum:

$
  EE[X] = sum_(i=1)^n x_i dot p_i
$

#example[
  Fair die: $EE[X] = sum_(k=1)^6 k dot 1/6 = 21 / 6 = 3.5$
]

== Continuous

Swap the sum for an integral, and the mass $p_i$ for $f(x) dif x$:

$
  EE[X] = integral_(-infinity)^infinity x dot f(x) dif x
$

== Partial (truncated) expectation

Average $x$ over only a window $[a, b]$ — same integrand, restricted limits:

$
  integral_a^b x dot f(x) dif x = EE[X dot 1_{a lt.eq X lt.eq b}]
$

where $1_{(dot)}$ is the *indicator* (1 when the condition holds, 0 otherwise). This is *not* a mean — it is not renormalized, so it shrinks toward 0 as the window captures less probability.

== Conditional expectation

Renormalize by the probability of the window — now it *is* a true average, given that $X$ landed in $[a, b]$:

$
  EE[X | a lt.eq X lt.eq b] = (integral_a^b x dot f(x) dif x) / P(a lt.eq X lt.eq b)
$

== LOTUS

*Law of the Unconscious Statistician.* To average a function $g(X)$, integrate $g$ against the density of $X$ — no need to first find the distribution of $g(X)$:

$
  EE[g(X)] = integral_(-infinity)^infinity g(x) dot f(x) dif x
$
