from pyomo.environ import *
from pyomo.environ import value

# 1

model = ConcreteModel()

model.x = Var([1,2], domain=NonNegativeReals)

model.OBJ = Objective(expr = 2*model.x[1] - model.x[2], sense=maximize)

model.Constraint1 = Constraint(expr = 8*model.x[1] - 4*model.x[2] <= 16)
model.Constraint2 = Constraint(expr = 3*model.x[1] - 4*model.x[2] <= 12)
model.Constraint3 = Constraint(expr = model.x[1] >= 0)
model.Constraint4 = Constraint(expr = model.x[2] <= 0)

solver = SolverFactory('glpk')

model.rc = Suffix(direction=Suffix.IMPORT)

result = solver.solve(model, tee=True)

model.pprint()
print("Objective value =", value(model.OBJ))

for v in model.component_objects(Var, active=True):
    vobj = getattr(model, v.name)
    for index in vobj:
        print(f"{v.name}[{index}] = {vobj[index].value}")


for c in model.component_objects(Constraint, active=True):
    cdata = getattr(model, c.name)
    for index in cdata:
        body = value(cdata[index].body)
        lb = cdata[index].lower
        ub = cdata[index].upper

        lb_val = value(lb) if lb is not None else None
        ub_val = value(ub) if ub is not None else None

        is_binding = False
        if lb_val is not None and abs(body - lb_val) < 1e-6:
            print(f"{c.name}[{index}] is binding at lower bound ({lb_val})")
            is_binding = True
        if ub_val is not None and abs(body - ub_val) < 1e-6:
            print(f"{c.name}[{index}] is binding at upper bound ({ub_val})")
            is_binding = True
        if not is_binding:
            print(f"{c.name}[{index}] is not binding (body = {body}, bounds = [{lb_val}, {ub_val}])")

rcs = []
for v in model.component_objects(Var, active=True):
    varobj = getattr(model, v.name)
    for idx in varobj:
        rc = model.rc.get(varobj[idx], None)
        val = varobj[idx].value
        rcs.append(rc)
        print(f"{v.name}[{idx}] = {val}, reduced cost = {rc}")

if any(rc == 0 for rc in rcs):
    print("Multiple Optimal Solutions")
else:
    print("Single Optimal Solution")

# The LP has multiple optimal solutions
# The constraints 8x1 - 4x2 ≤ 16 and x2 ≤ 0 are binding at (x1, x2) = (2, 0)

# 2

# TFFTF

# 3


model = ConcreteModel()

model.x = Var([1,2], domain=NonNegativeReals)

model.OBJ = Objective(expr = 3*model.x[1] + 5*model.x[2], sense=maximize)

model.Constraint1 = Constraint(expr = model.x[1] + model.x[2] <= 16)
model.Constraint2 = Constraint(expr = model.x[1] + 4*model.x[2] <= 20)
model.Constraint3 = Constraint(expr = 2*model.x[1] + model.x[2] >= 6)
model.Constraint4 = Constraint(expr = model.x[1] >= 0)
model.Constraint5 = Constraint(expr = model.x[2] >= 0)

solver = SolverFactory('glpk')


result = solver.solve(model, tee=True)

model.pprint()
print("Objective value =", value(model.OBJ))

for v in model.component_objects(Var, active=True):
    vobj = getattr(model, v.name)
    for index in vobj:
        print(f"{v.name}[{index}] = {vobj[index].value}")

for c in model.component_objects(Constraint, active=True):
    cdata = getattr(model, c.name)
    for index in cdata:
        body = value(cdata[index].body)
        lb = cdata[index].lower
        ub = cdata[index].upper

        lb_val = value(lb) if lb is not None else None
        ub_val = value(ub) if ub is not None else None

        is_binding = False
        if lb_val is not None and abs(body - lb_val) < 1e-6:
            print(f"{c.name}[{index}] is binding at lower bound ({lb_val})")
            is_binding = True
        if ub_val is not None and abs(body - ub_val) < 1e-6:
            print(f"{c.name}[{index}] is binding at upper bound ({ub_val})")
            is_binding = True
        if not is_binding:
            print(f"{c.name}[{index}] is not binding (body = {body}, bounds = [{lb_val}, {ub_val}])")

# x[1] = 44/3
# x[2] = 4/3

# (16, 0)

# 4 & 5

# Wood: 
#   Cost: 13 $ / unit
#   Max Supply: 50 units

# Table (x1)
#   Sale Price: 100 $ / unit
#   Requirement: 7 units / unit
#       Profit: 100 - (7 * 13) = 9
#   Labor: 1.1 unit / h

# Chair (x2)
#   Sale Price: 70 $ / unit
#   Requirement: 4 units / unit
#       Profit: 70 - (4 * 13) = 18
#   Labor: 0.7 unit / h

# Max Labor Time: 10h

# A = 9
# B = 1/11
# C = 1/0.7

model = ConcreteModel()

model.x = Var([1,2], domain=NonNegativeReals)

model.OBJ = Objective(expr = 9*model.x[1] + 18*model.x[2], sense=maximize)

model.Constraint1 = Constraint(expr = 7*model.x[1] + 4*model.x[2] <= 50)
model.Constraint2 = Constraint(expr = 70*model.x[1] + 110*model.x[2] <= 770)
model.Constraint3 = Constraint(expr = model.x[1] >= 0)
model.Constraint4 = Constraint(expr = model.x[2] >= 0)

solver = SolverFactory('glpk')

result = solver.solve(model, tee=True)

model.pprint()
print("Objective value =", value(model.OBJ))

for v in model.component_objects(Var, active=True):
    vobj = getattr(model, v.name)
    for index in vobj:
        print(f"{v.name}[{index}] = {vobj[index].value}")

for c in model.component_objects(Constraint, active=True):
    cdata = getattr(model, c.name)
    for index in cdata:
        body = value(cdata[index].body)
        lb = cdata[index].lower
        ub = cdata[index].upper

        lb_val = value(lb) if lb is not None else None
        ub_val = value(ub) if ub is not None else None

        is_binding = False
        if lb_val is not None and abs(body - lb_val) < 1e-6:
            print(f"{c.name}[{index}] is binding at lower bound ({lb_val})")
            is_binding = True
        if ub_val is not None and abs(body - ub_val) < 1e-6:
            print(f"{c.name}[{index}] is binding at upper bound ({ub_val})")
            is_binding = True
        if not is_binding:
            print(f"{c.name}[{index}] is not binding (body = {body}, bounds = [{lb_val}, {ub_val}])")

# 7
