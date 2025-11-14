// #set math.cases(gap: 1em)
#show math.equation.where(block: false): set text(12pt)
#set math.vec(delim: "[")
#set math.mat(delim: "[")
#set math.mat(gap: 1em)
#set math.vec(gap: 1em)

#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge
#import fletcher.shapes: diamond

#let text-size = 5pt


#show math.equation: set text(text-size)

// #diagram(
// 	node-stroke: 1.5pt,
// 	node(
//     (0,0), 
//     text(size: text-size)[
//       *Initialization* \
//       Constraints in\ 
//       canonical form
//     ],
//     shape: rect,
//     corner-radius: 2pt,
//   ),
	
//   edge("-|>"),

// 	node(
//     (0,1), 
//     text(size: text-size)[
//       Artificial\ 
//       variables\ 
//       added?
//     ], 
//     shape: diamond
//   ),

// 	edge((0, 1), (-1, 1), "-|>", [Yes], label-pos: 0.5),
  
//   node(
//     (-1, 1),
//     text(size: text-size)[
//       Use *Phase I*\
//       Objective\
//       ($w$)
//     ],
//     shape: rect,
//     corner-radius: 2pt,
//   ),

//   edge((0, 1), (0, 2), "-|>", [No], label-pos: 0.5),

//   node(
//     (0, 2),
//     text(size: text-size)[
//       Use *Phase II*\
//       Objective\
//       ($z$)
//     ],
//     shape: rect,
//     corner-radius: 2pt,
//   ),
  
//   node(
//     (-1, 2),
//     text(size: text-size)[
//       Place objective\ 
//       in canonical\ 
//       form
//     ],
//     shape: rect,
//     corner-radius: 2pt,
//   ),

//   edge((0, 2), (-1, 2), "-|>", [], label-pos: 0.5),
//   edge((-1, 1), (-1, 2), "-|>", [], label-pos: 0.5),

//   edge((-1, 2), (-1, 3), "-|>", [], label-pos: 0.5),

//   node(
//     (-1, 3),
//     fill: yellow.lighten(50%),
//     text(size: text-size)[
//       *Basic Feasible Solution*\ 
//       $
//         x_B = B^(-1) b \
//         x_N = bold(0)
//       $
//       Current basic feasible\ 
//       solution (BFS) corresponding\ 
//       to the current basis
//     ],
//     shape: rect,
//     corner-radius: 2pt,
//   ),

//   edge((-1, 3), (0, 3), "-|>", [], label-pos: 0.5),
  
//   node(
//     (0, 3),
//     fill: yellow.lighten(50%),
//     text(size: text-size)[
//       *Reduced Costs (vector)*\ 
//       $
//         macron(c)_N = c_N^T - c_B^T B^(-1) N
//       $
//       Represents the change in\ 
//       the objective value per\ 
//       unit increase of nonbasic\ 
//       variable $x_j$
//     ],
//     shape: rect,
//     corner-radius: 2pt,
//   ),

//   edge((0, 3), (1, 3), "-|>", [], label-pos: 0.5),

//   node(
//     (1, 3),
//     fill: yellow.lighten(50%),
//     text(size: text-size)[
//       *Optimality\ Test*\
//       Is any objective\ 
//       function coefficient\ 
//       positive?
//     ],
//     shape: diamond
//   ),

//   edge((1, 3), (1, 4), "-|>", [Yes], label-pos: 0.5),
  
//   node(
//     (1, 4),
//     fill: yellow.lighten(50%),
//     text(size: text-size)[
//       Select variable $x_s$\ 
//       to introduce into the basis\ 
//       as the variable\ 
//       with the largest\ 
//       objective coefficient
//     ],
//     shape: rect,
//     corner-radius: 2pt,    
//   ),

//   edge((1, 4), (1, 5), "-|>", [], label-pos: 0.5),

//   node(
//     (1, 5),
//     fill: yellow.lighten(50%),
//     text(size: text-size)[
//       *Unbounded\ Test*\
//       Does $x_s$ appear\ 
//       with a positive\ 
//       coefficient in some\ constraint?
//     ],
//     shape: diamond,
//   ),

//   edge((1, 5), (1, 6), "-|>", [Yes], label-pos: 0.5),

