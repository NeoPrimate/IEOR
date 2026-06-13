#import "/lib/imports.typ": *
#import "@local/tystats:0.1.0": norm, poisson, expon

#import "@preview/tiptoe:0.4.0"
#let obar(x) = math.accent(x, math.macron)

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

#let start-x = 0
#let start-y = 0
#let spacing = 1
#std.layout(size => context {
  let diagram-content = fletcher.diagram(
    node-corner-radius: 4pt,
    node-fill: luma(97%),
    node-outset: 1em,
    node-inset: 1em,
    spacing: (5.5em, 2.8em),
    // --- Stages (right = downstream, faces demand) ---
    node((start-x + 0*spacing, start-y), [Vendor], name: <vendor>),
    node((start-x + 1*spacing, start-y), [$S_n$ \ $h_n$], name: <sn>),
    node((start-x + 2*spacing, start-y), $dots$, name: <dots>),
    node((start-x + 3*spacing, start-y), [$S_2$ \ $h_2$], name: <s2>),
    node((start-x + 4*spacing, start-y), [$S_1$ \ $h_1$], name: <s1>),
    node((start-x + 5*spacing, start-y), [Demand \ $D, p$], name: <demand>),
    // --- Material flow (downstream); L_j = lead time INTO stage j ---
    edge(<vendor>, <sn>, "-|>", label: $L_n$),
    edge(<sn>, <dots>, "-|>", label: $L_(n-1)$),
    edge(<dots>, <s2>, "-|>", label: $L_2$),
    edge(<s2>, <s1>, "-|>", label: $L_1$),
    edge(<s1>, <demand>, "-|>"),
    // --- Induced penalty flow (upstream) ---
    edge(<s1>, <s2>, "-|>", label: $G_1$, dash: "dashed", bend: 30deg, stroke: rgb("#c0613a")),
    edge(<s2>, <dots>, "-|>", label: $G_2$, dash: "dashed", bend: 30deg, stroke: rgb("#c0613a")),
    edge(<dots>, <sn>, "-|>", label: $G_(n-1)$, dash: "dashed", bend: 30deg, stroke: rgb("#c0613a")),
    // --- Echelon labels ---
    node((start-x + 4*spacing, start-y + 0.5), [Echelon 1], stroke: none, fill: none, name: <lbl1>),
    node((start-x + 3*spacing, start-y + 0.9), [Echelon 2], stroke: none, fill: none, name: <lbl2>),
    node((start-x + 1*spacing, start-y + 1.3), [Echelon $n$], stroke: none, fill: none, name: <lbln>),
    // --- Echelon nesting boxes ---
    node(
      enclose: (<s1>, <lbl1>),
      stroke: gray + 0.5pt, fill: rgb(0, 0, 0, 4%),
      outset: 0.3em, name: <ech1>
    ),
    node(
      enclose: (<s2>, <s1>, <lbl1>, <lbl2>),
      stroke: gray + 0.5pt, fill: rgb(0, 0, 0, 4%),
      outset: 0.7em, name: <ech2>
    ),
    node(
      enclose: (<sn>, <dots>, <s2>, <s1>, <lbl1>, <lbl2>, <lbln>),
      stroke: gray + 0.5pt, fill: rgb(0, 0, 0, 4%),
      outset: 1.1em, name: <echn>
    ),
  )
  let diagram-width = measure(diagram-content).width
  let available-width = size.width
  if diagram-width > available-width {
    let factor = (available-width / diagram-width) * 100%
    scale(x: factor, y: factor, reflow: true, diagram-content)
  } else {
    diagram-content
  }
})

Solve stages $1 arrow 2 arrow n$. Each stage $j$ does three things:
- receives the penalty function from below
- solves its own newsvendor balance
- produces a new penalty function to pass up

*Base case (stage 1)*. No stage bellow it, so $G_0 = 0$. Stage 1's expected cost as a function of its echelon level $y$:

$
  C_1 (y) = h_1 EE[(y - D_L_1)^+] + p EE[(D_L_1 - y)^+]
$

Where $D_L_1$ is demand over the lead-time window. This is convex; its minimizer is the fractile:

$
  S_1 = F_(L_1)^(-1) (p / (p + h_1))
$

*Inductive step (stage $j$)*. Stage $j$ has received $G_(j-1)$ from bellow. It's cost combines its own echelon holding with the penalty it inflicts downstream when it can't fully supply:

$
  C_j (y) = h_j EE[(y - D_L_j)^+] + EE[G_(j-1) (y - D_L_j)]
$

Minimize over $y$ to get $S_j = arg min_y C_j (y)$.

*Produce the penalty to pass up*. The clamp and floor operation:

$
  G_j (x) = C_j (min(x, S_j)) - C_j (S_j)
$

Zero when $x gt.eq S_j$ (stage $j$ isn't constrained), positive and rising as x drops below $S_j$. Hand $G_j$ to stage $j + 1$.

#example([])[
#std.layout(size => context {
  let diagram-content = fletcher.diagram(
    node-corner-radius: 4pt,
    node-fill: luma(97%),
    node-outset: 1em,
    node-inset: 1em,
    spacing: (6.5em, 2.8em),

    // --- Stages (right = downstream) ---
    node((start-x + 0*spacing, start-y), [Vendor], name: <vendor>),
    node((start-x + 1*spacing, start-y), [$S_3 = 33.15$ \ $h_3 = 1$], name: <s3>),
    node((start-x + 2*spacing, start-y), [$S_2 = 22.86$ \ $h_2 = 2$], name: <s2>),
    node((start-x + 3*spacing, start-y), [$S_1 = 23.63$ \ $h_1 = 3$], name: <s1>),
    node((start-x + 4*spacing, start-y), [Demand \ $D ~ cal(N)(10, 2)$ \ $p = 27$], name: <demand>),

    // --- Material flow (downstream); L_j = lead time INTO stage j ---
    edge(<vendor>, <s3>, "-|>", label: $L_3 = 2$),
    edge(<s3>, <s2>, "-|>", label: $L_2 = 1$),
    edge(<s2>, <s1>, "-|>", label: $L_1 = 1$),
    edge(<s1>, <demand>, "-|>"),

    // --- Induced penalty flow (upstream) ---
    edge(<s1>, <s2>, "-|>", label: $G_1$, dash: "dashed", bend: 30deg, stroke: rgb("#c0613a")),
    edge(<s2>, <s3>, "-|>", label: $G_2$, dash: "dashed", bend: 30deg, stroke: rgb("#c0613a")),

    // --- Echelon labels ---
    node((start-x + 3*spacing, start-y + 0.5), [Echelon 1], stroke: none, fill: none, name: <lbl1>),
    node((start-x + 2*spacing, start-y + 0.9), [Echelon 2], stroke: none, fill: none, name: <lbl2>),
    node((start-x + 1*spacing, start-y + 1.3), [Echelon 3], stroke: none, fill: none, name: <lbl3>),

    // --- Echelon nesting boxes ---
    node(
      enclose: (<s1>, <lbl1>),
      stroke: gray + 0.5pt, fill: rgb(0, 0, 0, 4%),
      outset: 0.3em, name: <ech1>
    ),
    node(
      enclose: (<s2>, <s1>, <lbl1>, <lbl2>),
      stroke: gray + 0.5pt, fill: rgb(0, 0, 0, 4%),
      outset: 0.7em, name: <ech2>
    ),
    node(
      enclose: (<s3>, <s2>, <s1>, <lbl1>, <lbl2>, <lbl3>),
      stroke: gray + 0.5pt, fill: rgb(0, 0, 0, 4%),
      outset: 1.1em, name: <ech3>
    ),
  )
  let diagram-width = measure(diagram-content).width
  let available-width = size.width
  if diagram-width > available-width {
    let factor = (available-width / diagram-width) * 100%
    scale(x: factor, y: factor, reflow: true, diagram-content)
  } else {
    diagram-content
  }
})

*Stage 1.* Window $L_1 + 1 = 2$, fractile $27 / (27 + 3) = 0.9$, $z = 1.282$

$
  S_1 = 10 (2) + 1.282 dot 2 sqrt(2) = 20 + 2.63 approx 23.63
$

*Stage 2.* Window $L_2 + 1 = 2$, fractile $27 / (27 + 3 + 2) = 27 / 32 = 0.844$, $z = 1.011$

$
  S_2 = 20 + 1.011 dot 2 sqrt(2) = 20 + 2.86 approx 22.86
$

*Stage 3.* Window $L_3 + 1 = 3$, fractile $27 / (27 + 6) = 27 / 33 = 0.818$, $z = 0.908$

$
  S_3 = 10 (3) + 0.908 dot 2 sqrt(3) = 30 + 3.25 approx 33.15
$

- $S_3 - S_2$​at stage 3
- $S_2 − S_1$ at stage 2
- $S_1$ at stage 1

Note:

The fractile formula $p / (p + sum_(i lt j) h_i)$ with window $L_j + 1$ is the exact stage-1 newsvendor and a standard approximation for upstream stages. The *exact* Clark-Scarf $S_2$, $S_3$ come from minimizing $C_j (Y) = h_j EE[(y - D_L_j)^+] + EE[G_(j-1)(y - D_L_j)]$ numerically, since $G_(j-1)$ isn't a clean newsvendor cost.

]

#code([])[
  ```py
  # pip install stockpyl
  from stockpyl.ssm_serial import optimize_base_stock_levels

  # Nodes indexed 1=downstream(demand-facing) ... 3=upstream(vendor-facing)
  S_star, C_star = optimize_base_stock_levels(
      num_nodes=3,
      echelon_holding_cost=[3, 2, 1],   # h_1, h_2, h_3
      stockout_cost=27,                 # p, charged at downstream node
      lead_time=[1, 1, 2],              # L_1, L_2, L_3 (into each stage)
      demand_mean=10,
      demand_standard_deviation=2,
  )
  print(S_star)   # exact echelon base-stock levels
  print(C_star)   # optimal expected cost
  ```
]

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

$
  L(k) = EE[(Z - k)^+]
$

