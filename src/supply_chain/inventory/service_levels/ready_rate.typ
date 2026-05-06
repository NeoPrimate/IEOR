#import "/src/imports.typ": *

#let cm(x) = text(fill: red, [$#x$])

== Ready Rate (Time-based service level)

The probability that on-hand inventory is *positive at any random moment in time*. Counts *time*, not cycles or units.

$ "Ready rate" = gamma = P("on-hand" > 0) $

=== How it differs from CSL and fill rate

#table(
  columns: 4,
  inset: 0.7em,
  align: left,
  [*Metric*], [*Counts*], [*What it means*], [*Sample question*],
  [CSL ($alpha$)], [Cycles], [P(no stockout in this cycle)], ["What fraction of cycles have a stockout?"],
  [Fill rate ($beta$)], [Units], [E[demand met] / E[demand]], ["What fraction of unit demand is met?"],
  [Ready rate ($gamma$)], [Time], [P(stock > 0 at time $t$)], ["What fraction of time are we in stock?"],
)

All three are "service level" but answer different questions.

=== Ready rate = fraction of time with positive stock

In steady state, the inventory level over a (Q, r) cycle alternates:
- *Positive on-hand* during most of the cycle.
- *Zero on-hand* during any stockout window (the gap from when stock hits zero to when the order arrives).

If $T$ is the average cycle length and $W$ is the *expected stockout duration per cycle*:

$ gamma = (T - W) / T = 1 - W / T $

For (Q, r) with $T = Q / d$:

$ gamma approx 1 - cm(sigma_L L(z) / d) / (Q / d) = 1 - cm(sigma_L L(z) / Q) $

The same expression as fill rate! Under continuous-demand assumptions, ready rate and fill rate coincide. They diverge only when stockout duration and shortage size aren't proportional (e.g., very lumpy demand patterns).

=== When ready rate is the right metric

Use ready rate when:
- *Server availability*: a service desk that can take orders only when stock is on hand. "Are we ready to serve?"
- *Compliance*: regulations require a minimum % of time in stock (some pharmacies, parts depots).
- *Multi-product systems*: aggregate ready rate = average of individual ready rates, easier to manage.

Don't use ready rate when shortages have widely varying severity — use fill rate to capture how *much* demand was unmet rather than just *whether* you were stocked out at the moment.

=== Approximate equivalence to fill rate

Under standard assumptions (continuous time, smooth demand, no lumpy bursts):

$ gamma approx beta approx 1 - sigma_L L(z) / Q $

In practice, choose whichever is more *interpretable* for your stakeholders:
- Customer-facing metrics → *fill rate* (units of unmet demand)
- Operations / compliance → *ready rate* (time in stock)
- Executive reporting → *CSL* (binary cycle outcome, simpler)


#example[
  *Given* (same (Q, r) policy as CSL/fill rate examples):
  - $Q = 775$, $mu_L = 462$, $sigma_L = 18.7$, $d = 33$/day
  - Reorder point set for CSL = 95%: $r = 493$, $z = 1.65$.

  *Step 1 — expected stockout duration per cycle*

  Stockout occurs only if $D_L > r$. Expected shortage in units:
  $ E["shortage"] = sigma_L L(z) = 18.7 dot 0.0207 approx 0.39 "units" $

  Convert to time: shortage $approx 0.39$ units, daily demand 33, so:
  $ W = E["shortage"] / d approx 0.39 / 33 approx 0.012 "days" approx 17 "minutes" $

  *Step 2 — ready rate*

  $ gamma = 1 - W / T = 1 - 0.012 / (775 / 33) approx 1 - 0.0005 approx 99.95% $

  *Step 3 — compare metrics*

  At the same reorder point $r = 493$:
  - *CSL*: 95% (5% of cycles have a stockout)
  - *Fill rate*: 99.95% (0.05% of unit demand unmet)
  - *Ready rate*: 99.95% (in stock 99.95% of the time)

  Fill rate ≈ ready rate (both unit/time-weighted). CSL is the strict outlier — it's an *event* count, blind to severity.

  Two stakeholder views:
  - *CFO*: "We hit a 5% stockout-cycle rate at this safety stock level — is that too lenient?"
  - *Operations*: "We're shipping 99.95% of orders; nobody complains." — fill rate / ready rate.

  Both views are correct; just different denominators.
]
