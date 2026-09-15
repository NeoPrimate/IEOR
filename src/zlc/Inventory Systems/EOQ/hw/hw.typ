#import "@preview/lilaq:0.6.0" as lq
#import "@preview/tiptoe:0.4.0"

#set heading(numbering: "1.a.")
#set text(font: "Helvetica", size: 8pt)

#let result(content) = box(stroke: blue, fill: blue.transparentize(75%), inset: 0.5em, radius: 0.25em)[
  #content
]

#align(center)[
  #text(
    size: 32pt,
    [Assignement 1]
  )
]

= Finite Production
 
_Hyundai's SUV division is selling only one product and is running an independent, fully
automated facility with a production rate of 150 cars per month. The company needs 3 days
of setup period to warm up the facility, and \$1,000 is incurred daily for this task. It is facing a stable customer demand of 1,200 cars per year. The unit production cost is \$15,000 and the selling price is \$25,000. The company is applying an annual unit holding cost of 15% of product cost._

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
- Setup Cost (S) = $#S$ \$ / batch
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
 
Since $D, S, Q > 0$, $(dif^2 "TP")/(dif Q^2) < 0$ for all $Q > 0$, confirming $"TP"(Q)$ is concave and the critical point $Q^* = sqrt((2 D S) / (H (1 - D/P)))$ is a maximum.
 
Using the formula we derived:
 
