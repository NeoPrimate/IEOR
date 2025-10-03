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


== KKT Conditions

Conditions that a solution must satisfy in order to be optimal for a nonlinear optimization problem

Conditions are necessary for optimality, and sufficient if:
- $f$ is convex
- $g_i$ are convex
- $h_j$ linear

=== Setup

$
  min_(x in RR^n) quad &f(x) \
  s.t. quad &g_i (x) lt.eq 0 quad forall i = 1, dots, m \
  &h_j (x) = 0 quad forall j = 1, dots, p
$

- $f(x)$: objective function
- $g_i (x)$: inequality constraints
- $h_j (x)$: equality constraints

=== KKT Multipliers

We introduce:
- $lambda_i gt.eq 0$: for each inequality constraint (Lagrange multipliers)
- $mu_i in RR$: for each equality constraint

#align(center)[
  #table(
    columns: 4,
    align: left,
    inset: 1em,
    [], [Inequalities\ $g(x) lt.eq 0$], [Inequalities\ $g(x) gt.eq 0$], [Equalities],
    [Min], [$lambda gt.eq 0$], [$lambda lt.eq 0$], [$mu in RR$ (free)],
    [Max], [$lambda lt.eq 0$], [$lambda gt.eq 0$], [$mu in RR$ (free)],
  )
]

The Lagrangian is:

$
  cal(L) (x, lambda, mu) = f(x) + sum_(i = 1)^m lambda_i g_i (x) + sum_(j=1)^p mu_j h_j (x)
$

=== KKT Conditions

At local optimum $x^*$ there exists multipliers ($lambda^*, mu^*$) such that:

1. *Stationarity*

$
  gradient f (x^*) + sum_(i = 1)^m lambda_i^* gradient g_i (x^*) + sum_(j=1)^p mu_j^* gradient h_j (x^*) = 0
$

Stationarity is like a generalized version of "set the derivative to zero", but accounting for the constraints

2. *Primal feasibility*

$
  g_i (x^*) lt.eq 0, quad h_j (x^*) = 0
$

The solution must satisfy all the original constraints — it must lie inside the feasible region

3. *Dual Feasibility*

$
  lambda_i^* gt.eq 0 quad forall i
$

4. *Complementary Slackness*

$
  lambda_i^* g_i (x^*) = 0 quad forall i
$

Complementary slackness only applies to inequalities

Either the inequality constraint is: 
- Inactive: $g_i (x^*) lt 0 quad arrow.double quad lambda_i^* = 0 quad arrow quad$ The constraint doesn't affect the optimum
- Binding: $g_i (x^*) = 0 quad arrow.double quad lambda_i^* gt.eq 0 quad arrow quad$ The multiplier measures how much the objective would improve if the constraint were relaxed (shadow price)

=== Calculating Lagrangian Multipliers

To find the multipliers ($lambda^*, mu^*$) and the optimal point $x^*$, solve the KKT system of equations:

$
  cases(
    gradient_x cal(L) (x\, lambda\, mu) = 0,
    g_i (x) lt.eq 0 quad quad quad quad &forall i = 1\, dots\, m,
    h_j (x) = 0 quad quad quad quad &forall i = 1\, dots\, p,
    lambda_i gt.eq 0 quad quad quad quad &forall i = 1\, dots\, m,
    lambda_i g_i (x) = 0 quad quad quad quad &forall i = 1\, dots\, m,
  )
$

