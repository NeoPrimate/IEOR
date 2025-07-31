#import "@preview/cetz:0.3.4"
#import "@preview/cetz-plot:0.1.1"
#import "@preview/cetz:0.4.0": canvas, draw, tree
#import "@preview/fletcher:0.5.7" as fletcher: diagram, node, edge


#import "../utils/examples.typ": eg
#import "../utils/code.typ": code
#import "../utils/color_math.typ": colorMath
#import "../utils/definition.typ": definition

#set math.vec(delim: "[")
#set math.mat(delim: "[")

#align(center)[
  // #show table: set text(size: 7pt)

  #diagram(
    
    node-inset: 0pt,

    node(
      pos: (-1,0),
      label: $1$,
      stroke: 0.1em,
      radius: 1em,
      // fill: blue.transparentize(75%),
      name: <1>
    ),
    
    // Invisible node for the table
    node(
      pos: (-1.7, 0),
      label: [
        #table(
          columns: range(4).map(_ => auto),
          inset: 3pt,
          align: horizon,
          fill: blue.transparentize(75%),
          [$x_1$], [$x_2$], [$dots$], [$x_n$]
        )
      ],
      stroke: none,
      name: <table1>
    ),
    
    node(
      pos: (1,-1), 
      label: $2$, 
      stroke: 0.1em, 
      radius: 1em, 
      // fill: blue.transparentize(75%),
      name: <2>
    ),

    // Invisible node for the table
    node(
      pos: (1, -1.5),
      label: [
        #table(
          columns: range(4).map(_ => auto),
          inset: 3pt,
          align: horizon,
          fill: blue.transparentize(75%),
          [$x_1$], [$x_2$], [$dots$], [$x_n$]
        )
      ],
      stroke: none,
      name: <table2>
    ),
    
    node(
      pos: (1,1), 
      label: $3$, 
      stroke: 0.1em, 
      radius: 1em, 
      // fill: blue.transparentize(75%),
      name: <3>
    ),

    // Invisible node for the table
    node(
      pos: (1, 1.5),
      label: [
        #table(
          columns: range(4).map(_ => auto),
          inset: 3pt,
          align: horizon,
          fill: blue.transparentize(75%),
          [$x_1$], [$x_2$], [$dots$], [$x_n$]
        )
      ],
      stroke: none,
      name: <table3>
    ),
    
    node(
      pos: (4,-1), 
      label: $4$, 
      stroke: 0.1em, 
      radius: 1em, 
      // fill: blue.transparentize(75%),
      name: <4>
    ),

    // Invisible node for the table
    node(
      pos: (4, -1.5),
      label: [
        #table(
          columns: range(4).map(_ => auto),
          inset: 3pt,
          align: horizon,
          fill: blue.transparentize(75%),
          [$x_1$], [$x_2$], [$dots$], [$x_n$]
        )
      ],
      stroke: none,
      name: <table4>
    ),
    
    node(
      pos: (4,1), 
      label: $5$, 
      stroke: 0.1em, 
      radius: 1em, 
      // fill: blue.transparentize(75%),
      name: <5>
    ),

    // Invisible node for the table
    node(
      pos: (4, 1.5),
      label: [
        #table(
          columns: range(4).map(_ => auto),
          inset: 3pt,
          align: horizon,
          fill: blue.transparentize(75%),
          [$x_1$], [$x_2$], [$dots$], [$x_n$]
        )
      ],
      stroke: none,
      name: <table5>
    ),
    
    edge(
      <1>, <2>, 
      // "-|>", 
      label: [
        #table(
          columns: range(4).map(_ => auto),
          inset: 3pt,
          align: horizon,
          fill: green.transparentize(75%),
          [$x_1$], [$x_2$], [$dots$], [$x_n$]
        )
      ], 
      label-side: center, 
      bend: 0deg, 
      shift: 0pt, 
      label-fill: white
    ),
    
    edge(
      <1>, <3>, 
      // "-|>", 
      label: [
        #table(
          columns: range(4).map(_ => auto),
          inset: 3pt,
          align: horizon,
          fill: green.transparentize(75%),
          [$x_1$], [$x_2$], [$dots$], [$x_n$]
        )
      ], 
      label-side: center, 
      bend: 0deg, 
      shift: 0pt, 
      label-fill: white
    ),
    
    edge(
      <2>, <3>, 
      // "-|>", 
      label: [
        #table(
          columns: range(4).map(_ => auto),
          inset: 3pt,
          align: horizon,
          fill: green.transparentize(75%),
          [$x_1$], [$x_2$], [$dots$], [$x_n$]
        )
      ], 
      label-side: center, 
      shift: 0pt, 
      label-fill: white
    ),
    
    edge(
      <2>, <4>, 
      // "-|>", 
      label: [
        #table(
          columns: range(4).map(_ => auto),
          inset: 3pt,
          align: horizon,
          fill: green.transparentize(75%),
          [$x_1$], [$x_2$], [$dots$], [$x_n$]
        )
      ], 
      label-side: center, 
      shift: 0pt, 
      label-fill: white
    ),
    
    edge(
      <4>, <5>, 
      // "-|>", 
      label: [
        #table(
          columns: range(4).map(_ => auto),
          inset: 3pt,
          align: horizon,
          fill: green.transparentize(75%),
          [$x_1$], [$x_2$], [$dots$], [$x_n$]
        )
      ], 
      label-side: center, 
      shift: 0pt, 
      label-fill: white
    ),
  )    
  
  #linebreak()
  #linebreak()

  #set math.mat(column-gap: 1em)
  #table(
    columns: 2,
    stroke: none,
    align: horizon,
    gutter: 1em,
    [Node Embedding:], [
      #table(
        columns: range(4).map(_ => auto),
        inset: 3pt,
        align: horizon,
        fill: blue.transparentize(75%),
        [$x_1$], [$x_2$], [$dots$], [$x_n$]
      )
    ],
    [Edge Embedding:], [
      #table(
        columns: range(4).map(_ => auto),
        inset: 3pt,
        align: horizon,
        fill: green.transparentize(75%),
        [$x_1$], [$x_2$], [$dots$], [$x_n$]
      )
    ],
    [Adjacency Matrix:], [
      $
      mat(
          0, 1, 1, 0, 0;
          1, 0, 1, 1, 0;
          1, 1, 0, 0, 0;
          0, 1, 0, 0, 1;
          0, 0, 0, 1, 0;
        )
      $
    ],
  )
]



 









