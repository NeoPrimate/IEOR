#import "@preview/cetz:0.3.4"
#import "@preview/cetz-plot:0.1.1"
#import "@preview/cetz:0.4.0": canvas, draw, tree

#import "../../../utils/examples.typ": eg
#import "../../../utils/code.typ": code

== Safety Stock

Additional quantity of inventory kept on hand to protect against uncertainties in demand or supply. Buffer to prevent stockouts due to unexpected variations in demand or delays in supply.

2 reasons to keep safety stock:

- Variation in Demand

#align(center)[
  #cetz.canvas({
    import cetz.draw: *

    line((0, 0), (10, 0), name: "x_axis")
    line((0, 0), (0, 5.5), name: "y_axis")

    // tri 1
    line((0, 5), (4, 1))
    //tri 2
    line((4, 1), (4, 5))
    line((), (8, 1))

    line((0, 5), (4, 0), stroke:(dash:"dashed", paint: red, thickness: 2pt))
    line((4, 0), (4, 5), stroke:(dash:"dashed", paint: red, thickness: 2pt))
    line((), (8, 1), stroke:(dash:"dashed", paint: red, thickness: 2pt))

    line((0,1), (9.5,1), name: "s")

    set-style(mark:(symbol:"straight"))
    line((-1,0),(-1,1), name:"fixed_order_quantity")

    content(
      ("fixed_order_quantity.start", 50%,"fixed_order_quantity.end"),
    angle:0deg,
    padding: 0.25,
    [#box(align(center)[#text(8pt, "Safety Stock")], fill:white, inset:0.5em)])
  })
]

- Variation in Lead Time

#align(center)[
  #cetz.canvas({
    import cetz.draw: *

    line((0, 0), (10, 0), name: "x_axis")
    line((0, 0), (0, 5.5), name: "y_axis")

    // tri 1
    line((0, 5), (4, 1))
    //tri 2
    line((4, 1), (4, 5))
    line((), (8, 1))

    line((0, 5), (5, 0), stroke:(dash:"dashed", paint: red, thickness: 2pt))
    line((5, 0), (5, 5), stroke:(dash:"dashed", paint: red, thickness: 2pt))
    line((), (9, 1), stroke:(dash:"dashed", paint: red, thickness: 2pt))

    line((0,1), (9.5,1), name: "s")

    set-style(mark:(symbol:"straight"))
    line((-1,0),(-1,1), name:"fixed_order_quantity")

    content(
      ("fixed_order_quantity.start", 50%,"fixed_order_quantity.end"),
    angle:0deg,
    padding: 0.25,
    [#box(align(center)[#text(8pt, "Safety Stock")], fill:white, inset:0.5em)])
  })
]


*1. Constant Demand & Constant Lead Time*

$
"SS" = Z times sigma_D
$

Where:

- $Z$: Z-score corresponding to the desired service level
- $sigma$: standard deviation of demand


*2. Variable Demand & Constant Lead Time*


$
"SS" = Z times sigma_D times sqrt(L)
$

Where:

- $Z$: Z-score corresponding to the desired service level
- $sigma_D$: Standard deviation of demand per unit of time
- $L$: Lead time

*3. Variable Lead Time & Constant Demand*

$
"SS" = Z times macron(D) times sigma_L
$

Where:

- $Z$: Z-score corresponding to the desired service level
- $macron(D)$: Average demand
- $sigma_L$: Standard deviation of lead time

*4. Variable Demand & Variable Lead Time*

$
"SS" = Z times sqrt((macron(D)^2 times sigma_L^2) + (L times sigma_D^2))
$

Where:

- $macron(L)$: Average Lead Time (average time it takes to receive inventory after placing an order)
- $sigma_D^2$: Demand Variance (variability in demand during the lead time)
- $macron(D)$: Average Demand (mean quantity of demand per time period)
- $sigma_L^2$: Lead Time Variance (variability in lead time)

== Risk Pooling 

Standard deviation does not scale linearly

#eg[

  - Total Demand $D$: 100 units / day
  - Standard Deviation Demand $sigma_"total"$: 20 units / day
  - Lead Time $L$: 1 day
  - Service Level $z$: 1.65 ($approx 95%$)

  *Case 1*: Single Warehouse

  One warehouse serves all customers

  $
    "SS" 
    &= z dot sigma_"total" dot sqrt(L) \
    &= 1.65 dot 20 dot sqrt(1) \
    &= 33 "units"
  $

  *Case 2*: Four warehouses

  Customers are split evenly across 4 warehouses

  $
    sigma_"per_warehouse" = sigma_"total" / sqrt(4) = 20 / 2 = 10
  $

  Safety stock per warehouse:

  $
    "SS"_"per_warehouse" 
    &= z dot sigma_"per_warehouse" dot sqrt(L) \
    &= 1.65 dot 10 dot sqrt(1) \ 
    &= 16.5 \
  $

  Total safety stock across 4 warehouses:

  $
    "SS"_"total" = 4 dot 16.5 = 66 "units"
  $

]