#eg[

  Retailer Maximizing Profit under a Capacity Constraint


  A retailer sells product 1 and 2 with quantities $q_1$ and $q_2$. For product $i$ the market-clearing prices are:

  $
    p_i = a_i - b_i q_i quad i = 1, 2
  $

  Where $a_i, b_i gt 0$.

  The retailer maximizes *total profit* subject to a *capacity constraint*:

  $
    q_1 + q_2 lt.eq K quad q_1, q_2 gt.eq 0
  $

  1. Formulation

  $
    max_(q_1, q_2 gt.eq 0)& quad q_1 overbrace((a_1 - b_1 q_1), p_1) + q_2 overbrace((a_2 - b_2 q_2), p_2) \
    s.t.& quad q_1 + q_2 lt.eq K \
  $

  The objective is concave because 
  
  $
    - gradient^2 f(q_1, q_2) = mat(
      2b_1, 0;
      0, 2b_2;
    )
  $

  is positive semi-definite.

  The unconstrained FOC solution is:

  $
    q_1 = a_1 / (2b_1), quad q_2 = a_2 / (2b_2)
  $

  If $q_1 + q_2 lt.eq K$, this solution is feasible.

  #align(center)[

    #let (a1, b1) = (10, 1)
    #let (a2, b2) = (8, 0.5)
    #let K = 12

    #let opt_unconstrained = (a1 / (2*b1), a2 / (2*b2))
    
    #let z(q1, q2) = q1 * (a1 - b1 * q1) + q2 * (a2 - b2 * q2)
    #let c(x) = K - x

    #cetz.canvas({
      import cetz.draw: *
      import cetz-plot: *

      plot.plot(
        size: (7,7),
          axis-style: "scientific",
          x-tick-step: 2, 
          y-tick-step: 2, 
          x-grid: true,
          y-grid: true,
          x-label: [$q_1$],
          y-label: [$q_2$],
          x-min: 0, x-max: K,
          y-min: 0, y-max: K,
          axes: (
            stroke: none,
            tick: (stroke: none),
          ),
      {

        plot.add-hline(0, style: (stroke: (thickness: 1pt, paint: black)))
        plot.add-vline(0, style: (stroke: (thickness: 1pt, paint: black)))
        
        plot.add-contour(
          x-domain: (0, K), 
          y-domain: (0, K),
          z, 
          z: (55, 50, 40, 30, 20, 10), 
          fill: false,
          x-samples: 100,
          y-samples: 100,
          style: (stroke: (thickness: 1pt, paint: red, dash: none)),
        )

        plot.add(
          domain: (0, K),
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
            anchor: "west",
            padding: 1
          )
        })

        plot.add-fill-between(
          c,
          domain: (0, K),
          x => 0,
          style: (fill: rgb(0, 0, 255, 10), stroke: none)
        )
      }, name: "plot")
    })
  ]

  2. Lagrangian

  Introduce KKT multiplier $lambda gt.eq 0$ for the inequality constraint:

  $
    cal(L) (q_1, q_2, lambda) = overbrace(q_1 (a_1 - b_1 q_1) + q_2 (a_2 - b_2 q_2), f) + lambda overbrace((K - q_1 - q_2), b - g)
  $

  

  3. KKT Conditions

  #h(1em) 1. Stationarity

  $
    diff / (diff q_1) cal(L) = a_1 - 2 b_1 q_1 - lambda = 0 \
    diff / (diff q_2) cal(L) = a_2 - 2 b_2 q_2 - lambda = 0 \
  $

  #h(1em) 2. Primal Feasibility

  $
    q_1 + q_2 lt.eq K quad q_1, q_2 gt.eq 0
  $

  #h(1em) 3. Dual Feasibility

  $
    lambda gt.eq 0
  $

  #h(1em) 4. Complementary Slackness

  $
    lambda (K - q_1 - q_2) = 0
  $

  4. Solving KKT system

  Case 1: Unconstrained ($lambda = 0$)

  $
    max_(q_1, q_2 gt.eq 0) quad &f(q_1, q_2) = q_1 (a_1 - b_1 q_1) + q_2 (a_2 - b_2 q_2) \

    &f(q_1, q_2) = a_1 q_1 - b_1 q_1^2 + a_2 q_2 - b_2 q_2^2
  $

  First-Order Condition

  $
    (diff f) / (diff q_1) = a_1 - 2b_1 q_1 \
    (diff f) / (diff q_2) = a_2 - 2b_2 q_2 \
  $

  Set derivatives to 0 (stationarity)

  $
    a_1 - 2b_1 q_1 = 0 quad arrow.double quad q_1^* = a_1 / (2b_1) \
    a_2 - 2b_2 q_2 = 0 quad arrow.double quad q_2^* = a_2 / (2b_2) \
  $
  
  Unconstrained Solution: 
  
  $
    q_1^* = a_1 / (2b_1) \ 
    q_2^* = a_2 / (2b_2)
  $

  The second derivative check confirms it's a maximum because:

  $
    (diff^2 f) / (diff q_1^2) = -2b_1 lt 0 \
    (diff^2 f) / (diff q_2^2) = -2b_2 lt 0 \
  $

  Feasible if 
  
  $
    a_1 / (2b_1) + a_2 / (2b_2) lt.eq K
  $
  
  Case 2: Binding Constraint ($lambda gt 0$)

  We now include the capacity constraint:

  $
    q_1 + q_2 = K
  $

  If it binds (active) then

  $
    q_1 + q_2 = K
  $

  Lagrangian

  $
    cal(L) (q_1, q_2, lambda) = overbrace(q_1 (a_1 - b_1 q_1) + q_2 (a_2 - b_2 q_2), f(q_1, q_2)) + lambda overbrace((K - q_1 - q_2), b - g(q_1, q_2))
  $

  First-Order Condition

  $
    (diff cal(L)) / (diff q_1) &= a_1 - 2 b_1 q_1 - lambda \
    (diff cal(L)) / (diff q_2) &= a_2 - 2 b_2 q_2 - lambda \
    (diff cal(L)) / (diff lambda) &= K - q_1 - q_2 \
  $


  Set derivatives to 0 (stationarity)

  $
    a_1 - 2 b_1 q_1 - lambda = 0 \
    a_2 - 2 b_2 q_2 - lambda = 0 \
    K - q_1 - q_2 = 0 \
  $

  When we take the derivative of the Lagrangian with respect to the multiplier $lambda$ we recover the constraint itself.

  Solve system of equations

  $
    cases(
      a_1 - 2 b_1 q_1 - lambda = 0,
      a_2 - 2 b_2 q_2 - lambda = 0,
      q_1 + q_2 = K,
    )
  $

  Solution:

  $
    q_1 = (2b_2 K + a_1 - a_2) / (2(b_1 + b_2)) quad quad q_2 = (2b_1 K + a_2 - a_1) / (2(b_1 + b_2))
  $

  Feasible if 
  
  $
    a_1 / (2b_1) + a_2 / (2b_2) gt K
  $

  5. Optimal Solution

  $
    (q_1^*, q_2^*) = cases(
      (a_1 / (2b_1), a_2 / (2b_2)) quad quad &"if" a_1/(2b_1) + a_2 / (2b_2) lt.eq K,
      ((2b_2 K + a_1 - a_2) / (2(b_1 + b_2)), (2b_1 K + a_2 - a_1) / (2(b_1 + b_2))) quad quad &"otherwise",
    )
  $

  Intuition: 
  - If capacity $K$ is large enough, the retailer produces unconstrained quantities.
  - If $K$ is tight, the total production hits the limit, and the optimal quantities are shared according to the relative parameters $a_i, b_i$

]