$L(k)$ is the expected amount by which $Z$ exceeds the threshold $k$:
- $Z < k$: excess is 0
- $Z > k$: excess is $Z - k$. Average this across all the ways $Z$ could come in above $k$, weighted by probability 



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

We want $EE[max(X - k, 0)]$ - the average excess of $X$ above the threshold $k$, where the excess is *zero* when $X lt.eq k$.

Imaging 2 related quantities:

*Quantity A*: Tail Contribution

Sum up the value of $X$ at each tail outcome, weighted by probability:

$
  A = integral_k^infinity u dot phi.alt(u) dif u = phi.alt(k)
$

This is "if $X$ is in the tail, what value does it take, on average - weighted by likelihood?" Note that this counts the *full* value of $u$, not the excess $u - k$.

*Quantity B*: Threshold Contribution

$
  B = integral_k^infinity k dot phi.alt(u) dif u = k dot [1 - Phi(k)] = k dot "sf"(k)
$

This is "for every tail outcome, count $k$ once, weighted by probability of being there"

*Subtraction*

Each tail outcome at value $u$ contributes $u$ to A and $k$ to B. So the difference A - B contributes (u - k) per tail outcome - *exactly the excess we want*

$
  L(k) = A - B = underbrace(integral_k^infinity u phi.alt(u) dif u, "total tail values") - underbrace(integral_k^infinity k phi.alt(u) dif u, "treshold counted across tail")
$

The subtraction strips off the "baseline up to $k$" porton of each tail outcome, leaving only the part *above* $k$. Without that subtraction, we'd be over counting by $k$ for every tail occurrence.

#let L(k) = norm.pdf(k) - k * (1.0 - norm.cdf(k))
#let ks = lq.linspace(-3, 3, num: 200)

#lq.diagram(
  width: 6cm, height: 3cm,
  xlabel: $k$, ylabel: $L(k)$,
  xlim: (-3, 3), ylim: (0, 3.2),
  xaxis: (tick-distance: 1), yaxis: (tick-distance: 0.5),
  lq.plot(ks, L, mark: none, stroke: blue + 2pt),
  lq.plot((0,), (L(0),), stroke: none, mark: "o", mark-size: 5pt, color: red),
)

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

#table(
  columns: 2,
  inset: 1em,
  [$ phi.alt(u) $], [PDF],
  [$ phi.alt'(u) = - u phi.alt(u) $], [Derivative of PDF],
  [$ u phi.alt(u) = -phi.alt'(u) $], [Negative derivative of PDF],
)

#let phi_(u) = norm.pdf(u, mean: 0, std_dev: 1)
#let k  = -1.0
#let x  = lq.linspace(-3, 3, num: 200)   // full curve
#let xf = lq.linspace(k, 3, num: 100)    // shaded tail domain (k → 3)

#lq.diagram(
  width: 6cm, height: 3cm,
  xlabel: $u$, ylabel: $phi.alt(u)$,
  xlim: (-3, 3), ylim: (0, 0.45),
  xaxis: (tick-distance: 5), yaxis: (tick-distance: 1),
  lq.plot(x, phi_, mark: none, stroke: blue + 2pt),
  lq.vlines(k, stroke: red + 1pt),
)

#lq.diagram(
  width: 6cm, height: 3cm,
  xlabel: $u$, ylabel: $-u dot phi.alt(u)$,
  xlim: (-3, 3), ylim: (-0.3, 0.3),
  xaxis: (tick-distance: 5), yaxis: (tick-distance: 1),
  lq.fill-between(xf, u => -u * phi_(u), fill: red.transparentize(75%)),  // y2 omitted → fills to 0
  lq.plot(x, u => -u * phi_(u), mark: none, stroke: blue + 2pt),
  lq.hlines(0, stroke: black + 0.5pt),
  lq.vlines(k, stroke: red + 1pt),
)

#lq.diagram(
  width: 6cm, height: 3cm,
  xlabel: $u$, ylabel: $u dot phi.alt(u)$,
  xlim: (-3, 3), ylim: (-0.3, 0.3),
  xaxis: (tick-distance: 5), yaxis: (tick-distance: 1),
  lq.fill-between(xf, u => u * phi_(u), fill: red.transparentize(75%)),
  lq.plot(x, u => u * phi_(u), mark: none, stroke: blue + 2pt),
  lq.hlines(0, stroke: black + 0.5pt),
  lq.vlines(k, stroke: red + 1pt),
)

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
  [General Normal $f(x)$], [
    $
      f'(x) = - (x - mu) / sigma^2 dot f(x)
    $
  ],
  [Standard Normal $phi.alt(x)$], [
    $
      phi.alt'(z) = -z dot phi.alt(z)
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

= Risk Pooling

Combine multiple uncertain things together, the relative uncertainty of the whole tends to be smaller than the uncertainty of the individual pieces.

== The square-root law (independent demands)

For independent demands:

$
  sigma_"pool"^2 = sigma_1^2 + sigma_2^2 + dots + sigma_n^2
$

For $n$ identical regions with variance $sigma^2$:
$
  sigma_"pool"^2 = n sigma^2 quad => quad sigma_"pool" = sigma sqrt(n)
$

#example([])[
  
]

== Correlated Pooling (dependent demand)

$
  sigma_"pool"^2 = sum_(i=1)^n sigma_i^2 + 2 sum_(i lt j) rho_(i j) sigma_i sigma_j
$

- $rho_(i j)$: correlation coefficient between region $i$ and $j$
- $sigma_i sigma_j$: product of theur standard deviations
- $sum_(i lt j)$: goes over each pair of regions exactly once
- Factor of 2: each pair contributes a "cross term" twice when expanding $(X_1 + X_2 + dots + X_n)^2$ - once as $X_i X_j$ and once $X_j X_i$

Three regimes

$
  sigma_"pool"^2 = 2 sigma^2 (1 + rho)
$

- $rho = 0$: $sigma_"pool" = sigma sqrt(2)$ (square-root law)
- $rho = +1$: $sigma_"pool" = 2 sigma$ (no benefit)
- $rho = -1$: $sigma_"pool" = 0$ (risks cancel)

#example([])[
  
]

= Facility Location

== UFLP — Uncapacitated Facility Location Problem

$
  & min && sum_i f_i y_i + sum_i sum_j c_(i j) x_(i j) \
  & "s.t." && sum_i x_(i j) = 1 forall j, quad quad x_(i j) lt.eq y_i forall i, j
$

Where:
- $I$: candidate sites
- $J$: customers
- $f_i$: fixed cost to open site $i$ 
- $y_i in {0, 1}$: 1 if facility $i$ is open
- $c_(i j)$: cost to serve $j$ from $i$
- $x_(i j) in {0, 1}$: 1 if customer $j$ is served by facility $i$, else 0

#let f1_color = blue
#let f2_color = green

#let customer = (x, y, name, w: 1, r: 5pt, col: gray.lighten(50%), bd: black) => node(
  (x, y), none,
  shape: circle, radius: (3 + w * 0.9) * 1pt,
  fill: col, stroke: bd + 0.4pt,
  name: name,
)

#let facility = (x, y, col, label, name) => node(
  (x, y),
  text(fill: col.darken(25%))[#label],
  shape: rect,
  width: 16pt,
  height: 16pt,
  corner-radius: 0.25em,
  fill: col.lighten(70%),
  stroke: col + 0.5pt,
  inset: 1pt,
  name: name
)

#fletcher.diagram(spacing: 8pt,

  edge(<f1>,<c1>, stroke: f1_color),
  edge(<f1>,<c2>, stroke: f1_color),
  edge(<f1>,<c3>, stroke: f1_color),
  edge(<f1>,<c4>, stroke: f1_color),
  edge(<f1>,<c5>, stroke: f1_color),
  edge(<f2>,<c6>, stroke: f2_color),
  edge(<f2>,<c7>, stroke: f2_color),
  edge(<f2>,<c8>, stroke: f2_color),
  edge(<f2>,<c9>, stroke: f2_color),
  
  customer(0.9,0.0, <c1>),
  customer(0.5,2.0, <c2>),
  customer(2.3,0.0, <c3>),
  customer(2.5,2., <c4>),
  customer(1.8,3.2, <c5>),
  customer(4.5,1.1, <c6>),
  customer(5.9,1.0, <c7>),
  customer(6.1,2.5, <c8>),
  customer(4.6,3.1, <c9>),
  
  facility(1.7,1.6, f1_color, "F1", <f1>),
  facility(5.2,2.0, f2_color, "F2", <f2>),
  
  node((3.4,5.0), none, shape: rect, width: 14pt, height: 14pt,
    fill: none, stroke: (paint: rgb("#888780"), dash: "dashed", thickness: 0.5pt)),

  node((3.4,5.6), text(size: 8pt, fill: gray)[closed]),
  node((1.7,3.9), text(size: 8pt, fill: f1_color)[open · serves 5]),
  node((5.2,3.9), text(size: 8pt, fill: f2_color)[open · serves 4]),
)

== CFLP — Capacitated Facility Location Problem

$
  & min && sum_i f_i y_i + sum_i sum_j c_(i j) x_(i j) \
  & "s.t." && sum_i x_(i j) = 1 forall j, quad quad x_(i j) lt.eq y_i forall i, j \
  & && sum_j d_j x_(i j) lt.eq b_i y_i quad quad forall i
$

Where:
- $I$: candidate sites
- $J$: customers
- $f_i$: fixed cost to open site $i$ 
- $y_i in {0, 1}$: 1 if facility $i$ is open
- $c_(i j)$: cost to serve $j$ from $i$
- $x_(i j) in {0, 1}$: 1 if customer $j$ is served by facility $i$, else 0
- $d_j$: demand of customer $j$
- $b_i$: capacity of candidate site $i$

