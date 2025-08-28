import gurobipy as gp
from gurobipy import GRB
import numpy as np

# Input-output coefficients (A matrix)
A = np.array([
    [0.1, 0.2, 0.1],
    [0.1, 0.1, 0.2],
    [0.2, 0.1, 0.1]
])

# Final demand vector
d = np.array([10, 20, 30])

n = len(d)

# Model
m = gp.Model("InputOutput")

# Decision variables: total output of each sector
x = m.addMVar(n, lb=0, name="x")

# Input-output balance constraints: x >= A*x + d
m.addConstr(x >= A @ x + d, name="balance")

# Objective: minimize total production (feasible plan with least output)
m.setObjective(x.sum(), GRB.MINIMIZE)

# Solve
m.optimize()

if m.status == GRB.OPTIMAL:
    print("\nOptimal production plan:")
    for i, sector in enumerate(["Steel", "Rubber", "Chemicals"]):
        print(f"{sector}: {x[i].X:.2f}")
print(f"Objective value (total demand met): {m.objVal}")