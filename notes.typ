#import "/lib/imports.typ": *

- If you don't understand the continuous, try the discrete
- If you don't understand the multivariate, try the univariate
- If you don't understand the calculus / linear algebra / etc., try the geometric interpretation

= Lead Time

Why $sqrt(L)$?

Setup

Daily demand has mean $mu$ and standard deviation $sigma$

Say:
- $mu=100$
- $sigma=20$

One day:
- Mean is $mu = 100$
- Spread is $sigma = 20$

Two days:
- Demand: $D_1 + D_2$ (each day is independent)

Mean add:

$
  EE[D_1 + D_2] = mu_1 + mu_2 = 2mu = 200
$

But standard deviations do *NOT* add, Variances add:

$
  "Var"(D_1 + D_2) = "Var"(D_1) + "Var"(D_2) = sigma_1^2 + sigma_2^2 = 2 sigma^2
$

So:

$
  "Std"(D_1 + D_2) = sqrt(2 sigma^2) = sigma sqrt(2)
$

Generalize to $L$ days:

$
  "Var"(sum_(t=1)^L D_t) = L dot sigma^2
$

$
  "Std"(sum_(t=1)^L D_t) = sigma sqrt(L)
$

- Mean scales with $L$
- Std scales with $sqrt(L)$

= Multi-Echelon Inventory

Setup:

Consider a serial system with $N$ stages, where stage $N$ faces stochastic customer demand and each replenished from stage $j + 1$ with deterministic lead time $L_j$:

$
  "Stage" N arrow "Stage" (N - 1) arrow dots arrow "Stage" 1 arrow "External Supplier"
$

= Newsvendor Model

Critical Ratio

Probability you *don't stock out*:
- Type-1 service level
- In-stock probability

$F(Q) = P(D lt.eq Q)$: the probability that demand is *at most* $Q$

The left side is the in-stock probability at the optimum:

$
  F(Q^*) = c_u / (c_u + c_o) \
  Q^* = F^(-1)(c_u / (c_u + c_o))
$

$
  c_u = p - c \
  c_o = c - s \
$

Where:
- $c$: unit cost cost per unit
- $p$: sale price per unit
- $s$: salvage price per unit

You order $Q$ units. Then demand $D$ shows up. One of two things happens:
- Case 1: You ordered too much ($Q > D$)

You sold $D$ units \
You have $Q - D$ leftover units sitting there, useless

- Case 2: You ordered too little ($Q < D$)

You sold $Q$ units (all you had)\
You missed out on $D − Q$ sales you could have made.

Notice these cases are mutually exclusive. You're either over or under — never both at the same time.

Attach a Cost to Each Mistake

- Each leftover unit costs you $c_o$ (overage cost)
- Each missed sale costs you $c_u$ (underage cost)

So the actual cost for a given realization of demand $D$ is:

$
  C = cases(
    c_o dot (Q - D) "if" Q > D quad "(overage)",
    c_u dot (D - Q) "if" D > Q quad "(underage)",
  )
$

The $(⋅)^+$ Notation is a Trick to Combine Both Cases

Writing piecewise functions is clunky. The notation $(x)^+ = max(x, 0)$ lets us collapse both cases into one expression:

$
  (Q - D)^+ = cases(
    Q - D "if" Q > D,
    0 "otherwise",
  )
$

$
  (D - Q)^+ = cases(
    D - Q "if" D > Q,
    0 "otherwise",
  )
$

So the total cost for a given $D$ becomes:

$
   C(Q, D) = c_o dot (Q − D)^+ + c_u dot (D − Q)^+
$

Why does this work? Because at most one of these terms is nonzero for any given $D$. If:
- $D < Q$: the first term is positive and the second is zero.
- $D > Q$: the first term is zero and the second is positive.
- $D = Q$: both are zero

We can't minimize a random quantity directly. We minimize its average over the distribution of demand. That's why we take the expectation:

$
   EE[C(Q, D)] = EE[c_o dot (Q − D)^+ + c_u dot (D − Q)^+]
$

By linearity of expectation (constants pull out, sums split):

$
   C(Q) = c_o dot EE[(Q − D)^+] + c_u dot EE[(D − Q)^+]
$

We want to find the $Q$ that minimizes:

$
   C(Q) &= c_o dot EE[(Q − D)^+] + c_u dot EE[(D − Q)^+] \
   Q^∗ &= arg min_Q​C(Q)
$

== Rewrite the Expectations as Integrals:

$
  EE[(Q - D)^+] = integral_0^Q (Q - x) f(x) dif x
$

$
  EE[(D - Q)^+] = integral_Q^infinity (x - Q) f(x) dif x
$

- We're averaging $(Q − x)$ over all values of $x$, weighted by how likely each $x$ is. But $(Q - x)^+$ is zero whenever $x > Q$, so we only integrate from 0 to $Q$. Above $Q$, the integrand vanishes.
- We're averaging $(x − Q)$ over all values of $x$, weighted by how likely each $x$ is. But $(x - Q)^+$ is zero whenever $x < Q$, so we only integrate from $Q$ to $infinity$. Below $Q$, the integrand vanishes.

$
  C(Q) = c_o dot integral_0^Q (Q - x) f(x) dif x + c_u dot integral_Q^infinity (x - Q) f(x) dif x
$

== Differentiate with Respect to $Q$

We need $(dif C) / (dif Q)$, the value of $Q$ that minimzes $C(Q)$. 

1. First Term (upper limit depends on $Q$)

$
  dif / (dif Q) [integral_0^Q (Q - x) f(x) dif x]
$

$
  &= underbrace(integral_0^Q partial / (partial Q) (Q - x) f(x) dif x, "differentiate inside") + underbrace((Q - x) bar_(x=Q) dot f(Q) dot (dif Q) / (dif Q), "boundary term (upper limit)") \
  &= integral_0^Q 1 dot f(x) dif x + (Q - Q) dot f(Q) dot 1 \
  &= integral_0^Q f(x) dif x + 0 \
  &= F(Q)
$

2. Second term

$
  dif / (dif Q) [integral_Q^infinity (x - Q) f(x) dif x]
$

$
  &= underbrace(integral_Q^infinity partial / (partial Q) (x - Q) f(x) dif x, "differentiate inside") - underbrace((x - Q) bar_(x=Q) dot f(Q) dot (dif Q) / (dif Q), "boundary term (lower limit)") \
  &= integral_Q^infinity (-1) dot f(x) dif x - (Q - Q) dot f(Q) dot 1 \
  &= - integral_Q^infinity f(x) dif x - 0 \
  &= -(1 - F(Q))
$

Putting it all together

$
  (dif C) / (dif Q) = c_o dot F(Q) - c_u dot (1 - F(Q))
$

== Set the Derivative to Zero

$
  c_o​dot F(Q^∗) − c_u​dot (1 − F(Q^∗)) = 0
$

Solve:

$
  c_o​dot F(Q^∗) = c_u​- c_u​dot F(Q^∗) \
  c_o​dot F(Q^∗) + c_u​dot F(Q^∗) = c_u​− c_u​dot F(Q^∗) + c_u​dot F(Q^∗) \
  c_o​dot F(Q^∗) + c_u​dot F(Q^∗) = c_u \
  F(Q^*) (c_o + c_u) = c_u \
  F(Q^*) = c_u / (c_u + c_o)​
$

This is the critical ratio (or critical fractile). The optimal order quantity is the one where the CDF of demand equals this ratio.
In other words:

$
  Q^* = F^(-1) (c_u / (c_u + c_o))
$

== Check It's a Minimum (Not a Maximum)

Take the second derivative of:

$
  (dif C) / (dif Q) = c_0 dot F(Q) - c_u dot (1 - F(Q))
$

Using:

