#import "/lib/imports.typ": *
#show: formatting

= Stock Management <system_dynamics_stock_management>

The generic structure for inventory / stock control in #link(<system_dynamics_system_dynamics>)[system dynamics]: order based on *expected loss* + *inventory gap* + *supply-line gap*.

== The classical formula

$
  text("Order") = text("Expected loss") + (S^* - S) / tau_S + alpha (S L^* - S L) / tau_(S L)
$

where:
- $S$: current stock
- $S^*$: target stock
- $S L$: current supply line (on-order, not yet received)
- $S L^*$: target supply line
- $tau_S$: time to correct stock gap
- $tau_(S L)$: time to correct supply-line gap
- $alpha in [0, 1]$: *supply-line weighting* (how much you account for orders already placed)
- Expected loss: replacement for expected demand

== The supply-line neglect parameter

$alpha$ is critical:

- $alpha = 1$: fully account for on-order inventory → stable, no over-ordering
- $alpha = 0$: *ignore the supply line entirely* → over-order while waiting → oscillation

Sterman's beer-game experiments find $alpha approx 0.3$ on average — most subjects substantially neglect the supply line.

== Anchoring and adjustment

Generic decision-rule structure:

$
  text("Decision") = text("Anchor") + alpha dot (text("Cue") - text("Anchor"))
$

- *Anchor*: the default level (e.g., expected demand)
- *Cue*: corrective signal (e.g., inventory gap)
- $alpha$: partial-adjustment coefficient

This is the *anchoring-and-adjustment heuristic* (Tversky-Kahneman) operationalized as a formula. Captures bounded rationality.

== Why this generates bullwhip

The chain of reasoning that produces bullwhip:

1. Retailer sees demand spike → expected demand rises
2. Inventory gap grows → orders bigger (anchor + correction)
3. Supply-line neglect → keeps ordering even though previous orders are in transit
4. Wholesaler sees retailer's amplified orders → repeats the pattern
5. Manufacturer sees wholesaler's even more amplified orders → repeats

Each echelon amplifies the variance. The math: see #link(<system_dynamics_bullwhip_sd>)[Bullwhip in SD].

== Real-world example

A factory targets 100 units of inventory ($S^* = 100$). Currently has 60 ($S = 60$). On-order 50 units ($S L = 50$). Expected demand 20 units/period.

$
  text("Order") = 20 + (100 - 60)/4 + 0.3 dot (100 - 50)/4 = 20 + 10 + 3.75 = 33.75
$

Settings: $tau_S = tau_(S L) = 4$ periods, $alpha = 0.3$, $S L^* = 100$ (an order-of-magnitude approximation: target supply-line equal to target stock).

== See also

- *#link(<system_dynamics_feedback_loops>)[Feedback Loops]*
- *#link(<system_dynamics_smoothing>)[Smoothing]* — for expected demand
- *#link(<system_dynamics_bullwhip_sd>)[Bullwhip in SD]*
- *#link(<system_dynamics_beer_game>)[Beer Game]*
- *#link(<supply_chain_inventory_bullwhip_effect>)[Bullwhip Effect (Supply Chain)]*
