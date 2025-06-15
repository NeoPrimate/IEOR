#import "@preview/cetz:0.3.4"
#import "@preview/cetz-plot:0.1.1"

#import "../../../utils/examples.typ": eg
#import "../../../utils/code.typ": code

== IP (Integer Programming)

== Selection and Logical Relations on Binary Variables $x_i in {0, 1}$

=== Cardinality Constraints

Given a subset $S subset.eq {1, dots, n}$:

- At least $k$ of the items in $S$

$
  sum_(i in S) x_i gt.eq k
$

#eg[
  We want to select at least 2 of items 1, 2, 3

  $
    x_1 + x_2 + x_3 gt.eq 2
  $
]

- At most $k$ of the items in $S$

$
  sum_(i in S) x_i lt.eq k
$

#eg[
  We want to select at most 2 of items 1, 2, 3

  $
    x_1 + x_2 + x_3 lt.eq 2
  $
]

- Exactly $k$ of the items in $S$

$
  sum_(i in S) x_i eq k
$

#eg[
  We want to select exactly 2 of items 1, 2, 3

  $
    x_1 + x_2 + x_3 eq 2
  $
]

=== Logical OR

Given a subset $S subset.eq {1, dots, n}$:

- At least 1 item in $S$

$
  sum_(i in S) x_i gt.eq 1
$

#eg[
  Select item 1 or item 2, or both

  $
    x_1 + x_2 gt.eq 1
  $
]

=== Conditional Selection: "If X, then Y"

(Implication Constraints)

- If $x_a = 1$, then $x_b = 1$

$
  x_a lt.eq x_b
$

#eg[
  If item 1 is selected, then item 2 must also be selected
  
  $
    x_1 lt.eq x_2
  $
  #align(center)[
    #table(
      columns: (5em, 5em, 5em),
      inset: 5pt,
      stroke: none,
      align: horizon,
        [$x_a$], [$x_b$], [Valid?],
        table.hline(stroke: 0.05em),
        [0], [0], [✅],
        table.hline(stroke: 0.05em),
        [0], [1], [✅],
        table.hline(stroke: 0.05em),
        [1], [0], [✅],
        table.hline(stroke: 0.05em),
        [1], [1], [❌],
        table.hline(stroke: 0.05em),
    )
  ]

]

- If $x_a = 1$, then $x_b = 0$

$
  x_a + x_b lt.eq 1
$

#eg[
  If you choose project A, then you cannot choose project B (mutually exclusive).

  #align(center)[
    #table(
      columns: (5em, 5em, 5em),
      inset: 5pt,
      stroke: none,
      align: horizon,
        [$x_a$], [$x_b$], [Valid?],
        table.hline(stroke: 0.05em),
        [0], [0], [✅],
        table.hline(stroke: 0.05em),
        [0], [1], [✅],
        table.hline(stroke: 0.05em),
        [1], [0], [✅],
        table.hline(stroke: 0.05em),
        [1], [1], [❌],
        table.hline(stroke: 0.05em),
    )
  ]

]

- If $x_a = 1$, then $x_b + x_c lt.eq 0$ (generalized)

$
  x_b + x_c lt.eq M(1 - x_a)
$

#eg[
  For binary variables $M = 2$ works

  If you choose project A, then you must not choose either project B or C.

  #align(center)[
    #table(
      columns: (5em, 5em, 5em, 5em),
      inset: 5pt,
      stroke: none,
      align: horizon,
        [$x_a$], [$x_b$], [$x_c$], [Valid?],
        table.hline(stroke: 0.05em),
        [1], [0], [0], [✅],
        table.hline(stroke: 0.05em),
        [1], [1], [0], [❌],
        table.hline(stroke: 0.05em),
        [1], [1], [1], [❌],
        table.hline(stroke: 0.05em),
        [0], [1], [1], [✅],
        table.hline(stroke: 0.05em),
        [0], [0], [1], [✅],
        table.hline(stroke: 0.05em),
        
    )
  ]

]

=== Conditional OR: "If not X, then select Y and Z"

- If $x_j = 0$, then at least $k$ items in $S$ must be selected (generalized)

$
  sum_(i in S) x_i gt.eq k(1 - x_j)
$

#eg[

  If you do not choose item 1, then you must choose both item 2 and item

  If $x_1 = 0$, then $x_2 = x_3 = 1$
  
  $
    x_2 + x_3 gt.eq 2(1 - x_1)
  $

  #align(center)[
    #table(
      columns: (5em, 5em, 5em, 5em, 5em, 5em),
      inset: 5pt,
      stroke: none,
      align: horizon,
        [$x_1$], [$x_2$], [$x_3$], [LHS], [RHS], [Valid?],
        table.hline(stroke: 0.05em),
        [0], [1], [1], [2], [2], [✅],
        table.hline(stroke: 0.05em),
        [0], [1], [0], [1], [2], [❌],
        table.hline(stroke: 0.05em),
        [0], [0], [0], [0], [2], [❌],
        table.hline(stroke: 0.05em),
        [1], [0], [0], [0], [0], [✅],
        table.hline(stroke: 0.05em),
        [1], [1], [0], [1], [0], [✅],
        table.hline(stroke: 0.05em),
        [1], [1], [1], [2], [0], [✅],
        table.hline(stroke: 0.05em),
    )
  ]
]


=== XOR / Exclusive Conditions

- Exactly one item in a set $S$

$
  sum_(i in S) x_i = 1
$

- Select one or the other but not both (i.e., $x_i xor x_k$)

$
  x_a + x_b = 1
$

#eg[

  You can select item 1 or item 2, but not both

  #align(center)[
    #table(
      columns: (5em, 5em, 5em, 5em),
      inset: 5pt,
      stroke: none,
      align: horizon,
        [$x_1$], [$x_2$], [Sum], [Valid?],
        table.hline(stroke: 0.05em),
        [0], [1], [1], [✅],
        table.hline(stroke: 0.05em),
        [1], [0], [1], [✅],
        table.hline(stroke: 0.05em),
        [1], [1], [2], [❌],
        table.hline(stroke: 0.05em),
        [0], [0], [0], [❌],
        table.hline(stroke: 0.05em),
    )
  ]
]

