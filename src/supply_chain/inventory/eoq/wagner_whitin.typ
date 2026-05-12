#import "/lib/imports.typ": *
#show: formatting

#let cm(x) = text(fill: red, [$#x$])

== Wagner-Whitin (finite horizon, time-varying demand)

Relax two dimensions from basic EOQ at once: *planning horizon* is now finite, and *demand* is no longer constant — it varies period by period (still known and deterministic). No closed-form $Q^*$; the answer is a *schedule* of when to order, found by dynamic programming.

=== Setup

- Periods $t = 1, 2, dots, T$ (e.g., months in a finite production plan).
- Known demand $d_t$ in each period.
- Order cost $S$ per order placed (independent of size).
- Holding cost $h$ per unit carried *one period forward*.
- Decision: in which periods to place orders, and how much each order covers.

=== Zero-inventory ordering (ZIO) property

*Claim*: In an optimal Wagner-Whitin schedule, an order is placed only when starting inventory is zero.

*Proof sketch*: If you start a period with leftover stock and then order more, you could have ordered less the previous time and placed the same total order one period later — saving holding cost without changing the order count. So orders always coincide with the inventory hitting zero.

*Consequence*: each order covers a *consecutive block* of periods $[j, k]$ (for some $j lt.eq k$). The decision space collapses from "how much in each period" to "which blocks to use" — a much smaller problem solvable by DP.

=== Cost of a single order block $[j, k]$

If we order in period $j$ to cover demands $d_j, d_(j+1), dots, d_k$:
- *Order cost*: $S$ (one order).
- *Holding cost*: each unit consumed in period $t$ ($j lt.eq t lt.eq k$) sat in inventory for $t - j$ periods. Total holding for the block:

$ "Hold"(j, k) = h sum_(t = j)^k (t - j) d_t $

Block cost:

$ "Cost"(j, k) = S + h sum_(t = j)^k (t - j) d_t $

=== DP recursion

Let $F(t)$ = minimum cost to cover demand for periods $1, dots, t$. Boundary: $F(0) = 0$.

For each $t$, the last order block ends at $t$ and starts at some $j in {1, dots, t}$:

$ F(t) = min_(j = 1)^t [F(j - 1) + "Cost"(j, t)] $

Solve forward: $F(1), F(2), dots, F(T)$. Track the argmin $j^*(t)$ at each step to reconstruct the schedule.

=== Algorithm

1. Compute "Cost$(j, t)$" for all pairs $j lt.eq t$.
2. Forward pass: for each $t$, compute $F(t)$ and store $j^*(t)$.
3. Backtrack from $T$: order in $j^*(T)$ covering $[j^*(T), T]$, then recurse on $F(j^*(T) - 1)$.

Complexity: $O(T^2)$ in the number of periods.


#example[
  *Given* (small 4-period example):
  - 4 periods with demands $d = (10, 20, 5, 15)$
  - Order cost: $S$ = \$50 / order
  - Holding cost: $h$ = \$1 / unit / period

  *Step 1 — block costs*

  $"Cost"(j, t) = S + h sum_(s = j)^t (s - j) d_s$:

  #table(
    columns: 5,
    inset: 0.6em,
    align: center,
    [*$j arrow.b$ \\ $t arrow.r$*], [1], [2], [3], [4],
    [1], [50], [50 + 20 = 70], [70 + 10 = 80], [80 + 45 = 125],
    [2], [—], [50], [50 + 5 = 55], [55 + 30 = 85],
    [3], [—], [—], [50], [50 + 15 = 65],
    [4], [—], [—], [—], [50],
  )

  Each cell is the cost of one order placed in period $j$ that covers demand through period $t$.

  *Step 2 — DP forward pass*

  $F(0) = 0$.

  $F(1) = F(0) + "Cost"(1, 1) = 0 + 50 = bold(50)$. ($j^*(1) = 1$)

  $F(2) = min cases(
    F(0) + "Cost"(1, 2) = 0 + 70 = 70,
    F(1) + "Cost"(2, 2) = 50 + 50 = 100,
  ) = bold(70)$. ($j^*(2) = 1$)

  $F(3) = min cases(
    F(0) + "Cost"(1, 3) = 80,
    F(1) + "Cost"(2, 3) = 50 + 55 = 105,
    F(2) + "Cost"(3, 3) = 70 + 50 = 120,
  ) = bold(80)$. ($j^*(3) = 1$)

  $F(4) = min cases(
    F(0) + "Cost"(1, 4) = 125,
    F(1) + "Cost"(2, 4) = 50 + 85 = 135,
    F(2) + "Cost"(3, 4) = 70 + 65 = 135,
    F(3) + "Cost"(4, 4) = 80 + 50 = 130,
  ) = bold(125)$. ($j^*(4) = 1$)

  *Step 3 — reconstruct schedule*

  $j^*(4) = 1$ → order in period 1, covers periods 1–4.
  Total cost = $cm(125)$.

  *Step 4 — compare to basic EOQ on the average demand*

  Total demand $= 10 + 20 + 5 + 15 = 50$ over 4 periods → average $D = 12.5$ per period (or 50/year if $T = 4$ months $= 1\/3$ year, $D = 150$/year). EOQ would give a single $Q^*$ and a stationary cycle — but this problem's demand is *not* stationary (period 4 is 3× period 3), so a stationary order cycle wastes either order cost or holding cost.

  Wagner-Whitin's answer (one big order in period 1) is *cheaper than any stationary EOQ schedule* because it adapts to the lumpy demand profile.

  This is the value of dropping the "infinite horizon, stationary demand" assumption: when demand has structure, the optimal policy reflects that structure, not a one-size-fits-all $Q^*$.
]