$
  dif / (dif Q) F(Q) = f(Q) \
  dif / (dif Q) [1 - F(Q)] = -f(Q) \ 
$

We get:

$
  (dif^2 C) / (dif Q^2) = c_o dot f(Q) + c_u dot f(Q) = (c_o + c_u) f(Q) gt.eq 0
$

Since this is non-negative (assuming $f(Q) gt 0$), $C(Q)$ is convex and the critical ratio is the global minimum. 

#code([$Q^* = F^(-1)("cr")$])[
```py
from scipy.stats import norm

mu, sigma = 50, 12
c_u, c_o = 5, 3

cr = c_u / (c_u + c_o)    
z = norm.ppf(cr)           
# Q_star = norm.ppf(cr, loc=mu, scale=sigma)
Q_star = mu + sigma * z
```
]

#code([$Q^∗=F^(−1)(0.95)$])[
  ```py
  from scipy.stats import norm

  serive_level = 0.95

  z = norm.ppf(service_level)           
  # Q_star = norm.ppf(service_level, loc=mu, scale=sigma)
  Q_star = mu + sigma * z
  ```
]

#table(
  columns: 2,
  inset: 1em,
  [Question], [Integral],
  [How often do I stock out?], [
    $
      integral_Q^infinity f(x) dif x
    $
  ],
  [How badly do I stock out on average?], [
    $
      integral_Q^infinity (x - Q) f(x) dif x
    $
  ],
  [How often am I overstocked?], [
    $
      integral_0^Q f(x) dif x
    $
  ],
  [How badly am I overstocked on average?], [
    $
      integral_0^Q (Q - x) f(x) dif x    
    $
  ],
)


== Profit Maximization

The same $Q^*$ can be obtained by maximizing profit rather than minimizing costs:

$
  Pi(Q) = p dot EE[min(Q, D)] + s dot EE[(Q−D)^+] − c dot Q \
  Q^* = arg max_Q Pi(Q)
$

== Discrete

$
  C(Q) = c_o sum_(k=0)^Q (Q - k) p(k) + c_u sum_(k=Q+1)^infinity (k - Q) p(k)
$

Finite differences:

$
  Delta C(Q) = C(Q + 1) - C(Q)
$

$
  Delta C(Q) = c_o dot F(Q) - c_u dot (1 - F(Q))
$

$
  Q^* = min { Q: F(Q) gt.eq c_u / (c_u + c_o) }
$

#code([$$])[
  ```py
  from scipy.stats import poisson

  lam = 4
  cr = 5 / (5 + 3)

  Q = 0
  while poisson.cdf(Q, lam) < cr:
      Q += 1
  Q_star = Q
  ```
]

= Standard Normal Loss Function

#result[
  $
    L(k) = integral_k^infinity (z - k) phi.alt (z) dif z
  $
]
#result[
  $
    L(k) = phi.alt(k) - k dot (1 - Phi(k))
  $
]




#code([$L(k) = phi.alt(k) - k dot (1 - Phi(k))$])[
  ```py
  from scipy.stats import norm
  import numpy as np

  mu, sigma = 50, 12
  c_u, c_o = 5, 3

  # Optimal Q from critical ratio
  cr = c_u / (c_u + c_o)
  k_star = norm.ppf(cr)
  Q_star = mu + sigma * k_star

  # Standard normal loss function
  def L(k):
      return norm.pdf(k) - k * (1 - norm.cdf(k))

  expected_lost_sales = sigma * L(k_star)
  expected_sales = mu - expected_lost_sales
  expected_leftover = Q_star - mu + sigma * L(k_star)
  ```
]


= Differentiating Normal Distribution

$
  f(x) = 1 / sqrt(2 pi sigma^2) exp(- (x - mu)^2 / (2 sigma^2))
$

We want $f'(x) = dif / (dif x) f(x)$

- $mu$, $sigma$: constants
- $x$: variable

Step 1. Structure

Two factors:

