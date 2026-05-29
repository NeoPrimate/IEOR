#import "/lib/imports.typ": *
#show: formatting

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

== Penalty-function recursion

#emph[For this construction, index stages $1$ = downstream (demand-facing) to $n$ = upstream (vendor) — the reverse of the setup above.]

Consider a serial system with $n$ stages, where stage $1$ faces stochastic customer demand and each is replenished from stage $j + 1$ with deterministic lead time $L_j$:

#let start-x = 0
#let start-y = 0
#let spacing = 1
#std.layout(size => context {
  let diagram-content = fletcher.diagram(
    node-corner-radius: 4pt,
    node-fill: luma(97%),
    node-outset: 1em,
    node-inset: 1em,
    spacing: (5.5em, 2.8em),
    node((start-x + 0*spacing, start-y), [Vendor], name: <vendor>),
    node((start-x + 1*spacing, start-y), [$S_n$ \ $h_n$], name: <sn>),
    node((start-x + 2*spacing, start-y), $dots$, name: <dots>),
    node((start-x + 3*spacing, start-y), [$S_2$ \ $h_2$], name: <s2>),
    node((start-x + 4*spacing, start-y), [$S_1$ \ $h_1$], name: <s1>),
    node((start-x + 5*spacing, start-y), [Demand \ $D, p$], name: <demand>),
    edge(<vendor>, <sn>, "-|>", label: $L_n$),
    edge(<sn>, <dots>, "-|>", label: $L_(n-1)$),
    edge(<dots>, <s2>, "-|>", label: $L_2$),
    edge(<s2>, <s1>, "-|>", label: $L_1$),
    edge(<s1>, <demand>, "-|>"),
    edge(<s1>, <s2>, "-|>", label: $G_1$, dash: "dashed", bend: 30deg, stroke: rgb("#c0613a")),
    edge(<s2>, <dots>, "-|>", label: $G_2$, dash: "dashed", bend: 30deg, stroke: rgb("#c0613a")),
    edge(<dots>, <sn>, "-|>", label: $G_(n-1)$, dash: "dashed", bend: 30deg, stroke: rgb("#c0613a")),
    node((start-x + 4*spacing, start-y + 0.5), [Echelon 1], stroke: none, fill: none, name: <lbl1>),
    node((start-x + 3*spacing, start-y + 0.9), [Echelon 2], stroke: none, fill: none, name: <lbl2>),
    node((start-x + 1*spacing, start-y + 1.3), [Echelon $n$], stroke: none, fill: none, name: <lbln>),
    node(
      enclose: (<s1>, <lbl1>),
      stroke: gray + 0.5pt, fill: rgb(0, 0, 0, 4%),
      outset: 0.3em, name: <ech1>
    ),
    node(
      enclose: (<s2>, <s1>, <lbl1>, <lbl2>),
      stroke: gray + 0.5pt, fill: rgb(0, 0, 0, 4%),
      outset: 0.7em, name: <ech2>
    ),
    node(
      enclose: (<sn>, <dots>, <s2>, <s1>, <lbl1>, <lbl2>, <lbln>),
      stroke: gray + 0.5pt, fill: rgb(0, 0, 0, 4%),
      outset: 1.1em, name: <echn>
    ),
  )
  let diagram-width = measure(diagram-content).width
  let available-width = size.width
  if diagram-width > available-width {
    let factor = (available-width / diagram-width) * 100%
    scale(x: factor, y: factor, reflow: true, diagram-content)
  } else {
    diagram-content
  }
})

Solve stages $1 arrow 2 arrow n$. Each stage $j$ does three things:
- receives the penalty function from below
- solves its own newsvendor balance
- produces a new penalty function to pass up

*Base case (stage 1)*. No stage below it, so $G_0 = 0$. Stage 1's expected cost as a function of its echelon level $y$:

$
  C_1 (y) = h_1 EE[(y - D_(L_1))^+] + p EE[(D_(L_1) - y)^+]
$

where $D_(L_1)$ is demand over the lead-time window. This is convex; its minimizer is the fractile:

$
  S_1 = F_(L_1)^(-1) (p / (p + h_1))
$

*Inductive step (stage $j$)*. Stage $j$ has received $G_(j-1)$ from below. Its cost combines its own echelon holding with the penalty it inflicts downstream when it can't fully supply:

$
  C_j (y) = h_j EE[(y - D_(L_j))^+] + EE[G_(j-1) (y - D_(L_j))]
$

Minimize over $y$ to get $S_j = arg min_y C_j (y)$.

*Produce the penalty to pass up*. The clamp-and-floor operation:

$
  G_j (x) = C_j (min(x, S_j)) - C_j (S_j)
$

