#import "@preview/cetz:0.3.4"
#import "@preview/cetz-plot:0.1.1"
#import "@preview/fletcher:0.5.7" as fletcher: diagram, node, edge


#import "../../../utils/examples.typ": eg
#import "../../../utils/code.typ": code
#import "../../../utils/color_math.typ": colorMath

#set math.vec(delim: "[")
#set math.mat(delim: "[")

== Mathematical Programs

=== Formulation

#linebreak()

$min quad quad &f(x_1, x_2, dots, x_n) & quad quad  &(colorMath("objective function", #blue))\

s.t. quad quad &g_i (x_1, x_2, dots, x_n) lt.eq b_i quad quad &forall i in 1, dots, m quad quad &(colorMath("constraints", #blue))\

&x_j in RR quad &forall j in 1, dots, n quad quad &(colorMath("decision variables", #blue))\
$

- $m$: Number of constraints
- $n$: Number of variables
- $x_1, x_2, dots, x_n$: decision variables
- $f: RR^n arrow RR$
- $g_i: RR^n arrow RR$

$
  min& quad sum^n_(j=1) c_j x_j \
  s.t.& quad sum^n_(j=1) A_(i j) x_j lt.eq b_i quad forall i = 1, dots, m
$
- $A_(i j)$: constraint coefficients
- $b_i$: right-hand-side values (RHS)
- $c_j$: objective coefficients

*Vector*

$
  min& quad c^T x \
  s.t.& quad a_i^T x lt.eq b_i quad forall i = 1, dots, m
$
- $a_i in RR^n$
- $b_i in RR$
- $c in RR^n$
- $x in RR^n$

*Matrix*

$
  min& quad c^T x \
  s.t.& quad A x lt.eq b
$

- $A in R^(m times n)$
- $b in RR^m$


$
  A = mat(
    a_(1 1), a_(1 2), dots, a_(1 n);
    a_(2 1), a_(2 2), dots, a_(2 n);
    dots.v, dots.v, dots.down, dots.v;
    a_(m 1), a_(m 2), dots, a_(m n);
  )
$

$
  x = vec(x_1, x_2, dots.v, x_n)
  quad
  c = vec(c_1, c_2, dots.v, c_n)
  quad
  b = vec(b_1, b_2, dots.v, b_n)
$

$
  A x = mat(
    a_(1 1), a_(1 2), dots, a_(1 n);
    a_(2 1), a_(2 2), dots, a_(2 n);
    dots.v, dots.v, dots.down, dots.v;
    a_(m 1), a_(m 2), dots, a_(m n);
  ) 
  vec(x_1, x_2, dots.v, x_n) 
  = mat(
    a_(1 1) x_1, a_(1 2) x_2, dots, a_(1 n) x_n;
    a_(2 1) x_1, a_(2 2) x_2, dots, a_(2 n) x_n;
    dots.v, dots.v, dots.down, dots.v;
    a_(m 1) x_1, a_(m 2) x_2, dots, a_(m n) x_n;
  ) 
  lt.eq
  vec(b_1, b_2, dots.v, b_n)
$

$
  c^T x = [c_1, c_2, dots, c_n] vec(x_1, x_2, dots.v, x_n) = sum^n_(j=1) c_j x_j
$

=== Transformation

#linebreak()
- *Min and Max*

$
  max f(x) arrow.l.r.double min - f(x)
$

- *$eq$ and $gt.eq$*

$
  g_i (x) gt.eq b_i arrow.l.r.double - g_i (x) lt.eq - b_i
$

$
  g_i (x) eq b_i arrow.l.r.double g_i (x) gt.eq b_i and g_i (x) lt.eq b_i
$

- *E.g.,*

#align(center)[
  #table(
    columns: (auto, auto, auto),
    inset: 10pt,
    align: horizon,
    stroke: none,
    [
      $
        &max&  quad     x_1&     quad  -&   quad  x_2& \
        &s.t.& quad   -2x_1&   quad  +&   quad  x_2&  quad &gt.eq&  quad &-3& \
        & &             x_1&    quad  +&   quad  4x_2&  quad &eq& quad &5& \
      $
    ],
    [
      $
        \
        arrow.l.r.double
        \
      $
    ],
    [
      $
        &min&   quad quad    -x_1&  quad +& quad x_2& \
        &s.t.&  quad quad    2x_1&  quad -& quad  x_2&   quad  &lt.eq&  quad 3& \
        & &                   x_1&  quad +& quad 4x_2&   quad  &lt.eq&  quad 5& \
        & &                  -x_1&  quad +& quad 4x_2&   quad  &lt.eq&  quad -5& \
      $
    ]
  )
]

=== Constraints

#linebreak()

- *Sign Constraints*

$
  x_i gt.eq 0 "or" x_i lt.eq 0
$

- *Functional Constraints*

$
  sum_(i=1)^n c_i x_i lt.eq b_i
$

=== Feasable Solutions

- Feasable solution: Satisfies all constants
- Infeasable solution: violates at least one constraint

#align(center)[
  #cetz.canvas({
    import cetz.draw: *
    import cetz-plot: *

    plot.plot(
      size: (5,5),
      axis-style: "school-book",
      x-tick-step: 10, 
      y-tick-step: 10, 
      x-label: [$x_1$],
      y-label: [$x_2$],
      x-min: 0, x-max: 50,
      y-min: 0, y-max: 50,
      axes: (
        stroke: black,
        tick: (stroke: black),
      ),
    {
      plot.add(
        domain: (0, 50),
        x1 => 100 - 2 * x1,
        style: (stroke: 1pt, fill: black),
        label: [$2x_1 + x_2 lt.eq 100$],
      )
      plot.add-fill-between(
        domain: (0, 50),
        x1 => 100 - 2 * x1,
        x1 => 0,
        style: (fill: rgb(200, 200, 255, 80), stroke: black),
      )
      plot.annotate({
        content((15, 40), [Feasable])
      })
      plot.annotate({
        content((45, 40), [Infeasable])
      })
    }
  )
  })
]


=== Feasable Region and Optimal Solution

- Feasable Region: Set of feasable solutions

- Optimal Solution: Attains largest (maximization) or smallest (minimization) objective value


=== Binding Constraint

Let $g(dot) lt.eq b$ be an inequality constraint and $bar(x)$ be a solution. $g(dot) lt.eq b$ is binding at $bar(x)$ if $g(bar(x)) = b$

#eg[
  $
    2x_1& + x_2 lt.eq 100 quad quad "is" bold("binding (active)") "at the point" quad quad &(x_1, x_2) = (30, 40) \
    2x_1& + x_2 lt.eq 100 quad quad "is" bold("non-binding (inactive)") "at the point" quad quad &(x_1, x_2) = (20, 20) \
  $

  #align(center)[
  #cetz.canvas({
    import cetz.draw: *
    import cetz-plot: *

    plot.plot(
      size: (5,5),
      axis-style: "school-book",
      x-tick-step: 10, 
      y-tick-step: 10, 
      x-label: [$x_1$],
      y-label: [$x_2$],
      x-min: 0, x-max: 50,
      y-min: 0, y-max: 50,
    {
      plot.add(
        domain: (0, 50),
        x1 => 100 - 2 * x1,
        style: (stroke: 1pt, fill: black),
        // label: [$2x_1 + x_2 lt.eq 100$],
      )
      plot.annotate({
        content((40, 50), [$x_1 + 2x_2 lt.eq 80$])
      })

      // Constraint 1: 2x₁ + x₂ ≤ 100
      plot.add-fill-between(
        domain: (0, 50),
        x1 => 100 - 2 * x1,
        x1 => 0,
        style: (fill: rgb(200, 200, 255, 80), stroke: black),
        // label: [Feasable Region]
      )

      plot.add(
        ((30.0, 40.0),),
        mark: "o",
        mark-size: 0.3,
        style: (fill: none, stroke: none),
        mark-style: (fill: rgb(255, 200, 200), stroke: rgb(255, 0, 0)),
        // label: [Binding Constraint]
      )
      plot.annotate({
        content((40, 40), [Binding])
      })

      plot.add(
        ((20.0, 20.0),),
        mark: "o",
        mark-size: 0.3,
        style: (fill: none, stroke: none),
        mark-style: (fill: rgb(200, 200, 255), stroke: rgb(0, 0, 255)),
        // label: [Non-Binding Constraint]
      )
      plot.annotate({
        content((20, 15), [Non-Binding])
      })
    }
  )
  })
]
]

