#import "/lib/imports.typ": *

Holding inventory at *one central location* (or fewer central locations) instead of at every demand point. The simplest and most direct application of #link(<supply-chain-risk-pooling-square-root-law>)[risk pooling].

== Setup

You serve $N$ markets / regions / stores. Demand at each is random with mean $mu_i$ and standard deviation $sigma_i$. Two extremes:

- *Decentralized*: each region holds its own safety stock — independent inventories totalling $sum z sigma_i$
- *Centralized*: one warehouse holds aggregate safety stock $z sqrt(sum sigma_i^2)$ (for independent demands), then ships on demand

Centralized cuts safety stock by $sqrt(N) / N = 1/sqrt(N)$ (the #link(<supply-chain-risk-pooling-square-root-law>)[square-root law]).

== Numerical illustration

$N = 25$ regions, each $mu = 1000, sigma = 200$ per week, $z = 1.65$ for 95% service.

#table(
  columns: 3,
  align: (left, center, center),
  stroke: none,
  table.header([], [*Decentralized*], [*Centralized*]),
  [Mean demand], [$25{,}000$], [$25{,}000$],
  [Std dev], [$25 dot 200 = 5{,}000$ (sum)], [$200 sqrt(25) = 1{,}000$ (pool)],
  [Safety stock at 95%], [$25 dot 1.65 dot 200 = 8{,}250$], [$1.65 dot 1{,}000 = 1{,}650$],
  [Savings], [—], [$80%$],
)

== The trade-offs

Centralization isn't free:

- *Transport cost* — central → customer distance increases (more outbound shipping)
- *Response time* — last-mile lead time grows
- *Demand visibility* — aggregated demand loses regional / time-of-day texture
- *Customer experience* — same-day delivery may be impossible from central locations
- *Single point of failure* — central warehouse outage hits all customers

Some industries (Amazon, parts distribution) trade off these costs explicitly via *partial pooling* — multiple regional DCs rather than one central or $N$ stores.

== Optimal degree of pooling

The trade-off is a *facility-location problem*:
- More facilities → less safety stock pooling savings, but lower transport costs
- Fewer facilities → more safety stock pooling savings, but higher transport costs

The classical *square-root facility-location model* (Daganzo continuous approximation; covered in #link(<operations-research-optimization-facility-location>)[facility location]) computes the optimal number of facilities for a given demand density and cost structure.

== Other forms

- *Inventory pooling*: physical centralization (one warehouse)
- *Virtual pooling*: separate physical inventories that share via inter-location transfers (transshipments)
- *Substitution-based pooling*: customer accepts a different but similar product
- *Lead-time pooling*: covered separately at #link(<supply-chain-risk-pooling-lead-time-pooling>)[lead-time pooling]

== Real-world examples

- *Walmart regional DCs* — centralized 1980s; revolutionized big-box retail
- *Amazon fulfillment centers* — now mostly partially pooled with last-mile depots
- *Spare parts depots* — defense, automotive
- *Hospital networks* — central pharmacy for slow-moving / expensive drugs

== See also

- *#link(<supply-chain-risk-pooling-risk-pooling>)[Risk Pooling]* — overview
- *#link(<supply-chain-risk-pooling-square-root-law>)[Square-Root Law]*
- *#link(<supply-chain-risk-pooling-correlated-pooling>)[Correlated Pooling]*
- *#link(<operations-research-optimization-facility-location>)[Facility Location]*
