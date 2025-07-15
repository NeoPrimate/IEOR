#import "@preview/cetz:0.3.4"
#import "@preview/cetz-plot:0.1.1"
#import "@preview/fletcher:0.5.7" as fletcher: diagram, node, edge


#import "../../../utils/examples.typ": eg
#import "../../../utils/code.typ": code
#import "../../../utils/color_math.typ": colorMath
#import "../../../utils/definition.typ": definition

#set math.vec(delim: "[")
#set math.mat(delim: "[")


== Branch-and-Bound

Integer Program


  #align(center)[
      #cetz.canvas({
        import cetz.draw: *
        import cetz-plot: *

        plot.plot(
          size: (5,5),
          axis-style: "school-book",
          x-tick-step: 1, 
          y-tick-step: 1, 
          x-label: [$x_1$],
          y-label: [$x_2$],
          x-min: -0.5, x-max: 3,
          y-min: -0.5, y-max: 6.5,
          axes: (
            stroke: black,
            tick: (stroke: black),
          ),
        {
          plot.add-anchor("V_1", (0,0))

          plot.add(
            domain: (-1, 5),
            x => (11 - 4*x) / 2,
            style: (stroke: (thickness: 1pt, paint: black)),
          )

          plot.add(
            domain: (-1, 10),
            x => -3*x + 5,
            style: (stroke: (thickness: 1pt, paint: black, dash: "dashed")),
          )
          
          plot.add(
            domain: (-1, 10),
            x => -3*x + 6,
            style: (stroke: (thickness: 1pt, paint: black, dash: "dashed")),
          )
          plot.add(
            domain: (-1, 10),
            x => -3*x + 7,
            style: (stroke: (thickness: 1pt, paint: black, dash: "dashed")),
          )

          plot.add(
            ((0, 0),),
            mark: "o",
            mark-size: 0.2,
            mark-style: (fill: gray, stroke: 1pt),
          )
          plot.add(
            ((0, 1),),
            mark: "o",
            mark-size: 0.2,
            mark-style: (fill: gray, stroke: 1pt),
          )
          plot.add(
            ((0, 2),),
            mark: "o",
            mark-size: 0.2,
            mark-style: (fill: gray, stroke: 1pt),
          )
          plot.add(
            ((0, 3),),
            mark: "o",
            mark-size: 0.2,
            mark-style: (fill: gray, stroke: 1pt),
          )
          plot.add(
            ((0, 4),),
            mark: "o",
            mark-size: 0.2,
            mark-style: (fill: gray, stroke: 1pt),
          )
          plot.add(
            ((0, 5),),
            mark: "o",
            mark-size: 0.2,
            mark-style: (fill: gray, stroke: 1pt),
          )
          plot.add(
            ((1, 0),),
            mark: "o",
            mark-size: 0.2,
            mark-style: (fill: gray, stroke: 1pt),
          )
          plot.add(
            ((1, 1),),
            mark: "o",
            mark-size: 0.2,
            mark-style: (fill: gray, stroke: 1pt),
          )
          plot.add(
            ((1, 2),),
            mark: "o",
            mark-size: 0.2,
            mark-style: (fill: gray, stroke: 1pt),
          )
          plot.add(
            ((1, 3),),
            mark: "o",
            mark-size: 0.2,
            mark-style: (fill: gray, stroke: 1pt),
          )
          plot.add(
            ((2, 0),),
            mark: "o",
            mark-size: 0.2,
            mark-style: (fill: gray, stroke: 1pt),
          )
          plot.add(
            ((2, 1),),
            mark: "o",
            mark-size: 0.2,
            mark-style: (fill: gray, stroke: 1pt),
          )
          plot.add(
            ((0, 1),),
            mark: "o",
            mark-size: 0.2,
            mark-style: (fill: gray, stroke: 1pt),
          )
          plot.add(
            ((0, 1),),
            mark: "o",
            mark-size: 0.2,
            mark-style: (fill: gray, stroke: 1pt),
          )

        }, name: "plot")
      })
    ]


Linear Relaxation:

IP $arrow.long$ LP

Decompose an IP into mutltiple LPs

#definition(
  [Linear Relaxation],
  [For a Given LP, its linear relaxation is the resulting LP after removing all integer constraints]
)