=== Strict and Weak Inequalities

- Strict: The two sides *cannot be equal* (e.g., $x_1 + x_2 gt 5$)

- Weak: The two sides *can be equal* (e.g., $x_1 + x_2 gt.eq 5$)

=== Graphical Approach

#eg[

  $
      max& quad 40 &x_1& quad +& quad 30 &x_2& \
     s.t.& quad  2 &x_1& quad +& quad    &x_2& quad lt.eq& quad &100 \
         &         &x_1& quad +& quad  2 &x_2& quad lt.eq& quad &80 \
  $

  #let f2(x) = {
    if x <= 40 {
      (80 - x)/2
    } else {
      100 - 2 * x
    }
  }

  #align(center)[
    #cetz.canvas({
      import cetz.draw: *
      import cetz-plot: *

      plot.plot(
        size: (5,5),
        axis-style: "school-book",
        x-tick-step: none, 
        y-tick-step: none, 
        x-label: [$x_1$],
        y-label: [$x_2$],
        x-min: 0, x-max: 50,
        y-min: -5, y-max: 50,
        axes: (
          stroke: black,
          tick: (stroke: black),
        ),
      {
        plot.add-fill-between(
          domain: (0, 50),
          f2,
          x1 => 0,
          style: (fill: rgb(200, 200, 255, 80), stroke: black)
        )
        plot.add(
          domain: (0, 50),
          x1 => 100 - 2 * x1,
          style: (stroke: 1pt),
          // label: [$2x_1 + x_2 lt.eq 100$]
        )
        plot.annotate({
          content((65, 15), [$2x_1 + x_2 lt.eq 100$])
        })
        plot.add(
          domain: (0, 50),
          x1 => (80 - x1)/2,
          style: (stroke: 1pt),
          // label: [$x_1 + 2x_2 lt.eq 80$]
        )
        plot.annotate({
          content((40, 50), [$x_1 + 2x_2 lt.eq 80$])
        })


        plot.add(
          domain: (0, 50),
          x1 => (1200 - 40 * x1) / 30,
          style: (stroke: (dash: "dotted")),
        )

        plot.annotate({
          content((35, -7.5), [$40 x_1 + 30 x_2 = 1200$])
        })
        
        plot.add(
          domain: (0, 50),
          x1 => (2200 - 40 * x1) / 30,
          style: (stroke: (dash: "dotted")),
        )

        plot.annotate({
          content((68, 5), [$40 x_1 + 30 x_2 = 2200$])
        })
        
        plot.add(
          domain: (0, 50),
          x1 => (200 - 40 * x1) / 30,
          style: (stroke: (dash: "dotted")),
        )

        plot.annotate({
          content((-17, 8), [$40 x_1 + 30 x_2 = 200$])
        })
        
      }
    )
    })
  ]
]

