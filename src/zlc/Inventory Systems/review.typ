#import "@local/tystats:0.1.0": norm, expon, poisson, uniform
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge

#let mc(content, color: red) = text(fill: color, content)

Q_new / Q_old = √(2D·4S/H) / √(2DS/H) = √4 = 2

So Q* doubles. TVC* = √(2DSH) has S in the same place, so it also multiplies by √4 = 2.

The general rule is: take the factor the parameter changed by, then apply the square root. If the parameter is in the numerator under the root, multiply by that. If it's in the denominator, divide by it.


if any input is off by a factor k, the penalty is ½(√k + 1/√k)


#line(length: 100%)

#[
  #set text(size: 7pt)
  #table(
    columns: 4,
    align: left + horizon,
    [], [*Definition*], [*EOQ*], [*EPQ*],
    [$ H $], [Annual holding cost per unit ($i$ = annual holding rate, $c$ = unit cost)],
    table.cell(
      colspan: 2,
      $
        i c
      $
    ),
    [$ "TVC"(Q) $], [Total annual variable cost (setup/ordering + holding)],
    [
      $
        S D / Q + H Q / 2
      $
    ],
    [
      $
        S D / Q + H Q / 2 mc((1 - D / P))
      $
    ],
    [$ "TC"(Q) $], [Total annual cost (purchase/production + TVC)],
    [
      $
        c D + S D / Q + H Q / 2
      $
    ],
    [
      $
        c D + S D / Q + H Q / 2 mc((1 - D / P))
      $
    ],
    [$ (dif "TVC") / (dif Q) $], [First-order condition that gives the optimal lot size $Q^*$],
    [
      $
        - (S D) / Q^2 + H / 2 = 0
      $
    ],
    [
      $
        - (S D) / Q^2 + H / 2 mc((1 - D / P)) = 0
      $
    ],
    [$ Q^* $], [Optimal lot size (minimizes TVC)],
    [
      $
        sqrt((2 D S) / H)
      $
    ],
    [
      $
        sqrt((2 D S) / (H mc((1 - D / P))))
      $
    ],
    [$ "TVC"(Q^*) $], [Minimum annual variable cost (at $Q^*$, ordering cost = holding cost)],
    [
      $
        sqrt(2 D S H)
      $
    ],
    [
      $
        sqrt(2 D S H mc((1 - D / P)))
      $
    ],
    [$ "TC"(Q^*) $], [Minimum total annual cost (purchase/production + $"TVC"(Q^*)$)],
    [
      $
        c D + sqrt(2 D S H)
      $
    ],
    [
      $
        c D + sqrt(2 D S H mc((1 - D / P)))
      $
    ],
    [$ I_max $], [Maximum inventory level in a cycle],
    [
      $
        Q
      $
    ],
    [
      $
        T_p (P - D) = Q (1 - D / P)
      $
    ],
    [$ macron(I) $], [Average inventory level],
    [
      $
        Q / 2
      $
    ],
    [
      $
        I_max / 2
      $
    ],
    [$ T_p $], [Production time (uptime): inventory builds up at rate $P - D$],
    [
      $
        0
      $
    ],
    [
      $
        Q / P
      $
    ],
    [$ T_d $], [Depletion time (downtime): no production, inventory falls at rate $D$],
    [
      $
        T = Q / D
      $
    ],
    [
      $
        I_max / D = Q / D (1 - D / P)
      $
    ],
    [$ T $], [Cycle length: time between consecutive orders or runs],
    [
      $
        Q / D
      $
    ],
    [
      $
        T_p + T_d = Q / D
      $
    ],
    [$ n $], [Number of orders or runs per year],
    table.cell(
      colspan: 2,
      $
        1 / T = D / Q
      $
    ),
    [$ T^* $], [Optimal cycle length: time between orders or runs at $Q^*$],
    [
      $
        Q^* / D = sqrt((2 S) / (H D))
      $
    ],
    [
      $
        Q^* / D = sqrt((2 S) / (D H mc((1 - D / P))))
      $
    ],
    [$ n^* $], [Optimal number of orders or runs per year],
    [
      $
        1 / T^* = sqrt((D H) / (2 S))
      $
    ],
    [
      $
        1 / T^* = sqrt((D H mc((1 - D / P))) / (2 S))
      $
    ],
    [$ rho $], [Utilization: fraction of each cycle spent producing. Requires $D < P$, otherwise EPQ is infeasible],
    [
      $
        0
      $
    ],
    [
      $
        D / P = T_p / T
      $
    ],
    [$ "ROP"_(L <= T) $], [Reorder point when the lead time is at most one cycle. On-hand stock equals inventory position, so you reorder when on-hand reaches $D L$. For EPQ this holds only if $L <= T_d$; otherwise on-hand is $(P - D)(T - L)$],
    table.cell(
      colspan: 2,
      $
        D L
      $
    ),
    [$ "ROP"_(L > T) $], [Reorder point when the lead time is longer than a cycle. $D L$ is still the trigger for inventory position (on-hand plus on-order), but $floor(L / T)$ orders are already in transit, so the on-hand trigger is lower],
    table.cell(
      colspan: 2,
      $
        D L - floor(L / T) Q = D L - floor((D L) / Q) Q
      $
    ),
    [
      Sensitivity \
      $ r $ 

    ], 
    [
      1. Calculate $Q^*$
      2. Another $Q$ is given or computed
      3. Compute ratio $r$
      4. $%$ cost (TVC) increase = $(r - 1) times 100$
    ], 
    table.cell(
      colspan: 2,
      $
        "TVC"(Q) / "TVC"(Q^*) = 1/2 (Q^* / Q + Q / Q^*)
      $
    ),
    
    [
      Power of 2
    ], 
    [
      1. Calculate interval $T$ (time between orders)
      2. Calculate range
      3. Check where $T^*$ falls
      4. Calculate cost ratio
      5. $%$ cost (TVC) increase = $(r - 1) times 100$
    ], 
    table.cell(
      colspan: 2,
      $
        T^* = Q^* / D \
        [T^* / sqrt(2), T^* sqrt(2)] \
        r = 1/2 (T^* / T + T / T^*) \
      $
    ),
    
  )
]


