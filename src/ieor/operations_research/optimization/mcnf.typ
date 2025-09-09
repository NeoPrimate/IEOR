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

As long as
- Supply quantities
- Upper bounds 
are integers, the solution will be an *integer solution*

The LP relaxation of the IP formulation always gives an integer solution

Total unimodularity gives integer solutions

For a standard form LP $min {c^T x | A x = b, x gt.eq 0}$, if 
- $A$ is totally unimodular and
- $b in ZZ^n$, 
then an optimal bfs $x^*$ obtained by the simplex method must satisfy $x^* in ZZ^n$

Proof:

$
  x_B = A_B^(-1) b = 1 / (det A_B) A_B^"adj" b
$

Where:
- $A_B^"adj"$: adjugate matrix of $A_B$
- $(A_B^"adj")_(i j)$: determinant of the matrix obtained by removing row $j$ and column $i$ from $A_B$

If A is totally unimodular, $det(A_B)$ will be either 1 or -1 for any basis $B$. $x_B$ is then an integer vector if $b$ is an integer vector.

- If a standard form *LP* has a *totally unimodular coefficient matrix*, an optimal bfs will always be *integer*
- If a standard form *IP* has a *totally unimodular coefficient matrix*, its LP relaxation always gives *integer* solutions

Sufficient conditions for total unimodularity:
For matrix $A$, if:
- all its elements are 1, 0, -1
- each column contains at most two nonzero elements
- rows can be divided into two groups so that for each column two nonzero elements are in the same group if and only if they are different (+ and -)
Then $A$ is totally unimodular
 
#eg[

  - All its elements are 1, 0, -1
  - Each column contains at most two nonzero elements

  Constraints:

  $
    &x_(1 2) &+  &x_(1 3) & & & & & & & & & & & & & & &= &25& \
    -&x_(1 2) & & &+ &x_(2 3) &+  &x_(2 4) &+ &x_(25) & & & & & & & & &= &0& \
    & &  -&x_(1 3) &- &x_(2 3) & & & & &+ &x_(3 4) &+ &x_(3 5) & & &- &x_(5 3) &= &0& \
    & & & & & &- &x_(2 4) & & &- &x_(3 4) & & &+ &x_(4 5) & & &= &-10& \
    & & & & & & & &- &x_(2 5) & & &- &x_(3 5) &- &x_(4 5) &+ &x_(5 3) &= &-15& \
  $

  For simplex:

  $
    &x_(1 2) &+  &x_(1 3) & & & & & & & & & & & & & & &= &25& \
    -&x_(1 2) & & &+ &x_(2 3) &+  &x_(2 4) &+ &x_(25) & & & & & & & & &= &0& \
    & &  -&x_(1 3) &- &x_(2 3) & & & & &+ &x_(3 4) &+ &x_(3 5) & & &- &x_(5 3) &= &0& \
    & & & & & &colorMath(+, #red) &x_(2 4) & & &colorMath(+, #red)  &x_(3 4) & & &colorMath(-, #red) &x_(4 5) & & &= &colorMath(+, #red) 10& \
    & & & & & & & &colorMath(+, #red) &x_(2 5) & & &colorMath(+, #red) &x_(3 5) &colorMath(+, #red) &x_(4 5) &colorMath(-, #red) &x_(5 3) &= &colorMath(+, #red) 15& \
  $

  - Rows can be divided into two groups so that for each column two nonzero elements are in the same group if and only if they are different (+ and -)

  $
    #colorMat(
      (
        (1, 1, 0, 0, 0, 0, 0, 0, 0),
        (-1, 0, 1, 1, 1, 0, 0, 0, 0),
        (0, -1, -1, 0, 0, 1, 1, 0, -1),
        (0, 0, 0, 1, 0, 1, 0, -1, 0),
        (0, 0, 0, 0, 1, 0, 1, 1, -1),
      ),
      (
        (((0, 0), (2, 9)), red),
        (((3, 0), (5, 9)), blue),
      )
    )
  $
]

== Transportation Problems

