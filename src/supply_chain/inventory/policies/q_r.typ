#import "/lib/imports.typ": *

#let cm(x) = text(fill: red, [$#x$])

== (Q, r) Policy

Continuous review, fixed order quantity. The most common stochastic-demand policy in textbooks and practice.

*Decision rule*: monitor inventory position continuously. When it drops to (or below) the reorder point $r$, order a fixed quantity $Q$.

Two parameters:
- $Q$ = order quantity (a *fixed* batch every time)
- $r$ = reorder point (the trigger level)

=== Setup

Random demand with rate $d$ per unit time and standard deviation $sigma_d$. Lead time $L$ (constant for now). Holding cost $h$, fixed order cost $S$, plus a service-level requirement $z$ (e.g., $z = 1.645$ for 95% cycle service level).

*Inventory position* $= "on-hand" + "on-order" - "backorders"$. Continuous review means we always know it.

=== Inventory profile

Sawtooth shape, but with random consumption rate:
- Inventory drains stochastically.
- When position hits $r$, a Q-unit order is placed; arrives $L$ time later.
- During lead time, demand consumes $D_L =$ random draw from a distribution with mean $mu_L = d L$ and std $sigma_L = sigma_d sqrt(L)$.
- *Service level* (probability of no stockout per cycle) = $P(D_L lt.eq r)$.

#align(center)[
  #canvas({
    import cetz.draw: *

    line((0, 0), (9, 0), name: "x_axis")
    line((0, 0), (0, 5.5), name: "y_axis")

    line((0, 5), (4, 1))
    line((4, 1), (4, 5))
    line((), (8, 1))

    line((0, 1), (9.5, 1), name: "s")

    circle((4, 1), radius: 0.1, fill: black, name: "A")
    circle((8, 1), radius: 0.1, fill: black, name: "B")

    line((4, 0), (4, 5), stroke: (dash: "dashed"), name: "reorder_point_1")
    line((8, 0), (8, 5), stroke: (dash: "dashed"), name: "reorder_point_2")

    content("reorder_point_1.start", padding: 0.25, anchor: "north", [#text(8pt, "Order\nRelease")])
    content("reorder_point_2.start", padding: 0.25, anchor: "north", [#text(8pt, "Order\nRelease")])

    set-style(mark: (symbol: "straight"))
    line((-0.5, 1), (-0.5, 5), name: "fixed_order_quantity")

    content(("fixed_order_quantity.start", 50%, "fixed_order_quantity.end"), angle: -90deg, padding: 0.25, [#box(
      align(center)[#text(8pt, "Fixed Order\nQuantity (Q)")],
      fill: white,
      inset: 0.5em,
    )])

    content(("s.start", 100%, "s.end"), angle: 0deg, padding: 0.25, [#box(
      align(center)[#text(10pt, "Reorder Point\n(r)")],
      fill: white,
      inset: 0.5em,
    )])
  })
]

=== Set $r$ — the reorder point

To meet cycle service level $1 - alpha$:

$ r = cm(mu_L) + cm(z) cm(sigma_L) $

where:
- $mu_L = d L$ (expected demand during lead time)
- $sigma_L = sigma_d sqrt(L)$ (std of lead-time demand, assuming i.i.d. periods)
- $z = Phi^(-1)(1 - alpha)$ (standard-normal quantile for the desired service level)

The term $z sigma_L$ is the *safety stock* — buffer for demand variability.

=== Set $Q$ — the order quantity

When fixed cost $S$ is significant, use the EOQ formula:

$ Q = sqrt((2 D S) / h) $

(Approximate — exact joint optimization of $Q$ and $r$ exists but EOQ is within a few % of optimal.)

=== Final formulas

$
  Q approx sqrt((2 D S) / h)
  quad
  r = mu_L + z sigma_L
  quad
  "SS" = z sigma_L
$

Average inventory (approximation): $Q\/2 + "SS"$, so total holding cost $approx h (Q\/2 + z sigma_L)$.


#example[
  *Given* (shared policy-comparison params):
  - Annual demand: $D$ = 12,000 units/year ($d = 33$ units/day)
  - Daily demand std: $sigma_d = 5$ units/day
  - Lead time: $L = 14$ days (constant)
  - Order cost: $S$ = \$50 / order
  - Holding cost: $h$ = \$2 / unit / year
  - Service level: 95% → $z = 1.645$

  *Step 1 — order quantity (EOQ)*

  $ Q = sqrt((2 dot 12000 dot 50) / 2) = sqrt(600000) approx 775 "units" $

  *Step 2 — lead-time demand statistics*

  $ mu_L = d L = cm(33) dot cm(14) = 462 "units" $
  $ sigma_L = sigma_d sqrt(L) = cm(5) dot sqrt(14) approx 18.7 "units" $

  *Step 3 — reorder point*

  $ r = mu_L + z sigma_L = cm(462) + cm(1.645) dot cm(18.7) approx 462 + 30.8 approx 493 "units" $

  Safety stock: $"SS" = 30.8$ units.

  *Step 4 — interpret*

  Whenever inventory position drops to 493, place an order for 775. The order arrives 14 days later. Expected demand during those 14 days is 462; the extra 31 units of safety stock cover up-to-95th-percentile demand fluctuations.

  Average ordering rate: $D / Q = 12000 / 775 approx 15.5$ orders / year. Average cycle length: $Q / D = 775 / 12000 approx 24$ days.

  Average inventory: $Q/2 + "SS" = 388 + 31 approx 419$ units.
  Annual holding cost: $h dot 419 approx$ \$838 / year.
  Annual ordering cost: $S dot D/Q = 50 dot 15.5 approx$ \$775 / year.
  *Total*: $approx$ \$1613 / year (vs \$1549 for deterministic EOQ — the gap is the cost of safety stock).
]