=== Types of LP

#align(center)[
  #diagram(
    node-inset: 0pt,

    node(pos: (0,0), label: {}, stroke: 0em, radius: 0em, name: <root>),
    
    node(pos: (1,-0.5), label: {
      [Infeasible]
    }, stroke: 0.0em, radius: 3em, name: <infeasible>),
    
    node(pos: (1,0.5), label: {
      [Feasible]
    }, stroke: 0.0em, radius: 3em, name: <feasible>),
    
    node(pos: (2,0), label: {
      [Finitely 
      Optimal]
    }, stroke: 0.0em, radius: 3em, name: <optimal>),
    
    node(pos: (2,1), label: {
      [Unbounded]
    }, stroke: 0.0em, radius: 3em, name: <unbounded>),
    
    node(pos: (3,-0.5), label: {
      [Unique 
      Solution]
    }, stroke: 0.0em, radius: 3em, name: <unique>),
    
    node(pos: (3,0.5), label: {
      [Multiple 
      Solution]
    }, stroke: 0.0em, radius: 3em, name: <multiple>),
    
    edge(<root>, <infeasible>, "-|>", label: {}),
    edge(<root>, <feasible>, "-|>", label: {}),
    edge(<feasible>, <optimal>, "-|>", label: {}),
    edge(<feasible>, <unbounded>, "-|>", label: {}),
    edge(<optimal>, <unique>, "-|>", label: {}),
    edge(<optimal>, <multiple>, "-|>", label: {}),
    
  )
]

=== LP Formulation