$
  f(x) = underbrace(1 / sqrt(2 pi sigma^2), "constant") dot underbrace(exp(- (x - mu)^2 / (2 sigma^2)), "function of" x)
$

First factor is a constant (does not depend on $x$):

$
  f'(x) = 1 / sqrt(2 pi sigma^2) dot dif / (dif x) exp(- (x - mu)^2 / (2 sigma^2))
$

Step 2: Set up the chain rule

$
  u(x) = - (x - mu)^2 / (2 sigma^2)
$

Then

$
  exp(- (x - mu)^2 / (2 sigma^2)) = exp(u(x))
$

The chain rule:

$
  dif / (dif x) exp(u(x)) = exp(u(x)) dot u'(x)
$

We need 2 things:
- $exp(u(x)) = exp(u(x))$
- $u'(x)$

Step 3. Differentiate $u(x)$

$
  u(x) = - (x - mu)^2 / (2 sigma^2)
$

3.a. Pull out constant

$
  u(x) = - 1 / (2 sigma^2) dot (x - mu)^2
$

The factor $- 1 / 2 sigma^2$ depends only on $sigma$, not $x$. Constants pull out of derivatives:

$
  u'(x) = - 1 / (2 sigma^2) dot dif / (dif x) (x - mu)^2
$

Now we need $dif / (dif x) (x - mu)^2$

3.b. Apply chain rule again to $(x - mu)^2$

This is itself a composition:
- Outer function: $v^2$ where $v = x - mu$
- Inner function: $v(x) = x - mu$

Chain rule:

$
  dif / (dif x) (x - mu)^2 = dif / (dif v) (v^2) dot (dif v) / (dif x)
$

Outer derivative:

$
  dif / (dif v) (v^2) = 2 v = 2 (x - mu)
$

Inner derivative: $v(x) = x - mu$

Since $mu$ is a constant, $(dif u) / (dif x) = 0$. So:

$
  (dif v) / (dif x) = dif / (dif x) (x - mu) = dif / (dif x) (x) - dif / (dif x) (mu) = 1 - 0 = 1
$

Combine:

$
  dif / (dif x) (x - mu)^2 = 2 (x - mu) dot 1 = 2 (x - mu)
$

3.c. Put Step 3 together

Substitute back into expression for $u'(x)$

$
  u'(x) = - 1 / (2 sigma^2) dot (x - mu)
$

Simplify be canceling the 2's:

$
  u'(x) = - (2 (x - mu) / (2 sigma^2)) = - (x - mu) / sigma^2
$

So:

$
  u'(x) = - (x - mu) / sigma^2
$

Step 4. Apply chain tule from Step 2

We had:

$
  dif / (dif x) exp(u(x)) = exp(u(x)) dot u'(x)
$

Plug in:
- $exp(u(x)) = exp(- (x - mu)^2 / (2 sigma^2))$
- $u'(x) = - (x - mu) / sigma^2$

So:

$
  dif / (dif x) exp(- (x - mu)^2 / (2 sigma^2)) = exp(- (x - mu)^2 / (2 sigma^2)) dot (- (x - mu) / sigma^2)
$

Move the factor to the front for clarity:

$
  - (x - mu) / sigma^2 dot exp(- (x - mu)^2 / (2 sigma^2))
$

Step 5. Putting everything together

Recall from Step 1:

$
  f'(x) = 1 / sqrt(2 pi sigma^2) dot dif / (dif x) exp(- (x - mu)^2 / (2 sigma^2))
$

Substitute what we found:

$
  f'(x) = 1 / sqrt(2 pi sigma^2) dot [- (x - mu) / sigma^2 dot exp(- (x - mu)^2 / (2 sigma^2))]
$

Pull the $- (x - mu) / sigma^2$ out front:

$
  f'(x) = - (x - mu) / sigma^2 dot 1 / sqrt(2 pi sigma^2) dot exp(- (x - mu)^2 / (2 sigma^2))
$

