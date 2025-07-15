from pyomo.environ import *

# #################################
# ### PHASE I
# #################################

model = ConcreteModel()

# Define variables
model.x1 = Var(domain=NonNegativeReals)
model.x2p = Var(domain=NonNegativeReals)  # x'_2
model.x2pp = Var(domain=NonNegativeReals)  # x''_2
model.s1 = Var(domain=NonNegativeReals)
model.s2 = Var(domain=NonNegativeReals)
model.s3 = Var(domain=NonNegativeReals)
model.a1 = Var(domain=NonNegativeReals)
model.a2 = Var(domain=NonNegativeReals)
model.a3 = Var(domain=NonNegativeReals)

# Objective: Minimize sum of artificial variables
model.obj = Objective(expr=model.a1 + model.a2 + model.a3, sense=minimize)

# Constraints
model.c1 = Constraint(expr=model.x1 + model.x2p - model.x2pp + model.s1 == 1)
model.c2 = Constraint(expr=2*model.x1 - model.x2p + model.x2pp - model.s2 + model.a1 == 2)
model.c3 = Constraint(expr= model.x1 - 3*model.x2p + 3*model.x2pp - model.s3 + model.a2 == 1)
model.c4 = Constraint(expr=model.x1 - model.x2p + model.x2pp + model.a3 == 1)


# Solve
solver = SolverFactory('glpk')
result = solver.solve(model, tee=True)

# Results
print(f"x1 = {model.x1.value}")
print(f"x2p = {model.x2p.value}")
print(f"x2pp = {model.x2pp.value}")

print(f"x2 = x2p - x2pp = {model.x2p.value - model.x2pp.value}")

print(f"s1 = {model.s1.value}")
print(f"s2 = {model.s2.value}")
print(f"s3 = {model.s3.value}")

print(f"a1 = {model.a1.value} {'✅' if model.a1.value == 0 else '❌'}")
print(f"a2 = {model.a2.value} {'✅' if model.a2.value == 0 else '❌'}")
print(f"a3 = {model.a3.value} {'✅' if model.a3.value == 0 else '❌'}")
print(f"Phase I objective = {model.obj()} {'Feasible ✅' if model.obj() == 0 else 'Infeasible ❌'}")

#################################
### PHASE II
#################################

model = ConcreteModel()

# Variables
model.x1 = Var(domain=NonNegativeReals)  # x1 >= 0
model.x2 = Var(domain=Reals)             # x2 unrestricted

# Objective
model.obj = Objective(expr=model.x1 + 2*model.x2, sense=minimize)

# Constraints
model.c1 = Constraint(expr=model.x1 + model.x2 <= 1)          # slack constraint
model.c2 = Constraint(expr=2*model.x1 - model.x2 >= 2)        # surplus + artificial
model.c3 = Constraint(expr=-model.x1 + 3*model.x2 <= -1)      # negative RHS
model.c4 = Constraint(expr=model.x1 - model.x2 == 1)          # equality

# Solve
solver = SolverFactory('glpk')
result = solver.solve(model, tee=True)

# Print results
print(f"x1 = {model.x1.value}")
print(f"x2 = {model.x2.value}")
print(f"Objective = {model.obj()}")

# Display results
model.display()
