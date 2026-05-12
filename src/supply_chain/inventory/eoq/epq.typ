#import "/lib/imports.typ": *
#show: formatting

#let cm(x) = text(fill: red, [$#x$])

== EPQ (Economic Production Quantity)

Relax one dimension from basic EOQ: replenishment is *no longer instantaneous*. Instead of receiving $Q$ all at once, you produce at finite rate $p$ units/year while demand $d$ drains stock simultaneously.

=== Setup

New variables (beyond basic EOQ):
- $p$ = production rate (units/year), with $p > d$ (otherwise demand outpaces supply)
- $d$ = demand rate (units/year) — same as $D$ in basic EOQ; renamed here to emphasize it's a *rate*, not annual quantity

The inventory profile in each cycle:
- *Buildup phase* (length $Q / p$): produce at rate $p$, demand at rate $d$ — net accumulation rate $p - d$. Inventory rises to a peak $I_max$.
- *Drawdown phase* (length $I_max / d$): production stops, demand continues at rate $d$ — inventory drains from $I_max$ to 0.

Peak inventory reached at end of buildup:

$ I_max = (p - d) dot (Q / p) = Q dot (1 - d / p) $

The peak is *less than* $Q$ (the case for basic EOQ where $p = infinity$) because some units are consumed *during* production.

Average on-hand inventory (triangle, height $I_max$):

$ macron(I) = I_max / 2 = Q / 2 dot cm((1 - d / p)) $

The factor $(1 - d/p) lt.eq 1$ shrinks the average vs basic EOQ.

=== Cost model

Total relevant cost (drop the constant $c d$ term):

$ "TRC"(Q) = S (d / Q) + h dot Q / 2 dot cm((1 - d / p)) $

Only the holding term changes from basic EOQ — multiplied by $(1 - d/p)$. As $p -> infinity$ (instant production), the factor $-> 1$ and we recover basic EOQ.

=== Derive $Q^*$

Same calculus as basic EOQ: differentiate, set to zero.

$ d / (d Q) "TRC" = -(S d) / Q^2 + h / 2 dot (1 - d / p) = 0 $
$ (S d) / Q^2 = h / 2 dot (1 - d / p) $
$ (Q^*)^2 = (2 S d) / (h (1 - d / p)) $

Take the square root and rewrite $1 - d/p = (p - d)/p$:

$ Q^* = sqrt((2 S d) / h) dot sqrt(p / (p - d)) $

The first factor is the *basic EOQ*; the second is a multiplier $> 1$ that grows the production batch when the production rate is close to demand (long buildup, little overlap with drawdown).

=== Final formulas

$
  Q^* = sqrt((2 S d) / h) dot sqrt(p / (p - d))
  quad
  T^* = Q^* / d
  quad
  "TRC"^* = sqrt(2 S d h) dot sqrt(1 - d / p)
$

Sanity check: as $p -> infinity$ (instantaneous), the multiplier $sqrt(p/(p-d)) -> 1$ and we recover basic EOQ exactly. As $p -> d^+$ (production barely keeps up), $Q^* -> infinity$ — you should run the line continuously.


#example[
  *Given* (shared EOQ params + a finite production rate):
  - Annual demand: $d = 12000$ units/year
  - Setup cost: $S$ = \$50 / setup
  - Holding cost: $h$ = \$2 / unit / year
  - Production rate: $p = 24000$ units/year (twice the demand rate)

  *Step 1 — multiplier from finite production*

  $ sqrt(p / (p - d)) = sqrt(cm(24000) / (cm(24000) - cm(12000))) = sqrt(2) approx 1.414 $

  *Step 2 — production batch size*

  $
    Q^* = sqrt((2 dot 50 dot 12000) / 2) dot sqrt(2) = sqrt(600000) dot sqrt(2) approx 774.6 dot 1.414 approx 1095 "units"
  $

  *Step 3 — peak inventory and cycle*

  $ I_max = Q^* (1 - d / p) = 1095 (1 - 0.5) approx 548 "units" $
  $ T^* = Q^* / d = 1095 / 12000 approx 0.091 "years" approx 33 "days" $

  Of $T^*$, the buildup takes $Q^* / p = 1095 / 24000 approx 17$ days; drawdown takes the remaining $approx 16$ days.

  *Total cost*:

  $ "TRC"^* = sqrt(2 dot 50 dot 12000 dot 2) dot sqrt(1 - 0.5) approx 1549 dot 0.707 approx 1095 "$/year" $

  *Compare to basic EOQ* on the same demand and setup costs:
  - Basic EOQ ($p = infinity$): $Q^* = 775$, $"TRC"^* approx$ \$1549
  - EPQ ($p = 2 d$): $Q^* = 1095$ (larger), $"TRC"^* approx$ \$1095 (29% lower)

  EPQ is cheaper because some units are consumed *during* production — average on-hand is lower than the basic EOQ assumes.
]