#eg[

  Integer Problem:

  $
    &max& quad 3&x_1& quad &+& quad &x_2& \
    &s.t.& quad 4&x_1& quad &+& quad 2&x_2& quad lt.eq quad 11 \
    &&#place($colorMath(x_i in ZZ_+, #red) quad forall i = 1, 2$) \
  $

  Linear Relaxation:

  $
    &max& quad 3&x_1& quad &+& quad &x_2& \
    &s.t.& quad 4&x_1& quad &+& quad 2&x_2& quad lt.eq quad 11 \
    &&#place($colorMath(x_i gt.eq 0, #red) quad forall i = 1, 2$) \
  $

  #linebreak()
]

#eg[

  Integer Program:

  $
    &max& quad 16&x_1& quad &+& quad 22&x_2& quad &+& quad 12&x_3& quad &+& quad 8&x_4& \
    &s.t.& quad 5&x_1& &+& 7&x_2& &+& 4&x_3& &+& 3&x_4& quad lt.eq quad 10 \
    && #place($colorMath(x_i in {0, 1}, #red) quad forall i = 1, dots, 4$)
  $

  Linear Relaxation:
  
  $
    &max& quad 16&x_1& quad &+& quad 22&x_2& quad &+& quad 12&x_3& quad &+& quad 8&x_4& \
    &s.t.& quad 5&x_1& &+& 7&x_2& &+& 4&x_3& &+& 3&x_4& quad lt.eq quad 10 \
    && #place($colorMath(x_i in [0, 1], #red) quad forall i = 1, dots, 4$)
  $

  #linebreak()

  $
    x_i in [0, 1] quad arrow.l.r.double.long quad x_i gt.eq 0 and x_i lt.eq 1
  $
]

Linear relaxation provides a bound

- $z^*$: Optimal value of the Integer Program (IP)
- $z'$: Optimal value of the Linear Relaxation (LP)

1. Minimization

- For *minimization* IP, linear relaxation provides a *lower bound*
- The feasible region of the LP contains all feasible solutions of the IP (i.e., superset)
- Therefore, the LP can achieve a value that is at most as large as the IP
- Conclusion:

$
  z' lt.eq z^*
$

So, linear relaxation provides a lower bound on the optimal value of the integer program

#align(center)[
  #cetz.canvas({
    import cetz.draw: *
    import cetz-plot: *

    plot.plot(
      size: (5,5),
      axis-style: "school-book",
      x-tick-step: 1, 
      y-tick-step: 1, 
      x-label: [$x_1$],
      y-label: [$x_2$],
      x-min: 0, x-max: 3,
      y-min: 0, y-max: 6.5,
      axes: (
        stroke: black,
        tick: (stroke: black),
      ),
    {
      plot.add-anchor("V_1", (0,0))

      plot.add(
        domain: (-1, 5),
        x => (11 - 4*x) / 2,
        style: (stroke: (thickness: 1pt, paint: black)),
      )

      plot.add(
        domain: (-1, 10),
        x => -3*x + 7,
        style: (stroke: (thickness: 1pt, paint: black, dash: "dashed")),
      )

      plot.add(
        ((0, 0),),
        mark: "o",
        mark-size: 0.2,
        mark-style: (fill: gray, stroke: 1pt),
      )
      plot.add(
        ((0, 1),),
        mark: "o",
        mark-size: 0.2,
        mark-style: (fill: gray, stroke: 1pt),
      )
      plot.add(
        ((0, 2),),
        mark: "o",
        mark-size: 0.2,
        mark-style: (fill: gray, stroke: 1pt),
      )
      plot.add(
        ((0, 3),),
        mark: "o",
        mark-size: 0.2,
        mark-style: (fill: gray, stroke: 1pt),
      )
      plot.add(
        ((0, 4),),
        mark: "o",
        mark-size: 0.2,
        mark-style: (fill: gray, stroke: 1pt),
      )
      plot.add(
        ((0, 5),),
        mark: "o",
        mark-size: 0.2,
        mark-style: (fill: gray, stroke: 1pt),
      )
      plot.add(
        ((1, 0),),
        mark: "o",
        mark-size: 0.2,
        mark-style: (fill: gray, stroke: 1pt),
      )
      plot.add(
        ((1, 1),),
        mark: "o",
        mark-size: 0.2,
        mark-style: (fill: gray, stroke: 1pt),
      )
      plot.add(
        ((1, 2),),
        mark: "o",
        mark-size: 0.2,
        mark-style: (fill: gray, stroke: 1pt),
      )
      plot.add(
        ((1, 3),),
        mark: "o",
        mark-size: 0.2,
        mark-style: (fill: gray, stroke: 1pt),
      )
      plot.add(
        ((2, 0),),
        mark: "o",
        mark-size: 0.2,
        mark-style: (fill: gray, stroke: 1pt),
      )
      plot.add(
        ((2, 1),),
        mark: "o",
        mark-size: 0.2,
        mark-style: (fill: gray, stroke: 1pt),
      )
      plot.add(
        ((0, 1),),
        mark: "o",
        mark-size: 0.2,
        mark-style: (fill: gray, stroke: 1pt),
      )
      plot.add(
        ((0, 1),),
        mark: "o",
        mark-size: 0.2,
        mark-style: (fill: gray, stroke: 1pt),
      )

      plot.add-fill-between(
          domain: (0, 6),
          x => (11 - 4*x) / 2,
          x1 => 0,
          style: (fill: rgb(200, 200, 255, 80), stroke: none),
          label: none
        )

    }, name: "plot")
  })
]

