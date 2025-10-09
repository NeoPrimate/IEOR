#import "@preview/cetz:0.3.4"
#import "@preview/cetz-plot:0.1.1"
#import "@preview/numty:0.0.5" as nt

#import "../../../utils/examples.typ": eg
#import "../../../utils/code.typ": code
#import "../../../utils/color_math.typ": colorMath

== Linear Programming Duality

Every linear program (primal) has a *unique* and *symmetric* dual problem. For any primal LP, there is a unique dual, whose dual is the primal.

Solving the dual gives you information about the primal.

1. Weak Duality
2. Strong Duality
3. Complementary Slackness

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
      s.t.  quad  &colorMath(A^T, #green) bold("y") colorMath(lt.eq, #orange) colorMath(bold("c"), #blue) \
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
      s.t. quad &colorMath(a_(1 1), #green) y_1 + a_(2 1) y_2 + a_(3 1) y_3 colorMath(lt.eq, #orange) colorMath(c_1, #blue) \
          &colorMath(a_(1 2), #green) y_1 + a_(2 2) y_2 + a_(3 2) y_3 colorMath(lt.eq, #orange) colorMath(c_2, #blue) \
          &colorMath(a_(1 3), #green) y_1 + a_(2 3) y_2 + a_(3 3) y_3 colorMath(lt.eq, #orange) colorMath(c_3, #blue) \
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
      Primal LP
      $
        min quad 3&x_1 quad +& quad 2x_2& \
        s.t. quad &x_1 quad +& quad 2x_2& quad gt.eq& quad &4 \
                  2&x_1 quad +& quad x_2& quad gt.eq& quad &5 \
                  &#place($x_1 lt.eq 0, quad x_2 "urs"$) \
      $
    ], [
      Dual LP
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
      Primal LP

      $
        max quad  3&x_1 quad +& quad 2x_2& \
        s.t. quad  &x_1 quad +& quad  2x_2& quad lt.eq& quad &4 \
                  2&x_1 quad   +&  quad  x_2& quad lt.eq& quad &5 \
                  &#place($x_1 gt.eq 0, quad x_2 "urs"$) \
      $
    ],
    [
      Dual LP
      
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

$
  b^T y lt.eq c^T x
$

- Dual objective gives a lower bound for a minimization primal
- Dual objective gives an upper bound for a maximization primal

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


=== Strong Duality

If both primal and dual are feasible and at least one has an optimal solution:

$
  c^T x^* = b^T y^*
$

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
    columns: (auto, auto, auto),
    inset: 1em,
    align: center + horizon,
    [*Primal*], [*Dual*], [*Reason*],
    [Feasible & bounded\ Optimal value exists], [Feasible & bounded\ Same optimal value], [Strong Duality],
    [Infeasible], [Infeasible OR Unbounded], [Farkas' Lemma],
    [Unbounded], [Infeasible], [Weak Duality],
  )
]

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

=== Complimentary Slackness

$
  x_i (c_i - (A^T y)_i) = bold(0) quad forall i
$

If:
- $x_i gt 0$: dual constraint is tight (equality holds)
- $x_i = 0$: dual constraint is slack (inequality not binding)
