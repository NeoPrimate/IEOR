#import "@preview/cetz:0.3.4"
#import "@preview/cetz-plot:0.1.1"
#import "@preview/cetz:0.4.0": canvas, draw, tree
#import "@preview/suiji:0.4.0": *

#import "../../../utils/examples.typ": eg
#import "../../../utils/code.typ": code
#import "../../../utils/color_math.typ": colorMath
#import "../../../utils/definition.typ": definition

#set math.cases(gap: 1em)
#show math.equation.where(block: false): set text(12pt)
#set math.vec(delim: "[")
#set math.mat(delim: "[")
#set math.mat(gap: 1em)
#set math.vec(gap: 1em)

== Sensitivity Analysis

=== Dual Simplex Method

#eg[

  A company is selling 2 products

  - Producing 1 unit of product 1 requires 1 unit of resource 1 and 1 unit of resource 2, which can be sold for \$2
  - Producing 1 unit of product 2 requires 1 unit of resource 1 and 2 unit of resource 2, which can be sold for \$3
  - Total amount of resources 1 is 4 units
  - Total amount of resources 2 is 6 units

  $
    max& quad 2&x_1& quad + quad 3&x_2& \

    s.t.& quad &x_1& quad + quad &x_2& quad lt.eq quad 4 \

    & quad &x_1& quad + quad 2&x_2& quad lt.eq quad 6 \
    \
    &#place($x_1, x_2 gt.eq 0$)
    \
  $
  #linebreak()

  #align(center)[
    #table(
      columns: 5,
      inset: 0.75em,
      stroke: none,
      [-2], [-3], [0], [0], [0],
      table.hline(),
      table.vline(x: 4),
      table.cell(fill: red.lighten(50%))[1], [1], [1], [0], [4],
      [1], [2], [0], [1], [6],
    )
    
    #table(
      columns: 5,
      inset: 0.75em,
      stroke: none,
      [0], [-1], [2], [0], [8],
      table.hline(),
      table.vline(x: 4),
      [1], [1], [1], [0], [4],
      [0], table.cell(fill: red.lighten(50%))[1], [-1], [1], [2],
    )
    #table(
      columns: 5,
      inset: 0.75em,
      stroke: none,
      [0], [0], [1], [1], [10],
      table.hline(),
      table.vline(x: 4),
      [1], [0], [2], [-1], [2],
      [0], [1], [-1], [1], [2],
    )
  ]

  - An optimal solution $(x_1^*, x_2^*) = (2, 2)$
  - The objective is $z^* = 10$

  #text(size: 15pt)[*Additional activity*]

  The company now produces a 3rd product.

  - 1 unit of product 3 requires 1 unit of resource 2 and is sold for \$8

  #linebreak()
  
  $
    max& quad 3&x_1& quad + quad 2&x_2& quad colorMath(+ quad &8x_3&, #red) \
    
    s.t.& quad &x_1& quad + quad 2&x_2& quad && quad lt.eq quad 4 \

    & quad 2&x_1& quad + quad 4&x_2& quad colorMath(+ quad &x_3&, #red) quad lt.eq quad 6 \
    \
    &#place($x_1, x_2, x_3 gt.eq 0$)
    \
  $
  #linebreak()

  We don't need to solve a new linear program

  The decision variable set changes from $(x_1, x_2)$ to $(x_1, x_2, x_3)$, the solution $(x_1^*, x_2^*, 0)$ is feasible

  All we need to do is to check whether we should produce some product 3
  - If no, the current solution $(x_1^*, x_2^*, 0)$ is optimal
  - If yes, we increase the nonbasic variable $x_3$ until one basic variable becomes 0

  All we need is the (vector of) *reduced costs*:

  $
    c_B^T B^(-1) N - c_N
  $

  Where:
  - $B$: basis matrix
  - $N$: non-basis matrix
  - $c_B$: vector of objective coefficients corresponding to the basic variables
  - $c_N$: vector of objective coefficients corresponding to the non-basic variables

  For a single nonbasic variable ($x_3$), ot simplifies to:

  $
    c_B^T B^(-1) A_j - c_j
  $

  After we solve the original problem, we have $B^* = (x_1, x_2)$ and $N^* = (s_1, s_2)$
  - The optimal basis is $B^*$

  When we add a new decision variable $x_3$, it is 0 (*nonbasic*) at the beginning

  Therefore, to solve the new problem, we may start from the basis $B = (x_1, x_2)$ and the set of nonbasic variables $N = (x_3, s_1, s_2)$

  We start with the optimal tableau

  #align(center)[
    #table(
      columns: 5,
      inset: 0.75em,
      stroke: none,
      [0], [0], [1], [1], [10],
      table.hline(),
      table.vline(x: 4, end: 3),
      [1], [0], [2], [-1], [2],
      [0], [1], [-1], [1], [2],
      table.cell(colspan: 2, align: top)[#move(dy: -0.75em)[$underbrace(#box(width: 3em, height: 0em), "basic")$]],
      table.cell(colspan: 2, align: top)[#move(dy: -0.75em)[$underbrace(#box(width: 3em, height: 0em), "nonbasic")$]]
    )

    #linebreak()
    
    #table(
      columns: 6,
      inset: 0.75em,
      stroke: none,
      [0], [0], [?], [1], [1], [10],
      table.hline(),
      table.vline(x: 5, end: 3),
      [1], [0], [?], [2], [-1], [2],
      [0], [1], [?], [-1], [1], [2],
      table.cell(colspan: 2, align: top)[#move(dy: -0.75em)[$underbrace(#box(width: 2em, height: 0em), "basic")$]],
      table.cell(colspan: 3, align: top)[#move(dy: -0.75em)[$underbrace(#box(width: 6em, height: 0em), "nonbasic")$]]
    )
  ]

  The vecots of constraint coefficients for nonbasic variables is:

  $
    B^(-1)N
  $

  for column $j$:

  $
    B^(-1)A_j
  $

  Where $A_j$ is the coefficient column for $x_3$:

  $
    mat(
      2, -1;
      -1, 1;
    ) vec(0, 1)
    =
    vec(-1, 1)
  $

  And the vector if reduced costs for nonbasic variables is

  $
    c_B^T B^(-1) N - c_N^T
  $

  For column $j$, that value is

  $
    c_B^T B^(-1) A_j - c_j
  $

  $
    mat(2, 3) vec(-1, 1) - 8 = -7
  $

  #align(center)[
    #table(
      columns: 6,
      inset: 0.75em,
      stroke: none,
      [0], [0], [-7], [1], [1], [10],
      table.hline(),
      table.vline(x: 5, end: 3),
      [1], [0], [-1], [2], [-1], [2],
      [0], [1], [1], [-1], [1], [2],
      table.cell(colspan: 2, align: top)[#move(dy: -0.75em)[$underbrace(#box(width: 2em, height: 0em), "basic")$]],
      table.cell(colspan: 3, align: top)[#move(dy: -0.75em)[$underbrace(#box(width: 6em, height: 0em), "nonbasic")$]]
    )
  ]

  From this new tableau keep iterating

  #align(center)[
    #table(
      columns: 6,
      inset: 0.75em,
      stroke: none,
      [0], [0], [-7], [1], [1], [10],
      table.hline(),
      table.vline(x: 5, end: 3),
      [1], [0], [-1], [2], [-1], [2],
      [0], [1], table.cell(fill: red.lighten(50%))[1], [-1], [1], [2],
    )
    #table(
      columns: 6,
      inset: 0.75em,
      stroke: none,
      [0], [7], [0], [-6], [8], [24],
      table.hline(),
      table.vline(x: 5, end: 3),
      [1], [1], [0], table.cell(fill: red.lighten(50%))[1], [0], [4],
      [0], [1], [1], [-1], [1], [2],
    )
    #table(
      columns: 6,
      inset: 0.75em,
      stroke: none,
      [6], [13], [0], [0], [8], [28],
      table.hline(),
      table.vline(x: 5, end: 3),
      [1], [1], [0], [1], [0], [4],
      [1], [2], [1], [0], [1], [6],
    )
  ]

  $(x_1^(**), x_2^(**), x_3^(**)) = (0, 0, 6)$ with $z^(**) = 48$

  Allows asking *what if* questions:
  - What if it is \$5 instead of \$8
  - What if it takes 2 of resource on instead of 1?
  - What if it takes 1 of resource 2 instead of 0?

  #text(size: 15pt)[*Additional Constraints*]

  *Primal*

  $
    max& quad 2&x_1& quad + quad 3&x_2& \
    
    s.t.& quad &x_1& quad + quad &x_2& quad lt.eq quad 4 \

    & quad &x_1& quad + quad 2&x_2& quad lt.eq quad 6 \

    &#place($x_1, x_2 gt.eq 0$)
    \
  $

  #linebreak()

  We add a new contraint:

  *Dual*

  $
    max& quad 2&x_1& quad + quad 3&x_2& \
    
    s.t.& quad &x_1& quad + quad &x_2& quad lt.eq quad 4 \

    & quad &x_1& quad + quad 2&x_2& quad lt.eq quad 6 \

    &colorMath(quad &x_1& quad quad && quad lt.eq quad 1, #red) \
    \

    &#place($x_1, x_2 gt.eq 0$)
    \
  $

  #linebreak()

  We may plug in in the original optimal solution $(x_1^*, x_2^*) = (2, 2)$ into the new constraint
  - If it is feasible, it is optimal for the new problem
  - In our example, it is not feasible because $2 gt 1$

  The original optimal tableau

  #align(center)[
    #table(
      columns: 5,
      inset: 0.75em,
      stroke: none,
      [0], [0], [1], [1], [10],
      table.hline(),
      table.vline(x: 4, end: 3),
      [1], [0], [2], [-1], [2],
      [0], [1], [-1], [1], [2],
    )
  ]

  The new constraint $x_1 lt.eq 1$ introduces a new slack variable ($s_3$)

  Include $s_3$ to be a basic variable

  Let $B = (x_1, x_2, s_3)$ and $N = (s_1, s_2)$

  We have 
  
  $
    c_B = vec(2, 3, 0), 
    quad 
    c_N = vec(0, 0), 
    quad 
    B = mat(
      1, 1, 0;
      1, 2, 0;
      1, 0, 1;
    ), 
    quad 
    N = mat(
      1, 0;
      0, 1;
      0, 0;
    ), 
    quad 
    b = vec(4, 6, 1)
  $

  We then have 
  
  $
    B^(-1) = mat(
      2, -1, 0;
      -1, 1, 0;
      -2, 1, 1;
    ),
    quad
    B^(-1) N = mat(
      2, -1;
      -1, 1;
      -2, 1;
    ),
    quad
    c_B^T B^(-1) N - c_N^T = mat(1, 1),
    quad
    c_B^T B^(-1) b = 10
  $

  #align(center)[
    #table(
      columns: 6,
      inset: 0.75em,
      stroke: none,
      [0], [0], [1], [1], [0], [10],
      table.hline(),
      table.vline(x: 5, end: 4),
      [1], [0], [2], [-1], [0], [2],
      [0], [1], [-1], [1], [0], [2],
      [0], [0], [-2], [1], [1], [-1],
      table.cell(colspan: 2, align: top)[#move(dy: -0.75em)[$underbrace(#box(width: 2em, height: 0em), "basic")$]],
      table.cell(colspan: 2, align: top)[#move(dy: -0.75em)[$underbrace(#box(width: 3em, height: 0em), "nonbasic")$]],
      table.cell(colspan: 1, align: top)[#move(dy: -0.75em)[$underbrace(#box(width: 1em, height: 0em), "basic")$]],
    )
  ]

  This is an invalid simplex tableau (RHS column column contains a negative value)
  - This means $B = (x_1, x_2, s_3)$ is infeasible (as we already know)

  *Linear Programmin Duality*

  We know a primal constraint is a dual variable

  If a primal LP has one new constraint, it's dual LP will have one new variable

  #align(center)[
    #grid(
      columns: 2,
      gutter: 3em,
      [*Primal*], [*Dual*],
      [
        $
          max& quad 2&x_1& quad + quad 3&x_2& \
          
          s.t.& quad &x_1& quad + quad &x_2& quad lt.eq quad 4 \

          & quad &x_1& quad + quad 2&x_2& quad lt.eq quad 6 \

          &#place($x_1, x_2 gt.eq 0$)
          \
        $
      ],
      [
        $
          min& quad 4&y_1& quad + quad 6&y_2& \
          
          s.t.& quad &y_1& quad + quad &y_2& quad gt.eq quad 2 \

          & quad &y_1& quad + quad 2&y_2& quad gt.eq quad 3 \

          &#place($y_1, y_2 gt.eq 0$)
          \
        $
      ]
    )
  ]

  

  #linebreak()

  We add a new contraint:

  #align(center)[
    #grid(
      columns: 2,
      gutter: 3em,
      [*Primal LP\ with new constraint*], [*Dual LP\ with new variable*],
      [
        $
          max& quad 2&x_1& quad + quad 3&x_2& \
          
          s.t.& quad &x_1& quad + quad &x_2& quad lt.eq quad 4 \

          & quad &x_1& quad + quad 2&x_2& quad lt.eq quad 6 \

          &colorMath(quad &x_1& quad quad && quad lt.eq quad 1, #red) \
          \

          &#place($x_1, x_2 gt.eq 0$)
          \
        $
      ],
      [
        $
          min& quad 4&y_1& quad + quad 6&y_2& quad colorMath(+ quad &y_3&, #red) \
          
          s.t.& quad &y_1& quad + quad &y_2& quad colorMath(+ quad &y_3&, #red) quad gt.eq quad 2 \

          & quad &y_1& quad + quad 2&y_2& quad && quad gt.eq quad 3 \
          \

          &#place($y_1, y_2, y_3 gt.eq 0$)
          \
        $
      ]
    )
  ]
  
  #linebreak()
]




