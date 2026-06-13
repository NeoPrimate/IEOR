#import "/lib/imports.typ": *
#show: formatting



Integer Program

#align(center)[
  #let xs = lq.linspace(-1, 5, num: 200)
  #let lat-x = (0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 2, 2)
  #let lat-y = (0, 1, 2, 3, 4, 5, 0, 1, 2, 3, 0, 1)
  #lq.diagram(
    width: 5cm,
    height: 5cm,
    xlim: (-0.5, 3),
    ylim: (-0.5, 6.5),
    xaxis: (position: 0, tip: tiptoe.triangle, filter: (value, distance) => value != 0, subticks: none, tick-args: (tick-distance: 1)),
    yaxis: (position: 0, tip: tiptoe.triangle, subticks: none, tick-args: (tick-distance: 1)),
    xlabel: [$x_1$],
    ylabel: [$x_2$],
    lq.plot(xs, x => (11 - 4 * x) / 2, mark: none, stroke: black),
    lq.plot(xs, x => -3 * x + 5, mark: none, stroke: (paint: black, dash: "dashed")),
    lq.plot(xs, x => -3 * x + 6, mark: none, stroke: (paint: black, dash: "dashed")),
    lq.plot(xs, x => -3 * x + 7, mark: none, stroke: (paint: black, dash: "dashed")),
    lq.plot(lat-x, lat-y, mark: "o", stroke: none, mark-color: gray),
  )
]

Linear Relaxation:

IP $arrow.long$ LP

Decompose an IP into mutltiple LPs

#definition(
  [Linear Relaxation],
  [For a Given LP, its linear relaxation is the resulting LP after removing all integer constraints],
)

#example[

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

#example[

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
  #let xs = lq.linspace(-1, 5, num: 200)
  #let xs-fill = lq.linspace(0, 6, num: 200)
  #let lat-x = (0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 2, 2)
  #let lat-y = (0, 1, 2, 3, 4, 5, 0, 1, 2, 3, 0, 1)
  #lq.diagram(
    width: 5cm,
    height: 5cm,
    xlim: (0, 3),
    ylim: (0, 6.5),
    xaxis: (position: 0, tip: tiptoe.triangle, filter: (value, distance) => value != 0, subticks: none, tick-args: (tick-distance: 1)),
    yaxis: (position: 0, tip: tiptoe.triangle, subticks: none, tick-args: (tick-distance: 1)),
    xlabel: [$x_1$],
    ylabel: [$x_2$],
    lq.fill-between(xs-fill, xs-fill.map(x => (11 - 4 * x) / 2), y2: xs-fill.map(x => 0), fill: rgb(200, 200, 255, 80), stroke: none),
    lq.plot(xs, x => (11 - 4 * x) / 2, mark: none, stroke: black),
    lq.plot(xs, x => -3 * x + 7, mark: none, stroke: (paint: black, dash: "dashed")),
    lq.plot(lat-x, lat-y, mark: "o", stroke: none, mark-color: gray),
  )
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
  #let xs = lq.linspace(-1, 5, num: 200)
  #let xs-fill = lq.linspace(0, 6, num: 200)
  #let lat-x = (0, 1, 1, 1, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 3, 3)
  #let lat-y = (6, 5, 6, 4, 6, 5, 4, 3, 2, 6, 5, 4, 3, 2, 1, 0)
  #lq.diagram(
    width: 5cm,
    height: 5cm,
    xlim: (0, 3.5),
    ylim: (0, 6.5),
    xaxis: (position: 0, tip: tiptoe.triangle, filter: (value, distance) => value != 0, subticks: none, tick-args: (tick-distance: 1)),
    yaxis: (position: 0, tip: tiptoe.triangle, subticks: none, tick-args: (tick-distance: 1)),
    xlabel: [$x_1$],
    ylabel: [$x_2$],
    lq.fill-between(xs-fill, xs-fill.map(x => (11 - 4 * x) / 2), y2: xs-fill.map(x => 10), fill: rgb(200, 200, 255, 80), stroke: none),
    lq.plot(xs, x => (11 - 4 * x) / 2, mark: none, stroke: black),
    lq.plot(xs, x => -3 * x + 7, mark: none, stroke: (paint: black, dash: "dashed")),
    lq.plot(lat-x, lat-y, mark: "o", stroke: none, mark-color: gray),
  )
]

#linebreak()