2. Maximization

- For *maximization* IP, linear relaxation provides a *upper bound*
- The LP may find a solution with an objective value greater than or equal to that of any feasible integer solution.
- Conclusion:

$
  z' gt.eq z^*
$

- So, linear relaxation provides an upper bound on the optimal value of the integer program

#align(center)[
  #cetz.canvas({
    import cetz.draw: *
    import cetz-plot: *

    plot.plot(
      size: (5,5),
      axis-style: "school-book",
      x-tick-step: 1, 
      y-tick-step: 1, 
      x-label: [$x_1$],
      y-label: [$x_2$],
      x-min: 0, x-max: 3.5,
      y-min: 0, y-max: 6.5,
      axes: (
        stroke: black,
        tick: (stroke: black),
      ),
    {
      plot.add-anchor("V_1", (0,0))

      plot.add(
        domain: (-1, 5),
        x => (11 - 4*x) / 2,
        style: (stroke: (thickness: 1pt, paint: black)),
      )

      plot.add(
        domain: (-1, 10),
        x => -3*x + 7,
        style: (stroke: (thickness: 1pt, paint: black, dash: "dashed")),
      )

      plot.add(
        ((0, 6),),
        mark: "o",
        mark-size: 0.2,
        mark-style: (fill: gray, stroke: 1pt),
      )
      plot.add(
        ((1, 5),),
        mark: "o",
        mark-size: 0.2,
        mark-style: (fill: gray, stroke: 1pt),
      )
      plot.add(
        ((1, 6),),
        mark: "o",
        mark-size: 0.2,
        mark-style: (fill: gray, stroke: 1pt),
      )
      plot.add(
        ((1, 4),),
        mark: "o",
        mark-size: 0.2,
        mark-style: (fill: gray, stroke: 1pt),
      )
      plot.add(
        ((2, 6),),
        mark: "o",
        mark-size: 0.2,
        mark-style: (fill: gray, stroke: 1pt),
      )
      plot.add(
        ((2, 5),),
        mark: "o",
        mark-size: 0.2,
        mark-style: (fill: gray, stroke: 1pt),
      )
      plot.add(
        ((2, 4),),
        mark: "o",
        mark-size: 0.2,
        mark-style: (fill: gray, stroke: 1pt),
      )
      plot.add(
        ((2, 3),),
        mark: "o",
        mark-size: 0.2,
        mark-style: (fill: gray, stroke: 1pt),
      )
      plot.add(
        ((2, 2),),
        mark: "o",
        mark-size: 0.2,
        mark-style: (fill: gray, stroke: 1pt),
      )
      plot.add(
        ((3, 6),),
        mark: "o",
        mark-size: 0.2,
        mark-style: (fill: gray, stroke: 1pt),
      )
      plot.add(
        ((3, 5),),
        mark: "o",
        mark-size: 0.2,
        mark-style: (fill: gray, stroke: 1pt),
      )
      plot.add(
        ((3, 4),),
        mark: "o",
        mark-size: 0.2,
        mark-style: (fill: gray, stroke: 1pt),
      )
      plot.add(
        ((3, 3),),
        mark: "o",
        mark-size: 0.2,
        mark-style: (fill: gray, stroke: 1pt),
      )
      plot.add(
        ((3, 2),),
        mark: "o",
        mark-size: 0.2,
        mark-style: (fill: gray, stroke: 1pt),
      )
      plot.add(
        ((3, 1),),
        mark: "o",
        mark-size: 0.2,
        mark-style: (fill: gray, stroke: 1pt),
      )
      plot.add(
        ((3, 0),),
        mark: "o",
        mark-size: 0.2,
        mark-style: (fill: gray, stroke: 1pt),
      )

      plot.add-fill-between(
          domain: (0, 6),
          x => (11 - 4*x) / 2,
          x1 => 10,
          style: (fill: rgb(200, 200, 255, 80), stroke: none),
          label: none
        )

    }, name: "plot")
  })
]

