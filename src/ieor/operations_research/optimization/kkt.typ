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

#table(
  columns: 4,
  inset: 1em,
  [*Step*], [*Description*], [*KKT Condition*], [],
  [1. Assume activity\ of constraints], [
    Decide which inequality constraints are active ($g_i(x) = 0$) and which are inactive ($g_i(x) lt 0$). Equivalently, assign tentative signs to $lambda_i$:
      - Active $arrow$ $lambda_i > 0$
      - Inactive $arrow$ $lambda_i = 0$
  ], [Complementary\ Slackness], [],
  [2. Write Stationarity\ equations], [Compute the gradient of the Lagrangian: $nabla_x cal(L) (x, lambda, mu) = 0$], [Stationarity], [],
  [3. Substitute active\ constraints], [Replace active $g_i(x) = 0$ and all $h_j(x) = 0$ into the equations.\ Inactive $g_i(x)$ are ignored (since $lambda_i = 0$).], [Primal Feasibility\ (for active ones)], [],
  [4. Solve for\ $(x, lambda, mu)$], [Solve the resulting system (stationarity + active constraints)], [], [],
  [5. Check Dual\ Feasibility], [Verify that $lambda_i^* gt.eq 0$ for all $i$], [Dual Feasibility], [],
  [6. Check Primal Feasibility\ for inactive constraints], [Verify that the inactive constraints indeed satisfy $g_i (x^*) < 0$], [Primal Feasibility\ (for inactive ones)], [],
  [7. Conclude valid\ KKT point(s)], [If all four KKT conditions hold, record the feasible point. Otherwise discard this case.\ The remaining point(s) are KKT candidates; if the problem is convex, they are optimal.], [], [],
  [], [], [], [],
  [], [], [], [],
)

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
    max quad &f(x) = x_1 - x_2 \
    s.t. quad &g_1 (x) = x_1^2 + x_2^2 lt.eq 4 \
              &g_2 (x) = -x_1^2 - (x_2 + 2)^2 lt.eq -4 \
  $

  This NLP is *nonconvex*

  #align(center)[
    
    #let f(x) = x
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

        plot.add(
          domain: (-5, 5),
          x => f(x) - 0,
          style: (stroke: (dash: "dashed", paint: black, thickness: 1pt)),
        )  

        plot.add-fill-between(
          upper_semicircle_1,
          domain: (center_x1 - r + 0.0001, center_x1 + r - 0.0001),
          x => calc.max(lower_semicircle_1(x), upper_semicircle_2(x)),
          style: (fill: rgb(0, 0, 255, 50), stroke: none)
        )
       
        plot.add-fill-between(
          x => calc.min(upper_semicircle_1(x), lower_semicircle_2(x)),
          domain: (center_x2 - r + 0.0001, center_x2 + r - 0.0001),
          lower_semicircle_2,
          style: (fill: rgb(0, 0, 255, 50), stroke: none)
        )

      }, name: "plot")
    })
  ]

  1️⃣ Lagrangian

  Introduce multipliers $lambda_1, lambda_2 gt.eq 0$ for the inequalities. The Lagrangian is

  $
    cal(L) (x_1, x_2, lambda) = overbrace(x_1 - x_2, f) + lambda_1 overbrace((4 - x_1^2 - x_2^2), g_1) + lambda_2 overbrace((-4 + x_1^2 + (x_2 + 2)^2), g_2)
  $

  The solution $overline(x)$ is a local maximum only if there exists $lambda$ such that

  2️⃣ KKT Conditions

  1. Primal feasibility

  $
    &x_1^2 + x_2^2 lt.eq 4 quad quad &("PF-1") \
    &-x_1^2 - (x_2 + 2)^2 lt.eq -4 quad quad &("PF-2") \
  $

  2. Dual Feasibility

  $
    lambda_1 gt.eq 0 quad quad &("DFS-1")\
    lambda_2 gt.eq 0 quad quad &("DFS-2")
  $

  3. Stationarity

  $
    (diff cal(L)) / (diff x_1) &= 1 - 2(lambda_1 - lambda_2) x_1 = 0 quad quad &("DFF-1") \
    (diff cal(L)) / (diff x_2) &= -1 - 2 (lambda_1 - lambda_2) x_2 + 4 lambda_2 = 0 quad quad &("DFF-2") \
  $

  4. Complimentary Slackness

  $
    &lambda_1 (4 - x_1^2 - x_2^2) = 0 quad quad &("CS-1") \
    &lambda_2 (-4 + x_1^2 + (x_2 + 2)^2) = 0 quad quad &("CS-2") \
  $

  3️⃣ Examine all 4 cases for $(lambda_1, lambda_2)$

  *Case 1.* ($lambda_1 gt 0, lambda_2 gt 0$)

  Step 1: Complementary Slackness


  Since both multipliers are positive, the corresponding constraints must be active:

  $
    x_1^2 + x_2^2 &= 4 quad quad &("CS-1") \
    x_1^2 + (x_2 + 2)^2 &= 4 quad quad &("CS-2") \
  $

  Solve this system $arrow$ two candidate points:

  $
    (x_1, x_2) = (sqrt(3), -1) quad "and" quad (-sqrt(3), -1)
  $

  Step 2: Primal Feasibility

  1. For $(sqrt(3), -1)$

  $
    x_1^2 + x_2^2 &= colorMath(sqrt(3), #red)^2 + (colorMath(-1, #red))^2 lt.eq 4 quad quad &("PF-1")\
    -x_1^2 - (x_2 + 2)^2 &= -(colorMath(sqrt(3), #red))^2 - (colorMath(-1, #red) + 2)^2 lt.eq -4 quad quad &("PF-2") \
  $

  2. For $(-sqrt(3), -1)$
    
  $
    x_1^2 + x_2^2 &= (colorMath(-sqrt(3), #red))^2 + (colorMath(-1, #red))^2 lt.eq 4 quad quad &("PF-1")\
    -x_1^2 - (x_2 + 2)^2 &= -(colorMath(-sqrt(3), #red))^2 - (colorMath(-1, #red) + 2)^2 lt.eq -4 quad quad &("PF-2") \
  $

  ✅ Both satisfy primal feasibility.

  Step 3: Stationarity / First-order conditions (DFF)

  Plug each candidate point into the gradient equations and solve the system:
  
  $
    1 - 2(lambda_1 - lambda_2) colorMath(x_1, #red) &= 0 quad quad &("DFF-1") \
    -1 - 2 (lambda_1 - lambda_2) colorMath(x_2, #red) + 4 lambda_2 &= 0 quad quad &("DFF-2") \
  $
  
  For $(sqrt(3), -1)$:

  $
    1 - 2(lambda_1 - lambda_2) (colorMath(sqrt(3), #red)) &= 0 \
    -1 - 2 (lambda_1 - lambda_2) (colorMath(-1, #red)) + 4 lambda_2 &= 0 \
  $

  Solving the system we get:

  $
    lambda_1 = 1/4 + 1/(4 sqrt(3)) \
    lambda_2 = 1/4 - 1/(4 sqrt(3)) \
  $

  ✅ Both $lambda_1, lambda_2 gt.eq 0$ $arrow$ dual feasibility satisfied.

  For $(-sqrt(3), -1)$:

  $
    1 - 2(lambda_1 - lambda_2) (colorMath(-sqrt(3), #red)) &= 0 arrow.double.long lambda_1 - lambda_2 = - 1 / (2 sqrt(3))  \
    -1 - 2 (lambda_1 - lambda_2) (colorMath(-1, #red)) + 4 lambda_2 &= 0 arrow.double.long lambda_2 = 1 / 4 + 1 / (4 sqrt(3)) \
  $

  Solving the system we get:

  $
    lambda_1 = 1/4 - 1/(4 sqrt(3)) \
    lambda_2 = 1/4 + 1/(4 sqrt(3)) \
  $

  ✅ Both $lambda_1, lambda_2 gt.eq 0$ $arrow$ dual feasibility satisfied.

  #align(center)[
    
    #let f(x) = x
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
        size: (8,8),
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

        plot.add(
          domain: (-5, 5),
          x => f(x) - 0,
          style: (stroke: (dash: "dashed", paint: black, thickness: 1pt)),
        )  

        plot.add-fill-between(
          upper_semicircle_1,
          domain: (center_x1 - r + 0.0001, center_x1 + r - 0.0001),
          x => calc.max(lower_semicircle_1(x), upper_semicircle_2(x)),
          style: (fill: rgb(0, 0, 255, 50), stroke: none)
        )
       
        plot.add-fill-between(
          x => calc.min(upper_semicircle_1(x), lower_semicircle_2(x)),
          domain: (center_x2 - r + 0.0001, center_x2 + r - 0.0001),
          lower_semicircle_2,
          style: (fill: rgb(0, 0, 255, 50), stroke: none)
        )

        plot.add(
          ((calc.sqrt(3), -1),),
          mark: "o",
          mark-size: 0.15,
          mark-style: (fill: black, stroke: 2pt)
        )
        plot.annotate({
          content(
            (calc.sqrt(3), -1),
            [
              #show math.equation: set text(9pt)
              $(sqrt(3), -1)$
            ],
            anchor: "west",
            padding: 0.75
          )
        })

        plot.add(
          ((-calc.sqrt(3), -1),),
          mark: "o",
          mark-size: 0.15,
          mark-style: (fill: black, stroke: 2pt)
        )
        plot.annotate({
          content(
            (-calc.sqrt(3), -1),
            [
              #show math.equation: set text(9pt)
              $(-sqrt(3), -1)$
            ],
            anchor: "east",
            padding: 0.75
          )
        })
      }, name: "plot")
    })
  ]

  ✅ Both $(sqrt(3), -1)$ and $(-sqrt(3), -1)$ satisfy dual feasibility $arrow$ both are KKT points.
  
  *Case 2.* ($lambda_1 gt 0, lambda_2 = 0$)

  Step 1. Assumptions (Activity / Inactivity)

  - Constraint 1: Active ($x_1^2 + x_2^2 = 4$)

  - Constraint 2: Inactive ($x_1^2 + (x_2 + 2)^2 = 4$)
  
  Step 2. Stationarity Condition

  The Lagragian:

  $
    cal(L) (x_1, x_2, lambda_1, lambda_2) = (x_1 - x_2) + lambda_1 (4 - x_1^2 - x_2^2) + lambda_2 (-4 + x_1^2 + (x_2 + 2)^2)
  $

  Compute the gradients with respect to $x_1$ and $x_2$:

  $
    cases(
      (diff cal(L)) / (diff x_1) &= 1 - 2 lambda_1 x_1 + 2 lambda_2 x_1 = 0,
      (diff cal(L)) / (diff x_2) &= -1 - 2 lambda_1 x_2 + 2 lambda_2 (x_2 + 2) = 0,
    )
  $

  Since $lambda_2 = 0$, the equations simplify to:

  $
    cases(
      1 - 2 lambda_1 x_1 = 0,
      - 1 - 2 lambda_1 x_2 = 0,
    )
  $

  Simplify:

  $
    cases(
      x_1 = 1 / (2 lambda_1),
      x_2 = - 1 / (2 lambda_1),
    ) quad arrow.double quad x_1 = - x_2
  $

  Step 3. Substitute into Active Constraint

  Using $x_1^2 + x_2^2 = 4$ and $x_2 = -x_1$:

  $
    x_1^2 + (-x_1)^2 = 2x_1^2 = 4 quad arrow.double quad x_1^2 = 2 quad arrow.double quad x_1 = plus.minus sqrt(2), quad x_2 = minus.plus sqrt(2)
  $

  Two cadidate solutions $x_1$ and $x_2$:

  $
    (-sqrt(2), sqrt(2)) quad "and" quad (sqrt(2), -sqrt(2))
  $

  Step 4. Solve for $lambda_1$ and enforce $lambda_1 gt 0$

  Substitute $(x_1, x_2)$ into the stationarity condition:

  $
    1 + 2 lambda_1 x_1 = 0 quad arrow.double lambda_1 = - 1/(2 x_1)
  $

  $
    1 + 2 lambda_1 -sqrt(2)
  $

  - For $(x_1, x_2) = (sqrt(2), -sqrt(2))$:
  
  $
    lambda_1 = 1 / (2 sqrt(2)) gt 0 arrow #[✅ *Valid* ($lambda_1 gt.eq 0$)]
  $

  - For $(x_1, x_2) = (-sqrt(2), sqrt(2))$:

  $
    lambda_1 = 1 / (2 (-sqrt(2))) gt 0 arrow #[❌ *Reject* (violates $lambda_1 gt.eq 0$)]
  $

  So, the surviving candidate is:

  $
    (x_1, x_2) = (sqrt(2), -sqrt(2)), quad quad lambda_1 = 1 / (2 sqrt(2)), lambda_2 = 0
  $

  Step 5. Check the (inactive) constraint 2 for primal feasibility

  Constraint 2:

  $
    g_2 (x) = - x_1^2 - (x_2 + 2)^2 + 4 lt.eq 0
  $

  Plug $x_1 = sqrt(2)$ and $x_2 = -sqrt(2)$:

  $
    g_2 (x) = - (sqrt(2))^2 - (-sqrt(2) + 2)^2 + 4 gt 0
  $

  ❌ This violates the inequality $g_2 (x) lt.eq 0$

  #align(center)[
    
    #let f(x) = x
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
        size: (8,8),
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

        plot.add(
          domain: (-5, 5),
          x => f(x) - 0,
          style: (stroke: (dash: "dashed", paint: black, thickness: 1pt)),
        )  

        plot.add-fill-between(
          upper_semicircle_1,
          domain: (center_x1 - r + 0.0001, center_x1 + r - 0.0001),
          x => calc.max(lower_semicircle_1(x), upper_semicircle_2(x)),
          style: (fill: rgb(0, 0, 255, 50), stroke: none)
        )
       
        plot.add-fill-between(
          x => calc.min(upper_semicircle_1(x), lower_semicircle_2(x)),
          domain: (center_x2 - r + 0.0001, center_x2 + r - 0.0001),
          lower_semicircle_2,
          style: (fill: rgb(0, 0, 255, 50), stroke: none)
        )

        plot.add(
          ((calc.sqrt(2), -calc.sqrt(2)),),
          mark: "o",
          mark-size: 0.15,
          mark-style: (fill: black, stroke: 2pt)
        )
        plot.annotate({
          content(
            (calc.sqrt(2), -calc.sqrt(2)),
            [
              #show math.equation: set text(9pt)
              $(sqrt(2), -sqrt(2))$
            ],
            anchor: "west",
            padding: 0.75
          )
        })

        plot.add(
          ((-calc.sqrt(2), calc.sqrt(2)),),
          mark: "o",
          mark-size: 0.15,
          mark-style: (fill: black, stroke: 2pt)
        )
        plot.annotate({
          content(
            (-calc.sqrt(2), calc.sqrt(2)),
            [
              #show math.equation: set text(9pt)
              $(-sqrt(2), sqrt(2))$
            ],
            anchor: "east",
            padding: 0.75
          )
        })
      }, name: "plot")
    })
  ]

  ❌ There is therefore no KKT point under this assumption

  *Case 3.* ($lambda_1 = 0, lambda_2 gt 0$)

  CS-2 require 

  $
    x_1^2 + (x_2 + 2)^2 = 4
  $

  and $lambda_1 = 0$ and DFF-1 and DFF-2 require

  $
    1 + 2 lambda_2 x_1 &= 0 \
    -1 + 2 lambda_2 x_2 + 4 lambda_2 &= 0
  $

  Solving the three equations tields a KKT point

  $
    (x_1, x_2) = (-sqrt(2), sqrt(2) - 2) "with" lambda_2 = 1 / (2 sqrt(2))
  $

  Another solution $(x_1, x_2) = (sqrt(2), -sqrt(2) - 2)$ has $lambda_2 = - 1 / (2 sqrt(2))$ violates $lambda_2 gt 0$

  #align(center)[
    
    #let f(x) = x
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
        size: (8,8),
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

        plot.add(
          domain: (-5, 5),
          x => f(x) - 0,
          style: (stroke: (dash: "dashed", paint: black, thickness: 1pt)),
        )  

        plot.add-fill-between(
          upper_semicircle_1,
          domain: (center_x1 - r + 0.0001, center_x1 + r - 0.0001),
          x => calc.max(lower_semicircle_1(x), upper_semicircle_2(x)),
          style: (fill: rgb(0, 0, 255, 50), stroke: none)
        )
       
        plot.add-fill-between(
          x => calc.min(upper_semicircle_1(x), lower_semicircle_2(x)),
          domain: (center_x2 - r + 0.0001, center_x2 + r - 0.0001),
          lower_semicircle_2,
          style: (fill: rgb(0, 0, 255, 50), stroke: none)
        )

        plot.add(
          ((-calc.sqrt(2), calc.sqrt(2)-2),),
          mark: "o",
          mark-size: 0.15,
          mark-style: (fill: black, stroke: 2pt)
        )
        plot.annotate({
          content(
            (-calc.sqrt(2), calc.sqrt(2)-2),
            [
              #show math.equation: set text(9pt)
              $(-sqrt(2), sqrt(2)-2)$
            ],
            anchor: "east",
            padding: 1
          )
        })

        plot.add(
          ((calc.sqrt(2), -calc.sqrt(2)-2),),
          mark: "o",
          mark-size: 0.15,
          mark-style: (fill: black, stroke: 2pt)
        )
        plot.annotate({
          content(
            (calc.sqrt(2), -calc.sqrt(2)-2),
            [
              #show math.equation: set text(9pt)
              $(sqrt(2), -sqrt(2)-2)$
            ],
            anchor: "west",
            padding: 0.75
          )
        })
      }, name: "plot")
    })
  ]

  *Case 4.* ($lambda_1 = 0, lambda_2 = 0$)

  Ad DFF-1 and DFF-2 beome 1 = 0 and -1 = 0
  
  There is no KKT point

]

=== Sensitivity Analysis and Shadow Prices

Lagrange multipliers measure how senitive the objective function is to changes in the constraints

==== Shadow Prices 

The shadow price of a constraint is the value of the corresponding Lagrange multiplier at the optimal solution:

$
  "ShadowPrice"_i = lambda_i^*
$

It measures how much the objective function would improve if the constraint were relaxed by one unit. For example:

$
  x_1 + x_2 lt.eq colorMath(12, #red) quad arrow quad x_1 + x_2 lt.eq colorMath(13, #red)
$

The corresponding shadow price tells us the change in the optimal objective due to this relaxation. The magnitude of the Lagrange multiplier reflects the influence of its associated constraint on the optimal solution.

#align(center)[
  #table(
    columns: 4,
    align: left,
    inset: 1em,
    [], [Constraint Status], [Shadow Price ($lambda^*$)], [Impact on Objective],
    [Binding / Active], [$g_i (x^*) = 0$], [$lambda^* gt 0$], [Relaxing improves objective],
    [Inactive / Slack], [$g_i (x^*) < 0$], [$lambda^* = 0$], [Relaxing has no effect]
  )
]

#eg[
  
]


