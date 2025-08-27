#import "@preview/cetz:0.3.4"
#import "@preview/cetz-plot:0.1.1"
#import "@preview/numty:0.0.5" as nt

#import "../../../utils/examples.typ": eg
#import "../../../utils/code.typ": code
#import "../../../utils/color_math.typ": colorMath

== Linear Programming Duality

Uniqueeness & symmetry: For any primal LP, there is a unique dual, whose dual is the primal

=== General Form

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

#grid(
  columns: (1fr, 1fr),
  align: center + horizon,
  [
    $
      
    $
  ], [
    $
      
    $
  ]
)


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
        s.t. quad y_1 quad +& quad 2y_2& quad lt.eq& quad &3 \
                  2&y_1 quad +& quad y_2& quad lt.eq& quad &2 \
                  &#place($y_1 lt.eq 0, quad y_2 "urs"$) \
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
        x_1^* = 1 quad quad x_2^* = 3/2 \
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
                  &#place($y_1 "urs", quad y_2 gt.eq 0$) \
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
  align: center + horizon,
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


