#import "/lib/imports.typ": *

*Multi-Echelon Technique for Recoverable Item Control* (Sherbrooke 1968). A closed-form model for spare-parts networks with *Poisson demand* and *one-for-one (S - 1, S) base-stock policy*.

The original was developed for US Air Force repairable items — engines, avionics, hydraulics. The model is now standard for any service-parts network: defense, aerospace, semiconductors, medical devices.

== Setup

A *two-echelon* network:
- One *depot* (central repair facility)
- $J$ *bases* (forward sites consuming and returning parts)

At each base $j$:
- *Poisson* demand at rate $lambda_j$
- One-for-one policy: maintain inventory level $S_j$; every demand triggers a replenishment order to the depot

Failed parts go to the depot for repair (mean repair time $T_("depot")$), then redistributed.

== Palm's theorem (the key fact)

If demand is Poisson and lead times are independent, the *number of orders in the replenishment pipeline* at any moment is Poisson-distributed with mean = (demand rate) × (mean lead time).

For base $j$:

$
  "Pipeline orders at base" j ~ "Poisson"(lambda_j #h(0.2em) E[L_j])
$

where $E[L_j]$ is the *expected* lead time the base sees — which depends on whether the depot has stock or the base must wait.

== Expected backorders

For Poisson pipeline with mean $rho_j$ and base stock level $S_j$:

$
  E[B_j (S_j)] = sum_(x = S_j + 1)^infinity (x - S_j) #h(0.2em) e^(-rho_j) #h(0.2em) rho_j^x / x!
$

— the expected shortfall above $S_j$ in a Poisson distribution. Tables exist; computer-tractable to evaluate.

== Effective lead time

If the depot is stocked, base $j$ gets resupplied in standard shipping time $T_j^("ship")$. If the depot is stocked-out, the base waits for the depot's repair pipeline.

$
  E[L_j] = T_j^("ship") + E[W_j^("depot")]
$

where $E[W_j^("depot")]$ is the expected wait at the depot, which depends on depot's stock $S_0$ and the *aggregate* demand $sum_j lambda_j$ hitting the depot.

== Optimization

Decision variables: $S_0$ (depot) and $S_j$ for each base.

Objective: minimize total backorders (or expected number of units down) subject to a *budget constraint*:

$
  min #h(0.5em) sum_j E[B_j (S_j)] #h(2em) "s.t." sum_j c_j S_j + c_0 S_0 <= "budget"
$

Solved by *marginal analysis*: at each step, add one unit of inventory at whichever stocking location gives the biggest reduction in expected backorders per dollar.

== VARI-METRIC

Sherbrooke's original METRIC approximates depot resupply time as deterministic. *VARI-METRIC* (Graves 1985) fixes this by modeling the depot pipeline as *Negative Binomial* — preserving both the mean *and the variance* of pipeline orders. Sometimes large efficiency gains. See #link(<supply-chain-multi-echelon-vari-metric>)[VARI-METRIC].

== Where it shows up

- *Military / aerospace logistics* — original application
- *Semiconductor fab spare parts* — single fab + multiple tools
- *Service parts networks* — automotive, industrial equipment
- *Computer / IT spares* — server / network gear

== Limitations

- *Poisson demand only* — assumes one-by-one ordering; doesn't handle bulk demand
- *Stationary* — no demand trends or seasonality
- *Two-echelon* — extensions exist for $> 2$ echelons (Multi-Indenture / Multi-Echelon)

== See also

- *#link(<supply-chain-multi-echelon-vari-metric>)[VARI-METRIC]* — variance-correction extension
- *#link(<supply-chain-multi-echelon-stochastic-service>)[Stochastic-service]* — generalization
- *#link(<statistics-probability-distributions-poisson>)[Poisson Distribution]*
- *#link(<supply-chain-policies-base-stock>)[Base Stock Policy]*
