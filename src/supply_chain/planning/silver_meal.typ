#import "/lib/imports.typ": *
#show: formatting

A lot-sizing heuristic for time-varying demand (Silver & Meal, 1973). Chooses order intervals to minimize *average cost per period* covered.

Easier than #link(<supply-chain-eoq-wagner-whitin>)[Wagner-Whitin] (which is DP-optimal) and often close in quality.

== Setup

Demand $d_t$ over $T$ periods. Setup cost $K$ per order, holding cost $h$ per unit per period.

== Algorithm

Start with a candidate order in period $t$ covering $k$ periods of demand. Average cost per period:

$
  C(k) = (K + h sum_(j=1)^(k-1) j d_(t+j)) / k
$

(Setup once + holding cost for demand carried $j$ periods.)

Extend $k$ as long as $C(k)$ decreases. Stop at first $k$ where $C(k+1) > C(k)$. Place an order in $t$ to cover $k$ periods. Start a new order in $t + k$. Repeat until all periods are covered.

== Worked example

Demand: $d = (60, 100, 80, 50, 40, 70)$, $K = 100$, $h = 1$.

*Start at period 1*:
- $C(1) = 100/1 = 100$
- $C(2) = (100 + 1 dot 100)/2 = 100$ ← tied
- $C(3) = (100 + 100 + 2 dot 80)/3 = 360/3 = 120$ ← rose, stop. Order in period 1 covers 2 periods (160 units).

*Start at period 3*:
- $C(1) = 100/1 = 100$
- $C(2) = (100 + 50)/2 = 75$ ← decreasing
- $C(3) = (100 + 50 + 80)/3 = 76.67$ ← rose. Order in period 3 covers 2 periods (130 units).

*Start at period 5*:
- $C(1) = 100$
- $C(2) = (100 + 70)/2 = 85$ ← decreasing
- ($t+2$ doesn't exist, $T = 6$). Order in period 5 covers 2 periods (110 units).

Three orders: period 1 (160), period 3 (130), period 5 (110). Total cost computable.

== Compared to alternatives

#table(
  columns: 3,
  align: (left, left, left),
  stroke: none,
  table.header([Heuristic], [Quality vs WW optimum], [Computational cost]),
  [Lot-for-lot], [worst; high setup cost], [trivial],
  [POQ / fixed-quantity (EOQ)], [moderate; ignores demand variation], [trivial],
  [#link(<supply-chain-planning-least-unit-cost>)[Least Unit Cost]], [usually within 5-10%], [$O(T^2)$],
  [*Silver-Meal*], [usually within 3-5%], [$O(T^2)$],
  [#link(<supply-chain-planning-part-period-balancing>)[Part-Period Balancing]], [usually within 5%], [$O(T^2)$],
  [#link(<supply-chain-eoq-wagner-whitin>)[Wagner-Whitin]], [optimal], [$O(T^2)$ DP],
)

Silver-Meal is fast and good. Wagner-Whitin is exact and not much slower; usually preferred when implementable.

== Limitations

- *Greedy* — no lookahead beyond current order
- *Can miss good solutions* by stopping too early
- *Failure mode*: when demand has long-running upticks, Silver-Meal may stop short of the truly optimal order span

== See also

- *#link(<supply-chain-planning-least-unit-cost>)[Least Unit Cost]*
- *#link(<supply-chain-planning-part-period-balancing>)[Part-Period Balancing]*
- *#link(<supply-chain-eoq-wagner-whitin>)[Wagner-Whitin]* — DP-optimal
- *#link(<supply-chain-planning-mrp>)[MRP]* — where lot-sizing fits
