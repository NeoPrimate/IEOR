#import "../../../utils/examples.typ": eg
#import "../../../utils/code.typ": code
#import "../../../utils/color_math.typ": colorMath
#import "../../../utils/definition.typ": definition
#import "../../../utils/color_mat.typ": colorMat

#import "@preview/fletcher:0.5.7" as fletcher: diagram, node, edge, shapes

#set math.vec(delim: "[")
#set math.mat(delim: "[")



== Minimum Cost Network Flow (MCNF)

1. Maximum Flow
2. Shortest Path

IP $arrow$ LP Relaxation $arrow$ Integer Solution

Network
- Nodes ($n$)
- Edges $(u, v)$


- Directed
- Undirected

Path

*Path* from node $s$ to node $t$ is the set of arcs:

$
  (s, v_1), (v_1, v_2), (v_2, t)
$

such that $s$ and $t$ are connected

#linebreak()

#align(center)[
  #diagram(
    node-inset: 0pt,

    node(pos: (0,0), label: {$s$}, stroke: 0.1em, radius: 1em, name: <s>),
    
    node(pos: (1,0), label: {$v_1$}, stroke: 0.1em, radius: 1em, name: <n1>),
    
    node(pos: (2,0), label: {$v_2$}, stroke: 0.1em, radius: 1em, name: <n2>),
    
    node(pos: (3,0), label: {$t$}, stroke: 0.1em, radius: 1em, name: <t>),
    
    edge(<s>, <n1>, "-|>", label: {}),
    
    edge(<n1>, <n2>, "-|>", label: {}),
    
    edge(<n2>, <t>, "-|>", label: {}),
  )
]

- $s$: *source*
- $t$: *destination*

*Cycle*: Path whose source and destination are the same node

*Simple path*: A path that is not a cycle

*Acyclic network*: Network containing no cycle

*Flow*: actions of sending items through an edge

*Flow size*: Number of units sent through an edge

*Weight*: Property on an edge (e.g., distance, cost per unit, etc.)

*Weighted network*: network whose edges are Weighted

*Capacity*: Edge constraint

*Capacitated network*: network whose edges have capacities

Consider the weighted capacitated network $G = (V, E)$
- For node $i in V$ there is a *supply quantity* $b_i$
  - $b_i gt 0$: $i$ is a *supply* node
  - $b_i lt 0$: $i$ is a *demand* node
  - $b_i eq 0$: $i$ is a *transhipment* node
  - $sum_(i in V) b_i = 0$: Total supplies equal total demands

- For edge $(i, j) in E$, the weight $c_(i j) gt.eq 0$ is the *cost* of each unit of flow

Objective: Satisfy all demand while minimizing cost

LP Formulation

- The number of edges and constraints are equal
- Each variable appears in two constraints (coefficient 1 and coefficient -1)

