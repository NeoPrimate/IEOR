#import "/lib/imports.typ": *
#show: formatting

Order today, receive after the *lead time* $L$. What drives safety stock is the *distribution of demand over those $L$ periods*. Central question: why does its standard deviation scale with $sqrt(L)$, not $L$?

== Setup

Daily demand $D_t$ is i.i.d. with mean $mu$ and standard deviation $sigma$. Take $mu = 100$, $sigma = 20$.

== Two days

Demand over two days is $D_1 + D_2$ (independent draws).

Means add:
$ EE[D_1 + D_2] = mu + mu = 2 mu = 200 $

Standard deviations do *not* add — *variances* do:
$ "Var"(D_1 + D_2) = "Var"(D_1) + "Var"(D_2) = sigma^2 + sigma^2 = 2 sigma^2 $

So the spread grows by only $sqrt(2)$:
$ "Std"(D_1 + D_2) = sqrt(2 sigma^2) = sigma sqrt(2) $

== Generalize to $L$ days

$
  "Var"(sum_(t=1)^L D_t) = L sigma^2
  quad => quad
  "Std"(sum_(t=1)^L D_t) = sigma sqrt(L)
$

- Mean of lead-time demand scales with $L$: #h(0.5em) $mu_L = L mu$
- Spread scales with $sqrt(L)$: #h(0.5em) $sigma_L = sigma sqrt(L)$

#let ls = lq.linspace(0, 10, num: 200)
#lq.diagram(
  width: 6cm,
  height: 3.5cm,
  xlabel: $L$,
  xlim: (0, 10),
  ylim: (0, 10),
  xaxis: (tick-args: (tick-distance: 2)),
  yaxis: (tick-args: (tick-distance: 2)),
  lq.plot(ls, l => l, mark: none, stroke: blue, label: [mean $prop L$]),
  lq.plot(ls, l => calc.sqrt(l), mark: none, stroke: red, label: [std $prop sqrt(L)$]),
)

This $sqrt(L)$ is why safety stock $"SS" = z dot sigma sqrt(L)$ grows sub-linearly in lead time — halving $L$ cuts safety stock by only $sqrt(2)$, not $2$.
