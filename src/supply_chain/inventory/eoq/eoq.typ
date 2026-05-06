#import "/src/imports.typ": *

// `cm` highlights the token that *changed* between the previous derivation line and this one.
// `rm` highlights a token that *vanishes* (zeroed out, dropped, or cancelled).
#let cm(x) = text(fill: red, [$#x$])
#let rm(x) = text(fill: red, $cancel(#x)$)

== EOQ

The inventory replenishment trade-off:
- Order *too much* → high *holding cost* (storage, capital tied up)
- Order *too little* → high *order cost* (frequent setups, paperwork)

Strategy of this whole section:
+ Express total annual cost as a function of order quantity $Q$
+ Take its derivative with respect to $Q$ and set to zero
+ Solve for $Q$ — call this optimum the *Economic Order Quantity* (EOQ)

=== Assumptions

- Demand $D$ is constant and known
- Replenishment is instantaneous (no lead time)
- Unit cost $c$ is flat (no quantity discounts)
- Single product, single location
- Backorders are allowed at penalty rate $b$ (relaxed in the next subsection)

=== Cost model (TC)

Total cost over a year is the sum of four pieces. Build them one at a time.

*1. Purchase cost.* Buy $D$ units per year, each at unit cost $c$:

$ "PC" = c D $

*2. Order cost.* Each order costs $S$ to place; ordering $Q$ units at a time means $D / Q$ orders per year:

$ "OC" = S (D / Q) $

*3. Holding cost.* With backorders allowed, the average on-hand inventory is $(Q - B)^2 / (2 Q)$. Each unit on hand is charged at rate $h$:

$ "HC" = h (Q - B)^2 / (2 Q) $

*4. Shortage cost.* The average backorder level is $B^2 / (2 Q)$. Each backordered unit is charged at rate $b$:

$ "SC" = b (B^2 / (2 Q)) $

Sum the four pieces into total cost:

$
  "TC"(Q, B) =
  underbrace(c D, "PC")
  + underbrace(S (D / Q), "OC")
  + underbrace(h (Q - B)^2 / (2 Q), "HC")
  + underbrace(b (B^2 / (2 Q)), "SC")
$

Variables:
- $D$ = annual demand
- $Q$ = order quantity (the *decision* variable)
- $c$ = unit cost
- $S$ = setup (order) cost
- $h$ = annual holding cost per unit ($= r dot v$, where $r$ is the holding cost rate and $v$ is the unit value)
- $b$ = backorder penalty per unit per year
- $B$ = maximum backorder quantity

#table(
  columns: 3,
  align: left,
  inset: 1em,
  [$c D$], [Purchase cost], [Unit cost times annual demand],
  [$S (D / Q)$], [Order cost], [Place $D / Q$ orders per year, each costing $S$],
  [$h (Q - B)^2 / (2 Q)$], [Holding cost], [Average on-hand inventory times holding rate $h$],
  [$b (B^2 / (2 Q))$], [Shortage cost], [Average backorder level times penalty rate $b$],
)

=== Simplification (TRC)

Two simplifications take us from $"TC"$ down to the *Total Relevant Cost* — a function of $Q$ alone.

*Step 1 — forbid backorders* ($B = 0$). Substitute $B = #cm(0)$ everywhere:

$
  "TC"(Q, #cm(0)) = c D + S (D / Q) + h (Q - #cm(0))^2 / (2 Q) + b (#cm(0))^2 / (2 Q)
$

The shortage term zeroes out and the holding term collapses:

$
  = c D + S (D / Q) + h #cm($Q^2 / (2 Q)$) + #cm(0)
  = c D + S (D / Q) + h #cm($Q / 2$)
$

*Step 2 — drop the constant.* The purchase cost $c D$ does not depend on $Q$, so it does not move the optimum. Strike it out:

$ #rm($c D$) + S (D / Q) + h (Q / 2) $

What remains is the *Total Relevant Cost*:

$ "TRC"(Q) = S (D / Q) + h (Q / 2) $

#let S = 30
#let D = 1000
#let h = 5

#let order_cost(Q) = S * (D / Q)
#let holding_cost(Q) = h * (Q / 2)
#let trc(Q) = order_cost(Q) + holding_cost(Q)

#figure(
  caption: [TRC and its two components, as functions of $Q$. The minimum is where the two component curves cross.],
  cetz.canvas({
    import cetz-plot: *

    plot.plot(
      size: (10, 6),
      x-label: [$Q$],
      y-label: [Cost],
      x-tick-step: 100,
      y-tick-step: 500,
      {
        plot.add(order_cost, domain: (20, 300), style: (stroke: blue), label: "Order cost")
        plot.add(holding_cost, domain: (20, 300), style: (stroke: red), label: "Holding cost")
        plot.add(trc, domain: (20, 300), style: (stroke: black, dash: "dashed"), label: "TRC (total)")
      },
    )
  }),
)