#eg[
  $
    max quad &x_1 - x_2 \
    s.t. quad &x_1^2 + x_2^2 lt.eq 4 \
              &-x_1^2 - (x_2 + 2)^2 lt.eq -4 \
  $

  This NLP is *nonconvex*

  #align(center)[
    
    #let f(x) = -x
    #let c1(x1, x2) = calc.pow(x1, 2) + calc.pow(x2, 2)

    #let r = calc.sqrt(4)
    #let center_x1 = 0
    #let center_y1 = 0
    
    #let center_x2 = -0
    #let center_y2 = -2

    #let upper_semicircle_1(x) = center_y1 + calc.sqrt(calc.pow(r, 2) - calc.pow(x - center_x1, 2))
    #let lower_semicircle_1(x) = center_y1 - calc.sqrt(calc.pow(r, 2) - calc.pow(x - center_x1, 2))

    #let upper_semicircle_2(x) = center_y2 + calc.sqrt(calc.pow(r, 2) - calc.pow(x - center_x2, 2))
    #let lower_semicircle_2(x) = center_y2 - calc.sqrt(calc.pow(r, 2) - calc.pow(x - center_x2, 2))

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
          x-min: -5, x-max: 5,
          y-min: -5, y-max: 5,
          axes: (
            stroke: none,
            tick: (stroke: none),
          ),
      {
        plot.add-anchor("normal_start", normal_start)
        plot.add-anchor("normal_end", normal_end)

        plot.add-hline(0, style: (stroke: (thickness: 1pt, paint: black)))
        plot.add-vline(0, style: (stroke: (thickness: 1pt, paint: black)))

        plot.add(
          domain: (center_x1 - r + 0.0001, center_x1 + r - 0.0001),
          upper_semicircle_1,
          style: (stroke: (dash: none, paint: black, thickness: 1pt)),
        )  
        plot.add(
          domain: (center_x1 - r + 0.0001, center_x1 + r - 0.0001),
          lower_semicircle_1,
          style: (stroke: (dash: none, paint: black, thickness: 1pt)),
        )  
        
        plot.add(
          domain: (center_x2 - r + 0.0001, center_x2 + r - 0.0001),
          upper_semicircle_2,
          style: (stroke: (dash: none, paint: black, thickness: 1pt)),
        )  
        plot.add(
          domain: (center_x2 - r + 0.0001, center_x2 + r - 0.0001),
          lower_semicircle_2,
          style: (stroke: (dash: none, paint: black, thickness: 1pt)),
        )  

        // plot.add(
        //   domain: (-3, 7),
        //   x => f(x) + dst,
        //   style: (stroke: (dash: "dashed", paint: black, thickness: 1pt)),
        // )  

        plot.add-fill-between(
          upper_semicircle_1,
          domain: (center_x1 - r + 0.0001, center_x1 + r - 0.0001),
          x => 0,
          style: (fill: rgb(0, 0, 255, 50), stroke: none)
        )
       
        plot.add-fill-between(
          upper_semicircle_2,
          domain: (center_x2 - r + 0.0001, center_x2 + r - 0.0001),
          x => 0,
          style: (fill: rgb(0, 0, 255, 50), stroke: none)
        )

        plot.add(
          ((1.7, -1),),
          mark: "o",
          mark-size: 0.15,
          mark-style: (fill: black, stroke: 2pt)
        )
      }, name: "plot")

      // cetz.draw.set-style(line: (mark: (end: ">", size: .25)))
      
      // cetz.draw.line("plot.normal_start", "plot.normal_end", stroke: black, mark: (fill: black))
      // line(f(0), f(1))  

      // line("p1.south-east", (horizontal: (), vertical: "xline.end"))  
      // line("p1.south-east", (vertical: (), horizontal: "yline.end"))
    })
  ]



]

Sensitivity Analysis and Shadow Prices

Lagrange multipliers measure how senitive the objective function is tochanges in the constraints

Shadow price is the Lagrange multiplier at the optimal solution

It tells you how much the objective function would improve if you relaxed that constraint by one unit:

$
  x_1 + x_2 lt.eq colorMath(12, #red) quad arrow quad x_1 + x_2 lt.eq colorMath(13, #red)
$

A higher shadow price means that the constraint is more binding, and relaxing it will yield a greater improvement in the objective. Conversely, a lower shadow price means that relaxing that constraint will have a smaller impact on the objective

The larger Lagrange multiplier means that the constraint it's associated with has a stronger influence on the optimal solution. So, if you're looking to improve or adjust the overall process, it's definitely more impactful to focus on the constraint that has the higher multiplier.

#eg[
  
]


