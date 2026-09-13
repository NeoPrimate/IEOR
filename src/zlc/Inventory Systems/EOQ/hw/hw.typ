#import "@preview/lilaq:0.6.0" as lq
#import "@preview/tiptoe:0.4.0"

#set heading(numbering: "1.a.")
#set text(font: "Helvetica")

#align(center)[
  #text(
    size: 32pt,
    [Assignement 1]
  )
]

1 year = 12 months = 52 weeks = 365 days

= Finite Production
 
_Hyundai's SUV division is selling only one product and is running an independent, fully
automated facility with a production rate of 150 cars per month. The company needs 3 days
of setup period to warm up the facility, and €1,000 is incurred daily for this task. It is facing a stable customer demand of 1,200 cars per year. The unit production cost is €15,000 and the selling price is €25,000. The company is applying an annual unit holding cost of 15% of product cost._
 
#v(2em)
 
#let D = 1200
 
#let months-per-year = 12
#let P_month = 150
#let P = P_month * months-per-year
 
#let S-days = 3
#let S-daily-cost = 1000
#let S = S-days * S-daily-cost
 
#let c = 15000
#let p = 25000
 
#let h = 0.15
#let H = h * c
 
#let epq(D, S, H, P) = calc.sqrt((2 * D * S) / (H * (1 - D / P)))
 
#let q-star = epq(D, S, H, P)
#let q-star = calc.round(q-star, digits: 2)
 
#let purchase-cost = c * D
#let ordering-cost(Q) = S * (D / Q)
#let holding-cost(Q) = H * (Q / 2) * (1 - D / P)
 
#let TC(Q) = purchase-cost + ordering-cost(Q) + holding-cost(Q)
#let TVC(Q) = ordering-cost(Q) + holding-cost(Q)
 
#let total-revenue = p * D
#let TP(Q) = total-revenue - TC(Q)
 
#let cum-ordering-cost(Q) = purchase-cost + ordering-cost(Q)
#let cum-holding-cost(Q) = purchase-cost + holding-cost(Q)
 
#let days-per-year = 365
#let idle-fraction = 1 - D / P
#let idle-days = idle-fraction * days-per-year

#let Imax = q-star * (1 - D / P)
#let Imax = calc.round(Imax, digits: 2)

#let Ibar = Imax / 2
#let Ibar = calc.round(Ibar, digits: 2)

#let Td = (Imax / D) * days-per-year
#let Td = calc.round(Td, digits: 2)

#let Tp = (q-star / P) * days-per-year
#let Tp = calc.round(Tp, digits: 2)
 
#let avg-inventory = q-star * (1 - D / P) / 2
 
- Demand ($D$) = $#D$ units / year
- Sell Price (p) = $#p$ \$ / unit
- Cost (c) = $#c$ \$ / unit
- Setup Cost (S) = $#S$ \$ / setup
- Production rate ($P_"month"$) = $#P_month$ units / month
- Production rate ($P_"year"$) = $#P$ units / year
- Holding cost rate (h) = $#(h * 100)$ % / unit / year
- Holding cost (H) = $#H$ \$ / unit / year
 
#v(2em)
 
*(a)* _How many cars shall Hyundai produce whenever it starts the facility to maximize the total profit in the long run? (5 points)_
 
The total profit is given by the function:
 
$
  "TP"(Q)
  &= "TR" - "TC"(Q) \
  &= underbrace(p D, "Total\nRevenue") - underbrace(c D, "Purchasing\nCost") quad - quad underbrace(S D / Q, "Ordering\nCost") quad - quad underbrace(H / 2 (1 - D / P) Q, "Holding\nCost")
$
 
Maximize the total profit w.r. to $Q$:
 
