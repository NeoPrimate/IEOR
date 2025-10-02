#import "@preview/cetz:0.3.4"
#import "@preview/cetz-plot:0.1.1"
#import "@preview/cetz:0.4.0": canvas, draw, tree
#import "@preview/fletcher:0.5.7" as fletcher: diagram, node, edge


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

== Lagrange Relaxation

2 types of points:
- *Interior* point
- *Boundary* point

=== Single Variate

For constrained single variate:
- *Check convexity*: Verify whether the objective function is convex by inspecting the second derivative. Convexity ensures that any stationary point is a global minimum
- *Find unconstrained minimizer*: Solve the first-order condition (FOC), $f'(x) = 0$, to identify the unconstrained optimal solution $x^*$.
- Apply feasibility:
  - If $x^*$ lies within the feasible region, it is the constrained optimum.
  - If $x^*$ is infeasible, the constrained optimum is attained at the feasible boundary point closest to $x^*$ (since convexity guarantees the function grows monotonically away from the minimizer).

#eg[
  
  $
    min_(x gt.eq 0) f(x) = x^2 + 2x - 3
  $

  Derivatives:

  $
    f'(x) = 2x + 2 \
    f''(x) = 2
  $

  Thus, $f$ is convex.

  FOC solution:

  $
    f'(x) = 0 quad arrow.double quad x^* = -1
  $

  This is the unconstrained minimizer, but it violates $x gt.eq 0$:
  - Since $x^* = -1$ lies outside the feasible set, the closest feasible point is the boundary $x = 0$.

  Evaluation:

  $
    f(0) = -3
  $

  #align(center)[
    #cetz.canvas({
      import cetz.draw: *
      import cetz-plot: *

      let f(x) = x*x + 2*x - 3

      let p1 = (-1, 0)
      let p2 = (0, 0)

      let opt_constrained = (0, -3)
      let opt_unconstrained = (-1, -4)

      plot.plot(
        size: (7,7),
        axis-style: "scientific",
        x-tick-step: 2, 
        y-tick-step: 2, 
        x-grid: true,
        y-grid: true,
        x-label: [$$],
        y-label: [$$],
        x-min: -5, x-max: 4,
        y-min: -5, y-max: 4,
        axes: (
          stroke: none,
          tick: (stroke: none),
        ),
      { 
        plot.add(
          domain: (-4, 4),
          f, 
          style: (stroke: red),
        )

        plot.add-hline(0, style: (stroke: (thickness: 1pt, paint: black)))
        plot.add-vline(0, style: (stroke: (thickness: 1pt, paint: black)))

        plot.add-vline(-1, style: (stroke: (thickness: 1pt, paint: black, dash: "dashed")))

        plot.add(
          (p1,),
          mark: "o",
          mark-size: 0.15,
          mark-style: (fill: black, stroke: 2pt)
        )
        plot.annotate({
          content(
            p1,
            text(size:10pt)[$x^*$],
            anchor: "north-east",
            padding: 0.25
          )
        })

        plot.add(
          (p2,),
          mark: "o",
          mark-size: 0.15,
          mark-style: (fill: black, stroke: 2pt)
        )
        plot.annotate({
          content(
            p2,
            text(size:10pt)[closest],
            anchor: "north-west",
            padding: 0.25
          )
        })
        
        plot.add(
          (opt_unconstrained,),
          mark: "o",
          mark-size: 0.15,
          mark-style: (fill: black, stroke: 2pt)
        )

        plot.annotate({
          content(
            opt_unconstrained,
            text(size:10pt)[unconstrained\ optimal],
            anchor: "east",
            padding: 0.5
          )
        })

        plot.add(
          (opt_constrained,),
          mark: "o",
          mark-size: 0.15,
          mark-style: (fill: black, stroke: 2pt)
        )

        plot.annotate({
          content(
            opt_constrained,
            text(size:10pt)[optimal],
            anchor: "west",
            padding: 0.5
          )
        })

        plot.add-fill-between(
          x => 5,
          domain: (0, 4),
          x => -5,
          style: (fill: rgb(0, 0, 255, 10), stroke: none)
        )
        
      }, name: "plot")
    })

  ]

  So the constrained optimum is at $x = 0$ with objective value $-3$.
]

=== Multi Variate