//   node(
//     (1, 6),
//     fill: yellow.lighten(50%),
//     text(size: text-size)[
//       *Ratio Test*\ 
//       Select pivot row $r$\ 
//       as the row with the\ 
//       minimum ratio of RHS\ 
//       coefficients to positive\ 
//       $x_s$ coefficient
//     ],
//     shape: rect,
//     corner-radius: 2pt,
//   ),

//   edge((1, 6), (-1, 6), "-|>", [], label-pos: 0.5),
  
//   node(
//     (-1, 6),
//     fill: yellow.lighten(50%),
//     text(size: text-size)[
//       *Ratio Test*\ 
//       Select pivot row $r$\ 
//       as the row with the\ 
//       minimum ratio of RHS\ 
//       coefficients to positive\ 
//       $x_s$ coefficient
//     ],
//     shape: rect,
//     corner-radius: 2pt,
//   ),

//   edge((-1, 6), (-1, 3), "-|>", [], label-pos: 0.5),

//   edge((1, 5), (2, 5), "-|>", [No], label-pos: 0.5),

//   node(
//     (2, 5),
//     fill: green.lighten(50%),
//     text(size: text-size)[
//       *Terminate*\ 
//       $z$ is\ 
//       unbounded
//     ],
//     shape: rect,
//     corner-radius: 2pt,
//   ),

//   edge((1, 3), (2, 3), "-|>", [No], label-pos: 0.5),

//   node(
//     (2, 3),
//     text(size: text-size)[
//       *Phase I*?
//     ],
//     shape: diamond
//   ),

//   edge((2, 3), (2, 4), "-|>", [No], label-pos: 0.5),
  
//   node(
//     (2, 4),
//     fill: green.lighten(50%),
//     text(size: text-size)[
//       *Terminate*\
//       Current solution\ 
//       is optimal

//     ],
//     shape: rect,
//     corner-radius: 2pt,
//   ),

//   edge((2, 3), (2, 1), "-|>", [Yes], label-pos: 0.5),

//   node(
//     (2, 1),
//     text(size: text-size)[
//       $max w lt 0$?
//     ],
//     shape: diamond
//   ),

//   node(
//     (1, 1),
//     text(size: text-size)[
//       *Phase I - Phase II\
//       Transition*\
//       Use Phase II\ 
//       objective\
//       ($z$)
//     ],
//     shape: rect,
//     corner-radius: 2pt,
//   ),
  
//   edge((2, 1), (1, 1), "-|>", [No], label-pos: 0.5),
//   edge((2, 1), (2, 0), "-|>", [Yes], label-pos: 0.5),

//   edge((1, 1), (1, 3), "-|>", [], label-pos: 0.5),

//   node(
//     (2, 0),
//     fill: green.lighten(50%),
//     text(size: text-size)[
//       *Terminate*\
//       No feasible\ 
//       solution\ 
//     ],
//     shape: rect,
//     corner-radius: 2pt,
//   ),

// )

// #pagebreak()

