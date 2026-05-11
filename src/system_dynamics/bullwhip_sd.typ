#import "/lib/imports.typ": *

The *quantitative* analysis of supply-chain order amplification, from the system-dynamics perspective. Closed-form result by Chen, Drezner, Ryan, Simchi-Levi (2000) for the *order-up-to* (OUT) policy with AR(1) demand.

== Chen-Drezner-Ryan-Simchi-Levi formula

For demand $D_t$ following an AR(1) process and an OUT policy with smoothing parameter $p$ and lead time $L$:

$
  ("Var"(text("orders"))) / ("Var"(text("demand"))) = 1 + (2 L) / p + (2 L^2) / p^2
$

The order variance is always *at least* the demand variance, and grows quadratically with $L/p$ ratio. For two-echelon chains, this multiplies stage by stage.

== Key insights

- *Lead time matters most*: doubling $L$ roughly quadruples the bullwhip
- *Smoothing matters too*: longer smoothing ($p$) reduces bullwhip but adds delay
- *No exact balance*: even optimal $p$ doesn't achieve $"Var"(O) = "Var"(D)$ — always amplified

== Sources of bullwhip (Lee-Padmanabhan-Whang 1997)

Four causes, each contributing variance amplification:

1. *Demand signal processing*: each echelon uses smoothed orders (not actual demand) — like the Chen-DRSL formula
2. *Order batching*: large infrequent orders smooth retailer's demand into spikes upstream
3. *Price fluctuations*: forward-buying during promotions creates spikes
4. *Rationing & shortage gaming*: customers over-order during shortages, creating ghost demand

Each cause is amplified by long lead times.

== SD beer-game replication

The Sterman beer-game model implements this dynamically:

- Each echelon's decision-rule (anchoring-adjustment with supply-line neglect) propagates variance
- Initial customer-demand step (small) gets amplified at each echelon
- Final factory order is 5-10x the customer-demand variance — matching experimental data

This is the *quantitative validation* of the SD bullwhip explanation.

== Mitigations

What reduces bullwhip:

- *Short lead times*: $L$ down → quadratic reduction
- *Information sharing*: upstream sees real customer demand, not amplified orders (CPFR, VMI)
- *Order smoothing*: don't fully correct gaps instantly
- *Stable pricing*: avoid promotion-induced spikes
- *Capacity allocation rules*: use historical demand, not current orders (avoid rationing game)

== See also

- *#link(<system-dynamics-stock-management>)[Stock Management]* — the decision rule
- *#link(<system-dynamics-beer-game>)[Beer Game]* — simulation
- *#link(<supply-chain-bullwhip-effect>)[Bullwhip Effect (Supply Chain)]* — broader view
- *#link(<system-dynamics-delays>)[Delays]* — what enables amplification