#align(
  center,
  table(
    columns: (auto, auto, auto),
    inset: 10pt,
    align: horizon,
    table.header([*Problem Type*], [*Linear Relaxation\ Provides*], [*Inequality Between\ LP and IP*]),
    [Minimization IP], [Lower Bound], [$z' lt.eq z^*$],
    [Maximization IP], [Upper Bound], [$z' gt.eq z^*$],
  ),
)

- If the linear relaxation is infeasible or unbounded then the IP is infeasible or unbounded
- If an optimal solution to the linear relaxation is feasible,

Let $x'$ be an optimal solutions to the linear relaxation of an IP. If $x'$ is feasible to the IP, it is the optimal to the IP

#example[
  $
    & max  & quad z = 3 & x_1                                        & quad & + & quad 4 & x_2 &                   \
    & s.t. &     quad 2 & x_1                                        & quad & + &   quad & x_2 & quad lt.eq quad 6 \
    &      &          2 & x_1                                        & quad & + & quad 3 & x_2 & quad lt.eq quad 9 \
    &      &            & #place($x_i in NN_+ quad forall i = 1, 2$)
  $

  #linebreak()

  $
    & max  & quad z = 3 & x_1                                        & quad & + & quad 4 & x_2 &                   \
    & s.t. &     quad 2 & x_1                                        & quad & + &   quad & x_2 & quad lt.eq quad 6 \
    &      &          2 & x_1                                        & quad & + & quad 3 & x_2 & quad lt.eq quad 9 \
    &      &            & #place($x_i gt.eq 0 quad forall i = 1, 2$)
  $

  #linebreak()

  $
    x_1 = 9/4, quad x_2 = 3/2 \
    z = 12.75
  $

  #let n0 = {
    let xs = lq.linspace(-1, 10, num: 200)
    let xs-fill = lq.linspace(0, 6, num: 200)
    lq.diagram(
      width: 3cm,
      height: 3cm,
      xlim: (0, 3),
      ylim: (0, 3),
      xaxis: (position: 0, tip: tiptoe.triangle, filter: (value, distance) => value != 0, subticks: none, tick-args: (tick-distance: 1)),
      yaxis: (position: 0, tip: tiptoe.triangle, subticks: none, tick-args: (tick-distance: 1)),
      xlabel: [$x_1$],
      ylabel: [$x_2$],
      lq.fill-between(
        xs-fill,
        xs-fill.map(x => if x <= 11 / 5 { (9 - 2 * x) / 3 } else { 6 - 2 * x }),
        y2: xs-fill.map(x => 0),
        fill: rgb(200, 200, 255, 80),
        stroke: none,
      ),
      lq.plot(xs, x => 6 - 2 * x, mark: none, stroke: red),
      lq.plot(xs, x => (9 - 2 * x) / 3, mark: none, stroke: blue),
      lq.plot(xs, x => ((51 / 4) - 3 * x) / 4, mark: none, stroke: (paint: black, dash: "dashed")),
      lq.plot((9 / 4,), (3 / 2,), mark: "o", stroke: none, mark-color: red),
    )
  }

  #let n10 = {
    let xs = lq.linspace(-1, 10, num: 200)
    let xs-fill = lq.linspace(0, 6, num: 200)
    lq.diagram(
      width: 3cm,
      height: 3cm,
      xlim: (0, 3),
      ylim: (0, 3),
      xaxis: (position: 0, tip: tiptoe.triangle, filter: (value, distance) => value != 0, subticks: none, tick-args: (tick-distance: 1)),
      yaxis: (position: 0, tip: tiptoe.triangle, subticks: none, tick-args: (tick-distance: 1)),
      xlabel: [$x_1$],
      ylabel: [$x_2$],
      lq.fill-between(
        xs-fill,
        xs-fill.map(x => if x <= 5 / 2 { 1 } else { 6 - 2 * x }),
        y2: xs-fill.map(x => 0),
        fill: rgb(200, 200, 255, 80),
        stroke: none,
      ),
      lq.plot(xs, x => 6 - 2 * x, mark: none, stroke: red),
      lq.plot(xs, x => (9 - 2 * x) / 3, mark: none, stroke: blue),
      lq.plot(xs, x => (11.5 - 3 * x) / 4, mark: none, stroke: (paint: black, dash: "dashed")),
      lq.plot(xs, x => 1, mark: none, stroke: green),
      lq.plot((5 / 2,), (1,), mark: "o", stroke: none, mark-color: red),
    )
  }

  #let n11 = {
    let xs = lq.linspace(-1, 10, num: 200)
    let xs-fill = lq.linspace(0, 6, num: 200)
    lq.diagram(
      width: 3cm,
      height: 3cm,
      xlim: (0, 3),
      ylim: (0, 3),
      xaxis: (position: 0, tip: tiptoe.triangle, filter: (value, distance) => value != 0, subticks: none, tick-args: (tick-distance: 1)),
      yaxis: (position: 0, tip: tiptoe.triangle, subticks: none, tick-args: (tick-distance: 1)),
      xlabel: [$x_1$],
      ylabel: [$x_2$],
      lq.fill-between(
        xs-fill,
        xs-fill.map(x => if x <= 3 / 2 { (9 - 2 * x) / 3 } else { 2 }),
        y2: xs-fill.map(x => 2),
        fill: rgb(200, 200, 255, 80),
        stroke: none,
      ),
      lq.plot(xs, x => 6 - 2 * x, mark: none, stroke: red),
      lq.plot(xs, x => (9 - 2 * x) / 3, mark: none, stroke: blue),
      lq.plot(xs, x => (12.5 - 3 * x) / 4, mark: none, stroke: (paint: black, dash: "dashed")),
      lq.plot(xs, x => 2, mark: none, stroke: green),
      lq.plot((3 / 2,), (2,), mark: "o", stroke: none, mark-color: red),
    )
  }

  #let n20 = {
    let xs = lq.linspace(-1, 10, num: 200)
    let xs-fill = lq.linspace(0, 6, num: 200)
    lq.diagram(
      width: 3cm,
      height: 3cm,
      xlim: (0, 3),
      ylim: (0, 3),
      xaxis: (position: 0, tip: tiptoe.triangle, filter: (value, distance) => value != 0, subticks: none, tick-args: (tick-distance: 1)),
      yaxis: (position: 0, tip: tiptoe.triangle, subticks: none, tick-args: (tick-distance: 1)),
      xlabel: [$x_1$],
      ylabel: [$x_2$],
      lq.fill-between(
        xs-fill,
        xs-fill.map(x => if x <= 1 { (9 - 2 * x) / 3 } else { 2 }),
        y2: xs-fill.map(x => 2),
        fill: rgb(200, 200, 255, 80),
        stroke: none,
      ),
      lq.plot(xs, x => 6 - 2 * x, mark: none, stroke: red),
      lq.plot(xs, x => (9 - 2 * x) / 3, mark: none, stroke: blue),
      lq.plot(xs, x => (12.5 - 3 * x) / 4, mark: none, stroke: (paint: black, dash: "dashed")),
      lq.vlines(1, stroke: purple),
      lq.plot(xs, x => 2, mark: none, stroke: green),
      lq.plot((1,), (7 / 3,), mark: "o", stroke: none, mark-color: red),
    )
  }

  #let n21 = {
    let xs = lq.linspace(-1, 10, num: 200)
    lq.diagram(
      width: 3cm,
      height: 3cm,
      xlim: (0, 3),
      ylim: (0, 3),
      xaxis: (position: 0, tip: tiptoe.triangle, filter: (value, distance) => value != 0, subticks: none, tick-args: (tick-distance: 1)),
      yaxis: (position: 0, tip: tiptoe.triangle, subticks: none, tick-args: (tick-distance: 1)),
      xlabel: [$x_1$],
      ylabel: [$x_2$],
      lq.plot(xs, x => 6 - 2 * x, mark: none, stroke: red),
      lq.plot(xs, x => (9 - 2 * x) / 3, mark: none, stroke: blue),
      lq.vlines(2, stroke: purple),
      lq.plot(xs, x => 2, mark: none, stroke: green),
    )
  }

  #let n30 = {
    let xs = lq.linspace(-1, 10, num: 200)
    lq.diagram(
      width: 3cm,
      height: 3cm,
      xlim: (0, 3),
      ylim: (0, 3),
      xaxis: (position: 0, tip: tiptoe.triangle, filter: (value, distance) => value != 0, subticks: none, tick-args: (tick-distance: 1)),
      yaxis: (position: 0, tip: tiptoe.triangle, subticks: none, tick-args: (tick-distance: 1)),
      xlabel: [$x_1$],
      ylabel: [$x_2$],
      lq.plot(xs, x => 6 - 2 * x, mark: none, stroke: red),
      lq.plot(xs, x => (9 - 2 * x) / 3, mark: none, stroke: blue),
      lq.plot(xs, x => (11 - 3 * x) / 4, mark: none, stroke: (paint: black, dash: "dashed")),
      lq.vlines(1, stroke: purple),
      lq.plot(xs, x => 2, mark: none, stroke: green),
      lq.plot(xs, x => 2.1, mark: none, stroke: yellow),
      lq.plot((1,), (2,), mark: "o", stroke: none, mark-color: red),
    )
  }

  #let n31 = {
    let xs = lq.linspace(-1, 10, num: 200)
    lq.diagram(
      width: 3cm,
      height: 3cm,
      xlim: (0, 3),
      ylim: (0, 3),
      xaxis: (position: 0, tip: tiptoe.triangle, filter: (value, distance) => value != 0, subticks: none, tick-args: (tick-distance: 1)),
      yaxis: (position: 0, tip: tiptoe.triangle, subticks: none, tick-args: (tick-distance: 1)),
      xlabel: [$x_1$],
      ylabel: [$x_2$],
      lq.plot(xs, x => 6 - 2 * x, mark: none, stroke: red),
      lq.plot(xs, x => (9 - 2 * x) / 3, mark: none, stroke: blue),
      lq.plot(xs, x => (11 - 3 * x) / 4, mark: none, stroke: (paint: black, dash: "dashed")),
      lq.vlines(1, stroke: purple),
      lq.plot(xs, x => 2, mark: none, stroke: green),
      lq.plot(xs, x => 3, mark: none, stroke: yellow),
      lq.plot((1,), (2,), mark: "o", stroke: none, mark-color: red),
    )
  }

  #linebreak()
  #linebreak()
  #linebreak()
  #linebreak()
  #linebreak()
  #linebreak()
  #linebreak()

  #align(center)[
    #frame(fletcher.diagram(
      node-inset: 0pt,

      node(
        pos: (0, 0),
        label: {
          place(
            horizon + right,
            dy: 0mm,
            dx: 3em,
            $
              & x = (9/4, 3/2) \
              & z = 12.75 \
            $,
          )
          n0
        },
        stroke: 0em,
        radius: 6em,
        name: <n0>,
      ),

      node(
        pos: (-0.5, 1),
        label: {
          place(
            horizon + left,
            dy: 0mm,
            dx: -4em,
            $
              & x = (5/2, 1) \
              & z = 11.5 \
            $,
          )
          n10
        },
        stroke: 0em,
        radius: 6em,
        name: <n10>,
      ),

      node(
        pos: (0.5, 1),
        label: {
          place(
            horizon + right,
            dy: 0mm,
            dx: 3em,
            $
              & x = (3/2, 2) \
              & z = 12.5 \
            $,
          )
          n11
        },
        stroke: 0em,
        radius: 6em,
        name: <n11>,
      ),

      node(
        pos: (0, 2),
        label: {
          place(
            horizon + left,
            dy: 0mm,
            dx: -5em,
            $
              & x = (1, 7/3) \
              & z = 12.33 \
            $,
          )
          n20
        },
        stroke: 0em,
        radius: 6em,
        name: <n20>,
      ),

      node(
        pos: (1, 2),
        label: {
          place(horizon + right, dy: 0mm, dx: 2em, [Infeasible])
          n21
        },
        stroke: 0em,
        radius: 6em,
        name: <n21>,
      ),

      node(
        pos: (-0.5, 3),
        label: {
          place(
            horizon + left,
            dy: 0mm,
            dx: -4em,
            $
              & x = (1, 2) \
              & z = 11 \
            $,
          )
          n30
        },
        stroke: 0em,
        radius: 6em,
        name: <n30>,
      ),

      node(
        pos: (0.5, 3),
        label: {
          place(
            horizon + right,
            dy: 0mm,
            dx: 3em,
            $
              & x = (0, 3) \
              & z = 12 \
            $,
          )
          n31
        },
        stroke: 0em,
        radius: 6em,
        name: <n31>,
      ),

      edge(<n0>, <n10>, "-|>", label: $x_2 lt.eq 1$, label-side: center, bend: 0deg, shift: 0pt, label-fill: luma(230)),

      edge(<n0>, <n11>, "-|>", label: $x_2 gt.eq 2$, label-side: center, bend: 0deg, shift: 0pt, label-fill: luma(230)),

      edge(
        <n11>,
        <n20>,
        "-|>",
        label: $x_1 lt.eq 1$,
        label-side: center,
        bend: 0deg,
        shift: 0pt,
        label-fill: luma(230),
      ),

      edge(
        <n11>,
        <n21>,
        "-|>",
        label: $x_1 gt.eq 2$,
        label-side: center,
        bend: 0deg,
        shift: 0pt,
        label-fill: luma(230),
      ),

      edge(
        <n20>,
        <n30>,
        "-|>",
        label: $x_2 lt.eq 2$,
        label-side: center,
        bend: 0deg,
        shift: 0pt,
        label-fill: luma(230),
      ),

      edge(
        <n20>,
        <n31>,
        "-|>",
        label: $x_2 gt.eq 3$,
        label-side: center,
        bend: 0deg,
        shift: 0pt,
        label-fill: luma(230),
      ),
    ))
  ]

]

// #example[
//   $
//     &max& quad 8&x_1& quad &+& quad 5&x_2& \
//     &s.t.& quad &x_1& quad &+& quad &x_2& quad lt.eq quad 6 \
//     && 9&x_1& quad &+& quad 5&x_2& quad lt.eq quad 45 \
//     && &#place($x_1 in ZZ_+ quad forall i = 1, 2$)
//   $

//   - $x^* = (5, 0)$ is IP-optimal
//   - $x^1 = (15/4, 9/4)$ is LR-optimal

//   #align(center)[
//   #canvas({
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
