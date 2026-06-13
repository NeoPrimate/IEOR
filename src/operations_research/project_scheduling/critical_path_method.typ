#import "/lib/imports.typ": *
#show: formatting

What's the shortest possible time to finish the whole project, and which tasks are "tight" (any delay on them delays the whole project)

Let $G = (V, E)$ be a DAG with a duration of $d(v) gt.eq 0$ on each node. And edge $(u, v)$ means $u$ must finish before $v$ starts. $"pred"(v)$ and $"succ"(v)$ for in- and out-neighbors.

*Forward Pass* (one recurrence)

$
  "EF"(v) = d(v) + max_(u in "pred"(v)) "EF"(u), quad quad "ES"(v) = "EF"(v) - d(v)
$

with $max nothing.rev = 0$ (sources get $"ES" = 0$).

The makespan is $T = max_v "EF"(v)$.

*Backward Pass* (dual recurrence)

$
  "LF"(v) = min_(w in "succ"(v)) "LS"(w), quad quad "LS"(v) = "LF"(v) - d(v)
$

with $min nothing.rev = T$ (sinks get pinned to project end)

*Clack & Critical Pass*

$
  "slack"(v) = "LS"(v) - "ES"(v) = "LF"(v) - "EF"(v)
$

$"Critical path" = {v: "slack"(v) = 0}$

#example[

  #fletcher.diagram(
  	spacing: 8pt,
  	cell-size: (8mm, 10mm),
  	edge-stroke: 1pt,
  	edge-corner-radius: 5pt,
  	mark-scale: 70%,

  	node((0,0), [A\ 3 days],
    	fill: blue.lighten(60%),
      width: 20mm,
    	stroke: 1pt + blue.darken(20%),
    	corner-radius: 5pt,
      name: "A"
    ),
  	node((2,1), [C\ 2 days],
    	fill: blue.lighten(60%),
      width: 20mm,
    	stroke: 1pt + blue.darken(20%),
    	corner-radius: 5pt,
      name: "C"
    ),
  	node((2,-1), [B\ 4 days],
    	fill: blue.lighten(60%),
      width: 20mm,
    	stroke: 1pt + blue.darken(20%),
    	corner-radius: 5pt,
      name: "B"
    ),
  	node((4,1), [E\ 1 days],
    	fill: blue.lighten(60%),
      width: 20mm,
    	stroke: 1pt + blue.darken(20%),
    	corner-radius: 5pt,
      name: "E"
    ),
  	node((4,-1), [D\ 5 days],
    	fill: blue.lighten(60%),
      width: 20mm,
    	stroke: 1pt + blue.darken(20%),
    	corner-radius: 5pt,
      name: "D"
    ),
  	node((6,0), [F\ 2 days],
    	fill: blue.lighten(60%),
      width: 20mm,
    	stroke: 1pt + blue.darken(20%),
    	corner-radius: 5pt,
      name: "F"
    ),
  	edge(<A>, <B>, "-|>"),
  	edge(<A>, <C>, "-|>"),
  	edge(<B>, <D>, "-|>"),
  	edge(<C>, <E>, "-|>"),
  	edge(<E>, <F>, "-|>"),
  	edge(<D>, <F>, "-|>"),
  )

  Let's compute. We start the project at time 0.
  
  - A has no predecessors, so ES = 0, and EF = 0 + 3 = 3.
  - B depends only on A, so ES = EF(A) = 3, and EF = 3 + 4 = 7.
  - C also depends only on A, so ES = EF(A) = 3, and EF = 3 + 2 = 5.
  - D depends only on B, so ES = EF(B) = 7, and EF = 7 + 5 = 12.
  - E depends only on C, so ES = EF(C) = 5, and EF = 5 + 1 = 6.
]
