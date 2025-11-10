#import "@preview/cetz:0.3.4"
#import "@preview/cetz-plot:0.1.1"
#import "@preview/numty:0.0.5" as nt

#import "../../../utils/examples.typ": eg
#import "../../../utils/code.typ": code
#import "../../../utils/proof.typ": proof
#import "../../../utils/color_math.typ": colorMath
#import "../../../utils/color_mat.typ": colorMat

== Linear Programming Duality

Every linear program (primal) has a *unique* and *symmetric* dual problem. For any primal LP, there is a unique dual, whose dual is the primal.

Solving the dual gives you information about the primal.

=== General Form

#grid(
  columns: (1fr, 1fr),
  align: center + horizon,
  row-gutter: 2em,
  [
    *Primal*

    $
      colorMath(min\/max, #yellow)   quad  &colorMath(bold("c"), #blue)^T bold("x") \
      s.t.  quad  &colorMath(A, #green) bold("x") colorMath(compose, #purple) colorMath(bold("b"), #red) \
                  &bold("x") colorMath(diamond.stroked.small, #orange) 0
    $
  ],
  [
    *Dual*

    $
      colorMath(max\/min, #yellow)   quad  &colorMath(bold("b"), #red)^T bold("y") \
      s.t.  quad  &colorMath(A^T, #green) bold("y") colorMath(diamond.stroked.small, #orange) colorMath(bold("c"), #blue) \
                  &bold("y") colorMath(compose, #purple) 0
    $
  ],
  [
    *Primal*

    $
      colorMath(min\/max, #yellow) quad &sum_(j=1)^n colorMath(c_j, #blue) x_j \
      s.t. quad &sum_(j=1)^n colorMath(a_(i j), #green) x_j colorMath(compose, #purple) colorMath(b_i, #red), quad i = 1, dots, m \
      &x_j colorMath(diamond.stroked.small, #orange) 0, quad j = 1, dots, n
    $
  ],
  [
    *Dual*

    $
      colorMath(max\/min, #yellow) quad w = &sum_(i=1)^m u_i colorMath(b_i, #red) \
      s.t. quad &sum_(i=1)^m colorMath(a_(j i), #green) u_i colorMath(diamond.stroked.small, #orange) colorMath(c_j, #blue), quad j = 1, dots, n \
      &u_i colorMath(compose, #purple) 0, quad i = 1, dots, m
    $
  ],
  [
    *Primal*

    $
      colorMath(min\/max, #yellow) quad &colorMath(c_1, #blue) x_1 + colorMath(c_2, #blue) x_2 + colorMath(c_3, #blue) x_3 \
      s.t. quad &colorMath(a_(1 1), #green) x_1 + colorMath(a_(1 2), #green) x_2 + colorMath(a_(1 3), #green) x_3 colorMath(gt.eq, #purple) colorMath(b_1, #red) \
          &a_(2 1) x_1 + a_(2 2) x_2 + a_(2 3) x_3 colorMath(lt.eq, #purple) colorMath(b_2, #red) \
          &a_(3 1) x_1 + a_(3 2) x_2 + a_(3 3) x_3 colorMath(eq, #purple) colorMath(b_3, #red) \
          &x_1 colorMath(gt.eq, #orange) 0, quad x_2 colorMath(lt.eq, #orange) 0, quad x_3 colorMath("urs", #orange) \
    $
  ], [
    *Dual*

    $
      colorMath(max\/min, #yellow) quad &colorMath(b_1, #red) y_1 + colorMath(b_2, #red) y_2 + colorMath(b_3, #red) y_3 \
      s.t. quad &colorMath(a_(1 1), #green) y_1 + a_(2 1) y_2 + a_(3 1) y_3 colorMath(gt.eq, #orange) colorMath(c_1, #blue) \
          &colorMath(a_(1 2), #green) y_1 + a_(2 2) y_2 + a_(3 2) y_3 colorMath(lt.eq, #orange) colorMath(c_2, #blue) \
          &colorMath(a_(1 3), #green) y_1 + a_(2 3) y_2 + a_(3 3) y_3 colorMath(eq, #orange) colorMath(c_3, #blue) \
          &y_1 colorMath(lt.eq, #purple) 0, quad y_2 colorMath(gt.eq, #purple) 0, quad y_3 colorMath("urs", #purple) \
    $
  ],
)

=== Standard Form

#grid(
  columns: (1fr, 1fr),
  align: center + horizon,
  row-gutter: 2em,
  
  [
    *Primal*

    $
      colorMath(min\/max, #yellow)   quad &colorMath(bold("c"), #blue)^T bold("x") \
      s.t.  quad  &colorMath(A, #green) bold("x") colorMath(=, #purple) colorMath(bold("b"), #red) \
      &bold("x") colorMath(gt.eq, #orange) 0
    $
  ],
  [
    *Dual*

    $
      colorMath(max\/min, #yellow)   quad &colorMath(bold("b"), #red)^T bold("y") \
      s.t.  quad  &colorMath(A^T, #green) bold("y") colorMath(gt.eq, #orange) colorMath(bold("c"), #blue) \
                  &bold("y") colorMath("urs", #purple)
    $
  ],
  [
    *Primal*

    $
      colorMath(min\/max, #yellow) quad &sum_(j=1)^n colorMath(c_j, #blue) x_j \
      s.t. quad &sum_(j=1)^n colorMath(a_(i j), #green) x_j colorMath(=, #purple) colorMath(b_i, #red), quad i = 1, dots, m \
      &x_j colorMath(gt.eq, #orange) 0, quad j = 1, dots, n
    $
  ],
  [
    *Dual*

    $
      colorMath(max\/min, #yellow) quad w = &sum_(i=1)^m y_i colorMath(b_i, #red) \
      s.t. quad &sum_(i=1)^m colorMath(a_(j i), #green) y_i colorMath(lt.eq, #orange) colorMath(c_j, #blue), quad j = 1, dots, n \
      &y_i colorMath("urs", #purple), quad i = 1, dots, m
    $
  ],
  [
    *Primal*

    $
      colorMath(min\/max, #yellow) quad &colorMath(c_1, #blue) x_1 + colorMath(c_2, #blue) x_2 + colorMath(c_3, #blue) x_3 \
      s.t. quad &colorMath(a_(1 1), #green) x_1 + colorMath(a_(1 2), #green) x_2 + colorMath(a_(1 3), #green) x_3 colorMath(=, #purple) colorMath(b_1, #red) \
          &a_(2 1) x_1 + a_(2 2) x_2 + a_(2 3) x_3 colorMath(=, #purple) colorMath(b_2, #red) \
          &a_(3 1) x_1 + a_(3 2) x_2 + a_(3 3) x_3 colorMath(=, #purple) colorMath(b_3, #red) \
          &x_1, x_2, x_3 colorMath(gt.eq, #orange) 0
    $
  ],
  [
    *Dual*

    $
      colorMath(max\/min, #yellow) quad &colorMath(b_1, #red) y_1 + colorMath(b_2, #red) y_2 + colorMath(b_3, #red) y_3 \
      s.t. quad &colorMath(a_(1 1), #green) y_1 + a_(2 1) y_2 + a_(3 1) y_3 colorMath(gt.eq, #orange) colorMath(c_1, #blue) \
          &colorMath(a_(1 2), #green) y_1 + a_(2 2) y_2 + a_(3 2) y_3 colorMath(gt.eq, #orange) colorMath(c_2, #blue) \
          &colorMath(a_(1 3), #green) y_1 + a_(2 3) y_2 + a_(3 3) y_3 colorMath(gt.eq, #orange) colorMath(c_3, #blue) \
          &y_1, y_2, y_3 colorMath("urs", #purple)
    $
  ],

)

#linebreak()

#align(center)[
  #table(
    columns: (auto, auto, auto, auto),
    align: center + horizon,
    [Obj], [max], [min], [Obj],
    [
      Constraint
    ], [
      $
        lt.eq \
        gt.eq \
        eq \     
      $
    ], [
      $
        gt.eq 0 \
        lt.eq 0 \
        "urs". \
      $
    ], [
      Variable
    ],
    
    [
      Variable
    ], [
      $
        gt.eq 0 \
        lt.eq 0 \
        "urs". \
      $
    ], [
      $
        lt.eq \
        gt.eq \
        eq \     
      $
    ], [
      Constraint
    ],
  )
]

#eg[
  *Minimization*

  #grid(
    columns: (1fr, 1fr),
    align: center,
    row-gutter: 1em,
    [
      *Primal*
      $
        min quad 3&x_1 quad +& quad 2x_2& \
        s.t. quad &x_1 quad +& quad 2x_2& quad gt.eq& quad &4 \
                  2&x_1 quad +& quad x_2& quad gt.eq& quad &5 \
                  &#place($x_1 lt.eq 0, quad x_2 "urs"$) \
      $
    ], [
      *Dual*
      $
        max quad 4&y_1 quad +& quad 5&y_2& \
        s.t. quad &y_1 quad +& quad 2y_2& quad gt.eq& quad &3 \
                  2&y_1 quad +& quad y_2& quad eq& quad &2 \
                  &#place($y_1 lt.eq 0, quad y_2 lt.eq 0$) \
      $
    ],
  )

  *Maximization*

  #grid(
    columns: (1fr, 1fr),
    align: center,
    row-gutter: 1em,
    [
      *Primal*

      $
        max quad  3&x_1 quad +& quad 2x_2& \
        s.t. quad  &x_1 quad +& quad  2x_2& quad lt.eq& quad &4 \
                  2&x_1 quad   +&  quad  x_2& quad lt.eq& quad &5 \
                  &#place($x_1 gt.eq 0, quad x_2 "urs"$) \
      $
    ],
    [
      *Dual*
      
      $
        min quad  4&y_1 quad +& quad 5y_2& \
        s.t. quad  &y_1 quad +& quad 2y_2& quad gt.eq& quad &3 \
                  2&y_1 quad   +&  quad  y_2& quad =& quad &2 \
                  &#place($y_1 gt.eq 0, quad y_2 gt.eq 0$) \
      $
    ]
  )

  #linebreak()
    
]

=== Weak Duality

1. Dual objective gives a *lower bound* for a *minimization* primal

$
  c^T x gt.eq b^T y
$

2. Dual objective gives an *upper bound* for a *maximization* primal

$
  c^T x lt.eq b^T y
$

Suffciency of optimality

If $macron(x)$ and $macron(y)$ are primal and dual feasible and $c^T macron(x) lt.eq macron(y)^T b$, then $macron(x)$ and $macron(y)$ are primal and dual optimal

#eg[

]

Given a primal feasible solution $macron(x)$, if we find a dual feasible solution so that their objective values are identical, $macron(x)$ is optimal (strong duality)

=== Dual Oprimal solution

If we have solved the primal LP, the dual optimal solution can be obtained 

If $macron(x)$ is primal optimal with basis $B$, then $macron(y)^T = c_B^T A_B^(-1)$ is dual optimal

=== Strong Duality

If both primal and dual are feasible and at least one has an optimal solution:

$macron(x)$ and $macron(y)$ are primal and dual optimal iif $macron(x)$ and $macron(y)$ are primal and dual feasible and

$
  c^T macron(x) = b^T macron(y)
$

#eg[
  #align(center)[
    #grid(
      columns: 3,
      align: center + horizon,
      column-gutter: 3em,
      [
        *Primal*

        $
          max quad &x_1 \
          s.t. quad 2&x_1 quad -& quad x_2& quad lt.eq& quad &4 \
                    2&x_1 quad +& quad x_2& quad lt.eq& quad &8 \
                     &    quad  & quad x_2& quad lt.eq& quad &3 \
                    &#place($x_1, x_2 gt.eq 0$) \
        $
      ],
      [
        $arrow.double.l.r$
      ],
      [
        *Dual*
        $
          min quad  4&y_1 quad +& quad 8&y_2 quad &+ quad 3&y_3 \
          s.t. quad 2&y_1 quad +& quad 2&y_2 quad &        &    quad &gt.eq quad &1 \
                    -&y_1 quad +& quad  &y_2 quad &+ quad  &y_3 quad &gt.eq quad &1 \
                    &#place($y_1, y_2, y_3 gt.eq 0$) \
        $
      ],
    )
  ]

  #linebreak()

  Using the simplex method, we obtain the optimal tableau:

  #align(center)[
    #grid(
      columns: 3,
      align: center + horizon,
      column-gutter: 1em,
      [
        #table(
          columns: 6,
          inset: 0.5em,
          stroke: none,
          table.vline(x: 5),
          [-1], [0], [0], [0], [0], [0],
          table.hline(),
          [2], [-1], [1], [0], [0], [$x_3 = 4$],
          [2], [1], [0], [1], [0], [$x_4 = 8$],
          [0], [1], [0], [0], [1], [$x_5 = 3$],
        )
      ],
      [
        $
          arrow quad dots quad arrow
        $
      ],
      [
        #table(
          columns: 6,
          inset: 0.5em,
          stroke: none,
          table.vline(x: 5),
          [0], [0], [1/4], [1/4], [0], [3],
          table.hline(),
          [1], [0], [1/4], [1/4], [0], [$x_1 = 3$],
          [0], [1], [-1/2], [1/2], [0], [$x_2 = 2$],
          [0], [0], [1/2], [-1/2], [1], [$x_5 = 1$],
        )
      ]
    )
  ]

  - The associated optimal basis is $B = (1, 2, 5)$
  - The optimal solution is $macron(x) = (3, 2)$
  - The associated objective value is $z^* = 3$

  For the standard form primal LP:

  $
    c^T = #colorMat(
      (
        (1, 0, 0, 0, 0),
      ),
      (
        (((0,0), (0, 1)), red),
        (((0,4), (4, 4)), red),
      )
    )
    quad quad 
    A = #colorMat(
      (
        (2, -1, 1, 0, 0),
        (2, 1, 0,1, 0),
        (0, 1, 0, 0, 1),
      ),
      (
        (((0,0), (2, 1)), red),
        (((0,4), (4, 4)), red),
      )
    )
  $

  Given $x_B = (x_1, x_2, x_5)$ and $x_N = (x_2, x_4)$:

  $
    c_B^T = #colorMat(
      (
        (1, 0, 0),
      ),
      (
        (((0,0), (0, 2)), red),
      ),
    ) 
    quad quad 
    A_B = #colorMat(
      (
        (2, -1, 0),
        (2, 1, 0),
        (0, 0, 1),
      ),
      (
        (((0,0), (2, 2)), red),
      )
    )
  $

  $
    macron(y) 
    = c_B^T A_B^(-1) 
    = mat(1, 0, 0) mat(
      1/4, 1/4, 0;
      -1/2, 1/2, 0;
      1/2, -1/2, 1
    )
    = mat(1/4, 1/4, 0)
  $

  For $macron(y) = (1/4, 1/4, 0)$:
  - It is dual feasible: $2(1/4) + 2(1/4) gt 1$ and $-1/4 + 1/4 + 0 gt.eq 0$
  - Its dual objective value $w = 4(1/4) + 8(1/4) = 3 = z^*$

  Therefore $macron(y)$ is *dual optimal*
]

#eg[

  *Minimization*

  #grid(
    columns: (1fr, 1fr),
    align: center,
    row-gutter: 1em,
    [
      *Primal*

      $
        min quad &x_1 quad +& quad x_2& \
        s.t. quad &x_1 quad +& quad 2x_2& quad gt.eq& quad &2 \
                  3&x_1 quad +& quad x_2& quad gt.eq& quad &3 \
                  &#place($x_1, x_2 gt.eq 0$) \
      $
    ],
    [
      *Dual*
      $
        max quad 2&y_1 quad +& quad 3y_2& \
        s.t. quad &y_1 quad +& quad 3y_2& quad lt.eq& quad &1 \
                  2&y_1 quad +& quad y_2& quad lt.eq& quad &1 \
                  &#place($y_1, y_2 gt.eq 0$) \
      $
    ],
    grid.cell(
      colspan: 2,
      [
        *Strong Duality*
        $
          c^T x^* = b^T y^* 
        $
      ]
    ),
    [
      #cetz.canvas({
        import cetz.draw: *
        import cetz-plot: *

        let obj(x, z) = (z - 1*x)
        let c1(x) = (2 - x)/2
        let c2(x) = (3 - 3*x)

        plot.plot(
          size: (5,5),
          axis-style: "school-book",
          x-tick-step: 0.5, 
          y-tick-step: 0.5, 
          x-label: [$x_1$],
          y-label: [$x_2$],
          x-min: 0, x-max: 1.5,
          y-min: 0, y-max: 1.5,
          axes: (
            stroke: black,
            tick: (stroke: black),
          ),
        {

          plot.add(
            domain: (0, 5),
            x => obj(x, 1.4),
            style: (stroke: (thickness: 1pt, paint: black, dash: "dashed")),
          )

          plot.add(
            domain: (0, 5),
            c1,
            style: (stroke: (thickness: 1pt, paint: red)),
          )
          plot.add(
            domain: (0, 5),
            c2,
            style: (stroke: (thickness: 1pt, paint: red)),
          )

          plot.add(
            ((0.8, 0.6),),
            mark: "o",
            mark-size: 0.2,
            style: (fill: none, stroke: none),
            mark-style: (fill: red, stroke: black),
          )

          plot.add-fill-between(
            domain: (0, 6),
            x => calc.max(c1(x), c2(x)),
            x1 => 3,
            style: (fill: rgb(200, 200, 255, 80), stroke: none),
            label: none
          )

        }, name: "plot")
      })
    ],
    [
      #cetz.canvas({
        import cetz.draw: *
        import cetz-plot: *

        let obj(y, z) = (z - 2*y) / 3
        let c1(y) = (1 - y) / 3
        let c2(y) = (1 - 2*y)

        plot.plot(
          size: (5,5),
          axis-style: "school-book",
          x-tick-step: 0.1, 
          y-tick-step: 0.1, 
          x-label: [$y_1$],
          y-label: [$y_2$],
          x-min: 0, x-max: 0.5,
          y-min: 0, y-max: 0.5,
          axes: (
            stroke: black,
            tick: (stroke: black),
          ),
        {

          plot.add(
            domain: (0, 5),
            x => obj(x, 1.4),
            style: (stroke: (thickness: 1pt, paint: black, dash: "dashed")),
          )

          plot.add(
            domain: (0, 5),
            c1,
            style: (stroke: (thickness: 1pt, paint: red)),
          )
          plot.add(
            domain: (0, 5),
            c2,
            style: (stroke: (thickness: 1pt, paint: red)),
          )

          plot.add(
            ((0.4, 0.2),),
            mark: "o",
            mark-size: 0.2,
            style: (fill: none, stroke: none),
            mark-style: (fill: red, stroke: black),
          )

          plot.add-fill-between(
            domain: (0, 2),
            x => calc.min(c1(x), c2(x)),
            x1 => 0,
            style: (fill: rgb(200, 200, 255, 80), stroke: none),
            label: none
          )
        }, name: "plot")
      })
    ],
    [
      $
        x^* = (0.8, 0.6) \
        z^* = 1.4
      $
    ], 
    [
      $
        y^* = (0.4, 0.2) \
        z^* = 1.4
      $
    ],
    grid.cell(
      colspan: 2,
      [
        *Weak Duality*
        $
          c^T x > b^T y \ 
          "if" \ 
          x eq.not x^* "or" y eq.not y^*
        $
      ]
    ),
    [
      #cetz.canvas({
        import cetz.draw: *
        import cetz-plot: *

        let obj(x, z) = (z - 1*x)
        let c1(x) = (2 - x)/2
        let c2(x) = (3 - 3*x)

        let x_opt = (1, 1)
        let x1 = (0.8, 0.6)
        let x2 = (1.25, 0.75)

        plot.plot(
          size: (5,5),
          axis-style: "school-book",
          x-tick-step: 0.5, 
          y-tick-step: 0.5, 
          x-label: [$x_1$],
          y-label: [$x_2$],
          x-min: 0, x-max: 1.5,
          y-min: 0, y-max: 1.5,
          axes: (
            stroke: black,
            tick: (stroke: black),
          ),
        {

          plot.add(
            domain: (0, 5),
            x => obj(x, 1.4),
            style: (stroke: (thickness: 1pt, paint: black, dash: "dashed")),
          )

          plot.add(
            domain: (0, 5),
            c1,
            style: (stroke: (thickness: 1pt, paint: red)),
          )
          plot.add(
            domain: (0, 5),
            c2,
            style: (stroke: (thickness: 1pt, paint: red)),
          )

          plot.add(
            (x_opt,),
            mark: "o",
            mark-size: 0.2,
            style: (fill: none, stroke: none),
            mark-style: (fill: blue, stroke: black),
          )
          
          plot.add(
            (x1,),
            mark: "o",
            mark-size: 0.2,
            style: (fill: none, stroke: none),
            mark-style: (fill: red, stroke: black),
          )

          plot.add(
            (x2,),
            mark: "o",
            mark-size: 0.2,
            style: (fill: none, stroke: none),
            mark-style: (fill: green, stroke: black),
          )

          plot.add-fill-between(
            domain: (0, 6),
            x => calc.max(c1(x), c2(x)),
            x1 => 3,
            style: (fill: rgb(200, 200, 255, 80), stroke: none),
            label: none
          )

        }, name: "plot")
      })
    ],
    [
      #cetz.canvas({
        import cetz.draw: *
        import cetz-plot: *

        let obj(y, z) = (z - 2*y) / 3
        let c1(y) = (1 - y) / 3
        let c2(y) = (1 - 2*y)

        let y_opt = (0.4, 0.2)
        let y1 = (0.2, 0.1)
        let y2 = (0.1, 0.2)

        plot.plot(
          size: (5,5),
          axis-style: "school-book",
          x-tick-step: 0.1, 
          y-tick-step: 0.1, 
          x-label: [$y_1$],
          y-label: [$y_2$],
          x-min: 0, x-max: 0.5,
          y-min: 0, y-max: 0.5,
          axes: (
            stroke: black,
            tick: (stroke: black),
          ),
        {

          plot.add(
            domain: (0, 5),
            x => obj(x, 1.4),
            style: (stroke: (thickness: 1pt, paint: black, dash: "dashed")),
          )

          plot.add(
            domain: (0, 5),
            c1,
            style: (stroke: (thickness: 1pt, paint: red)),
          )
          plot.add(
            domain: (0, 5),
            c2,
            style: (stroke: (thickness: 1pt, paint: red)),
          )

          plot.add(
            (y_opt,),
            mark: "o",
            mark-size: 0.2,
            style: (fill: none, stroke: none),
            mark-style: (fill: blue, stroke: black),
          )
          
          plot.add(
            (y1,),
            mark: "o",
            mark-size: 0.2,
            style: (fill: none, stroke: none),
            mark-style: (fill: red, stroke: black),
          )
          
          plot.add(
            (y2,),
            mark: "o",
            mark-size: 0.2,
            style: (fill: none, stroke: none),
            mark-style: (fill: green, stroke: black),
          )

          plot.add-fill-between(
            domain: (0, 2),
            x => calc.min(c1(x), c2(x)),
            x1 => 0,
            style: (fill: rgb(200, 200, 255, 80), stroke: none),
            label: none
          )
        }, name: "plot")
      })
    ],
    grid.cell(
      colspan: 2,
      [
        $
          colorMath(x^*, #red) = (0.8, 0.6)& quad &   quad &colorMath(y, #red) = (0.2, 0.1) \
          colorMath(z^*, #red) =        1.4& quad &gt quad &colorMath(w, #red) = 1 \
          \ \
          colorMath(x, #blue) = (1, 1)& quad &   quad &colorMath(y^*, #blue) = (0.4, 0.2) \
          colorMath(z, #blue) =    2& quad &gt quad &colorMath(w^*, #blue)   = 1.4 \
          \ \
          colorMath(x, #green) = (1, 1)& quad &   quad &colorMath(y, #green) = (0.4, 0.2) \
          colorMath(z, #green) =    2& quad &gt quad &colorMath(w, #green)   = 1.4 \
        $
      ]
    ),
  )

  *Minimization*

  #grid(
    columns: (1fr, 1fr),
    align: center,
    row-gutter: 1em,
    [
      *Primal*
      $
        max quad &x_1 quad +& quad x_2& \
        s.t. quad 2&x_1 quad +& quad x_2& quad lt.eq& quad &4 \
                  &x_1 quad +& quad 2x_2& quad lt.eq& quad &5 \
                  &#place($x_1, x_2 gt.eq 0$) \
      $
    ],
    [
      *Dual*
      $
        min quad 4&y_1 quad +& quad 5y_2& \
        s.t. quad 2&y_1 quad +& quad y_2& quad gt.eq& quad &1 \
                  &y_1 quad +& quad 2y_2& quad gt.eq& quad &1 \
                  &#place($y_1, y_2 gt.eq 0$) \
      $
    ],
    grid.cell(
      colspan: 2,
      [
        *Strong Duality*
        $
          c^T x^* = b^T y^* 
        $
      ]
    ),
    [
      #cetz.canvas({
        import cetz.draw: *
        import cetz-plot: *

        let obj(x, z) = (z - x)
        let c1(x) = 4 - 2*x
        let c2(x) = (5 - x) / 2

        plot.plot(
          size: (5,5),
          axis-style: "school-book",
          x-tick-step: 1, 
          y-tick-step: 1, 
          x-label: [$x_1$],
          y-label: [$x_2$],
          x-min: 0, x-max: 5,
          y-min: 0, y-max: 5,
          axes: (
            stroke: black,
            tick: (stroke: black),
          ),
        {

          plot.add(
            domain: (0, 5),
            x => obj(x, 3),
            style: (stroke: (thickness: 1pt, paint: black, dash: "dashed")),
          )

          plot.add(
            domain: (0, 5),
            c1,
            style: (stroke: (thickness: 1pt, paint: red)),
          )
          plot.add(
            domain: (0, 5),
            c2,
            style: (stroke: (thickness: 1pt, paint: red)),
          )

          plot.add(
            ((1, 2),),
            mark: "o",
            mark-size: 0.2,
            style: (fill: none, stroke: none),
            mark-style: (fill: red, stroke: black),
          )

          plot.add-fill-between(
            domain: (0, 5),
            x => calc.min(c1(x), c2(x)),
            x1 => 0,
            style: (fill: rgb(200, 200, 255, 80), stroke: none),
            label: none
          )
        }, name: "plot")
      })
    ],
    [
      #cetz.canvas({
        import cetz.draw: *
        import cetz-plot: *

        let obj(y, z) = (z - 4*y) / 5
        let c1(y) = 1 - 2*y
        let c2(y) = (1 - y) / 2

        plot.plot(
          size: (5,5),
          axis-style: "school-book",
          x-tick-step: 0.2, 
          y-tick-step: 0.2, 
          x-label: [$y_1$],
          y-label: [$y_2$],
          x-min: 0, x-max: 1,
          y-min: 0, y-max: 1,
          axes: (
            stroke: black,
            tick: (stroke: black),
          ),
        {

          plot.add(
            domain: (0, 5),
            x => obj(x, 3),
            style: (stroke: (thickness: 1pt, paint: black, dash: "dashed")),
          )

          plot.add(
            domain: (0, 5),
            c1,
            style: (stroke: (thickness: 1pt, paint: red)),
          )
          plot.add(
            domain: (0, 5),
            c2,
            style: (stroke: (thickness: 1pt, paint: red)),
          )

          plot.add(
            ((1/3, 1/3),),
            mark: "o",
            mark-size: 0.2,
            style: (fill: none, stroke: none),
            mark-style: (fill: red, stroke: black),
          )

          plot.add-fill-between(
            domain: (0, 5),
            x => calc.max(c1(x), c2(x)),
            x1 => 5,
            style: (fill: rgb(200, 200, 255, 80), stroke: none),
            label: none
          )
        }, name: "plot")
      })
    ],
    [
      $
        x^* = (1, 2) \
        z^* = 3
      $
    ], 
    [
      $
        y^* = (1/3, 1/3) \
        z^* = 3
      $
    ],
    grid.cell(
      colspan: 2,
      [
        *Weak Duality*
        $
          c^T x < b^T y \ 
          "if" \ 
          x eq.not x^* "or" y eq.not y^*
        $
      ]
    ),
    [
      #cetz.canvas({
        import cetz.draw: *
        import cetz-plot: *

        let obj(x, z) = (z - x)
        let c1(x) = 4 - 2*x
        let c2(x) = (5 - x) / 2

        plot.plot(
          size: (5,5),
          axis-style: "school-book",
          x-tick-step: 1, 
          y-tick-step: 1, 
          x-label: [$x_1$],
          y-label: [$x_2$],
          x-min: 0, x-max: 5,
          y-min: 0, y-max: 5,
          axes: (
            stroke: black,
            tick: (stroke: black),
          ),
        {

          plot.add(
            domain: (0, 5),
            x => obj(x, 3),
            style: (stroke: (thickness: 1pt, paint: black, dash: "dashed")),
          )

          plot.add(
            domain: (0, 5),
            c1,
            style: (stroke: (thickness: 1pt, paint: red)),
          )
          plot.add(
            domain: (0, 5),
            c2,
            style: (stroke: (thickness: 1pt, paint: red)),
          )

          plot.add(
            ((1, 2),),
            mark: "o",
            mark-size: 0.2,
            style: (fill: none, stroke: none),
            mark-style: (fill: red, stroke: black),
          )

          plot.add(
            ((1, 0.5),),
            mark: "o",
            mark-size: 0.2,
            style: (fill: none, stroke: none),
            mark-style: (fill: blue, stroke: black),
          )
          
          plot.add(
            ((0.5, 1),),
            mark: "o",
            mark-size: 0.2,
            style: (fill: none, stroke: none),
            mark-style: (fill: green, stroke: black),
          )

          plot.add-fill-between(
            domain: (0, 5),
            x => calc.min(c1(x), c2(x)),
            x1 => 0,
            style: (fill: rgb(200, 200, 255, 80), stroke: none),
            label: none
          )
        }, name: "plot")
      })
    ],
    [
      #cetz.canvas({
        import cetz.draw: *
        import cetz-plot: *

        let obj(y, z) = (z - 4*y) / 5
        let c1(y) = 1 - 2*y
        let c2(y) = (1 - y) / 2

        plot.plot(
          size: (5,5),
          axis-style: "school-book",
          x-tick-step: 0.2, 
          y-tick-step: 0.2, 
          x-label: [$y_1$],
          y-label: [$y_2$],
          x-min: 0, x-max: 1,
          y-min: 0, y-max: 1,
          axes: (
            stroke: black,
            tick: (stroke: black),
          ),
        {

          plot.add(
            domain: (0, 5),
            x => obj(x, 3),
            style: (stroke: (thickness: 1pt, paint: black, dash: "dashed")),
          )

          plot.add(
            domain: (0, 5),
            c1,
            style: (stroke: (thickness: 1pt, paint: red)),
          )
          plot.add(
            domain: (0, 5),
            c2,
            style: (stroke: (thickness: 1pt, paint: red)),
          )

          plot.add(
            ((1/3, 1/3),),
            mark: "o",
            mark-size: 0.2,
            style: (fill: none, stroke: none),
            mark-style: (fill: blue, stroke: black),
          )
          
          plot.add(
            ((0.8, 0.4),),
            mark: "o",
            mark-size: 0.2,
            style: (fill: none, stroke: none),
            mark-style: (fill: red, stroke: black),
          )
          
          plot.add(
            ((0.4, 0.8),),
            mark: "o",
            mark-size: 0.2,
            style: (fill: none, stroke: none),
            mark-style: (fill: green, stroke: black),
          )

          plot.add-fill-between(
            domain: (0, 5),
            x => calc.max(c1(x), c2(x)),
            x1 => 5,
            style: (fill: rgb(200, 200, 255, 80), stroke: none),
            label: none
          )
        }, name: "plot")
      })
    ],
    grid.cell(
      colspan: 2,
      [
        $
          colorMath(x^*, #red) = (1, 2)& quad &   quad &colorMath(y, #red) = (0.8, 0.4) \
          colorMath(z^*, #red) = 3& quad &lt quad &colorMath(w, #red) = 5.6 \
          \ \
          colorMath(x, #blue) = (1, 0.5)& quad &   quad &colorMath(y^*, #blue) = (1/3, 1/3) \
          colorMath(z, #blue) = 1.5& quad &lt quad &colorMath(w^*, #blue)   = 3 \
          \ \
          colorMath(x, #green) = (0.5, 1)& quad &   quad &colorMath(y, #green) = (0.4, 0.8) \
          colorMath(z, #green) = 1.5& quad &lt quad &colorMath(w, #green) = 5.6 \
        $
      ]
    ),
  )
]

=== Feasibility-Infeasibility Certificates

- If the primal is *infeasible*, the dual is either *infeasible* or *unbounded*
- If the primal is *unbounded*, the dual is necessarily *infeasible*


#align(center)[
  #table(
    columns: 4,
    inset: 1em,
    align: center + horizon,
    stroke: none,
    table.hline(),
    table.cell(
      rowspan: 2,
      [Primal]
    ), 
    table.cell(
      colspan: 3,
      [Dual]
    ),
    table.hline(),
    [Infeasible], [Unbounded], [Finitely Optimal],
    table.hline(),
    [Infeasible], [✅], [✅], [❌],
    [Unbounded], [✅], [❌], [❌],
    [Finitely Optimal], [❌], [❌], [✅],
    table.hline(),
  )
]

- ✅ means possible and ❌ means impossible
- Primal unbounded $arrow$ no upper bound $arrow$ dual infeasible
- Primal finitely optimal $arrow$ finite objective value $arrow$ dual finitely optimal
- Primal infeasible $arrow$ dual infeasible or unbounded

#eg[
  *Infeasible Primal $arrow$ Infeasible Dual* 

  #grid(
    columns: (1fr, 1fr),
    row-gutter: 1em,
    [
      *Primal*
      $
        min quad 2&x_1 quad +& quad 2x_2& \
        s.t. quad &x_1 quad +& quad x_2& quad gt.eq& quad &5 \
                  &x_1 quad +& quad x_2& quad lt.eq& quad &3 \
                  &#place($x_1, x_2 gt.eq 0$) \
      $
    ],
    [
      *Dual*
      $
        max quad &y_1 quad +& quad y_2& \
        s.t. quad &y_1 quad +& quad y_2& quad lt.eq& quad &2 \
                  &y_1 quad +& quad y_2& quad lt.eq& quad &2 \
                  &#place($y_1, y_2 gt.eq 0$) \
      $
    ],
    [

    ],
    [
      
    ]
  )

  *Infeasible Primal $arrow$ Unbounded Dual*

  #grid(
    columns: (1fr, 1fr),
    row-gutter: 1em,
    [

    ],
    [

    ],
    [

    ],
    [

    ]
  )

  *Unbounded Primal $arrow$ Infeasible Primal*

  #grid(
    columns: (1fr, 1fr),
    row-gutter: 1em,
    [

    ],
    [

    ],
    [

    ],
    [

    ]
  )

]

=== Strong and Weak Duality

#align(center)[
  #table(
    columns: (auto, auto, auto, auto),
    align: center + horizon,
    inset: 1em,
    [*Problem Type*], [*Duality*], [*Weak Duality*], [*Strong Duality*],

    [*Min* Primal\ *Max* Dual], 
    [$c^T x gt.eq b^T y$], 
    [$c^T x > b^T y \ "if" \ x eq.not x^* "or" y eq.not y^*$], 
    [$c^T x^* = b^T y^*$],

    [*Max* Primal\ *Min* Dual], 
    [$c^T x lt.eq b^T y$], 
    [$c^T x lt b^T y \ "if" \ x eq.not x^* "or" y eq.not y^*$], 
    [$c^T x^* = b^T y^*$],
  )
]

=== Complimentary Slackness

*Slack* variables of the dual LP

#align(center)[
  #grid(
    columns: 3,
    align: center + horizon,
    column-gutter: 3em,
    [
      $
        max quad &c^T x \
        s.t. quad &A x = b \
        &x gt.eq 0
      $
    ],
    [
      $arrow.double.l.r$
    ],
    [
      $
        min quad &y^T b \
        s.t. quad &y^T A gt.eq c^T \
        &x "urs"
      $
    ]
  )
]




$
  min quad &y^T b \
  s.t. quad &y^T A colorMath(- v^T, #red) = c^T \
  &v gt.eq 0 
$

$macron(x)$ and $(macron(y), macron(v))$ are primal and dual opimal iif they are feasible and $macron(v)^T macron(x) = bold(0)$

#proof[
  We have 
  $
    c^T macron(x) 
    &= (macron(y)^T A - macron(v)^T) macron(x) \
    &= macron(y)^T A macron(x) - macron(v)^T macron(x) \
    &= macron(y)^T b - macron(v)^T macron(x) \
  $

  Therefore $macron(v)^T macron(x) = 0$ iif $c^T macron(x) = macron(y)^T b$, i.e., $macron(x)$ and $(macron(y), macron(v))$ are primal and dual optimal according to strong duality.

  - Note that $v^T macron(x) = 0$ iif $macron(v)_i macron(x)_i = 0$ for all $i$ as $macron(x)_i gt.eq 0$ and $macron(v) gt.eq 0$
  - If a dual (primal) constraint is *nonbinding*, the corresponding primal (dual) variable is *zero*
]

#eg[
  #align(center)[
    #set text(size: 8pt)
    #grid(
      columns: 3,
      align: center + horizon,
      column-gutter: 3em,
      row-gutter: 3em,
      [
        *Primal*

        $
          max quad &x_1 \
          s.t. quad 2&x_1 quad -& quad x_2& quad lt.eq& quad &4 \
                    2&x_1 quad +& quad x_2& quad lt.eq& quad &8 \
                     &    quad  & quad x_2& quad lt.eq& quad &3 \
                    &#place($x_1, x_2 gt.eq 0$) \
        $
      ],
      [
        $arrow.double.l.r$
      ],
      [
        *Dual*
        $
          min quad  4&y_1 quad +& quad 8&y_2 quad &+ quad 3&y_3 \
          s.t. quad 2&y_1 quad +& quad 2&y_2 quad &        &    quad &gt.eq quad &1 \
                    -&y_1 quad +& quad  &y_2 quad &+ quad  &y_3 quad &gt.eq quad &0 \
                    &#place($y_1, y_2, y_3 gt.eq 0$) \
        $
      ],
      grid.cell(
        colspan: 3,
        align: left,
        [
          Let $s_i$ and $v_j$ be the slack variables for the primal and dual LPs:
        ]
      ),
      [
        $
          max quad &x_1 \
          s.t. quad 2&x_1 quad -& quad x_2& quad colorMath(&+ quad  &s_1, #red) quad  &  quad  &         &       &    quad &eq quad &4 \
                    2&x_1 quad +& quad x_2& quad &  quad  &    quad  colorMath(&+ quad  &s_2, #red) quad &       &    quad &eq quad &8 \
                     &    quad  & quad x_2& quad &  quad  &    quad  &  quad  &    quad colorMath(&+ quad &s_3, #red) quad &eq quad &3 \
                    &#place($x_1, x_2 gt.eq 0, quad s_1, s_2, s_3 gt.eq 0$) \
        $
      ],
      [
        $arrow.double.l.r$
      ],
      [
        $
          min quad  4&y_1 quad +& quad 8&y_2 quad &+ quad 3&y_3 \
          s.t. quad 2&y_1 quad +& quad 2&y_2 quad &        &    quad &colorMath(- quad v_1, #red) quad & &eq quad &1 \
                    -&y_1 quad +& quad  &y_2 quad &+ quad  &y_3 quad &     &colorMath(- quad v_2, #red) quad &eq quad &0 \
                     &#place($y_1, y_2, y_3 gt.eq 0, quad v_1, v_2 gt.eq 0$) \
        $
      ],
    )
  ]

  If optimal solution:
  $
    x_1 v_1 = bold(0) \
    x_2 v_2 = bold(0) \
    dots.v
  $

  Similarly, for an optimal solution:

  $
    s_1 y_1 = bold(0) \
    s_2 y_2 = bold(0) \
    dots.v
  $

  Let $(macron(x), macron(s))$ be primal optimal, we have $(macron(x), macron(s)) = (3, 2, 0, 0, 1)$. Let's find the dual optimal solution $(macron(y), macron(v))$ without solving the LP.

  According to complimentary slackness $macron(x_1), macron(x_2), macron(s_1) gt 0$ imply $macron(v_1) = macron(v_2) = macron(y_3) = 0$ since:

  $
    macron(x_1) macron(x_1) = 0 \
    macron(x_2) macron(x_2) = 0 \
    macron(s_3) macron(y_3) = 0 \
  $

  The two dual functional equalities are reduced to:

  $
    2 macron(y_1) + 2 macron(y_2) = 1 \ 
    - macron(y_1) + macron(y_2) = 0 \ 
  $

  Solving the above equaltions results in $macron(y_1) = 1/4$ and $macron(y_2) = 1/4$. 
  
  $(macron(y), macron(v))$ is then guaranteed to be dual optimal

  ($z^* = 3 = w^*$)

  If a primal solution is positive, the dual slack must be zero and vis versa.

]



#line(length: 100%)

$
  x_i (c_i - (A^T y)_i) = bold(0) quad forall i
$

If:
- $x_i gt 0$: dual constraint is tight (equality holds)
- $x_i = 0$: dual constraint is slack (inequality not binding)

=== Shadow Prices

What if I have an additional unit of a particular resource?

For each resource there is a maximum price we are willing to pay for one additional unit

Definition: Shadow Price

For an LP that has an optimal colution, the *shadow price of a constraint* if the amount the objective value increases when the RHS of that constrint *increases* by 1, *assuming the current optimal basis remains optimal*

Sign or Shadow Price

#align(center)[
  #table(
    columns: 4,
    inset: 1em,
    align: center + horizon,
    stroke: none,
    table.hline(),
    table.cell(
      rowspan: 2,
      [Objective\ Function]
    ),
    table.hline(),
    table.cell(
      colspan: 3,
      [Constraint]
    ),
    [$lt.eq$], [$gt.eq$], [$eq$], 
    table.hline(),
    [max], [$gt.eq 0$], [$lt.eq 0$], [Free],
    [min], [$lt.eq 0$], [$gt.eq 0$], [Free],
    table.hline(),
  )
]

- If shifting a constraint does not affect the optimal solution, the shadow price is zero. Shadow prices are zero for contraints that are nonbinding at the optimal solution.

Finding all shadow prices:
- $m$: number of constraints

#eg[
  The solution to the dual program is the shadow price of the primal

  What are the shadow prices?

  $
    min& quad 6&x_1& quad &+& quad 4&x_2& \
    s.t.& quad &x_1& quad &+& quad &x_2& quad &gt.eq quad 2 \ 
    & quad 2&x_1& quad &+& quad &x_2& quad &gt.eq quad 1 \
    &#place($x_1, x_2 gt.eq 0$)
  $

  Solve the dual LP

  $
    &max& quad 2y_1& quad +& quad y_2& \
    &s.t.& quad y_1& quad +& quad 3y_2& quad lt.eq& quad 6& \
    && quad y_1& quad +& quad y_2& quad lt.eq& quad 4& \
    &&#place($y_1, y_2 gt.eq 0$)
  $

  The dual optimal solution is $y^* = (4, 0)$

  So shadow prices are 4 and 0 respectively

  The shadow price is the absolute increate on the objective value given an increate of 1 on the RHS values

  Instead of solving $m$ LPs (one for each constraint increase by 1), we can just solve the dual LP
]