#let bar = (frac, col) => box(width: 64pt, height: 8pt, stroke: col + 0.4pt, radius: 1pt,
  clip: true, fill: white, inset: 0pt,
  align(left)[#box(width: 64pt * frac, height: 8pt, fill: col.lighten(20%))])

#let over_color = red

#fletcher.diagram(spacing: 8pt,

  edge(<f1>,<c1>, stroke: f1_color),
  edge(<f1>,<c2>, stroke: f1_color),
  edge(<f1>,<c3>, stroke: f1_color),
  edge(<f2>,<c4>, stroke: over_color),
  edge(<f1>,<c5>, stroke: f1_color),
  edge(<f2>,<c6>, stroke: f2_color),
  edge(<f2>,<c7>, stroke: f2_color),
  edge(<f2>,<c8>, stroke: f2_color),
  edge(<f2>,<c9>, stroke: f2_color),
  
  customer(0.9,0.0, <c1>),
  customer(0.5,2.0, <c2>),
  customer(2.3,0.0, <c3>),
  customer(2.5,2., <c4>),
  customer(1.8,3.2, <c5>),
  customer(4.5,1.1, <c6>),
  customer(5.9,1.0, <c7>),
  customer(6.1,2.5, <c8>),
  customer(4.6,3.1, <c9>),
  
  facility(1.7,1.6, f1_color, "F1", <f1>),
  facility(5.2,2.0, f2_color, "F2", <f2>),
  
  node((1.7, 4.0), bar(1.0, f1_color)),
  node((1.7, 4.45), text(size: 8pt, fill: f1_color)[capacity]),
  node((5.2, 4.0), bar(0.6, f2_color)),
  node((5.2, 4.45), text(size: 8pt, fill: f2_color)[capacity]),
)

== p-median

$
  & min   && sum_i sum_j d_j c_(i j) x_(i j) \
  & "s.t." && sum_i x_(i j) = 1 quad forall j \
  &        && x_(i j) lt.eq y_i quad forall i, j \
  &        && sum_i y_i = p
$
Where:
- $I$: candidate sites
- $J$: customers
- $y_i in {0, 1}$: is $i$ open?
- $c_(i j)$: cost (distance) to serve $j$ from $i$
- $x_(i j)$: fraction of $j$ served by $i$
- $d_j$: demand of customer $j$
- $p$: number of facilities to open


#let c1_color = purple
#let c2_color = maroon

#fletcher.diagram(spacing: 8pt,

  edge(<f1>,<c1>, stroke: f1_color),
  edge(<f1>,<c2>, stroke: f1_color),
  edge(<f1>,<c3>, stroke: f1_color),
  edge(<f1>,<c4>, stroke: f1_color),
  edge(<f1>,<c5>, stroke: f1_color),
  edge(<f2>,<c6>, stroke: f2_color),
  edge(<f2>,<c7>, stroke: f2_color),
  edge(<f2>,<c8>, stroke: f2_color),
  edge(<f2>,<c9>, stroke: f2_color),
  
  customer(0.9,0.0, <c1>, w: 5),
  customer(0.5,2.0, <c2>, w: 3),
  customer(2.3,0.0, <c3>, w: 0.5),
  customer(2.5,2., <c4>, w: 10),
  customer(1.8,3.2, <c5>, w: 1),
  customer(4.5,1.1, <c6>, w: 4),
  customer(5.9,1.0, <c7>, w: 0.5),
  customer(6.1,2.5, <c8>, w: 10),
  customer(4.6,3.1, <c9>, w: 5),
  
  facility(1.7,1.6, f1_color, "F1", <f1>),
  facility(5.2,2.0, f2_color, "F2", <f2>),
  
  node((1.7,3.9), text(size: 8pt, fill: f1_color)[open · serves 5]),
  node((5.2,3.9), text(size: 8pt, fill: f2_color)[open · serves 4]),
)

== Covering problems

=== Set Covering — cover everyone, as cheaply as possible

$
  & min   && sum_i y_i \
  & "s.t." && sum_i a_(i j) y_i gt.eq 1 quad forall j
$

Where:
- $I$: candidate sites
- $J$: customers
- $y_i in {0, 1}$: is $i$ open?
- $a_(i j) in {0, 1}$: does site $i$ cover customer $j$?

#let f1_color = blue
#let f2_color = green
#let f3_color = orange

#let coverage = (x, y, col, name) => node(
  (x, y), none,
  shape: circle, radius: 50pt,
  fill: col.lighten(88%), stroke: (paint: col, dash: "dashed", thickness: 0.5pt),
  layer: -1, name: name,
)

#fletcher.diagram(spacing: 8pt,
  coverage(1.7, 1.7, f1_color, <cov1>),
  coverage(4.3, 1.7, f2_color, <cov2>),
  coverage(3.0, 3.4, f3_color, <cov3>),

  customer(1.35, 1.45, <c1>),
  customer(2.05, 1.55, <c2>),
  customer(1.65, 2.15, <c3>),
  customer(3.95, 1.50, <c4>),
  customer(4.65, 1.55, <c5>),
  customer(4.35, 2.20, <c6>),
  customer(2.70, 3.20, <c7>),
  customer(3.30, 3.25, <c8>),
  customer(3.00, 3.95, <c9>),

  facility(1.7, 1.7, f1_color, [F1], <f1>),
  facility(4.3, 1.7, f2_color, [F2], <f2>),
  facility(3.0, 3.4, f3_color, [F3], <f3>),

  // node((3.0, 4.7), text(size: 8pt, fill: gray)[every customer inside ≥ 1 circle · minimize \# facilities]),
)

=== Maximal Covering (Max Covering) — fixed budget, cover as much demand as possible

$
  & max   && sum_j d_j z_j \
  & "s.t." && z_j lt.eq sum_i a_(i j) y_i quad forall j \
  &        && sum_i y_i = p
$

Where:
- $I$: candidate sites
- $J$: customers
- $y_i in {0, 1}$: is $i$ open?
- $a_(i j) in {0, 1}$: does site $i$ cover customer $j$?
- $z_j in {0, 1}$: is customer $j$ covered?
- $d_j$: demand of customer $j$
- $p$: number of facilities to open

#let f1_color = blue
#let f2_color = green
#let miss_color = red


#fletcher.diagram(spacing: 8pt,
  coverage(1.7, 1.7, f1_color, <cov1>),
  coverage(4.7, 1.8, f2_color, <cov2>),

  customer(1.1, 1.1, <c1>, r: 6pt),
  customer(2.2, 1.0, <c2>, r: 6pt),
  customer(1.3, 2.2, <c3>, r: 7pt),
  customer(2.3, 2.2, <c4>, r: 5pt),
  customer(4.1, 1.2, <c5>, r: 6pt),
  customer(5.3, 1.4, <c6>, r: 7pt),
  customer(4.5, 2.4, <c7>, r: 6pt),
  customer(5.4, 2.3, <c8>, r: 5pt),
  customer(3.2, 3.4, <miss>, r: 4pt, col: miss_color.lighten(40%), bd: miss_color),

  facility(1.7, 1.7, f1_color, [F1], <f1>),
  facility(4.7, 1.8, f2_color, [F2], <f2>),

  // node((3.2, 4.0), text(size: 8pt, fill: miss_color)[low-demand outlier left uncovered (budget p=2)]),
)


== Center-of-gravity & the Weiszfeld algorithm

#let cust_color  = gray
#let trail_color = purple
#let opt_color   = maroon

// single source of truth: customer points (x, y, weight)
#let customers = (
  (1.2, 1.1, 1),
  (3.0, 0.9, 1),
  (5.2, 1.4, 5),
  (1.8, 3.3, 1),
  (4.7, 3.2, 1),
)

// Weiszfeld fixed-point iteration -> (start, trail, opt)
#let weiszfeld(pts) = {
  let sw = pts.fold(0.0, (a, p) => a + p.at(2))
  let cx = pts.fold(0.0, (a, p) => a + p.at(2) * p.at(0)) / sw
  let cy = pts.fold(0.0, (a, p) => a + p.at(2) * p.at(1)) / sw
  let trail = ((cx, cy),)
  let px = cx
  let py = cy
  for _ in range(40) {
    let nx = 0.0
    let ny = 0.0
    let den = 0.0
    for p in pts {
      let dx = px - p.at(0)
      let dy = py - p.at(1)
      let d = calc.max(calc.sqrt(dx * dx + dy * dy), 0.0001)
      let om = p.at(2) / d
      nx += om * p.at(0)
      ny += om * p.at(1)
      den += om
    }
    nx = nx / den
    ny = ny / den
    trail.push((nx, ny))
    if calc.abs(nx - px) < 0.002 and calc.abs(ny - py) < 0.002 {
      px = nx; py = ny; break
    }
    px = nx; py = ny
  }
  (start: (cx, cy), trail: trail, opt: (px, py))
}

#let r = weiszfeld(customers)

#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  // axes
  // line((0.4, 0.4), (6.2, 0.4), stroke: gray.lighten(30%) + 0.4pt)
  // line((0.4, 0.4), (0.4, 4.0), stroke: gray.lighten(30%) + 0.4pt)

  // spokes from optimum to each customer
  for p in customers {
    line(r.opt, (p.at(0), p.at(1)), stroke: trail_color.lighten(40%) + 0.5pt)
  }

  // customers sized by weight
  for p in customers {
    circle((p.at(0), p.at(1)), radius: 0.08 + calc.sqrt(p.at(2)) * 0.04,
      fill: cust_color, stroke: cust_color.darken(20%) + 0.4pt)
  }

  // centroid start (dashed ring)
  circle(r.start, radius: 0.1, fill: none,
    stroke: (paint: cust_color, dash: "dashed", thickness: 0.6pt))

  // iteration trail, fading in toward the optimum
  for i in range(r.trail.len()) {
    let t = r.trail.at(i)
    let frac = i / calc.max(1, r.trail.len() - 1)
    if i > 0 {
      line(r.trail.at(i - 1), t, stroke: trail_color + 0.5pt)
    }
    circle(t, radius: 0.05,
      fill: trail_color.transparentize((1 - (0.3 + 0.6 * frac)) * 100%), stroke: none)
  }

  // optimal point (diamond)
  let o = r.opt
  line((o.at(0), o.at(1) + 0.13), (o.at(0) + 0.13, o.at(1)),
       (o.at(0), o.at(1) - 0.13), (o.at(0) - 0.13, o.at(1)), close: true,
       fill: opt_color, stroke: none)

  content((3.0, 0.0),
    text(size: 8pt, fill: opt_color)[diamond = optimal point · trail = iterations from centroid (ring)])
})