A firm owns $n$ factories that supply one pruduct to $m$ markets
- $s_i$: Capacity of factory $i$, $i = 1, dots, n$
- $d_j$: Demand of market $j$, $j = 1, dots, m$

Between factory $i$ and market $j$ there is a route
- $c_(i j)$: Unit cost for shipping one unit from factory $i$ to market $j$

How to produce and ship the product to fulfill all demands while minimizing the total cost?

#align(center)[
  #diagram(
    node-inset: 0pt,

    node(pos: (0,0), label: {
      place(left, dx: -5mm, dy: 2.5mm, $s_i$) 
      $1$
    }, stroke: 0.1em, radius: 1em, name: <1>),
    node(pos: (0,0.75), label: $2$, stroke: 0.1em, radius: 1em, name: <2>),
    node(pos: (0,1.5), label: $3$, stroke: 0.1em, radius: 1em, name: <3>),
    
    node(pos: (1,0), label: {
      place(left, dx: 10mm, dy: 2.5mm, $d_j$) 
      $1$
    }, stroke: 0.1em, radius: 1em, name: <4>),
    node(pos: (1,0.75), label: $2$, stroke: 0.1em, radius: 1em, name: <5>),
    node(pos: (1,1.5), label: $3$, stroke: 0.1em, radius: 1em, name: <6>),
    
    node(pos: (0,2.25), label: $dots.v$, stroke: none, radius: 1em, name: <10>),
    node(pos: (0.5,2.25), label: $dots.v$, stroke: none, radius: 1em, name: <10>),
    node(pos: (1,2.25), label: $dots.v$, stroke: none, radius: 1em, name: <10>),

    node(pos: (0,3), label: $n$, stroke: 0.1em, radius: 1em, name: <7>),
    node(pos: (1,3), label: $m$, stroke: 0.1em, radius: 1em, name: <8>),

    edge(<1>, <4>, "-|>"),
    edge(<1>, <5>, "-|>"),
    edge(<1>, <6>, "-|>"),
    edge(<2>, <4>, "-|>"),
    edge(<2>, <5>, "-|>"),
    edge(<2>, <6>, "-|>"),
    edge(<3>, <4>, "-|>"),
    edge(<3>, <5>, "-|>"),
    edge(<3>, <6>, "-|>"),
    
    edge(<7>, <8>, "-|>", label: $c_(i j)$, label-side: right, label-fill: none),
  )
]

if $sum^n_(i=1) s_i = sum^n_(j=1) d_j$
- $x_(i j)$: Shipping quantity on arc $(i, j)$, $i = 1, dots, n, j = 1, dots, m$

This is a MCNF problem:
- Factories are supply nodes whose supply quantity is $s_i$
- Markets are demand nodes whose supply quantity is $-d_j$
- No transhipment nodes
- Arc weights are unit transportation costs $c_(i j)$
- Arcs have unlimited capacities ($u_(i j) = infinity$)

If capacity is greater than demand:

$
  sum^n_(i=1) s_i gt sum^n_(j=1) d_j
$

- Create a "virtual market" (market 0) whose demand quantity is $d_0 = sum^n_(i=1) s_i - sum^n_(j=1) d_j$
- Arcs $(i, 0)$ have cost $c_(i 0) = 0$
- Shipping to market 0 just means some factory capacity is unused

