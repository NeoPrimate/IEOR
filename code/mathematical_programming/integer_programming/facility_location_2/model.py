import gurobipy as gp
from gurobipy import GRB
import numpy as np

# Data

# n = 8
# m = 2
# d = np.array([
#     [0,3,4,6,8,9,8,10],
#     [3,0,5,4,8,6,12,9],
#     [4,5,0,2,2,3,5,7],
#     [6,4,2,0,3,2,5,4],
#     [8,8,2,3,0,2,2,4],
#     [9,6,3,2,2,0,3,2],
#     [8,12,5,5,2,3,0,2],
#     [10,9,7,4,4,2,2,0]  # Adjusted if needed
# ])
# p = np.array([40,30,35,20,15,50,45,60])

n = 4
m = 3
d = np.array([
    [0,3,4,1],
    [3,0,5,8],
    [4,5,0,1],
    [1,8,1,0],
])

p = np.array([40,30,35,5])

# Model
model = gp.Model()

# Variables
x = model.addVars(n, vtype=GRB.BINARY, name="x")
y = model.addVars(n, n, vtype=GRB.BINARY, name="y")
w = model.addVars(n, vtype=GRB.CONTINUOUS, name="w")
z = model.addVar(vtype=GRB.CONTINUOUS, name="z")

# Constraints
model.addConstr(x.sum() == m)  # Exactly m ambulances
for i in range(n):
    model.addConstr(gp.quicksum(y[i,j] for j in range(n)) == 1)  # Each district assigned
    for j in range(n):
        model.addConstr(y[i,j] <= x[j])  # Only assign to ambulance location
    model.addConstr(w[i] >= gp.quicksum(d[i,j]*y[i,j] for j in range(n)))  # Distance to closest
    model.addConstr(p[i]*w[i] <= z)  # Max population-weighted time

# Objective
model.setObjective(z, GRB.MINIMIZE)

# Solve
model.optimize()

# Results
ambulance_locations = [j+1 for j in range(n) if x[j].x > 0.5]
min_max_time = z.x

print("Ambulances should be located in districts:", ambulance_locations)
print("Minimized maximum population-weighted firefighting time:", min_max_time)