= Phase Spaces

- State
- State variables
- State space

== Transhipment Problem

Goal: Move goods from supply nodes to demand nodes at minimum cost, allowing flow to pass through intermediate nodes.

*Node types* (defined by their net flow requirement $b_i$):

- Source: produces goods $arrow.long$ $b_i = s_i gt 0$ (more flow out than in)
- Sink: consumes goods $arrow.long$ $b_i = −d_i < 0$ (more flow in than out)
- Transhipment: pass-through only $arrow.long$ $b_i = 0$ (flow in = flow out)

Decision variables:

$x_(i j) gt.eq 0$ = units shipped along edge $(i, j)$

Parameters:

- $c_(i j)$ = cost per unit on edge $(i, j)$
- $b_i$ = net supply (signed):
  - positive = supplies
  - negative = demands
  - zero = trashipment

$
  &min && sum_((i, j) in E) c_(i j) x_(i j) \
  &s.t. && underbrace(sum_((i, j) in E) x_(i j), "flow out of" i) - underbrace(sum_((j, i) in E) x_(j i), "flow into" i) = b_i quad forall i \
$

In words: (outflow − inflow) = net supply at the node.

Total supply = total demand: $sum_i b_i = 0$ (summing the constraint over all nodes forces this, since every $x_(i j)$ appears once as + and once as -).

== Capacitated Transhipment Problem

Goal: Move goods from supply nodes to demand nodes at minimum cost, allowing flow to pass through intermediate nodes.
Each edge now has a maximum capacity. You can't push unlimited flow along an edge.

Decision variables:

- $x_(i j)$ = units shipped along edge $(i, j)$

Parameters:

- $c_(i j)$ = cost per unit on edge $(i, j)$
- $b_i$ = net supply (signed):
  - positive = source
  - negative = sink
  - zero = transhipment
- $u_(i j)$ = upper bound (capacity) on edge $(i,j)$ — the max units that edge can carry

$
  &min && sum_((i, j) in E) c_(i j) x_(i j) \
  &s.t. && sum_((i, j) in E) x_(i j) - sum_((j, i) in E) x_(j i) = b_i quad forall i \
  &&& colorMath(0 lt.eq x_(i j) lt.eq u_(i j), #red)
$

Capacity bounds (one per edge)
- lower bound 0: no negative/reverse flow on the edge
- upper bound $u_(i j)$: edge can't carry more than its capacity

== Bipartite Assiment Problem

=== Balanced

$
  &min && sum_((i, j) in E) c_(i j) x_(i j) \
  &s.t. && sum_j x_(i j) = 1 quad forall i \
  &&& sum_i x_(i j) = 1 quad forall j \
  &&& x_(i j) gt.eq 0
$

=== Unbalanced (Dummy)

$
  &min && sum_(i j) c_(i j) x_(i j) \
  &"s.t." && sum_j x_(i j) lt.eq 1 quad forall i \
  &&& sum_i x_(i j) = 1 quad forall j \
  &&& x_(i j) gt.eq 0
$

Equivalently:

$
  &min && sum_(i=1)^n sum_(j=1)^(m+1) c_(i j) x_(i j) \
  &"s.t." && sum_(j=1)^(m+1) x_(i j) = 1 quad forall i in {1, dots, n} \
  &&& sum_(i=1)^n x_(i j) = 1 quad forall j in {1, dots, m} \
  &&& sum_(i=1)^n x_(i, m+1) = n - m \
  &&&x_(i j) gt.eq 0
$



= (MI)LP Cheatsheet

Phrasebook of LP/MILP modeling idioms: small algebraic constructs

#table(
  columns: (auto, 1fr),
  align: (left, left),
  stroke: 0.5pt + gray,
  inset: 5pt,
  table.cell(colspan: 2, fill: luma(230))[*Network / flow*],
  $sum_j x_(i j) - sum_j x_(j i) = b_i$, [conservation: $b_i$ source/sink/0],
  $x_(i j) - x_(j i)$, [net arc flow (single signed var)],
  $0 <= x_(i j) <= u_(i j)$, [arc capacity],
  $sum_(i in S, j in.not S) x_(i j)$, [flow across a cut],
  table.cell(colspan: 2, fill: luma(230))[*Conditional (Big-M)*],
  $a^T x <= b + M(1 - y)$, [active only if $y = 1$],
  [
    $
    a^T x <= b_1 + M y \
    a^T x <= b_2 + M(1 - y)
    $
  ], [either/or],
  [tight $M$], [loose $M$ ruins relaxation],
  table.cell(colspan: 2, fill: luma(230))[*Binary ↔ continuous*],
  $x <= M y$, [fixed-charge on/off],
  $l y <= x <= u y$, [semi-continuous: 0 or $[l, u]$],
  $x >= epsilon y$, [force strictly positive],
  table.cell(colspan: 2, fill: luma(230))[*Binary logic*],
  $sum y_i <= 1$, [at most one],
  $sum y_i = 1$, [exactly one (SOS1)],
  $sum y_i >= 1$, [OR],
  [
    $
    sum y_i <= k \
    sum y_i >= k
    $
  ], [cardinality],
  $y_a <= y_b$, [implication $a => b$],
  table.cell(colspan: 2, fill: luma(230))[*Products*],
  [
    $
    z <= y_1 \
    z <= y_2 \
    z >= y_1 + y_2 - 1
    $
  ], [bin × bin],
  [
    $
    z <= u y \
    z <= x \
    z >= x - u(1 - y) \
    z >= 0
    $
  ], [bin × cont, $x in [0,u]$],
  [McCormick envelope], [cont × cont relaxation],
  table.cell(colspan: 2, fill: luma(230))[*Abs / norms*],
  [
    $
    x = x^+ - x^- \
    x^+, x^- >= 0
    $
  ], [$|x| = x^+ + x^-$ (L1)],
  [
    $
    t >= x \
    t >= -x
    $
  ], [$|x|$, epigraph],
  table.cell(colspan: 2, fill: luma(230))[*Min / max*],
  $t >= f_i (x) forall i$, [min $t$ ⇒ minimax],
  $t <= f_i (x) forall i$, [max $t$ ⇒ maximin],
  table.cell(colspan: 2, fill: luma(230))[*Piecewise-linear*],
  [λ-method + SOS2], [convex combo of breakpoints],
  [δ-method], [incremental encoding],
  table.cell(colspan: 2, fill: luma(230))[*Sequencing*],
  $u_i - u_j + n x_(i j) <= n - 1$, [MTZ subtour elim.],
  $s_j >= s_i + d_i$, [precedence],
  table.cell(colspan: 2, fill: luma(230))[*Covering family*],
  $sum a_(i j) x_j >= 1$, [set covering],
  $sum a_(i j) x_j <= 1$, [set packing],
  $sum a_(i j) x_j = 1$, [partitioning],
  $sum w_i x_i <= W$, [knapsack],
  table.cell(colspan: 2, fill: luma(230))[*Slack / deviation*],
  [
    $
    a^T x + s = b \
    s >= 0
    $
  ], [slack (≤ → =); surplus $-s$],
  $f(x) + d^- - d^+ = "tgt"$, [goal prog. / soft],
  table.cell(colspan: 2, fill: luma(230))[*Temporal*],
  $I_t = I_(t-1) + p_t - d_t$, [inventory balance],
  table.cell(colspan: 2, fill: luma(230))[*Transforms*],
  $sum x = 1, x >= 0$, [unit simplex],
  [Charnes–Cooper], [linear-fractional → LP],
  $y_i >= y_(i+1)$, [symmetry breaking],
)

= Bootstrap & resampling

= Acceptance sampling: OC curve, AOQ, AOQL, single/double/sequential plans

= Variance

$
  EE[(X - mu)^2] \

  (sum_(i=1)^n (x_i - obar(x))^2) / n
$

= Covariance

$
  "Cov"(X, Y) = EE[(X - EE[X])(Y - EE[Y])] = EE[X Y] - EE[X] EE[Y] \
  (sum_(i=1)^n (x_i - obar(x))(y_i - obar(y))) / n
$

#example[
  $
    X = (1, 2, 3) \
    Y = (2, 4, 6) \
  $

  $
    EE[X] = (1 + 2 + 3) / 3 = 2 \
    EE[Y] = (2 + 4 + 6) / 3 = 4 \
  $

  #table(
    columns: 5,
    align: center + horizon,
    [$x_i$], [$y_i$], [$x_i - EE[X]$], [$y_i - EE[Y]$], [product],
    [1], [2], [-1], [-2], [2],
    [2], [4], [0], [0], [0],
    [3], [6], [1], [2], [2],
  )

  $
    "Cov"(X, Y) = (2 + 0 + 2) / 3 = 4 / 3 approx 1.33
  $

  Cross-check with the formula:

  $
    EE[X Y] - EE[X] EE[Y]
  $

  $
    EE[X Y] = ((1)(2) + (2)(4) + (3)(6)) / 3 = (2 + 8 + 18) / 3 = 28 / 3 \

    EE[X] EE[Y] = (2)(4) = 8 \

    EE[X Y] - EE[X] EE[Y] = 28 / 3 - 8 = 4 / 3
  $
]

Covariance is unbounded; correlation is the normalized version:

$
  rho_(X Y) = "Cov"(X, Y) / (sigma_X sigma_Y)
$

= Covariance and Correlation
// #show: lq.theme.schoolbook

