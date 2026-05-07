#import "/lib/imports.typ": *

#let cm(x) = text(fill: red, [$#x$])
#let rm(x) = text(fill: red, $cancel(#x)$)

== EOQ with planned backorders

Relax one dimension from basic EOQ: *excess demand* is no longer forbidden — stockouts are allowed at penalty rate $b$ per unit per year. Now there are *two* decisions: order quantity $Q$ and maximum backorder $B$.

=== Setup

New variables (beyond basic EOQ):
- $B$ = maximum backorder quantity (decision variable)
- $b$ = backorder penalty cost per unit per year

The inventory profile in each cycle:
- Receive $Q$ units, immediately fill the backlog $B$ — on-hand jumps to $Q - B$.
- On-hand drains at rate $D$ over time $(Q-B)/D$, hits zero, then accumulates backlog up to $B$ over time $B/D$, total cycle $T = Q / D$.

Two area integrals over a cycle, divided by the cycle length $T = Q / D$:
- *Average on-hand*: triangle of height $Q - B$, width $(Q-B)/D$ → $((Q-B)^2)/(2 D) divides T = (Q-B)^2/(2 Q)$
- *Average backlog*: triangle of height $B$, width $B/D$ → $B^2/(2 D) divides T = B^2/(2 Q)$

=== Cost model

Total relevant cost (drop the constant purchase-cost term):

$ "TRC"(Q, B) = S (D / Q) + h (Q - cm(B))^2 / (2 Q) + cm(b (B^2 / (2 Q))) $

Two changes from basic EOQ TRC, both highlighted in red: the holding term now sees $(Q - B)$ instead of $Q$ (less average on-hand), plus a new shortage term.

=== Derive $B^*$ first (FOC in $B$)

Holding $Q$ fixed, take $partial "TRC" \/ partial B$:

$ partial / (partial B) "TRC" = h dot 2(Q - B) cm((-1)) / (2 Q) + b dot 2 B / (2 Q) = -h(Q - B)/Q + b B / Q $

Set to zero, multiply by $Q$:

$ -h(Q - B) + b B = 0 $
$ -h Q + h B + b B = 0 $
$ B^* = (h Q) / (h + b) $

So the backlog is the share $h \/ (h + b)$ of the order quantity.

=== Derive $Q^*$ (FOC in $Q$, after substituting $B^*$)

Take $partial "TRC" \/ partial Q$ and set to zero (algebra for the holding term uses the product rule):

$ -(S D) / Q^2 + h(Q^2 - B^2) / (2 Q^2) - b B^2 / (2 Q^2) = 0 $

Multiply by $2 Q^2$:

$ -2 S D + h (Q^2 - B^2) - b B^2 = 0 $
$ h Q^2 - cm((h + b)) B^2 = 2 S D $

Substitute $B^* = h Q / (h + b)$ so $(h + b) (B^*)^2 = h^2 Q^2 / (h + b)$:

$ h Q^2 - h^2 Q^2 / (h + b) = 2 S D $
$ Q^2 dot h (h + b - h) / (h + b) = 2 S D $
$ Q^2 dot (h b) / (h + b) = 2 S D $
$ (Q^*)^2 = (2 S D) / h dot cm((h + b) / b) $

Take the square root:

$ Q^* = sqrt((2 S D) / h) dot sqrt((h + b) / b) $

The first factor is the *basic EOQ*; the second is a multiplier $> 1$ that grows the order when backorders are cheap (small $b$).

=== Final formulas

$
  Q^* = sqrt((2 S D) / h) dot sqrt((h + b) / b)
  quad
  B^* = sqrt((2 S D h) / (b (h + b)))
  quad
  "TRC"^* = sqrt(2 S D h) dot sqrt(b / (h + b))
$

Sanity check: as $b -> infinity$ (backorders prohibitively expensive), the multiplier $sqrt((h+b)/b) -> 1$ and $B^* -> 0$ — recovers basic EOQ. As $b -> 0$ (backorders are free), $Q^* -> infinity$ and $"TRC"^* -> 0$.


#example[
  *Given* (shared EOQ params + a backorder penalty):
  - Annual demand: $D = 12000$ units/year
  - Order cost: $S$ = \$50 / order
  - Holding cost: $h$ = \$2 / unit / year
  - Backorder penalty: $b$ = \$8 / unit / year

  *Step 1 — backlog share*

  $ B^* = (h Q^*) / (h + b) = (cm(2)) / (cm(2) + cm(8)) Q^* = 0.2 Q^* $

  So the optimal backlog is 20% of the order quantity.

  *Step 2 — order quantity*

  $
    Q^* = sqrt((2 dot 50 dot 12000) / 2) dot sqrt((2 + 8) / 8) = sqrt(600000) dot sqrt(1.25) approx 774.6 dot 1.118 approx 866 "units"
  $

  *Step 3 — backlog and cost*

  $ B^* = 0.2 dot 866 approx 173 "units" $
  $ "TRC"^* = sqrt(2 dot 50 dot 12000 dot 2) dot sqrt(8 / 10) approx 1549 dot 0.894 approx 1386 "$/year" $

  *Compare to basic EOQ* on the same inputs:
  - Basic EOQ: $Q^* = 775$, $"TRC"^* approx$ \$1549
  - With backorders: $Q^* = 866$ (larger), $B^* = 173$, $"TRC"^* approx$ \$1386 (10% lower)

  Allowing planned backorders is worthwhile here because $b$ is only $4 times h$ — backorders cost a bit more than holding but not so much that we want zero backlog.
]