== Constraint Activation and Relaxation via Binary Indicators $z_i in {1, 0}$

=== Base Case: At Least One of Two Constraints Satisfied

You are given 2 constraints

$
  g_1(x) lt.eq b_1 \
  g_2(x) lt.eq b_2 \
$

We want at least one of these two constraints to be satisfied.

Binary Indicator Variables

Define:

$
  z_i = cases(
    1 quad "if" g_i(x) lt.eq b_i "is enforced",
    0 quad "if" g_i(x) lt.eq b_i "may be violated",
  ) quad "for" i = 1, 2
$

Let $M_1$ and $M_2$ be upper bounds on how much each constraint's LHS $g_i(x)$ can exceed $b_i$:

$
  M_i gt.eq max_x (g_i(x) - b_i)
$

Big-M Reformulation

We relax each constraint as follows:

$
  g_1(x) - b_1 lt.eq M_1 (1 - z_1) \
  g_2(x) - b_2 lt.eq M_2 (1 - z_2) \
$

When $z_i = 1$, the original constraint is enforced 

When $z_i = 0$, the original constraint can be violated by up to $M_i$

At Least One Constraint Enforced

We require:

$
  z_1 + z_2 gt.eq 1
$

=== General Formulation for $m$ Constraints with At Least $k$ Satisfied

1. Introduce a binary variable $z_i in {0, 1}$ for each constraint $g_i(x) lt.eq b_i$, where:

- $z_i = 1$: the constraint is enforced (i.e., $g_i(x) lt.eq b_i$)
- $z_i = 0$: the constraint may be violated

2. Use "big-M" constraint to relax $g_i(x) lt.eq b_i$ when $z_i = 0$, like:

$
  g_i(x) - b_i lt.eq M_i (1 - z_i), quad forall i = 1, dots, m
$

Where $M_i gt.eq max_x (g_i(x) - b_i)$

3. Impose a condition that at least $k$ of the $m$ constraints must be satisfied:

$
  sum^m_(i=1) z_i gt.eq k
$


== Fixed Charge Constraints (Setup Costs)

- $n$: Number of factories
- $K_i$: Capacity of factory $i$
- $C_i$: Unit production cost at factory $i$
- $S_i$: Fixed setup cost for factory $i$
- $D$: Total Demand

Decision Variables

- $x_i$: production quantity at factory $i$, $i = 1, dots, n$

- $y_i$: Binary variable indicating whether factory $i$ is used

$
 y_i= cases(
    1 quad "if factory" i "is used (i.e.," x_i gt 0 ")",
    0 quad "if factory" i "is not used (i.e," x_i = 0 ")",
  )
$

Objective Function

$
  min underbrace(sum^n_(i=1) C_i x_i, "Production Cost") + underbrace(sum^n_(i=1) S_i y_i, "Setup Cost")
$

Capacity Constraints

$
  x_i lt.eq K_i quad forall i = 1, dots, n
$

Demand Fullfilment

$
  sum^n_(i=1) x_i gt.eq D
$

Logical Linking of $x_i$ and $y_i$

To ensure $y_i = 1$ if any production occurs at factory $i$:

$
  x_i lt.eq K_i y_i quad forall i = 1, dots, n
$

- If $x_i gt 0$, this forces $y_i = 1$
- If $x_i = 0$, $y_i$ can be 0 or 1 (but to minimize cost, $y_i$ will be 0)

Binary & Non-negative Constraints

$
  y_i in {0, 1}, quad x_i gt.eq 0 quad forall i = 1, dots, n
$

General Form (Big-M Formulation)

$
  x lt.eq M y
$

Where $M$ must be set to the upper bound of $x$

== Facility Location

#align(center)[
  #table(
    columns: (auto, auto),
    align: (left, left),
    inset: 5pt,
    table.header([*Problem*], [*Definition*]),
    [Set Covering], [Select the minimum number of facilities such that every demand point is within a specified coverage distance of at least one facility],
    [Maximum Covering], [Select a fixed number of facilities to maximize the number of demand points covered within a specified distance],
    [Fixed Charge Location], [Determine which facilities to open and how to assign demand to them to minimize the total cost],
  )
]


=== Set Covering Problem

*Question*: How to allocate as few facilities as possible to cover all demand nodes?

- $I$: Set of demand nodes
- $J$: Set of location nodes
- $d_(i j) gt 0$: Distance between demand node $i in I$ and location node $j in J$
- $s$: Maximum allowable distance (a facility at $j$ can cover demand node $i$ if $d_(i j) lt s$)
- Demand $i$ is "covered" by location $j$ if $d_(i j) lt s$
- $w_j gt 0$: Cost of building facility at location $j$ (usually set to $w_j=1$ for minimizing number of facilities, but can reflect other costs)

- $
a_(i j) = cases(
  1 quad "if" d_(i j) lt s,
  0 quad "otherwise",
) quad$: Indicator of whether location $j$ can cover demand $i$

- $
x_j = cases(
  1 quad "if facility is built at location" j,
  0 quad "otherwise",
)$

Complete Formulation

$
  & min & quad &sum_(j in J) w_j x_j \
  & s.t. & quad &sum_(j in J) a_(i j) x_j gt.eq 1 quad &forall i in I \
  & & quad &x_j in {0, 1} quad &forall j in J
$

=== Maximum Covering Problem

*Question*: How to allocate at most $p$ facilities to cover as many demand nodes as possible?

- $I$: Set of demand nodes
- $J$: Set of location nodes
- $d_(i j) gt 0$: Distance between demand node $i in I$ and location node $j in J$
- $p in NN$: maximum number of facilities
- $w_j gt 0$: Cost of building facility at location $j$ (usually set to $w_j=1$ for minimizing number of facilities, but can reflect other costs)

- $
x_j = cases(
  1 quad "if facility is built at location" j,
  0 quad "otherwise",
)$