#diagram(
	node-stroke: 1.5pt,

  node(
    (-1, 0),
    fill: yellow.lighten(50%),
    text(size: text-size)[
      *LP\ (Standard Form)*\ 
      $
        bold(max) &z = c^T x \
        &A x = b \
        &x gt.eq 0
      $
    ],
    shape: rect,
    corner-radius: 2pt,
  ),

  edge((-1, 0), (0, 0), "-|>"),

  node(
    (0, 0),
    fill: yellow.lighten(50%),
    text(size: text-size)[
      *Partition*\ 
      $
        A = mat(B, N) \
        c = vec(c_B, c_N) quad x = vec(x_B, x_N)
      $
    ],
    shape: rect,
    corner-radius: 2pt,
  ),

  edge((0, 0), (0, 1), "-|>"),

  node(
    (0, 1),
    fill: yellow.lighten(50%),
    text(size: text-size)[
      *Basic Feasible Solution*\ 
      $
        x_B &= B^(-1) b \
        x_N &= bold(0)
      $
    ],
    shape: rect,
    corner-radius: 2pt,
  ),

  edge((0, 1), (0, 2), "-|>"),

  node(
    (0, 2),
    fill: yellow.lighten(50%),
    text(size: text-size)[
      All $x_B gt.eq 0$?
    ],
    shape: diamond
  ),

  
  edge((0, 2), (0, 3), "-|>", [Yes], label-pos: 0.5),
  edge((0, 2), (1, 2), "-|>", [No], label-pos: 0.5),

  node(
    (1, 2),
    fill: yellow.lighten(50%),
    text(size: text-size)[
      *Infeasible*
    ],
    shape: rect,
    corner-radius: 2pt,
  ),

  node(
    (0, 3),
    fill: yellow.lighten(50%),
    text(size: text-size)[
      *Reduced Costs*\ 
      $
        macron(c)_N^T = c_N^T - c_B^T B^(-1) N \
        macron(c)_j = c_j - c_B^T B^(-1) a_j
      $
      $macron(c)_j$ represents the change\ 
      in the objective value per\ 
      unit increase of nonbasic\ 
      variable $x_j$
    ],
    shape: rect,
    corner-radius: 2pt,
  ),

  edge((0, 3), (0, 4), "-|>"),

  node(
    (0, 4),
    fill: yellow.lighten(50%),
    text(size: text-size)[
      All $macron(c)_N_j lt.eq 0$?
    ],
    shape: diamond
  ),

  edge((0, 4), (1, 4), "-|>", [Yes], label-pos: 0.5),
  edge((0, 4), (0, 5), "-|>", [No], label-pos: 0.5),

  node(
    (1, 4),
    fill: yellow.lighten(50%),
    text(size: text-size)[
      *Optimal*
    ],
    shape: rect,
    corner-radius: 2pt,
  ),
  
  node(
    (0, 5),
    fill: yellow.lighten(50%),
    text(size: text-size)[
      *Entering Variable*\ 
      $
        j = arg max_i macron(c)_N_i
      $
      Index $j$ of entering variable\ \
      If there is a tie:\
      Choose smallest index\
      (Bland's rule)
    ],
    shape: rect,
    corner-radius: 2pt,
  ),

  edge((0, 5), (0, 6), "-|>"),
  
  node(
    (0, 6),
    fill: yellow.lighten(50%),
    text(size: text-size)[
      *Direction Vector*\ 
      $
        d = B^(-1) A_j
      $
      Shows how the basic\ 
      variables $x_B$ change\ 
      as the entering variable\ 
      $x_j$ increases
    ],
    shape: rect,
    corner-radius: 2pt,
  ),

  edge((0, 6), (0, 7), "-|>"),

  node(
    (0, 7),
    fill: yellow.lighten(50%),
    text(size: text-size)[
      All $d_i lt.eq 0$?
    ],
    shape: diamond
  ),

  edge((0, 7), (-1, 7), "-|>", [No], label-pos: 0.5),
  edge((0, 7), (1, 7), "-|>", [Yes], label-pos: 0.5),

  node(
    (1, 7),
    fill: yellow.lighten(50%),
    text(size: text-size)[
      *Unbounded*
    ],
    shape: rect,
    corner-radius: 2pt,
  ),
  
  node(
    (-1, 7),
    fill: yellow.lighten(50%),
    text(size: text-size)[
      *Ratio Test\ (Leaving Variable)*\ 
      $
        theta_i = ((B^(-1) b)_i) / d_i quad d_i gt 0
      $
      The leaving variable\ 
      is the basic variable\
      $x_(B_(i^*))$ corresponding to the\ 
      *smallest positive ratio*\ \
      If there is a tie:\
      Choose smallest index\
      (Bland's rule)
    ],
    shape: rect,
    corner-radius: 2pt,
  ),

  edge((-1, 7), (-1, 3), "-|>"),
  
  node(
    (-1, 3),
    fill: yellow.lighten(50%),
    text(size: text-size)[
      *Pivot\ (Update Basis)*\ \
      Replace $x_(B_(i^*))$ with\ 
      $x_j$ in the basis\
      \
      New basis \
      $B arrow.l [B_1, dots, A_j, dots, B_m]$
    ],
    shape: rect,
    corner-radius: 2pt,
  ),

  edge((-1, 3), (0, 3), "-|>"),

)

#pagebreak()












#pagebreak()


#text(size: 13pt, weight: "semibold")[1. Convert to standard form]

#diagram(
  node-stroke: 1.5pt,
  node(
    (0,0),
    text(size: 13pt, weight: "semibold")[
      *Start* \
      Original LP \
      min/max z \
      with constraints and variable signs
    ],
    shape: rect,
    corner-radius: 2pt
  ),

  edge("-|>"),

  node(
    (0,1),
    text(size: 13pt, weight: "semibold")[
      *Objective Function* \
      min z → max -z
    ],
    shape: rect,
    corner-radius: 2pt
  ),

  edge("-|>"),

  node(
    (0,2),
    text(size: 13pt, weight: "semibold")[
      *Constraints* \
      Ax ≤ b → Ax + s = b, s ≥ 0 \
      Ax ≥ b → Ax - s + a = b, s,a ≥ 0
    ],
    shape: rect,
    corner-radius: 2pt
  ),

  edge("-|>"),

  node(
    (0,3),
    text(size: 13pt, weight: "semibold")[
      *Variable Signs* \
      x_j ≥ 0: OK \
      x_j ≤ 0 or free → x_j = x_j^+ - x_j^-, x_j^+, x_j^- ≥ 0
    ],
    shape: rect,
    corner-radius: 2pt
  ),

  edge("-|>"),

  node(
    (0,4),
    text(size: 13pt, weight: "semibold")[
      *Result* \
      LP in Standard Form \
      (max z, Ax = b, x ≥ 0)
    ],
    shape: rect,
    corner-radius: 2pt
  )
)