#grid(
  columns: 2,
  inset: 1em,
  [
    #let xs = lq.linspace(-10, 10, num: 20)
    #let ys = lq.vec.jitter(xs, seed: auto, amount: 0, distribution: "normal")

    #let x-bar = xs.sum() / xs.len()
    #let y-bar = ys.sum() / ys.len()

    
    #let x_diff = xs.map(x => x - x-bar)
    #let y_diff = ys.map(y => y - y-bar)

    #let prod = x_diff.zip(y_diff).map(xy => xy.at(0) * xy.at(1))
    #let cov_0 = prod.sum() / prod.len()

    #let std_xs = calc.sqrt(xs.map(x => calc.pow(x - x-bar, 2)).sum() / xs.len())
    #let std_ys = calc.sqrt(ys.map(y => calc.pow(y - y-bar, 2)).sum() / ys.len())

    #let corr_0 = cov_0 / (std_xs * std_ys)

    #let quad-color = (x, y) => if (x - x-bar) * (y - y-bar) >= 0 { blue } else { red }
    #let colors = xs.zip(ys).map(((x, y)) => quad-color(x, y))

    #lq.diagram(
      lq.vlines(x-bar),
      lq.hlines(y-bar),
      lq.scatter(
        xs,
        ys,
        color: colors
      ),
      ..xs.zip(ys).map(((x, y)) => lq.rect(
      x-bar, y-bar,
      width: x - x-bar,
      height: y - y-bar,
      fill: quad-color(x, y).transparentize(80%),
      stroke: none,
      z-index: 1,
    ))
    )
    $
      "Cov" &= #calc.round(cov_0, digits: 2) \
      "Corr" &= #corr_0\
    $
  ],
  [
    
    #let xs = lq.linspace(-10, 10, num: 20)
    #let ys = xs.map(x => -x)
    #let ys = lq.vec.jitter(ys, seed: auto, amount: 0, distribution: "normal")

    #let x-bar = xs.sum() / xs.len()
    #let y-bar = ys.sum() / ys.len()

    #let x_diff = xs.map(x => x - x-bar)
    #let y_diff = ys.map(y => y - y-bar)

    #let prod = x_diff.zip(y_diff).map(xy => xy.at(0) * xy.at(1))
    #let cov_1 = prod.sum() / prod.len()

    #let std_xs = calc.sqrt(xs.map(x => calc.pow(x - x-bar, 2)).sum() / xs.len())
    #let std_ys = calc.sqrt(ys.map(y => calc.pow(y - y-bar, 2)).sum() / ys.len())

    #let corr_1 = cov_1 / (std_xs * std_ys)

    #let quad-color = (x, y) => if (x - x-bar) * (y - y-bar) >= 0 { blue } else { red }
    #let colors = xs.zip(ys).map(((x, y)) => quad-color(x, y))

    #lq.diagram(
      lq.vlines(x-bar),
      lq.hlines(y-bar),
      lq.scatter(
        xs,
        ys,
        color: colors
      ),
      ..xs.zip(ys).map(((x, y)) => lq.rect(
      x-bar, y-bar,
      width: x - x-bar,
      height: y - y-bar,
      fill: quad-color(x, y).transparentize(80%),
      stroke: none,
      z-index: 1,
    ))
    )
    $
      "Cov" &= #calc.round(cov_1, digits: 2) \
      "Corr" &= #corr_1\
    $
  ],
  [
    #let xs = lq.linspace(-10, 10, num: 20)
    #let ys = lq.vec.jitter(xs, seed: auto, amount: 10, distribution: "normal")

    #let x-bar = xs.sum() / xs.len()
    #let y-bar = ys.sum() / ys.len()

    
    #let x_diff = xs.map(x => x - x-bar)
    #let y_diff = ys.map(y => y - y-bar)

    #let prod = x_diff.zip(y_diff).map(xy => xy.at(0) * xy.at(1))
    #let cov_2 = prod.sum() / prod.len()

    #let std_xs = calc.sqrt(xs.map(x => calc.pow(x - x-bar, 2)).sum() / xs.len())
    #let std_ys = calc.sqrt(ys.map(y => calc.pow(y - y-bar, 2)).sum() / ys.len())

    #let corr_2 = cov_2 / (std_xs * std_ys)

    #let quad-color = (x, y) => if (x - x-bar) * (y - y-bar) >= 0 { blue } else { red }
    #let colors = xs.zip(ys).map(((x, y)) => quad-color(x, y))

    #lq.diagram(
      lq.vlines(x-bar),
      lq.hlines(y-bar),
      lq.scatter(
        xs,
        ys,
        color: colors
      ),
      ..xs.zip(ys).map(((x, y)) => lq.rect(
      x-bar, y-bar,
      width: x - x-bar,
      height: y - y-bar,
      fill: quad-color(x, y).transparentize(80%),
      stroke: none,
      z-index: 1,
    ))
    )
    $
      "Cov" &= #calc.round(cov_2, digits: 2) \
      "Corr" &= #calc.round(corr_2, digits: 2) \
    $
  ],
  [
    
    #let xs = lq.linspace(-10, 10, num: 20)
    #let ys = xs.map(x => -x)
    #let ys = lq.vec.jitter(ys, seed: auto, amount: 10, distribution: "normal")

    #let x-bar = xs.sum() / xs.len()
    #let y-bar = ys.sum() / ys.len()

    
    #let x_diff = xs.map(x => x - x-bar)
    #let y_diff = ys.map(y => y - y-bar)

    #let prod = x_diff.zip(y_diff).map(xy => xy.at(0) * xy.at(1))
    #let cov_3 = prod.sum() / prod.len()

    #let std_xs = calc.sqrt(xs.map(x => calc.pow(x - x-bar, 2)).sum() / xs.len())
    #let std_ys = calc.sqrt(ys.map(y => calc.pow(y - y-bar, 2)).sum() / ys.len())

    #let corr_3 = cov_3 / (std_xs * std_ys)

    #let quad-color = (x, y) => if (x - x-bar) * (y - y-bar) >= 0 { blue } else { red }
    #let colors = xs.zip(ys).map(((x, y)) => quad-color(x, y))

    #lq.diagram(
      lq.vlines(x-bar),
      lq.hlines(y-bar),
      lq.scatter(
        xs,
        ys,
        color: colors
      ),
      ..xs.zip(ys).map(((x, y)) => lq.rect(
      x-bar, y-bar,
      width: x - x-bar,
      height: y - y-bar,
      fill: quad-color(x, y).transparentize(80%),
      stroke: none,
      z-index: 1,
    ))
    )
    $
      "Cov" &= #calc.round(cov_3, digits: 2) \
      "Corr" &= #calc.round(corr_3, digits: 2) \
    $
  ],
)

= PCA as application


*Covariance Matrix*

Principle components are always perpendicular 

Let $X_j$ denote the $j$-th feature, and $X_1, X_2, dots, X_d$ are your $d$ features:

$
  C = mat(
    "var"(X_1), "cov"(X_1, X_2), dots, "cov"(X_1, X_d);
    "cov"(X_2, X_1), "var"(X_2), dots, "cov"(X_2, X_d);
    dots.v, dots.v, dots.down, dots.v;
    "cov"(X_d, X_1), "cov"(X_d, X_2), dots, "var"(X_d);
  )
$


#example[
  $
    X = {(0, 2), (2, 0), (4, 3), (6, 4), (8, 6)}
  $

  *Step 1* Center

  $
    overline(x) = (0 + 2 + 4 + 6 + 8) / 5 = 5 quad quad quad overline(y) = (2 + 0 + 3 + 4 + 6) / 5 = 3
  $

  Subtract (5, 4) from each point

  $
    obar(X) = {(−4,−1),(−2,−3),(0,0),(2,1),(4,3)} 
  $

  *Step 2* Covariance matrix

  $
    "var"(x) = (16 + 4 + 0 + 4 + 16) / 4 \
    "var"(y) = (1 + 9 + 0 + 1 + 9) / 4 \
    "cov"(x, y) = ((-4)(-1) + (-2)(-3) + 0 + (2)(1) + (4)(3)) / 4 = 6 \
  $

  $
    C = mat(
      10, 6;
      6, 5;
    )
  $

  - top-left = 10 → how much &x& spreads on its own
  - bottom-right = 5 → how much $y$ spreads on its own ($x$ spreads twice as much)
  - off-diagonal = 6 → how $x$ and $y$ move together (positive, so they rise together)

  *Step 3 — Eigenvalues and eigenvectors*

  Each principal component is an eigenvector $v$ of $C$: a direction that $C$ only
  stretches, never rotates.
  $ C v = lambda v quad arrow.double quad (C - lambda I) v = 0 $

  *Eigenvalues* — force a non-trivial solution with $det(C - lambda I) = 0$:
  $
    det(C - lambda I) &= (10 - lambda)(5 - lambda) - 36 \
                      &= lambda^2 - 15 lambda + 14 \
                      &= (lambda - 14)(lambda - 1) = 0
  $
  $ arrow.double quad lambda_1 = 14 quad "or" quad lambda_2 = 1 $

  *Eigenvectors* — substitute each $lambda$ back into $(C - lambda I) v = 0$.

  For $lambda_1 = 14$, with $C - 14 I = mat(-4, 6; 6, -9)$:
  $ -4 v_1 + 6 v_2 = 0 quad arrow.double quad 2 v_1 = 3 v_2 quad arrow.double quad v prop vec(3, 2) $

  For $lambda_2 = 1$, with $C - 1 I = mat(9, 6; 6, 4)$:
  $ 9 v_1 + 6 v_2 = 0 quad arrow.double quad 3 v_1 = -2 v_2 quad arrow.double quad v prop vec(2, -3) $

  Normalise to unit length:
  $ "PC"_1 = 1/sqrt(13) vec(3, 2) quad "PC"_2 = 1/sqrt(13) vec(2, -3) $
  
  #let x = (0, 2, 4, 6, 8)
  #let y = (2, 0, 3, 4, 6)

  #let mean = (4, 3)              // centroid: the means you subtract to center
  #let s = 1 / calc.sqrt(13)
  #let u1 = (3 * s, 2 * s)        // PC1 direction (unit)
  #let u2 = (2 * s, -3 * s)       // PC2 direction (unit)

  #let len1 = calc.sqrt(14) * 2   // length ∝ sqrt(eigenvalue) = std dev
  #let len2 = calc.sqrt(1) * 2

  #let axis(c, u, L) = (
    (c.at(0) - u.at(0) * L, c.at(1) - u.at(1) * L),
    (c.at(0) + u.at(0) * L, c.at(1) + u.at(1) * L),
  )
  #let (a1, b1) = axis(mean, u1, len1)
  #let (a2, b2) = axis(mean, u2, len2)

  #lq.diagram(
    width: 7cm, height: 7cm,         // equal size  +
    xlim: (-3, 11), ylim: (-4, 10),  // equal spans  => true right angles
    lq.scatter(x, y, color: blue),
    lq.line(a1, b1, stroke: (paint: red, thickness: 1.5pt),
            tip: tiptoe.stealth, toe: tiptoe.stealth),
    lq.line(a2, b2, stroke: (paint: purple, thickness: 1.5pt),
            tip: tiptoe.stealth, toe: tiptoe.stealth),
  )
]