#eg[

  $
    min_(x in RR^2)& quad f(x) = (x_1 - 2)^2 + 4(x_2 - 1)^2 \
    s.t.& quad x_1 + 2x_2 lt.eq 2 \
  $

  For this CP, the FOC solution $x = (2, 1)$ is infeasible
  
  The closest feasible solution is *not* optimal

  #align(center)[
    
    #let z(x1, x2) = calc.pow(x1 - 2, 2) + 4 * calc.pow(x2 - 1, 2)
    #let c(x) = 2 - 2 * x

    #let opt_unconstrained = (2, 1)
    #let opt_constrained = (10/17, 14/17)
    #let closest = (0.8, 0.4)

    #cetz.canvas({
      import cetz.draw: *
      import cetz-plot: *

      plot.plot(
        size: (7,7),
          axis-style: "scientific",
          x-tick-step: 1, 
          y-tick-step: 1, 
          x-grid: true,
          y-grid: true,
          x-label: [$x_1$],
          y-label: [$x_2$],
          x-min: -1, x-max: 4,
          y-min: -1, y-max: 4,
          axes: (
            stroke: none,
            tick: (stroke: none),
          ),
      {

        plot.add-hline(0, style: (stroke: (thickness: 1pt, paint: black)))
        plot.add-vline(0, style: (stroke: (thickness: 1pt, paint: black)))
        
        plot.add-contour(
          x-domain: (-1.1, 4.1), 
          y-domain: (-1.1, 4.1),
          z, 
          z: (1, 2), 
          fill: false,
          x-samples: 100,
          y-samples: 100,
          style: (stroke: (thickness: 1pt, paint: red, dash: none)),
        )

        plot.add(
          domain: (-4, 4),
          c, 
          style: (stroke: black),
        )  

        plot.add(
          (opt_unconstrained,),
          mark: "o",
          mark-size: 0.15,
          mark-style: (fill: black, stroke: 2pt)
        )

        plot.annotate({
          content(
            opt_unconstrained,
            text(size:10pt)[unconstrained\ optimal],
            anchor: "north-west",
            padding: 0.0
          )
        })

        plot.add(
          (closest,),
          mark: "o",
          mark-size: 0.15,
          mark-style: (fill: black, stroke: 2pt)
        )
        plot.annotate({
          content(
            closest,
            text(size:10pt)[closest],
            anchor: "south-east",
            padding: 0.0
          )
        })

        plot.add(
          (opt_constrained,),
          mark: "o",
          mark-size: 0.15,
          mark-style: (fill: black, stroke: 2pt)
        )

        plot.annotate({
          content(
            opt_constrained,
            text(size:10pt)[optimal],
            anchor: "north-east",
            padding: 0.0
          )
        })

        plot.add-fill-between(
          c,
          domain: (-1, 4),
          x => -5,
          style: (fill: rgb(0, 0, 255, 10), stroke: none)
        )

        plot.add(
          (opt_unconstrained, closest),
          style: (stroke: (dash: "dashed", paint: black, thickness: 1pt))
        )
      }, name: "plot")
    })
  ]
]

$
  z^* = max_(x in RR^n)& quad f(x) \
  s.t.& quad g_i(x) lt.eq b_i quad forall i = 1, dots, m
$

Replace *hard* constraints with *soft* constraints

$
  z^L (lambda) = max_(x in RR^n) quad f(x) + sum_(i=1)^m lambda_i [b_i - g_i(x)] \
  lambda_i gt.eq 0
$

Lagrangian

$
  cal(L) (x | lambda) = f(x) + sum_(i=1)^m lambda_i [b_i - g_i(x)] 
$

$lambda_i$ is the Lagrangian multiplier

For a minization problem

