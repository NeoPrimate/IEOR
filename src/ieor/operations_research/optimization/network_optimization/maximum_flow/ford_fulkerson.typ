#import "../../../../../utils/examples.typ": eg
#import "../../../../../utils/code.typ": code

#import "@preview/fletcher:0.5.7" as fletcher: diagram, node, edge, shapes

== Ford-Fulkerson

Find augmenting paths in the network and increase the flow until no more augmenting paths can be found

#eg[

  #linebreak()

  #align(center)[
    #diagram(
      node-inset: 0pt,

      node(pos: (0,0), label: $s$, stroke: 0.1em, radius: 1em, name: <s>),
      
      
      node(pos: (2,-2), label: $A$, stroke: 0.1em, radius: 1em, name: <A>),
      
      node(pos: (2,2), label: $B$, stroke: 0.1em, radius: 1em, name: <B>),
      
      node(pos: (4,0), label: $t$, stroke: 0.1em, radius: 1em, name: <t>),

      edge(<s>, <A>, "-|>", label: {
        place(bottom+center, dy: 0mm, $10$)
      }),
      
      edge(<s>, <B>, "-|>", label: {
        place(bottom+center, dy: 0mm, $5$)
      }),
      
      edge(<A>, <B>, "-|>", label: {
        place(bottom+center, dy: 0mm, $15$)
      }),
      
      edge(<A>, <t>, "-|>", label: {
        place(bottom+center, dy: 0mm, $10$)
      }),
      
      edge(<B>, <t>, "-|>", label: {
        place(bottom+center, dy: 0mm, $10$)
      }),
    )
  ]

#linebreak()

- $s$: Source
- $A$ & $B$: Intermediate nodes
- $t$: Sink

Capacities:

- $s arrow t$: 10
- $s arrow B$: 5
- $A arrow B$: 15
- $A arrow t$: 10
- $B arrow t$: 10

*Step 1*: Initialize flow to 0

All flows through the edges are initially set to 0.

#align(center)[
  #diagram(
    node-inset: 0pt,

    node(pos: (0,0), label: $s$, stroke: 0.1em, radius: 1em, name: <s>),
    
    
    node(pos: (2,-2), label: $A$, stroke: 0.1em, radius: 1em, name: <A>),
    
    node(pos: (2,2), label: $B$, stroke: 0.1em, radius: 1em, name: <B>),
    
    node(pos: (4,0), label: $t$, stroke: 0.1em, radius: 1em, name: <t>),

    edge(<s>, <A>, "-|>", label: {
      place(bottom+center, dy: 0mm, $0$)
    }),
    
    edge(<s>, <B>, "-|>", label: {
      place(bottom+center, dy: 0mm, $0$)
    }),
    
    edge(<A>, <B>, "-|>", label: {
      place(bottom+center, dy: 0mm, $0$)
    }),
    
    edge(<A>, <t>, "-|>", label: {
      place(bottom+center, dy: 0mm, $0$)
    }),
    
    edge(<B>, <t>, "-|>", label: {
      place(bottom+center, dy: 0mm, $0$)
    }),
  )
]


*Step 2*: Find an augmenting path

Find an augmenting path using Depth-First Search (DFS). Start from the source $s$

$
s arrow A arrow t
$

The minimum capacity along this path is 10 (bottleneck on edge $A arrow t$)

We can push a flow of 10 units along this path.

*Step 3*: Update the residual graph

- $s arrow A$: Capacity becomes $10 - 10 = 0$ (no residual capacity)
- $A arrow t$: Capacity becomes $10 - 10 = 0$ (no residual capacity)