#align(center)[
  #diagram(
    node-inset: 0pt,

    node(pos: (1,-0.75), label: $0$, stroke: 0.1em, radius: 1em, name: <0>),
    node(pos: (0,0), label: {
      place(left, dx: -5mm, dy: 2.5mm, $s_i$) 
      $1$
    }, stroke: 0.1em, radius: 1em, name: <1>),
    node(pos: (0,0.75), label: $2$, stroke: 0.1em, radius: 1em, name: <2>),
    node(pos: (0,1.5), label: $3$, stroke: 0.1em, radius: 1em, name: <3>),
    
    node(pos: (1,0), label: {
      place(left, dx: 10mm, dy: 2.5mm, $d_j$) 
      $1$
    }, stroke: 0.1em, radius: 1em, name: <4>),
    node(pos: (1,0.75), label: $2$, stroke: 0.1em, radius: 1em, name: <5>),
    node(pos: (1,1.5), label: $3$, stroke: 0.1em, radius: 1em, name: <6>),
    
    node(pos: (0,2.25), label: $dots.v$, stroke: none, radius: 1em, name: <10>),
    node(pos: (1,2.25), label: $dots.v$, stroke: none, radius: 1em, name: <10>),

    node(pos: (0,3), label: $n$, stroke: 0.1em, radius: 1em, name: <7>),
    node(pos: (1,3), label: $m$, stroke: 0.1em, radius: 1em, name: <8>),

    edge(<1>, <0>, "-|>", label: $0$, label-side: center, label-fill: white),
    edge(<2>, <0>, "-|>", label: $0$, label-side: center, label-fill: white),
    edge(<3>, <0>, "-|>", label: $0$, label-side: center, label-fill: white),
    edge(<7>, <0>, "-|>", label: $0$, label-side: center, label-pos: 50%, label-fill: white),
  )
]

If different factories have different unit production costs $c_i^P$
- $c_(i j)$ is updated to $c_(i j) + c_i^P$

If different markets habe different unit retailing costs $c_j^R$
- $c_j$ is updated to $c_(i j) + c_j^R$


== Assignment Problems

- A manager assignes $n$ jobs to $m$ workers
- The assigment is one-to-one (one job to one worker)
  - Jobs cannot be split
- $c_(i j)$: cost for worker $j$ to complete job $i$

How to minimize total cost?

Special case of Transportation Problem
- Jobs are factories and workers are markets
- Each factory produces one item and each market demands one item
- Cost of shipping one item from factory $i$ to maket $j$ is $c_(i j)$

#align(center)[
  #diagram(
    node-inset: 0pt,

    node(pos: (0,0), label: {
      place(left, dx: -5mm, dy: 2.5mm, $s_i$) 
      $1$
    }, stroke: 0.1em, radius: 1em, name: <1>),
    node(pos: (0,0.75), label: $2$, stroke: 0.1em, radius: 1em, name: <2>),
    node(pos: (0,1.5), label: $3$, stroke: 0.1em, radius: 1em, name: <3>),
    
    node(pos: (1,0), label: {
      place(left, dx: 10mm, dy: 2.5mm, $d_j$) 
      $1$
    }, stroke: 0.1em, radius: 1em, name: <4>),
    node(pos: (1,0.75), label: $2$, stroke: 0.1em, radius: 1em, name: <5>),
    node(pos: (1,1.5), label: $3$, stroke: 0.1em, radius: 1em, name: <6>),
    
    node(pos: (0,2.25), label: $dots.v$, stroke: none, radius: 1em, name: <10>),
    node(pos: (0.5,2.25), label: $dots.v$, stroke: none, radius: 1em, name: <10>),
    node(pos: (1,2.25), label: $dots.v$, stroke: none, radius: 1em, name: <10>),

    node(pos: (0,3), label: $n$, stroke: 0.1em, radius: 1em, name: <7>),
    node(pos: (1,3), label: $m$, stroke: 0.1em, radius: 1em, name: <8>),

    edge(<1>, <4>, "-|>"),
    edge(<1>, <5>, "-|>"),
    edge(<1>, <6>, "-|>"),
    edge(<2>, <4>, "-|>"),
    edge(<2>, <5>, "-|>"),
    edge(<2>, <6>, "-|>"),
    edge(<3>, <4>, "-|>"),
    edge(<3>, <5>, "-|>"),
    edge(<3>, <6>, "-|>"),
    
    edge(<7>, <8>, "-|>", label: $c_(i j)$, label-side: right, label-fill: none),
  )
]

What if there are fewer jobs then workers:

$
  sum^n_(i=1) s_i lt sum^n_(j=1) d_j
$

- Create a "virtual job" (job 0)
- Arcs $(i, 0)$ have cost $c_(i 0) = 0$
- Assigning job 0 just means some workers are unused

