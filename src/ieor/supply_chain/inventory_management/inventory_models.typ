#import "@preview/cetz:0.3.4"

#import "../../../utils/examples.typ": eg
#import "../../../utils/code.typ": code

== Dimensions

1. Inventory Review Policy

    - Reorder Point: An order is placed when inventory falls below a specific threshold
    - Periodic Review: Inventory is reviewed and ordered at regular time intervals

2. Order Quantities

  - Fixed Order Quantity: A predetermined quantity is ordered each time
  - Order-Up-to-Level: Inventory is replenished up to a set maximum level during reviews

3. Ordering Policy

  - Continuous Review: Inventory levels are monitored continuously
  - Periodic Review: Inventory levels are reviewed at specific intervals

4. Lead Time

  - Constant Lead Time: The time between placing an order and receiving it is fixed
  - Variable Lead Time: The lead time can fluctuate

5. Demand

  - Stochastic Demand: Demand is random and follows a probability distribution
  - Deterministic Demand: Demand is known in advance and does not change

== (s, Q)

Continuous Review, Fixed-Order Quantity Policy

Parameters:

- $s$: Reorder point
- $Q$: Fixed order quantity

Steps:

- Inventory is continuously reviewed
- When the inventory level falls below the reorder point $s$, a fixed quantity $Q$ is ordered

