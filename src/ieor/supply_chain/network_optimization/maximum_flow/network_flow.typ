#import "../../../../utils/examples.typ": eg
#import "../../../../utils/code.typ": code

#import "@preview/fletcher:0.5.7" as fletcher: diagram, node, edge, shapes

== Netwrok Flow Optimization

Types of Problems:

- Maximum Flow

- Minimum Cost Flow

- Multi-Commodity Flow

#linebreak()
#linebreak()

#align(center)[
  #diagram(
    node-inset: 0pt,

    node(pos: (0,0), label: {
      place(top+center, dy: -5mm, $b_i$)
      $i$
    }, stroke: 0.1em, radius: 1em, name: <i>),
    
    node(pos: (2,0), label: {
      place(top+center, dy: -5mm, $b_j$)
      $j$
    }, stroke: 0.1em, radius: 1em, name: <j>),
    
    edge(<i>, <j>, "-|>", label: {
      place(bottom+center, dy: 10mm, $[l_(i j),  u_(i j)]$)
    }),
    
    edge(<i>, <j>, "-|>", label: {
      place(bottom+center, dy: -3mm, $c_(i j)$)
    }),
  )
]

#linebreak()
#linebreak()

Node $i$

- Sink node: $b_i > 0$ #h(1fr) Has demand of $b_i$ units

- Source node: $b_i < 0$ #h(1fr) Has supply of $-b_i$ units

- Transsipment node: $b_i = 0$ #h(1fr) Neither supply or demand

#linebreak()
#linebreak()
#linebreak()

#align(center)[
  #diagram(
    node-inset: 0pt,

    node(pos: (0,0), label: {
      place(top+center, dy: -5mm, "150")
      $i$
    }, stroke: 0.1em, radius: 1em, name: <i>),
    node(pos: (0,0), label: {
      place(top+center, dy: 10mm, "Sink Node")
      $i$
    }, stroke: 0.1em, radius: 1em, name: <i>),
    

    node(pos: (2,0), label: {
      place(top+center, dy: -5mm, "-100")
      $j$
    }, stroke: 0.1em, radius: 1em, name: <j>),
    node(pos: (2,0), label: {
      place(top+center, dy: 10mm, "Source Node")
      $j$
    }, stroke: 0.1em, radius: 1em, name: <j>),

    node(pos: (4,0), label: {
      place(top+center, dy: -5mm, "0")
      $k$
    }, stroke: 0.1em, radius: 1em, name: <k>),
    node(pos: (4,0), label: {
      place(top+center, dy: 10mm, "Transshipment Node")
      $k$
    }, stroke: 0.1em, radius: 1em, name: <k>),
  )
]

#linebreak()
#linebreak()
#linebreak()

Units shipped from node $i$ to node $j$:

$
x_(i j)
$

Minimize:

$
Z = sum_(i, j) c_(i j) x_(i j)
$

s.t.

$
sum_k x_(k i) - sum_(l) x_(i l) #text(red)[$=$] "or" #text(red)[$lt.eq$] "or" #text(red)[$gt.eq$] b_1
$

$
l_(i j) lt.eq x_(i j) lt.eq u_(i j)
$

Where:
- $c_(i j)$: Unit cost of flow from node $i$ to node $j$

- $b_i$: Demand on node $i$

- $l_(i j)$: flow lower bound from $i$ to $j$

- $u_(i j)$: Flow upper bound from $i$ to $j$

- $sum_k x_(k i)$: Inflow to $i$

- $sum_(l) x_(i l)$: Outflow from $j$

#linebreak()

#align(center)[
  #diagram(
    node-inset: 0pt,
    node(pos: (-1,0), label: $x_(j i)$, name: <1>, radius: 1em),
    node(pos: (-1,0.3), name: <2>, radius: 1em),
    node(pos: (-1,-0.3), name: <3>, radius: 1em,),

    node(pos: (0,0), label: {
      place(top+center, dy: -5mm, $b_i$)
      $i$
    }, stroke: 0.1em, radius: 1em, name: <i>),
    
    node(pos: (1,0), label: $x_(i k)$, name: <4>, radius: 1em,),
    node(pos: (1,0.3), radius: 1em, name: <5>),
    node(pos: (1,-0.3), radius: 1em, name: <6>),
    
    edge(<1>, <i>, "-|>"),
    edge(<2>, <i>, "-|>", shift: -5pt),
    edge(<3>, <i>, "-|>", shift: 5pt),
    
    edge(<i>, <4>, "-|>"),
    edge(<i>, <5>, "-|>", shift: -5pt),
    edge(<i>, <6>, "-|>", shift: 5pt),
  )
]

#linebreak()

