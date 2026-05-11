#import "/lib/imports.typ": *

An extension of #link(<supply-chain-multi-echelon-metric>)[METRIC] (Graves 1985) that captures the *variance* of pipeline orders, not just the mean. The pipeline is modeled as *Negative Binomial* instead of Poisson — same mean, larger variance, more realistic for low-stock scenarios.

== Why METRIC under-estimates backorders

METRIC assumes depot resupply time is deterministic and that the resulting *order pipeline is Poisson*. But when the depot occasionally stocks out, downstream waiting times are *random*, inflating pipeline variance.

If true variance $> $ Poisson variance ($= $ mean), the *real* probability of large pipelines is higher than Poisson predicts → real backorders are higher.

== Negative Binomial pipeline

VARI-METRIC fits the pipeline-order distribution as Negative Binomial with mean $rho$ and variance $sigma^2 > rho$:

$
  P("pipeline" = x) = binom(x + r - 1, x) (1 - p)^x p^r
$

where $r, p$ are chosen to match the *observed (or computed) mean and variance*:

$
  rho = (1 - p) r / p, #h(2em) sigma^2 = (1 - p) r / p^2 = rho / p
$

Solve for $(r, p)$ given target $(rho, sigma^2)$.

== Computing the variance

Variance of orders at base $j$:

$
  sigma_j^2 = lambda_j E[L_j] + lambda_j^2 "Var"(L_j)
$

— two contributions:
1. *Demand variance* during a mean-length lead time (Poisson contribution, $= lambda E[L]$)
2. *Lead-time variance* itself (when waiting at the depot)

For the depot pipeline (single location aggregating multiple bases), use law of total variance:

$
  "Var"("pipeline") = E["pipeline" #h(0.2em) | #h(0.2em) "depot stockout state"] + "Var"(...)
$

(Exact formulas are detailed; the point is that variance is *not* equal to the mean.)

== Expected backorders with NB pipeline

$
  E[B_j (S_j)] = sum_(x = S_j + 1)^infinity (x - S_j) #h(0.2em) P("pipeline" = x)
$

— same form as METRIC, just with the NB instead of Poisson distribution for pipeline orders.

== Practical impact

For low-stock items with appreciable depot-side delay, VARI-METRIC predictions are 20–50% more pessimistic than METRIC — and they match empirical data much better.

The optimization (marginal analysis on the budget vs total backorders) is the same algorithm; only the backorder calculation differs.

== When METRIC is "good enough" vs VARI-METRIC

- High stock levels (low backorder probability) → METRIC is close
- Low stock / tight budget / many bases → VARI-METRIC corrects substantial under-counting

== See also

- *#link(<supply-chain-multi-echelon-metric>)[METRIC]* — Poisson-pipeline original
- *#link(<supply-chain-multi-echelon-multi-echelon>)[Multi-Echelon overview]*
- *#link(<supply-chain-multi-echelon-stochastic-service>)[Stochastic-service models]*