- $
a_(i j) = cases(
  1 quad "if" d_(i j) lt s,
  0 quad "otherwise",
)quad$: Indicator of whether location $j$ can cover demand $i$

- $
y_i = cases(
  1 quad "if demand" i in I "is covered by any facility",
  0 quad "otherwise",
)$

Complete Formulation

$
  & min & quad &sum_(i in I) w_i y_i \
  & s.t. & quad &sum_(j in J) a_(i j) x_j gt.eq y_i quad &forall i in I \
  & & quad &sum_(j in J) x_j lt.eq p quad &forall j in J \
  & & quad &x_j in {0, 1} quad &forall j in J \
  & & quad &y_i in {0, 1} quad &forall i in I
$

*Fixed Charge Location Problems*

*Question*: How to allocate some facilities to minimize the total shipping and construction costs?

Uncapacitated Facility Location Problem (UFL)

- $I$: Set of demand nodes
- $J$: Set of location nodes
- $h_i gt 0$: Demand size at demand node $i$
- $d_(i j)$: Unit shipping cost from location node $j$ to demand node $i$
- $f_j gt 0$: Fixed construction cost at location $j$

- $
x_j = cases(
  1 quad "if facility is built at location" j,
  0 quad "otherwise",
)$

- $
y_(i j) = cases(
  1 quad "if demand" i in I "is served by facility at location" j in J,
  0 quad "otherwise",
)$

Complete Formulation

$
  &min& quad &underbrace(sum_(i in I) sum_(j in J) h_i d_(i j) y_(i j), "Shipping Costs") + underbrace(sum_(j in J) f_j x_j, "Fixed Costs") \
  &s.t.& quad &y_(i j) lt.eq x_j quad forall i in I, j in J \
  &&&sum_(j in J) y_(i j) = 1 quad forall i in I \
  &&&x_j in {0, 1} quad forall j in J \
  &&&y_(i j) in {0, 1} quad forall i in I \
$

Capacitated Facility Location Problem (CFL)

If locations have a capacity, we may add constraint

$
  sum_(i in I) h_i y_(i j) lt.eq K_j quad forall j in J
$

Where:
- $K_j gt 0$: Capacity of location $j$

