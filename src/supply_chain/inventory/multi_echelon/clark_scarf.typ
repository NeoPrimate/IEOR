#import "/lib/imports.typ": *

The foundational result for *stochastic* multi-echelon inventory in serial systems (Clark & Scarf 1960). Shows that the multi-echelon problem decomposes into *independent single-echelon problems* — one per stage, each solved as a #link(<supply-chain-newsvendor-overview>)[newsvendor]-like base-stock problem with an *induced penalty cost*.

== Setup: serial system

Stages numbered $1$ (most upstream) to $N$ (most downstream = retailer). Customer demand $D$ hits stage $N$ only. Each stage:

- Holds inventory $I_i$
- Receives shipments from upstream stage $i-1$ with lead time $L_i$
- Ships to downstream stage $i+1$
- Stage $N$ also faces backorder cost $b$ per unit per period

Holding cost rates: $h_i$ at stage $i$ (assume $h_1 < h_2 < dots < h_N$ — inventory is more expensive downstream where it carries more added value).

== Echelon stock

Define *echelon stock* at stage $i$:

$
  E_i = I_i + sum_(j=i+1)^N I_j + "in-transit to" #h(0.2em) j > i
$

— what's at stage $i$ plus everything below it. Holding cost on echelon stock is incremental:

$
  h_i^E = h_i - h_(i-1)
$

(with $h_0 = 0$). This is the *marginal* holding cost as inventory moves from stage $i-1$ to stage $i$.

== Optimal policy: echelon base-stock

The optimal policy is *echelon base-stock*: at each review, stage $i$ orders to bring its echelon stock up to a target $S_i^*$.

The Clark-Scarf decomposition shows that $S_i^*$ at each stage solves a *single-stage newsvendor problem* with:

- *Demand*: lead-time demand $D_(L_i)$ from the most upstream (stage 1) feeding through
- *Underage cost*: an *induced penalty* $hat(b)_i$ that propagates upstream
- *Overage cost*: $h_i^E$ (incremental echelon holding cost)

== Induced penalty

The recursion (downstream → upstream):

$
  hat(b)_N = b #h(2em) "(retailer faces real backorder cost)"
$

$
  hat(b)_(i-1) = E[(D_(L_i) - "shortage at stage" i)^+] dot hat(b)_i + h_i^E dot text("...")
$

Formally: each stage's penalty depends on the optimal cost-to-go from downstream — a backward DP. The decomposition magic is that, despite this coupling, the *form* of each stage's optimal policy is base-stock with parameters depending only on local data + the induced penalty.

== Worked sketch (2-stage)

Stages: warehouse (1) → retailer (2). $L_1, L_2$ lead times. $h_1, h_2 = h_1^E + h_2^E$. Backorder cost $b$ at retailer.

*Retailer (stage 2)*: classical newsvendor with critical ratio $b / (b + h_2^E)$. Solve for $S_2^*$.

*Warehouse (stage 1)*: newsvendor with critical ratio $hat(b)_1 / (hat(b)_1 + h_1^E)$ where $hat(b)_1$ is the expected cost the warehouse imposes on the retailer when warehouse stockouts cause retailer delays.

== Why echelon stocks decouple the problem

If stage $i$'s order pulls from infinite supply (or upstream is always available), each stage is independent. Real life: upstream isn't always available. The induced penalty *charges* upstream for the downstream cost of its stockouts — capturing the coupling exactly.

== Limitations

- *Serial systems only*: pure chains, no branching
- *Stationary demand*: i.i.d. demand each period
- *Costly to compute* for many stages and long horizons

For general networks, see #link(<supply-chain-multi-echelon-graves-willems>)[Graves-Willems guaranteed-service].

== See also

- *#link(<supply-chain-multi-echelon-multi-echelon>)[Multi-Echelon]* — overview
- *#link(<supply-chain-multi-echelon-graves-willems>)[Graves-Willems]* — alternative for general networks
- *#link(<supply-chain-policies-base-stock>)[Base Stock Policy]*
- *#link(<supply-chain-newsvendor-overview>)[Newsvendor]*
