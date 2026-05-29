#import "/lib/imports.typ": *
#show: formatting

== Lead Time

Order today, receive after the *lead time* $L$. What drives safety stock is the *distribution of demand over those $L$ periods*. Central question: why does its standard deviation scale with $sqrt(L)$, not $L$?

=== Setup

Daily demand $D_t$ is i.i.d. with mean $mu$ and standard deviation $sigma$. Take $mu = 100$, $sigma = 20$.

=== Two days

Demand over two days is $D_1 + D_2$ (independent draws).

Means add:
$ EE[D_1 + D_2] = mu + mu = 2 mu = 200 $

Standard deviations do *not* add — *variances* do:
$ "Var"(D_1 + D_2) = "Var"(D_1) + "Var"(D_2) = sigma^2 + sigma^2 = 2 sigma^2 $

So the spread grows by only $sqrt(2)$:
$ "Std"(D_1 + D_2) = sqrt(2 sigma^2) = sigma sqrt(2) $

=== Generalize to $L$ days

$
  "Var"(sum_(t=1)^L D_t) = L sigma^2
  quad => quad
  "Std"(sum_(t=1)^L D_t) = sigma sqrt(L)
$

- Mean of lead-time demand scales with $L$: #h(0.5em) $mu_L = L mu$
- Spread scales with $sqrt(L)$: #h(0.5em) $sigma_L = sigma sqrt(L)$

#frame(cetz.canvas({
  import draw: *
  plot.plot(
    size: (9, 5),
    x-label: $L$,
    y-label: [],
    x-min: 0, x-max: 10,
    y-min: 0, y-max: 10,
    x-tick-step: 2, y-tick-step: 2,
    legend: "inner-north-west",
    {
      plot.add(
        l => l,
        domain: (0, 10),
        label: [mean $prop L$],
        style: (stroke: blue),
      )
      plot.add(
        l => calc.sqrt(l),
        domain: (0, 10),
        label: [std $prop sqrt(L)$],
        style: (stroke: red),
      )
    },
  )
}))

This $sqrt(L)$ is why safety stock $"SS" = z dot sigma sqrt(L)$ grows sub-linearly in lead time — halving $L$ cuts safety stock by only $sqrt(2)$, not $2$.