#eg[
  $
    min quad &underbrace(sum^5_(j=1) f_j x_j, "Fixed Costs") + underbrace(sum^5_(i=1) sum^5_(j=1) c_(i j) y_(i j), "Shipping Costs") \
    s.t. quad &sum^5_(i=1) y_(i j) lt.eq K_j x_j quad &forall& j = 1, dots, 5 quad& &("Capacity Constraint") \
    &sum^5_(j=1) y_(i j) gt.eq D_i quad &forall& i = 1, dots, 5 quad& &("Demand Constraint") \
    &x_j in {0, 1} quad &forall& j = 1, dots, 5 quad& &("Binary Constraint") \
    &y_(i j) gt.eq 0 quad &forall& i = 1, dots, 5, j = 1, dots, 5 quad quad & &("Positivity Constraint")
  $

  *Parameters*

  - $f_j$: weekly operating cost of distribution center $j$
  - $c_(i j)$: shipping cost per book from distribution center $j$ to region $i$
  - $K_j$: capacity of distribution center $j$
  - $D_i$: book demand of region $i$

  *Decision variable*

  - $x_(i j)$: binary variable
  $
    x_(i j) = cases(
      1 quad "if a distribution center is build at location" j,
      0 quad "otherwise",
    )
  $
  - $y_(i j)$: number of books shipped from distribution center $j$ to region $i$

  *Supply*

  #align(center)[
    #table(
      columns: 7,
      stroke: none,
      table.hline(),
      table.header(
        [],
        [WA],
        [NV],
        [NE],
        [PA],
        [FL],
        [Demand\ ($D_i$)]
      ),
      table.hline(),

      [NorthWest], [$y_(1 1)$], [$y_(1 2)$], [$y_(1 3)$], [$y_(1 4)$], [$y_(1 5)$], [8000],
      
      [SouthWest], [$y_(2 1)$], [$y_(2 2)$], [$y_(2 3)$], [$y_(2 4)$], [$y_(2 5)$], [12000],
      
      [MidWest], [$y_(3 1)$], [$y_(3 2)$], [$y_(3 3)$], [$y_(3 4)$], [$y_(3 5)$], [9000],
      
      [SouthEast], [$y_(4 1)$], [$y_(4 2)$], [$y_(4 3)$], [$y_(4 4)$], [$y_(4 5)$], [14000],
      
      [NorthEast], [$y_(5 1)$], [$y_(5 2)$], [$y_(5 3)$], [$y_(5 4)$], [$y_(5 5)$], [17000],

      table.hline(),
    )
  ]

  *Fixed Costs ($f_j$) and Capacity ($K_j$)*
  
  #align(center)[
    #table(
      columns: 6,
      stroke: none,
      table.hline(),
      table.header(
        [],
        [$x_1$],
        [$x_2$],
        [$x_3$],
        [$x_4$],
        [$x_5$],
      ),
      table.hline(),
      
      [Operation Cost ($f_i$)], [40000], [30000], [25000], [40000], [30000],
      
      [Capacity ($K_i$)], [20000], [20000], [15000], [25000], [15000],

      table.hline(),
    )
  ]

  *Shipping Cost ($c_j$)*

  #align(center)[
    #table(
      columns: 6,
      stroke: none,
      table.hline(),
      table.header(
        [],
        [WA],
        [NV],
        [NE],
        [PA],
        [FL],
      ),
      table.hline(),

      [NorthWest], [2.4], [3.25], [4.05], [5.25], [6.95],
      
      [SouthWest], [3.5], [2.3], [3.25], [6.05], [5.85],
      
      [MidWest], [4.8], [3.4], [2.85], [4.3], [4.8],
      
      [SouthEast], [6.8], [5.25], [4.3], [3.25], [2.1],
      
      [NorthEast], [5.75], [6], [4.75], [2.75], [3.5],

      table.hline(),
    )
  ]

  *Binary Decision Variable*

  #align(center)[
    #table(
      columns: 2,
      stroke: none,
      table.hline(),

      [WA], [$x_1$],
      [NV], [$x_2$],
      [NE], [$x_3$],
      [PA], [$x_4$],
      [FL], [$x_5$],

      table.hline(),
    )
  ]

  *model.py*

  #code[
    ```python
    from pyomo.environ import *
    from pyomo.dataportal import DataPortal

    model = AbstractModel()

    # Sets
    model.I = Set(doc='Regions (demand points)')
    model.J = Set(doc='Candidate distribution centers')

    # Parameters
    model.D = Param(model.I, within=NonNegativeReals, doc='Demand at region i')
    model.K = Param(model.J, within=NonNegativeReals, doc='Capacity at distribution center j')
    model.f = Param(model.J, within=NonNegativeReals, doc='Fixed cost to open center j')
    model.c = Param(model.I, model.J, within=NonNegativeReals, doc='Shipping cost from j to i')

    # Decision Variables
    model.x = Var(model.J, within=Binary, doc='1 if center j is opened')
    model.y = Var(model.I, model.J, within=NonNegativeReals, doc='Units shipped from j to i')

    # Objective Function: Minimize total cost
    def total_cost_rule(model):
        fixed = sum(model.f[j] * model.x[j] for j in model.J)
        shipping = sum(model.c[i, j] * model.y[i, j] for i in model.I for j in model.J)
        return fixed + shipping
    model.TotalCost = Objective(rule=total_cost_rule, sense=minimize)

    # Constraints

    # Capacity Constraint: Total shipped from center ≤ capacity if opened
    def capacity_rule(model, j):
        return sum(model.y[i, j] for i in model.I) <= model.K[j] * model.x[j]
    model.CapacityConstraint = Constraint(model.J, rule=capacity_rule)

    # Demand Constraint: Total received by region ≥ its demand
    def demand_rule(model, i):
        return sum(model.y[i, j] for j in model.J) >= model.D[i]
    model.DemandConstraint = Constraint(model.I, rule=demand_rule)

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
    set I := NorthWest SouthWest MidWest SouthEast NorthEast;
    set J := WA NV NE PA FL;

    param: D :=
    NorthWest 8000
    SouthWest 12000
    MidWest 9000
    SouthEast 14000
    NorthEast 17000;

    param: f :=
    WA 40000
    NV 30000
    NE 25000
    PA 40000
    FL 30000;

    param: K :=
    WA 20000
    NV 20000
    NE 15000
    PA 25000
    FL 15000;

    param c:
            WA     NV     NE     PA     FL :=
    NorthWest 2.4   3.25   4.05   5.25   6.95
    SouthWest 3.5   2.3    3.25   6.05   5.85
    MidWest   4.8   3.4    2.85   4.3    4.8
    SouthEast 6.8   5.25   4.3    3.25   2.1
    NorthEast 5.75  6      4.75   2.75   3.5 ;

    ```
  ]
  
  *Output:*

  #code[
    ```python
    Variables:
    x : 1 if center j is opened
        Size=5, Index=J
        Key : Lower : Value : Upper : Fixed : Stale : Domain
         FL :     0 :   1.0 :     1 : False : False : Binary
         NE :     0 :   0.0 :     1 : False : False : Binary
         NV :     0 :   1.0 :     1 : False : False : Binary
         PA :     0 :   1.0 :     1 : False : False : Binary
         WA :     0 :   0.0 :     1 : False : False : Binary
    y : Units shipped from j to i
        Size=25, Index=I*J
        Key                 : Lower : Value   : Upper : Fixed : Stale : Domain
          ('MidWest', 'FL') :     0 :  1000.0 :  None : False : False : NonNegativeReals
          ('MidWest', 'NE') :     0 :     0.0 :  None : False : False : NonNegativeReals
          ('MidWest', 'NV') :     0 :     0.0 :  None : False : False : NonNegativeReals
          ('MidWest', 'PA') :     0 :  8000.0 :  None : False : False : NonNegativeReals
          ('MidWest', 'WA') :     0 :     0.0 :  None : False : False : NonNegativeReals
        ('NorthEast', 'FL') :     0 :     0.0 :  None : False : False : NonNegativeReals
        ('NorthEast', 'NE') :     0 :     0.0 :  None : False : False : NonNegativeReals
        ('NorthEast', 'NV') :     0 :     0.0 :  None : False : False : NonNegativeReals
        ('NorthEast', 'PA') :     0 : 17000.0 :  None : False : False : NonNegativeReals
        ('NorthEast', 'WA') :     0 :     0.0 :  None : False : False : NonNegativeReals
        ('NorthWest', 'FL') :     0 :     0.0 :  None : False : False : NonNegativeReals
        ('NorthWest', 'NE') :     0 :     0.0 :  None : False : False : NonNegativeReals
        ('NorthWest', 'NV') :     0 :  8000.0 :  None : False : False : NonNegativeReals
        ('NorthWest', 'PA') :     0 :     0.0 :  None : False : False : NonNegativeReals
        ('NorthWest', 'WA') :     0 :     0.0 :  None : False : False : NonNegativeReals
        ('SouthEast', 'FL') :     0 : 14000.0 :  None : False : False : NonNegativeReals
        ('SouthEast', 'NE') :     0 :     0.0 :  None : False : False : NonNegativeReals
        ('SouthEast', 'NV') :     0 :     0.0 :  None : False : False : NonNegativeReals
        ('SouthEast', 'PA') :     0 :     0.0 :  None : False : False : NonNegativeReals
        ('SouthEast', 'WA') :     0 :     0.0 :  None : False : False : NonNegativeReals
        ('SouthWest', 'FL') :     0 :     0.0 :  None : False : False : NonNegativeReals
        ('SouthWest', 'NE') :     0 :     0.0 :  None : False : False : NonNegativeReals
        ('SouthWest', 'NV') :     0 : 12000.0 :  None : False : False : NonNegativeReals
        ('SouthWest', 'PA') :     0 :     0.0 :  None : False : False : NonNegativeReals
        ('SouthWest', 'WA') :     0 :     0.0 :  None : False : False : NonNegativeReals

    Objectives:
      TotalCost : Size=1, Index=None, Active=True
          Key  : Active : Value
          None :   True : 268950.0

    Constraints:
      CapacityConstraint : Size=5
          Key : Lower : Body : Upper
          FL :  None :  0.0 :   0.0
          NE :  None :  0.0 :   0.0
          NV :  None :  0.0 :   0.0
          PA :  None :  0.0 :   0.0
          WA :  None :  0.0 :   0.0
      DemandConstraint : Size=5
          Key       : Lower   : Body    : Upper
            MidWest :  9000.0 :  9000.0 :  None
          NorthEast : 17000.0 : 17000.0 :  None
          NorthWest :  8000.0 :  8000.0 :  None
          SouthEast : 14000.0 : 14000.0 :  None
          SouthWest : 12000.0 : 12000.0 :  None
    ```
  ]

]

