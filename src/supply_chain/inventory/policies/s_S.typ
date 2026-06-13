#import "/lib/imports.typ": *
#show: formatting

#let cm(x) = text(fill: red, [$#x$])

Continuous review, *order-up-to* $S$. Generalizes (Q, r): instead of always ordering the same Q, top up to a target level.

*Decision rule*: monitor inventory continuously. When inventory position drops to (or below) the reorder point $s$, order *enough to bring inventory position back up to* $S$.

Two parameters:
- $s$ = reorder point (trigger)
- $S$ = order-up-to level

The actual order quantity *varies*: $Q_"actual" = S - "(inventory position when triggered)"$. If inventory drops exactly to $s$ before triggering, $Q_"actual" = S - s$. If demand causes a drop *below* $s$ (overshoot), $Q_"actual" > S - s$.

== Setup

Same as (Q, r): demand rate $d$ with std $sigma_d$, lead time $L$, costs $S_"setup", h$, service level $z$.

== Difference from (Q, r)

(Q, r) commits to a *fixed* batch $Q$ every order — doesn't matter if inventory dropped to exactly $r$ or much below. (s, S) compensates: if inventory overshoots downward, the order is *larger* to make up.

In practice, *with continuous review and small per-period demand* (smooth depletion), the two are nearly identical. Differences emerge under *lumpy demand* — large discrete withdrawals can drop inventory well below $s$ in one go.

#align(center)[
  #frame(cetz.canvas({
    import cetz.draw: *

    line((0, 0), (9, 0), name: "x_axis")
    line((0, 0), (0, 5.5), name: "y_axis")

    line((0, 5), (4, 1))
    line((4, 1), (4, 5))
    line((), (8, 1))

    line((0, 1), (9.5, 1), name: "s")
    line((0, 5), (9.5, 5), name: "S")

    circle((4, 1), radius: 0.1, fill: black, name: "A")
    circle((8, 1), radius: 0.1, fill: black, name: "B")

    line((4, 0), (4, 5), stroke: (dash: "dashed"), name: "reorder_point_1")
    line((8, 0), (8, 5), stroke: (dash: "dashed"), name: "reorder_point_2")

    content("reorder_point_1.start", padding: 0.25, anchor: "north", [#text(8pt, "Order\nRelease")])
    content("reorder_point_2.start", padding: 0.25, anchor: "north", [#text(8pt, "Order\nRelease")])

    content(("s.start", 100%, "s.end"), angle: 0deg, padding: 0.25, [#box(
      align(center)[#text(10pt, "Reorder Point\n(s)")],
      fill: white,
      inset: 0.5em,
    )])

    content(("S.start", 100%, "S.end"), angle: 0deg, padding: 0.25, [#box(
      align(center)[#text(10pt, "Up-to Level\n(S)")],
      fill: white,
      inset: 0.5em,
    )])
  }))
]

== Set $s$

Same logic as $r$ in (Q, r):

$ s = mu_L + z sigma_L $

== Set $S$

For large fixed cost (most cases), $S - s$ should approximately equal the EOQ:

$ S = s + Q_"EOQ" = s + sqrt((2 D S_"setup") / h) $

Why: when inventory drops exactly to $s$ (no overshoot), this gives the same order quantity as (Q, r). When it overshoots, the order grows automatically.

For low/zero fixed cost: $S = s$ (order one unit at a time — the "base stock" / (S-1, S) policy in the limit; see [base_stock.typ](base_stock.typ)).

== Final formulas

$
  s = mu_L + z sigma_L
  quad
  S = s + sqrt((2 D S_"setup") / h)
  quad
  "SS" = z sigma_L
$

Average inventory under (s, S) is *slightly higher* than (Q, r) because of the overshoot correction — but only by an amount proportional to expected overshoot per cycle, usually small.

#example[
  *Given* (same policy-comparison params):
  - $D = 12000$/yr, $d = 33$/day, $sigma_d = 5$, $L = 14$ days
  - $S_"setup"$ = \$50, $h$ = \$2/unit/yr, $z = 1.645$
  - Demand assumed *smooth* (small per-period withdrawals)

  *Step 1 — reorder point*

  $ s = mu_L + z sigma_L = 462 + 30.8 approx cm(493) $

  Identical to $r$ in (Q, r).

  *Step 2 — order-up-to level*

  $ Q_"EOQ" = sqrt((2 dot 12000 dot 50) / 2) approx 775 $
  $ S = s + Q_"EOQ" = 493 + 775 approx cm(1268) "units" $

  *Step 3 — order quantity per trigger*

  Whenever inventory position drops to (or below) 493, order:
  $ Q_"actual" = 1268 - "current position" $

  - If position is exactly 493 at the moment of trigger: order $1268 - 493 = 775$ (same as EOQ).
  - If position is 480 (overshot below 493 due to a lumpy demand): order $1268 - 480 = 788$ (slightly larger to compensate).

  *Compare to (Q, r)*

  Under smooth demand:
  - (Q, r): $Q = 775$ exactly, $r = 493$.
  - (s, S): $S - s = 775$, expected order $approx 775$, so essentially the same numbers.

  *Difference appears under lumpy demand*: if a single customer order suddenly removes 100 units, dropping inventory from 540 to 440:
  - (Q, r) orders 775. New inventory position: $440 + 775 = 1215$.
  - (s, S) orders $1268 - 440 = 828$. New inventory position: $1268$ (back to target).

  (s, S) restores the *target* every time; (Q, r) just adds the same fixed batch. Use (s, S) when demand is lumpy or when you have a target inventory budget.
]
