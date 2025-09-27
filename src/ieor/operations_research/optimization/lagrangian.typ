#import "@preview/cetz:0.3.4"
#import "@preview/cetz-plot:0.1.1"
#import "@preview/cetz:0.4.0": canvas, draw, tree
#import "@preview/fletcher:0.5.7" as fletcher: diagram, node, edge


#import "../../../utils/examples.typ": eg
#import "../../../utils/code.typ": code
#import "../../../utils/color_math.typ": colorMath
#import "../../../utils/definition.typ": definition

== Lagrangian 

$
  gradient f = lambda gradient g \
  g = 0
$

Constrained optimization problem:

$
  min&   quad f(x) \
  s.t.&  quad g_i (x) = 0 quad forall i = 1, dots, m \
      &  quad h_j (x) = 0 quad forall j = 1, dots, p \
$

- $x in RR^n$: decision variables
- $f(x)$: objective function
- $g_i (x) = 0$: equality constraints
- $h_i (x) lt.eq 0$: inequality constraints

Lagrangian $cal(L) (x, lambda, mu)$:

$
  cal(L) (x, lambda, mu) 
  =
  underbrace(f(x), "objective function")
  +
  underbrace(sum_(i=1)^m lambda_i g_i (x), "equality constraints")
  +
  underbrace(sum_(j=1)^p mu_j h_j (x), "inequality constraints")
$

- $lambda_i$: Lagrangian multipliers for equality constraints
- $mu_i$: Lagrangian multipliers for inequality constraints

#eg[

]

#eg[
  #cetz.canvas({
      import cetz.draw: *
      import cetz-plot: *

      let y_up(x) = + calc.sqrt(1 - x*x)
      let y_down(x) = - calc.sqrt(1 - x*x)
      let L(x) = x*x + 3*(x - 2)

      plot.plot(
        size: (7,7),
        axis-style: "school-book",
        x-tick-step: 5, 
        y-tick-step: 5, 
        x-label: [$x$],
        y-label: [$y$],
        x-min: -2, x-max: 2,
        y-min: -2, y-max: 2,
        axes: (
          stroke: black,
          tick: (stroke: black),
        ),
      {
        plot.add-anchor("o", (-1, 1))
        plot.add(
            domain: (-1, 1),
            y_up,
            style: (stroke: (thickness: 1pt, paint: black)),
            label: none,
          )

          plot.add(
            domain: (-1, 1),
            y_down,
            style: (stroke: (thickness: 1pt, paint: black)),
            label: none,
          )
        
        plot.add-contour(
          x-domain: (-2, 2), 
          y-domain: (-2, 2),
          style: (fill: rgb("#8383c332"), stroke: (thickness: 1pt, paint: blue)),
          fill: true,
          op: "<",
          z: (5, 4, 3, 2, 1.5, 0.5, 0, -0.5, -1, -1.5, -2, -3),
          (x, y) => x * y + 1
        )
        
      }, name: "plot",
    )
    })

]

