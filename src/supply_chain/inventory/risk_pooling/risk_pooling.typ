#import "/lib/imports.typ": *

The fundamental supply-chain insight that *combining demand streams reduces variability* — so total safety stock to cover combined demand is less than the sum of safety stocks for each stream alone.

Formally: if you pool $N$ independent demand sources, the standard deviation of total demand scales as $sqrt(N)$, not $N$. Safety stock (proportional to standard deviation) therefore *scales as $sqrt(N)$* — a substantial saving when $N$ is large.

== The basic identity

For independent random demands $D_1, dots, D_N$ with means $mu_i$ and standard deviations $sigma_i$:

$
  E[D_1 + dots + D_N] = sum_i mu_i
$

$
  "Var"(D_1 + dots + D_N) = sum_i sigma_i^2
$

$
  sigma_("pool") = sqrt(sum_i sigma_i^2)
$

For *identical* demands ($mu_i = mu$, $sigma_i = sigma$):

$
  sigma_("pool") = sigma sqrt(N) #h(2em) "(not " N sigma)
$

== The square-root law

If safety stock $= k sigma$ for some constant $k$ (e.g., $k = z_(0.95)$ for 95% service), then total pooled safety stock is

$
  "SS"_("pool") = k sigma sqrt(N)
$

vs unpooled

$
  "SS"_("separate") = sum_i k sigma = N k sigma
$

*Saving*: factor of $sqrt(N) / N = 1/sqrt(N)$ in safety stock. With $N = 100$ locations, only $10$%(!) of the total separate safety stock is needed when fully pooled.

See #link(<supply-chain-risk-pooling-square-root-law>)[Square-Root Law] for derivation.

== Five flavors of pooling

1. *#link(<supply-chain-risk-pooling-location-pooling>)[Location pooling]* — centralize inventory across geographies
2. *#link(<supply-chain-risk-pooling-product-pooling>)[Product pooling]* — share common components / postponement
3. *#link(<supply-chain-risk-pooling-lead-time-pooling>)[Lead-time pooling]* — substitute inventory for variability when lead times shrink
4. *Capacity pooling* — pool flexible production capacity across products
5. *Virtual pooling / transshipments* — keep separate locations but allow inter-location transfers

== With correlated demands

If demands are *positively correlated*, pooling gains shrink. If they're *negatively correlated*, pooling gains expand. See #link(<supply-chain-risk-pooling-correlated-pooling>)[Correlated Pooling] for the general formula.

== Pooling costs

Pooling isn't free:

- *Transportation cost* — pooled stock is farther from some customers
- *Response time* — central inventory takes longer to reach distant points
- *Coordination overhead* — sharing requires good information systems
- *Demand transparency loss* — aggregated demand loses regional signal

Optimal pooling is a trade-off — see Daganzo's continuous approximation for facility location.

== Where it matters

- *Consolidating warehouses* — Walmart's regional DCs vs every-store-own-stock
- *Component commonality* — shared parts across product lines (HP DeskJet postponement case)
- *Make-to-order systems* — pool capacity, not inventory
- *Service-parts networks* — pool depots, especially for slow-moving items

== See also

- *#link(<supply-chain-risk-pooling-square-root-law>)[Square-Root Law]*
- *#link(<supply-chain-risk-pooling-correlated-pooling>)[Correlated Pooling]*
- *#link(<supply-chain-risk-pooling-location-pooling>)[Location Pooling]*
- *#link(<supply-chain-risk-pooling-product-pooling>)[Product Pooling]*
- *#link(<supply-chain-risk-pooling-lead-time-pooling>)[Lead-time Pooling]*
- *#link(<supply-chain-stocks-safety-stock>)[Safety Stock]*