#eg[

  *Production*

  We produce desks and tables

  - Producing a desk requires 3 units of wood, 1 hour of labor and 50 minutes of machine time
  - Producing a table requires 5 units of wood, 2 hours of labor and 20 minutes of machine time
  
  For each day, we have

  - 200 workers that each work 8 hours
  - 50 machines that each run for 16 hours
  - A supply of 3600 units of wood

  Desks and tables are sold \$700 and \$900 per unit, respectively
  
  Everything that is produced is sold

  *1. Define Variables*

  $x_1$: number of desks produced per day
  
  $x_2$: number of tables produced per day

  *2. Formulate Objective Function*

  $
    max quad 700x_1 + 900x_2
  $

  *3. Formulate Constraints*

  #align(center)[
    #table(
      stroke: none,
      inset: 10pt,
      columns: (auto, auto, auto, auto),
      table.hline(),
      table.cell(
        rowspan: 2,
        align: horizon,
        [Resource],
      ),
      table.hline(),
      table.cell(
        colspan: 2,
        align: horizon,
        [Consumption per],
      ), 
      table.cell(
        rowspan: 2,
        align: horizon,
        [Total supply],
      ),
      [Desk], [Table],
      table.hline(),
      [Wood], [3 units], [5 units], [3600 units],
      table.hline(),
      [Labor], [1 hours], [2 hours], [200 workers $times$ 8 hours\ = 1600 hours],
      table.hline(),
      [Machine\ time], [50 minutes], [20 minutes], [50 machines $times$ 16 hours\ = 800 hours],
      table.hline(),
    )
  ]

  #linebreak()

  $
    3x_1& quad +& quad 5x_2& quad lt.eq& quad &3600 \
    x_1& quad +& quad 2x_2& quad lt.eq& quad &1600 \
    50x_1& quad +& quad 20x_2& quad lt.eq& quad &48000 \
  $

  *4. Complete Formulation*

  $
    &max& quad 700&x_1& quad &+& quad 900&x_2& \
    &s.t.& quad 3&x_1& quad &+& quad 5&x_2& quad &lt.eq& quad &3600 quad &&("wood") \
    && quad &x_1& quad &+& quad 2&x_2& quad &lt.eq& quad &1600 quad &&("labor") \
    && quad 50&x_1& quad &+& quad 20&x_2& quad &lt.eq& quad &48000 quad &&("machine") \
    && quad &x_1& &&&& &gt.eq& quad &0 \
    && quad &&&& &x_2& &gt.eq& quad &0 \
  $

  *Compact Formulation*

  $
    &max& quad &sum^n_(j=1) P_j x_j \
    &s.t.& &sum^n_(j=1) A_(i j) x_j lt.eq R_i quad forall i = 1, dots, m \
    & & &x_j gt.eq 0 quad forall j = 1, dots, n
  $

  Where:
  - $n$: number of products
  - $m$: number of resources
  - $j$: indices of products
  - $i$: indices of resources
  - $P_j$: unit sale price of product $j$
  - $R_i$: supply limit of resource $i$
  - $A_(i j)$: unit of resource $i$ to produce one unit of product $j$
  - $i = 1, dots, m$
  - $j = 1, dots, n$
  - $x_j$: production quantity for product $j$, $j = 1, dots, n$

  #line(length: 100%)

  *model.py*
  #code[
    ```py
    from pyomo.environ import *
    from pyomo.dataportal import DataPortal

    model = AbstractModel()

    # Sets
    model.Products = Set()
    model.Resources = Set()

    # Parameters
    model.Profit = Param(model.Products)
    model.Supply = Param(model.Resources)
    model.Consumption = Param(model.Resources, model.Products)

    # Variables
    model.x = Var(model.Products, domain=NonNegativeReals)

    # Objective: Maximize profit
    def objective_rule(model):
        return sum(model.Profit[j] * model.x[j] for j in model.Products)
    model.OBJ = Objective(rule=objective_rule, sense=maximize)

    # Constraints: Do not exceed resource supply
    def constraint_rule(model, i):
        return sum(model.Consumption[i, j] * model.x[j] for j in model.Products) <= model.Supply[i]
    model.ResourceConstraint = Constraint(model.Resources, rule=constraint_rule)

    # Load data from .dat file
    data = DataPortal()
    data.load(filename='data.dat', model=model)

    # Create an instance of the model
    instance = model.create_instance(data)

    # Create solver
    solver = SolverFactory('glpk')
    solver.options['tmlim'] = 60

    # Solve with solver timeout (optional)
    results = solver.solve(instance, tee=True)

    # Display results
    instance.display()
    ```
    ]

    *data.dat*

    #code[
      ```python
      set Products := Desk Table ;
      set Resources := Wood Labor Machine ;

      param Profit :=
      Desk   700
      Table  900 ;

      param Supply :=
      Wood    3600
      Labor   1600
      Machine 48000 ;

      param Consumption:
                Desk Table :=
      Wood        3     5
      Labor       1     2
      Machine    50    20 ;

      ```
    ]

    *Output:*

    #code[
    ```python

    Variables:
    x : Size=2, Index=Products
        Key   : Lower : Value            : Upper : Fixed : Stale : Domain
         Desk :     0 : 884.210526315789 :  None : False : False : NonNegativeReals
        Table :     0 : 189.473684210526 :  None : False : False : NonNegativeReals

  Objectives:
    OBJ : Size=1, Index=None, Active=True
        Key  : Active : Value
        None :   True : 789473.6842105257

  Constraints:
    ResourceConstraint : Size=3
        Key     : Lower : Body              : Upper
          Labor :  None : 1263.157894736841 :  1600.0
        Machine :  None : 47999.99999999997 : 48000.0
           Wood :  None : 3599.999999999997 :  3600.0
    ```

    
  ]
]