= Joint, Conditional and Marginal Probabilities

*Setup*

Imagine we have 100 emails. We track two things about each one: is it spam or not, and does it contain the word "free" or not. Here's the count of every combination:

#align(center)[
  #table(
    stroke: none,
    inset: 1em,
    columns: 4,
    align: center + horizon,
    [], [$F$], [$F^c$], [margin],
    table.hline(),
    table.vline(x: 1),
    table.vline(x: 3),
    [$S$], [0.20], [0.10], [0.30],
    [$S^c$], [0.05], [0.65], [0.70],
    table.hline(),
    [margin], [0.25], [0.75], [1.00],
  )
]

== Joint Probability

$
  P(S inter F) = 0.20
$

== Marginal Probability

$
  P(A) = sum_(i=1)^n P(A inter B_i)
$

$
  P(S)
  &= P(S inter F) + P(S inter F^c)\
  &= 0.20 + 0.10 \
  &= 0.30
$

== Conditional Probability

$
  P(A | B) = P(A inter B) / P(B)
$

$
  P(S | F) = P(S inter F) / P(F) = 0.20 / 0.25 = 0.80
$

== Convolution

You have two independent random variables, $X$ and $Y$. You add them: $Z = X + Y$. What's the distribution of $Z$?

=== Discrete

$
  P(Z = z) = sum_x P(X = x) P(Y = z - x)
$

// discrete convolution: P(X + Y = z) = sum_k p_X(k) p_Y(z - k)
#let conv-pmf(z, la, lb) = {
  let total = 0.0
  for k in range(0, z + 1) { total += poisson.pmf(k, la) * poisson.pmf(z - k, lb) }
  total
}

#let lam-x = 2      // blue, fixed
#let lam-y = 3      // red, the one we flip & slide
#let kmax  = 14

#let ks = range(0, kmax + 1)

#let input-plot(z) = lq.diagram(
  width: 6cm, height: 2cm,
  xlim: (-1, kmax + 1), ylim: (0, 0.30),
  xaxis: (tick-distance: 2), yaxis: (ticks: none),
  lq.bar(
    ks, ks.map(k => poisson.pmf(k, lam-x)),
    offset: -0.2, width: 0.4, fill: blue.transparentize(50%),
  ),
  lq.bar(
    ks, ks.map(k => poisson.pmf(z - k, lam-y)),
    offset: 0.2, width: 0.4, fill: red.transparentize(50%),
  ),
  lq.vlines(z, stroke: purple + 1pt),
)

#let conv-plot(z) = {
  let js = range(0, z + 1)
  lq.diagram(
    width: 6cm, height: 2cm,
    xlim: (-1, kmax + 1), ylim: (0, 0.20),
    xaxis: (tick-distance: 2), yaxis: (ticks: none),
    lq.bar(
      js,
      js.map(j => conv-pmf(j, lam-x, lam-y)),
      fill: purple.transparentize(50%),
    ),
    lq.vlines(z, stroke: purple + 1pt),
  )
}

#let zs = (1, 3, 5, 7, 9)
#grid(columns: 2, column-gutter: 1em, row-gutter: 1em,
  ..zs.map(z => input-plot(z)).zip(zs.map(z => conv-plot(z))).flatten())

=== Continuous

$
  f_Z (z) = integral_(-infinity)^(+infinity) f_X (x) f_Y (z - x) 
$

#let x = lq.linspace(-8, 8, num: 1000)

#let density-plot(shift) = lq.diagram(
  width: 6cm, height: 2cm,
  xlim: (-8, 8), ylim: (0, 0.45),
  xaxis: (tick-distance: 2),
  yaxis: (ticks: none),
  lq.plot(x, x => norm.pdf(x, mean: 0, std_dev: 1), mark: none, stroke: red),
  lq.fill-between(
    x,
    x.map(x => norm.pdf(x, mean: 0, std_dev: 1)),
    fill: red.transparentize(75%),
  ),
  lq.plot(x, x => norm.pdf(x, mean: shift, std_dev: 1), mark: none, stroke: blue),
  lq.fill-between(
    x,
    x.map(x => norm.pdf(x, mean: shift, std_dev: 1)),
    fill: blue.transparentize(75%),
  ),
  lq.vlines(shift, stroke: blue + 1.5pt)
)

#let conv(z) = calc.exp(-calc.pow(z, 2) / 4) / (2 * calc.sqrt(calc.pi))

#let conv-plot(shift) = {
  let xs = lq.linspace(-8, shift, num: 500)
  lq.diagram(
    width: 6cm, height: 2cm,
    xlim: (-8, 8), ylim: (0, 0.45),
    xaxis: (tick-distance: 2),
    yaxis: (ticks: none),
    lq.fill-between(
      xs,
      xs.map(conv),
      fill: gray.transparentize(60%),
      stroke: black,
    ),
    lq.vlines(shift, stroke: blue + 1.5pt),
  )
}

#let shifts = range(5).map(i => -6 + i * 3)

#let col1 = shifts.map(s => density-plot(s))

#let col2 = shifts.map(s => conv-plot(s))

#grid(
  columns: 2,
  column-gutter: 1em,
  row-gutter: 1em,
  ..col1.zip(col2).flatten(),
)


= Mixture distributions

A mixture is what you get when you randomly pick one of several distributions and then draw from it. You're not combining the random variables — you're choosing between them.

$
  f(x) = sum_i w_i f_i (x) quad quad w_i gt.eq 0, sum_i w_i = 1
$

- Flip a biased coin: with probability $w_1$, pick component 1, with probability $w_2 = 1 - w_1$ pick component 2.
- Draw your value from whichever component the coin selected.

#example[
  $
    f(x) = 0.7 dot cal(N)(x; 0, 1) + 0.3 dot cal(N)(x; 5, 1)
  $

#let w1 = 0.7
#let w2 = 0.3

#let mix(x) = w1 * norm.pdf(x, mean: 0, std_dev: 1) + w2 * norm.pdf(x, mean: 5, std_dev: 1)

#let x = lq.linspace(-4, 10, num: 1000)

#lq.diagram(
  lq.plot(x, x => w1 * norm.pdf(x, mean: 0, std_dev: 1), mark: none, stroke: blue),  // 0.7·𝒩(0,1)
  lq.plot(x, x => w2 * norm.pdf(x, mean: 5, std_dev: 1), mark: none, stroke: blue),  // 0.3·𝒩(5,1)
  lq.fill-between(x, mix, fill: red.transparentize(75%)),
  lq.plot(x, mix, mark: none, stroke: black),                                        // the mixture f
)

$
  f(x) = 0.6 dot cal(N)(0,1) + 0.4 dot cal(N) (3,1)
$

#let w1 = 0.6
#let w2 = 0.4
#let mix(x) = w1 * norm.pdf(x, mean: 0, std_dev: 1) + w2 * norm.pdf(x, mean: 3, std_dev: 1)
#let x = lq.linspace(-4, 7, num: 1000)
#lq.diagram(
  ylim: (0, auto),
  lq.plot(x, x => w1 * norm.pdf(x, mean: 0, std_dev: 1), mark: none, stroke: blue),  // 0.6·𝒩(0,1)
  lq.plot(x, x => w2 * norm.pdf(x, mean: 3, std_dev: 1), mark: none, stroke: blue),  // 0.4·𝒩(3,1)
  lq.fill-between(x, mix, fill: red.transparentize(75%)),
  lq.plot(x, mix, mark: none, stroke: black),                                        // the mixture f
)

$
  f(x) =  0.5 dot cal(N) (2,0.6) + 0.5 dot cal(N) (2,3)
$

#let w1 = 0.5
#let w2 = 0.5
#let mix(x) = w1 * norm.pdf(x, mean: 2, std_dev: 0.6) + w2 * norm.pdf(x, mean: 2, std_dev: 3)
#let x = lq.linspace(-7, 11, num: 1000)
#lq.diagram(
  ylim: (0, auto),
  lq.plot(x, x => w1 * norm.pdf(x, mean: 2, std_dev: 0.6), mark: none, stroke: blue),  // 0.5·𝒩(2,0.6) — sharp spike
  lq.plot(x, x => w2 * norm.pdf(x, mean: 2, std_dev: 3),   mark: none, stroke: blue),  // 0.5·𝒩(2,3)   — broad base
  lq.fill-between(x, mix, fill: red.transparentize(75%)),
  lq.plot(x, mix, mark: none, stroke: black),                                          // the mixture f
)

]

= Law of Total Expectation

- Tower property
- Law of iterated expectations
- Smoothing theorem
- Adam's law

$
  EE[X] = EE[EE[X | Y]]
$

= Law of Total Variance

- Variance decomposition formula
- Conditional variance formula
- Eve's law

$
  "Var"(X) = underbrace(EE["Var"(X | Y)], "within-group") + underbrace("Var"(EE[X | Y]), "between-group")
$

= i.i.d

- *Independent* — the joint distribution factorizes; cross-terms (covariances) vanish.
- *Identically distributed* — every variable shares the same mean, variance, and distribution shape, so you can replace $n$ different quantities with one common one.

= CLT and LLN

We have random variables $X_1, X_2, X_3, dots$ what are *i.i.d.* --- *independent* (knowing one tells you nothing about the other) and *identically distributed* (same underlying distribution).

Each has a finite means and variance:

