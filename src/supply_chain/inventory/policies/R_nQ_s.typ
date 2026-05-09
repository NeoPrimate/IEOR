#import "/lib/imports.typ": *

#let cm(x) = text(fill: red, [$#x$])

== (R, nQ, s) Policy

Periodic review, *fixed pack size, with reorder point*. Combines the periodic-review structure of (R, s, S) with the fixed-pack constraint of (nQ, r).

*Decision rule*: at every review point (every $R$ time units), observe inventory position $I_t$.
- *If* $I_t lt.eq s$ (inventory low): order the smallest integer multiple $n Q$ that brings position above $s$ (or above some target).
- *Else*: don't order.

Three parameters:
- $R$ = review interval
- $Q$ = fixed pack size (supplier-mandated)
- $s$ = reorder point

(The "S" of (R, s, S) is replaced by *implicit* $S = s + n Q$ — the resulting position depends on how many packs are needed.)

=== When to use

The pragmatic real-world combination:
- Reviews are periodic (cycle counts done weekly or monthly).
- Pack size is fixed by the supplier (full case, dozen, pallet).
- Want to skip the order when inventory is still healthy.

Common in retail (Each store reorders periodically, pack sizes are case-of-N) and pharmacy (DEA-mandated periodic counts of controlled substances, fixed pack size from manufacturer).

=== Inventory profile

Sawtooth, with two layers of discreteness:
- Some reviews: skip (inventory above $s$).
- Other reviews: order $n Q$ where $n$ is the integer chosen at trigger time.

Average inventory is *higher* than (R, s, S) because the integer-pack rounding inflates each order. Difference is small if $Q << s$, large if $Q$ is comparable to $s$.

#align(center)[
  #frame(cetz.canvas({
    import cetz.draw: *

    line((0, 0), (9, 0), name: "x_axis")
    line((0, 0), (0, 5.5), name: "y_axis")

    line((0, 5), (4, 1))
    line((4, 1), (4, 5))
    line((), (8, 1))

    line((0, 1), (9.5, 1), name: "s")

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

    set-style(mark: (symbol: "straight"))
    line((-0.5, 1), (-0.5, 5), name: "fixed_order_quantity")

    content(("fixed_order_quantity.start", 50%, "fixed_order_quantity.end"), angle: -90deg, padding: 0.25, [#box(
      align(center)[#text(8pt, "Pack Size\n(Q)")],
      fill: white,
      inset: 0.5em,
    )])
  }))
]

=== Set $s$

Same protection-window logic as (R, s, S) and (R, S):

$ s = mu_(R+L) + z sigma_(R+L) $

Pack-size constraint affects the *order quantity*, not the trigger.

=== Choose $n$ at trigger time

When triggered with position $I_t lt.eq s$:

$ n = ceil((s - I_t + Q) / Q) quad ("smallest" n " s.t. " I_t + n Q > s) $

A simpler rule: pick $n$ to make post-order position $approx s + Q\/2$ (midpoint of typical $s$-to-$s + Q$ range). For the smooth-demand case, $n = 1$ usually suffices.

=== Set $Q$

$Q$ is *given* by the supplier. If you have flexibility (multiple pack sizes available), pick the one closest to $Q_"EOQ" = sqrt(2 D S_"setup" \/ h)$.

=== Final formulas

$
  s = mu_(R+L) + z sigma_(R+L)
  quad
  Q = "supplier-fixed pack size"
  quad
  n = ceil((s - I_t + Q) / Q)
$


#example[
  *Given* (same policy-comparison params + a fixed pack):
  - $D = 12000$/yr, $d = 33$/day, $sigma_d = 5$, $L = 14$ days, $R = 30$ days
  - $z = 1.645$, $h$ = \$2/unit/yr
  - Pack size: $Q = 1000$ units (case)

  *Step 1 — reorder point*

  $ s = mu_(R+L) + z sigma_(R+L) = 1452 + 54.6 approx cm(1507) $

  *Step 2 — typical review with healthy inventory*

  Inventory at review = 1800 (above $s = 1507$). *Skip — no order*.

  *Step 3 — typical review with depleted inventory*

  Inventory at review = 1200 (below $s$). Compute $n$:
  $ n = ceil((1507 - 1200 + 1000) / 1000) = ceil(1307 / 1000) = ceil(1.307) = cm(2) "packs" $

  Order $n Q = 2000$ units. Post-order position: $1200 + 2000 = 3200$. Well above $s$.

  *Step 4 — typical review with slight depletion*

  Inventory at review = 1450 (just below $s$). Compute $n$:
  $ n = ceil((1507 - 1450 + 1000) / 1000) = ceil(1057 / 1000) = ceil(1.057) = cm(2) "packs" $

  Hmm — even a tiny dip below $s$ orders 2 packs. The formula always rounds up to ensure the post-order position is *above* $s + Q$. A more economical choice would be 1 pack (post-order = 2450, above $s$ = 1507 ✓), but then over time you'd accumulate small deficits.

  *Refinement*: a common variant orders the smallest $n$ such that post-order position exceeds *just $s$* (not $s + Q$):

  $ n_"loose" = ceil((s - I_t) / Q) = ceil((1507 - 1450) / 1000) = ceil(0.057) = cm(1) "pack" $

  Choice of rule depends on tolerance for overshoot vs subsequent shortages. The tighter rule (always above $s + Q$) is safer; the looser rule (just above $s$) is leaner.

  *Step 5 — compare to (R, s, S)*

  (R, s, S) on same params: $s = 1507$, $S = s + Q_"EOQ" = 2282$.
  - At trigger with position 1450, order $S - 1450 = 832$. Post-order: 2282.
  - Compare to (R, nQ, s) with $Q = 1000$: order $1 dot 1000 = 1000$. Post-order: 2450.

  *(R, nQ, s) carries about 10% more inventory* (2450 vs 2282) because integer packs round up. Acceptable when supplier inflexibility forces the constraint.

  Use (R, nQ, s) when: periodic review + fixed pack size + want skip-when-healthy logic. The most operationally realistic of the periodic policies.
]