#align(center)[
  #diagram(
    node-inset: 0pt,

    node(pos: (0,-0.75), label: $0$, stroke: 0.1em, radius: 1em, name: <0>),
    node(pos: (0,0), label: {
      place(left, dx: -5mm, dy: 2.5mm, $s_i$) 
      $1$
    }, stroke: 0.1em, radius: 1em, name: <1>),
    node(pos: (0,0.75), label: $2$, stroke: 0.1em, radius: 1em, name: <2>),
    node(pos: (0,1.5), label: $3$, stroke: 0.1em, radius: 1em, name: <3>),
    
    node(pos: (1,0), label: {
      place(left, dx: 10mm, dy: 2.5mm, $d_j$) 
      $1$
    }, stroke: 0.1em, radius: 1em, name: <4>),
    node(pos: (1,0.75), label: $2$, stroke: 0.1em, radius: 1em, name: <5>),
    node(pos: (1,1.5), label: $3$, stroke: 0.1em, radius: 1em, name: <6>),
    
    node(pos: (0,2.25), label: $dots.v$, stroke: none, radius: 1em, name: <10>),
    node(pos: (1,2.25), label: $dots.v$, stroke: none, radius: 1em, name: <10>),

    node(pos: (0,3), label: $n$, stroke: 0.1em, radius: 1em, name: <7>),
    node(pos: (1,3), label: $m$, stroke: 0.1em, radius: 1em, name: <8>),

    edge(<0>, <4>, "-|>", label: $0$, label-side: center, label-fill: white),
    edge(<0>, <5>, "-|>", label: $0$, label-side: center, label-fill: white),
    edge(<0>, <6>, "-|>", label: $0$, label-side: center, label-fill: white),
    edge(<0>, <8>, "-|>", label: $0$, label-side: center, label-pos: 50%, label-fill: white),
  )
]

IP Formulation

- $I$: set of factories / jobs
- $J$: set of markets / workers

