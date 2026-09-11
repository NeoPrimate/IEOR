#import "@preview/lilaq:0.6.0" as lq

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
#let monthly-production-rate = 150
#let yearly-production-rate = monthly-production-rate * months-per-year

#let S-days = 3
#let S-daily-cost = 1000
#let S = S-days * S-daily-cost

#let c = 15000
#let p = 25000

#let h = 0.15
#let H = h * c

#let eoq(D, S, H) = calc.sqrt((2 * D * S) / H)

#let q-star = eoq(D, S, H)
#let q-star = calc.round(q-star, digits: 2)

#let purchase-cost = c * D
#let ordering-cost(Q) = S * (D / Q)
#let holding-cost(Q) = H * (Q / 2)

#let TC(Q) = purchase-cost + ordering-cost(Q) + holding-cost(Q)
#let TVC(Q) = ordering-cost(Q) + holding-cost(Q)

#let total-revenue = p * D
#let TP(Q) = total-revenue - TC(Q)

#let total-profit = q-star * (p - c)

#let cum-ordering-cost(Q) = purchase-cost + ordering-cost(Q)
#let cum-holding-cost(Q) = purchase-cost + holding-cost(Q)

- Demand ($D$) = #D units / year
- Sell Price (p) = #p \$ / unit
- Cost (c) = #c \$ / unit
- Setup Cost (S) = #S \$ / order
- Production rate (monthly) = #monthly-production-rate units / month
- Production rate (yearly) = #yearly-production-rate units / year
- Holding cost rate (h) = #(h * 100) % / unit / year
- Holding cost (H) = #H \$ / unit / year

#v(2em)

*(a)* _How many cars shall Hyundai produce whenever it starts the facility to maximize the total profit in the long run? (5 points)_

The total cost is given by the function:

$
  "TP"(Q) 
  &= "TR" - "TC"(Q) \
  &= underbrace(p D, "Total\nRevenue") - underbrace(c D, "Purchasing\nCost") quad - quad underbrace(S D / Q, "Ordering\nCost") quad - quad underbrace(H Q / 2, "Holding\nCost")
$

Maximize the total profit w.r. to $Q$:

$
  Q^* = op(arg min, limits: #true)_Q "TP"(Q)
$

Setting the derivative equal to zero to find the critical point:

$
  (dif "TP") / (dif Q) 
  &= dif / (dif Q) [p D - c D - S D / Q - H Q / 2] \
  &= dif / (dif Q) [p D] - dif / (dif Q) [c D] - dif / (dif Q) [S D / Q] - dif / (dif Q) [H Q / 2] \
  &= 0 - 0 - dif / (dif Q) [S D dot Q^(-1)] - H/2 dif / (dif Q) [Q] \
  &= - S D dot dif / (dif Q) [Q^(-1)] - H/2 dot 1 \
  &= - S D dot (-1) Q^(-2) - H/2 \
  &= S D / Q^2 - H/2
$

Setting the derivative equal to zero to find the critical point:

$
  S D / Q^2 - H/2 &= 0 \
  H/2 &= (D S) / Q^2 \
  Q^2 &= (2 D S) / H \
  Q &= sqrt((2 D S) / H)
$

To confirm this critical point is a maximum rather than a minimum, check the second derivative:

$
  (dif^2 "TP") / (dif Q^2)
  &= (dif) / (dif Q) [(D S) / Q^2 - H/2] \ \
  &= (dif) / (dif Q) [D S Q^(-2)] - (dif) / (dif Q) [H/2] \ \
  &= D S dot (dif) / (dif Q) [Q^(-2)] - 0 \ \
  &= D S dot (-2) Q^(-3) \ \
  &= -(2 D S) / Q^3
$

Since $D, S, Q > 0$, $(dif^2 "TP")/(dif Q^2) < 0$ for all $Q > 0$, confirming $"TP"(Q)$ is concave and the critical point $Q^* = sqrt((2 D S) / H)$ is indeed a maximum.

Using the formula we derived:

$
  Q^* 
  &= sqrt((2 D S) / H) \
  &= sqrt((2 (#D) (#c)) / #H) \
  &= #q-star
$

Therefore, the total profit:

$
  "TP"(Q^*) 
  &= c D + S D / Q + H Q / 2 \
  &= (#p)(#D) - (#c)(#D) - #S #D / #q-star - #H #q-star / 2 \
  &= #TP(q-star)
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
    lq.plot(x, y-tp, mark: none, stroke: black + 1.5pt, label: [TC]),
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
  &= underbrace(c D, "Purchasing\nCost") quad + quad underbrace(S D / Q, "Ordering\nCost") quad + quad underbrace(H Q / 2, "Holding\nCost") 
$

Minimize the total cost w.r. to $Q$:

$
  Q^* = op(arg min, limits: #true)_Q "TC"(Q)
$

Find the first derivative of the total cost function:

$
  (dif "TC") / (dif Q)
    &= (dif) / (dif Q) [ S D/Q + H Q/2 ] \ \
    &= (dif) / (dif Q) (D S Q^(-1)) + (dif) / (dif Q) (H/2 Q) \ \
    &= D S dot (dif) / (dif Q) (Q^(-1)) + H/2 dot (dif) / (dif Q) (Q) \ \
    &= D S dot (-1) Q^(-2) + H/2 dot 1 \ \
    &= -(D S) / Q^2 + H/2
$

Setting the derivative equal to zero to find the critical point:

$
  -(D S) / Q^2 + H/2 &= 0 \ \
  H/2 &= (D S) / Q^2 \ \
  Q^2 &= (2 D S) / H \ \
  Q &= sqrt((2 D S) / H)
$

To confirm this critical point is a minimum rather than a maximum, check the second derivative:

$
  (dif^2 "TC") / (dif Q^2)
    &= (dif) / (dif Q) [-(D S) / Q^2 + H/2] \ \
    &= (dif) / (dif Q) [-D S Q^(-2)] + (dif) / (dif Q) [H/2] \ \
    &= -D S dot (dif) / (dif Q) [Q^(-2)] + 0 \ \
    &= -D S dot (-2) Q^(-3) \ \
    &= (2 D S) / Q^3
$

Since $D, S, Q > 0$, $(dif^2 "TC")/(dif Q^2) > 0$ for all $Q > 0$, confirming $"TC"(Q)$ is convex and the critical point $Q^* = sqrt((2 D S) / H)$ is indeed a minimum.

Using the formula we derived:

$
  Q^* 
  &= sqrt((2 D S) / H) \
  &= sqrt((2 (#D) (#c)) / #H) \
  &= #q-star
$

Therefore, the total cost:

$
  "TC"(Q^*) 
  &= c D + S D / Q + H Q / 2 \
  &= (#c)(#D) + #S #D / #q-star + #H #q-star / 2 \
  &= #TC(q-star)
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
    lq.plot(x, y-tc, mark: none, stroke: black + 1.5pt, label: [TC]),
    lq.plot(x, y-cum-ordering-cost, mark: none, stroke: green + 1.5pt, label: [Holding Cost]),
    lq.plot(x, y-cum-holding-cost, mark: none, stroke: blue + 1.5pt, label: [Ordering Cost]),
    lq.vlines(q-star, stroke: (paint: red, dash: "dashed", thickness: 1.5pt)),
    lq.hlines(TC(q-star), stroke: (paint: red, dash: "dashed", thickness: 1.5pt)),
  )
]

And total variable cost:

$
  "TVC"(Q^*) 
  &= sqrt(2 D S H) \
  &= sqrt(2 (#D) (#S) (#H)) \
  &= #TVC(q-star)
$

#align(center)[
  #let x = lq.linspace(10, 150, num: 200)
  #let y-tc = x.map(TVC)
  #let y-holding-cost = x.map(holding-cost)
  #let y-ordering-cost = x.map(ordering-cost)

  #lq.diagram(
    width: 25em,
    height: 20em,
    xlabel: [$Q$],
    ylabel: [$"TVC"(Q)$],
    // xaxis: (ticks: (q-star,)),
    // yaxis: (ticks: (TVC(q-star),)),
    lq.plot(x, y-tc, mark: none, stroke: black + 1.5pt, label: [TC]),
    lq.plot(x, y-holding-cost, mark: none, stroke: blue + 1.5pt, label: [Holding Cost]),
    lq.plot(x, y-ordering-cost, mark: none, stroke: green + 1.5pt, label: [Ordering Cost]),
    lq.vlines(q-star, stroke: (paint: red, dash: "dashed", thickness: 1.5pt)),
    lq.hlines(TVC(q-star), stroke: (paint: red, dash: "dashed", thickness: 1.5pt)),
  )
]

#v(2em)

*(c)* _How many days per year shall the facility be idle for (b) above? (5 points)_

#q-star

#yearly-production-rate

*(d)* _What is the average inventory level for (b) above in the long run? (5 points)_

#(q-star / 2)

*(e)* _How much is the average total profit per year in the long run? (5 points)_

$
  "Total Profit" 
  &= Q^* (p - c) \
  &= #q-star (#p - #c) \
  &= #total-profit
$

*(f)* _Now the company has a new constraint on the production batch size and the production quantity should be a multiple of 40, i.e., 40 - 80 - 120 - 160 - ..., whenever it runs the facility. How much is the optimal production quantity to minimize the long-run cost? (5 points)_