Zero when $x gt.eq S_j$ (stage $j$ isn't constrained), positive and rising as $x$ drops below $S_j$. Hand $G_j$ to stage $j + 1$.

#example([3-stage serial system])[
#std.layout(size => context {
  let diagram-content = fletcher.diagram(
    node-corner-radius: 4pt,
    node-fill: luma(97%),
    node-outset: 1em,
    node-inset: 1em,
    spacing: (6.5em, 2.8em),
    node((start-x + 0*spacing, start-y), [Vendor], name: <vendor>),
    node((start-x + 1*spacing, start-y), [$S_3 = 33.15$ \ $h_3 = 1$], name: <s3>),
    node((start-x + 2*spacing, start-y), [$S_2 = 22.86$ \ $h_2 = 2$], name: <s2>),
    node((start-x + 3*spacing, start-y), [$S_1 = 23.63$ \ $h_1 = 3$], name: <s1>),
    node((start-x + 4*spacing, start-y), [Demand \ $D ~ cal(N)(10, 2)$ \ $p = 27$], name: <demand>),
    edge(<vendor>, <s3>, "-|>", label: $L_3 = 2$),
    edge(<s3>, <s2>, "-|>", label: $L_2 = 1$),
    edge(<s2>, <s1>, "-|>", label: $L_1 = 1$),
    edge(<s1>, <demand>, "-|>"),
    edge(<s1>, <s2>, "-|>", label: $G_1$, dash: "dashed", bend: 30deg, stroke: rgb("#c0613a")),
    edge(<s2>, <s3>, "-|>", label: $G_2$, dash: "dashed", bend: 30deg, stroke: rgb("#c0613a")),
    node((start-x + 3*spacing, start-y + 0.5), [Echelon 1], stroke: none, fill: none, name: <lbl1>),
    node((start-x + 2*spacing, start-y + 0.9), [Echelon 2], stroke: none, fill: none, name: <lbl2>),
    node((start-x + 1*spacing, start-y + 1.3), [Echelon 3], stroke: none, fill: none, name: <lbl3>),
    node(
      enclose: (<s1>, <lbl1>),
      stroke: gray + 0.5pt, fill: rgb(0, 0, 0, 4%),
      outset: 0.3em, name: <ech1>
    ),
    node(
      enclose: (<s2>, <s1>, <lbl1>, <lbl2>),
      stroke: gray + 0.5pt, fill: rgb(0, 0, 0, 4%),
      outset: 0.7em, name: <ech2>
    ),
    node(
      enclose: (<s3>, <s2>, <s1>, <lbl1>, <lbl2>, <lbl3>),
      stroke: gray + 0.5pt, fill: rgb(0, 0, 0, 4%),
      outset: 1.1em, name: <ech3>
    ),
  )
  let diagram-width = measure(diagram-content).width
  let available-width = size.width
  if diagram-width > available-width {
    let factor = (available-width / diagram-width) * 100%
    scale(x: factor, y: factor, reflow: true, diagram-content)
  } else {
    diagram-content
  }
})

*Stage 1.* Window $L_1 + 1 = 2$, fractile $27 / (27 + 3) = 0.9$, $z = 1.282$:

$
  S_1 = 10 (2) + 1.282 dot 2 sqrt(2) = 20 + 2.63 approx 23.63
$

*Stage 2.* Window $L_2 + 1 = 2$, fractile $27 / (27 + 3 + 2) = 27 / 32 = 0.844$, $z = 1.011$:

$
  S_2 = 20 + 1.011 dot 2 sqrt(2) = 20 + 2.86 approx 22.86
$

*Stage 3.* Window $L_3 + 1 = 3$, fractile $27 / (27 + 6) = 27 / 33 = 0.818$, $z = 0.908$:

$
  S_3 = 10 (3) + 0.908 dot 2 sqrt(3) = 30 + 3.25 approx 33.15
$

The local stock held at each stage is the echelon-difference: $S_3 - S_2$ at stage 3, $S_2 - S_1$ at stage 2, $S_1$ at stage 1.

The fractile formula $p \/ (p + sum_(i lt j) h_i)$ with window $L_j + 1$ is the exact stage-1 newsvendor and a standard approximation upstream. The *exact* Clark-Scarf $S_2, S_3$ come from minimizing $C_j (y) = h_j EE[(y - D_(L_j))^+] + EE[G_(j-1)(y - D_(L_j))]$ numerically, since $G_(j-1)$ isn't a clean newsvendor cost.
]

#code([])[
  ```py
  # pip install stockpyl
  from stockpyl.ssm_serial import optimize_base_stock_levels

  # Nodes indexed 1=downstream(demand-facing) ... 3=upstream(vendor-facing)
  S_star, C_star = optimize_base_stock_levels(
      num_nodes=3,
      echelon_holding_cost=[3, 2, 1],   # h_1, h_2, h_3
      stockout_cost=27,                 # p, charged at downstream node
      lead_time=[1, 1, 2],              # L_1, L_2, L_3 (into each stage)
      demand_mean=10,
      demand_standard_deviation=2,
  )
  print(S_star)   # exact echelon base-stock levels
  print(C_star)   # optimal expected cost
  ```
]

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
