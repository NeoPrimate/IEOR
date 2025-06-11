#import "@preview/cetz:0.3.4"
#import "@preview/cetz-plot:0.1.1"
#import "@preview/fletcher:0.5.7" as fletcher: diagram, node, edge


#import "../../../utils/examples.typ": eg
#import "../../../utils/code.typ": code
#import "../../../utils/color_math.typ": colorMath

== Non-Linear Programming

=== EOQ

*Parameters*

- $D$: annual demand (units)
- $K$: unit ordering cost (\$)
- $h$: unit holding cost per year (\$)
- $p$: unit purchasing cost (\$)

*Decision Variable*

- $Q$: order quantity per order (units)

*Objective* 

Minimize annual total cost

#align(center)[
  #let D = 8.0
  #let q = 5.0


  #cetz.canvas({
    import cetz.draw: *
    import cetz-plot: *

    plot.plot(
      size: (10,5),
      axis-style: "school-book",
      x-tick-step: none, 
      y-tick-step: none, 
      x-ticks: range(10).map(n => {
        let n = n + 1
        ((n*q)/D, [$(#n q)/D$])
      }),
      y-ticks: ((q, [$Q$]), (q/2, [$Q/2$])),
      x-label: [Time],
      y-label: [Inventory\ Level],
      x-min: 0, x-max: 2,
      y-min: 0, y-max: 5,
    {
      plot.add(
        range(10).map(n => {
          (((n*q)/D, 0), ((n*q)/D,q))
        }).join(),
        style: (stroke: black),
      )

      plot.add-hline(style: (stroke: (dash: "dotted")), q)
      plot.add-hline(style: (stroke: (dash: "dotted")), q/2)
    }
  )
  })
]

- $q/2$: average inventory level

- $h times q / 2 = (h q)/2$: annual holding cost

- $p D$: annual purchasing cost

- $D / q$: number of orders in a year

- $K times D / q = (K D) / q$: annual ordering cost

*Objective Function*

$
  min_(q gt.eq 0) underbrace((K D) / q, "Ordering\nCost") + underbrace(p D, "Purchasing\nCost") + underbrace((h q) / 2, "Inventory\nCost")
$

$p D$ is just a constant, so:

