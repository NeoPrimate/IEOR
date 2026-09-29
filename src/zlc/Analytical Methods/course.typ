#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge

#set text(font: "Helvetica", size: 8pt)

= Analytical Methods

- Demand
- Capacity
- Lead Time
- Yield
- Multiple Products
- Bundling
- Discounts

#let y-offset = 0.5
#let tint(c) = (stroke: c, fill: rgb(..c.components().slice(0,3), 5%), inset: 8pt)

#diagram(
	node-corner-radius: 4pt,

	node((0,y-offset * 1), $a$, name: <a>),
	node((0,y-offset * 2), $b$, name: <b>),
	node((0,y-offset * 3), $c$, name: <c>),
	node((0,y-offset * 4), $d$, name: <d>),
	
  node((1,y-offset * 1), $1$, name: <1>),
  node((1,y-offset * 2), $2$, name: <2>),
  node((1,y-offset * 3), $3$, name: <3>),
  node((1,y-offset * 4), $4$, name: <4>),

  node(enclose: (<a>, <b>, <c>, <d>), align(top + left)[$X$], ..tint(teal), name: <X>),
  node(enclose: (<1>, <2>, <3>, <4>), align(top + right)[$Y$], ..tint(teal), name: <Y>),

  edge(<a>, <1>, "-|>"),
  edge(<b>, <2>, "-|>"),
  edge(<c>, <3>, "-|>"),
)



Exercise 1.

$
  max quad &z = (80 - 20) a + (100 - 25) b \
  s.t. quad 
  &0.2 a + 0.5 b lt.eq 60 \
  &a lt.eq 200 \
  &b lt.eq 110 \
  &a gt.eq 0  \
  &b gt.eq 0  \
$

Constraints

$
  0.2 a + 0.5 b lt.eq 60
  \ \
  a = 0 arrow.double 0.5 b = 60 arrow.double b = 120
  \ \
  b = 0 arrow.double 0.2 a = 60 arrow.double a = 300
$

Objective function

$
  60 a + 75 b
  \ \
  a = 0 arrow.double
  \ \
  b = 0 arrow.double
$

1. Define decision variables
2. Define objective function
3. Define constraints

Assumptions:
- Linearity
- Divisibility (fractional $eq.not$ whole number)
- Certainty (parameters non stochastic)
- Non-negativity

== Diet Problem

Value ($a_i$)
#table(
  columns: 5,
  [], [Vitamine], [Protein], [Calcium], [Fat], 
  [Corn], [8], [5], [6], [8], 
  [Beef], [2], [5], [10], [8], 
  [Soy], [6], [12], [6], [4], 
  [Fish], [8], [18], [6], [5], 
)

Bounds ($L_j, U_j$)
- Vitamine:
  - Min: 60
  - Max: N.A
- Protein:
  - Min: 300
  - Max: N.A
- Calcium:
  - Min: 70
  - Max: N.A
- Fat:
  - Min: 40
  - Max: 200

Availability ($s_i$):
- Corn: 10
- Beef: 6
- Soy: 4
- Fish: 5

Cost ($c_i$)
- Corn: 60 c
- Beef: 400c
- Soy 75 c
- Fish: 350 c

Notation

- Ingredients: $i in I$
- Nutrients: $j in J$

Decision variables

- $x_i$: kgs of ingredient $i$ in the meal


$
  min quad & sum_(i in I) c_i x_i  \
  s.t. quad
  & x_i lt.eq s_i &quad quad forall i in I\
  & sum_(i in I) a_(i j) x_i gt.eq L_j &quad quad forall j in J \
  & sum_(i in I) a_(i j) x_i lt.eq U_j &quad quad forall j in J \
  & x_i gt.eq 0 &quad quad forall i in I \
$

== Scheduling Problem

Requirements 

- 12-4: 5
- 4-8: 7
- 8-12: 15
- 12-4: 8
- 4-8: 12
- 8-12: 8

8 Consecutive hours

Minimum number of officers to cover all shifts

Shifts:

- 1: 12-8
- 2: 4-12
- 3: 8-4
- 4: 12-8
- 5: 4-12
- 6: 8-4

$x_i$: number of employees assigned to shift $i$

$
  min quad &z = sum_(i = 1)^6 x_i \
  s.t. quad
  & x_i gt.eq s_i \
  & x_1 + x_6 gt.eq 5 \
  & x_1 + x_2 gt.eq 7 \
  & x_2 + x_3 gt.eq 15 \
  & x_3 + x_4 gt.eq 8 \
  & x_4 + x_5 gt.eq 12 \
  & x_5 + x_6 gt.eq 9 \
  &x_i gt.eq 0, quad forall i in {1, 2, dots, 6} \
$

=== Compact Form

- $L_j$: \# of peple needed during time period $j$ ($j = 1, dots, 6$)

$
  L = vec(5, 7, 18, 8, 12, 9)
$

- $T_(i j) = cases(
  1 quad "if work shift" i "covers period" j,
  0 quad "otherwise"
)$

$
  T = mat(
    0, 1, 0, 0, 0, 1;
    1, 1, 0, 0, 0, 0;
    0, 1, 1, 0, 0, 0;
    0, 0, 1, 1, 0, 0;
    0, 0, 0, 1, 1, 0;
    0, 0, 0, 0, 1, 1;
  )
$

$
  min quad 
  &z = sum_(i=1)^6 x_i \
  s.t. quad
  &sum_(i=1)^6 T_(i j) dot x_i gt.eq L_j quad forall j in {1, dots, 6} \
  &x_i gt.eq 0, quad forall i in {1, dots, 6}
$

== Dynamic Pricing

#table(
  columns: 6,
  [Price Levels ($p$)], [60], [54], [48], [36], [25], 
  [Demand Multiplier], [1], [1.5], [1.75], [2], [inf],
  [Weekly Demand ($d$)], [100], [150], [175], [200], [inf], 
)

- $x_i$: \# of weeks during which I charge a price level $i$
  - $x_60$: \# of weeks during which I charge a price level \$$60$
  - $x_54$: \# of weeks during which I charge a price level \$$54$
  - $x_48$: \# of weeks during which I charge a price level \$$48$
  - $x_36$: \# of weeks during which I charge a price level \$$36$
  - $x_s$: \# of units salvaged
- $p_i$: Price
- $d_i$: Demand associated with price $i$
- $D$: Total demand (2500)
- $W$: \# of weeks (15)

$
  max quad 
  &z = sum_(i=1)^4 underbrace(p_i, "price") dot underbrace(x_i dot d_i, "sales") + underbrace(x_s dot s, "salvage") \
  s.t. quad
  &sum_(i=1)^5 x_i lt.eq W \
  &sum_(i=1)^5 d_i x_i lt.eq D \
  &x_i gt.eq 0 quad forall i in {1, dots, 5} \
$

== Network Flow Problems