If:
- Total Supply #text(red)[$=$] Total Demand #h(1fr) [Inflow to $i$] - [Outflow from $i$] #text(red)[$=$] $b_i$

- Total Supply #text(red)[$gt$] Total Demand #h(1fr) [Inflow to $i$] - [Outflow from $i$] #text(red)[$gt.eq$] $b_i$

- Total Supply #text(red)[$lt$] Total Demand #h(1fr) [Inflow to $i$] - [Outflow from $i$] #text(red)[$lt.eq$] $b_i$

#linebreak()

Important:

- One decision variable $x_(i j)$ for each edge $(i, j)$

- One flow balancing constraint for each node $i$

#eg[
  #linebreak()
  #linebreak()

  #align(center)[
    #diagram(
      node-inset: 0pt,

      node(pos: (0,0), label: {
        place(top+center, dy: -5mm, dx: 5mm, $170$)
        $5$
      }, stroke: 0.1em, radius: 1em, name: <5>),
      
      node(pos: (-2,1), label: {
        place(top+center, dy: -4mm, $70$)
        $6$
      }, stroke: 0.1em, radius: 1em, name: <6>),
      
      node(pos: (-2,-1), label: {
        place(top+center, dy: -4mm, $60$)
        $3$
      }, stroke: 0.1em, radius: 1em, name: <3>),
      
      node(pos: (2,0), label: {
        place(top+center, dy: 0mm, dx: 7mm, $80$)
        $4$
      }, stroke: 0.1em, radius: 1em, name: <4>),
      
      node(pos: (1,1.5), label: {
        place(bottom+center, dy: 4mm, $-300$)
        $7$
      }, stroke: 0.1em, radius: 1em, name: <7>),
      
      node(pos: (1.5,-1.5), label: {
        place(top+center, dy: -7mm, $-200$)
        $1$
      }, stroke: 0.1em, radius: 1em, name: <1>),
      
      node(pos: (0,-1.5), label: {
        place(top+center, dy: -4mm, $100$)
        $2$
      }, stroke: 0.1em, radius: 1em, name: <2>),
      
      edge(<5>, <6>, "-|>", label: "35", label-side: center, bend: 20deg, shift: 0pt, label-fill: luma(230)),
      
      edge(<6>, <5>, "-|>", label: "25", label-side: center, bend: 20deg, shift: 0pt, label-fill: luma(230)),
      
      edge(<5>, <3>, "-|>", label: "40", label-side: center, bend: 20deg, shift: 0pt, label-fill: luma(230)),
      
      edge(<3>, <5>, "-|>", label: "35", label-side: center, bend: 20deg, shift: 0pt, label-fill: luma(230)),
      
      edge(<5>, <4>, "-|>", label: "30", label-side: center, shift: 0pt, label-fill: luma(230)),
      
      edge(<7>, <4>, "-|>", label: "50", label-side: center, shift: 0pt, label-fill: luma(230)),

      edge(<7>, <5>, "-|>", label: "45", label-side: center, shift: 0pt, label-fill: luma(230)),

      edge(<7>, <6>, "-|>", label: "50", label-side: center, shift: 0pt, label-fill: luma(230)),
      
      edge(<1>, <4>, "-|>", label: "40", label-side: center, shift: 0pt, label-fill: luma(230)),
      
      edge(<1>, <2>, "-|>", label: "30", label-side: center, shift: 0pt, label-fill: luma(230)),
      
      edge(<2>, <3>, "-|>", label: "50", label-side: center, shift: 0pt, label-fill: luma(230)),
      
    )
  ]

  #linebreak()

  Minimize
  
  $
  Z = 30 x_12 + 40 x_14 + 50 x_23 + 35 x_35 + 40 x_53 \ + 30 x_54 + 35 x_56 + 25 x_65 + 50 x_74 + 45 x_75 + 50 x_76
  $

  #linebreak()

  s.t.

  #h(10mm) $x_12 + x_14 lt.eq 200$ #h(1fr) (Node 1)

  #h(10mm) $x_12 + x_23 gt.eq 100$ #h(1fr) (Node 2)

  #h(10mm) $x_23 + x_53 - x_35 gt.eq 60$ #h(1fr) (Node 3)
  
  #h(10mm) $x_14 + x_54 + x_74 gt.eq 80$ #h(1fr) (Node 4)
  
  #h(10mm) $x_35 + x_65 + x_75 - x_53 - x_54 - x_56 gt.eq 170$ #h(1fr) (Node 5)

  #h(10mm) $x_56 + x_76 - x_65 gt.eq 70$ #h(1fr) (Node 6)

  #h(10mm) $x_76 + x_75 + x_74 lt.eq 300$ #h(1fr) (Node 7)

  #linebreak()

  #h(10mm) $x_(i j) gt.eq 0$ #h(1em) $forall (i, j) in E$

  #linebreak()
]

