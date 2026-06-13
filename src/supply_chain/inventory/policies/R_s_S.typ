#import "/lib/imports.typ": *
#show: formatting

#let cm(x) = text(fill: red, [$#x$])

Periodic review with a reorder point. Generalizes (R, S) by adding a "do nothing" option when inventory is high.

*Decision rule*: at every review point (every $R$ time units), observe the inventory position $I_t$.
- *If* $I_t lt.eq s$ (inventory low): order $S - I_t$ (bring up to $S$).
- *Else* ($I_t > s$, inventory still healthy): *don't order*.

Three parameters:
- $R$ = review interval
- $s$ = reorder point
- $S$ = order-up-to level

== When to use

Use (R, s, S) when:
- Reviews are periodic (truck arrives weekly), but
- You don't want to order *every* review when inventory is still healthy (saves order cost when consumption was light).

Compared to (R, S): saves order cost in low-consumption periods. Compared to (s, S): adds the periodic-review constraint (simpler operations, less precise).

(R, s, S) is widely considered the *most general* periodic policy. It generalizes both (R, S) (set $s = S$, always order) and *zero ordering* (set $s$ very low, never order).

== Inventory profile

Sawtooth, with order skipping:
- Some reviews: $I_t > s$, no order. Inventory continues to drain.
- Other reviews: $I_t lt.eq s$, order up to $S$.
- Order arrives at next review or before, depending on $L$ vs $R$.

If $R$ is short relative to mean cycle, most reviews do *not* trigger orders. If $R$ is long, almost every review triggers.

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

    line((2, 0), (2, 5), stroke: (dash: "dashed"), name: "review_1")
    line((4, 0), (4, 5), stroke: (dash: "dashed"), name: "review_2")
    line((6, 0), (6, 5), stroke: (dash: "dashed"), name: "review_3")
    line((8, 0), (8, 5), stroke: (dash: "dashed"), name: "review_4")

    content("review_1.start", padding: 0.25, anchor: "north", [#text(8pt, "Review")])
    content("review_2.start", padding: 0.25, anchor: "north", [#text(8pt, "Review")])
    content("review_3.start", padding: 0.25, anchor: "north", [#text(8pt, "Review")])
    content("review_4.start", padding: 0.25, anchor: "north", [#text(8pt, "Review")])

    set-style(mark: (symbol: "straight"))
    line((0, 0.5), (2, 0.5), name: "R_1")
    line((2, 0.5), (4, 0.5), name: "R_2")
    line((4, 0.5), (6, 0.5), name: "R_3")
    line((6, 0.5), (8, 0.5), name: "R_4")

    content(("R_1.start", 50%, "R_1.end"), angle: 0deg, padding: 0.25, [#box(
      align(center)[#text(8pt, "R")],
      fill: white,
      inset: 0.5em,
    )])
    content(("R_2.start", 50%, "R_2.end"), angle: 0deg, padding: 0.25, [#box(
      align(center)[#text(8pt, "R")],
      fill: white,
      inset: 0.5em,
    )])
    content(("R_3.start", 50%, "R_3.end"), angle: 0deg, padding: 0.25, [#box(
      align(center)[#text(8pt, "R")],
      fill: white,
      inset: 0.5em,
    )])
    content(("R_4.start", 50%, "R_4.end"), angle: 0deg, padding: 0.25, [#box(
      align(center)[#text(8pt, "R")],
      fill: white,
      inset: 0.5em,
    )])

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

== Set $s$ — protection-window logic

Same as (R, S): the protection window is $R + L$, because an order placed at review covers demand until the *next* review's order arrives. So:

$ s = mu_(R+L) + z sigma_(R+L) $

Identical to the $S$ in (R, S)! That's because $s$ in (R, s, S) plays the same protection role as $S$ in (R, S) — it's the level *above which we still have enough buffer*.

== Set $S$

$S - s$ should be the EOQ-style batch size. Heuristic:

$ S = s + Q_"EOQ" = s + sqrt((2 D S_"setup") / h) $

When inventory drops to exactly $s$ between reviews, the next order is for $S - s = Q_"EOQ"$. With overshoot (inventory below $s$ at review), the order is bigger — same as (s, S).

== Computing optimal $s, S$ exactly

Closed forms exist for special cases (Wagner's lower-bound formula); in general, $(s^*, S^*)$ require dynamic programming or simulation. The heuristic above is within a few % of optimal for typical industrial parameter ranges.

== Final formulas

$
  s = mu_(R+L) + z sigma_(R+L)
  quad
  S = s + sqrt((2 D S_"setup") / h)
  quad
  "SS" = z sigma_(R+L)
$

#example[
  *Given* (same policy-comparison params):
  - $D = 12000$/yr, $d = 33$/day, $sigma_d = 5$, $L = 14$ days, $R = 30$ days
  - $S_"setup"$ = \$50, $h$ = \$2/unit/yr, $z = 1.645$

  *Step 1 — reorder point* (same as $S$ from (R, S))

  $ s = mu_(R+L) + z sigma_(R+L) = 1452 + 54.6 approx cm(1507) $

  *Step 2 — order-up-to level*

  $ Q_"EOQ" = sqrt((2 dot 12000 dot 50) / 2) approx 775 $
  $ S = s + Q_"EOQ" = 1507 + 775 approx cm(2282) $

  *Step 3 — typical reviews*

  Steady-state inventory between reviews drops by about $R d = 990$ units per review interval.

  - *Review 1*: position is 2282 (just received order). Drains to $approx 2282 - 990 = 1292$ by review 2.
  - *Review 2*: position 1292. *Below $s = 1507$* ✓ → order $2282 - 1292 = 990$ units.
  - Continues this pattern.

  Almost every review triggers an order because $R$ is comparable to the average cycle time. Behaviorally similar to (R, S).

  *Step 4 — when "don't order" actually fires*

  Suppose demand is unusually light over a review period (e.g., only 200 units consumed instead of 990). Then inventory at the next review is $2282 - 200 = 2082 > 1507 = s$. No order placed → save \$50.

  Then next review: another 200 consumed → 1882, still above $s$ → no order.
  Then another: 1682 → still above $s$ → no order.
  Eventually drops below $s$, then big catch-up order.

  *(R, s, S) sleeps through low-consumption stretches*; (R, S) would have ordered every review regardless.

  *Compare to (R, S)*

  - (R, S): always order every review. $S$ at protection-window level (1507). Number of orders = $365 / R = 12.2$/year.
  - (R, s, S): may skip some reviews. Same $s$ (1507), $S = s + Q_"EOQ"$ (2282). Order frequency varies; expected $approx 365 / (Q_"EOQ"/d) = 365/(775/33) = 15.5$/year *but with variability*.

  Use (R, s, S) when *order setup cost is significant* and consumption variability is high — the "skip a review" behavior amortizes the setup cost across larger batches.
]