== Power of 2

1. Calculate interval $T^*$ (time between orders)

$
  T^* = Q^* / D
$

2. Calculate range

$
  [T^* / sqrt(2), T^* sqrt(2)]
$

3. Check where $T^*$ falls

#table(
  columns: 3,
  inset: (x: 1em, y: 0.75em),
  table.header([$k$], [$T = 2^k$], [In $[T^* / sqrt(2), T^* sqrt(2)]$?]),
  [0], [1], [no],
  [1], [2], [no],
  [2], [4], [no],
  [3], [8], [*yes*],
  [4], [16], [no],
)

4. Calculate cost ratio

$
  r = 1/2 (T^* / T + T / T^*)
$

5. $%$ cost (TVC) increase = $(r - 1) times 100$


= Quantity Discounts

- Break points: $q_0, q_1, dots,q_m$ ($q_0 = 0$ and $q_m = infinity$)
- If the order $Q$ is between $q_i$ and $q_(i+1)$, each unit (in the entire order) is obtained at a cost $C_i$
- $C_0 gt.eq C_1 gt.eq dots gt.eq C_(m-1)$

$
  "TVC"_i (Q) = D / Q S + Q / 2 h C_i + D C_i quad "for" q_i lt.eq Q lt q_(i+1)
$

1. Calculate the EOQ for the lowest price. If it is feasible, then stop. This is the optimal lot size. Calculate total variable cost (TVC) for this lot size
2. If the EOQ is not feasible, calculate the TVC for this price and the smallest quantity for that price
3. Calculate the EOQ for the next lowest price.  If it is feasible, stop and calculate the TVC for that quantity and price
4. Compare the TVC for Steps 2 and 3.  Choose the quantity corresponding to the lowest TVC
5. If the EOQ in Step 3 is not feasible, repeat Steps 2, 3, and 4 until a feasible EOQ is found

Starting from the lowest price, evaluate the EOQ for each $C_i$:

$
  Q_i = sqrt((2 D S) / (h C_i))
$

Case 1: $q_i lt.eq Q_i lt q_(i+1)$, then $Q_i$ is feasible and:

$
  "TVC"_i = D / Q_i S + Q_i / 2 h C_i + D C_i
$

Case 2: $Q_i lt q_i$, then choose $q_i$ and:

$
  "TVC"_i = D / q_i S + q_i / 2 h C_i + D C_i
$

Select $Q^*$ with lowest TVC

== Aggregation

- $m$ products
  - $D_i$: demand of product $i$
  - $C_i$: unit cost of product $i$
  - $h$: holding rate of product $i$
- S is the common order cost (paid once per order)
- $s_i$: product-specific order cost (paid each time product $i$ is included)
- $n$: number of orders per year

#let S = 2000
#let capacity = 3000

#let DA = 10000
#let DB = 4000
#let DC = 500

#let cA = 50
#let cB = 100
#let cC = 200