// #import "@preview/numty:0.0.5"

// $
//   max& quad 2&x_1& quad + quad 3&x_2& \
//   s.t.& quad &x_1& quad + quad &x_2& quad lt.eq quad 4 \
//   & quad &x_1& quad + quad 2&x_2& quad lt.eq quad 6 \ \
//   &#place($x_1, x_2 gt.eq 0$) \
// $

// #linebreak()

// $
//   max& quad 2&x_1& quad + quad 3&x_2& quad + quad 0&s_1& quad + quad 0&s_2&  \
//   s.t.& quad &x_1& quad + quad &x_2& quad + quad &s_1& quad && quad eq quad 4 \
//   & quad &x_1& quad + quad 2&x_2& quad quad && quad + quad &s_2& quad eq quad 6 \ \
//   &#place($x_1, x_2 gt.eq 0$) \
// $

// #linebreak()

// $
//   min& quad - 2&x_1& quad - quad 3&x_2& quad - quad 0&s_1& quad - quad 0&s_2&  \
//   s.t.& quad &x_1& quad + quad &x_2& quad + quad &s_1& quad && quad eq quad 4 \
//   & quad &x_1& quad + quad 2&x_2& quad quad && quad + quad &s_2& quad eq quad 6 \ \
//   &#place($x_1, x_2, s_1, s_2 gt.eq 0$) \
// $

