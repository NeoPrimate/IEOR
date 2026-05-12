#import "/lib/imports.typ": *
#show: formatting

#let cm(x) = text(fill: red, [$#x$])

== Joint replenishment (multi-item EOQ with shared setup)

Relax one dimension from basic EOQ: *number of items* is no longer one. Multiple items share a single supplier (or a single delivery truck, or a single setup operation), so the order cost $S$ is paid *once per coordinated order* — not separately per item.

Single supplier, multiple SKUs: order them all together on the same cadence, save on setup.

=== Setup

$n$ items indexed $i = 1, dots, n$:
- $D_i$ = annual demand for item $i$
- $h_i$ = holding cost per unit per year for item $i$
- *Common setup* cost: $S$ (paid once when *any* order goes out, regardless of how many items)
- Decision: a *common cycle time* $T$ — every $T$ years, order each item in the quantity needed for one cycle, $Q_i = D_i T$.

This is the simplest joint-replenishment formulation. (Variants with item-specific minor setups $s_i$ in addition to a major $S$ exist — see Roundy / Federgruen-Zheng — but we'll keep it minimal here.)

=== Cost model

Per cycle:
- *One* setup cost: $S$
- Holding for item $i$ over the cycle: $h_i dot Q_i \/ 2 dot T = h_i D_i T \/ 2 dot T$. Wait — average inventory $Q_i\/2$, time per cycle $T$, so per-cycle holding cost is $h_i dot (Q_i \/ 2) dot T = h_i D_i T^2 \/ 2$.

Per unit time, divide by $T$:

$ "TC"(T) = S / T + sum_(i = 1)^n h_i (D_i T) / 2 = S / T + (T / 2) sum_(i = 1)^n h_i D_i $

The single decision $T$ trades off setup cost (decreases with $T$) against aggregate holding (increases with $T$).

=== Derive $T^*$

$ d / (d T) "TC" = -S / T^2 + 1 / 2 sum_i h_i D_i = 0 $

Solve for $T^*$:

$ T^{*2} = (2 S) / (sum_i h_i D_i) $
$ T^* = sqrt((2 S) / (sum_i h_i D_i)) $

=== Final formulas

$
  T^* = sqrt((2 S) / (sum_i h_i D_i))
  quad
  Q_i^* = D_i T^* = D_i sqrt((2 S) / (sum_j h_j D_j))
  quad
  "TC"^* = sqrt(2 S sum_i h_i D_i)
$

Sanity check: for a single item ($n = 1$), $T^* = sqrt(2 S \/ (h_1 D_1))$, $Q_1^* = D_1 T^* = sqrt(2 S D_1 \/ h_1)$ — exactly basic EOQ ✓.

The aggregation comes through the *single* $sqrt(sum_i h_i D_i)$ — items with small $h_i D_i$ contribute little to the optimal cycle, so they're ordered alongside the big-$h_i D_i$ items at no extra setup cost.

=== Why is this cheaper than independent EOQs?

Order each item independently with its own EOQ: each pays $S$ per order, total cost is $sum_i sqrt(2 S D_i h_i)$.

Joint replenishment: $sqrt(2 S sum_i h_i D_i)$.

By Cauchy-Schwarz / Jensen, $sqrt(sum_i a_i^2) lt.eq sum_i a_i$, so:

$ sqrt(2 S sum_i h_i D_i) lt.eq sum_i sqrt(2 S h_i D_i) $

Joint always wins. The savings grow with the number of items and the unevenness of $h_i D_i$ across them.


#example[
  *Given* (3 items sharing a single supplier with shared setup):
  - Common setup: $S$ = \$50 / order
  - Item 1: $D_1 = 12000$, $h_1$ = \$2
  - Item 2: $D_2 = 6000$, $h_2$ = \$3
  - Item 3: $D_3 = 3000$, $h_3$ = \$4

  *Step 1 — aggregate holding rate*

  $
    sum_i h_i D_i = 2 dot 12000 + 3 dot 6000 + 4 dot 3000 = 24000 + 18000 + 12000 = cm(54000)
  $

  *Step 2 — common cycle time*

  $
    T^* = sqrt((2 dot 50) / cm(54000)) = sqrt(100 / 54000) approx 0.0430 "years" approx 16 "days"
  $

  *Step 3 — order quantities*

  $
    Q_1^* = D_1 T^* = 12000 dot 0.043 approx 516 "units"
  $
  $
    Q_2^* = D_2 T^* = 6000 dot 0.043 approx 258 "units"
  $
  $
    Q_3^* = D_3 T^* = 3000 dot 0.043 approx 129 "units"
  $

  *Step 4 — total cost*

  $ "TC"^* = sqrt(2 dot 50 dot 54000) = sqrt(5400000) approx 2324 $ \$/year

  *Compare to independent EOQs* (each item ordered separately with full $S$):
  - Item 1: $Q_1 = sqrt(2 dot 50 dot 12000 \/ 2) = 775$, $"TC"_1 = sqrt(2 dot 50 dot 12000 dot 2) approx 1549$
  - Item 2: $Q_2 = sqrt(2 dot 50 dot 6000 \/ 3) approx 447$, $"TC"_2 = sqrt(2 dot 50 dot 6000 dot 3) approx 1342$
  - Item 3: $Q_3 = sqrt(2 dot 50 dot 3000 \/ 4) approx 274$, $"TC"_3 = sqrt(2 dot 50 dot 3000 dot 4) approx 1095$
  - Total independent: \$1549 + \$1342 + \$1095 = *\$3986*.

  *Joint replenishment saves \$1662/year* (42% lower) by sharing the setup across items. The savings scale with the number of items — at 10 SKUs of similar size, savings would approach 70%.
]
