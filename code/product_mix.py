import gurobipy as gp
from gurobipy import GRB
import numpy as np

products = ["table", "chair"]
bom = np.array([[2, 1],
                [2, 2]])
capacity = np.array([6, 8])
price = np.array([20.00, 15.00])

m = gp.Model("product_mix")
x = m.addMVar(shape=price.size, lb=0.0, name=products)

m.setObjective(price @ x, GRB.MAXIMIZE)
cap = m.addConstr(bom @ x <= capacity, name="capacity")

m.optimize()

if m.Status == GRB.OPTIMAL:
    obj = x.Obj
    inc = x.SAObjUp - obj
    dec = obj - x.SAObjLow

    print(f"Objective = {m.ObjVal:.2f}\n")

    print(f"{'Var':6} {'Value':>7} {'Obj':>7} {'Inc':>7} {'Dec':>7} {'RC':>7}")
    for row in zip(x.VarName, x.X, obj, inc, dec, x.RC):
        print(f"{row[0]:6} " + " ".join(f"{v:7.2f}" for v in row[1:]))

    print(f"\n{'Constr':12} {'Slack':>7} {'Dual':>7} {'RHS lo':>7} {'RHS hi':>7}")
    for row in zip(cap.ConstrName, cap.Slack, cap.Pi, cap.SARHSLow, cap.SARHSUp):
        print(f"{row[0]:12} " + " ".join(f"{v:7.2f}" for v in row[1:]))