// #linebreak()

// #let eye(n) = {
//   let zeros = range(n * n).map(_ => 0)
//   let zeros = zeros.chunks(n, exact: true)
//   for i in range(n) {
//     for j in range(n) {
//       if i == j {
//         zeros.at(i).at(j) = 1
//       }
//     }
//   }
//   zeros
// }

// #let argmin(arr) = {
//   let minValue = arr.at(0)
//   let minIndex = 0
//   for (i, v) in arr.enumerate() {
//     if v < minValue {
//       minValue = v
//       minIndex = i
//     }
//   }
//   minIndex
// }

// #linebreak()

// #let dir = "max"
// #let c = (2, 3)
// #let A = (
//     (1, 1),
//     (1, 2),
// )
// #let b = (4, 6)

// #let m = A.len()
// #let n = A.at(0).len()

// #let B = eye(2)

// #let tableau_rows = ();
// #for (i, (val1, val2)) in A.zip(B).enumerate() {
//   tableau_rows.push(val1 + val2 + (b.at(i),))
// }

// #if dir == "max" {
//   c = c.map(i => i * - 1)
// } else if dir == "min" {
//   c = c
// }

// #tableau_rows.insert(0, c + range(m+1).map(_ => 0))

// #tableau_rows

// #let tableau_row_number = tableau_rows.len()
// #let tableau_col_number = tableau_rows.at(0).len()

