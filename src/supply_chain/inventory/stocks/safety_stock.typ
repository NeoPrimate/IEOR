#import "/lib/imports.typ": *
#show: formatting

#let cm(x) = text(fill: red, [$#x$])

The portion of inventory held *as a buffer against uncertainty* — in demand, in lead time, or both. Distinguished from cycle stock (which exists due to *batching*, not uncertainty).

$ "SS" = z dot sigma_"LD" $

where $sigma_"LD"$ is the standard deviation of *lead-time demand* and $z$ is the quantile of the standard normal at the desired service level.

== Why this form

The reorder point under (Q, r) is set such that the probability of running out during lead time equals the target stockout probability $alpha$:

$ P(D_L > r) = alpha $

For normally distributed lead-time demand $D_L tilde cal(N)(mu_L, sigma_"LD"^2)$:

$ r = mu_L + z sigma_"LD", quad z = Phi^(-1)(1 - alpha) $

Decompose:
- $mu_L$ = expected demand during lead time. Just covers the average — no safety.
- $z sigma_"LD"$ = the *safety stock*. Buffer above the average for the variability.

== Lead-time demand variance — the four cases

The form of $sigma_"LD"^2$ depends on which of demand and lead time are random. Combining via the law of total variance:

$ sigma_"LD"^2 = E[L] sigma_d^2 + (E[d])^2 sigma_L^2 $

where $sigma_d$ = std of per-period demand, $sigma_L$ = std of lead time, $E[d] = bar(d)$ and $E[L] = bar(L)$.

The four classical cases:

#table(
  columns: 3,
  inset: 0.7em,
  align: (left, left, left),
  [*Case*], [*$sigma_"LD"$*], [*Where the variance comes from*],
  [Constant $d$, constant $L$], [$0$], [No variance — basic EOQ regime, no safety stock needed],
  [Variable $d$, constant $L$], [$sqrt(L) dot sigma_d$], [Demand variability over $L$ periods],
  [Constant $d$, variable $L$], [$bar(d) dot sigma_L$], [Lead time variability scales the deterministic demand],
  [Variable $d$, variable $L$], [$sqrt(L sigma_d^2 + bar(d)^2 sigma_L^2)$], [Both contribute],
)

The combined formula reduces to the special cases when one variance is zero. The $bar(d)^2$ factor in the lead-time term often dominates when both are random — small percentage variance in lead time can produce *huge* swings in lead-time demand.

== Safety stock = $z sigma_"LD"$

Once you know $sigma_"LD"$, the safety stock formula is:

$ "SS" = z dot sigma_"LD" $

Choose $z$ from the desired service level (see [cycle_service_level.typ](../service_levels/cycle_service_level.typ) and [fill_rate.typ](../service_levels/fill_rate.typ)).

== Risk pooling reduces safety stock

When inventory is held centrally rather than distributed across $n$ independent locations:
- *Decentralized*: each location holds $z sigma_d sqrt(L)$, total = $n times z sigma_d sqrt(L)$.
- *Centralized*: one location holds $z sigma_d sqrt(L) sqrt(n)$ (because aggregate variance scales with $n$, std with $sqrt(n)$).

*Total safety stock falls by factor $sqrt(n)$* under centralization (assuming independent demands across locations). This is the *square-root law* of inventory aggregation.

#example[
  *Given* (compare four scenarios):
  - $bar(d) = 33$ units / day
  - $bar(L) = 14$ days
  - $z = 1.65$ (95% CSL)

  *Case 1 — constant demand, constant lead time*

  No variance. *Safety stock = 0*. Just hold $bar(d) bar(L) = 462$ units of cycle/pipeline; no buffer.

  *Case 2 — variable demand, constant lead time* ($sigma_d = 5$, $sigma_L = 0$)

  $ sigma_"LD" = sqrt(L) dot sigma_d = sqrt(14) dot 5 approx 18.7 $
  $ "SS" = z sigma_"LD" = 1.65 dot 18.7 approx cm(31) "units" $

  *Case 3 — constant demand, variable lead time* ($sigma_d = 0$, $sigma_L = 3$ days)

  $ sigma_"LD" = bar(d) dot sigma_L = 33 dot 3 = 99 $
  $ "SS" = 1.65 dot 99 approx cm(163) "units" $

  *Lead time variability dominates demand variability* in this case — same $z$, same demand, but 5× higher safety stock. Because $bar(d) = 33$ is much larger than $sigma_d = 5$, the multiplier $bar(d)$ amplifies $sigma_L$.

  *Case 4 — variable demand AND variable lead time*

  $
    sigma_"LD" = sqrt(L sigma_d^2 + bar(d)^2 sigma_L^2) = sqrt(14 dot 25 + 33^2 dot 9) = sqrt(350 + 9801) = sqrt(10151) approx 100.8
  $
  $ "SS" = 1.65 dot 100.8 approx cm(166) "units" $

  Combined std is *barely larger* than the lead-time-only case — when one source of variance dominates, the other contributes little. Reducing the bigger one (lead-time variability here) gives the biggest safety-stock savings.

  *Practical takeaway*

  - Reduce demand-side uncertainty → modest safety-stock savings.
  - Reduce *lead-time* uncertainty → often dramatic savings (because $bar(d)$ multiplies $sigma_L$).
  - Centralize inventory → safety stock shrinks by $sqrt(n)$ (risk pooling).
]