#linebreak()
#linebreak()
#linebreak()

= Graph Neural Networks (GNNs)

- Node-level predictions
- Edge-level predictions
- Graph-level predictions

Graph Data
- Size variant
- Isomorphism: permutation invariance
- Grid structure: non-euclidian

== Message Passing

Allows nodes in a graph to exchange information and update their representations (embeddings) based on their local neighborhood

$
  G = (V, E)
$

Where:
- $V$: set of nodes ($|V| = n$)
- $E subset.eq V times V$: set of edges
- $h_v^(k) in RR^d$: feature (embedding) of node $v$ at iteation $k$
- $cal(N)(v)$: set of neighbors of node $v$

*Step 1*: Message computation

Each node $v$ receives messages from its neighbors $u in cal(N) (v)$. A message function $M$ defines how information is sent:

$
  bold("m")_v^(k) = sum_(u in cal(N)(v)) M(bold("h")_v^(k-1), bold("h")_u^(k-1), e_(u v))
$

- $bold("h")_u^(k-1)$: source (neighbor)
- $bold("h")_v^(k-1)$: target (receiver)
- $e_(u v)$: Optional edge features

*Step 2*: Aggregation

Aggregation combines incoming messages. This is often already done by the summation, mean, or max:

$
  bold("m")_v^k = "AGGREGATE"({bold("h")_u^(k-1): u in cal(N)(v)})
$

*Step 3*: Update

Each node updates its state with an update function $U$:

$
  bold("h")_v^k = U(bold("h")_v^(k-1), bold("m")_v^k)
$

Common choce:

$
  bold("h")_v^k = sigma(W dot [bold("h")_v^(k-1) || bold("m")_v^k])
$

Where:
- $||$: vector concatenation
- $sigma$: non-linearity (ReLU, tanh)
- $W$: learnable weights

