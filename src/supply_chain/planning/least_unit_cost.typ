#import "/lib/imports.typ": *

A lot-sizing heuristic similar to #link(<supply-chain-planning-silver-meal>)[Silver-Meal], but minimizing *cost per unit produced* instead of *cost per period covered*.

== Algorithm

For an order starting in period $t$ covering $k$ periods:

$
  C_("LUC")(k) = (K + h sum_(j=1)^(k-1) j d_(t+j)) / (sum_(j=0)^(k-1) d_(t+j))
$

Numerator: total setup + holding cost.
Denominator: total units in the order.

Extend $k$ while $C_("LUC")(k)$ decreases. Stop when it increases. Order covers $k$ periods.

== Compared to Silver-Meal

- *Silver-Meal*: minimize cost per *time* period
- *LUC*: minimize cost per *unit*

When demand is uniform, the two give similar / identical answers. When demand varies, they diverge:

- *Spiky demand peaks*: LUC tends to order bigger batches (drives down per-unit cost via fixed-cost amortization)
- *Smoother demand*: Silver-Meal tends to order more frequently

Neither is strictly better. Both are heuristics, both within ~5% of #link(<supply-chain-eoq-wagner-whitin>)[Wagner-Whitin] optimum on typical instances.

== Worked example

Same data as Silver-Meal: $d = (60, 100, 80, 50, 40, 70)$, $K = 100$, $h = 1$.

*Start period 1*:
- $C_("LUC")(1) = 100/60 = 1.67$
- $C_("LUC")(2) = (100 + 100)/(60 + 100) = 200/160 = 1.25$ ← decreasing
- $C_("LUC")(3) = (100 + 100 + 160)/(60+100+80) = 360/240 = 1.50$ ← rose, stop. Order 1 covers 2 periods.

(Same answer as Silver-Meal in this case.)

== When LUC favors larger orders

If subsequent demand is high (say $d_(t+1) = 1000$), Silver-Meal's *per-period* cost increases fast (high holding cost on big inventory), but LUC's *per-unit* cost may still drop (fixed cost spread over more units).

So LUC tends to *bundle* into larger orders when downstream demand is high.

== See also

- *#link(<supply-chain-planning-silver-meal>)[Silver-Meal]* — sister heuristic
- *#link(<supply-chain-planning-part-period-balancing>)[Part-Period Balancing]*
- *#link(<supply-chain-eoq-wagner-whitin>)[Wagner-Whitin]* — optimal
- *#link(<supply-chain-eoq-eoq>)[EOQ]* — stationary-demand analog