$
  mu = EE[X_i] \
  sigma^2 = "Var"(X_i) = EE[(X_i - mu)^2]
$

The object we care about is the *sample mean*:

$
  obar(X)_n = 1/ n sum_(i=1)^n X_i
$

Both theorems describe what happens to $obar(X)_n$ as $n arrow infinity$.
- LLN says it settles down to $mu$
- CLT describes how it wobbles around around $mu$ on the way there

= Moment Generating Function (MGF)

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

= Central Limit Theorem

Draw a sample of size $n$, compute its mean $obar(X)_n$ many times (say M=1500 times), then histogram those M sample means.

#let M = 1500                    // sample means per panel
#let lo = 0.0
#let hi = 2.0
#let bins = 30
#let w = (hi - lo) / bins
#let centers = range(bins).map(b => lo + (b + 0.5) * w)

#let clt-hist(n) = {
  // ONE draw of M*n values, then chunk into M sample means of size n
  let big = expon.rvs(rate: 1, size: M * n)
  let means = range(M).map(j => big.slice(j * n, (j + 1) * n).sum() / n)

  // bin into counts, then normalize to a density (area = 1)
  let counts = range(bins).map(b => {
    let a = lo + b * w
    let c = a + w
    if b == bins - 1 { means.filter(v => v >= a and v <= c).len() }
    else { means.filter(v => v >= a and v < c).len() }
  })
  let density = counts.map(cnt => cnt / (M * w))

  // theoretical bell: Normal(mu = 1, var = sigma^2/n = 1/n)
  let npts = 200
  let xs = range(npts + 1).map(k => lo + (hi - lo) * k / npts)
  let v = 1.0 / n
  let ys = xs.map(x => {
    let d = x - 1
    calc.exp(-d * d / (2 * v)) / calc.sqrt(2 * calc.pi * v)
  })

  lq.diagram(
    title: [n = #n],
    xlim: (lo, hi),
    xlabel: $overline(X)_n$,
    ylabel: [density],
    lq.bar(centers, density, width: w, fill: blue.lighten(60%), stroke: 0.3pt),
    lq.plot(xs, ys, mark: none, stroke: (paint: red, thickness: 1.5pt)),
  )
}

#figure({
  show: lq.layout                // aligns the four diagrams' axes
  grid(columns: 2, row-gutter: 1.5em, column-gutter: 1.5em,
    clt-hist(1), clt-hist(2), clt-hist(5), clt-hist(30),
  )
})



= Law of Large Numbers

The sample mean $obar(X)_n$ converges to $mu$. That is, as you add more samples, the value $obar(X_n)$ gets arbitrarily close to the true mean $mu$

#let n = ()
#for i in range(1, 201) { n.push(i) }

#let big = expon.rvs(rate: 1, size: 6000)   // 30 paths × 200 draws, ONE call

#let paths = ()
#for p in range(0, 30) {
  let running = ()
  let s = 0.0
  for i in range(0, 200) {
    s += big.at(p * 200 + i)                 // path p uses draws [p*200 .. p*200+199]
    running.push(s / (i + 1))
  }
  paths.push(running)
}

#lq.diagram(
  ylim: (0, 2),
  xlabel: $n$, ylabel: $overline(X)_n$,
  ..paths.map(r => lq.plot(n, r, mark: none,
    stroke: (paint: blue.transparentize(80%)))),
)

Weak Law of Large Numbers

If you take more and more independent samples from the same distribution and average them, the probability that your average is "noticeably far" from the true mean shrinks to zero.

If $X_1, X_2, dots, X_n$ are i.i.d. with a true mean $mu$, and we define the same mean:

$
  obar(X)_n = 1/n sum_(i=1)^n X_i
$

then for *any* tolerance $epsilon gt 0$ you pick,

$
  lim_(n arrow infinity) P(|obar(X)_n - mu| gt.eq epsilon) = 0
$

Steps:

1. *Markov's inequality* -- bound on how much probability can sit in the tail of a non-negative variable
2. *Chebyshev's inequality* -- bound on distance from the mean (variance)
3. *Plug in sample mean into Chebyshev* -- bound collapses to zero as $n$ grows

Notation:

- *Mean*: $mu = E[X] = sum_x x P(X = x)$ -- each possible value weighted by its probability
- *Variance*: $sigma^2 = "Var"(X) = E[(X - mu)^2]$ -- average squared distance from the mean

*Step 1*: Markov Inequality

If $X gt.eq 0$ and $a gt 0$, then:

$
  P(X gt.eq a) lt.eq E[X] / a
$

Define a new r.v., the *indicator*:

$
  I = cases(
    1 quad "if" X gt.eq a,
    0 quad "if" X lt a,
  )
$

The expression of an indicator is the probability of its event:

$
  E[I] = 1 dot P(X gt.eq a) + 0 dot P(X lt a) = P(X gt.eq a)
$

So, for *every possible outcome*:

$
  X gt.eq a dot I
$

- *Case $X gt.eq a$*: then $I = 1$, so $a dot I = a$. And we assumed $X gt.eq a$ ✅
- *Case $X lt a$*: then $I = 0$, so $a dot I = 0$. And we assumed $X gt.eq 0$ ✅

So $X gt.eq a I$ always holds.

Now take the expectation of both sides (expectations preserve inequalities, if one variable is always $gt.eq$ another, its average is too):

$
  E[X] gt.eq E[a I] = a E[I] = a P(X gt.eq a)
$

Divide both sides by $a gt 0$:

$
  P(X gt.eq a) lt.eq E[X] / a
$

*Step 2*: Chebyshev Inequality

For any random variable $X$ with mean $mu$ and variance $sigma^2$, and any $k gt 0$,

$
  P(|X - k| gt.eq k) lt.eq sigma^2 / k^2
$

Rewrite event:

$
  |X - mu| gt.eq k quad arrow.l.r.double.long quad (X - mu)^2 gt.eq k^2
$

Same event, so same probability:

$
  P(|X - mu| gt.eq k) = P((X - mu)^ gt.eq k^2)
$

Apply Markov with a threshold of $k$

Let $Y = (X - mu)^2 gt.eq 0$

$
  P(Y gt.eq k^2) lt.eq E[Y] / k^2
$

Substitute back. The left side is the event we just rewrote, and $E[Y] = E[(X - mu)^2] = sigma^2$:

$
  P(|X - mu| gt.eq k) lt.eq sigma^2 / k^2
$

$
  P(|X - mu| lt.eq k) lt.eq sigma^2 / k^2
$

The change of landing $k$ or more away from the mean is at most $sigma^2 / k^2$. Small variance, or a large distance $k$, both squeeze the probability down.

Mean of the Sample Mean

$
  E[obar(X)_n] = E[1/n sum_(i=1)^n X_i] = 1/n sum_(i=1)^n E[X_i] = 1/n sum_(i=1)^n mu = 1/n dot n mu = mu
$

So the sample mean is centered on the true mean.

- $"Var"(a X) = a^2 "Var"(X)$ <fact-1>

$
  "Var"(a X)
  &= E[(a X - a mu)^2] \
  &= E[a^2 (X- mu)] \
  &= a^2 E[(X - mu)^2] \
  &= a^2 "Var"(X)
$

- For *independent* $X$, $Y$, $"Var"(X + Y) = "Var"(X) + "Var"(Y)$ <fact-2>

$
  "Var"(X + Y)
  &= E[((X - mu_X) + (Y - mu_Y))^2] \
  &= "Var"(X) + "Var"(Y) + 2 underbrace(E[(X - mu_X)(Y - mu_Y)], "cross term")
$

The cross term is the covariance. For *independent* variables, the expectation of the product splits into the product of expectations:

$
  E[(X - mu_X)(Y - mu_Y)]
  &= E[X - mu_X] dot E[Y - mu_Y] \
  &= 0 dot 0 \
  &= 0
$

Cross terms vanish for a sum of $n$ independent variables, leaving $"Var"(X + Y) = "Var"(X) + "Var"(Y)$. *This is the one and only place where independence is used in the Law of Large Numbers*.

$
  "Var"(obar(X)_n)
  &= "Var"(1/n sum_(i=1)^n X_i) \
  &= 1/n^2 "Var"(sum_(i=1)^n X_i) \
  &= 1/n^2 sum_(i=1)^n "Var"(X_i) \
  &= 1/n^2 dot n sigma^2 \
  &= sigma^2 / n
$

So, for Chebyshev:
- Mean: $mu$
- Variance: $sigma^2 / n$

Applying Chebyshev to $obar(X)_n$ with threshold $k = epsilon$:

$
  P(|obar(X)_n - mu| gt.eq epsilon) lt.eq "Var"(obar(X)_n) / epsilon^2 = sigma^2 / (n epsilon^2)
$

Hold $epsilon$ and $sigma^2$ fixed and let $n arrow infinity$. The right side goes to zero and the probability can't go below zero, so it's squeezed.

$
  0 lt.eq P(|obar(X)_n - mu| gt.eq epsilon) lt.eq sigma^2 / (n epsilon^2) arrow.long_(n arrow infinity) 0
$

Therefore, for every $epsilon gt 0$:

$
  lim_(n arrow infinity) P(|obar(X)_n - mu| gt.eq epsilon) = 0
$



== Weak Law

Limit it *outside*

$
  forall epsilon gt 0: quad lim_(n arrow infinity) P(|obar(X)_n - mu| gt.eq epsilon) = 0
$


Look down a vertical slice. Pick the dashed line at some fixed large $n$.
The weak law says: at that column, almost every path has already fallen inside the $plus.minus epsilon$ band

== Strong Law

Limit is *inside*

$
  P(lim_(n arrow infinity) obar(X)_n = mu) = 1
$

Follow a single path left to right.
With probability 1, a path will eventually enters the band and never leaves again.
There's some (random) sample count $N$ after which it's locked in for good.

#let n = ()
#for i in range(1, 201) { n.push(i) }

#let big = expon.rvs(rate: 1, size: 6000)   // 30 paths × 200 draws, ONE call

