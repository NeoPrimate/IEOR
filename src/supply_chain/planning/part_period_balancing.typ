#import "/lib/imports.typ": *

A lot-sizing heuristic (DeMatteis, 1968) based on the *EOQ balance condition*: at the EOQ optimum, ordering cost equals holding cost. Replicate this for time-varying demand.

== EOQ balance recap

For stationary demand:
- Setup cost per cycle: $K$
- Holding cost per cycle: $h Q / 2 dot T_("cycle")$

EOQ optimality: these are equal. The Part-Period Balancing analog: equate setup cost to *part-periods* (cumulative holding cost).

== Algorithm

*Economic part-period* (EPP):
$
  "EPP" = K / h
$

— the number of unit-periods that would generate holding cost equal to one setup. (One unit held for one period contributes $h$ of holding cost; total holding cost on EPP unit-periods is $h dot "EPP" = K$.)

For an order starting in period $t$ covering $k$ periods:

$
  "Part-periods"(k) = sum_(j=1)^(k-1) j d_(t+j)
$

Extend $k$ until part-periods approaches but doesn't exceed EPP. Stop at the $k$ where:

$
  "Part-periods"(k+1) > "EPP" #h(1em) "but" #h(0.5em) "Part-periods"(k) <= "EPP"
$

== Worked example

$d = (60, 100, 80, 50, 40, 70)$, $K = 100$, $h = 1$. $"EPP" = 100/1 = 100$.

*Start period 1*:
- Part-periods after $k=1$: 0
- After $k=2$: $1 dot 100 = 100$ ← right at EPP, stop
- (If we went to $k=3$: $100 + 2 dot 80 = 260$, way past.)

Order covers 2 periods.

*Start period 3*:
- Part-periods after $k=2$: $1 dot 50 = 50$ — below EPP
- After $k=3$: $50 + 2 dot 40 = 130$ — past EPP, stop

Take $k=2$ (130 vs 50 — closer to 100? 130 vs 50: $|130 - 100| = 30, |50 - 100| = 50$. Take $k=3$.). Note: rules differ; some variants pick "closest" rather than "last not exceeding".

*Start period 6*: only one period left. Order covers 1 period.

(Worked answer depends on tie-breaking rule.)

== Variants

- *Standard PPB*: stop at first $k$ where part-periods exceed EPP
- *Look-ahead PPB*: include the contribution of period $t + k$ before deciding
- *Modified PPB*: minimize $|"Part-periods" - "EPP"|$

== Quality

Generally within 5–10% of Wagner-Whitin optimum. Slightly worse than Silver-Meal or LUC in benchmarks, but conceptually simpler — directly mimics EOQ's balance principle.

== Why it sometimes wins

When demand patterns are *close to stationary*, PPB hugs the EOQ-like balance more tightly than the period-based or unit-based alternatives.

== See also

- *#link(<supply-chain-planning-silver-meal>)[Silver-Meal]* — period-based
- *#link(<supply-chain-planning-least-unit-cost>)[Least Unit Cost]* — unit-based
- *#link(<supply-chain-eoq-wagner-whitin>)[Wagner-Whitin]* — optimal
- *#link(<supply-chain-eoq-eoq>)[EOQ]* — the balance principle PPB emulates
