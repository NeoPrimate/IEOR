#import "../../../utils/examples.typ": eg
#import "../../../utils/code.typ": code

== LP (Linear Programming)

Optimizing (maximizing or minimizing) a linear *objective function* subject to linear equality or inequality *constraints*. *Decision variables* can take any continuous real values.

1. Objective Function

Maximize:

$
Z = c_1 x_1 + c_2 x_2 + ... + c_n x_n
$

Or, equivalently:

$
Z = c^T x = sum_(i=1)^n c_i x_i
$

Where:

- $Z$: Objective Function
- $c_1, c_2, ..., c_n$: Coefficients
- $x_1, x_2, ..., x_n$: Decision Variables

2. Constraints

$
a_(11) x_1 + a_(12) x_2 + ... + a_(1n) x_n &≤ b_1 \
a_(21) x_1 + a_(22) x_2 + ... + a_(2n) x_n &≤ b_2 \
\ 
dots.v
\
a_(m 1) x_1 + a_(m 2) x_2 + ... + a_(m n) x_n &≤ b_2 \
$

Or, in matrix form:

$
A x ≤ b
$

Where:

- $A$: $m times n$ matrix of coefficients $a_(i j)$
- $x = (x_1, x_2, ..., x_n)^T$: vector of decision variables
- $b = (b_1, b_2, ..., b_m)^T$: vector of known constants

3. Non-Nagativity Constraints

$
x_i ≥ 0 "for" i = 1, 2, ..., n
$

#eg[

1. Problem

A company produces two products: $x_1$ (Product A) and $x_2$ (Product B). The company wants to maximize profit, where:

- Each unit of Product A gives a profit of \$40.
- Each unit of Product B gives a profit of \$30.

The company has constraints on the production process:

- It takes 2 hours of labor to produce one unit of Product A and 1 hour to produce one unit of Product B. The company has a maximum of 100 labor hours available.
- The company can only use up to 80 units of raw material, and each unit of Product A uses 1 unit of material, while Product B uses 2 units of material.

The goal is to decide how many units of Product A ($x_1$) and Product B ($x_2$) to produce to maximize profit.

2. Formulation:
*Objective Function* (maximize the profit):

$
Z = 40 x_1 + 30 x_2
$

*Constraints*
1. Labor (maximum 100 hours):

$
2 x_1 + x_2 ≤ 100
$

2. Raw material (maximum 60 units):

$
x_1 + 2 x_2 ≤ 80
$

3. Non-negativity (can't produce nagtive quantities):

$
x_1 ≥ 0
$

$
x_2 ≥ 0
$

4. Summary

Maximize:

$
Z = 40 x_1 + 30 x_2
$

s.t.

$
2 x_1 + x_2 &≤ 100 \
x_1 + 2 x_2 &≤ 80 \
x_1 &≥ 0 \
x_2 &≥ 0 \
$

#figure(image("../../../vis/linear_programming.png", width: 80%))

]

#code[
```py
import pulp

# Initialize the problem
prob = pulp.LpProblem("Maximize Profit", pulp.LpMaximize)

# Define decision variables
x1 = pulp.LpVariable('x1', lowBound=0, cat='Continuous')  # Product A
x2 = pulp.LpVariable('x2', lowBound=0, cat='Continuous')  # Product B

# Objective function: Maximize 40*x1 + 30*x2
prob += 40 * x1 + 30 * x2, "Total Profit"

# Constraints
prob += 2 * x1 + x2 <= 100, "Labor Constraint"
prob += x1 + 2 * x2 <= 80, "Material Constraint"

# Solve the problem
prob.solve()

# Print the results
print("Status:", pulp.LpStatus[prob.status])
print(f"Optimal x1 (Product A): {pulp.value(x1)}")
print(f"Optimal x2 (Product B): {pulp.value(x2)}")
print(f"Maximum Profit: {pulp.value(prob.objective)}")
```
]