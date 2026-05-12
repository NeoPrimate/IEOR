#import "/lib/imports.typ": *
#show: formatting

Reducing inventory by *sharing parts / components across product variants* rather than holding stock for each finished SKU separately. Two main mechanisms:

1. *Component commonality* — products share common parts
2. *Postponement (delayed differentiation)* — defer customization until late in the supply chain

Both convert several high-variance finished-good demands into one lower-variance component demand — a textbook application of #link(<supply-chain-risk-pooling-square-root-law>)[risk pooling].

== Postponement: the HP DeskJet case

Classic Lee-Tang (1996) example. HP shipped printers configured for North America, Europe, Asia from a Singapore factory. Each region got its own SKU (different power supplies, manuals, plugs). Region-specific safety stocks per SKU.

*Postponement*: ship *generic* printers to regional DCs. Final regional configuration (adding power supply, labeling) done at the DC, right before delivery.

Effect:
- 3 finished SKUs → 1 generic + 3 small customization kits
- Safety stock for the generic stage uses aggregate demand across regions
- Customization kits have very fast lead time → minimal safety stock

Variance accounting:

#table(
  columns: 3,
  align: (left, center, center),
  stroke: none,
  table.header([], [*Per-region*], [*Aggregate*]),
  [Mean demand], [$mu_i$], [$sum mu_i$],
  [Variance], [$sigma_i^2$], [$sum sigma_i^2$ (independent)],
  [Coefficient of variation], [$sigma_i / mu_i$], [$sqrt(sum sigma_i^2) / sum mu_i$],
)

The aggregate CV is smaller — pooling effect for the generic. Total safety stock falls by a factor $sqrt(N)/N$ for the components that get postponed.

== Component commonality (Baker-Magazine-Nuttle 1986)

Two end products $A$ and $B$ use:
- Some shared components — *commonality*
- Some unique components

For the shared component, demand is $D_A + D_B$ — pooled. For unique components, demand is each product's own — not pooled.

*Trade-off*:
- More commonality → more pooling savings, but each product is harder to differentiate
- More uniqueness → more product differentiation, more inventory cost

== Variance math

Let product demands $D_A, D_B$ be independent with $sigma_A, sigma_B$. The shared component (used in *both*) sees:

$
  sigma_("shared") = sqrt(sigma_A^2 + sigma_B^2)
$

vs separate components:

$
  sigma_("separate, A") + sigma_("separate, B") = sigma_A + sigma_B
$

By the triangle inequality $sqrt(sigma_A^2 + sigma_B^2) <= sigma_A + sigma_B$ (and strict inequality when both $sigma_i > 0$). Equality only when one variance is zero.

So sharing strictly reduces required safety stock for the shared component.

== Practical examples

- *Auto industry* — Toyota uses common platforms across models (Corolla, Camry, RAV4 share many parts)
- *Electronics* — Apple uses common batteries, chargers, screens across product lines
- *Apparel* — DKNY makes generic shirts in white, dyes them to color at distribution centers
- *PC manufacturing* — Dell assemble-to-order from common components
- *Pharmacy* — generic drug → repackaged for retail / hospital channels

== Limitations

- *Customization later costs more per unit* — postponed assembly is less efficient than dedicated lines
- *Some differentiation can't be deferred* — e.g., physical form factors
- *Information / coordination overhead* — late customization needs accurate downstream demand info

== See also

- *#link(<supply-chain-risk-pooling-risk-pooling>)[Risk Pooling]*
- *#link(<supply-chain-risk-pooling-square-root-law>)[Square-Root Law]*
- *#link(<supply-chain-risk-pooling-location-pooling>)[Location Pooling]*
- *#link(<supply-chain-stocks-safety-stock>)[Safety Stock]*
