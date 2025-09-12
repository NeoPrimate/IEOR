# requires gurobipy
from gurobipy import Model, GRB
import numpy as npm

# adjacency matrix (0 = no arc)
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
source = "s"
sink = "t"

# build list of directed arcs from nonzero entries
arcs = []
cost = {}
for i,u in enumerate(nodes):
    for j,v in enumerate(nodes):
        if A[i,j] != 0:
            arcs.append((u,v))
            cost[(u,v)] = float(A[i,j])

# create model
m = Model("shortest_path")
m.setParam("OutputFlag", 1)   # set to 0 to silence Gurobi output

# decision vars: x_uv = 1 if arc (u,v) is chosen
x = {}
for (u,v) in arcs:
    x[(u,v)] = m.addVar(vtype=GRB.BINARY, name=f"x_{u}_{v}")

m.update()

# objective: minimize sum cost_uv * x_uv
m.setObjective(sum(cost[(u,v)]*x[(u,v)] for (u,v) in arcs), GRB.MINIMIZE)

# flow conservation:
# for each node: sum_out - sum_in = b(node) where b(s)=1, b(t)=-1, others 0
b = {node: 0 for node in nodes}
b[source] = 1
b[sink]   = -1

for node in nodes:
    out_expr = sum(x[(u,v)] for (u,v) in arcs if u==node)
    in_expr  = sum(x[(u,v)] for (u,v) in arcs if v==node)
    m.addConstr(out_expr - in_expr == b[node], name=f"flow_{node}")

m.optimize()

# print objective and selected arcs
if m.status == GRB.OPTIMAL:
    print("Objective (shortest distance) =", m.objVal)
    chosen_arcs = [arc for arc in arcs if x[arc].X > 0.5]
    print("Chosen arcs:", chosen_arcs)

    # reconstruct path from source to sink
    path = [source]
    current = source
    visited = set([source])
    while current != sink:
        next_arcs = [v for (u,v) in chosen_arcs if u == current]
        if not next_arcs:
            print("Could not reconstruct full path (broken selection).")
            break
        # choose the unique next node
        nxt = next_arcs[0]
        if nxt in visited:
            print("Cycle detected while reconstructing path.")
            break
        path.append(nxt)
        visited.add(nxt)
        current = nxt

    print("Path:", " -> ".join(path))

else:
    print("No optimal solution found. Status:", m.status)

#######
### 1
#######

# The path 0BADT does not exist
# 13
# No cycle

#######
### 2
#######

# 13

#######
### 3
#######

# 11

#######
### 4 
#######

# x_DT = 4 ❌
# None of the above ❌
# x_BC = 1

#######
### 5
#######

# Both A and B are totally unimodular