#eg[
  *Multi Period (Inventory)*

  We produce and sell products

  For the coming 4 days, the demand will be

  - Days 1: 100
  - Days 2: 150
  - Days 3: 200 
  - Days 4: 170

  The unit production costs are different for different days

  - Days 1: \$9
  - Days 2: \$12
  - Days 3: \$10 
  - Days 4: \$12

  Prices are all fixed. So maximizing profit is equivalent to minimizing costs.

  We may store products and sell them later. Inventory cost is \$1 per unit per day.

  E.g., producing 620 units on day 1 to fulfill all demands:

  $
    \$9 times 620 + \$1 times 150 + \$2 times 200 + \$3 times 170 = \$6,640
  $

  
  #align(center)[
  #cetz.canvas({
    import cetz.draw: *
    import cetz-plot: *
    set-style(axes: (y: (stroke: 0pt)))

    plot.plot(
      size: (14,2),
      axis-style: "school-book",
      x-tick-step: none, 
      y-tick-step: none, 
      x-ticks: ((1, []), (2, []), (3, [])),
      x-label: [time],
      y-label: none,
      x-min: 0.1, x-max: 2.9,
      y-min: 0, y-max: 0,
      axes: (
        stroke: black,
        tick: (stroke: black),
      ),
      name: "plot",
    {
      plot.add(((0,0), (3,0)), style: (stroke: black))
      plot.add-anchor("production", (1.1,0))
      plot.add-anchor("sales", (1.9,0))
      
      plot.add-anchor("beginning-inventory", (1,-0.25))
      plot.add-anchor("ending-inventory", (2,-0.25))

      plot.annotate({
        content((0.5, -0.5), [day $t - 1$])
      })

      plot.annotate({
        content((1.5, -0.5), [day $t$])
      })
      plot.annotate({
        content((2.5, -0.5), [day $t + 1$])
      })
      
    }
  )
  line("plot.production", ((), "|-", (0, 1.5)), mark: (start: ">", fill: black), name: "productionline")
  content("productionline.end", [production], anchor: "south", padding: .1)

  line("plot.sales", ((), "|-", (0, 1.5)), mark: (start: ">", fill: black), name: "salesline")
  content("salesline.end", [sales], anchor: "south", padding: .1)
  
  line("plot.beginning-inventory", ((), "|-", (0, 0.1)), mark: (start: ">", fill: black), name: "beginning-inventoryline")
  content("beginning-inventoryline.end", [beginning\ inventory], anchor: "north", padding: 0.1)
  
  line("plot.ending-inventory", ((), "|-", (0, 0.1)), mark: (start: ">", fill: black), name: "ending-inventoryline")
  content("ending-inventoryline.end", [beginning\ inventory], anchor: "north", padding: 0.1)
  })
]

$
  I_(t-1) + x_t - d_t = I_t
$

- $I_(t-1)$: inevntory at the end of day $t-1$ (i.e., beginning inventory for day $t$)

- $x_t$: units produced on day $t$