#grid(
  columns: (1fr, 1fr),
  inset: 1em,
  [Transportation Problem], [Assignment Problem],
  [
    $
      & min& quad &sum_(i in I) sum_(j in J) c_(i j) x_(i j) \
      &s.t.& quad &sum^m_(j=1) x_(i j) = colorMath(s_i, #red) quad forall i in I \
      &    &      &sum^n_(i=1) x_(i j) = colorMath(d_j, #red) quad forall j in J \
      &    &      &x_(i j) in colorMath(ZZ^+, #red) quad forall i in I, j in J
    $
  ],
  [
    $
      & min& quad &sum_(i in I) sum_(j in J) c_(i j) x_(i j) \
      &s.t.& quad &sum^colorMath(n, #red)_(j=1) x_(i j) = colorMath(1, #red) quad forall i in I \
      &    &      &sum^n_(i=1) x_(i j) = colorMath(1, #red) quad forall j in J \
      &    &      &x_(i j) in colorMath({0, 1}, #red) quad forall i in I, j in J
    $
  ]
)

- These matrices are *totally unimodular*

== Transhipment Problems

If there are intermediary nodes in the transportation problem it is a transhipment problem


== Maximum Flow Problems

#align(center)[
  #diagram(
    node-inset: 0pt,

    node(pos: (0,0), label: $s$, stroke: 0.1em, radius: 1em, name: <s>),
    node(pos: (1,-1), label: $1$, stroke: 0.1em, radius: 1em, name: <1>),
    node(pos: (1,1), label: $2$, stroke: 0.1em, radius: 1em, name: <2>),
    node(pos: (3,-1), label: $3$, stroke: 0.1em, radius: 1em, name: <3>),
    node(pos: (3,1), label: $4$, stroke: 0.1em, radius: 1em, name: <4>),
    node(pos: (4,0), label: $t$, stroke: 0.1em, radius: 1em, name: <t>),
  
    edge(<s>, <1>, "-|>", label: $4$, label-side: center, label-fill: white),
    edge(<s>, <2>, "-|>", label: $5$, label-side: center, label-fill: white),
    edge(<2>, <1>, "-|>", label: $6$, label-side: center, label-fill: white),
    edge(<1>, <4>, "-|>", label: $3$, label-side: center, label-fill: white, label-pos: 75%),
    edge(<1>, <3>, "-|>", label: $8$, label-side: center, label-fill: white),
    edge(<3>, <2>, "-|>", label: $2$, label-side: center, label-fill: white, label-pos: 75%),
    edge(<2>, <4>, "-|>", label: $3$, label-side: center, label-fill: white),
    edge(<3>, <4>, "-|>", label: $2$, label-side: center, label-fill: white),
    edge(<3>, <t>, "-|>", label: $6$, label-side: center, label-fill: white),
    edge(<4>, <t>, "-|>", label: $7$, label-side: center, label-fill: white),

    edge(<t>, <s>, "-|>", label: $-1$, bend: 90deg, label-side: center, label-fill: white, stroke: (dash: "dashed")),
  )
]

$
  &min& quad &-x_(t s) \
  &s.t.& quad &sum_((i, k) in E) x_(i k) - sum_((k, j) in E) x_(k j) = 0 quad &forall& k in V \
  && &x_(i j) lt.eq u_(i j) quad &forall& (i, j) in E \
  && &x_(i j) in ZZ^+ quad &forall& (i, j) in E
$

Where:
- $x_(t s)$: flow size of the 
- $u_(i j)$: 

Objective: Maximize number of units sent from $s$ to $t$ given edge capacities

== Shortest Path Problems

$
  &min & quad &sum_(i in I) sum_(j in J) d_(i j) x_(i j) \
  &s.t.&   quad &sum_((s,j) in E) x_(s j) = 1 \
  &&            &sum_((i,t) in E) x_(i t) = 1 \
  &&          &sum_((i, k) in E) x_(i k) - sum_((k, j) in E) x_(k j) = 0 quad &forall& k in T \
  &&          &x_(i j) in {0, 1} quad &forall& (i, j) in E
$

Where:
- $s$: supply node
- $t$: demand node
- $x_(i j)$: weather edge $(i, j)$ is chosen (binary)
- $d_(i j)$: weight (distance) between nodes $i$ and $j$

Objective: Get from $s$ to $t$ while minimizing distance

Out of all outgoing edges from $s$, one must be selected:

#align(center)[
  #grid(
    columns: (auto, auto),
    inset: 1em,
    align: horizon,
    column-gutter: 1em,
    [
      $
        sum_((s,j) in E) x_(s j) = 1
      $
    ],
    [
      #diagram(
        node-inset: 0pt,

        node(pos: (0,1.875), label: $s$, stroke: 0.1em, radius: 1em, name: <1>),

        node(pos: (1,0.75), label: $1$, stroke: 0.1em, radius: 1em, name: <2>),
        node(pos: (1,1.5), label: $2$, stroke: 0.1em, radius: 1em, name: <3>),
        
        node(pos: (1,2.25), label: $dots.v$, stroke: none, radius: 1em, name: <10>),

        node(pos: (1,3), label: $j$, stroke: 0.1em, radius: 1em, name: <4>),

        edge(<1>, <2>, "-|>"),
        edge(<1>, <3>, "-|>", stroke: (paint: red, thickness: 1pt)),
        edge(<1>, <4>, "-|>"),
      )
    ]
  )
]

Out of all ingoing edges to $t$, one must be selected:

#align(center)[
  #grid(
    columns: (auto, auto),
    inset: 1em,
    align: horizon,
    column-gutter: 1em,
    [
      $
        sum_((i,t) in E) x_(i t) = 1
      $
    ],
    [
      #diagram(
        node-inset: 0pt,

        node(pos: (1,1.875), label: $t$, stroke: 0.1em, radius: 1em, name: <1>),

        node(pos: (0,0.75), label: $1$, stroke: 0.1em, radius: 1em, name: <2>),
        node(pos: (0,1.5), label: $2$, stroke: 0.1em, radius: 1em, name: <3>),
        
        node(pos: (0,2.25), label: $dots.v$, stroke: none, radius: 1em, name: <10>),

        node(pos: (0,3), label: $i$, stroke: 0.1em, radius: 1em, name: <4>),

        edge(<2>, <1>, "-|>", stroke: (paint: red, thickness: 1pt)),
        edge(<3>, <1>, "-|>"),
        edge(<4>, <1>, "-|>"),
      )
    ]
  )
]

