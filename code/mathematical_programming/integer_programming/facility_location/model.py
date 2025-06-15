from pyomo.environ import *
from pyomo.dataportal import DataPortal

model = AbstractModel()

# Sets
model.I = Set(doc='Regions (demand points)')
model.J = Set(doc='Candidate distribution centers')

# Parameters
model.D = Param(model.I, within=NonNegativeReals, doc='Demand at region i')
model.K = Param(model.J, within=NonNegativeReals, doc='Capacity at distribution center j')
model.f = Param(model.J, within=NonNegativeReals, doc='Fixed cost to open center j')
model.c = Param(model.I, model.J, within=NonNegativeReals, doc='Shipping cost from j to i')

# Decision Variables
model.x = Var(model.J, within=Binary, doc='1 if center j is opened')
model.y = Var(model.I, model.J, within=NonNegativeReals, doc='Units shipped from j to i')

# Objective Function: Minimize total cost
def total_cost_rule(model):
    fixed = sum(model.f[j] * model.x[j] for j in model.J)
    shipping = sum(model.c[i, j] * model.y[i, j] for i in model.I for j in model.J)
    return fixed + shipping
model.TotalCost = Objective(rule=total_cost_rule, sense=minimize)

# Constraints

# Capacity Constraint: Total shipped from center ≤ capacity if opened
def capacity_rule(model, j):
    return sum(model.y[i, j] for i in model.I) <= model.K[j] * model.x[j]
model.CapacityConstraint = Constraint(model.J, rule=capacity_rule)

# Demand Constraint: Total received by region ≥ its demand
def demand_rule(model, i):
    return sum(model.y[i, j] for j in model.J) >= model.D[i]
model.DemandConstraint = Constraint(model.I, rule=demand_rule)

# Load data from .dat file
data = DataPortal()
data.load(filename='data.dat', model=model)

# Create an instance of the model
instance = model.create_instance(data)

# Create solver
solver = SolverFactory('glpk')
solver.options['tmlim'] = 60

# Solve with solver timeout (optional)
results = solver.solve(instance, tee=True)

# Display results
instance.display()