== Machine Scheduling 

#align(center)[
  #table(
    columns: (auto, auto, auto),
    align: (left, left),
    inset: 5pt,
    table.header([], [*Problem*], [*Definition*]),
    table.cell(
      rowspan: 1,
      align: horizon,
      inset: 5pt,
      [*One\ Machine*]
    ), [Single Machine\ Serial Production], [Scheduling jobs one after another on a single machine],
    table.cell(
      rowspan: 3,
      align: horizon,
      inset: 5pt,
      [*Multiple\ Machines*]
    ),
    [Multiple Parallel\ Machines], [Scheduling jobs on two or more identical machines working in parallel; each job can be assigned to any machine],
    [Flow Shop], [All jobs follow the same sequence of machines; each job visits every machine in the same order],
    [Job Shop], [Each job has its own specific sequence of machines to follow],
  )
]

- Job Splitting
  - Non-premptive problems

  Once a job starts processing on a machine, it must continue without interruption until completion

  #align(center)[
  #cetz.canvas({
    import cetz.draw: *
    import cetz-plot: *
    
    set-style(
      axes: (
        y: (stroke: 0pt),
        // x: (stroke: 0pt),
        tick: (stroke: 0pt),
        padding: 0pt,
      ),
      
    ) 

    plot.plot(
      size: (10,2),
      axis-style: "school-book",
      x-tick-step: none, 
      y-tick-step: none, 
      x-ticks: range(10).map(n => (n+1, [])),
      x-label: [],
      y-label: none,
      x-min: 1, x-max: 7,
      y-min: -1, y-max: 1,
      
      axes: (
        stroke: black,
        tick: (stroke: 0pt),
      ),
      name: "plot",
    {
      plot.add(((0,0), (3,0)), style: (stroke: none))

      plot.annotate({
        rect(
          (1.05,-0.3), 
          (4.95, 0.3), 
          fill: blue.lighten(60%),
          // radius: 1pt
        )
        content((3, 0), [1])
      })

      plot.annotate({
        rect(
          (5.05,-0.3), 
          (5.95, 0.3), 
          fill: green.lighten(60%),
          // radius: 1pt
        )
        content((5.5, 0), [2])
      })

      plot.annotate({
        rect(
          (6.05,-0.3), 
          (6.95, 0.3), 
          fill: gray.lighten(60%),
          // radius: 1pt
        )
      })
      
    }
  )
  })
]

  - Premptive problems

  A job can be interrupted and resumed later, possibly on a different machine, without losing progress

   #align(center)[
  #cetz.canvas({
    import cetz.draw: *
    import cetz-plot: *
    set-style(
      axes: (
        y: (stroke: 0pt),
        // x: (stroke: 0pt),
        tick: (stroke: 0pt),
        padding: 0pt,
      ),
      
    )

    plot.plot(
      size: (10,2),
      axis-style: "school-book",
      x-tick-step: none, 
      y-tick-step: none, 
      x-ticks: range(10).map(n => (n+1, [])),
      x-label: [],
      y-label: none,
      x-min: 1, x-max: 7,
      y-min: -1, y-max: 1,
      
      axes: (
        stroke: black,
        tick: (stroke: black),
      ),
      name: "plot",
    {
      plot.add(((0,0), (3,0)), style: (stroke: none))

      plot.annotate({
        rect(
          (1.05,-0.3), 
          (2.95, 0.3), 
          fill: blue.lighten(60%),
          // radius: 1pt
        )
        content((2, 0), [1])
      })

      plot.annotate({
        rect(
          (3.05,-0.3), 
          (3.95, 0.3), 
          fill: green.lighten(60%),
          // radius: 1pt
        )
        content((3.5, 0), [2])
      })
      
      plot.annotate({
        rect(
          (4.05,-0.3), 
          (5.95, 0.3), 
          fill: blue.lighten(60%),
          // radius: 1pt
        )
        content((5, 0), [1])
      })

      plot.annotate({
        rect(
          (6.05,-0.3), 
          (6.95, 0.3), 
          fill: gray.lighten(60%),
          // radius: 1pt
        )
      })
      
    }
  )
  })
]

- Performance Metrics

  - *Makespan*: The sum of completion times of all jobs, possibly weighted by job importance

  - *(Weighted) total completion time*: The sum of completion times of all jobs, possibly weighted by job importance (measures overall throughput)

  - *(Weighted) number of delayed jobs*: The total number of jobs completed after they are due, possibly weighted by job priority

  - *(Weighted) total lateness*: The sum of differences between each job's completion time and due date (can be negative or positive), possibly weighted

  - *(Weighted) total tardiness*: The sum of positive delays (i.e., lateness when a job finishes after its due date), possibly weighted. Negative values (early completions) are treated as zero.

  - ...

=== Single Machine Serial Production

