from pyomo.environ import *


### 1 ✅

model = ConcreteModel()

# Define variables
model.x1 = Var(domain=NonNegativeReals)
model.x2 = Var(domain=NonNegativeReals)

# Objective: Minimize sum of artificial variables
model.obj = Objective(expr=3*model.x1 + 5*model.x2, sense=maximize)

# Constraints
model.c1 = Constraint(expr=model.x1 + model.x2 <= 16)
model.c2 = Constraint(expr=model.x2 <= 7.5)


# Solve
solver = SolverFactory('glpk')
result = solver.solve(model, tee=True)

# Results
print(f"x1 = {model.x1.value}")
print(f"x2 = {model.x2.value}")
print(f"Obj = {model.obj()}")

# 8.5, 7.5 ✅

### 2 

# x_1 lt.eq 8 and x_1 gt.eq 9 ✅

### 3 

# 9, 7 ✅

model = ConcreteModel()

# Define variables
model.x1 = Var(domain=NonNegativeIntegers)
model.x2 = Var(domain=NonNegativeIntegers)

# Objective: Minimize sum of artificial variables
model.obj = Objective(expr=3*model.x1 + 5*model.x2, sense=maximize)

# Constraints
model.c1 = Constraint(expr=model.x1 + model.x2 <= 16)
model.c2 = Constraint(expr=model.x2 <= 7.5)

# Solve
solver = SolverFactory('glpk')
result = solver.solve(model, tee=True)

# Results
print(f"x1 = {model.x1.value}")
print(f"x2 = {model.x2.value}")
print(f"Obj = {model.obj()}")

### 4 

jobs = {
    1: 7, 2: 4, 3: 6, 4: 9, 5: 12, 6: 6, 7: 10, 8: 11,
    9: 8, 10: 7, 11: 6, 12: 8, 13: 15, 14: 14, 15: 3
}

# Sort jobs by descending processing time, tie-break by job ID
sorted_jobs = sorted(jobs.items(), key=lambda x: (-x[1], x[0]))

machines = {1: 0, 2: 0, 3: 0}

# Assign each job to the machine with the smallest current load
for job, duration in sorted_jobs:
    min_machine = min(machines, key=lambda m: machines[m])
    machines[min_machine] += duration

print(machines)

# Compute makespan
makespan = max(machines.values())
print(f"Makespan: {makespan}")


# 47 ❌
# 43

### 5

z_lb = sum(jobs.values()) / len(machines)
print(f"z_lb: {z_lb}")

z_alg = max(machines.values())
print(f"z_alg: {z_alg}")

op_gap = (z_alg - z_lb) / z_lb * 100
print(f"Optimality gap: {op_gap:.2f}%") 

# 10 ❌
# 2