#linebreak()

#align(
  center,
  table(
    columns: (auto, auto, auto),
    inset: 10pt,
    align: horizon,
    table.header(
      [*Problem Type*], [*Linear Relaxation\ Provides*], [*Inequality Between\ LP and IP*],
    ),
    [Minimization IP], [Lower Bound], [$z' lt.eq z^*$],
    [Maximization IP], [Upper Bound], [$z' gt.eq z^*$],
  )
)

- If the linear relaxation is infeasible or unbounded then the IP is infeasible or unbounded
- If an optimal solution to the linear relaxation is feasible, 

Let $x'$ be an optimal solutions to the linear relaxation of an IP. If $x'$ is feasible to the IP, it is the optimal to the IP

#eg[
  $
    &max& quad z = 3&x_1& quad &+& quad 4&x_2& \
    &s.t.& quad 2&x_1& quad &+& quad &x_2& quad lt.eq quad 6 \
    && 2&x_1& quad &+& quad 3&x_2& quad lt.eq quad 9 \
    && &#place($x_i in NN_+ quad forall i = 1, 2$)
  $

  #linebreak()

  #align(center)[
    #cetz.canvas({
      import cetz.draw: *
      import cetz-plot: *

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
        plot.add-anchor("V_1", (0,0))

        plot.add(
          domain: (-1, 10),
          x => 6 - 2*x,
          style: (stroke: (thickness: 1pt, paint: red)),
          label: $2x_1 + x_2 lt.eq 6$
        )

        plot.add(
          domain: (-1, 5),
          x => (9 - 2*x) / 3,
          style: (stroke: (thickness: 1pt, paint: blue)),
          label: $2x_1 + 3x_2 lt.eq 9$
        )

        plot.add(
          domain: (-1, 10),
          x => ((51 / 4) -3 * x) / 4,
          style: (stroke: (thickness: 1pt, paint: black, dash: "dashed")),
          label: $z = 3x_1 + 4x_2$
        )

        plot.add-fill-between(
          domain: (0, 6),
          x => {
            if x <= 11/5 {
              (9 - 2*x) / 3
            } else {
              6 - 2*x
            }
          },
          x1 => 0,
          style: (fill: rgb(200, 200, 255, 80), stroke: none),
          label: none
        )

        plot.add(
          ((9/4, 3/2),),
          mark: "o",
          mark-size: 0.2,
          mark-style: (fill: red, stroke: 1pt),
        )

      }, name: "plot")
    })
  ]

  $
    &max& quad z = 3&x_1& quad &+& quad 4&x_2& \
    &s.t.& quad 2&x_1& quad &+& quad &x_2& quad lt.eq quad 6 \
    && 2&x_1& quad &+& quad 3&x_2& quad lt.eq quad 9 \
    && &#place($x_i gt.eq 0 quad forall i = 1, 2$)
  $

  #linebreak()

  $

    x_1 = 9/4, quad x_2 = 3/2 \

    z = 12.75
  $

  #align(center)[
    #cetz.canvas({
      import cetz.draw: *
      import cetz-plot: *

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
        plot.add-anchor("V_1", (0,0))

        plot.add(
          domain: (-1, 10),
          x => 6 - 2*x,
          style: (stroke: (thickness: 1pt, paint: red)),
          // label: $2x_1 + x_2 lt.eq 6$
        )

        plot.add(
          domain: (-1, 5),
          x => (9 - 2*x) / 3,
          style: (stroke: (thickness: 1pt, paint: blue)),
          // label: $2x_1 + 3x_2 lt.eq 9$
        )

        // plot.add(
        //   domain: (-1, 10),
        //   x => ((51 / 4) -3 * x) / 4,
        //   style: (stroke: (thickness: 1pt, paint: black, dash: "dashed")),
        // )

        plot.add(
          domain: (-1, 5),
          x => 1,
          style: (stroke: (thickness: 1pt, paint: green)),
          // label: $x_2 lt.eq 1$
        )

        plot.add-fill-between(
          domain: (0, 6),
          x => {
            if x <= 5/2 {
              1
            } else {
              6 - 2*x
            }
          },
          x1 => 0,
          style: (fill: rgb(200, 200, 255, 80), stroke: none),
          label: none
        )

        plot.add(
          ((5/2, 1),),
          mark: "o",
          mark-size: 0.2,
          mark-style: (fill: red, stroke: 1pt),
        )
        

      }, name: "plot")
    })
  ]

  #align(center)[
    #cetz.canvas({
      import cetz.draw: *
      import cetz-plot: *

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
        plot.add-anchor("V_1", (0,0))

        plot.add(
          domain: (-1, 10),
          x => 6 - 2*x,
          style: (stroke: (thickness: 1pt, paint: red)),
          // label: $2x_1 + x_2 lt.eq 6$
        )

        plot.add(
          domain: (-1, 5),
          x => (9 - 2*x) / 3,
          style: (stroke: (thickness: 1pt, paint: blue)),
          // label: $2x_1 + 3x_2 lt.eq 9$
        )

        // plot.add(
        //   domain: (-1, 10),
        //   x => ((51 / 4) -3 * x) / 4,
        //   style: (stroke: (thickness: 1pt, paint: black, dash: "dashed")),
        // )

        plot.add(
          domain: (-1, 5),
          x => 2,
          style: (stroke: (thickness: 1pt, paint: green)),
          // label: $x_2 gt.eq 2$
        )

        plot.add-fill-between(
          domain: (0, 6),
          x => {
            if x <= 3/2 {
              (9 - 2*x) / 3
            } else {
              2
            }
          },
          x1 => 2,
          style: (fill: rgb(200, 200, 255, 80), stroke: none),
          label: none
        )

        plot.add(
          ((3/2, 2),),
          mark: "o",
          mark-size: 0.2,
          mark-style: (fill: red, stroke: 1pt),
        )

      }, name: "plot")
    })
  ]

  #align(center)[
    #cetz.canvas({
      import cetz.draw: *
      import cetz-plot: *

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
        plot.add-anchor("V_1", (0,0))

        plot.add(
          domain: (-1, 10),
          x => 6 - 2*x,
          style: (stroke: (thickness: 1pt, paint: red)),
          // label: $2x_1 + x_2 lt.eq 6$
        )

        plot.add(
          domain: (-1, 5),
          x => (9 - 2*x) / 3,
          style: (stroke: (thickness: 1pt, paint: blue)),
          // label: $2x_1 + 3x_2 lt.eq 9$
        )

        // plot.add(
        //   domain: (-1, 10),
        //   x => ((51 / 4) -3 * x) / 4,
        //   style: (stroke: (thickness: 1pt, paint: black, dash: "dashed")),
        // )

        plot.add-vline(
          1,
          style: (stroke: (thickness: 1pt, paint: purple)),
        ) 
        

        plot.add(
          domain: (-1, 5),
          x => 2,
          style: (stroke: (thickness: 1pt, paint: green)),
          // label: $x_2 gt.eq 2$
        )

        plot.add-fill-between(
          domain: (0, 6),
          x => {
            if x <= 1 {
              (9 - 2*x) / 3
            } else {
              2
            }
          },
          x1 => 2,
          style: (fill: rgb(200, 200, 255, 80), stroke: none),
          label: none
        )

        plot.add(
          ((1, 7/3),),
          mark: "o",
          mark-size: 0.2,
          mark-style: (fill: red, stroke: 1pt),
        )

      }, name: "plot")
    })
  ]

  

  #align(center)[
    #cetz.canvas({
      import cetz.draw: *
      import cetz-plot: *

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
        plot.add-anchor("V_1", (0,0))

        plot.add(
          domain: (-1, 10),
          x => 6 - 2*x,
          style: (stroke: (thickness: 1pt, paint: red)),
          // label: $2x_1 + x_2 lt.eq 6$
        )

        plot.add(
          domain: (-1, 5),
          x => (9 - 2*x) / 3,
          style: (stroke: (thickness: 1pt, paint: blue)),
          // label: $2x_1 + 3x_2 lt.eq 9$
        )

        plot.add(
          domain: (-1, 10),
          x => ((51 / 4) -3 * x) / 4,
          style: (stroke: (thickness: 1pt, paint: black, dash: "dashed")),
        )

        plot.add-vline(
          2,
          style: (stroke: (thickness: 1pt, paint: purple)),
        ) 
        

        plot.add(
          domain: (-1, 5),
          x => 2,
          style: (stroke: (thickness: 1pt, paint: green)),
        )

      }, name: "plot")
    })
  ]

  #import "@preview/cetz:0.4.0": canvas, draw, tree

