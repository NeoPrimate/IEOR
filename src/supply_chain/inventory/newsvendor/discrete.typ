#import "/src/imports.typ": *

#let cm(x) = text(fill: red, [$#x$])

== Newsvendor with discrete demand

Relax one dimension from basic newsvendor: *demand distribution* is no longer continuous. Demand $D$ takes integer values (Poisson, empirical histograms, etc.). The critical-ratio rule still applies, but the quantile is found by a *discrete lookup* instead of inverting a continuous CDF.

=== Setup

Same costs as basic newsvendor:
- $C_u = P - C$ (underage)
- $C_o = C - S$ (overage)
- $"CR" = C_u \/ (C_u + C_o)$

Demand $D in {0, 1, 2, dots}$ with PMF $p_d$ and CDF $F(d) = P(D lt.eq d) = sum_(k = 0)^d p_k$.

=== Decision rule

For continuous $F$, $Q^* = F^(-1)("CR")$. For discrete $F$, the CDF jumps — there may be no $Q$ with $F(Q) = "CR"$ exactly. Take the *smallest* $Q$ that gets you to (or above) CR:

$ Q^* = min{Q in {0, 1, 2, dots} : cm(F(Q) gt.eq "CR")} $

Equivalent statements:
- $F(Q^*) gt.eq "CR"$ (don't undershoot)
- $F(Q^* - 1) < "CR"$ (smallest such $Q$)

Why this is correct: the marginal-analysis derivation from the basic newsvendor still holds. The expected marginal profit of one more unit at level $Q$ is $(1 - F(Q)) C_u - F(Q) C_o$. Order while this is $gt.eq 0$, i.e., while $F(Q) lt.eq "CR"$. Stop at the first $Q$ where $F(Q) gt.eq "CR"$.


#example(title: "Empirical demand from sales records")[
  *Given*: 6 weeks of sales for a perishable item.

  - Sale price: $P$ = \$10
  - Purchase cost: $C$ = \$4
  - Salvage value: $S$ = \$1
  - Empirical demand counts:

  #table(
    columns: 7,
    inset: 0.5em,
    align: center,
    [Demand $d$], [10], [12], [14], [16], [18], [20],
    [Frequency], [1], [1], [2], [1], [0], [1],
  )

  Total weeks: 6.

  *Step 1 — costs and CR*

  $ C_u = cm(10 - 4) = 6, quad C_o = cm(4 - 1) = 3 $
  $ "CR" = 6 / (6 + 3) = 2 / 3 approx 0.667 $

  *Step 2 — empirical CDF*

  Convert frequencies to probabilities, then accumulate:

  #table(
    columns: 7,
    inset: 0.5em,
    align: center,
    [$d$], [10], [12], [14], [16], [18], [20],
    [$p_d$], [$1\/6$], [$1\/6$], [$2\/6$], [$1\/6$], [$0$], [$1\/6$],
    [$F(d)$],
    [$1\/6 approx 0.167$],
    [$2\/6 approx 0.333$],
    [$4\/6 approx 0.667$],
    [$5\/6 approx 0.833$],
    [$5\/6$],
    [$6\/6 = 1$],
  )

  *Step 3 — find smallest $Q$ with $F(Q) gt.eq 0.667$*

  - $F(10) = 0.167 < 0.667$
  - $F(12) = 0.333 < 0.667$
  - $F(14) = 0.667 gt.eq 0.667$ ✓ — first to satisfy.

  $ Q^* = cm(14) "units" $

  *Step 4 — sanity check via marginal analysis*

  At $Q = 14$, expected marginal profit of one more unit:
  $ Delta(14) = (1 - cm(0.667)) dot 6 - cm(0.667) dot 3 = 2 - 2 = 0 ✓ $

  Adding a 15th unit would yield $Delta(15) = (1 - 0.833) dot 6 - 0.833 dot 3 = 1 - 2.5 < 0$ — not worth it.

  *Compare to continuous-normal baseline*: empirical mean $approx 14$, std $approx 3.4$. If we had assumed normal demand:
  $ Q^*_"normal" approx 14 + 0.44 dot 3.4 approx 15.5 → 16 "(rounded)" $

  The discrete answer ($Q^* = 14$) is *smaller* than the continuous approximation because the empirical CDF jumps past the threshold exactly at 14. With small samples, the discrete formula respects the actual data distribution rather than a smoothed assumption.
]
