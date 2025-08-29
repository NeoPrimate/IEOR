#import "@preview/cetz:0.3.4"
#import "@preview/cetz-plot:0.1.1"
#import "@preview/numty:0.0.5" as nt

#import "../../../utils/examples.typ": eg
#import "../../../utils/code.typ": code
#import "../../../utils/color_math.typ": colorMath

== Linear Programming Duality

Uniqueeness & symmetry: For any primal LP, there is a unique dual, whose dual is the primal

- Upper and Lower Bounds

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

Strict inequality occurs because at least one of $x$ or $y$ is not optimal, even though both are feasible

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
          colorMath(z^*, #blue) =    2& quad &gt quad &colorMath(w, #blue)   = 1.4 \
          \ \
          colorMath(x, #green) = (1, 1)& quad &   quad &colorMath(y^*, #green) = (0.4, 0.2) \
          colorMath(z^*, #green) =    2& quad &gt quad &colorMath(w, #green)   = 1.4 \
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
    grid.cell(
      colspan: 2,
      [
        $
          colorMath(x^*, #red) = (1, 2)& quad &   quad &colorMath(y, #red) = (, ) \
          colorMath(z^*, #red) =        3& quad &lt quad &colorMath(w, #red) =  \
          \ \
          colorMath(x, #blue) = (, )& quad &   quad &colorMath(y^*, #blue) = (1/3, 1/3) \
          colorMath(z^*, #blue) =   & quad &lt quad &colorMath(w, #blue)   = 3 \
          \ \
          colorMath(x, #green) = (, )& quad &   quad &colorMath(y^*, #green) = (, ) \
          colorMath(z^*, #green) =    2& quad &lt quad &colorMath(w, #green)   =  \
        $
      ]
    ),
  )
]





- Feasibility-Infeasibility Certificates

=== General Form

#grid(
  columns: (1fr, 1fr),
  align: center + horizon,
  [
    Primal
    $
      &max& quad z = &sum_(j=1)^n colorMath(c_j, #red) x_j \
      &s.t.& quad &sum_(j=1)^n colorMath(a_(i j), #green) x_j lt.eq colorMath(b_i, #blue), quad i = 1, dots, m \
      &&&x_j gt.eq 0, quad j = 1, dots, n
    $
  ],
  [
    Dual 
    $
      &min& quad w = &sum_(i=1)^m u_i colorMath(b_i, #blue) \
      &s.t.& quad &sum_(i=1)^m colorMath(a_(j i), #green) u_i gt.eq colorMath(c_j, #red), quad j = 1, dots, n \
      &&&u_i gt.eq 0, quad i = 1, dots, m
    $
  ],
)




#grid(
  columns: (1fr, 1fr),
  align: center + horizon,
  [
    Primal LP

    $
      colorMath(max, #yellow) quad &colorMath(c_1, #blue) x_1 + colorMath(c_2, #blue) x_2 + colorMath(c_3, #blue) x_3 \
      s.t. quad &colorMath(A_(1 1), #green) x_1 + colorMath(A_(1 2), #green) x_2 + colorMath(A_(1 3), #green) x_3 colorMath(gt.eq, #purple) colorMath(b_1, #red) \
          &A_(2 1) x_1 + A_(2 2) x_2 + A_(2 3) x_3 colorMath(lt.eq, #purple) colorMath(b_2, #red) \
          &A_(3 1) x_1 + A_(3 2) x_2 + A_(3 3) x_3 colorMath(eq, #purple) colorMath(b_3, #red) \
          &x_1 colorMath(gt.eq, #orange) 0, quad x_2 colorMath(lt.eq, #orange), quad x_3 colorMath("urs", #orange) \
    $
  ], [
    Dual LP

    $
      colorMath(min, #yellow) quad &colorMath(b_1, #red) y_1 + colorMath(b_2, #red) y_2 + colorMath(b_3, #red) y_3 \
      s.t. quad &colorMath(A_(1 1), #green) y_1 + A_(2 1) y_2 + A_(3 1) y_3 colorMath(gt.eq, #orange) colorMath(c_1, #blue) \
          &colorMath(A_(1 2), #green) y_1 + A_(2 2) y_2 + A_(3 2) y_3 colorMath(lt.eq, #orange) colorMath(c_2, #blue) \
          &colorMath(A_(1 3), #green) y_1 + A_(2 3) y_2 + A_(3 3) y_3 colorMath(eq, #orange) colorMath(c_3, #blue) \
          &y_1 colorMath(lt.eq, #purple) 0, quad y_2 colorMath(gt.eq, #purple), quad y_3 colorMath("urs", #purple) \
    $
  ],
)

=== Standard Form

#grid(
  columns: (1fr, 1fr),
  align: center + horizon,
  row-gutter: 2em,
  [
    Primal LP

    $
      colorMath(max, #yellow) quad &colorMath(c_1, #blue) x_1 + colorMath(c_2, #blue) x_2 + colorMath(c_3, #blue) x_3 \
      s.t. quad &colorMath(A_(1 1), #green) x_1 + colorMath(A_(1 2), #green) x_2 + colorMath(A_(1 3), #green) x_3 colorMath(eq, #purple) colorMath(b_1, #red) \
          &A_(2 1) x_1 + A_(2 2) x_2 + A_(2 3) x_3 colorMath(eq, #purple) colorMath(b_2, #red) \
          &A_(3 1) x_1 + A_(3 2) x_2 + A_(3 3) x_3 colorMath(eq, #purple) colorMath(b_3, #red) \
          &x_1 colorMath(gt.eq, #orange) 0, quad x_2 colorMath(gt.eq, #orange), quad x_3 colorMath(gt.eq, #orange) 0 \
    $
  ], [
    Dual LP

    $
      colorMath(min, #yellow) quad &colorMath(b_1, #red) y_1 + colorMath(b_2, #red) y_2 + colorMath(b_3, #red) y_3 \
      s.t. quad &colorMath(A_(1 1), #green) y_1 + A_(2 1) y_2 + A_(3 1) y_3 colorMath(gt.eq, #orange) colorMath(c_1, #blue) \
          &colorMath(A_(1 2), #green) y_1 + A_(2 2) y_2 + A_(3 2) y_3 colorMath(gt.eq, #orange) colorMath(c_2, #blue) \
          &colorMath(A_(1 3), #green) y_1 + A_(2 3) y_2 + A_(3 3) y_3 colorMath(gt.eq, #orange) colorMath(c_3, #blue) \
          &y_1, y_2, y_3 colorMath("urs", #purple) \
    $
  ],
  [
    $
      max quad &c^T x \
      s.t. quad &A x eq b \
      &x gt.eq 0 \
    $
  ],
  [
    $
      min quad &y^T b \
      s.t. quad &y^T A gt.eq c^T \
    $
  ]
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
  Minimization

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
        s.t. quad &y_1 quad +& quad 2y_2& quad lt.eq& quad &3 \
                  2&y_1 quad +& quad y_2& quad eq& quad &2 \
                  &#place($y_1 lt.eq 0, quad y_2 lt.eq 0$) \
      $
    ],
    [
      #cetz.canvas({
        import cetz.draw: *
        import cetz-plot: *

        let obj(x, z) = (z - 3*x)/2
        let c1(x) = (4 - x)/2
        let c2(x) = 5 - 2*x

        plot.plot(
          size: (5,5),
          axis-style: "school-book",
          x-tick-step: 1, 
          y-tick-step: 1, 
          x-label: [$x_1$],
          y-label: [$x_2$],
          x-min: 0, x-max: 3,
          y-min: 0, y-max: 3,
          axes: (
            stroke: black,
            tick: (stroke: black),
          ),
        {

          plot.add(
            domain: (0, 3),
            x => obj(x, 8),
            style: (stroke: (thickness: 1pt, paint: black, dash: "dashed")),
            // label: [$4x_1 + x_2 lt.eq 9$],
          )

          plot.add(
            domain: (0, 3),
            c1,
            style: (stroke: (thickness: 1pt, paint: red)),
            // label: [$4x_1 + x_2 lt.eq 9$],
          )

          plot.add(
            domain: (0, 3),
            c2,
            style: (stroke: (thickness: 1pt, paint: green)),
            // label: [$2x_1 - x_2 gt.eq 8$],
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

        let obj(x, w) = (w - 4*x)/5
        let d1(y) = (3 - y)/2
        let d2(y) = 2 - 2*y

        plot.plot(
          size: (5,5),
          axis-style: "school-book",
          x-tick-step: 1, 
          y-tick-step: 1, 
          x-label: [$y_1$],
          y-label: [$y_2$],
          x-min: 0, x-max: 3,
          y-min: 0, y-max: 3,
          axes: (
            stroke: black,
            tick: (stroke: black),
          ),
        {
          plot.add(
            domain: (0, 8),
            x => obj(x, 8),
            style: (stroke: (thickness: 1pt, paint: black, dash: "dashed")),
            // label: [$4x_1 + x_2 lt.eq 9$],
          )

          plot.add(
            domain: (0, 3),
            d1,
            style: (stroke: (thickness: 1pt, paint: red)),
            // label: [$4x_1 + x_2 lt.eq 9$],
          )

          plot.add(
            domain: (0, 3),
            d2,
            style: (stroke: (thickness: 1pt, paint: green)),
            // label: [$2x_1 - x_2 gt.eq 8$],
          )

          plot.add-fill-between(
            domain: (0, 6),
            x => calc.min(d1(x), d2(x)),
            x1 => 0,
            style: (fill: rgb(200, 200, 255, 80), stroke: none),
            label: none
          )

        }, name: "plot")
      })
    ],
    [
      $
        x_1^* = 2 quad quad x_2^* = 1 \
        z^* = 8
      $
    ], 
    [
      $
        y_1^* = 1/3 quad quad y_2^* = 4/3 \
        z^* = 8
      $
    ]
  )
]
  
#eg[
  
  Maximization

  #grid(
    columns: (1fr, 1fr),
    align: center,
    row-gutter: 1em,
    [
      Primal LP

      $
        max quad  3&x_1 quad -& quad 2x_2& \
        s.t. quad  &x_1 quad +& quad  2x_2& quad =& quad &6 \
                  3&x_1 quad   +&  quad  3x_2& quad lt.eq& quad -&4 \
                  &#place($x_1 "urs", quad x_2 gt.eq 0$) \
      $
    ],
    [
      Dual LP
      
      $
        min quad  6&y_1 quad -& quad 4y_2& \
        s.t. quad  &y_1 quad +& quad 3y_2& quad =& quad &3 \
                  2&y_1 quad   +&  quad  3y_2& quad gt.eq& quad -&1 \
                  &#place($y_1 "urs", quad y_2 lt.eq 0$) \
      $
    ],
    [
      
    ],
    [

    ]
  )
]
 

=== Duality Theorems

Standard Form

#grid(
  columns: (1fr, 1fr),
  align: center,
  [
    Primal LP

    $
      max quad &c^T x \
      s.t. quad &A x eq b \
      &x gt.eq 0 \
    $
  ], [
    Dual LP

    $
      min quad &y^T b \
      s.t. quad &y^T A gt.eq c^T \
    $
  ]
)

==== Weak Duality Theorem

$
  c^T x lt.eq b^T y
$

If $x$ and $y$ are primal and dual feasible, then $c^T lt.eq y^T b$

Proof: As long as $x$ and $y$ are primal and dual feasible:

$
  c^T x &lt.eq y^T A x quad &(x gt.eq 0 and y^T A gt.eq c^T) \
        &= y^T (A x) \
        &= y^T b quad &(A x = b) \
$

- If the primal is unbounded, then the dual is infeasible
- If the dual is unbounded, then the primal is infeasible
- If both the primal and dual have optimal solutions, then the optimal value of the primal is less than or equal to the optimal value of the dual

==== Strong Duality Theorem

$
  max c^T x = min b^T y \
  min c^T x = max b^T y \
$


