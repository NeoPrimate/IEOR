from gurobipy import Model, GRB, quicksum
import numpy as np

# adjacency matrix (capacity matrix)
A = np.array([
    [0, 2, 5, 4, 0, 0, 0],  # s
    [0, 0, 2, 0, 7, 0, 0],  # A
    [0, 0, 0, 1, 4, 3, 0],  # B
    [0, 0, 0, 0, 0, 4, 0],  # C
    [0, 0, 0, 0, 0, 1, 5],  # D
    [0, 0, 0, 0, 0, 0, 7],  # E
    [0, 0, 0, 0, 0, 0, 0],  # t
], dtype=float)

nodes = ["s","A","B","C","D","E","t"]
n = len(nodes)
source, sink = "s", "t"

# build arcs with capacities
arcs = []
cap = {}
for i,u in enumerate(nodes):
    for j,v in enumerate(nodes):
        if A[i,j] > 0:
            arcs.append((u,v))
            cap[(u,v)] = A[i,j]

# create model
m = Model("max_flow")
m.setParam("OutputFlag", 0)  # silence solver output

# flow vars
f = {}
for (u,v) in arcs:
    f[(u,v)] = m.addVar(lb=0, ub=cap[(u,v)], name=f"f_{u}_{v}")

m.update()

# flow conservation
for node in nodes:
    if node in [source, sink]:
        continue
    inflow  = quicksum(f[(u,v)] for (u,v) in arcs if v == node)
    outflow = quicksum(f[(u,v)] for (u,v) in arcs if u == node)
    m.addConstr(inflow == outflow, name=f"flow_{node}")

# objective: maximize total out of source
m.setObjective(quicksum(f[(u,v)] for (u,v) in arcs if u == source), GRB.MAXIMIZE)

m.optimize()

if m.status == GRB.OPTIMAL:
    print("Max flow value:", m.objVal)
    print("Arc flows:")
    for (u,v) in arcs:
        if f[(u,v)].X > 1e-6:  # print only positive flows
            print(f"{u} -> {v}: {f[(u,v)].X} / {cap[(u,v)]}")