$
  z^* = colorMath(min, #red)_(x in RR^n)& quad {f(x) | g_i(x) lt.eq b_i quad forall i = 1, dots, m}
$

$
  z^L (lambda) = max_(x in RR^n) quad f(x) + sum_(i=1)^m lambda_i [b_i - g_i(x)] \
  lambda_i colorMath(lt.eq, #red) 0
$

#eg[
  $
    z^* =  max& quad &x_1   + &x_2 \
          s.t.& quad &x_1^2 + &x_2^2  lt.eq 8 \
              &      &        &x_2    lt.eq 6
  $
  
  #align(center)[
    
    #let f(x) = -x
    #let c1(x1, x2) = calc.pow(x1, 2) + calc.pow(x2, 2)

    #let r = calc.sqrt(8)
    #let center_x = 0
    #let center_y = 0

    #let upper_semicircle(x) = center_y + calc.sqrt(calc.pow(r, 2) - calc.pow(x - center_x, 2))
    #let lower_semicircle(x) = center_y - calc.sqrt(calc.pow(r, 2) - calc.pow(x - center_x, 2))

    #let opt_constrained = (2, 2)

    #let dst = 6

    #let normal_start = (dst/2, dst/2)
    #let normal_end = (normal_start.at(0) + 1, normal_start.at(1)+1)

    #cetz.canvas({
      import cetz.draw: *
      import cetz-plot: *

      plot.plot(
        size: (7,7),
          axis-style: "scientific",
          x-tick-step: 1, 
          y-tick-step: 1, 
          x-grid: true,
          y-grid: true,
          x-label: [$x_1$],
          y-label: [$x_2$],
          x-min: -3, x-max: 7,
          y-min: -3, y-max: 7,
          axes: (
            stroke: none,
            tick: (stroke: none),
          ),
      {
        plot.add-anchor("normal_start", normal_start)
        plot.add-anchor("normal_end", normal_end)

        plot.add-hline(0, style: (stroke: (thickness: 1pt, paint: black)))
        plot.add-vline(0, style: (stroke: (thickness: 1pt, paint: black)))
      
        plot.add-hline(6, style: (stroke: (thickness: 1pt, paint: black)))

        plot.add(
          domain: (center_x - r + 0.0001, center_x + r - 0.0001),
          upper_semicircle,
          style: (stroke: (dash: none, paint: black, thickness: 1pt)),
        )  

        plot.add(
          domain: (center_x - r + 0.0001, center_x + r - 0.0001),
          lower_semicircle,
          style: (stroke: (dash: none, paint: black, thickness: 1pt)),
        )  

        plot.add(
          domain: (-3, 7),
          x => f(x) + dst,
          style: (stroke: (dash: "dashed", paint: black, thickness: 1pt)),
        )  

        plot.add-fill-between(
          upper_semicircle,
          domain: (center_x - r + 0.0001, center_x + r - 0.0001),
          x => 0,
          style: (fill: rgb(0, 0, 255, 10), stroke: none)
        )
        plot.add-fill-between(
          lower_semicircle,
          domain: (center_x - r + 0.0001, center_x + r - 0.0001),
          x => 0,
          style: (fill: rgb(0, 0, 255, 10), stroke: none)
        )

        plot.add(
          (opt_constrained,),
          mark: "o",
          mark-size: 0.15,
          mark-style: (fill: black, stroke: 2pt)
        )
      }, name: "plot")

      cetz.draw.set-style(line: (mark: (end: ">", size: .25)))
      
      cetz.draw.line("plot.normal_start", "plot.normal_end", stroke: black, mark: (fill: black))
      // line(f(0), f(1))  

      // line("p1.south-east", (horizontal: (), vertical: "xline.end"))  
      // line("p1.south-east", (vertical: (), horizontal: "yline.end"))
    })
  ]

  Original NLP

  $
    z^* = max_(x in RR^2) {x_1 + x_2 | x_1^2 + x_2^2 lt.eq 8, x_2 lt.eq 6}
  $

  Given the Lagrangian multipliers $lambda = {lambda_1, lambda_2} gt.eq 0$, the Lagrangian is:

  $
    cal(L) (x | lambda) = underbrace(x_1 + x_2, f) + lambda_1 underbrace((8 - x_1^2 - x_2^2), b_1 - g_1) + lambda_2 underbrace((6 - x_2), b_2 - g_2)
  $

  We may then solve

  $
    z^L (lambda) = max_(x in RR^2) cal(L) (x | lambda)
  $

  given any $lambda gt.eq 0$.

  E.g.:
  - 

]

=== Bounds

Lagrance relaxation provides bounds for the original NLP

*Weak Duality* of Lagrangian Relaxation

$
  z^L (lambda) gt.eq z^* quad forall lambda gt.eq 0
$

Proof

$
  z^* 
  &= max_(x in RR^n) = {f(x) | g_i (x) lt.eq b_i quad forall i = 1, dots, m} \
  &lt.eq max_(x in RR^n) = {f(x) + sum_(i=1)^m lambda_i [b_i - g_i (x)] | g_i (x) lt.eq b_i quad forall i = 1, dots, m} \
  &lt.eq max_(x in RR^n) = {f(x) + sum_(i=1)^m lambda_i [b_i - g_i (x)]} = z^L (lambda) \
$

Given that $x^L (lambda) gt.eq z^*$ for all $lambda gt.eq 0$, the *Lagrange dual program* is defined as:

$
  min_(lambda gt.eq 0) z^L (lambda)
$

The lagrange multipliers are the *dual variables* in NLP
