#import "/lib/imports.typ": *

#let cm(x) = text(fill: red, [$#x$])

== Cycle Service Level (Type I, $alpha$)

The probability of *no stockout during a replenishment cycle*. Counts *events*: did this cycle have any unmet demand, yes or no?

$ "CSL" = 1 - alpha = P("no stockout during cycle") $

=== Definition

A *cycle* runs from one order arrival to the next. Stockout = *any* moment in the cycle where on-hand inventory hits zero with demand still present.

For a (Q, r) policy:
- Order placed when inventory position drops to $r$.
- Order arrives $L$ time later. During those $L$ time units, lead-time demand $D_L$ consumes inventory.
- *No stockout* in this cycle iff $D_L lt.eq r$.

So:

$ "CSL" = P(D_L lt.eq r) $

=== Setting $r$ for target CSL

If $D_L tilde cal(N)(mu_L, sigma_L^2)$:

$ "CSL" = Phi((r - mu_L) / sigma_L) = 1 - alpha $

Solve for $r$:

$ r = mu_L + cm(z) sigma_L quad "where" quad z = Phi^(-1)(1 - alpha) $

The familiar "$mu + z sigma$" form.

=== What CSL does *not* count

CSL counts *cycles*, not *units*. A cycle with one unit short and a cycle with 1000 units short both count as one stockout. So a 95% CSL means *5% of cycles experience a stockout*, but says *nothing* about how *severe* those stockouts are.

In practice this matters: a 95% CSL might correspond to 99% fill rate (most stockouts are tiny) or 80% fill rate (the stockouts are catastrophic) depending on the demand-distribution shape.

=== When CSL is the right metric

Use CSL when:
- The *occurrence* of any stockout is what matters (regulatory thresholds, contract penalties tied to "stockout incidents", reputational concerns).
- Demand is fairly smooth — the gap between CSL and fill rate is small.
- You want a simple, interpretable number for executive reporting.

Don't use CSL when stockout *severity* matters more than *frequency* — use fill rate instead.

=== Common $z$ values

#table(
  columns: 4,
  inset: 0.7em,
  align: center,
  [*CSL ($1 - alpha$)*], [*$alpha$*], [*$z$*], [*Notes*],
  [50%], [0.50], [0.00], [Order at the median],
  [80%], [0.20], [0.84], [Lean],
  [90%], [0.10], [1.28], [Common default],
  [95%], [0.05], [1.65], [Standard target],
  [97.5%], [0.025], [1.96], [Two-sigma],
  [99%], [0.01], [2.33], [High service],
  [99.5%], [0.005], [2.58], [],
  [99.9%], [0.001], [3.09], [Critical items (V-class)],
)


#example[
  *Given* (continuous-review (Q, r) policy):
  - Mean lead-time demand: $mu_L = 462$
  - Std of lead-time demand: $sigma_L = 18.7$
  - Target CSL: 95%

  *Step 1 — quantile*

  $ z = Phi^(-1)(0.95) approx cm(1.65) $

  *Step 2 — reorder point*

  $ r = mu_L + z sigma_L = cm(462) + cm(1.65) dot cm(18.7) approx 493 "units" $

  Safety stock: $z sigma_L approx 31$ units.

  *Step 3 — interpret*

  Out of every 100 cycles, expect *about 5* to experience some stockout. Each stockout could be small (1-2 units short) or large (50+ units short, if a demand spike hits) — CSL doesn't distinguish.

  If a cycle averages 24 days (= $Q\/d$ for $Q = 775$, $d = 33$), then $5%$ of cycles is *one stockout every $approx 480$ days* on average — about twice every three years.
]