#let n0 = cetz.canvas({
      import cetz.draw: *
      import cetz-plot: *

      plot.plot(
        size: (2,2),
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
        plot.add-anchor("V_1", (0,0))

        plot.add(
          domain: (-1, 10),
          x => 6 - 2*x,
          style: (stroke: (thickness: 1pt, paint: red)),
        )

        plot.add(
          domain: (-1, 5),
          x => (9 - 2*x) / 3,
          style: (stroke: (thickness: 1pt, paint: blue)),
        )

        plot.add(
          domain: (-1, 10),
          x => ((51 / 4) -3 * x) / 4,
          style: (stroke: (thickness: 1pt, paint: black, dash: "dashed")),
        )

        plot.add-fill-between(
          domain: (0, 6),
          x => {
            if x <= 11/5 {
              (9 - 2*x) / 3
            } else {
              6 - 2*x
            }
          },
          x1 => 0,
          style: (fill: rgb(200, 200, 255, 80), stroke: none),
          label: none
        )

        plot.add(
          ((9/4, 3/2),),
          mark: "o",
          mark-size: 0.2,
          mark-style: (fill: red, stroke: 1pt),
        )

      }, name: "plot")
    })

  #let n10 = cetz.canvas({
      import cetz.draw: *
      import cetz-plot: *

      plot.plot(
        size: (2,2),
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
        plot.add-anchor("V_1", (0,0))

        plot.add(
          domain: (-1, 10),
          x => 6 - 2*x,
          style: (stroke: (thickness: 1pt, paint: red)),
        )

        plot.add(
          domain: (-1, 5),
          x => (9 - 2*x) / 3,
          style: (stroke: (thickness: 1pt, paint: blue)),
        )

        plot.add(
          domain: (-1, 10),
          x => ((11.5) -3 * x) / 4,
          style: (stroke: (thickness: 1pt, paint: black, dash: "dashed")),
        )

        plot.add(
          domain: (-1, 5),
          x => 1,
          style: (stroke: (thickness: 1pt, paint: green)),
        )

        plot.add-fill-between(
          domain: (0, 6),
          x => {
            if x <= 5/2 {
              1
            } else {
              6 - 2*x
            }
          },
          x1 => 0,
          style: (fill: rgb(200, 200, 255, 80), stroke: none),
          label: none
        )

        plot.add(
          ((5/2, 1),),
          mark: "o",
          mark-size: 0.2,
          mark-style: (fill: red, stroke: 1pt),
        )
      }, name: "plot")
    })

  #let n11 = cetz.canvas({
      import cetz.draw: *
      import cetz-plot: *

      plot.plot(
        size: (2,2),
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
        plot.add-anchor("V_1", (0,0))

        plot.add(
          domain: (-1, 10),
          x => 6 - 2*x,
          style: (stroke: (thickness: 1pt, paint: red)),
        )

        plot.add(
          domain: (-1, 5),
          x => (9 - 2*x) / 3,
          style: (stroke: (thickness: 1pt, paint: blue)),
        )

        plot.add(
          domain: (-1, 10),
          x => (12.5 -3 * x) / 4,
          style: (stroke: (thickness: 1pt, paint: black, dash: "dashed")),
        )

        plot.add(
          domain: (-1, 5),
          x => 2,
          style: (stroke: (thickness: 1pt, paint: green)),
        )

        plot.add-fill-between(
          domain: (0, 6),
          x => {
            if x <= 3/2 {
              (9 - 2*x) / 3
            } else {
              2
            }
          },
          x1 => 2,
          style: (fill: rgb(200, 200, 255, 80), stroke: none),
          label: none
        )

        plot.add(
          ((3/2, 2),),
          mark: "o",
          mark-size: 0.2,
          mark-style: (fill: red, stroke: 1pt),
        )

      }, name: "plot")
    })

