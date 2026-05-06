== Policy dimensions

Stochastic-demand inventory policies sit at the intersection of *five* design choices. The choices made along these dimensions name the policy.

=== 1. Inventory review

- *Periodic* review (*R*-policies): inventory checked at regular intervals $R$. Orders are placed only at review points.
- *Continuous* review (*s*-policies): inventory monitored continuously. Orders are triggered immediately when the level falls below a threshold.

=== 2. Order quantity

- *Fixed* order quantity (*Q*): a predetermined, constant quantity is ordered each time (lot-for-lot replenishment).
- *Order-up-to* level (*S*): inventory replenished up to a pre-defined maximum $S$, adapting to the current stock gap.
- *Reorder-point shorthand* (*s*): the trigger level — used in both Q-style and S-style policies.

=== 3. Flexibility

- *Q*-policies: *rigid* — order size is always the same.
- *S*-policies: *responsive* — order size adapts to the actual inventory level.

=== 4. Lead time

- *Constant*: time between placing an order and receiving it is fixed.
- *Variable*: lead time fluctuates, requiring extra safety stock (see [stocks/safety_stock.typ](../stocks/safety_stock.typ)).

=== 5. Demand

- *Deterministic*: known and constant — yields the EOQ family.
- *Stochastic*: random — yields the policies in this section.

=== Policy comparison table

#table(
  columns: 4,
  inset: 1em,
  align: horizon,
  [*Policy*], [*Review type*], [*Trigger*], [*Order size*],
  [$(bold(s), bold(Q))$ — see [q_r.typ](q_r.typ)], [Continuous], [Inventory $lt.eq bold(s)$], [Fixed batch $bold(Q)$],
  [$(bold(s), bold(S))$ — see [s_S.typ](s_S.typ)], [Continuous], [Inventory $lt.eq bold(s)$], [Order-up-to $bold(S)$],
  [$(bold(n) bold(Q), bold(r))$ — see [nQ_r.typ](nQ_r.typ)], [Continuous], [Inventory $lt.eq bold(r)$], [Smallest $n bold(Q)$ above $bold(r)$],
  [$(bold(S) - 1, bold(S))$ — see [base_stock.typ](base_stock.typ)], [Continuous], [Every consumption], [One unit (one-for-one)],
  [$(bold(R), bold(S))$ — see [R_S.typ](R_S.typ)], [Periodic (every $bold(R)$)], [Always at review], [Order-up-to $bold(S)$],
  [$(bold(R), bold(s), bold(S))$ — see [R_s_S.typ](R_s_S.typ)], [Periodic (every $bold(R)$)], [If inventory $lt.eq bold(s)$ at review], [Order-up-to $bold(S)$],
  [$(bold(R), bold(n) bold(Q), bold(s))$ — see [R_nQ_s.typ](R_nQ_s.typ)], [Periodic (every $bold(R)$)], [If inventory $lt.eq bold(s)$ at review], [Smallest $n bold(Q)$ above $bold(s)$],
)

A policy is named by listing its parameters in sorted order: review interval $R$ (if periodic), reorder point $s$ or $r$, target level $S$, fixed quantity $Q$, with $n$ for integer multipliers.

The *(s, Q)* policy is also widely written *(Q, r)* — same thing, different naming convention. Likewise *(R, s)* is a *family* (specifies trigger but not order rule); concrete instances are *(R, s, Q)* and *(R, s, S)*.