$
  Q^* = op(arg max, limits: #true)_Q "TP"(Q)
$
 
Taking the derivative:
 
$
  (dif "TP") / (dif Q)
  &= dif / (dif Q) [p D - c D - S D / Q - H / 2 (1 - D / P) Q] \
  &= dif / (dif Q) [p D] - dif / (dif Q) [c D] - dif / (dif Q) [S D / Q] - H/2 (1 - D/P) dif / (dif Q) [Q] \
  &= 0 - 0 - dif / (dif Q) [S D dot Q^(-1)] - H/2 (1 - D/P) dot 1 \
  &= - S D dot dif / (dif Q) [Q^(-1)] - H/2 (1 - D/P) \
  &= - S D dot (-1) Q^(-2) - H/2 (1 - D/P) \
  &= S D / Q^2 - H/2 (1 - D/P)
$
 
Setting the derivative equal to zero to find the critical point:
 
$
  S D / Q^2 - H/2 (1 - D/P) &= 0 \
  H/2 (1 - D/P) &= (D S) / Q^2 \
  Q^2 &= (2 D S) / (H (1 - D/P)) \
  Q &= sqrt((2 D S) / (H (1 - D/P)))
$
 
To confirm this critical point is a maximum rather than a minimum, check the second derivative:
 
$
  (dif^2 "TP") / (dif Q^2)
  &= (dif) / (dif Q) [(D S) / Q^2 - H/2 (1 - D/P)] \ \
  &= (dif) / (dif Q) [D S Q^(-2)] - 0 \ \
  &= D S dot (dif) / (dif Q) [Q^(-2)] \ \
  &= D S dot (-2) Q^(-3) \ \
  &= -(2 D S) / Q^3
$
 
Since $D, S, Q > 0$, $(dif^2 "TP")/(dif Q^2) < 0$ for all $Q > 0$, confirming $"TP"(Q)$ is concave and the critical point $Q^* = sqrt((2 D S) / (H (1 - D/P)))$ is indeed a maximum.
 
Using the formula we derived:
 
$
  Q^*
  &= sqrt((2 D S) / (H (1 - D / P))) \
  &= sqrt((2 (#D) (#S)) / (#H * (1 - #D / #P))) \
  &= #q-star
$
 
Therefore, the total profit:
 
$
  "TP"(Q^*)
  &= p D - c D - S D / Q^* - H/2 (1 - D/P) Q^* \
  &= (#p)(#D) - (#c)(#D) - #S (#D) / (#q-star) - (#H)/2 (1 - #D/#P) (#q-star) \
  &= #calc.round(TP(q-star), digits: 2)
$
 
 
#align(center)[
  #let x = lq.linspace(10, 150, num: 200)
  #let y-tp = x.map(TP)
  // #let y-tc = x.map(TC)
  // #let y-holding-cost = x.map(cum-holding-cost)
 
  #lq.diagram(
    width: 25em,
    height: 20em,
    xlabel: [$Q$],
    ylabel: [$"TP"(Q)$],
    lq.plot(x, y-tp, mark: none, stroke: 1.5pt, label: [TP]),
    // lq.plot(x, y-tc, mark: none, stroke: green + 1.5pt, label: [Holding Cost]),
    // lq.plot(x, y-cum-holding-cost, mark: none, stroke: blue + 1.5pt, label: [Ordering Cost]),
    lq.vlines(q-star, stroke: (paint: red, dash: "dashed", thickness: 1.5pt)),
    lq.hlines(TP(q-star), stroke: (paint: red, dash: "dashed", thickness: 1.5pt)),
  )
]
 
#v(2em)
 
*(b)* _How many cars shall the company produce whenever it starts the facility to minimize the total cost in the long run? (5 points)_
 
The total cost is given by the function:
 
$
  "TC"(Q)
  &= underbrace(c D, "Purchasing\nCost") quad + quad underbrace(S D / Q, "Ordering\nCost") quad + quad underbrace(H / 2 (1 - D / P) Q, "Holding\nCost")
$
$
  "TVC"(Q)
  &= underbrace(S D / Q, "Ordering\nCost") quad + quad underbrace(H / 2 (1 - D / P) Q, "Holding\nCost")
$
 
Minimize the total cost w.r. to $Q$:
 
$
  Q^* = op(arg min, limits: #true)_Q "TVC"(Q)
$
 
Find the first derivative of the total variable cost function:
 
$
  (dif "TVC") / (dif Q)
    &= (dif) / (dif Q) [ S D/Q + H/2 (1 - D/P) Q ] \ \
    &= (dif) / (dif Q) (D S Q^(-1)) + H/2 (1 - D/P) dot (dif) / (dif Q) (Q) \ \
    &= D S dot (dif) / (dif Q) (Q^(-1)) + H/2 (1 - D/P) dot 1 \ \
    &= D S dot (-1) Q^(-2) + H/2 (1 - D/P) \ \
    &= -(D S) / Q^2 + H/2 (1 - D/P)
$
 
Setting the derivative equal to zero to find the critical point:
 
$
  -(D S) / Q^2 + H/2 (1 - D/P) &= 0 \ \
  H/2 (1 - D/P) &= (D S) / Q^2 \ \
  Q^2 &= (2 D S) / (H (1 - D/P)) \ \
  Q^* &= sqrt((2 D S) / (H (1 - D/P)))
$
 
To confirm this critical point is a minimum rather than a maximum, check the second derivative:
 
$
  (dif^2 "TVC") / (dif Q^2)
    &= (dif) / (dif Q) [-(D S) / Q^2 + H/2 (1 - D/P)] \ \
    &= (dif) / (dif Q) [-D S Q^(-2)] + 0 \ \
    &= -D S dot (dif) / (dif Q) [Q^(-2)] \ \
    &= -D S dot (-2) Q^(-3) \ \
    &= (2 D S) / Q^3
$
 
Since $D, S, Q > 0$, $(dif^2 "TVC")/(dif Q^2) > 0$ for all $Q > 0$, confirming $"TVC"(Q)$ is convex and the critical point $Q^* = sqrt((2 D S) / (H (1 - D/P)))$ is indeed a minimum.
 
Using the formula we derived:
 
$
  Q^*
  &= sqrt((2 D S) / (H (1 - D/P))) \
  &= sqrt((2 (#D) (#S)) / (#H * (1 - #D/#P))) \
  &= #q-star
$
 
Therefore, the total cost:
 
$
  "TC"(Q^*)
  &= c D + S D / Q^* + H/2 (1 - D/P) Q^* \
  &= (#c)(#D) + #S (#D) / (#q-star) + (#H)/2 (1 - #D/#P) (#q-star) \
  &= #calc.round(TC(q-star), digits: 2)
$
 
#align(center)[
  #let x = lq.linspace(10, 150, num: 200)
  #let y-tc = x.map(TC)
  #let y-cum-ordering-cost = x.map(cum-ordering-cost)
  #let y-cum-holding-cost = x.map(cum-holding-cost)
 
  #lq.diagram(
    width: 25em,
    height: 20em,
    xlabel: [$Q$],
    ylabel: [$"TC"(Q)$],
    lq.plot(x, y-tc, mark: none, stroke: 1.5pt, label: [TC]),
    lq.plot(x, y-cum-ordering-cost, mark: none, stroke: 1.5pt, label: [Ordering Cost]),
    lq.plot(x, y-cum-holding-cost, mark: none, stroke: 1.5pt, label: [Holding Cost]),
    lq.vlines(q-star, stroke: (paint: red, dash: "dashed", thickness: 1.5pt)),
    lq.hlines(TC(q-star), stroke: (paint: red, dash: "dashed", thickness: 1.5pt)),
  )
]
 
And total variable cost:
 
$
  "TVC"(Q^*)
  &= sqrt(2 D S H (1 - D / P)) \
  &= sqrt(2 (#D) (#S) (#H) (1 - #D / #P)) \
  &= #calc.round(TVC(q-star), digits: 2)
$
 
#align(center)[
  #let x = lq.linspace(10, 150, num: 200)
  #let y-tvc = x.map(TVC)
  #let y-holding-cost = x.map(holding-cost)
  #let y-ordering-cost = x.map(ordering-cost)
 
  #lq.diagram(
    width: 25em,
    height: 20em,
    xlabel: [$Q$],
    ylabel: [$"TVC"(Q)$],
    // xaxis: (ticks: (q-star,)),
    // yaxis: (ticks: (TVC(q-star),)),
    lq.plot(x, y-tvc, mark: none, stroke: 1.5pt, label: [TVC]),
    lq.plot(x, y-ordering-cost, mark: none, stroke: 1.5pt, label: [Ordering Cost]),
    lq.plot(x, y-holding-cost, mark: none, stroke: 1.5pt, label: [Holding Cost]),
    lq.vlines(q-star, stroke: (paint: red, dash: "dashed", thickness: 1.5pt)),
    lq.hlines(TVC(q-star), stroke: (paint: red, dash: "dashed", thickness: 1.5pt)),
  )
]
 
#v(2em)
 
*(c)* _How many days per year shall the facility be idle for (b) above? (5 points)_

#let T = q-star / D

$
  T_p 
  &= Q / P \
  &= #q-star / #P \
  &= #Tp
$

$
  T 
  &= Q / D \
  &= #q-star / #D \
  &= #T
$

$
  T_d 
  &= T - T_p \
  &= #T - Tp \
  &= #Td
$

$
  T_d = I_max / D = #Imax / #D = #Td
$

Number of cycles

#let n-cycles = D / q-star
#let n-cycles = calc.round(n-cycles, digits: 2)

$
  "Cycles" = D / Q^* = #D / #q-star = #n-cycles
$

#let idle = Td * n-cycles

$
  #idle
$

$
  "Down time/year"
  &= D/Q dot Q(1/D - 1/P) \
  &= D(1/D - 1/P) \
  &= 1 - D/P \
  &= 1 - (#D)/(#P) \
  &= #calc.round(idle-fraction, digits: 4)
$
 
$
  "Idle days/year" 
  &= (1 - D/P) #days-per-year \
  &= #calc.round(idle-days, digits: 2) " days"
$
 
At the optimal batch size $Q^* = #q-star$, this corresponds to $D \/ Q^* approx #calc.round(D / q-star, digits: 2)$ production runs per year:
- Production time of $Q^* \/ P approx #calc.round(q-star / P * days-per-year, digits: 2)$ days
- Cycle length of $Q^* \/ D approx #calc.round(q-star / D * days-per-year, digits: 2)$ days
 
*(d)* _What is the average inventory level for (b) above in the long run? (5 points)_
 
Because the facility produces at a finite rate, inventory never reaches the full batch size $Q^*$ —
it only ever builds up to $I_"max" = Q^*(1 - D/P)$ before the facility idles and inventory is drawn
down again. Average inventory over the cycle is half of that peak:
 
$
  I_"max" 
  &= Q^* (1 - D/P) \
  &= (#q-star)(1 - (#D)/(#P)) \
  &= Imax \
  \
$

$
  macron(I) &= I_max / 2 = #Imax / 2 = #Ibar
$

#let epq(D, S, H, P) = calc.sqrt((2 * D * S) / (H * (1 - D / P)))
#let Q = epq(D, S, H, P)

// #let Tp = Q / P
// #let Imax = (P - D) * Tp
// #let Td = Imax / D
#let T = Tp + Td

#align(center)[

  #lq.diagram(
    width: 25em,
    height: 14em,
    xlim: (0, T),
    ylim: (0, Imax * 1.1),
    xaxis: (ticks: ((Tp, []),), subticks: none),
    yaxis: (
      ticks: (
        (Imax, $I_"max" = #Imax$),
        (Ibar, $macron(I) = #Ibar$),
      ), 
      subticks: none
    ),
    ylabel: [Inventory Level],

    lq.plot((0, Tp, T), (0, Imax, 0), mark: none, stroke: 1.5pt),

    lq.line((0, 0), (Tp, 0), tip: tiptoe.triangle, toe: tiptoe.triangle,
      stroke: (paint: black, thickness: 1pt), clip: false),
    lq.place(Tp / 2, 0 - 0.5, align: top, $T_p = #Tp$),

    lq.line((Tp, 0), (T, 0), tip: tiptoe.triangle, toe: tiptoe.triangle,
      stroke: (paint: black, thickness: 1pt), clip: false),
    lq.place((Tp + T) / 2, 0 - 0.5, align: top, $T_d = Td$),

    lq.line((0, -0.15 * Imax), (T, -0.15 * Imax), tip: tiptoe.triangle, toe: tiptoe.triangle,
      stroke: (paint: black, thickness: 1pt), clip: false),
    lq.place(T / 2, -0.15 * Imax - 0.5, align: top, $T = #T$),
  )
]
 
*(e)* _How much is the average total profit per year in the long run? (5 points)_
 
$
  "TP"(Q^*)
  &= "TR" - "TC"(Q^*) \
  &= underbrace(p D, "Total\nRevenue") - underbrace(c D, "Purchasing\nCost") quad - quad underbrace(S D / Q^*, "Ordering\nCost") quad - quad underbrace(H/2 (1 - D/P) Q^*, "Holding\nCost") \
  &= (#p)(#D) - (#c)(#D) - #S (#D) / (#q-star) - (#H)/2 (1 - #D/#P) (#q-star) \
  &= #calc.round(TP(q-star), digits: 2)
$
 
*(f)* _Now the company has a new constraint on the production batch size and the production quantity should be a multiple of 40, i.e., 40 - 80 - 120 - 160 - ..., whenever it runs the facility. How much is the optimal production quantity to minimize the long-run cost? (5 points)_
 
Since $"TC"(Q)$ is convex and $Q^* = #q-star$ is not a multiple of $40$, the constrained optimum must be
one of the two feasible batch sizes bracketing $Q^*$: $Q = 80$ or $Q = 120$.
 
#let Q1 = 80
#let Q2 = 120
 
$
  "TC"(#Q1) &= c D + S D / #Q1 + H/2 (1 - D/P) #Q1 = #calc.round(TC(Q1), digits: 2) \
  "TC"(#Q2) &= c D + S D / #Q2 + H/2 (1 - D/P) #Q2 = #calc.round(TC(Q2), digits: 2)
$
 
Since $Q1 dot Q2 = #(Q1 * Q2) = (Q^*)^2$, both quantities give exactly the same total cost — a
general property of the EOQ/EPQ cost function: whenever two candidates' product equals $(Q^*)^2$,
their ordering-cost and holding-cost terms simply swap values, so the sum is identical.
 
*Therefore both $Q = 80$ and $Q = 120$ are optimal*, tied at
 
$
  "TC"_min = #calc.round(TC(Q1), digits: 2)
$
 
which is $#calc.round(TC(Q1) - TC(q-star), digits: 2)$ \$ higher per year than the unconstrained
minimum of $#calc.round(TC(q-star), digits: 2)$ \$ found in (b).
 
#align(center)[
  #let x = lq.linspace(10, 200, num: 200)
  #let y-tc = x.map(TC)
 
  #lq.diagram(
    width: 25em,
    height: 20em,
    xlabel: [$Q$],
    ylabel: [$"TC"(Q)$],
    lq.plot(x, y-tc, mark: none, stroke: 1.5pt, label: [TC]),
    lq.vlines(q-star, stroke: (paint: red, dash: "dashed", thickness: 1.5pt)),
    lq.vlines(Q1, Q2, stroke: (paint: blue, dash: "dashed", thickness: 1.5pt)),
    lq.hlines(TC(Q1), stroke: (paint: blue, dash: "dashed", thickness: 1.5pt)),
  )
]

= All unit and marginal unit discounts (Max Points 30)

_Ericson's mobile communications division, a smartphone manufacturer, uses 20,000 memory
chips per month. Their transportation service provider charges Ericson €300 per shipment,
independently of the quantity purchased. The manufacturer offers an all unit quantity
discount with a price of €1 per memory chip for orders up to 18,000 units, €0.96 per chip for
orders between 18,000 and 36,000 units, and €0.92 per chip for orders larger than 36,000
units. Ericson incurs an annual unit holding cost of 15% of product cost._

#v(2em)

#let D = 20000
#let S = 300
#let q = (18000, 36000)
#let c = (1, 0.96, 0.92)
#let h = 0.15

#let TVC(Q, c) = D * c + D / Q * S + Q / 2 * h * c
#let q-star(ci) = calc.sqrt((2 * D * S) / (h * ci))

#let q-stars = c.map(q-star)
#let q-stars = q-stars.map(q => calc.round(q, digits: 2))

#let q-star-1 = q-stars.at(0)
#let q-star-2 = q-stars.at(1)
#let q-star-3 = q-stars.at(2)

- Demand $D$ = $#D$ unit / year
- Setup cost $S$ = $#S$ \$ / order
- Break points: $(18000, 36000)$
- Cost $c$ (\$ / unit)
  - $c_1 = 1$
  - $c_2 = 0.96$
  - $c_3 = 0.92$


#v(2em)

*(a)* _What is the optimal lot size for Ericson? (5 points)_

$
  "TVC"_i (Q) = D c_i + D / Q S + Q / 2 h c_i, quad "for" q_i lt.eq Q lt.eq q_(i+1)
$

$
  (dif "TVC") / (dif Q) = - (S D) / Q^2 + (h c_i) / 2
$

$
  Q^*_i = sqrt((2 D S) / (h c_i))
$

#align(center)[

  #let breaks = (200,) + q + (50000,)

  #lq.diagram(
    width: 25em,
    height: 20em,
    ylim: (19000, 25000),
    xaxis: (
      ticks: (
        ..q.enumerate().map(v => (v.at(1), $q_#(v.at(0) + 1)$)),
        // ..c.enumerate().map(v => (Qstar(v.at(1)), $Q^*_#(v.at(0) + 1)$)),
      ),
      subticks: none
    ),
    // yaxis: (ticks: none, subticks: none),
    xlabel: [$Q$],
    ylabel: [$"TVC"(Q)$],

    ..c.enumerate().map(v => {
      let i = v.at(0)
      let ci = v.at(1)
      let xs = lq.linspace(breaks.at(i), breaks.at(i + 1), num: 100)
      lq.plot(xs, xs.map(Q => TVC(Q, ci)), mark: none,
        stroke: (thickness: 2pt), label: [$c = #ci$])
    }),
    
    ..c.enumerate().map(v => {
      let x = lq.linspace(200, breaks.last(), num: 200)
      lq.plot(x, x.map(Q => TVC(Q, v.at(1))), mark: none,
        stroke: (dash: "dashed", thickness: 1pt, paint: gray))
    }),
  )
]

#let tvc-1 = calc.round(TVC(q-star-1, c.at(0)), digits: 2)
#let tvc-2 = calc.round(TVC(18000, c.at(1)), digits: 2)
#let tvc-3 = calc.round(TVC(36000, c.at(2)), digits: 2)

#align(center)[
  #text(size: 8pt)[
    #table(
      columns: 7,
      inset: 1em,
      [Category], [Range], [Price], [Unconstrained $Q^*_i$], [Feasible], [Min Feasible $Q^*$], [$"TVC"(Q)$],
      [$c_1$], [$0 lt.eq Q lt.eq 17999$], [$1$], [#q-star-1], [Yes],  [#q-star-1], [#tvc-1],
      [$c_2$], [$1800 lt.eq Q lt.eq 35999$], [$0.96$], [#q-star-2], [No], [18000], [#tvc-2],
      [$c_3$], [$Q gt.eq 36000$], [$0.92$], [#q-star-3], [No], [36000], [#tvc-3],
    )
  ]
]

The $Q$ that minimizes the $"TVC"$ is therefore 18000.

*(b)* _What is the annual cost of such a policy? (5 points)_

$
  "TVC"(18000) = #tvc-2
$


*(c)* _What is the cycle inventory of memory chips at Ericson? (5 points)_

$
  Q^* / 2 = #q-star-2 / 2 = #calc.round(q-star-2 / 2, digits: 2)
$

*[(d)-(e)]* _The manufacturer now offers a “marginal” unit quantity discount for the chips. The
first 18,000 chips of any order are sold at €1 per unit, the next 18,000 units are sold at €0.96
and any quantity over 36,000 chips is sold for €0.92 per unit._


*(d)* What is the optimal lot size for Ericson given this pricing structure, what is the resulting cost, and how does it compare with that in (a) and (b)? (10 points)

*(e)* _What is the cycle inventory of memory chips at Ericson given the ordering policy? (5 points)_


= Shipment aggregation (Max Points 20)

_LG, a refiner in Barcelona, serves three customers near Zaragoza, and maintains consignment
inventory (owned by LG) at each location. Demand at the large customer is 48 tons a year,
demand at the medium customer is 24 tons per year, and demand at the small customer is 12
tons per year. Product cost for LG is €80,000 per ton and the annual unit holding cost has been
estimated to 15% of product cost. Currently, LG uses full-truckload transportation to deliver
separately to each customer. Truck capacity is 12 tons and each delivery costs €700 plus €150
per stop (thus, delivering to each customer separately costs €850 per truck). LG is considering
aggregating deliveries to Zaragoza on a single truck._

*(a)* _What is the annual transportation and holding cost if LG ships a full truckload each time
a customer is running out of stock? How many days of inventory1 are carried at each customer
under this policy? (5 points)_

*(b)* _What is the optimal delivery policy to each customer if LG ships separately (not
necessarily full truckloads) to each of them? What is the annual transportation and holding
cost? How many days of inventory are carried at each customer under this policy? (5 points)_

*(c)* _What is the optimal delivery policy to each customer if LG aggregates shipments to each
of the three customers on every truck that goes to Zaragoza? What is the annual
transportation and holding cost? How many days of inventory are carried at each customer
under this policy? (10 points)_

= Power of two policies (Max Points 20)

_EasyWash is a washing machine manufacturer operating in Europe. One of its best-selling
models is produced in the firm's manufacturing site in Zaragoza and consists of three core
subassemblies: rotor, cylinder, and frame. While the rotor is manufactured in-house, the other
two subassemblies (cylinder and frame) are sourced from Asia. The cost for placing an order
with the cylinder supplier is 2,500€, while the same cost for the frame is 600€. Also, the annual
cost of holding one unit of inventory is equal to 75€ for the cylinder and 50€ for the frame.
The annual demand for the particular model is equal to 1,200 units (each machine consists of
one rotor, one cylinder, and one frame)._

_Assuming that availability of rotor is not an issue, the firm would like to coordinate the
procurement of the other two subassemblies (cylinder and frame) for logistics planning
purposes, by using “power of two” policies. What would be the optimal policies for the two
subassemblies, considering that the firm's planning team uses one week as the base planning
period (TB)? For each subassembly separately, please evaluate your policy's performance
(cost-wise) compared to the optimal one._

#align(center)[
  #text(size: 20pt, weight: "semibold")[Quiz Problems]
]

= Batches Production (Max Points 10)

_In the Economic Production Quantity (EPQ) model, we have assumed that output immediately
becomes available to meet demand. Therefore, we can wait until inventory drops to zero
before beginning production. In many cases, however, the finished product cannot be used
until an entire batch is complete, perhaps because the batch must be moved to a warehouse,
or because some finishing operation (e.g., cooling) is required. Let $D$ = demand rate, $P$ =
production rate $(P gt D)$, $S$ = setup cost, $H$ = unit holding cost, and $Q$ = production quantity per production run._

*(a)* _Show that the average inventory, optimal production quantity, and total variable cost
are respectively equal to:_

$
  macron(I) == 1/2 (1 + D / P), quad Q^* = sqrt((2 D S) / (H (1 + D / P))), quad "TCV"(Q^*) = sqrt(2 D S H (1 + D / P))
$

_(Hint: consider, to avoid running out of stock, what are the maximum and minimum inventory
values for this system). (7 points)_

*(b)* _Notice that when output is immediate available, the total variable cost is increasing in
the production rate, while in this case (i.e., when the finished product cannot be used until an
entire batch is complete), the total variable cost is decreasing in the production rate. Explain
the possible reason. (3 points)_

= EOQ with Backorders (Max Points 10)

_In the Atlantic Coast Tire Corporation (ACT) problem that we discussed during our first lecture
on EOQ, we ignored the cost of being out of stock (\$7.50 per tire short). Consider the penalty
associated with stocking out as cost per unit short per year (i.e., the stockout cost penalizes
also the duration of the stockout situation; hence it shall be treated as the holding cost).
Assuming that all demand that is not satisfied on time is backordered (i.e., it is served, usually first, during the next batch delivery):_

*(a)* _What is the EOQ for ACT in this case? Please show the steps you followed in deriving
this quantity. (7 points)_

_Hint: Set B the quantity backordered. Make a graph of how the policy will look like if
backorders are allowed. Compute the time lengths $T_1$ (demand is fully met) and $T_2$ (demand
is backordered) as functions of $D$, $Q$, and $B$. Compute average inventory and average
backorders and construct the cost function (which is now a function of both $Q$ and $B$). You can
assume that the cost function is jointly convex to Q and B (i.e., you don't need to show second
order derivative calculations). Then, take the partial derivatives of the cost function over $Q$
and $B$. This will result to a system of two equations with two unknowns. By solving this system,
you can obtain the optimal $Q$ and $B$._

*(b)* _Do you expect the new EOQ to be different (smaller or larger) from the classical EOQ
derived in class? Please explain why. (3 points)_