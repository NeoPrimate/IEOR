#import "../../../utils/examples.typ": eg
#import "../../../utils/code.typ": code

== IP (Integer Programming)

Optimizing (maximizing or minimizing) a linear *objective function* subject to linear equality or inequality *constraints*. *Decision variables* can take any integer real values.

Minimize or Maximize

$
c^T x
$

s.t.

$
A x ≤ b
$

and

$
x in ZZ^n
$

Where
- $x$: vector of decision variables
- $c$: vector of coefficients for the objective function
- $A$: matrix of contraint coefficients
- $b$: vector of constraint constants
- $x in ZZ^n$: each $x_i$ of $x$ must be integer values

#eg[
You are organizing a small event and want to minimize costs. You have to decide how many chairs and tables to rent.

- Each chair ($x_1$) costs \$5, each table ($x_2$) costs \$20.
- You need at least 3 tables and 10 chairs.
- Your budget is \$100.

You can only rent whole numbers of chairs and tables.

Minimize

$
5 x_1 + 20 x_2
$

s.t.

$
x_1 &≥ 10 \
x_2 &≥ 3 \
5 x_1 + 20 x_2 &≤ 100
$

$
x_1, x_2 in ZZ^+
$
]

#code[
```py
import pulp

# Create a linear programming problem instance
# We are minimizing the cost
prob = pulp.LpProblem("Minimize_Cost", pulp.LpMinimize)

# Define decision variables
# x1 is the number of chairs
# x2 is the number of tables
x1 = pulp.LpVariable("x1", lowBound=10, cat='Integer')
x2 = pulp.LpVariable("x2", lowBound=3, cat='Integer')

# Objective function: Minimize 5*x1 + 20*x2
prob += 5 * x1 + 20 * x2, "Total_Cost"

# No additional constraints in this example, as the bounds cover the requirements

# Solve the problem
prob.solve()

# Print the results
print(f"Status: {pulp.LpStatus[prob.status]}")
print(f"Number of chairs (x1): {x1.varValue}")
print(f"Number of tables (x2): {x2.varValue}")
print(f"Total cost: {pulp.value(prob.objective)}")

```
]