#align(center)[
  #cetz.canvas({
    import cetz.draw: *
    import cetz-plot: *

    set-style(
      axes: (
        y: (stroke: 0pt),
        // x: (stroke: 0pt),
        tick: (stroke: 0pt),
        padding: 0pt,
      ),
      
    )

    plot.plot(
      size: (10,2),
      axis-style: "school-book",
      x-tick-step: none, 
      y-tick-step: none, 
      x-ticks: range(10).map(n => (n+1, [])),
      x-label: [],
      y-label: none,
      x-min: 1, x-max: 7,
      y-min: -1, y-max: 1,
      
      axes: (
        stroke: black,
        tick: (stroke: 0pt),
      ),
      name: "plot",
    {
      plot.add(((0,0), (3,0)), style: (stroke: none))

      plot.annotate({
        rect(
          (1.05,-0.3), 
          (2.95, 0.3), 
          fill: blue.lighten(60%),
          // radius: 1pt
        )
        content((2, 0), [3])
      })

      plot.annotate({
        rect(
          (3.05,-0.3), 
          (3.95, 0.3), 
          fill: blue.lighten(60%),
          // radius: 1pt
        )
        content((3.5, 0), [1])
      })
      
      plot.annotate({
        rect(
          (4.05,-0.3), 
          (5.95, 0.3), 
          fill: blue.lighten(60%),
          // radius: 1pt
        )
        content((5, 0), [2])
      })

      plot.annotate({
        rect(
          (6.05,-0.3), 
          (6.95, 0.3), 
          fill: gray.lighten(60%),
          // radius: 1pt
        )
      })
      
    }
  )
  })
]

*Notation*

- $n$: Total number of jobs

- $J = {1, 2, dots, n}$: Set of jobs

- $j in J$: A job

- $p_j$: processing time of job $j$

- $x_j$: completion time of job $j$

- $z_(i j) in {0, 1}$: Binary variable

$
z_(i j) = cases(
  1 quad "if job" j "is before job" i,
  0 quad "otherwise",
)
$

*Job Order Constraints*

We must ensure that either job $i$ comes before job $j$ or vice versa, but not both

If job $i$ is before job $j$ ($z_(i j) = 0$)

$
  x_j gt.eq x_i + p_j
$

If job $j$ is before job $i$ ($z_(i j) = 1$):

$
   x_i gt.eq x_j + p_i
$

These two cases can be rewritten using a big-$M$ formulation:

$
  x_i + p_j - x_j &lt.eq M z_(i j) \
  x_j + p_i - x_i &lt.eq M (1 - z_(i j))
$

Where:

- $M = sum_(j in J) p_j$

#align(center)[
  #cetz.canvas({
    import cetz.draw: *
    import cetz-plot: *

    set-style(
      axes: (
        y: (stroke: 0pt),
        // x: (stroke: 0pt),
        tick: (stroke: 0pt),
        padding: 0pt,
        x: (tick: (label: (offset: 10pt))),
      ),
      
    )

    plot.plot(
      size: (10,2),
      axis-style: "school-book",
      x-tick-step: none, 
      y-tick-step: none, 
      x-ticks: ((3, [$x_1$]), (4, [$x_2$]), (6, [$x_3$])),
      x-label: [],
      y-label: none,
      x-min: 1, x-max: 7,
      y-min: -1, y-max: 1,
      
      axes: (
        stroke: black,
        tick: (stroke: 0pt),
      ),
      name: "plot",
    {
      plot.add(((0,0), (3,0)), style: (stroke: none))

      plot.annotate({
        rect(
          (1.05,-0.3), 
          (2.95, 0.3), 
          fill: blue.lighten(60%),
          // radius: 1pt
        )
        content((2, 0), [1])
      })

      plot.annotate({
        rect(
          (3.05,-0.3), 
          (3.95, 0.3), 
          fill: blue.lighten(60%),
          // radius: 1pt
        )
        content((3.5, 0), [2])
      })
      
      plot.annotate({
        rect(
          (4.05,-0.3), 
          (5.95, 0.3), 
          fill: blue.lighten(60%),
          // radius: 1pt
        )
        content((5, 0), [3])
      })

      plot.annotate({
        rect(
          (6.05,-0.3), 
          (6.95, 0.3), 
          fill: gray.lighten(60%),
          // radius: 1pt
        )
      })
    }
  )

  cetz.decorations.flat-brace((0.1,1.5),(3.2,1.5), name: "p_1")
  cetz.draw.content(
    "p_1",
    [$p_1$],
    anchor: "south",
    padding: 1em,
  )

  cetz.decorations.flat-brace((3.5,1.5),(4.9,1.5), name: "p_2")
  cetz.draw.content(
    "p_2",
    [$p_2$],
    anchor: "south",
    padding: 1em,
  )

  cetz.decorations.flat-brace((5.2,1.5),(8.2,1.5), name: "p_3")
  cetz.draw.content(
    "p_3",
    [$p_3$],
    anchor: "south",
    padding: 1em,
  )

  })
]

*Complete Formulation*

$
  &min& quad &sum_(j in J) x_j \
  &s.t.& quad &x_i + p_j - x_j lt.eq M z_(i j) quad &forall& i in J, j in J, i lt j \
  & & &x_j + p_i - x_i lt.eq M (1 - z_(i j)) quad &forall& i in J, j in J, i lt j \
  & & &x_j gt.eq p_j quad &forall& j in J \
  & & &x_j gt.eq 0 quad &forall& j in J \
  & & &z_(i j) in {0, 1} quad &forall& i in J, j in J, i lt j \

$

*Interpretation*

If jobs are run in order $1, 2, dots, n$, the completion times are:

$
  x_1 &= p_1 \ 
  x_2 &= p_1 + p_2 \
  x_3 &= p_1 + p_2 + p_3 \
  &dots.v \ 
  x_n &= sum^n_(i=1) p_i \
$

So, the completion time of a job depends on the sum of processing times of all jobs before it in the schedule

*Optional: Release Times*

If jobs have release times $R_j$, meaning each job $j$ cannot start before $R_j$, then we add:

$
  x_j gt.eq R_j + p_j quad forall j in J
$

