# planning_bc_gurobi.py
import numpy as np
import gurobipy as gp
from gurobipy import GRB

A = np.array([[0.1, 0.2],
              [0.3, 0.1]], dtype=float)

l = np.array([2.0, 5.0])

L = 100.0

w = np.array([1.0, 1.0])

n = 2

m = gp.Model("Labor_Planning")

x = m.addMVar(shape=n, lb=0.0, name="x")

d = m.addMVar(shape=n, lb=0.0, name="d")

I = np.eye(n)

for i in range(n):
    m.addConstr(x[i] >= A[i, :] @ x + d[i], name=f"balance_{i}")

m.addConstr(l @ x <= L, name="labor")

m.setObjective(w @ d, GRB.MAXIMIZE)

m.setParam("OutputFlag", 1)   # set to 0 to suppress solver output
m.optimize()

if m.status == GRB.OPTIMAL:
    x_vals = x.X
    d_vals = d.X
    print("\nOptimal solution:")
    print(f"  x_B (Bread total production):   {x_vals[0]:.4f}")
    print(f"  x_C (Clothes total production): {x_vals[1]:.4f}")
    print(f"  d_B (Bread delivered):          {d_vals[0]:.4f}")
    print(f"  d_C (Clothes delivered):        {d_vals[1]:.4f}")
    print(f"Objective (weighted demand met): {m.objVal:.4f}")
else:
    print("Model status:", m.status)