$
  T C(q) = underbrace((K D)/colorMath(q, #red), "Ordering\nCost") + underbrace((h colorMath(q, #red)) / 2, "Inventory\nCost")
$

- As $colorMath(q, #red)$ *increases*:
  - Inventory costs increase 
  - Ordering cost decease
- As $colorMath(q, #red)$ *decreases*:
  - Inventory costs decrease
  - Ordering cost increase

#align(center)[
  #let D = 0.5
  #let K = 1
  #let p = 0.1
  #let h = 0.5

  #let eoq(q) = (K * D) / q + p * D + (h * q) / 2

  #let q = calc.sqrt((2 * K * D) / h)

  #cetz.canvas({
    import cetz.draw: *
    import cetz-plot: *

    plot.plot(
      size: (10,5),
      axis-style: "school-book",
      x-tick-step: none, 
      y-tick-step: none, 
      x-ticks: ((q, [$q^*$]),),
      // y-ticks: ((Q, [$Q$]), (Q/2, [$Q/2$])),
      x-label: [Order\ Quantity],
      y-label: [Total\ Cost],
      x-min: 0, x-max: 5,
      y-min: 0, y-max: 5,
    {
      plot.add(
        eoq,
        domain: (0.01, 5),
        style: (stroke: black),
      )

      plot.add-vline(q)
    }
  )
  })
]

=== Portfolio Optimization

*Objective*

Invest $B$ dollars in $n$ stocks while managing risk and meeting required return

*Notation*

- $B$: budget (\$)
- $R$: required minimum expected return
- For each stock $i in {1, dots, n}$
  - $p_i$: current price
  - $mu_i$: expected future price
  - $sigma^2_i$: variance of ruturn per share
  - $sigma_(i j)$: Covariance between assets $i$ and $j$
  - $x_i$: number of shares to buy (decision variable)

*Model*

$
  min quad &sum^n_(i=1) sigma^2_i x^2_i + 2 sum^n_(i=1) sum^n_(j=i+1) sigma_(i j) x_i x_j quad quad &(&"Total risk")\
  s.t. quad &sum^n_(i=1) p_i x_i lt.eq B quad quad &(&"Budget constraint")\
  &sum^n_(i=1) mu_i x_i gt.eq R quad quad &(&"Return constraint") \
  &x_i gt.eq 0 quad forall i = 1, dots, n quad quad &(&"No short-selling")
$

== Linearizing Maximum/Minimum Functions

1. When the *maximum* function is on the *smaller side* of inequality

*General Form*

$
  y gt.eq max(x_1, x_2) quad quad arrow.l.r.double.long quad quad y gt.eq x_1 and y gt.eq x_2
$

- This rule holds regardless of whether $x_1$, $x_2$, $y$ are variables, constants, or expressions
- You're ensuring that $y$ is greater than or equal to all values in the maximum function, so it must be greater than or equal to each term individually

*Generalized form with more than two elements*

$
  y gt.eq max(x_1, x_2, dots, x_n) quad quad arrow.l.r.double.long quad quad y gt.eq x_i quad forall i = 1, dots, n
$

*Example*

$
  colorMath(y + x_1 + 3, #red) gt.eq max(colorMath(x_1 - x_3, #blue), colorMath(2 x_2 + 4, #green))
  quad arrow.l.r.double.long quad 
  cases(
    colorMath(y + x_1 + 3, #red) gt.eq colorMath(x_1 - x_3, #blue),
    colorMath(y + x_1 + 3, #red) gt.eq colorMath(2x_2 + 4, #green),
  )
  
$

2. When the *minimum* function is on the *larger side* of inequality

*General Form*

$
  y lt.eq min(x_1, x_2) quad quad arrow.l.r.double.long quad quad y lt.eq x_1 and y lt.eq x_2
$

- This rule holds regardless of whether $x_1$, $x_2$, $y$ are *variables*, *constants*, or *expressions*
- You're ensuring that $y$ is smaller than or equal to all values in the minimum function, so it must be smaller than or equal to each term individually

*Generalized form with more than two elements*

$
  y lt.eq min(x_1, x_2, dots, x_n) quad quad arrow.l.r.double.long quad quad y lt.eq x_i quad forall i = 1, dots, n
$

*Example*

$
  colorMath(y + x_1, #red) lt.eq min(colorMath(x_1 - x_3, #blue), colorMath(2x_2 + 4, #green), colorMath(0, #purple)) quad
  arrow.l.r.double.long quad
  cases(
    colorMath(y + x_1, #red) lt.eq colorMath(x_1 - x_3, #blue),
    colorMath(y + x_1, #red) lt.eq colorMath(2x_2 + 4, #green),
    colorMath(y + x_1, #red) lt.eq colorMath(0, #purple)
  )
$

*Cases Where Linearization Does Not Apply*

- $y lt.eq max(x_1, x_2) arrow.l.r.double.not y lt.eq x_1 and y lt.eq x_2$
- $y gt.eq max(x_1, x_2) arrow.l.r.double.not y gt.eq x_1 and y gt.eq x_2$
- Maximum or minimum function in an equality

$
  y = max(x_1, x_2) quad "or" quad y = min(x_1, x_2)
$

== Linearize Objective Function

1. *Minimize* a *Maximum* Function

#align(center)[
  #table(
    stroke: none,
    align: horizon,
    columns: (auto, auto, auto),
    [
      $
        min quad max(colorMath(x_1, #red), colorMath(x_2, #blue))
      $
    ],
    [
      $
        quad arrow.l.r.double.long quad
      $
    ],
    [
      $
        min quad &w \
        s.t. quad &w gt.eq colorMath(x_1, #red) \
        &w gt.eq colorMath(x_2, #blue)
      $     
    ]
  )
]

2. *Maximize* a *Minimum* Function

#align(center)[
  #table(
    stroke: none,
    align: horizon,
    columns: (auto, auto, auto),
    [
      $
        max quad &min(colorMath(x_1, #red), colorMath(x_2, #blue), colorMath(2x_3 + 5, #green)) + colorMath(x_4, #purple) \
        s.t. quad &colorMath(2x_1 + x_2 - x_4 lt.eq x_3, #orange) \
      $
    ],
    [
      $
        quad arrow.l.r.double.long quad
      $
    ],
    [
      $
        max quad &w + colorMath(x_4, #purple) \
        s.t. quad &w lt.eq colorMath(x_1, #red) \
        &w lt.eq colorMath(x_2, #blue) \
        &w lt.eq colorMath(2x_3 + 5, #green) \
        &colorMath(2x_1 + x_2 - x_4 lt.eq x_3, #orange)
      $
    ]
  )
]

*Cases Where Linearization Does Not Apply*

- $max max(x_1, x_2)$
- $min min(x_1, x_2)$

*Absolute Function* 

The absolute value is equivalent to a maximum function:

$
  abs(x) = max(x, -x)
$

Thus, it can be linearized when it appears on the smaller side of an inequality:

$
  abs(x) lt.eq y quad arrow.l.r.double.long quad cases(
    x lt.eq y,
    -x lt.eq y,
  )
$

#eg[
  We want to allocate \$1000 to 2 people in a fair way

  - *Fairness criterion*: Minimize the difference between the amounts each person receives.

  - Let $x_i$ be amount to allocate to person $i$ for $i = 1, 2$

  We write the problem as:

  $
    min quad &abs(x_2 - x_1) \
    s.t. quad &x_1 + x_2 = 1000 \
    &x_i gt.eq 0 quad forall i = 1, 2
  $

  - The absolute value makes the objective *nonlinear*

  #align(center)[

    #cetz.canvas({
      import cetz.draw: *
      import cetz-plot: *

      plot.plot(
        size: (3,3),
        axis-style: "school-book",
        x-tick-step: none, 
        y-tick-step: none, 
        x-label: [$x$],
        y-label: [$abs(x)$],
        x-min: -3, x-max: 3,
        y-min: -3, y-max: 3,
      {
        plot.add(
          calc.abs,
          domain: (-3, 3),
          style: (stroke: black),
        )
      }
    )
    })
  ]

  *Linearizing the Problem*

  We now reformulate the problem to make it linear

  *Step 1.: Introduce a new variable*
  
  Let $w$ be the absolute difference: $w = abs(x_2 - x_1)$

  $
    min quad &colorMath(w, #red) \
    s.t. quad &x_1 + x_2 = 1000 \
    &colorMath(w = abs(x_2 - x_1), #red) \
    &x_i gt.eq 0 quad forall i = 1, 2
  $

  *Step 2. Relax the equality*
  
  We replace the equality with an inequality:

  $
    min quad &w \
    s.t. quad &x_1 + x_2 = 1000 \
    &w colorMath(gt.eq, #red) abs(x_2 - x_1) \
    &x_i gt.eq 0 quad forall i = 1, 2
  $

  #align(center)[
    #cetz.canvas({
      import cetz.draw: *
      import cetz-plot: *

      plot.plot(
        size: (5,5),
        axis-style: "school-book",
        x-label: [$x_1$],
        y-label: [$w$],
        x-tick-step: 100,
        y-tick-step: 100,
        x-min: 300, x-max: 700,
        y-min: 0, y-max: 400,
        name: "plot",
      {
        // The true absolute value curve
        plot.add(
          x => calc.abs(1000 - 2 * x),
          domain: (300, 700),
          style: (stroke: (paint: black, thickness: 1pt)),
        )

        // Feasible region: w ≥ |x2 - x1|
        plot.add-fill-between(
          domain: (300, 700),
          x => calc.abs(1000 - 2 * x),
          x => 400,
          style: (fill: rgb(220,220,255, 120), stroke: none)
        )

        // A sample point: (x1 = 400, w = 250)
        plot.add(
          ((400,350),),
          mark: "o",
          mark-size: 0.2,
          mark-style: (stroke: 0.1pt, color: black, fill: black)
        )
        plot.annotate({
          content((515, 350), [Feasible but\ Not Optimal])
        })

        // // Optimal point: (x1 = 400, w = 200)
        plot.add(
          ((400,200),),
          mark: "o",
          mark-size: 0.2,
          mark-style: (stroke: 0.1pt, color: black, fill: black)
        )
        plot.annotate({
          content((475, 200), [Optimal])
        })

        plot.add-anchor("pt_start", (400,330))
        plot.add-anchor("pt_end", (400,215))
      }
      )
      line("plot.pt_end", ((), "|-", "plot.pt_start"), mark: (start: ">", fill: black))
    })
]

// , style: (stroke: (paint: red, dash: "dotted", thickness: 3pt))

  *Step 3. Replace absolute value with maximum*

  Recall:

  $
    abs(x_2 - x_1) = max(x_2 - x_1, x_1 - x_2)
  $ 

  #align(center)[

    #cetz.canvas({
      import cetz.draw: *
      import cetz-plot: *

      plot.plot(
        size: (3,3),
        axis-style: "school-book",
        x-tick-step: none, 
        y-tick-step: none, 
        x-label: [$x$],
        y-label: [$abs(x)$],
        x-min: -3, x-max: 3,
        y-min: -3, y-max: 3,
      {

        plot.add(
          x => x,
          domain: (-3, 3),
          style: (stroke: black),
        )

        plot.add(
          x => -x,
          domain: (-3, 3),
          style: (stroke: black),
        )

        plot.add(
          calc.abs,
          domain: (-3, 3),
          style: (stroke: (paint: red, dash: "dotted", thickness: 3pt)),
        )

        plot.annotate({
          content((3.3, 3.3), [$x$])
        })
        plot.annotate({
          content((3.3, -3.3), [$-x$])
        })
      }
    )
    })
  ]

  Therefore:  

  $
    w gt.eq abs(x_2 - x_1) quad quad arrow.l.r.double quad quad w gt.eq max(x_2 - x_1, x_1 - x_2) quad quad arrow.l.r.double quad quad w gt.eq x_2 - x_1 and w gt.eq x_1 - x_2
  $

  Now the problem is fully linear:

  $
    min quad &w \
    s.t. quad &x_1 + x_2 = 1000 \
    &colorMath(w gt.eq x_2 - x_1, #red) \
    &colorMath(w gt.eq x_1 - x_2, #red) \
    &x_i gt.eq 0 quad forall i = 1, 2
  $

  *Reformulating in One Variable*

  using $x_2 = 1000 - x_1$, we can express everything in terms of $x_1$:

  $
    min quad &w \
    s.t. quad &w gt.eq 1000 - 2 x_1 \
    &w gt.eq 2 x_1 - 1000 \
    &x_1 gt.eq 0
  $

  #align(center)[

    #cetz.canvas({
      import cetz.draw: *
      import cetz-plot: *

      let f(x) = {
        if x <= 500 {
          1000 - 2*x
        } else {
          2*x - 1000
        }
      }

      plot.plot(
        size: (5,5),
        axis-style: "school-book",
        x-tick-step: none, 
        y-tick-step: none, 
        x-label: [$x_1$],
        y-label: [$w$],
        x-ticks: ((500, 500),),
        x-min: -100, x-max: 1000,
        y-min: -1000, y-max: 1000,
      {

        plot.add(
          x => 1000 - 2 * x,
          domain: (-1000, 1000),
          style: (stroke: black),
        )
        plot.add(
          x => 2 * x - 1000,
          domain: (-1000, 1000),
          style: (stroke: black),
        )
        plot.add-fill-between(
          domain: (0, 1000),
          f,
          x => 100*x,
          style: (fill: rgb(200, 200, 255, 80), stroke: none)
        )
      }
    )
    })
  ]

  We are minimizing $w$, which represents the difference between the two allocations. The solution occurs when the two inequalities intersect — that is, when both are equal:

  $
    1000 - 2 x_1 = 2 x_1 - 1000 quad arrow.double quad x_1 = 500
  $

  So:

  - $x_1 = 500$
  - $x_2 = 1000 - x_1 = 500$
  - $w = abs(500 - 500) = 0$

  This is the fair allocation: each person receives \$500, and the difference between the two amounts is 0.
]

== Linearizing Products of Decision Variables

Products of decision variables can be linearized if:
- A binary and a continuous variable
- Two binary variables

Cannot be linearized if:
- Two continuous variables