#let n20 = cetz.canvas({
      import cetz.draw: *
      import cetz-plot: *

      plot.plot(
        size: (2,2),
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
        plot.add-anchor("V_1", (0,0))

        plot.add(
          domain: (-1, 10),
          x => 6 - 2*x,
          style: (stroke: (thickness: 1pt, paint: red)),
          // label: $2x_1 + x_2 lt.eq 6$
        )

        plot.add(
          domain: (-1, 5),
          x => (9 - 2*x) / 3,
          style: (stroke: (thickness: 1pt, paint: blue)),
          // label: $2x_1 + 3x_2 lt.eq 9$
        )

        plot.add(
          domain: (-1, 10),
          x => (12.5 -3 * x) / 4,
          style: (stroke: (thickness: 1pt, paint: black, dash: "dashed")),
        )

        plot.add-vline(
          1,
          style: (stroke: (thickness: 1pt, paint: purple)),
        ) 
        

        plot.add(
          domain: (-1, 5),
          x => 2,
          style: (stroke: (thickness: 1pt, paint: green)),
          // label: $x_2 gt.eq 2$
        )

        plot.add-fill-between(
          domain: (0, 6),
          x => {
            if x <= 1 {
              (9 - 2*x) / 3
            } else {
              2
            }
          },
          x1 => 2,
          style: (fill: rgb(200, 200, 255, 80), stroke: none),
          label: none
        )

        plot.add(
          ((1, 7/3),),
          mark: "o",
          mark-size: 0.2,
          mark-style: (fill: red, stroke: 1pt),
        )

      }, name: "plot")
    })