#let iA = 0.20
#let iB = 0.25
#let iC = 0.30

#let sA = 500
#let sB = 800
#let sC = 1200

#let SpA = S + sA
#let SpB = S + sB
#let SpC = S + sC



#let hA = iA * cA
#let hB = iB * cB
#let hC = iC * cC

#let EOQ(D, Sp, H) = calc.sqrt((2 * D * Sp) / H)
#let TVC(D, Sp, H, Q) = Sp * D / Q + H * Q / 2

$
  H_i = c_i i_i
$

*No Aggregation*


$
  S'_i = S + s_i
$

#let QA = EOQ(DA, SpA, hA)
#let QB = EOQ(DB, SpB, hB)
#let QC = EOQ(DC, SpC, hC)

$
  Q^*_i = sqrt((2 D_i S'_i) / H_i)
$

#let nA = DA / QA
#let nB = DB / QB
#let nC = DC / QC

$
  n^*_i = D_i / Q^*_i = sqrt((D_i H_i) / (2 S'_i))
$

#let TVC_no = TVC(DA, SpA, hA, QA) + TVC(DB, SpB, hB, QB) + TVC(DC, SpC, hC, QC)

$
  "TVC"_"no" = sum_i sqrt(2 D_i S'_i H_i)
$

*Aggregation*

#let Sp = S + sA + sB + sC

$
  S' = S + sum_i s_i
$

#let n_agg = calc.sqrt((DA * hA + DB * hB + DC * hC) / (2 * Sp))

$
  n^* = sqrt((sum_i D_i H_i) / (2 S'))
$

#let QA_agg = DA / n_agg
#let QB_agg = DB / n_agg
#let QC_agg = DC / n_agg

$
  Q^*_i = D_i / n^*
$

#let TVC_agg = n_agg * Sp + (hA * DA + hB * DB + hC * DC) / (2 * n_agg)

$
  "TVC"_"agg" = n^* S' + (sum_i (H_i D_i)) / (2 n^*) = sqrt(2 S' sum_i D_i H_i) = 2 n^* S'
$

$
  "Savings" = (1 - "TVC"_"agg" / "TVC"_"no") times 100 %
$

// ---- Compare ----

#let r(x, d: 2) = calc.round(x, digits: d)

#table(
  columns: 5,
  align: (left, right, right, right, right),
  table.header(
    [], table.cell(colspan: 2, align: center)[*No aggregation*],
        table.cell(colspan: 2, align: center)[*Complete aggregation*],
    [*Product*], [$n_i$], [$Q_i$], [$n^*$], [$Q_i$],
  ),
  [A], [#r(nA)], [#r(QA)], table.cell(rowspan: 3, align: horizon)[#r(n_agg, d: 3)], [#r(QA_agg)],
  [B], [#r(nB)], [#r(QB)], [#r(QB_agg)],
  [C], [#r(nC)], [#r(QC)], [#r(QC_agg)],
  table.hline(),
  [*TVC*], table.cell(colspan: 2)[#r(TVC_no)], table.cell(colspan: 2)[#r(TVC_agg)],
  [*Savings*], table.cell(colspan: 4, align: center)[#r(TVC_no - TVC_agg) (#r((1 - TVC_agg / TVC_no) * 100, d: 1)%)],
)

// ---- Capacity Check ----

#let load = QA_agg + QB_agg + QC_agg

#line(length: 100%)

= Newsvendor

- $D$: demand 
- $Q$: order quantity
- $p$: unit revenue 
- $c$: unit cost 
- $s$: salvage value per unit leftover
- $g$: goodwill cost per unit short

#let mu_D = 3192
#let sigma_D = 1181
#let p = 190
#let c = 110
#let s = 90
#let g = 0

#let cu = p - c + g
#let co = c - s

#let CR = cu / (cu + co)

#let z = norm.ppf(CR)

#let Q = mu_D + z * sigma_D

#[
  #set text(size: 7pt)
  #table(
    columns: 4,
    inset: 1em,
    [
      Standardize Q \
      $z$-statistic
    ],
    [
      First step for every measure below, for any Q. At $Q^*$, $z = z^*$
    ],
    [
      $
        z = (Q - mu_D) / sigma_D
      $
    ],
    [
    ```py
    z = (Q - mu_D) / sigma_D
    z = norm.cdf(Q, loc=mu_D, scale=sigma_D)
    ```
    ],
    [Optimal order quantity $Q^*$],
    [
      Maximizes expected profit: balances underage vs. overage cost
    ],
    [
      $
        c_u = p - c + g, quad c_o = c - s \
        "CR" = c_u / (c_u + c_o) \
        z^* = Phi^(-1)("CR")\
        Q^* = mu_D + z^* sigma_D
      $
    ],
   [
      ```py
      cu = p - c + g 
      co = c - s
      cr = cu / (cu + co)
      z = norm.ppf(cr)
      Q = mu_D + z * sigma_D
      ```
    ],
    [
      In-stock probability\ 
      Type I - service level
    ], 
    [
      Probability all demand is satisfied
    ], 
    [
      $
        Phi(z)
      $
    ],
    [
      ```py
      norm.cdf(z)
      ```
    ],

    [
      $Q$ for a target in-stock probability
    ],
    [

    ],
    [
      $
        Q = μ + Φ⁻¹(alpha) sigma
      $
    ],
    [
      ```py
      alpha = 0.99
      Q = mu_D + norm.ppf(alpha) * sigma
      ```
    ],

    [
      P(Stockout)
    ], 
    [
      Probability some demand is lost
    ], 
    [
      $
        P(D > Q) 
        &= 1 - F(Q) \
        &= 1 - Phi(z) \
      $
    ],
    [
      ```py
      norm.sf(z)
      ```
    ],

    [
      E[Lost] \
      E[Short]
      
    ], 
    [
      The expected number of units by which demand will exceed the order quantity
    ], 
    [
      $
        L(z) = phi(z) - z (1 - Phi(z)) \
        E["Short"] = sigma L
      $
    ],
    [
      ```py
      L = norm.pdf(z) - z * (1 - norm.cdf(z))
      E_short = sigma_D * L
      ```
    ], 
    [
      E[sales] 
    ], 
    [
      The expected number of units sold
    ],
    [
      $
        E["Sales"] 
        &= mu_D - E["Short"] \
        &= mu_D - sigma_D L(z)
      $
    ],
    [
      ```py
      E_sales = mu_D - E_short
      ```
    ], 
    [
      Fill rate \
      Type II - service level
    ], 
    [
      The fraction of demand that is filled
    ],
    [
      $
        E["Fillrate"] 
        &= E["Sales"] / mu_D \
        &= 1 - E["Short"] / mu_D
      $
    ],
    [
      ```py
      fill_rate = E_sales / mu_D
      fill_rate = 1 - E_short / mu_D
      ```
    ],
    [
      E[Leftover]
    ],
    [
      The expected number of units left over after demand is realized
    ],
    [
      $
        E["Leftover"] 
        &= Q - E["Sales"] \ 
        &= sigma_D (z + L(z))
      $
    ],
    [
      ```py
      E_leftover = Q - mu_D + E_short
      E_leftover = Q - E_sales
      ```
    ],
    [
      E[Profit]
    ],
    [
      Expected revenue + salvage - purchase cost - goodwill penalty
    ],
    [
      $
        E["Profit"] 
        &= p E["Sales"] \
        &+ s E["Leftover"] \
        &- c Q \
        &- g E["Short"] \
      $
    ],
    [
      ```py
      E_profit = p * E_sales + s * E_leftover - c * Q - g * E_short
      E_profit = (p - s) * E_sales - (c - s) * Q - g * E_short
      ```
    ],
  )
]


E[Fill]

E[InStock]

E[Stockout]



// #let inp = (fill: luma(235), stroke: none)
// #let key = (fill: rgb("#dbe8ff"), stroke: 0.6pt + rgb("#4a6fb5"))
// #let out = (fill: rgb("#e3f4e1"), stroke: 0.6pt + rgb("#3d8a3a"), inset: 1em)
// #let tint(c) = (stroke: c, fill: rgb(..c.components().slice(0,3), 5%), inset: 0.25em)

// #figure(
//   diagram(
//     spacing: (12mm, 9mm),
//     node-corner-radius: 3pt,
//     node-inset: 5pt,
//     edge-stroke: 0.6pt,

//     // inputs
//     node((0, 0), $p$, name: <p>),
//     node((0.5, 0), $g$, name: <g>),
//     node((1, 0), $c$, name: <c>),
//     node((1.5, 0), $s$, name: <s>),
//     node(enclose: (<p>, <c>, <s>, <g>), name: <inputs>, ..tint(teal)),
    
//     node((2, 0), $mu_D$, name: <mu>),
//     node((2.5, 0), $sigma_D$, name: <sigma>),
//     node(enclose: (<mu>, <sigma>), ..tint(teal)),

//     node((0.75, 2), 
//       [
//         $
//           c_o &= c - s \
//           c_u &= p - c + g \
//           "CR" &= c_u / (c_u + c_o)
//         $
//       ], name: <cr>, ..tint(teal)
//     ),

//     node((3.6, 2), [target $alpha$], name: <a>, ..inp),
//     node((2.5, 3), $z = Phi^(-1)(dot)$, name: <z>, ..key),

//     edge(<inputs>, <cr>, "-|>"),

//     node((5, 3), $Q = mu + z sigma$, name: <q>, ..out),
    
//     node((3.2, 4), $L(z) = phi(z) - z(1 - Phi(z))$, name: <L>),
//     node((5, 3), $E["Short"] = L sigma$, name: <q>, ..out),

//     // node((0.3, 4), $P("in") = Phi(z)$, name: <pin>, ..out),
//     // node((1.4, 5), $P("out") = 1 - Phi(z)$, name: <pout>, ..out),
//     node((3.2, 6), $E["Sales"] = mu - E["Short"]$, name: <sa>),
//     node((1.4, 7), $"Fillrate" = E["Sales"] / mu$, name: <fr>, ..out),
//     node((5, 7), $E["Leftover"] = Q - E["Sales"]$, name: <lo>),
//     node((3.2, 8), $E["Profit"] = p E["Sales"] + s E["Left"] - c Q - g E["Short"]$, name: <pr>, ..out),
    
//     node((3.2, 10), $P("Stockout") = 1 - c_u / (c_u + c_o) = c_o / (c_u + c_o)$, name: <pr>, ..out),

    

//     // edge(<ms>, <q>, "-|>"),
//     // edge(<z>, <q>, "-|>"),
//     // edge(<z>, <pin>, "-|>"),
//     // edge(<pin>, <pout>, "-|>"),
//     // edge(<z>, <L>, "-|>"),
//     // edge(<L>, <sh>, "-|>"),
//     // edge(<sh>, <sa>, "-|>"),
//     // edge(<sa>, <fr>, "-|>"),
//     // edge(<sa>, <lo>, "-|>"),
//     // edge(<q>, <lo>, "-|>"),
//     // edge(<sa>, <pr>, "-|>"),
//     // edge(<lo>, <pr>, "-|>"),
//     // edge(<sh>, <pr>, "-|>", bend: -40deg),
//     // edge(<q>, <pr>, "-|>", bend: 35deg),
//   ),
//   caption: [Newsvendor dependency graph (normal demand). Gray: inputs · blue: key steps · green: answers.],
// )

== Double Marginalization

#let box-node(pos, label, name) = node(
  pos, label,
  width: 25mm, height: 10mm,
  fill: gray.lighten(60%),
  stroke: 1pt + gray.darken(20%),
  corner-radius: 5pt,
  name: name,
)

#let step(n) = box(
  inset: 0.25em, stroke: black, radius: 100%,
  fill: white, text(size: 8pt, weight: "bold")[#n],
)

#let uses(..n) = text(size: 8pt, fill: gray.darken(30%))[
  uses #n.pos().map(str).join(", ")
]


#table(
  columns: (1fr, 1fr),
  inset: 0.8em,
  align: center + top,
  table.cell(
    colspan: 2,
    [
      #diagram(
        spacing: (8mm, 5mm),
        node((-1, 0), [$c$], name: <Cost>),
        box-node((0, 0), [Supplier], <S>),
        box-node((6, 0), [Retail], <R>),
        node((7, 0), [$p$ \ $s$], name: <Mkt>),

        edge(<S>, <R>, "-|>", [$w$], bend: 15deg),
        edge(<S>, <R>, "<|-", [$b$ (retailer pays $r$)], bend: -15deg, label-side: right),
      )
    ]
  ),
  table.cell(
    colspan: 2,
    align: left,
    text(size: 8pt)[
      - $c$ production cost
      - $w$ wholesale price
      - $p$ retail price
      - $s$ retailer salvage
      - $b$ buyback price
      - $r$ return cost per unit
      - $v$ supplier salvage on returns
      - $b - r$: what the retailer nets for each return
    ],
  ),
  table.cell(fill: gray.lighten(80%))[*Supplier*],
  table.cell(fill: gray.lighten(80%))[*Retail*],
  [
    #text(size: 9pt)[Wholesale #step(2)]
    $ E[pi_S] = (w - c) Q^* $
    #text(size: 8pt)[$Q^*$ from retail wholesale]
  ],
  [
    #text(size: 9pt)[Wholesale #step(1)]
    $
        c_u &= p - w \
        c_o &= w - s \
        "cr" &= c_u / (c_u + c_o) \
        Q^* &= F^(-1)("cr") \
        z &= (Q^* - mu) / sigma \
        L(z) &= phi(z) - z (1 - Phi(z)) \
        E["Short"] &= sigma L(z) \
        E["Sales"] &= mu - E["Short"] \
        E["Left"] &= Q^* - E["Sales"] \
        E[pi_R] &= p E["Sales"] + s E["Left"] - w Q^*
    $
  ],
  [
    #text(size: 9pt)[Buyback #step(2)]
    $ E[pi_S] = (w - c) Q^* - (b - v) E["Left"] $
    #text(size: 8pt)[$Q^*$, $E["Left"]$ from retail buyback]
  ],
  [
    #text(size: 9pt)[Buyback #step(1)]
    $
      c_u &= p - w \
      c_o &= w - (b - r) \
      "cr" &= c_u / (c_u + c_o) = (p - w) / (p - b + r) \
      Q^* &= F^(-1)("cr") \
      z &= (Q^* - mu) / sigma \
      L(z) &= phi(z) - z (1 - Phi(z)) \
      E["Short"] &= sigma L(z) \
      E["Sales"] &= mu - E["Short"] \
      E["Left"] &= Q^* - E["Sales"] \
      E[pi_R] &= p E["Sales"] + (b - r) E["Left"] - w Q^*
    $
  ],

  // Supply chain
  table.cell(
    colspan: 2,
    [
      #text(size: 9pt)[*Supply Chain* #step(1)]
      $
        c_u = p - c \
        c_o = c - s \
        E[pi_"SC"] = p E["Sales"] + s E["Left"] - c Q^*
      $
      
      #text(size: 8pt)[rerun $Q^* -> E["Left"]$ chain with $"cr"_"SC"$]

      $
        (p - w) / (p - (b - r)) = (p - c) / (p - s)
      $

      $
        "given" w: quad b^* = p + r - ((p - w)(p - s)) / (p - c)
        quad quad
        "given" b: quad w^* = p - ((p - c)(p - b + r)) / (p - s)
      $

      $
        "buyback %" = b / w
      $

      #align(left)[
        #text(size: 8pt)[
          Feasiblity: 
          - $b < w$: retailer doesn't make profit returning merchandise
          - $b > s + r$: retailer prefers to return rather than salvage
          - $pi_R + pi_S = pi_"SC"$
        ]
      ]
    ]
  ),
)

== Revenue Management with Capacity Controls

#{
  set text(size: 10pt)
  let hd(t) = text(fill: black, weight: "bold", t)
  table(
    columns: (auto, 1fr, 1fr),
    inset: (x: 3pt, y: 2.6pt),
    align: (left + horizon, left, left),
    stroke: 0.4pt + luma(200),
    table.header(hd[], hd[Capacity controls], hd[Overbooking]),
    [*Uncertain*], [$D$ = high-fare demand $(mu, sigma)$], [$X$ = no-shows $(mu_X, sigma_X)$],
    [*Decision*], [$Q$ = protection level (held back *inside* cap)], [$R$ = overbooked units (sold *beyond* cap)],
    [*Sell*], [low-fare booking limit $= "cap" - Q$], [max reservations $= "cap" + R$],
    [*Underage*], [$D > Q$ (sold cheap) → $C_u = r_H - r_L$], [$X > R$ (empty seat) → $C_u$ = price],
    [*Overage*], [$D < Q$ (empty seat) → $C_o = r_L$], [$X < R$ (bumped) → $C_o$ = bump cost],
    [*Ratio*], [$alpha = (r_H - r_L)\/r_H$], [$alpha = C_u\/(C_u + C_o)$],
    [*$z$*], [$(Q - mu)\/sigma$], [$(R - mu_X)\/sigma_X$],
    [*$sigma L(z)$ is*], [lost high-fare customers], [empty seats],
    [*Leftover*], [empty seats $= Q - mu + sigma L(z)$], [bumped $= R - mu_X + sigma_X L(z)$],
    [*Prob.*], [all sold $= 1 - Phi(z)$], [bumping $= Phi(z)$],
    [*Money*], [rev. $= r_H (mu - sigma L(z)) + r_L ("cap" - Q)$], [payout $= C_o dot (R - mu_X + sigma_X L(z))$],
  )
}

#line(length: 100%)

= Order Up To

- $L$: Lead time






#[
  #set text(size: 7pt)

  #table(
    columns: 3,
    [$L$], [Lead time], [Time between ordering and receiving an order], 
    [$mu$], [Demand mean (1 period)], [], 
    [$sigma$], [Demand s.d. (1 period)], [], 
    [$mu_(L+1)$], [Demand mean ($L$ period)], [], 
    [$sigma_(L+1)$], [Demand s.d. ($L$ period)], [], 
    [$mu_(L+T)$], [Demand mean ($L+T$ period)], [], 
    [$sigma_(L+T)$], [Demand s.d. ($L+T$ period)], [], 
    [$b$], [Backorder penalty], [], 
    [$h$], [Holding cost], [], 
    [$S$], [], [], 
    [], [], [], 
    [], [], [], 
    [], [], [], 
  )

  #table(
    columns: 4,
    inset: 1em,
    [], [*Definition*], [*Formula*], [*Python*],
    [
      Inventory *Level*
    ],
    [
      Units in stock minus backorders. At the end of a period it equals $S - D_(L+1)$
    ],
    [
      $
        "OnHand" - "Backorder"
      $
    ],
    [
      ```py
      on_hand - backorder
      ```
    ],
    [
      Inventory *Position*
    ],
    [
      Inventory level plus units on order. Right after ordering it equals $S$
    ],
    [
      $
        underbrace("OnHand" - "Backorder", "Inventory\nLevel") + "OnOrder"
      $
    ],
    [
      ```py
      on_hand - backorder + on_order
      ```
    ],
    [
      Demand over $L+1$
    ],
    [
      Demand that $S$ must cover: $L$ periods of lead time plus the current period. Assumes periods are independent
    ],
    [
      $
        mu_(L+1) &= mu (L+1) \
        sigma_(L+1) &= sigma sqrt(L+1) \
      $
    ],
    [
      ```py
      mean_L1 = mean * (L + 1)
      sd_L1 = sd * np.sqrt(L + 1)
      ```
    ],
    [
      Demand over $L+T$
    ],
    [
      General case with review period $T$: $S$ must cover the lead time plus one review period
    ],
    [
      $
        mu_(L+T) &= mu (L+T) \
        sigma_(L+T) &= sigma sqrt(L+T) \
      $
    ],
    [
      ```py
      mean_LT = mean * (L + T)
      sd_LT = sd * np.sqrt(L + T)
      ```
    ],
    [
      E[OnOrder] \
      E[Pipeline] \
    ],
    [
      Number of units ordered but not received. Uses $L$, not $L+1$ (Little's Law), so it does not depend on demand variability
    ],
    [
      $
        mu L
      $
    ],
    [
      ```py
      mean * L
      ```
    ],

    [
      E[OnHand] \
      SafetyStock \
    ],
    [
      Expected on-hand inventory at the end of a period (analogous to expected leftover inventory in the newsvendor model)
    ],
    [
      $
        S - mu_(L+1) + E["Backorder"]
      $
    ],
    [
      ```py
      S - mean_L1 + e_backorder
      ```
    ],

    [
      E[Backorder]
    ],
    [
      Expected units backordered at the end of a period (analogous to expected lost sales in the newsvendor model, but the OUT model has no lost sales)
    ],
    [
      $
        z = (S - mu_(L+1)) / sigma_(L+1) \
        L(z) = phi(z) - z (1 - Phi(z)) \
        E["Backorder"] = sigma_(L+1) L(z)
      $
    ],
    [
      ```py
      z = (S - mean_L1) / sd_L1
      loss = norm.pdf(z) - z * (1 - norm.cdf(z))
      e_backorder = sd_L1 * loss
      ```
    ],
    [
      Order\
      Quantity
    ],
    [
      Ordered each period. It equals the previous period's demand (1-for-1, pull system)
    ],
    [
      $
        Q = S - I_p
      $
    ],
    [
      ```py
      q = S - inv_position
      ```
    ],
    [
      $S$ \
      OrderUpTo \
    ],
    [
      Order-up-to (base-stock) level: the maximum inventory position allowed
    ],
    [
      $
        S = mu_(L+1) + z dot sigma_(L+1)
      $
    ],
    [
      ```py
      mean_L1 = mean * (L + 1)
      sd_L1 = sd * np.sqrt(L + 1)

      z = norm.ppf(service)
      S = mean_L1 + z * sd_L1
      ```
    ],
    [
      Target InStock
    ],
    [
      Choose $S$ so the in-stock probability meets target $alpha$ (e.g. $F(3.08) = 0.9990$)
    ],
    [
      $
        Phi(mc(z)) = alpha \
        S = mu_(L+1) + mc(z) dot sigma_(L+1)
      $
    ],
    [
      ```py
      z = norm.ppf(service)
      S = mean_L1 + z * sd_L1
      ```
    ],
    [
      P(InStock)
    ],
    [
      Probability all demand is filled in a period
    ],
    [
      $
        P(D_(L+1) <= S) = Phi(z)
      $
    ],
    [
      ```py
      norm.cdf(z)
      ```
    ],
    [
      P(Stockout)
    ],
    [
      Probability at least one unit is backordered in a period
    ],
    [
      $
        1 - P(D_(L+1) <= S) = 1 - Phi(z)
      $
    ],
    [
      ```py
      1 - norm.cdf(z)
      ```
    ],
    [
      Stockouts\
      over time
    ],
    [
      For $N$ periods and in-stock target $alpha$
    ],
    [
      $
        E["periods out"] = N (1 - alpha) \
        E["periods to 1st"] = 1 / (1 - alpha)
      $
    ],
    [
      ```py
      N * (1 - alpha)
      1 / (1 - alpha)
      ```
    ],
    [
      Fillrate
    ],
    [
      Fraction of demand per period satisfied from stock. The denominator is one-period demand $mu$, not $mu_(L+1)$
    ],
    [
      $
        1 - E["Backorder"] / mu
      $
    ],
    [
      ```py
      1 - e_backorder / mean
      ```
    ],
    [
      Optimal\
      in-stock\
      probability
    ],
    [
      Critical ratio that minimises cost: $C_o = h$ if $S$ is too high, $C_u = b$ if too low
    ],
    [
      - $h$: holding cost per unit per period
      - $b$: backorder penalty per unit
      $
        P(D_(L+1) lt.eq S)
        &= C_u / (C_u + C_o) \
        &= b / (b + h) \
      $
    ],
    [
      ```py
      crit = b / (b + h)
      z = norm.ppf(crit)
      S = mean_L1 + z * sd_L1
      ```
    ],
    [
      E[Backorder] \
      (Poisson)
    ],
    [
      Slow movers (mean $<= 10$): no z-statistic, so use the table or the formula. $sigma = sqrt(lambda)$. Choose the smallest $S$ with $F(S) >= alpha$
    ],
    [
      $
        lambda_(L+1) = lambda (L+1) \
        L(S) = lambda_(L+1) - lambda_(L+1) F(S - 1) - S (1 - F(S))
      $
    ],
    [
      ```py
      lam_L1 = lam * (L + 1)
      F = lambda s: poisson.cdf(s, lam_L1)
      e_backorder = lam_L1 - lam_L1 * F(S - 1) - S * (1 - F(S))
      S = poisson.ppf(service, lam_L1)
      ```
    ],
    [
      E[Backorder] \
      SafetyStock \
      (general $L+T$)
    ],
    [
      Periodic review with review period $T$: replace $L+1$ with $L+T$
    ],
    [
      $
        S = mu_(L+T) + z dot sigma_(L+T) \
        E["Backorder"] = sigma_(L+T) L(z) \
        "SafetyStock" = S - mu_(L+T) + E["Backorder"]
      $
    ],
    [
      ```py
      S = mean_LT + z * sd_LT
      z = (S - mean_LT) / sd_LT
      loss = norm.pdf(z) - z * (1 - norm.cdf(z))
      e_backorder = sd_LT * loss
      ss = S - mean_LT + e_backorder
      ```
    ],
    [
      Cycle\
      inventory
    ],
    [
      Average order quantity is one period's demand, so cycle stock is half of it
    ],
    [
      $
        (mu T) / 2 quad (T = 1 => mu / 2)
      $
    ],
    [
      ```py
      mean * T / 2
      ```
    ],
    [
      Average\
      inventory
    ],
    [
      Used for holding cost when choosing the review period
    ],
    [
      $
        "SafetyStock" + "CycleInventory"
      $
    ],
    [
      ```py
      ss + mean * T / 2
      ```
    ],
    [
      $n$ \
      Orders/year
    ],
    [
      No order is placed in a period with zero demand
    ],
    [
      $
        (1 - P(D_T = 0)) / T_"years"
      $
    ],
    [
      ```py
      (1 - p_zero) / T_years
      ```
    ],
    [
      Days of\
      supply
    ],
    [
      Safety stock in periods of demand. Its three drivers are lead time, variability, and service level
    ],
    [
      $
        sqrt(L+1) dot sigma / mu dot (phi(z) + z Phi(z))
      $
    ],
    [
      ```py
      np.sqrt(L + 1) * sd / mean * (norm.pdf(z) + z * norm.cdf(z))
      ```
    ],
  )
]