- $d_t$: demand (or sales) on dat $t$

- $I_t$: inventory at the end of day $t$

Inventory costs are calculated according to *ending inventory*

- $x_t$: production quantity of day $t$, $t = 1, dots, 4$

- $y_t$: *ending* inventory of day $t$, $t = 1, dots, 4$

Objective function:

$
  min quad 9 x_1 + 12 x_2 + 10 x_3 + 12 x_4 + y_1 + y_2 + y_3 + y_4
$

#align(center)[
  #cetz.canvas({
    import cetz.draw: *
    import cetz-plot: *

    set-style(axes: (y: (stroke: 0pt)))

    plot.plot(
      size: (14,2),
      axis-style: "school-book",
      x-tick-step: none, 
      y-tick-step: none, 
      x-ticks: ((1, [$y_1$]), (2, [$y_2$]), (3, [$y_3$]), (4, [$y_4$])),
      x-label: none,
      y-label: none,
      x-min: 0.1, x-max: 4,
      y-min: 0, y-max: 0,
      axes: (
        stroke: black,
        tick: (stroke: black),
      ),
      name: "plot",
    {
      plot.add(((0,0), (3,0)), style: (stroke: black))
      plot.add-anchor("x1", (0.2,0))
      plot.add-anchor("x2", (1.2,0))
      plot.add-anchor("x3", (2.2,0))
      plot.add-anchor("x4", (3.2,0))
      
      plot.add-anchor("s1", (0.8,0))
      plot.add-anchor("s2", (1.8,0))
      plot.add-anchor("s3", (2.8,0))
      plot.add-anchor("s4", (3.8,0))
    }
  )
  line("plot.x1", ((), "|-", (0, 1.5)), mark: (start: ">", fill: black), name: "x1line")
  content("x1line.end", [$x_1$], anchor: "south", padding: .1)

  line("plot.x2", ((), "|-", (0, 1.5)), mark: (start: ">", fill: black), name: "x2line")
  content("x2line.end", [$x_2$], anchor: "south", padding: .1)
  
  line("plot.x3", ((), "|-", (0, 1.5)), mark: (start: ">", fill: black), name: "x3line")
  content("x3line.end", [$x_3$], anchor: "south", padding: .1)
  
  line("plot.x4", ((), "|-", (0, 1.5)), mark: (start: ">", fill: black), name: "x4line")
  content("x4line.end", [$x_4$], anchor: "south", padding: .1)
  
  line("plot.s1", ((), "|-", (0, 1.5)), mark: (start: ">", fill: black), name: "s1line")
  content("s1line.end", [$-100$], anchor: "south", padding: .1)
  
  line("plot.s2", ((), "|-", (0, 1.5)), mark: (start: ">", fill: black), name: "s2line")
  content("s2line.end", [$-150$], anchor: "south", padding: .1)
  
  line("plot.s3", ((), "|-", (0, 1.5)), mark: (start: ">", fill: black), name: "s3line")
  content("s3line.end", [$-200$], anchor: "south", padding: .1)
  
  line("plot.s4", ((), "|-", (0, 1.5)), mark: (start: ">", fill: black), name: "s4line")
  content("s4line.end", [$-170$], anchor: "south", padding: .1)
  })
]

Inventory balancing constraints:

- Day 1: $x_1 - 100 = y_1$

- Day 2: $y_1 + x_2 - 150 = y_2$

- Day 3: $y_2 + x_3 - 200 = y_3$

- Day 4: $y_3 + x_4 - 170 = y_4$

Demand fulfillment constraints:

- $x_1 gt.eq 100$

- $y_1 + x_2 gt.eq 150$

- $y_2 + x_3 gt.eq 200$

- $y_3 + x_4 gt.eq 170$

Non-negativity constraints:

- $y_t gt.eq 0$

- $x_t gt.eq 0$

Complete Formulation


$
  min quad &9x_1 + 12x_2 + 10x_3 + 12x_4 + y_1 + y_2 + y_3 + y_4 \
  s.t. quad &x_1 - 100 = y_1 \
            &y_1 + x_2 - 150 = y_2 \
            &y_2 + x_3 - 200 = y_3 \
            &y_3 + x_4 - 170 = y_4 \
            &x_1 gt.eq 100 \
            &y_1 + x_2 gt.eq 150 \
            &y_2 + x_3 gt.eq 200 \
            &y_3 + x_4 gt.eq 170 \
            &x_t, y_t gt.eq 0 quad forall t = 1, dots, 4 