=== Multiple Parallel Machines

#align(center)[
  #cetz.canvas({
    import cetz.draw: *
    import cetz-plot: *

    set-style(
      axes: (
        y: (stroke: 0pt),
        // x: (stroke: 0pt),
        tick: (stroke: 0pt),
        padding: 0pt,
      ),
      
    )

    plot.plot(
      size: (10,2),
      axis-style: "school-book",
      x-tick-step: none, 
      y-tick-step: none, 
      x-ticks: range(10).map(n => (n+1, [])),
      x-label: [],
      y-label: none,
      x-min: 1, x-max: 7,
      y-min: 0, y-max: 0,
      
      axes: (
        stroke: black,
        tick: (stroke: black),
      ),
      name: "plot",
      {
        plot.add(((0,0), (0,0)), style: (stroke: none))

        plot.annotate({
          rect(
            (0.05,-0.3), 
            (2.95, 0.3), 
            fill: blue.lighten(60%),
          )
          content((1.5, 0), [1])
        })

        plot.annotate({
          rect(
            (3.05,-0.3), 
            (3.95, 0.3), 
            fill: blue.lighten(60%),
          )
          content((3.5, 0), [4])
        })

        plot.annotate({
          rect(
            (4.05,-0.3), 
            (5.95, 0.3), 
            fill: blue.lighten(60%),
          )
          content((5, 0), [7])
        })
        
        plot.annotate({
          rect(
            (6.05,-0.3), 
            (6.95, 0.3), 
            fill: gray.lighten(60%),
          )
          content((5, 0), [7])
        })
      }
    )
    group(
      {
        set-origin((0, -0.75))
        plot.plot(
          size: (10,2),
          axis-style: "school-book",
          x-tick-step: none, 
          y-tick-step: none, 
          x-ticks: range(10).map(n => (n+1, [])),
          x-label: [],
          y-label: none,
          x-min: 1, x-max: 7,
          y-min: 0, y-max: 0,
          
          axes: (
            stroke: black,
            tick: (stroke: black),
          ),
          name: "plot",
        {
          plot.add(((0,0), (0,0)), style: (stroke: none))


          plot.annotate({
            rect(
              (0.05,-0.3), 
              (1.95, 0.3), 
              fill: blue.lighten(60%),
            )
            content((1, 0), [2])
          })

          plot.annotate({
            rect(
              (2.05,-0.3), 
              (4.95, 0.3), 
              fill: blue.lighten(60%),
            )
            content((3.5, 0), [5])
          })

          plot.annotate({
            rect(
              (5.05,-0.3), 
              (6.95, 0.3), 
              fill: gray.lighten(60%),
            )
          })
          
        }
      )
      }
    )
    group(
      {
        set-origin((0, -1.5))
        plot.plot(
          size: (10,2),
          axis-style: "school-book",
          x-tick-step: none, 
          y-tick-step: none, 
          x-ticks: range(10).map(n => (n+1, [])),
          x-label: [],
          y-label: none,
          x-min: 1, x-max: 7,
          y-min: 0, y-max: 0,
          
          axes: (
            stroke: black,
            tick: (stroke: black),
          ),
          name: "plot",
        {
          plot.add(((0,0), (0,0)), style: (stroke: none))
          
          plot.annotate({
            rect(
              (0.05,-0.3), 
              (2.95, 0.3), 
              fill: blue.lighten(60%),
            )
            content((1.5, 0), [3])
          })

          plot.annotate({
            rect(
              (3.05,-0.3), 
              (5.95, 0.3), 
              fill: blue.lighten(60%),
            )
            content((4.5, 0), [6])
          })

          plot.annotate({
            rect(
              (6.05,-0.3), 
              (6.95, 0.3), 
              fill: gray.lighten(60%),
            )
          })
          
        }
      )
      }
    )
  }) 
]

We aim to assign jobs to machines such that:
  - Each job is assigned to exactly one machine.
  - A job can be processed on any machine.
  - The objective is to minimize the makespan, which is the time when the last machine finishes processing.

*Notation*

- $J = {1, 2, dots, n}$: set of jobs
- $I = {1, 2, dots, m}$: set of machines
- $p_j$: processing time of job $j in J$
- $x_(i j)$: a binary variable that indicates whether job $j$ is assigned to machine $i$:

$
  x_(i j) = cases(
    1 quad "if job" j "is assigned to machine" i,
    0 quad "otherwise"
  )
$
- The completion time of machine $i$ is the total processing time of all jobs assigned to it

$
  C_i = sum_(j in J) p_j x_(i j)
$

- The makespan $w$ is the maximum completion time accross all machines:

$
  w gt.eq sum_(j in J) p_j x_(i j) quad forall i in I
$

*Objective*

Minimize makespan $w$

*Complete Formulation*

$
  min quad &w \
  s.t. quad &sum_(j in J) p_j x_(i j) lt.eq w quad &forall& i in I \
  &sum_(i in I) x_(i j) = 1 quad &forall& j in J \
  &x_(i j) in {0, 1} quad &forall& i in I, j in J \
$

- The first constraint ensures the makespan is at least as large as each machine's workload
- The second ensures each job is assigned to one and only one machine

#code[
  ```py
from pyomo.environ import *

model = AbstractModel()

model.MACHINES = Set()
model.JOBS = Set()

model.p = Param(model.JOBS, within=PositiveReals)

model.x = Var(model.MACHINES, model.JOBS, domain=Binary)
model.w = Var(domain=NonNegativeReals)

def obj_rule(m):
    return m.w
model.Obj = Objective(rule=obj_rule, sense=minimize)

def job_assignment_rule(m, j):
    return sum(m.x[i, j] for i in m.MACHINES) == 1
model.JobAssignment = Constraint(model.JOBS, rule=job_assignment_rule)

def machine_completion_rule(m, i):
    return sum(m.p[j] * m.x[i, j] for j in m.JOBS) <= m.w
model.MachineCompletion = Constraint(model.MACHINES, rule=machine_completion_rule)
  ```
]

=== Flow Shop