=== Derive $Q^*$ (first-order condition)

Find the $Q$ that minimizes $"TRC"(Q)$:
- Set the derivative with respect to $Q$ to zero (FOC, this subsection).
- Verify the second derivative is positive (SOC, next subsection).

==== Differentiate term by term

Start:

$ d / (d Q) "TRC"(Q) = d / (d Q) (S (D / Q) + h (Q / 2)) $

Split the derivative across the two terms:

$ = d / (d Q) (S (D / Q)) + d / (d Q) (h (Q / 2)) $

Rewrite $1 / Q$ as $#cm($Q^(-1)$)$ in the first term:

$ = d / (d Q) (S D #cm($Q^(-1)$)) + d / (d Q) ((h / 2) Q) $

Apply the power rule to each term — the exponent comes down as a coefficient, then drops by 1:

$
  = S D #cm((-1)) Q^(#cm($-1 - 1$)) + (h / 2) #cm(1) Q^(#cm($1 - 1$))
$

Simplify the exponents:

$ = -S D Q^(#cm(-2)) + (h / 2) Q^(#cm(0)) $

Use $Q^0 = 1$ and tidy:

$ d / (d Q) "TRC"(Q) = -(S D) / Q^2 + h / 2 $

==== Set to zero, solve for $Q$

Start (FOC):

$ -(S D) / Q^2 + h / 2 = 0 $

Move $-(S D) / Q^2$ to the right side (becomes positive):

$ #cm($h / 2$) = (S D) / Q^2 $

Multiply both sides by $#cm($Q^2$)$:

$ (h / 2) #cm($Q^2$) = S D $

Multiply both sides by $#cm($2 / h$)$:

$ Q^2 = #cm($(2 S D) / h$) $

Take the square root of both sides:

$ Q^* = #cm($sqrt$) ((2 S D) / h) $

This $Q^*$ is the *Economic Order Quantity*:

$ "EOQ" = Q^* = sqrt((2 S D) / h) $

#example[
  Plug in $D = 12000$ units/year, $S = 50$ \$/order, $h = 2$ \$/unit/year:

  $ Q^* = sqrt((2 dot 50 dot 12000) / 2) = sqrt(600000) approx 775 "units" $

  Order ~775 units at a time.
]

=== Verify it is a minimum (second-order condition)

Differentiate $d / (d Q) "TRC"(Q)$ once more.

Start:

$ d^2 / (d Q^2) "TRC"(Q) = d / (d Q) (-S D Q^(-2) + h / 2) $

The constant $h / 2$ drops out. Apply the power rule to $-S D Q^(-2)$ — exponent $#cm(-2)$ comes down, then drops by 1:

$ = -S D #cm((-2)) Q^(#cm($-2 - 1$)) = #cm(2) S D Q^(#cm(-3)) $

Tidy:

$ d^2 / (d Q^2) "TRC"(Q) = (2 S D) / Q^3 $

For any $Q > 0$ this is positive ⇒ $Q^*$ is a *minimum*. ✓

=== Derive $"TRC"^*$ (the minimum cost)

Substitute $Q^* = sqrt((2 S D) / h)$ back into $"TRC"$.

Start:

$ "TRC"^* = S (D / Q^*) + h (Q^* / 2) $

Substitute $Q^*$:

$
  = S D / #cm($sqrt((2 S D) / h)$) + (h / 2) #cm($sqrt((2 S D) / h)$)
$

Use $1 \/ sqrt(x) = sqrt(1 \/ x)$ on the first term:

$ = S D #cm($sqrt(h / (2 S D))$) + (h / 2) sqrt((2 S D) / h) $

Pull each coefficient inside its radical (squared):

$
  = #cm($sqrt(S^2 D^2 dot h / (2 S D))$) + #cm($sqrt(h^2 / 4 dot (2 S D) / h)$)
$

Cancel inside each radical:

$ = sqrt(#cm($(S D h) / 2$)) + sqrt(#cm($(S D h) / 2$)) $

Two equal terms add:

$ = #cm(2) sqrt((S D h) / 2) $

Bring the $2$ inside the radical (squared, so it becomes $4$):

$ = sqrt(#cm(4) dot (S D h) / 2) = sqrt(#cm($2 S D h$)) $

Result:

$ "TRC"^* = sqrt(2 S D h) $

=== Key insight: balance at the optimum

At $Q^*$, *annual order cost equals annual holding cost*. Each is exactly half of $"TRC"^*$.

*Order cost at $Q^*$:*

$
  "OC"^* = S (D / Q^*)
  = S D / sqrt((2 S D) / h)
  = sqrt((S^2 D^2 dot h) / (2 S D))
  = sqrt((S D h) / 2)
$

*Holding cost at $Q^*$:*

$
  "HC"^* = h (Q^* / 2)
  = (h / 2) sqrt((2 S D) / h)
  = sqrt(h^2 / 4 dot (2 S D) / h)
  = sqrt((S D h) / 2)
$

Therefore:

$ "OC"^* = "HC"^* = sqrt((S D h) / 2) = "TRC"^* / 2 $

Mnemonic: *EOQ is the $Q$ where the two cost curves cross.*

=== How forgiving is EOQ? (sensitivity)

Small input errors produce *much smaller* cost penalties — square-root cushioning. Quantify it.

==== Cost penalty function

Take the ratio of $"TRC"$ at any $Q$ to $"TRC"^*$.

Start:

$ "TRC"(Q) / "TRC"^* = (S D / Q + h Q / 2) / sqrt(2 S D h) $

Split the fraction:

$ = (S D / Q) / sqrt(2 S D h) + (h Q / 2) / sqrt(2 S D h) $

Two useful identities (each obtained by rearranging $Q^* = sqrt((2 S D) \/ h)$):

$ sqrt(2 S D h) = h Q^* quad "and" quad sqrt(2 S D h) = (2 S D) / Q^* $

Substitute the *second* identity into the first term, the *first* identity into the second term:

$
  = (S D / Q) / #cm($(2 S D) / Q^*$) + (h Q / 2) / #cm($h Q^*$)
$

Cancel $S D$ in the first fraction, $h$ in the second:

$ = #cm($Q^* / (2 Q)$) + #cm($Q / (2 Q^*)$) $

Factor out $1 / 2$:

$ "TRC"(Q) / "TRC"^* = 1 / 2 (Q / Q^* + Q^* / Q) $

#let penalty(x) = 0.5 * (x + 1 / x)

#figure(
  caption: [Cost penalty curve: how much extra you pay when $Q != Q^*$.],
  cetz.canvas({
    import cetz-plot: *

    plot.plot(
      size: (10, 6),
      x-label: [$Q \/ Q^*$],
      y-label: [$"TRC"(Q) \/ "TRC"^*$],
      x-tick-step: 0.5,
      y-tick-step: 0.5,
      {
        plot.add(penalty, domain: (0.2, 3), style: (stroke: 2pt + blue))
        plot.add-hline(1, style: (stroke: (paint: gray, dash: "dashed")))
      },
    )
  }),
)

Snapshots:
- $Q = 2 Q^*$ or $Q = 0.5 Q^*$ ⇒ cost is *1.25*× optimum (+25%)
- $Q = Q^*$ ⇒ cost is *1.00*× optimum

==== Demand-forecast error

Forecast $D'$, actual $D$. Define $E = D / D'$. Then $Q' \/ Q^* = sqrt(D' \/ D) = 1 / sqrt(E)$, so:

$ "TRC" / "TRC"^* = 1 / 2 (1 / sqrt(E) + sqrt(E)) $

- $E = 0.5$ (actual demand is half the forecast) ⇒ cost penalty is just *+6%*. Tiny.

==== Cost-parameter error

Same square-root cushion — a 10% error in $S$ or $h$ produces *much less* than a 10% error in $Q^*$, since $Q^* prop sqrt(S)$ and $Q^* prop sqrt(1\/h)$.

=== Practical: power-of-two policies

Real warehouses cannot use an arbitrary cycle time $T^* = Q^* / D$ — they need a fixed, predictable cadence.

*Rule.* The replenishment interval $T$ must be of the form $T_"base" dot 2^k$ for some integer $k = 0, 1, 2, ...$. Example with $T_"base" = 1$ week: allowed intervals are 1, 2, 4, 8 weeks.

Variables:
- $T$ = chosen replenishment interval
- $T^*$ = optimal interval ($= Q^* / D$)
- $T \/ T^*$ = how far the chosen schedule deviates from the optimum

#let bound = 1.0606 // 6% threshold

#figure(
  caption: [Power-of-two safe zone: $T \/ T^* in [0.707, 1.414]$ guarantees ≤ 6% cost penalty.],
  cetz.canvas({
    import cetz-plot: *

    plot.plot(
      size: (12, 7),
      x-label: [$T \/ T^*$ ratio],
      y-label: [Cost multiplier ($"TRC" \/ "TRC"^*$)],
      x-tick-step: 0.5,
      y-tick-step: 0.05,
      x-domain: (0.2, 2.5),
      y-domain: (0.95, 1.3),
      {
        plot.add(penalty, domain: (0.3, 2.5), style: (stroke: 2pt + black))
        plot.add-hline(bound, style: (stroke: (paint: red, dash: "dashed")))
        plot.add-vline(0.707, 1.414, style: (stroke: red + 1pt))
        plot.add-fill-between(
          penalty,
          x => 0.95,
          domain: (0.707, 1.414),
          style: (fill: rgb(255, 0, 0, 30), stroke: none),
        )
        plot.add(((0.5, penalty(0.5)),), mark: "o", style: (stroke: blue))
        plot.add(((1.0, 1.0),), mark: "o", style: (stroke: blue, fill: blue))
        plot.add(((2.0, penalty(2.0)),), mark: "o", style: (stroke: blue))
      },
    )
  }),
)