$

Simplification (Redundant Constraints)

- Inventory balancing & non-negativity imply fulfillment
  - E.g., in day 1, $x_1 - 100 = y_1$ and $y_1 gt.eq 0$ means $x_1 gt.eq 100$

$
  min quad &9x_1 + 12x_2 + 10x_3 + 12x_4 + y_1 + y_2 + y_3 + y_4 \
  s.t. quad &x_1 - 100 = y_1 \
            &y_1 + x_2 - 150 = y_2 \
            &y_2 + x_3 - 200 = y_3 \
            &y_3 + x_4 - 170 = y_4 \
            &x_t, y_t gt.eq 0 quad forall t = 1, dots, 4 
$

- No need to have ending inventory in period 4 (costly but useless)

$
  min quad &9x_1 + 12x_2 + 10x_3 + 12x_4 + y_1 + y_2 + y_3 + y_4 \
  s.t. quad &x_1 - 100 = y_1 \
            &y_1 + x_2 - 150 = y_2 \
            &y_2 + x_3 - 200 = y_3 \
            &y_3 + x_4 - 170 = 0 \
            &x_t gt.eq 0 quad forall t = 1, dots, 4 \
            &y_t gt.eq 0 quad forall t = 1, dots, 3 
$

*Compact Formulation*

$
  &min& quad &sum^4_(t=1) (C_t x_t + y_t) \
  &s.t.& quad &y_t - 1 + x_t - D_t = y_t quad forall t = 1, dots, 4 \
  & & quad &y_0 = 0 \
  & & quad &x_t, y_t gt.eq 0 quad forall t = 1, dots, 4
$

Where:
- $D_t$: demand on day $t$
- $y_t$: ending inventory of day $t$
- $C_t$: unit production cost on day $t$
]

#eg[
  *Personnel Scheduling*

  Scheduling employees 

  Each employee must work for 5 consecutive days and then take 2 consectutive rest days

  Number of employees required for each day

  #align(center)[
    #table(
      stroke: none,
      inset: 10pt,
      columns: (auto, auto, auto, auto, auto, auto, auto),
      table.hline(),
      [Mon], [Tue], [Wed], [Thu], [Fri], [Sat], [Sun],
      table.hline(),
      [110], [80], [150], [30], [70], [160], [120],      
      table.hline(),
    )
  ]

  Seven shifts
  - Mon to Fri
  - Tue to Sat
  - ...

  Minimize number of employees hired

  Let $x_i$ be the number of employees assigned to work from day $i$ for 5 consecutive days

  Objective function:

  $
    min x_1 + x_2 + x_3 + x_4 + x_5 + x_6 + x_7
  $

  Demand Fullfilment Constraints

  - 110 employeeds needed Monday

  $
    x_1 + x_4 + x_5 + x_6 + x_7 gt.eq 110
  $

  An employee that works on Tues ($t_2$) or Wed ($t_3$) does not work on Mon ($t_1$)

  - 80 employees needed Tuesday

  $
    x_1 + x_2 + x_5 + x_6 + x_7 gt.eq 80
  $

  An employee that works on Wed ($t_3$) or Thu ($t_4$) does not work on Tue ($t_2$)

  - 120 employees needed Sunday

  $
    x_3 + x_4 + x_5 + x_6 + x_7 gt.eq 120
  $

  An employee that works on Mon ($t_1$) or Tue ($t_2$) does not work on Sun ($t_7$)

  Non-Nagativity Constraints

  $
    x_i gt.eq 0 quad forall i = i, dots, 7
  $

  Complete Formulation

#show math.equation: it => {
  show "+": $quad + quad$
  it
}

#let eqFill = hide[$>=$]
#let f = hide[+]

$
    & min  quad & x_1 + & x_2 + & x_3 + & x_4 + & x_5 + & x_6 + & x_7 & eqFill   \
    & s.t. quad & x_1 + &       &       & x_4 + & x_5 + & x_6 + & x_7 & >= & 110 \
    &           & x_1 + & x_2 + &       &       & x_5 + & x_6 + & x_7 & >= &  80 \
    &           & x_1 + & x_2 + & x_3 + &       &       & x_6 + & x_7 & >= & 150 \
    &           & x_1 + & x_2 + & x_3 + & x_4 + &       &       & x_7 & >= &  30 \
    &           & x_1 + & x_2 + & x_3 + & x_4 + & x_5 #f&       &     & >= &  70 \
    &           &       & x_2 + & x_3 + & x_4 + & x_5 + & x_6   &     & >= & 160 \
    &           &       &       & x_3 + & x_4 + & x_5 + & x_6 + & x_7 & >= & 120 \
    &           &x_i >= 0 & forall i = 1, ..., 7 \