#let n21 = cetz.canvas({
      import cetz.draw: *
      import cetz-plot: *

      plot.plot(
        size: (2,2),
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
        plot.add-anchor("V_1", (0,0))

        plot.add(
          domain: (-1, 10),
          x => 6 - 2*x,
          style: (stroke: (thickness: 1pt, paint: red)),
        )

        plot.add(
          domain: (-1, 5),
          x => (9 - 2*x) / 3,
          style: (stroke: (thickness: 1pt, paint: blue)),
        )

        plot.add-vline(
          2,
          style: (stroke: (thickness: 1pt, paint: purple)),
        ) 
        

        plot.add(
          domain: (-1, 5),
          x => 2,
          style: (stroke: (thickness: 1pt, paint: green)),
        )

      }, name: "plot")
    })

#linebreak()
#linebreak()
#linebreak()
#linebreak()
#linebreak()
#linebreak()
#linebreak()

#align(center)[
  #diagram(
      node-inset: 0pt,

      node(pos: (0,0), label: {
        place(horizon+right, dy: 0mm, dx: 3em, 
          $
            &x = (9/4, 3/2) \
            &z = 12.75 \
          $
        )
        n0
      }, stroke: 0em, radius: 6em, name: <n0>),
      
      node(pos: (-0.5,1), label: {
        place(horizon+left, dy: 0mm, dx: -4em,
          $
            &x = (5/2, 1) \
            &z = 11.5 \
          $
        )
        n10
      }, stroke: 0em, radius: 6em, name: <n10>),

      node(pos: (0.5,1), label: {
        place(horizon+right, dy: 0mm, dx: 3em,
          $
            &x = (3/2, 2) \
            &z = 12.5 \
          $
        )
        n11
      }, stroke: 0em, radius: 6em, name: <n11>),
      
      node(pos: (0,2), label: {
        place(horizon+left, dy: 0mm, dx: -5em,
          $
            &x = (3/2, 2) \
            &z = 12.5 \
          $
        )
        n20
      }, stroke: 0em, radius: 6em, name: <n20>),
      
      node(pos: (1,2), label: {
        place(horizon+right, dy: 0mm, dx: 2em,
          [Infeasible]
        )
        n21
      }, stroke: 0em, radius: 6em, name: <n21>),
      
      // node(pos: (2,0), label: {
      //   place(top+center, dy: 0mm, dx: 7mm, $80$)
      //   $4$
      // }, stroke: 0.1em, radius: 1em, name: <4>),
      
      // node(pos: (1,1.5), label: {
      //   place(bottom+center, dy: 4mm, $-300$)
      //   $7$
      // }, stroke: 0.1em, radius: 1em, name: <7>),
      
      // node(pos: (1.5,-1.5), label: {
      //   place(top+center, dy: -7mm, $-200$)
      //   $1$
      // }, stroke: 0.1em, radius: 1em, name: <1>),
      
      // node(pos: (0,-1.5), label: {
      //   place(top+center, dy: -4mm, $100$)
      //   $2$
      // }, stroke: 0.1em, radius: 1em, name: <2>),
      
      edge(<n0>, <n10>, "-|>", label: $x_2 lt.eq 1$, label-side: center, bend: 0deg, shift: 0pt, label-fill: luma(230)),
      
      edge(<n0>, <n11>, "-|>", label: $x_2 gt.eq 2$, label-side: center, bend: 0deg, shift: 0pt, label-fill: luma(230)),
      
      edge(<n11>, <n20>, "-|>", label: $x_1 lt.eq 1$, label-side: center, bend: 0deg, shift: 0pt, label-fill: luma(230)),
      
      edge(<n11>, <n21>, "-|>", label: $x_1 gt.eq 2$, label-side: center, bend: 0deg, shift: 0pt, label-fill: luma(230)),
      
    )
]


  



]