For all transhipment nodes $T$, 

#align(center)[
  #grid(
    columns: (auto, auto),
    inset: 1em,
    align: horizon,
    column-gutter: 1em,
    [
      $
        sum_((i, k) in E) x_(i k) - sum_((k, j) in E) x_(k j) = 0 quad forall k in T
      $
    ],
    [
      #diagram(
        node-inset: 0pt,

        node(pos: (1,1.875), label: $k$, stroke: 0.1em, radius: 1em, name: <1>),

        node(pos: (0,0.75), label: $1$, stroke: 0.1em, radius: 1em, name: <2>),
        node(pos: (0,1.5), label: $2$, stroke: 0.1em, radius: 1em, name: <3>),
        
        node(pos: (0,2.25), label: $dots.v$, stroke: none, radius: 1em),

        node(pos: (0,3), label: $i$, stroke: 0.1em, radius: 1em, name: <4>),
        
        node(pos: (2,0.75), label: $1$, stroke: 0.1em, radius: 1em, name: <5>),
        node(pos: (2,1.5), label: $2$, stroke: 0.1em, radius: 1em, name: <6>),
        
        node(pos: (2,2.25), label: $dots.v$, stroke: none, radius: 1em),

        node(pos: (2,3), label: $j$, stroke: 0.1em, radius: 1em, name: <7>),

        edge(<2>, <1>, "-|>", stroke: (paint: red, thickness: 1pt)),
        edge(<3>, <1>, "-|>"),
        edge(<4>, <1>, "-|>"),
        edge(<1>, <5>, "-|>"),
        edge(<1>, <6>, "-|>", stroke: (paint: red, thickness: 1pt)),
        edge(<1>, <7>, "-|>"),
      )
    ]
  )
]




#text(size: 16pt)[*Summary*]

- *Assigment* problems are a special case of *Transportation* problems
- *Transportation* and *Shortest Path* problems are a special case of *Transhipment* problems 
- *Transhipment* and *Maximum Flow* problems are a special case of *MCNF* problems 

#align(center)[
  #grid(
    columns: (auto, auto),
    column-gutter: 5em,
    inset: 1em,
    align: horizon,
    [

      $
        &min& quad &c^T x \
        &s.t.& quad &A x = b \
        &    &  &x lt.eq u \
        &   & &x gt.eq 0 \
      $
    ],
    [
      #align(center)[
        #diagram(
          node-inset: 0pt,

          node(pos: (0,0), label: [MCNF], stroke: none, radius: 1em, name: <1>),

          node(pos: (2,2), label: [Max Flow], stroke: none, radius: 1em, name: <3>),
          node(pos: (-2,2), label: [Transshipment], stroke: none, radius: 1em, name: <2>),

          node(pos: (-4,4), label: [Transportation], stroke: none, radius: 1em, name: <4>),
          node(pos: (0,4), label: [Shortest Path], stroke: none, radius: 1em, name: <5>),

          node(pos: (-4,6), label: [Assigment], stroke: none, radius: 1em, name: <6>),
          
          edge(
            <2>, <1>, 
            "-|>", 
            label: $
              u_(i j) = infinity
            $, 
            label-side: center, 
            label-fill: white
          ),
          edge(
            <3>, <1>, 
            "-|>", 
            label: $
              c_(i j) = 0 forall (i, j) in E \ c_(t s) = -1
            $, 
            label-side: center, 
            label-fill: white
          ),
          edge(
            <4>, <2>, 
            "-|>", 
            label: $
              b_i eq.not 0
            $, 
            label-side: center, 
            label-fill: white
          ),
          edge(
            <5>, <2>, 
            "-|>", 
            label: $
              b_i = 0 forall i in T\ b_s = 1, b_t = -1
            $, 
            label-side: center, 
            label-fill: white
          ),
          edge(
            <6>, <4>, 
            "-|>", 
            label: $
              b_i = plus.minus 1
            $, 
            label-side: center, 
            label-fill: white
          ),
        )
      ]
    ]
  )
]