$
  Q^*
  &= sqrt((2 D S) / (H (1 - D / P))) \
  &= sqrt((2 (#D) (#S)) / (#H * (1 - #D / #P))) \
  &= #result([#q-star])
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
    width: 10cm,
    height: 8cm,
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
 
Since $D, S, Q > 0$, $(dif^2 "TVC")/(dif Q^2) > 0$ for all $Q > 0$, confirming $"TVC"(Q)$ is convex and the critical point $Q^* = sqrt((2 D S) / (H (1 - D/P)))$ is a minimum.
 
Using the formula we derived:
 
$
  Q^*
  &= sqrt((2 D S) / (H (1 - D/P))) \
  &= sqrt((2 (#D) (#S)) / (#H * (1 - #D/#P))) \
  &= #result([#q-star])
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
    width: 10cm,
    height: 8cm,
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
    width: 10cm,
    height: 8cm,
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
  #result([#idle])
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
  &= #result([#calc.round(idle-days, digits: 2) days])
$
 
At the optimal batch size $Q^* = #q-star$, this corresponds to $D \/ Q^* approx #calc.round(D / q-star, digits: 2)$ production runs per year:
- Production time of $Q^* \/ P approx #calc.round(q-star / P * days-per-year, digits: 2)$ days
- Cycle length of $Q^* \/ D approx #calc.round(q-star / D * days-per-year, digits: 2)$ days
 
*(d)* _What is the average inventory level for (b) above in the long run? (5 points)_
 
Average inventory over the cycle is half of the peak:
 
$
  I_"max" 
  &= Q^* (1 - D/P) \
  &= (#q-star)(1 - (#D)/(#P)) \
  &= Imax \
  \ \ \
  macron(I) 
  &= I_max / 2 \
  &= #Imax / 2 \
  &= #result([#Ibar])
$

#let epq(D, S, H, P) = calc.sqrt((2 * D * S) / (H * (1 - D / P)))
#let Q = epq(D, S, H, P)

// #let Tp = Q / P
// #let Imax = (P - D) * Tp
// #let Td = Imax / D
#let T = Tp + Td

#align(center)[

  #lq.diagram(
    width: 10cm,
    height: 8cm,
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
  &= #result([#calc.round(TP(q-star), digits: 2)])
$
 
*(f)* _Now the company has a new constraint on the production batch size and the production quantity should be a multiple of 40, i.e., 40 - 80 - 120 - 160 - ..., whenever it runs the facility. How much is the optimal production quantity to minimize the long-run cost? (5 points)_
 
The constrained optimum must be one of the two feasible batch sizes bracketing $Q^*$: $Q = 80$ or $Q = 120$:
 
#let Q1 = 80
#let Q2 = 120
 
$
  "TC"(#Q1) &= c D + S D / #Q1 + H/2 (1 - D/P) #Q1 = #calc.round(TC(Q1), digits: 2) \
  "TC"(#Q2) &= c D + S D / #Q2 + H/2 (1 - D/P) #Q2 = #calc.round(TC(Q2), digits: 2)
$
 
Both 

$Q = #result([80])$ 

and 

$Q = #result([120])$ 

are optimal, tied at:
 
$
  "TC"_min = #calc.round(TC(Q1), digits: 2)
$
 
which is $#calc.round(TC(Q1) - TC(q-star), digits: 2)$ \$ higher per year than the unconstrained
minimum of $#calc.round(TC(q-star), digits: 2)$ \$.
 
#align(center)[
  #let x = lq.linspace(10, 200, num: 200)
  #let y-tc = x.map(TC)
 
  #lq.diagram(
    width: 10cm,
    height: 8cm,
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
chips per month. Their transportation service provider charges Ericson \$300 per shipment,
independently of the quantity purchased. The manufacturer offers an all unit quantity
discount with a price of \$1 per memory chip for orders up to 18,000 units, \$0.96 per chip for
orders between 18,000 and 36,000 units, and \$0.92 per chip for orders larger than 36,000
units. Ericson incurs an annual unit holding cost of 15% of product cost._

#v(1em)

#let months-per-year = 12
#let D-monthly = 20000
#let D = D-monthly * months-per-year
#let S = 300
#let q = (18000, 36000)
#let p = (1, 0.96, 0.92)
#let h = 0.15

- Demand $D$ = $#D$ units/year
- Setup cost $S$ = \$$#S$/order
- Holding cost rate $h$ = $#(h*100)%$ of unit cost
- Break points: $q_1 = 18000$, $q_2 = 36000$
- Price $c_i$ (\$/unit): $c_1 = 1$, $c_2 = 0.96$, $c_3 = 0.92$

#v(1em)

*(a)* _What is the optimal lot size for Ericson? (5 points)_

The total annual cost for bracket $i$ is:

$
  "TVC"_i (Q) = D c_i + D / Q S + Q / 2 h c_i
$

which is minimized at

$
  (dif "TVC"_i (Q)) / (dif Q) = - (D S) / Q^2 + (h c_i) / 2 = 0 quad arrow.double quad Q^*_i = sqrt((2 D S) / (h c_i))
$

#let Qstar(c) = calc.sqrt((2 * D * S) / (h * c))
#let TVC(Q, c) = D * c + D / Q * S + Q / 2 * h * c

#let Qstar-1 = calc.round(Qstar(p.at(0)), digits: 2)
#let Qstar-2 = calc.round(Qstar(p.at(1)), digits: 2)
#let Qstar-3 = calc.round(Qstar(p.at(2)), digits: 2)

#let tvc-1 = calc.round(TVC(18000, p.at(0)), digits: 2)
#let tvc-2 = calc.round(TVC(Qstar(p.at(1)), p.at(1)), digits: 2)
#let tvc-3 = calc.round(TVC(36000, p.at(2)), digits: 2)

#align(center)[
  #table(
    columns: 7,
    inset: 0.8em,
    align: center + horizon,
    [*Bracket*], [*Range*], [*Price*], [*Unconstrained $Q^*_i$*], [*Feasible?*], [*Best $Q$ in bracket*], [*$"TVC"_i$*],
    [1], [$0 lt.eq Q lt.eq 18000$], [1], [#Qstar-1], [No (too large)], [18,000], [#tvc-1],
    [2], [$18000 lt.eq Q lt.eq 36000$], [0.96], [#Qstar-2], [Yes], [#Qstar-2], [#tvc-2],
    [3], [$Q gt.eq 36000$], [0.92], [#Qstar-3], [No (too small)], [36,000], [#tvc-3],
  )
]

#align(center)[
  #let breaks = (200,) + q + (70000,)

  #lq.diagram(
    width: 10cm,
    height: 8cm,
    ylim: (220000, 260000),
    xaxis: (
      ticks: q.enumerate().map(v => (v.at(1), $q_#(v.at(0) + 1)$)),
      subticks: none,
    ),
    xlabel: [$Q$],
    ylabel: [$"TVC"(Q)$],

    ..p.enumerate().map(v => {
      let i = v.at(0)
      let ci = v.at(1)
      let xs = lq.linspace(breaks.at(i), breaks.at(i + 1), num: 100)
      lq.plot(xs, xs.map(Q => TVC(Q, ci)), mark: none,
        stroke: (thickness: 2pt), label: [$c = #ci$])
    }),

    ..p.enumerate().map(v => {
      let x = lq.linspace(200, breaks.last(), num: 200)
      lq.plot(x, x.map(Q => TVC(Q, v.at(1))), mark: none,
        stroke: (dash: "dashed", thickness: 1pt, paint: gray))
    }),

    lq.scatter((36000,), (tvc-3,), size: 10pt, color: black),
  )
]

$
  Q^* = #result([36,000])
$

*(b)* _What is the annual cost of such a policy? (5 points)_

$
  "TVC"(Q^*) = "TVC"(36000) = D(0.92) + D/36000 (300) + 36000/2 (0.15)(0.92) = #result([#tvc-3])
$

*(c)* _What is the cycle inventory of memory chips at Ericson? (5 points)_

$
  Q^* / 2 = 36000 / 2 = #result([18,000])
$

#v(1em)

*[(d)-(e)]* _The manufacturer now offers a "marginal" unit quantity discount for the chips. The
first 18,000 chips of any order are sold at \$1 per unit, the next 18,000 units are sold at \$0.96
and any quantity over 36,000 chips is sold for \$0.92 per unit._

*(d)* _What is the optimal lot size for Ericson given this pricing structure, what is the
resulting cost, and how does it compare with that in (a) and (b)? (10 points)_
 
$
  C_1 (Q) &= Q &&"for " 0 lt.eq Q lt.eq 18000 \
  C_2 (Q) &= 18000 + 0.96 (Q - 18000) quad quad &&"for " 18000 lt.eq Q lt.eq 36000 \
  C_3 (Q) &= 35280 + 0.92 (Q - 36000) &&"for " Q gt.eq 36000
$
 
$
  "TVC"_i (Q) = D / Q (S + C_i (Q)) + h / 2 C_i (Q)
$
 
$
  (dif "TVC"_i) / (dif Q) = - (D (S + R_i)) / Q^2 + (h p_i) / 2 = 0
  quad arrow.double quad
  Q^*_i = sqrt((2 D (S + R_i)) / (h p_i))
$
 
#let R = (0, 720.0, 2160.0)
#let Qstar-marg(i) = calc.round(calc.sqrt((2 * D * (S + R.at(i))) / (h * p.at(i))), digits: 2)
#let TVC-marg(Q, i) = {
  let C = R.at(i) + p.at(i) * Q
  D / Q * (S + C) + h / 2 * C
}
 
#let qm-1 = Qstar-marg(0)
#let qm-2 = Qstar-marg(1)
#let qm-3 = Qstar-marg(2)
 
#let tvcm-1 = calc.round(TVC-marg(18000, 0), digits: 2)
#let tvcm-2 = calc.round(TVC-marg(36000, 1), digits: 2)
#let tvcm-3 = calc.round(TVC-marg(qm-3, 2), digits: 2)
 
#align(center)[
  #table(
    columns: 7,
    inset: 0.8em,
    align: center + horizon,
    [*Bracket*], [*Range*], [*Price $p_i$*], [*$R_i$*], [*Unconstrained $Q^*_i$*], [*Feasible?*], [*$"TVC"_i$*],
    [1], [$0 lt.eq Q lt.eq 18000$], [1], [0], [#qm-1], [No (too large)], [#tvcm-1],
    [2], [$18000 lt.eq Q lt.eq 36000$], [0.96], [720], [#qm-2], [No (too large)], [#tvcm-2],
    [3], [$Q gt.eq 36000$], [0.92], [2160], [#qm-3], [*Yes*], [#tvcm-3],
  )
]
  
#align(center)[
  #let plot-domain = (500,) + q + (130000,)
 
  #lq.diagram(
    width: 13cm,
    height: 10cm,
    ylim: (225000, 260000),
    xaxis: (
      ticks: q.enumerate().map(v => (v.at(1), $q_#(v.at(0) + 1)$)),
      subticks: none,
    ),
    xlabel: [$Q$],
    ylabel: [$"TVC"(Q)$],
 
    ..p.enumerate().map(v => {
      let i = v.at(0)
      let xs = lq.linspace(plot-domain.at(i), plot-domain.at(i + 1), num: 100)
      lq.plot(xs, xs.map(Q => TVC-marg(Q, i)), mark: none,
        stroke: (thickness: 2pt), label: [$p_#(i + 1) = #v.at(1)$])
    }),
 
    ..p.enumerate().map(v => {
      let i = v.at(0)
      let xs = lq.linspace(plot-domain.first(), plot-domain.last(), num: 200)
      lq.plot(xs, xs.map(Q => TVC-marg(Q, i)), mark: none,
        stroke: (dash: "dashed", thickness: 1pt, paint: gray))
    }),
 
    lq.scatter((qm-3,), (tvcm-3,), size: 6pt, color: black),
  )
]
 
$
  Q^*_"marginal" = #result([#qm-3])
$
 
(compare to the bracket boundaries $18000$ and $36000$)
 
$
  "TVC"(Q^*_"marginal") = #result([#tvcm-3])
$

Comparison: the marginal-discount optimum requires ordering more than twice
as much per shipment (#qm-3 vs. 36,000) to reach a comparable cost level, and even so the
resulting annual cost, \$#tvcm-3, is higher than the all-units discount's \$#tvc-3.
 
*(e)* _What is the cycle inventory of memory chips at Ericson given the ordering policy? (5 points)_
 
$
  Q^*_"marginal" / 2 = #qm-3 / 2 = #result([#calc.round(qm-3 / 2, digits: 2)])
$

= Shipment aggregation (Max Points 20)

_LG, a refiner in Barcelona, serves three customers near Zaragoza, and maintains consignment
inventory (owned by LG) at each location. Demand at the large customer is 48 tons a year,
demand at the medium customer is 24 tons per year, and demand at the small customer is 12
tons per year. Product cost for LG is \$80,000 per ton and the annual unit holding cost has been
estimated to 15% of product cost. Currently, LG uses full-truckload transportation to deliver
separately to each customer. Truck capacity is 12 tons and each delivery costs \$700 plus \$150
per stop (thus, delivering to each customer separately costs \$850 per truck). LG is considering
aggregating deliveries to Zaragoza on a single truck._

#v(2em)

#let Dl = 48
#let Dm = 24
#let Ds = 12
#let C = 80000
#let h = 0.15
#let capacity = 12
#let S = 700
#let stop-cost = 150
#let H = C * h
#let n-cust = 3

#let Sl = S + stop-cost
#let Sm = S + stop-cost
#let Ss = S + stop-cost

- Demand
  - Large ($D_l$) = #Dl tons / year
  - Medium ($D_m$) = #Dm tons / year
  - Small ($D_s$) = #Ds tons / year
- Unit cost ($C$) = #C \$ / ton
- Holding cost rate ($h$) = #(h * 100) %
- Holding cost ($H = C h$) = #H \$ / ton / year
- Truck capacity ($M$) = #capacity tons / truck
- Major delivery cost ($S$) = #S \$ / delivery
- Minor stop cost ($s_i$) = #stop-cost \$ / stop
- Cost of a solo delivery ($S_i = S + s_i$) = #Sl \$ / truck

#v(2em)

*(a)* _What is the annual transportation and holding cost if LG ships a full truckload each time
a customer is running out of stock? How many days of inventory are carried at each customer
under this policy? (5 points)_

#let Qa = capacity

#let n-a-l = Dl / Qa
#let n-a-m = Dm / Qa
#let n-a-s = Ds / Qa

#let tr-a-l = n-a-l * Sl
#let tr-a-m = n-a-m * Sm
#let tr-a-s = n-a-s * Ss

#let h-a-l = (Qa / 2) * H
#let h-a-m = (Qa / 2) * H
#let h-a-s = (Qa / 2) * H

#let tc-a-l = tr-a-l + h-a-l
#let tc-a-m = tr-a-m + h-a-m
#let tc-a-s = tr-a-s + h-a-s
#let tc-a-total = tc-a-l + tc-a-m + tc-a-s

#let days-a-l = 365 * Qa / (2 * Dl)
#let days-a-m = 365 * Qa / (2 * Dm)
#let days-a-s = 365 * Qa / (2 * Ds)

Since every truck is full (#Qa tons), the number of deliveries per year is fixed by demand alone:
#calc.round(n-a-l, digits: 2) trips/year to the large customer, #calc.round(n-a-m, digits: 2) to
the medium customer, and #calc.round(n-a-s, digits: 2) to the small customer.

#table(
  columns: 5,
  [*Customer*], [*Deliveries/yr*], [*Transport cost*], [*Holding cost*], [*Total cost*],
  [Large], [#calc.round(n-a-l, digits: 2)], [\$#calc.round(tr-a-l, digits: 0)], [\$#calc.round(h-a-l, digits: 0)], [\$#calc.round(tc-a-l, digits: 0)],
  [Medium], [#calc.round(n-a-m, digits: 2)], [\$#calc.round(tr-a-m, digits: 0)], [\$#calc.round(h-a-m, digits: 0)], [\$#calc.round(tc-a-m, digits: 0)],
  [Small], [#calc.round(n-a-s, digits: 2)], [\$#calc.round(tr-a-s, digits: 0)], [\$#calc.round(h-a-s, digits: 0)], [\$#calc.round(tc-a-s, digits: 0)],
)

*Total annual cost = \$#calc.round(tc-a-total, digits: 0)* (transportation \$#calc.round(tr-a-l+tr-a-m+tr-a-s, digits: 0) + holding \$#calc.round(h-a-l+h-a-m+h-a-s, digits: 0)).

Days of inventory carried (average inventory ÷ average daily demand, $= 365 Q\/(2D)$):
large = #calc.round(days-a-l, digits: 1) days, medium = #calc.round(days-a-m, digits: 1) days,
small = #calc.round(days-a-s, digits: 1) days. Because every customer receives the *same* 12-ton
lot regardless of how fast it sells, the small customer (who only needs 12 tons a year) ends up
sitting on about half a year of stock.

#v(2em)

*(b)* _What is the optimal delivery policy to each customer if LG ships separately (not
necessarily full truckloads) to each of them? What is the annual transportation and holding
cost? How many days of inventory are carried at each customer under this policy? (5 points)_

#let Ql = calc.sqrt(2 * Dl * Sl / H)
#let Qm = calc.sqrt(2 * Dm * Sm / H)
#let Qs = calc.sqrt(2 * Ds * Ss / H)

#let TCl = calc.sqrt(2 * Dl * Sl * H)
#let TCm = calc.sqrt(2 * Dm * Sm * H)
#let TCs = calc.sqrt(2 * Ds * Ss * H)
#let TC_nonagg = TCl + TCm + TCs

#let n-b-l = Dl / Ql
#let n-b-m = Dm / Qm
#let n-b-s = Ds / Qs

#let days-b-l = 365 * Ql / (2 * Dl)
#let days-b-m = 365 * Qm / (2 * Dm)
#let days-b-s = 365 * Qs / (2 * Ds)

Dropping the full-truckload requirement lets each customer order its own economic lot size
$Q_i^* = sqrt(2 D_i S_i \/ H)$. These are all well under the #(capacity)-ton truck capacity, so a single
(partly empty) truck per delivery is still enough.

#table(
  columns: 5,
  [*Customer*], [*$Q^*$ (tons)*], [*Orders/yr*], [*Days of inventory*], [*Annual cost*],
  [Large], [#calc.round(Ql, digits: 2)], [#calc.round(n-b-l, digits: 2)], [#calc.round(days-b-l, digits: 1)], [\$#calc.round(TCl, digits: 0)],
  [Medium], [#calc.round(Qm, digits: 2)], [#calc.round(n-b-m, digits: 2)], [#calc.round(days-b-m, digits: 1)], [\$#calc.round(TCm, digits: 0)],
  [Small], [#calc.round(Qs, digits: 2)], [#calc.round(n-b-s, digits: 2)], [#calc.round(days-b-s, digits: 1)], [\$#calc.round(TCs, digits: 0)],
)

*Total annual (transportation + holding) cost = \$#calc.round(TC_nonagg, digits: 0)*, versus
\$#calc.round(tc-a-total, digits: 0) under policy (a). A saving of roughly
\$#calc.round(tc-a-total - TC_nonagg, digits: 0) simply from right-sizing each shipment instead of
always sending a full truck. Note transportation cost equals holding cost for each customer here
(a property of the EOQ optimum), and days of inventory now scale with demand instead of all being
identical.

#v(2em)

*(c)* _What is the optimal delivery policy to each customer if LG aggregates shipments to each
of the three customers on every truck that goes to Zaragoza? What is the annual
transportation and holding cost? How many days of inventory are carried at each customer
under this policy? (10 points)_

#let S-agg = S + n-cust * stop-cost
#let D-agg = Dl + Dm + Ds

#let Q-agg = calc.sqrt(2 * D-agg * S-agg / H)
#let TC-agg = calc.sqrt(2 * D-agg * S-agg * H)
#let n-agg = D-agg / Q-agg

#let t-agg = Q-agg / D-agg
#let t-agg-days = t-agg * 365
#let days-agg = 365 * t-agg / 2

#let q-c-l = t-agg * Dl
#let q-c-m = t-agg * Dm
#let q-c-s = t-agg * Ds

With aggregation, the truck makes one route to all #n-cust customers per trip, so the fixed cost
becomes $S_"agg" = S + n s_i = $ \$#S-agg, shared over the combined demand
$D_"agg" = $ #D-agg tons/year. Treating the pooled demand as a single EOQ problem:

$ Q_"agg"^* = sqrt(2 D_"agg" S_"agg" \/ H) = #calc.round(Q-agg, digits: 2) "tons per trip" $

which is comfortably under the #(capacity)-ton truck capacity, so one truck per cycle still
suffices. This implies #calc.round(n-agg, digits: 2) joint deliveries per year, i.e. a truck
every #calc.round(t-agg-days, digits: 1) days, split across customers in proportion to their
demand:

#table(
  columns: 3,
  [*Customer*], [*Shipment size per trip (tons)*], [*Days of inventory*],
  [Large], [#calc.round(q-c-l, digits: 2)], [#calc.round(days-agg, digits: 1)],
  [Medium], [#calc.round(q-c-m, digits: 2)], [#calc.round(days-agg, digits: 1)],
  [Small], [#calc.round(q-c-s, digits: 2)], [#calc.round(days-agg, digits: 1)],
)

Because all three customers are now replenished on the *same* synchronized cycle, they all carry
the *same* number of days of inventory (#calc.round(days-agg, digits: 1) days) even though their
lot sizes differ.

*Total annual (transportation + holding) cost = \$#calc.round(TC-agg, digits: 0)*, versus
\$#calc.round(TC_nonagg, digits: 0) under separate optimal delivery in (b). Representing a saving of \$#calc.round(TC_nonagg - TC-agg, digits: 0) (≈ #calc.round((TC_nonagg - TC-agg) / TC_nonagg * 100, digits: 1)%), and \$#calc.round(tc-a-total - TC-agg, digits: 0) versus the original full-truckload policy in (a).

*LG should aggregate deliveries to Zaragoza.*

= Power of two policies (Max Points 20)

_EasyWash is a washing machine manufacturer operating in Europe. One of its best-selling
models is produced in the firm's manufacturing site in Zaragoza and consists of three core
subassemblies: rotor, cylinder, and frame. While the rotor is manufactured in-house, the other
two subassemblies (cylinder and frame) are sourced from Asia. The cost for placing an order
with the cylinder supplier is 2,500\$, while the same cost for the frame is 600\$. Also, the annual
cost of holding one unit of inventory is equal to 75\$ for the cylinder and 50\$ for the frame.
The annual demand for the particular model is equal to 1,200 units (each machine consists of
one rotor, one cylinder, and one frame)._

_Assuming that availability of rotor is not an issue, the firm would like to coordinate the
procurement of the other two subassemblies (cylinder and frame) for logistics planning
purposes, by using “power of two” policies. What would be the optimal policies for the two
subassemblies, considering that the firm's planning team uses one week as the base planning
period (TB)? For each subassembly separately, please evaluate your policy's performance
(cost-wise) compared to the optimal one._

#let weeks-in-year = 52

#let TB = 1

#let D = 1200

#let Sc = 2500
#let Sf = 600

#let Hc = 75
#let Hf = 50

#let Qc = calc.sqrt((2 * D * Sc) / Hc)
#let Qf = calc.sqrt((2 * D * Sf) / Hf)

#let TCc = calc.sqrt(2 * D * Sc * Hc)
#let TCf = calc.sqrt(2 * D * Sf * Hf)

#let Tc = calc.sqrt((2 * Sc) / (D * Hc))
#let Tc = calc.round(Tc, digits: 2)

#let Tf = calc.sqrt((2 * Sf) / (D * Hf))
#let Tf = calc.round(Tf, digits: 2)

#let TVC-t(T, S, H) = S / T + (H * D) / 2 * T
#let TVC-t-weeks(T, S, H) = TVC-t(T / weeks-in-year, S, H)

#let x = lq.linspace(4, 16, num: 200)
#let y-c = x.map(x => TVC-t-weeks(x, Sc, Hc))
#let y-f = x.map(x => TVC-t-weeks(x, Sf, Hf))

Base period ($T_B$) = 1 week
$
  2^0 dot T_B = 1 "week" \
  2^1 dot T_B = 2 "week" \
  2^2 dot T_B = 4 "week" \
  2^3 dot T_B = 8 "week" \
  dots.v \
$

Since:

$
  Q = D T
$

Substitute $Q = D T$ into $"TVC"(Q)$:

$
  "TVC"(Q) = (S D) / Q + (H Q) / 2
$

Ordering term becomes:

$
  (S D) / Q = (S D) / (D T) = S / T
$

Holding term becomes:

$
  (H Q) / 2 = (H (D T)) / 2 = (H D) / 2 T
$

Therefore:

$
  "TVC"(T) = S / T + (H D) / 2 T
$

Taking the derivative:

$
  (dif "TVC"(T)) / (dif T) = -S / T^2 + (H D) / 2 = 0 quad arrow.double quad T^* = sqrt((2 S) / (H D))
$

#let t-opt-c = calc.sqrt((2 * Sc) / (Hc * D))
#let t-opt-c = calc.round(t-opt-c, digits: 2)
#let t-opt-c-week = t-opt-c * weeks-in-year
#let t-opt-c-week = calc.round(t-opt-c-week, digits: 2)

#let t-opt-f = calc.sqrt((2 * Sf) / (Hf * D))
#let t-opt-f = calc.round(t-opt-f, digits: 2)
#let t-opt-f-week = t-opt-f * weeks-in-year
#let t-opt-f-week = calc.round(t-opt-f-week, digits: 2)

#let tvc-opt-f = TVC-t-weeks(t-opt-f-week, Sf, Hf)
#let tvc-opt-f = calc.round(tvc-opt-f, digits: 2)
#let tvc-opt-c = TVC-t-weeks(t-opt-c-week, Sc, Hc)
#let tvc-opt-c = calc.round(tvc-opt-c, digits: 2)

Our optimal cycle time ($T^*$) for _cylinders_ is:

$
  T^*_c 
  &= sqrt((2 (#Sc)) / ((#Hc) #D)) \
  &= #t-opt-c
$

Convert from years to weeks: 

$
  T^*_c times #weeks-in-year
  &= #t-opt-c times #weeks-in-year \
  &= #t-opt-c-week \
$

Similarly for _frames_:

$
  T^*_f 
  &= sqrt((2 (#Sf)) / ((#Hf) #D)) \
  &= #t-opt-f
$

From years to weeks:

$ 
  T^*_f times #weeks-in-year
  &= #t-opt-f times #weeks-in-year \
  &= #t-opt-f-week \
$

#let x-ticks = (t-opt-c-week, t-opt-f-week, 4, 8, 16)
#let x-ticks = x-ticks.sorted()
#let x-ticks = x-ticks.map(t => (t, text(size: 8pt)[$#t$]))

#let y-ticks = (tvc-opt-f, tvc-opt-c)
#let y-ticks = y-ticks.sorted()
#let y-ticks = y-ticks.map(t => (t, text(size: 8pt)[$#t$]))

#align(center)[
  #lq.diagram(
    width: 10cm,
    height: 8cm,
    xlabel: [$T$],
    ylabel: [$"TVC"(T)$],
    xaxis: (
      ticks: x-ticks,
      subticks: none,
    ),
    yaxis: (
      ticks: y-ticks,
      subticks: none,
    ),
    lq.plot(x, y-c, mark: none, stroke: blue + 1.5pt, label: [Cylinder]),
    lq.plot(x, y-f, mark: none, stroke: orange + 1.5pt, label: [Frame]),
    lq.vlines(t-opt-c-week, max: TVC-t-weeks(t-opt-c-week, Sc, Hc), stroke: (paint: blue, thickness: 1pt, dash: "dashed")),
    lq.vlines(t-opt-f-week, max: TVC-t-weeks(t-opt-f-week, Sf, Hf), stroke: (paint: orange, thickness: 1pt, dash: "dashed")),
    lq.hlines(tvc-opt-f, max: t-opt-f-week, stroke: (paint: orange, thickness: 1pt, dash: "dashed")),
    lq.hlines(tvc-opt-c, max: t-opt-c-week, stroke: (paint: blue, thickness: 1pt, dash: "dashed")),
  )
]

We now want to find the power of 2 that braket $T^*$:

$
  2^k T_B lt.eq T^* lt.eq 2^(k+1) T_B
$

For _cylinder_:

$ 
  2^3 T_B lt.eq T^*_c lt.eq 2^4 T_B 
$

Since $T^*_c$ is closer to 16, we order every 16 weeks.

For _frame_:

$ 
  2^2 T_B lt.eq T^*_f lt.eq 2^3 T_B 
$

Since $T^*_f$ is closer to 8, we order every 8 weeks.

Thus,

$
  T_c = 16 "weeks" \
  T_f = 8 "weeks" \
$

To compare the optimal with our new constrained schedule:

#let Tc = 16
#let Tf = 8

#let tvc-c = TVC-t-weeks(Tc, Sc, Hc)
#let tvc-f = TVC-t-weeks(Tf, Sf, Hf)


#let delta-t-c = tvc-c / tvc-opt-c - 1
#let delta-t-c = calc.round(delta-t-c, digits: 3)

#let delta-t-f = tvc-f / tvc-opt-f - 1
#let delta-t-f = calc.round(delta-t-f, digits: 3)
$
  "TVC"(T^*_c) = #tvc-opt-c \
  "TVC"(T_c) = #tvc-c \
  Delta = #delta-t-c lt 0.06
$

And

$
  "TVC"(T^*_f) = #tvc-opt-f \
  "TVC"(T_f) = #tvc-f \
  Delta = #delta-t-f lt 0.06
$

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
  macron(I) = 1/2 (1 + D / P), quad Q^* = sqrt((2 D S) / (H (1 + D / P))), quad "TCV"(Q^*) = sqrt(2 D S H (1 + D / P))
$

_(Hint: consider, to avoid running out of stock, what are the maximum and minimum inventory
values for this system). (7 points)_

*Optimal Production Quantity*

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
 
Since $D, S, Q > 0$, $(dif^2 "TVC")/(dif Q^2) > 0$ for all $Q > 0$, confirming $"TVC"(Q)$ is convex and the critical point $Q^* = sqrt((2 D S) / (H (1 - D/P)))$ is a minimum.

$
  "TVC"(Q) = S D / Q + H (1 - D / P) Q / 2
$

#align(center)[
  #result[
    $
      (dif "TCV"(Q)) / (dif Q) = = 0 quad arrow.double quad Q^* = sqrt((2 D S) / (H (1 + D / P)))
    $
  ]
]

*Total variable Cost*

$
  "TVC"(Q) = S D / Q^* + H (1 - D / P) Q^* / 2 
  quad quad quad 
  Q^* = sqrt((2 D S) / (H (1 + D / P)))
$

$
  "TVC"(Q^*) = S D / (sqrt((2 D S) / (H (1 + D / P)))) + H (1 - D / P) (sqrt((2 D S) / (H (1 + D / P)))) / 2 
$

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