#align(center)[
  #diagram(
    node-inset: 0pt,

    node(pos: (0,0), label: $s$, stroke: 0.1em, radius: 1em, name: <s>),
    
    
    node(pos: (2,-2), label: $A$, stroke: 0.1em, radius: 1em, name: <A>),
    
    node(pos: (2,2), label: $B$, stroke: 0.1em, radius: 1em, name: <B>),
    
    node(pos: (4,0), label: $t$, stroke: 0.1em, radius: 1em, name: <t>),

    edge(<s>, <A>, "-|>", label: {
      place(bottom+center, dy: 0mm, $0$)
    }),
    
    edge(<s>, <B>, "-|>", label: {
      place(bottom+center, dy: 0mm, $0$)
    }),
    
    edge(<A>, <B>, "-|>", label: {
      place(bottom+center, dy: 0mm, $0$)
    }),
    
    edge(<A>, <t>, "-|>", label: {
      place(bottom+center, dy: 0mm, $0$)
    }),
    
    edge(<B>, <t>, "-|>", label: {
      place(bottom+center, dy: 0mm, $0$)
    }),
  )
]

*Step 4*: Find another augmenting path

Find another augmenting path. 

We cannot use $s arrow A$ or $A arrow t$ because their capacities are 0.

$
s arrow B arrow t
$

The minimum capacity along this path is 5 (bottleneck on edge $s arrow B$)

We can push a flow of 5 units along this path

*Step 5*: Update the residual graph

- $s arrow B$: Capacity becomes $5 - 5 = 0$
- $B arrow t$: Capacity becomes $10 - 5 = 5$

#align(center)[
  #diagram(
    node-inset: 0pt,

    node(pos: (0,0), label: $s$, stroke: 0.1em, radius: 1em, name: <s>),
    
    
    node(pos: (2,-2), label: $A$, stroke: 0.1em, radius: 1em, name: <A>),
    
    node(pos: (2,2), label: $B$, stroke: 0.1em, radius: 1em, name: <B>),
    
    node(pos: (4,0), label: $t$, stroke: 0.1em, radius: 1em, name: <t>),

    edge(<s>, <A>, "-|>", label: {
      place(bottom+center, dy: 0mm, $0$)
    }),
    
    edge(<s>, <B>, "-|>", label: {
      place(bottom+center, dy: 0mm, $0$)
    }),
    
    edge(<A>, <B>, "-|>", label: {
      place(bottom+center, dy: 0mm, $0$)
    }),
    
    edge(<A>, <t>, "-|>", label: {
      place(bottom+center, dy: 0mm, $0$)
    }),
    
    edge(<B>, <t>, "-|>", label: {
      place(bottom+center, dy: 0mm, $5$)
    }),
  )
]

*Step 6*: Termination

No more augmenting paths from $s$ to $t$ can be found, as all edges from $s$ are fully saturated

Maximum flow:

- $s arrow A arrow t$: 10 units
- $s arrow B arrow t$: 5 units

Thus, the maximum flow from source $s$ to sink $t$ is 15 units

*Step 7*: Final Flow Distribution

#align(center)[
  #diagram(
    node-inset: 0pt,

    node(pos: (0,0), label: $s$, stroke: 0.1em, radius: 1em, name: <s>),
    
    
    node(pos: (2,-2), label: $A$, stroke: 0.1em, radius: 1em, name: <A>),
    
    node(pos: (2,2), label: $B$, stroke: 0.1em, radius: 1em, name: <B>),
    
    node(pos: (4,0), label: $t$, stroke: 0.1em, radius: 1em, name: <t>),

    edge(<s>, <A>, "-|>", label: {
      place(bottom+center, dy: 0mm, $10$)
    }),
    
    edge(<s>, <B>, "-|>", label: {
      place(bottom+center, dy: 0mm, $5$)
    }),
    
    edge(<A>, <B>, "-|>", label: {
      place(bottom+center, dy: 0mm, $0$)
    }),
    
    edge(<A>, <t>, "-|>", label: {
      place(bottom+center, dy: 0mm, $10$)
    }),
    
    edge(<B>, <t>, "-|>", label: {
      place(bottom+center, dy: 0mm, $5$)
    }),
  )
]

]