#let paths = ()
#for p in range(0, 30) {
  let running = ()
  let s = 0.0
  for i in range(0, 200) {
    s += big.at(p * 200 + i)                 // path p uses draws [p*200 .. p*200+199]
    running.push(s / (i + 1))
  }
  paths.push(running)
}

#lq.diagram(
  ylim: (0, 2),
  yaxis: (
    position: 0,
    // ticks: 1,
    // tick-args: none,
    tick-args: (tick-distance: 5),
    tip: tiptoe.triangle,
    filter: (value, distance) => value != 0,
    // filter: no-zero,
    subticks: none,
  ),
  xaxis: (
    position: 0,
    tick-args: (tick-distance: 50),
    tip: tiptoe.triangle,
    filter: (value, distance) => value != 0,
    subticks: none,
  ),

  xlabel: $n$, ylabel: $overline(X)_n$,
  ..paths.map(r => lq.plot(n, r, mark: none,
    stroke: (paint: blue.transparentize(80%)))),

  lq.hlines(0.75, min: 0, max: 200, stroke: (dash: "dashed")),
  lq.hlines(1, min: 0, max: 200),
  lq.hlines(1.25, min: 0, max: 200, stroke: (dash: "dashed")),
  
  lq.vlines(150, stroke: (paint: red, dash: "dashed")),

  lq.place(100%, 1.25)[$+ epsilon$],
  lq.place(100%, 1)[$mu$],
  lq.place(100%, 0.75)[$- epsilon$],
)

= Linearity of Expectations

$
  E[X + Y] = E[X] + E[Y] \
  E[a X] = a E[X] \
$

= Markov's inequality


= Chebyshev's inequality


= Vectors


#lq.diagram(
  width: 5cm,
  height: 5cm,
  xlim: (-3, 3),
  ylim: (-3, 3),
  yaxis: (
    position: 0,
    // ticks: 1,
    tick-args: (tick-distance: 2),
    tip: tiptoe.triangle,
    // filter: no-zero,
    subticks: none,
  ),
  xaxis: (
    position: 0,
    tick-args: (tick-distance: 2),
    tip: tiptoe.triangle,
    filter: (value, distance) => value != 0,
    subticks: none,
  ),
  lq.line(
    (0, 0), (2, 2),
    tip: tiptoe.triangle,
    stroke: blue + 1.5pt,
  ),
)

= AIC & BIC

Picking between competing models

Maximized likelihood

== AIC

$
  "AIC" = underbrace(2k, "penalty term") − underbrace(2 dot ln(hat(L)), "fit term")
$

- $k$: number of parameters in the model
- $n$: number of data points 

#lq.diagram(
  width: 4cm, height: 4cm,
  xlabel: $k$,
  ylabel: $hat(L)$,
  lq.colormesh(
    lq.linspace(0.001, 5, num: 60),
    lq.linspace(0.001, 5, num: 60),
    (k, L) => 2 * k - 2 * calc.ln(L),
    map: color.map.icefire,
    interpolation: "smooth"
  )
)

== BIC

$
  "BIC" = underbrace(k dot ln(n), "penalty term") − underbrace(2 dot ln(hat(L)), "fit term")
$

- $k$: number of parameters in the model
- $n$: number of data points 

#grid(
  columns: 2,
  inset: 1em,
  align: center + horizon,
  [
    #lq.diagram(
      width: 4cm, height: 4cm,
      xlabel: $k$,
      ylabel: $hat(L)$,
      lq.colormesh(
        lq.linspace(0.001, 5, num: 60),   // k
        lq.linspace(0.001, 5, num: 60),   // L
        (k, L) => k * calc.ln(100) - 2 * calc.ln(L),
        map: color.map.icefire,
        interpolation: "smooth"
      )
    )

    Fix $n$, plot over $k$ and $hat(L)$
  ],
  [
    #lq.diagram(
      width: 4cm, height: 4cm,
      xlabel: $k$,
      ylabel: $n$,
      lq.colormesh(
        lq.linspace(0.001, 5, num: 60),   // k
        lq.linspace(2, 200, num: 60),     // n
        (k, n) => k * calc.ln(n),         // pure penalty, since 2*ln(1)=0
        map: color.map.icefire,
        interpolation: "smooth"
      )
    )

    Fix $hat(L)$, plot over $k$ and $n$
  ]
)
)


Explanation: 
- The fit term, $−2 dot ln(L)$, is identical in both (Better fit $arrow$ bigger L̂ $arrow$ bigger ln(L̂) $arrow$ this term goes down $arrow$ criterion goes down
- The penalty term is the only difference:
  - AIC charges 2 per parameter
  - BIC charges ln(n) per parameter

#example[
  You have n = 100 data points and two candidate models for them:

  - Model A (simpler): k = 3 parameters, maximized log-likelihood ln(L̂) = −120
  - Model B (fancier): k = 6 parameters, maximized log-likelihood ln(L̂) = −116

  Model B fits better — its log-likelihood is higher (−116 > −120), which it should be, since it has more parameters to play with. The whole question is whether those 3 extra parameters are worth it.

  *AIC* $2k − 2·ln(hat(L))$

  - Model A:  2·3  − 2·(−120) =  6 + 240 = 246
  - Model B:  2·6  − 2·(−116) = 12 + 232 = 244

  AIC picks Model B (244 < 246)

  *BIC* $k dot ln(n) − 2·ln(hat(L))$

  - Model A:  3·4.6 − 2·(−120) = 13.8 + 240 = 253.8
  - Model B:  6·4.6 − 2·(−116) = 27.6 + 232 = 259.6

  BIC picks Model A (253.8 < 259.6)

  Same data, same two models, opposite verdicts. Here's the why, and it's exactly that per-parameter cost from before:
  Going from A to B, the fit term drops by 8 (from 240 to 232) — that's the reward for the better fit. The 3 extra parameters cost you:

  BIC charges more per parameter (because ln(100) > 2), so it demands a bigger fit improvement before it'll accept extra complexity.
  That's why it leans toward simpler models.
]

= Log

#let x = lq.linspace(0.001, 10, num: 1000)

#lq.diagram(
  lq.plot(x, x => calc.log(x, base: 2), mark: none)
)

A logarithm turns multiplication into addition. 

$
  log(a · b) = log(a) + log(b)
$


= Ln

#lq.diagram(
  lq.plot(x, x => calc.ln(x), mark: none)
)


= Types of Statistics

- Descriptive: summarize data you actually have
- Inferential: generalize from a sample to a broader population
- Predictive: cares about forecasting accuracy on new data regarless of whether the model is interpretable (inferential cares about understanding the data-generating process)
- Exploratory hypothesis generating rather than testing

=  Critical Path Method (CPM)

What's the shortest possible time to finish the whole project, and which tasks are "tight" (any delay on them delays the whole project)

Let $G = (V, E)$ be a DAG with a duration of $d(v) gt.eq 0$ on each node. And edge $(u, v)$ means $u$ must finish before $v$ starts. $"pred"(v)$ and $"succ"(v)$ for in- and out-neighbors.

*Forward Pass* (one recurrence)

$
  "EF"(v) = d(v) + max_(u in "pred"(v)) "EF"(u), quad quad "ES"(v) = "EF"(v) - d(v)
$

with $max nothing.rev = 0$ (sources get $"ES" = 0$).

The makespan is $T = max_v "EF"(v)$.

*Backward Pass* (dual recurrence)

$
  "LF"(v) = min_(w in "succ"(v)) "LS"(w), quad quad "LS"(v) = "LF"(v) - d(v)
$

with $min nothing.rev = T$ (sinks get pinned to project end)

*Clack & Critical Pass*

$
  "slack"(v) = "LS"(v) - "ES"(v) = "LF"(v) - "EF"(v)
$

$"Critical path" = {v: "slack"(v) = 0}$

#example[

  #fletcher.diagram(
  	spacing: 8pt,
  	cell-size: (8mm, 10mm),
  	edge-stroke: 1pt,
  	edge-corner-radius: 5pt,
  	mark-scale: 70%,

  	node((0,0), [A\ 3 days],
    	fill: blue.lighten(60%),
      width: 20mm,
    	stroke: 1pt + blue.darken(20%),
    	corner-radius: 5pt,
      name: "A"
    ),
  	node((2,1), [C\ 2 days],
    	fill: blue.lighten(60%),
      width: 20mm,
    	stroke: 1pt + blue.darken(20%),
    	corner-radius: 5pt,
      name: "C"
    ),
  	node((2,-1), [B\ 4 days],
    	fill: blue.lighten(60%),
      width: 20mm,
    	stroke: 1pt + blue.darken(20%),
    	corner-radius: 5pt,
      name: "B"
    ),
  	node((4,1), [E\ 1 days],
    	fill: blue.lighten(60%),
      width: 20mm,
    	stroke: 1pt + blue.darken(20%),
    	corner-radius: 5pt,
      name: "E"
    ),
  	node((4,-1), [D\ 5 days],
    	fill: blue.lighten(60%),
      width: 20mm,
    	stroke: 1pt + blue.darken(20%),
    	corner-radius: 5pt,
      name: "D"
    ),
  	node((6,0), [F\ 2 days],
    	fill: blue.lighten(60%),
      width: 20mm,
    	stroke: 1pt + blue.darken(20%),
    	corner-radius: 5pt,
      name: "F"
    ),
  	edge(<A>, <B>, "-|>"),
  	edge(<A>, <C>, "-|>"),
  	edge(<B>, <D>, "-|>"),
  	edge(<C>, <E>, "-|>"),
  	edge(<E>, <F>, "-|>"),
  	edge(<D>, <F>, "-|>"),
  )

  Let's compute. We start the project at time 0.
  
  - A has no predecessors, so ES = 0, and EF = 0 + 3 = 3.
  - B depends only on A, so ES = EF(A) = 3, and EF = 3 + 4 = 7.
  - C also depends only on A, so ES = EF(A) = 3, and EF = 3 + 2 = 5.
  - D depends only on B, so ES = EF(B) = 7, and EF = 7 + 5 = 12.
  - E depends only on C, so ES = EF(C) = 5, and EF = 5 + 1 = 6.
]