// #let cells = tableau_rows.map(row => row.map(cell => [#cell])).flatten()

// #let A_cells = A.map(row => row.map(cell => [#cell])).flatten()
// #let c_cells = c.map(cell => [#cell])

// #table(
//   columns: tableau_col_number,
//   inset: 0.75em,
//   stroke: none,
//   table.hline(y: 1),
//   table.vline(x: tableau_col_number - 1),
//   ..c_cells,
//   ..A_cells
// )

// #let iteration = 0;
// #while true {
//   iteration += 1;
//   [== Iteration #iteration]

//   [
//     === Entering Column

//     Column with the greatest reduced costs
//   ]

//   table(
//     columns: tableau_col_number,
//     inset: 0.75em,
//     stroke: none,
//     fill: (x, y) => if x == argmin(tableau_rows.at(0)) { red.lighten(50%) },
//     table.hline(y: 1),
//     table.vline(x: tableau_col_number - 1),
//     ..cells
//   )

//   [
//     === Ratio Test
//   ]

//   let entering_col = argmin(tableau_rows.at(0))
  
//   table(
//     columns: tableau_col_number,
//     inset: 0.75em,
//     stroke: none,
//     fill: (x, y) => {
//       if y >= 1 {
//         if x == entering_col or x == tableau_col_number - 1 { 
//           red.lighten(50%) 
//         }
//       }
//     },
//     table.hline(y: 1),
//     table.vline(x: tableau_col_number - 1),
//     ..cells
//   )



//   [
//     Ratios:
//     - $#{4 / 1} = 4$
//     - $6 / 2 = 3$
//   ]

 

//   break;
// }



// #let zeros = range((m+1) * (n+m+1)).map(_ => 0)
// #let tableau = zeros.chunks(m+1, exact: true)

// #tableau

// tableau = np.zeros((m+1, n+m+1))
// tableau[:m, :n] = A
// tableau[:m, n:n+m] = np.eye(m)
// tableau[:m, -1] = b
// tableau[-1, :n] = -c