#eg[
  #align(center)[
    #diagram(
      
      // node-inset: 0pt,

      node(
        pos: (0,0),
        label: $0$,
        stroke: 0.1em,
        radius: 1em,
        // fill: blue.transparentize(75%),
        name: <0>
      ),
      
      // Invisible node for the table
      node(
        pos: (0.5, 0),
        label: $vec(1, 0)$,
        stroke: none,
        name: <vec0>
      ),
      
      node(
        pos: (-1,2), 
        label: $1$, 
        stroke: 0.1em, 
        radius: 1em, 
        // fill: blue.transparentize(75%),
        name: <1>
      ),

      // Invisible node for the table
      node(
        pos: (-1.5, 2),
        label: $vec(0, 1)$,
        stroke: none,
        name: <vec1>
      ),
      
      node(
        pos: (1,2), 
        label: $2$, 
        stroke: 0.1em, 
        radius: 1em, 
        name: <2>
      ),

      // Invisible node for the vec
      node(
        pos: (1.5, 2),
        label: $vec(1, 1)$,
        stroke: none,
        name: <vec2>
      ),
      
      edge(
        <0>, <1>, 
        "-|>", 
        label: $vec(2, 0)$, 
        label-side: center, 
        bend: 0deg, 
        shift: 0pt, 
        label-fill: luma(230)
      ),
      
      edge(
        <0>, <2>, 
        "-|>", 
        label: $vec(0, 3)$, 
        label-side: center, 
        bend: 0deg, 
        shift: 0pt, 
        label-fill: luma(230)
      ),
    )    
  ]
]

== Invariance

A function is invariant to node permutations if its output stays the same no matter how the nodes are reordered (i.e., relabeled)