#align(center)[
  #grid(
    columns: 3,
    gutter: 2em,
    align: center + horizon,
    [
      $
        &cases(
          &z = min c^T x, 
          &z = max c^T x,
        ) \
        &A x = b \
        &A x lt.eq b \
        &A x gt.eq b \
        &x gt.eq 0 \
        &x lt.eq 0 \
        &x "free" \
      $
    ],
    [
      $arrow$
    ],
    [
      $
        &z = max c^T x \
        &A x = b \
        &x gt.eq 0
      $
    ]
  )
]

*Objective Function*

#align(center)[
  #grid(
    columns: 3,
    gutter: 2em,
    align: center + horizon,
    [
      $
        min z
      $
    ],
    [
      $arrow$
    ],
    [
      $
        max -(z)
      $
    ]
  )
]

*Constraints*

#align(center)[
  #grid(
    columns: 4,
    gutter: 2em,
    align: left + horizon,
    [*Slack*],
    [
      $
        A x lt.eq b
      $
    ],
    [
      $arrow$
    ],
    [
      $
        A x + s = b \
        s gt.eq 0 \
      $
    ],
    [*Surplus*],
    [
      $
        A x gt.eq b
      $
    ],
    [
      $arrow$
    ],
    [
      $
        A x - s + a = b \
        s, a gt.eq 0 \
      $
    ],
  )
]


*Negative/Free Variables* 

#align(center)[
  #grid(
    columns: 3,
    gutter: 2em,
    align: left + horizon,
    [
      $
        x_j lt.eq 0 \
        x_j "free" \
      $
    ],
    [
      $arrow$
    ],
    [
      $
        x_j = x_j^+ - x_j^- \
        x_j^+, x_j^- gt.eq 0
      $
    ]
  )
]

#text(size: 13pt, weight: "semibold")[2. Partition]

$
  A = mat(B, N) quad quad x = vec(x_B, x_N) quad quad c = vec(c_B, c_N)
$

Constraints:

$
  B x_b + N x_n = b  
$

#text(size: 13pt, weight: "semibold")[3. Basic Feasible Solution]

$
  x_B = B^(-1) b
$

#text(size: 13pt, weight: "semibold")[4. Reduced Costs]

$
  macron(x)_N = c_N^T - c_B^T B^(-1) N
$

- If $macron(c)_j gt 0$: $x_j$ can enter the basis
- If $macron(c)_j lt.eq 0$: optimal


#text(size: 13pt, weight: "semibold")[5. Choose Entering Variable]

Select $x_j in N$ with the largest $macron(c)_j$.

If there's a tie, pick the smallest index (Bland's rule).


#text(size: 13pt, weight: "semibold")[6. Pivot / Ratio Test]

Let $d = B^(-1) A_j$ be the column of the entering variable expressed in basic coordinates
Only $d_i gt 0$ maintain feasibility

$theta_i = ((B^(-1) b)_i) / d_i, quad d_i > 0$

-	The smallest $theta_i$ identifies the leaving variable $x_(B_i)$.
-	If all $d_i lt.eq 0$: the LP is unbounded