#align(center)[
  #cetz.canvas({
    import cetz.draw: *
    import cetz-plot: *

    set-style(
      axes: (
        y: (stroke: 0pt),
        // x: (stroke: 0pt),
        tick: (stroke: 0pt),
        padding: 0pt,
      ),
      
    )
    plot.plot(
      size: (10,2),
      axis-style: "school-book",
      x-tick-step: none, 
      y-tick-step: none, 
      x-ticks: range(10).map(n => (n+1, [])),
      x-label: [],
      y-label: none,
      x-min: 1, x-max: 7,
      y-min: 0, y-max: 0,
      
      axes: (
        stroke: black,
        tick: (stroke: black),
      ),
      name: "plot",
      {
        plot.add(((0,0), (0,0)), style: (stroke: none))

        plot.annotate({
          rect(
            (0.05,-0.3), 
            (0.95, 0.3), 
            fill: gray.lighten(60%),
          )
        })

        plot.annotate({
          rect(
            (1.05,-0.3), 
            (1.95, 0.3), 
            fill: blue.lighten(60%),
          )
          content((1.5, 0), [1])
        })

        plot.annotate({
          rect(
            (2.05,-0.3), 
            (2.95, 0.3), 
            fill: green.lighten(60%),
          )
          content((2.5, 0), [2])
        })

        plot.annotate({
          rect(
            (3.05,-0.3), 
            (6.95, 0.3), 
            fill: gray.lighten(60%),
          )
        })
      }
    )
    group(
      {
        set-origin((0, -0.75))
        plot.plot(
          size: (10,2),
          axis-style: "school-book",
          x-tick-step: none, 
          y-tick-step: none, 
          x-ticks: range(10).map(n => (n+1, [])),
          x-label: [],
          y-label: none,
          x-min: 1, x-max: 7,
          y-min: 0, y-max: 0,
          
          axes: (
            stroke: black,
            tick: (stroke: black),
          ),
          name: "plot",
        {
          plot.add(((0,0), (0,0)), style: (stroke: none))


          plot.annotate({
            rect(
              (0.05,-0.3), 
              (1.95, 0.3), 
              fill: gray.lighten(60%),
            )
          })

          plot.annotate({
            rect(
              (2.05,-0.3), 
              (3.95, 0.3), 
              fill: blue.lighten(60%),
            )
            content((3, 0), [1])
          })
          
          plot.annotate({
            rect(
              (4.05,-0.3), 
              (5.95, 0.3), 
              fill: green.lighten(60%),
            )
            content((5, 0), [2])
          })

          plot.annotate({
            rect(
              (6.05,-0.3), 
              (6.95, 0.3), 
              fill: gray.lighten(60%),
            )
          })
          
        }
      )
      }
    )
    group(
      {
        set-origin((0, -1.5))
        plot.plot(
          size: (10,2),
          axis-style: "school-book",
          x-tick-step: none, 
          y-tick-step: none, 
          x-ticks: range(10).map(n => (n+1, [])),
          x-label: [],
          y-label: none,
          x-min: 1, x-max: 7,
          y-min: 0, y-max: 0,
          
          axes: (
            stroke: black,
            tick: (stroke: black),
          ),
          name: "plot",
        {
          plot.add(((0,0), (0,0)), style: (stroke: none))
          
          plot.annotate({
            rect(
              (0.05,-0.3), 
              (3.95, 0.3), 
              fill: gray.lighten(60%),
            )
          })

          plot.annotate({
            rect(
              (4.05,-0.3), 
              (4.95, 0.3), 
              fill: blue.lighten(60%),
            )
            content((4.5, 0), [1])
          })

          plot.annotate({
            rect(
              (5.05,-0.3), 
              (5.95, 0.3), 
              fill: gray.lighten(60%),
            )
          })

          plot.annotate({
            rect(
              (6.05,-0.3), 
              (6.95, 0.3), 
              fill: green.lighten(60%),
            )
            content((6.5, 0), [2])
          })
          
        }
      )
      }
    )
  }) 
]

=== Job Shop

== Vehicle Routing

=== Traveling Salesperson

- Let $G = (V, E)$ be a directed complete graph
- Let $d_(i j)$ be the distance (cost) from node $i$ to $j$
- Let $x_(i j)$ be a binary decision variable:
$
  x_(i j) = cases(
    1 quad "if" (i, j) "is selected",
    0 quad "otherwise"
  )
$

*Objective*

Minimize the total travel cost

$
  min sum_((i,j) in E) d_(i j) x_(i j)
$

*Constraints*

1. Flow Balancing

For node $k in V$

- One *incoming* edge:

$
  sum_(i in V, i eq.not k) = 1
$

- One *outgoing* edge:

$
  sum_(j in V, j eq.not k) = 1
$

2. Subtours

a. Miller-Tucker-Zemlin (MTZ)

- Let $u_i s$: be the position of node $i$ in the tour (e.g., $u_i = k$ if node $i$ is the $k$th node to be passed on the tour)

$
  &u_1 = 1 \
  &2 lt.eq u_i lt.eq n quad &forall& i in V \\ {1} \
  &u_i - u_j + 1 lt.eq (n-1)(1 - x_(i j)) quad &forall& (i, j) in E, i eq.not 1, j eq.not 1
$

b. Subtour Elimination Constraint (SEC)

For every subset $S subset V$ with $abs(S) gt.eq 2$:

$
  sum_(i in S, j in S\ i eq.not j) x_(i j) lt.eq abs(S) - 1 quad forall S subset V, abs(S) gt.eq 2
$

This ensures that no subset of nodes forms a closed tour independent of the main tour.

*Complete Formulation*

$
  min quad &sum_((i,j) in E) d_(i j) x_(i j) \ 
  s.t. quad &sum_(i in V, i eq.not k) = 1 quad &forall& k in V \
  &sum_(j in V, j eq.not k) = 1 quad &forall& k in V\
  &x_(i j) in {0, 1} quad &forall& (i,j) in E \
  &"MTZ or SEC"
$