$
  f(P colorMath(X, #red), P colorMath(A, #blue) P^T) = f(colorMath(X, #red), colorMath(A, #blue))
$

If you shuffle the node labels, the graph is still the same — just redrawn

If you reorder the rows of $X$ (node features) and both rows and columns of $A$ (adjacency matrix) using the same permutation matrix $P$, the output does not change

== Equivariance

A function is equivariant to node permutations if permuting the input nodes results in the output being permuted in the same way

$
  f(P colorMath(X, #red), P colorMath(A, #blue) P^T) = P f(colorMath(X, #red), colorMath(A, #blue))
$

If you shuffle the nodes in the input graph, the output values (e.g., node embeddings or predictions) shuffle in the same way

If you reorder the rows of $X$ (node features) and both rows and columns of $A$ (adjacency matrix) using the same permutation matrix $P$, the output is reordered in the same way — i.e., its rows are permuted by $P$ too


#eg[
  Let $G = (V, E)$ be a directed graph where 

  $
    V &= {0,1} \
    E &= {(0, 1)} \
  $

  #align(center)[
    #diagram(
      
      // node-inset: 0pt,

      node(
        pos: (0,0),
        label: $0$,
        stroke: 0.1em,
        radius: 1em,
        // fill: blue.transparentize(75%),
        name: <0>
      ),
      
      // Invisible node for the table
      node(
        pos: (0.5, 0),
        // label: $vec(1, 0)$,
        stroke: none,
        name: <vec0>
      ),
      
      node(
        pos: (2,0), 
        label: $1$, 
        stroke: 0.1em, 
        radius: 1em, 
        // fill: blue.transparentize(75%),
        name: <1>
      ),

      // Invisible node for the table
      node(
        pos: (-1.5, 2),
        // label: $vec(0, 1)$,
        stroke: none,
        name: <vec1>
      ),
      
      
      edge(
        <0>, <1>, 
        "-|>", 
        // label: $vec(2, 0)$, 
        label-side: center, 
        bend: 0deg, 
        shift: 0pt, 
        label-fill: luma(230)
      ),
    )    
  ]

  Adjacency matrix:

  $
    A = mat(
      0, 1;
      0, 0;
    )
  $

  Node feature matrix:

  $
    X = mat(
      1, 2;
      3, 4;
    )
  $

  Permutation matrix (swaps node 0 and node 1):

  $
    P = mat(
      0, 1;
      1, 0;
    )
  $

  #text(size: 16pt, weight: "semibold", [Equivariance])

  Let's define a very simple *equivariant function*:

  $
    f(X, A) = A X
  $

  Message passing: sum over neighbors' features

  *Step 1*: Compute output without permutation

  $
    f(X, A) 
    = A X 
    = mat(
      0, 1;
      0, 0;
    )
    mat(
      1, 2;
      3, 4;
    )
    = mat(
      3, 4;
      0, 0;
    )
  $

  *Step 2*: Compute permuted inputs

  - Permute $X$

  $
    P X 
    &= mat(
      0, 1;
      1, 0;
    )
    mat(
      1, 2; 
      3, 4;
    )
    = mat(
      3, 4;
      1, 2;
    )
  $
  
  - Permute $A$

  $
    P A P^T 
    &= mat(
      0, 1;
      1, 0;
    ) mat(
      0, 1;
      0, 0;
    ) mat(
      0, 1;
      1, 0;
    ) = mat(
      0, 0;
      1, 0;
    )
  $

  This is now node 1 pointing to node 0

  #align(center)[
    #diagram(
      
      // node-inset: 0pt,

      node(
        pos: (0,0),
        label: $0$,
        stroke: 0.1em,
        radius: 1em,
        // fill: blue.transparentize(75%),
        name: <0>
      ),
      
      // Invisible node for the table
      node(
        pos: (0.5, 0),
        // label: $vec(1, 0)$,
        stroke: none,
        name: <vec0>
      ),
      
      node(
        pos: (2,0), 
        label: $1$, 
        stroke: 0.1em, 
        radius: 1em, 
        // fill: blue.transparentize(75%),
        name: <1>
      ),

      // Invisible node for the table
      node(
        pos: (-1.5, 2),
        // label: $vec(0, 1)$,
        stroke: none,
        name: <vec1>
      ),
      
      
      edge(
        <1>, <0>, 
        "-|>", 
        // label: $vec(2, 0)$, 
        label-side: center, 
        bend: 0deg, 
        shift: 0pt, 
        label-fill: luma(230)
      ),
    )    
  ]

  *Step 3*: Apply function to permuted inputs

  $
    f(P X, P A P^T) 
    = (P A P^T)(P X) 
    = mat(
      0, 0;
      1, 0;
    )
    mat(
      3, 4;
      1, 2;
    )
    = mat(
      0, 0;
      3, 4;
    )
  $

  *Step 4*: Compare with $P f(X, A)$

  $
    f(X, A) = mat(
      3, 4;
      0, 0;
    )
    quad
    arrow.double.long
    quad
    P f(X, A) = mat(
      0, 0;
      3, 4;
    )
  $

  So this function is *equivariant*:

  $
    f(P colorMath(X, #red), P colorMath(A, #blue) P^T) = P f(colorMath(X, #red), colorMath(A, #blue))
  $

  #text(size: 16pt, weight: "semibold", [Invariance])

  Let's define a simple invariant function:

  $
    g(X, A) = bold(1)^T A X
  $

  *Step 1*: Compute $g(X, A)$

  $
    A X 
    = mat(
      0, 1;
      0, 0;
    )
    mat(
      1, 2;
      3, 4;
    )
    = mat(
      3, 4;
      0, 0;
    )
  $

  Sum over rows:

  $
    bold(1)^T A X = mat(3 + 0, 4 + 0) = mat(3, 4)
  $

  *Step 2*: Compute permuted inputs

  - Permute $X$

  $
    P X 
    &= mat(
      0, 1;
      1, 0;
    )
    mat(
      1, 2; 
      3, 4;
    )
    = mat(
      3, 4;
      1, 2;
    )
  $
  
  - Permute $A$

  $
    P A P^T 
    &= mat(
      0, 1;
      1, 0;
    ) mat(
      0, 1;
      0, 0;
    ) mat(
      0, 1;
      1, 0;
    ) = mat(
      0, 0;
      1, 0;
    )
  $

  *Step 3*: Compute new output

  $
    P A P^T dot P X = 
    mat(
      0, 0;
      1, 0;
    )
    mat(
      3, 4;
      1, 2;
    )
    = mat(
      0, 0;
      3, 4;
    )
  $

  *Step 4*: Apply function to permuted inputs

  $
    bold(1)^T (P A P^T) (P X) = mat(1, 1) mat(
      0, 0;
      3, 4;
    ) = mat(3, 4)
  $

  Result:

  $
    g(X, A) = mat(3, 4) = g(P X, P A P^T)
  $


  So the function is invariant under node permutation:

  $
    f(P colorMath(X, #red), P colorMath(A, #blue) P^T) = f(colorMath(X, #red), colorMath(A, #blue))
  $
]

#code[

]