// #eg[
//   $
//     &max& quad 8&x_1& quad &+& quad 5&x_2& \
//     &s.t.& quad &x_1& quad &+& quad &x_2& quad lt.eq quad 6 \
//     && 9&x_1& quad &+& quad 5&x_2& quad lt.eq quad 45 \
//     && &#place($x_1 in ZZ_+ quad forall i = 1, 2$)
//   $

//   - $x^* = (5, 0)$ is IP-optimal
//   - $x^1 = (15/4, 9/4)$ is LR-optimal

//   #align(center)[
//   #cetz.canvas({
//     import cetz.draw: *
//     import cetz-plot: *

//     plot.plot(
//       size: (5,5),
//       axis-style: "school-book",
//       x-tick-step: 1, 
//       y-tick-step: 1, 
//       x-label: [$x_1$],
//       y-label: [$x_2$],
//       x-min: 0, x-max: 3.5,
//       y-min: 0, y-max: 6.5,
//       axes: (
//         stroke: black,
//         tick: (stroke: black),
//       ),
//     {
//       plot.add-anchor("V_1", (0,0))

//       plot.add(
//         domain: (-1, 5),
//         x => 6 - x,
//         style: (stroke: (thickness: 1pt, paint: black)),
//       )

//       plot.add(
//         domain: (-1, 10),
//         x => -3*x + 7,
//         style: (stroke: (thickness: 1pt, paint: black, dash: "dashed")),
//       )

//       plot.add(
//         ((0, 6),),
//         mark: "o",
//         mark-size: 0.2,
//         mark-style: (fill: gray, stroke: 1pt),
//       )

//       plot.add-fill-between(
//           domain: (0, 6),
//           x => (11 - 4*x) / 2,
//           x1 => 0,
//           style: (fill: rgb(200, 200, 255, 80), stroke: none),
//           label: none
//         )

//     }, name: "plot")
//   })
// ]

// ]