#linebreak()

#eg[
  #linebreak()
  #linebreak()

  #align(center)[
    #diagram(
      node-inset: 0pt,

      node(
        pos: (0,0), 
        label: {
          place(
            top+center, 
            dy: -7mm, 
            dx: 7mm, 
            box(fill: luma(230), outset: 0.1em, text(size: 0.5em)[$\ d=170 \ p=120 \ l=10$])
          )
          $5$
        }, 
        stroke: 0.1em, 
        radius: 1em, 
        name: <5>,
      ),
      
      node(
        pos: (-5,1), 
        label: {
          place(
            top+center, 
            dx: 0mm, 
            dy: -10mm, 
            box(fill: luma(230), outset: 0.1em, text(size: 0.5em)[$\ d=70 \ p=120 \ l=10$])
          )
          $6$
        }, 
        stroke: 0.1em, 
        radius: 1em, 
        name: <6>,
      ),
      
      node(
        pos: (-4,-4), 
        label: {
          place(
            top+center, 
            dx: 0mm,
            dy: -10mm, 
            box(fill: luma(230), outset: 0.1em, text(size: 0.5em)[$\ d=60 \ p=120 \ l=10$])
          )
          $3$
        }, 
        stroke: 0.1em, 
        radius: 1em, 
        name: <3>
      ),
      
      node(
        pos: (3,0), 
        label: {
          place(
            top+center, 
            dx: 9mm, 
            dy: 0mm, 
            box(fill: luma(230), outset: 0.1em, text(size: 0.5em)[$\ d=80 \ p=120 \ l=10$])
          )
          $4$
        }, 
        stroke: 0.1em, 
        radius: 1em, 
        name: <4>
      ),
      
      node(
        pos: (1,4), 
        label: {
          place(
            bottom+center, 
            dx: 0mm, 
            dy: 10mm, 
            box(fill: luma(230), outset: 0.1em, text(size: 0.5em)[$\ d=-300 \ p=120 \ l=10$])
          )
          $7$
        }, 
        stroke: 0.1em, 
        radius: 1em, 
        name: <7>
      ),
      
      node(
        pos: (2.5,-3), 
        label: {
          place(
            top+center, 
            dy: -10mm, 
            box(fill: luma(230), outset: 0.1em, text(size: 0.5em)[$\ d=-200 \ p=120 \ l=10$])
          ) 
          $1$
        }, 
        stroke: 0.1em, 
        radius: 1em, 
        name: <1>
      ),
      
      node(
        pos: (0,-4), 
        label: {
          place(
            top+center, 
            dx: 0mm,
            dy: -10mm, 
            box(fill: luma(230), outset: 0.1em, text(size: 0.5em)[$\ d=100 \ p=120 \ l=10$])
          )
          $2$
        }, 
        stroke: 0.1em, 
        radius: 1em, 
        name: <2>
      ),
      
      edge(
        <5>, <6>, "-|>", 
        label: $\ c_v=35 \ [b_l, b_u]=[3, 5] \ c_f=10 \ l=10$, 
        label-fill: luma(230),
        label-side: center, 
        bend: 30deg, 
        shift: 0pt, 
        label-size: 0.5em, 
      ),
      
      edge(
        <6>, <5>, "-|>", 
        label: $\ c_v=25 \ [b_l, b_u]=[3, 5] \ c_f=10 \ l=10$, 
        label-fill: luma(230),
        label-side: center, 
        bend: 30deg, 
        shift: 0pt, 
        label-size: 0.5em, 
      ),
      
      edge(<5>, <3>, "-|>", 
        label: $\ c_v=40 \ [b_l, b_u]=[3, 5] \ c_f=10 \ l=10$, 
        label-fill: luma(230),
        label-side: center, 
        bend: 30deg, shift: 0pt, 
        label-size: 0.5em, 
      ),
      
      edge(
        <3>, <5>, "-|>", 
        label: $\ c_v=35 \ [b_l, b_u]=[3, 5] \ c_f=10 \ l=10$, 
        label-fill: luma(230),
        label-side: center, 
        bend: 30deg, shift: 0pt, 
        label-size: 0.5em, 
      ),
      
      edge(
        <5>, <4>, "-|>", 
        label: $\ c_v=30 \ [b_l, b_u]=[3, 5] \ c_f=10 \ l=10$, 
        label-fill: luma(230),
        label-side: center, 
        shift: 0pt, 
        label-size: 0.5em, 
      ),
      
      edge(
        <7>, <4>, "-|>", 
        label: $\ c_v=50 \ [b_l, b_u]=[3, 5] \ c_f=10 \ l=10$, 
        label-fill: luma(230),
        label-side: center, 
        shift: 0pt, 
        label-size: 0.5em, 
      ),

      edge(
        <7>, <5>, "-|>", 
        label: $\ c_v=45 \ [b_l, b_u]=[3, 5] \ c_f=10 \ l=10$, 
        label-fill: luma(230),
        label-side: center, 
        shift: 0pt, 
        label-size: 0.5em, 
      ),

      edge(
        <7>, <6>, "-|>", 
        label: $\ c_v=50 \ [b_l, b_u]=[3, 5] \ c_f=10 \ l=10$, 
        label-fill: luma(230),
        label-side: center,
        shift: 0pt, 
        label-size: 0.5em, 
      ),
      
      edge(
        <1>, <4>, "-|>", 
        label: $\ c_v=40 \ [b_l, b_u]=[3, 5] \ c_f=10 \ l=10$, 
        label-fill: luma(230),
        label-side: center,
        shift: 0pt, 
        label-size: 0.5em, 
      ),
      
      edge(
        <1>, <2>, "-|>", 
        label: $\ c_v=30 \ [b_l, b_u]=[3, 5] \ c_f=10 \ l=10$, 
        label-fill: luma(230),
        label-side: center,
        shift: 0pt, 
        label-size: 0.5em, 
      ),
      
      edge(
        <2>, <3>, "-|>", 
        label: $\ c_v=50 \ [b_l, b_u]=[3, 5] \ c_f=10 \ l=10$, 
        label-fill: luma(230),
        label-side: center,
        shift: 0pt, 
        label-size: 0.5em, 
      ),
    )
  ]
  #linebreak()
  #linebreak()

  Minimize:
  
  $
  sum_(i j) (c^f_(i j) dot y_(i j)) + sum_(i j)(c^v_(i j) dot x_(i j)) + sum_i (c^f_i dot y_i) + sum_i (p_i dot s_i) + 
  $

  #linebreak()

  Where:
  - $sum_(i j) (c^f_(i j) dot y_(i j))$: Edge fixed cost contribution

  - $sum_(i j)(c^v_(i j) dot x_(i j))$: Variable cost contribution
  
  - $sum_i (c^f_i dot y_i)$: Node fixed cost contribution

  - $sum_i (p_i dot s_i)$: Penalty contribution

  - $sum_(i j) (l_(i j) dot x_(i j))$: Edge lead time weighted by flow

  - $sum_i l_i dot sum_j x_(i j)$: Node service time weighted by flow
  
  #linebreak()

  s.t.

  #h(10mm) $sum_j x_(j i) - sum_(j) x_(i j) #text(red)[$=$] "or" #text(red)[$lt.eq$] "or" #text(red)[$gt.eq$] d_i$ #h(1fr) Flow Conservation

  #h(10mm) $b^l_(i j) lt.eq x_(i j) lt.eq b^u_(i j)$ #h(1fr) Lower & Upper Flow Bound
  
  #h(10mm) $x_(i j) lt.eq M dot y_(i j)$ #h(1fr) Fixed Cost Route
  
  #h(10mm) $sum_i (x_(j i) + x_(i j)) lt.eq M dot y_i$ #h(1fr) Fixed Cost Node
  
  #h(10mm) $sum_i x_(i j) + s_j gt.eq d_j$ #h(1fr) Unmet Demand Penalty

  #h(10mm) $x_(i j) gt.eq 0$ #h(1em) $forall (i, j) in E$ #h(1fr) Non Negative Flow

  #linebreak()
]

#linebreak()

#linebreak()
#line(length: 100%)
#linebreak()

Node Properties:

- *Node Type*: Source, sink, or intermediary.
- *Supply (Source)*: Flow capacity of source nodes.
- *Holding Cost (Intermediary)*: Inventory cost for stored goods.
- *Service Time*: Processing time at the node.
- *Demand*: Required flow at sink nodes.
- *Storage Capacity (Intermediary)*: Maximum amount of goods that can be held at a node 
- *Penalty for Unfulfilled Demand (Sink)*: Cost for unmet demand.
- *Disruption Risk (All Nodes)*: Probability of a node being unavailable due to unforeseen circumstances


Edge Properties:

- *Edge Type*: Transport mode (air, water, road, rail).
- *Fixed Cost*: Cost incurred for using the edge, regardless of flow.
- *Reliability*: Probability of edge availability.
- *Flow Bounds*: Minimum and maximum allowable flow.
- *Unit Cost*: Cost per unit of flow.
- *Lead Time*: Time it takes for flow to travel along the edge.
- *Environmental Impact*: Account for the carbon footprint of using certain transport modes.