$

*model.py*

#code[
  ```py
  from pyomo.environ import *
  from pyomo.dataportal import DataPortal

  model = AbstractModel()

  # Sets
  model.Days = Set(ordered=True)           # Days 1..7 (Mon..Sun)
  model.Shifts = Set(ordered=True)         # Shifts starting on days 1..7

  # Parameters
  model.Demand = Param(model.Days)         # Daily staffing requirements
  model.Cover = Param(model.Days, model.Shifts, within=Binary)  # Coverage matrix (1 if shift j covers day i)

  # Variables
  model.x = Var(model.Shifts, domain=NonNegativeReals)

  # Objective: Minimize total employees hired
  def obj_rule(model):
      return sum(model.x[s] for s in model.Shifts)
  model.OBJ = Objective(rule=obj_rule, sense=minimize)

  # Constraints: Cover daily demand
  def demand_rule(model, d):
      return sum(model.Cover[d, s] * model.x[s] for s in model.Shifts) >= model.Demand[d]
  model.DemandConstraint = Constraint(model.Days, rule=demand_rule)

  # Load data from .dat file
  data = DataPortal()
  data.load(filename='data.dat', model=model)

  # Create an instance of the model
  instance = model.create_instance(data)

  # Create solver
  solver = SolverFactory('glpk')
  solver.options['tmlim'] = 60

  # Solve with solver timeout (optional)
  results = solver.solve(instance, tee=True)

  # Display results
  instance.display()
  ```
  ]
  
  *data.dat*

  #code[
    ```python
    set Days := Mon Tue Wed Thu Fri Sat Sun ;
    set Shifts := s1 s2 s3 s4 s5 s6 s7 ;

    param Demand :=
    Mon 110
    Tue 80
    Wed 150
    Thu 30
    Fri 70
    Sat 160
    Sun 120 ;

    # Each shift covers 5 consecutive days starting on the shift's day
    # 1 if shift s_j covers day d_i, 0 otherwise

    param Cover:
            s1 s2 s3 s4 s5 s6 s7 :=
    Mon     1  0  0  1  1  1  1
    Tue     1  1  0  0  1  1  1
    Wed     1  1  1  0  0  1  1
    Thu     1  1  1  1  0  0  1
    Fri     1  1  1  1  1  0  0
    Sat     0  1  1  1  1  1  0
    Sun     0  0  1  1  1  1  1 ;

    ```
  ]
  
  *Output:*
  
  #code[
    ```python
    Variables:
    x : Size=7, Index=Shifts
        Key : Lower : Value            : Upper : Fixed : Stale : Domain
         s1 :     0 : 3.33333333333333 :  None : False : False : NonNegativeReals
         s2 :     0 :             40.0 :  None : False : False : NonNegativeReals
         s3 :     0 : 13.3333333333333 :  None : False : False : NonNegativeReals
         s4 :     0 :              0.0 :  None : False : False : NonNegativeReals
         s5 :     0 : 13.3333333333333 :  None : False : False : NonNegativeReals
         s6 :     0 : 93.3333333333333 :  None : False : False : NonNegativeReals
         s7 :     0 :              0.0 :  None : False : False : NonNegativeReals

  Objectives:
    OBJ : Size=1, Index=None, Active=True
        Key  : Active : Value
        None :   True : 163.33333333333323

  Constraints:
    DemandConstraint : Size=7
        Key : Lower : Body               : Upper
        Fri :  70.0 :  69.99999999999993 :  None
        Mon : 110.0 : 109.99999999999993 :  None
        Sat : 160.0 :  159.9999999999999 :  None
        Sun : 120.0 :  119.9999999999999 :  None
        Thu :  30.0 :  56.66666666666663 :  None
        Tue :  80.0 : 149.99999999999994 :  None
        Wed : 150.0 : 149.99999999999994 :  None
    ```
  ]
]