Step 6. Recognize $f(x)$ on the right side

Look at the last two factors

$
  1 / sqrt(2 pi sigma^2) dot exp(- (x - mu)^2 / (2 sigma^2)) = f(x)
$

That's exactly the original PDF. So:

$
  f'(x) = - (x - mu) / sigma^2 dot f(x)
$

Step 7. Standard Normal

Does this collapse to $phi.alt'(z)$ when $mu = 0$ and $sigma = 1$?

Plug in $mu = 0$, $sigma = 1$:

$
  f'(x) = - (x - 0) / 1^2 dot f(x) = - x dot f(x)
$

With $mu = 0$ and $sigma = 1$, $f(x)$ becomes $phi.alt(x)$, so:

$
  phi.alt(x) = -x dot phi.alt(x)
$

#table(
  columns: 2,
  inset: 1em,
  [Distribution], [Derivative],
  [Standard Normal $phi.alt(x)$], [
    $
      phi.alt'(z) = -z dot phi.alt(z)
    $
  ],
  [General Normal $f(x)$], [
    $
      f'(x) = (x - mu) / sigma^2 dot f(x)
    $
  ],
)

= Clark-Scarf view (stochastic service)

Echelon inventory position at stage $j$:

// #line(width: 100%)

Demand
- $mu$: 100 units
- $sigma$: 20 units
Lead time:
- $L_(f, w)$: 4 days
- $L_(f)$: 5 days

The question: *where do we keep safety stock?*





Safety stock formula:

$
  "SS" = k dot sigma dot sqrt(L)
$

With $k = 2$ ($approx 9%$ service level), $sigma = 20$, $L = 4$ days:

$
  "SS"_w = 2 dot 20 dot sqrt(4) = 80 "units"
$

== Graves-Willems view (guaranteed service)




= Expected Value

== Discrete

$
  EE[X] = sum_(i=1)^n x_i dot p_i
$

== Continuous

$
  EE[X] = integral_(-infinity)^infinity x dot f(x) dif x
$

=== Partial

Truncated or restricted expectation. Specifically:

$
  integral_(-infinity)^(infinity) x dot f(x) dif x = EE[X dot 1_{n lt.eq X lt.eq m}]
$

Where $1_{⋅}$​ is the indicator function — it's 1 when the condition is true, 0 otherwise.

=== Conditional

$
  EE[X | n lt.eq X lt.eq m] = (integral_(-infinity)^(infinity) x dot f(x) dif x) / P(n lt.eq X lt.eq m)
$

=== LOTUS

Law of the Unconscious Statistician

$
  integral_(-infinity)^infinity g(x) dot f(x) dif x
$


= Leibniz's Rule

$
  dif / (dif Q) integral_a(Q)^b(Q) h(x, Q) dif x = underbrace(integral_a(Q)^b(Q) (partial h) / (partial Q) dif x, "swap") + underbrace(h(b, Q) dot b'(Q) - h(a, Q) dot a'(Q), "boundary term")
$

= PDF & CDF

$
  f(x) = dif / (dif x) F(x)
$

$
  F(x) = integral_(-infinity)^x f(t) dif t
$

= PDF v. Likelihood

// Difference between #link(<PDF>)["PDF"] and #link(<likelihood>)["Likelihood"]

Same formula:

$
  phi.alt (x; mu, sigma) = 1 / (sigma sqrt(2 pi)) exp(- (x - mu)^2 / (2 sigma^2)) 
$

#table(
  columns: 4,
  inset: 1em,
  [Quantity], [Fixed], [Varies], [Sums / Integrates to 1],
  [PDF $phi.alt (x; mu, sigma)$], [$mu, sigma$], [$x$], [Yes],
  [Likelihood $cal(L)(mu, sigma | x)$], [$x$], [$mu, sigma$], [No],
)


$
  cal(L)(mu, sigma | x_1, dots, x_n) = product_(i=1)^n phi.alt (x_i; mu, sigma)
$