#align(center)[
  #cetz.canvas({
    import cetz.draw: *

    line((0, 0), (9 ,0), name: "x_axis")
    line((0, 0), (0, 5.5), name: "y_axis")

    // tri 1
    line((0, 5), (4, 1))
    //tri 2
    line((4, 1), (4, 5))
    line((), (8, 1))

    line((0,1), (9.5,1), name: "s")

    circle((4, 1), radius: 0.1, fill: black, name: "A")
    circle((8, 1), radius: 0.1, fill: black, name: "B")

    line((4, 0), (4, 5), stroke:(dash:"dashed"), name:"reorder_point_1")
    line((8, 0), (8, 5), stroke:(dash:"dashed"), name:"reorder_point_2")

    content("reorder_point_1.start",
    padding: 0.25,
    anchor: "north",
    [#text(8pt, "Order\nRelease")])

    content("reorder_point_2.start",
    padding: 0.25,
    anchor: "north",
    [#text(8pt, "Order\nRelease")])

    set-style(mark:(symbol:"straight"))
    line((-0.5,1),(-0.5,5), name:"fixed_order_quantity")

    content(("fixed_order_quantity.start", 50% ,"fixed_order_quantity.end"),
    angle:-90deg,
    padding:0.25,
    [#box(align(center)[#text(8pt, "Fixed Order\nQuantity (Q)")], fill:white, inset:0.5em)])

    content(("s.start", 100% ,"s.end"),
    angle:0deg,
    padding:0.25,
    [#box(align(center)[#text(10pt, "Reoder Point\n(s)")], fill:white, inset:0.5em)])
  })
]

#eg[
  #figure(image("../../../vis/s_Q.png", width: 60%))

]

== (R, s, S)

Periodic Review, Order-Up-to-S Policy

Parameters:

- $R$: Review period
- $s$: Reorder point
- $S$: Target stock level (maximum level to which inventory is replenished)

Steps:

- Inventory is reviewed every $R$ periods
- If the inventory level drops below the reorder point $s$, an order is placed to bring the inventory up to the level $S$
- This policy ensures that inventory is maintained between $s$ and $S$

#align(center)[
  #cetz.canvas({
    import cetz.draw: *

    line((0, 0), (9 ,0), name: "x_axis")
    line((0, 0), (0, 5.5), name: "y_axis")

    // tri 1
    line((0, 5), (4, 1))
    //tri 2
    line((4, 1), (4, 5))
    line((), (8, 1))

    line((0,1), (9.5,1), name: "s")
    line((0,5), (9.5,5), name: "S")

    circle((4, 1), radius: 0.1, fill: black, name: "A")
    circle((8, 1), radius: 0.1, fill: black, name: "B")

    line((2, 0), (2, 5), stroke:(dash:"dashed"), name:"review_1")

    line((4, 0), (4, 5), stroke:(dash:"dashed"), name:"review_2")

    line((6, 0), (6, 5), stroke:(dash:"dashed"), name:"review_3")

    line((8, 0), (8, 5), stroke:(dash:"dashed"), name:"review_4")

    content("review_1.start",
    padding: 0.25,
    anchor: "north",
    [#text(8pt, "Review")])

    content("review_2.start",
    padding: 0.25,
    anchor: "north",
    [#text(8pt, "Review")])

    content("review_3.start",
    padding: 0.25,
    anchor: "north",
    [#text(8pt, "Review")])

    content("review_4.start",
    padding: 0.25,
    anchor: "north",
    [#text(8pt, "Review")])

    set-style(mark:(symbol:"straight"))
    line((0,0.5),(2,0.5), name:"R_1")
    line((2,0.5),(4,0.5), name:"R_2")
    line((4,0.5),(6,0.5), name:"R_3")
    line((6,0.5),(8,0.5), name:"R_4")

    content(("R_1.start", 50% ,"R_1.end"),
    angle:0deg,
    padding:0.25,
    [#box(align(center)[#text(8pt, "R")], fill:white, inset:0.5em)])

    content(("R_2.start", 50% ,"R_2.end"),
    angle:0deg,
    padding:0.25,
    [#box(align(center)[#text(8pt, "R")], fill:white, inset:0.5em)])

    content(("R_3.start", 50% ,"R_3.end"),
    angle:0deg,
    padding:0.25,
    [#box(align(center)[#text(8pt, "R")], fill:white, inset:0.5em)])

    content(("R_4.start", 50% ,"R_4.end"),
    angle:0deg,
    padding:0.25,
    [#box(align(center)[#text(8pt, "R")], fill:white, inset:0.5em)])

    content(("s.start", 100% ,"s.end"),
    angle:0deg,
    padding:0.25,
    [#box(align(center)[#text(10pt, "Reoder Point\n(s)")], fill:white, inset:0.5em)])
    
    content(("S.start", 100% ,"S.end"),
    angle:0deg,
    padding:0.25,
    [#box(align(center)[#text(10pt, "Up-to-Level\n(S)")], fill:white, inset:0.5em)])

  })
]

#eg[
  #figure(image("../../../vis/R_s_S.png", width: 60%))

]

== (s, S) (Continuous Review)

Continuous review model

Parameters:

- $s$: Reorder Point
- $S$: Order-up-to Level

Steps:

- When the inventory level drops to or below the reorder point $s$, an order is placed to bring the inventory back up to the target level $S$

#align(center)[
  #cetz.canvas({
    import cetz.draw: *

    line((0, 0), (9 ,0), name: "x_axis")
    line((0, 0), (0, 5.5), name: "y_axis")

    // tri 1
    line((0, 5), (4, 1))
    //tri 2
    line((4, 1), (4, 5))
    line((), (8, 1))

    line((0,1), (9.5,1), name: "s")
    line((0,5), (9.5,5), name: "S")

    circle((4, 1), radius: 0.1, fill: black, name: "A")
    circle((8, 1), radius: 0.1, fill: black, name: "B")

    line((4, 0), (4, 5), stroke:(dash:"dashed"), name:"reorder_point_1")
    line((8, 0), (8, 5), stroke:(dash:"dashed"), name:"reorder_point_2")

    content("reorder_point_1.start",
    padding: 0.25,
    anchor: "north",
    [#text(8pt, "Order\nRelease")])

    content("reorder_point_2.start",
    padding: 0.25,
    anchor: "north",
    [#text(8pt, "Order\nRelease")])

    content(("s.start", 100% ,"s.end"),
    angle:0deg,
    padding:0.25,
    [#box(align(center)[#text(10pt, "Reoder Point\n(s)")], fill:white, inset:0.5em)])
    
    content(("S.start", 100% ,"S.end"),
    angle:0deg,
    padding:0.25,
    [#box(align(center)[#text(10pt, "Up-to-Level\n(S)")], fill:white, inset:0.5em)])
  })
]

#eg[
  #figure(image("../../../vis/s_S.png", width: 60%))

]


== (R, s, Q)

Periodic Review, Fixed-Order Quantity

Parameters:

- $R$: Review period
- $s$: Reorder point
- $Q$: Fixed order quantity

Steps:

- Inventory is reviewed at regular intervals every $R$ time periods
- If the inventory level is below $s$ at the time of review, a fixed order quantity $Q$ is placed

#align(center)[
  #cetz.canvas({
    import cetz.draw: *

    line((0, 0), (9 ,0), name: "x_axis")
    line((0, 0), (0, 5.5), name: "y_axis")

    // tri 1
    line((0, 5), (4, 1))
    //tri 2
    line((4, 1), (4, 5))
    line((), (8, 1))

    line((0,1), (9.5,1), name: "s")

    circle((4, 1), radius: 0.1, fill: black, name: "A")
    circle((8, 1), radius: 0.1, fill: black, name: "B")

    line((2, 0), (2, 5), stroke:(dash:"dashed"), name:"review_1")

    line((4, 0), (4, 5), stroke:(dash:"dashed"), name:"review_2")

    line((6, 0), (6, 5), stroke:(dash:"dashed"), name:"review_3")

    line((8, 0), (8, 5), stroke:(dash:"dashed"), name:"review_4")

    content("review_1.start",
    padding: 0.25,
    anchor: "north",
    [#text(8pt, "Review")])

    content("review_2.start",
    padding: 0.25,
    anchor: "north",
    [#text(8pt, "Review")])

    content("review_3.start",
    padding: 0.25,
    anchor: "north",
    [#text(8pt, "Review")])

    content("review_4.start",
    padding: 0.25,
    anchor: "north",
    [#text(8pt, "Review")])

    set-style(mark:(symbol:"straight"))
    line((0,0.5),(2,0.5), name:"R_1")
    line((2,0.5),(4,0.5), name:"R_2")
    line((4,0.5),(6,0.5), name:"R_3")
    line((6,0.5),(8,0.5), name:"R_4")

    content(("R_1.start", 50% ,"R_1.end"),
    angle:0deg,
    padding:0.25,
    [#box(align(center)[#text(8pt, "R")], fill:white, inset:0.5em)])

    content(("R_2.start", 50% ,"R_2.end"),
    angle:0deg,
    padding:0.25,
    [#box(align(center)[#text(8pt, "R")], fill:white, inset:0.5em)])

    content(("R_3.start", 50% ,"R_3.end"),
    angle:0deg,
    padding:0.25,
    [#box(align(center)[#text(8pt, "R")], fill:white, inset:0.5em)])

    content(("R_4.start", 50% ,"R_4.end"),
    angle:0deg,
    padding:0.25,
    [#box(align(center)[#text(8pt, "R")], fill:white, inset:0.5em)])

    content(("s.start", 100% ,"s.end"),
    angle:0deg,
    padding:0.25,
    [#box(align(center)[#text(10pt, "Reoder Point\n(s)")], fill:white, inset:0.5em)])

    set-style(mark:(symbol:"straight"))
    line((-0.5,1),(-0.5,5), name:"fixed_order_quantity")

    content(("fixed_order_quantity.start", 50% ,"fixed_order_quantity.end"),
    angle:-90deg,
    padding:0.25,
    [#box(align(center)[#text(8pt, "Fixed Order\nQuantity (Q)")], fill:white, inset:0.5em)])

  })
]

#eg[
  
  
  #figure(image("../../../vis/R_s_Q.png", width: 60%))

]


== Multi-Echelon Inventory Model