*Safe zone.* For any $T^*$, *some* power-of-two $T$ is always within a factor of $sqrt(2)$ of it. So $T \/ T^* in [0.707, 1.414]$ is always achievable, which from the cost-penalty curve gives at most a *6% cost penalty*.

*Why this is great.* Powers of two *nest*: a product ordered every 2 months and another every 4 months always sync up. Predictable warehouse rhythm and consolidated shipping costs.

#table(
  columns: 3,
  align: left,
  inset: 1em,
  [Scenario], [Deviation], [Cost impact ($"TRC" \/ "TRC"^*$)],
  [Order quantity], [$Q = 2 Q^*$ (too large)], [1.25 (+25%)],
  [Order quantity], [$Q = 0.5 Q^*$ (too small)], [1.25 (+25%)],
  [Demand forecast], [$D = 2 D'$ (actual is double)], [1.06 (+6%)],
  [Demand forecast], [$D = 0.5 D'$ (actual is half)], [1.06 (+6%)],
  [Replenishment], [Power-of-two interval], [≤ 1.06 (≤ +6%)],
)

#example[

  *1. Setup: two products with different demand profiles.*

  Base time period $T_"base" = 1$ month.

  #table(
    columns: 3,
    [Feature], [Product A (fast mover)], [Product B (slow mover)],
    [Annual demand $D$], [2400 units], [600 units],
    [Order cost $S$], [\$50], [\$50],
    [Holding cost $h$], [\$2 / unit / year], [\$3 / unit / year],
  )

  *2. Compute the mathematical ideal $T^*$* (using $T^* = Q^* \/ D$).

  Product A:

  $
    Q^*_A = sqrt((2 dot 50 dot 2400) / 2) approx 346 "units" \
    \
    T^*_A = 346 / 2400 approx 0.144 "years" approx bold(1.7) "months"
  $

  Product B:

  $
    Q^*_B = sqrt((2 dot 50 dot 600) / 3) approx 141 "units" \
    \
    T^*_B = 141 / 600 approx 0.235 "years" approx bold(2.8) "months"
  $

  *3. Snap to the power-of-two grid.*

  Allowed intervals: 1, 2, 4, 8, ... months. Pick the one inside the 6% safe zone $0.707 lt.eq T \/ T^* lt.eq 1.414$.

  - Product A ($T^*_A approx 1.7$ months):
    - $T = 2$ months ⇒ $T \/ T^* = 2 / 1.7 = 1.17$ ⇒ inside the safe zone ⇒ choose *2 months*.

  - Product B ($T^*_B approx 2.8$ months):
    - $T = 2$ months ⇒ $T \/ T^* = 2 / 2.8 = 0.71$ ⇒ just above the lower bound 0.707 ✓
    - $T = 4$ months ⇒ $T \/ T^* = 4 / 2.8 = 1.43$ ⇒ above 1.414 ✗
    - Choose *2 months*.

  *4. Synchronization for free.*

  Powers of two nest: if A is ordered every 2 months and B every 4 months, B's orders always coincide with one of A's. Predictable rhythm, consolidated shipping.
]