#eg[

  Decision valiables:

  $x_(i j)$: Flow size of edge $(i, j)$ 
  
  for all $(i, j) in E$

  #linebreak()

  #align(center)[
    #diagram(
      node-inset: 0pt,

      node(pos: (0,0), label: {
        place(left, dx: -5mm, dy: 2.5mm, $25$)
        $1$
      }, stroke: 0.1em, radius: 1em, name: <1>),
      
      node(pos: (2,-2), label: {
        place(top+center, dy: -5mm, $0$)
        $2$
      }, stroke: 0.1em, radius: 1em, name: <2>),
      
      node(pos: (2,2), label: {
        place(bottom+center, dy: 5mm, $0$)
        $3$
      }, stroke: 0.1em, radius: 1em, name: <3>),
      
      node(pos: (8,-2), label: {
        place(top+center, dy: -5mm, $-10$)
        $4$
      }, stroke: 0.1em, radius: 1em, name: <4>),
      
      node(pos: (8,2), label: {
        place(bottom+center, dy: 5mm, $-10$)
        $5$
      }, stroke: 0.1em, radius: 1em, name: <5>),
      
      edge(<1>, <2>, "-|>", label: $(15, \$4)$, label-side: center, label-fill: luma(230)),
      
      edge(<1>, <3>, "-|>", label: $(20, \$3)$, label-side: center, label-fill: luma(230)),
      
      edge(<2>, <4>, "-|>", label: $(10, \$2)$, label-side: center, label-fill: luma(230)),
      
      edge(<2>, <3>, "-|>", label: $(infinity, \$2)$, label-side: center, label-fill: luma(230)),
      
      edge(<3>, <5>, "-|>", label: $(5, \$4)$, label-side: center, label-fill: luma(230), bend: 20deg),
      
      edge(<5>, <3>, "-|>", label: $(10, \$1)$, label-side: center, label-fill: luma(230), bend: 20deg),
      
      edge(<2>, <5>, "-|>", label: $(8, \$3)$, label-side: center,  label-pos: 0.75, label-fill: luma(230)),
      
      edge(<3>, <4>, "-|>", label: $(12, \$2)$, label-side: center, label-pos: 0.75, label-fill: luma(230)),
      
      edge(<4>, <5>, "-|>", label: $(infinity, \$2)$, label-side: center, label-fill: luma(230)),

      
    )
  ]

  *Objective* function:

  $
    min quad 4x_(1 2) + 3x_(1 3) + 2x_(2 3) + 2x_(2 4) + 3x_(2 5) + 2x_(3 4) + 1x_(3 5) + 2x_(4 5) + 1x_(5 3)
  $

  *Capacity* Constraints

  $
    x_(1 2) lt.eq 15 \
    x_(1 3) lt.eq 20 \
    x_(2 4) lt.eq 10 \
    x_(2 5) lt.eq 8 \
    x_(3 4) lt.eq 12 \
    x_(3 5) lt.eq 5 \
    x_(5 3) lt.eq 10 \
  $

  *Flow Balancing* Constraints

  - Supply node

  $
    x_(colorMath(1, #red) 2) + x_(colorMath(1, #red) 3) = 25 \
  $

  - Transhipment nodes

  $
    x_(1 colorMath(2, #red)) &= x_(colorMath(2, #red) 3) + x_(colorMath(2, #red) 4) + x_(colorMath(2, #red) 5) \
    x_(1 colorMath(3, #red)) + x_(2 colorMath(3, #red)) + x_(5 colorMath(3, #red)) &= x_(colorMath(3, #red) 4) + x_(colorMath(3, #red) 5) \
  $

  - Demand nodes

  $
    x_(2 colorMath(4, #red)) + x_(3 colorMath(4, #red)) &= x_(colorMath(4, #red) 5) + 10 \
    x_(2 colorMath(5, #red)) + x_(3 colorMath(5, #red)) + x_(4 colorMath(5, #red)) &= x_(colorMath(5, #red) 3) + 15 \
  $

  Complete Formulation

  $
     min& quad 4&x_(1 2) &+ 3&x_(1 3)  &+ 2&x_(2 3) &+ 2&x_(2 4) &+ 3&x_(2 5) &+ 2&x_(3 4) &+ &x_(3 5) &+ 2&x_(4 5) &+ 4&x_(5 3) \
    s.t.& quad  &x_(1 2) &+  &x_(1 3)  &   &        &   &        &   &        &   &        &  &        &   &        &   &        &= &25& \
        &      -&x_(1 2) &   &         &+  &x_(2 3) &+  &x_(2 4) &+  &x_(2 5) &   &        &  &        &   &        &   &        &= &0& \
        &       &        &  -&x_(1 3)  &-  &x_(2 3) &   &        &   &        &+  &x_(3 4) &+ &x_(3 5) &   &        &-  &x_(5 3) &= &0& \
        &       &        &   &         &   &        &-  &x_(2 4) &   &        &-  &x_(3 4) &  &        &+  &x_(4 5) &   &        &= &-10& \
        &       &        &   &         &   &        &   &        &-  &x_(2 5) &   &        &- &x_(3 5) &-  &x_(4 5) &+  &x_(5 3) &= &-15& \
        #place(
          $
            0 lt.eq x_(1 2) lt.eq 15 \
            0 lt.eq x_(1 3) lt.eq 20 \
            0 lt.eq x_(2 4) lt.eq 10 \
            0 lt.eq x_(2 5) lt.eq 8 \
            0 lt.eq x_(3 4) lt.eq 12 \
            0 lt.eq x_(3 5) lt.eq 5 \
            0 lt.eq x_(5 3) lt.eq 10 \
          $
        )
  $

  #linebreak() #linebreak() #linebreak() #linebreak() #linebreak() #linebreak() #linebreak() #linebreak()
  
]

Total Unimodularity (Totally Unimodular Matrices)

#definition(
  [Unimodular Matrix],
  [
    A square matrix is unimodular if its determinant is 1 or -1

    - Unimodular:
    $
      det(A) = {1, -1}
    $
  ]
)

#definition(
  [Totally Unimodular Matrix],
  [
    A matrix is totally unimodular (TU) is all its square submatrices are either singluar of unimodular

    $
      A = #colorMat(
        (
          (1, 0, -1, 0),
          (0, -1, 0, 1),
          (-1, 0, 1, 0),
        ),
        (
          (((0,0), (1, 1)), red),
          (((0,1), (2, 3)), blue),
        )
      )
    $

    - Singluar:
    $
      det(A) = 0
    $

    - Unimodular:
    $
      det(A) = {1, -1}
    $
  ]
)

As long as
- SUpply quantities
- Upper bounds 
are integers, the solution will be an *integer solution*

The LP relaxation of the IP formulation always gives an integer solution

