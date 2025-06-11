from pyomo.environ import *
from pyomo.dataportal import DataPortal

model = AbstractModel()

# Sets
model.Days = Set(ordered=True)           # Days 1..7 (Mon..Sun)
model.Shifts = Set(ordered=True)         # Shifts starting on days 1..7

# Parameters
model.Demand = Param(model.Days)         # Daily staffing requirements
model.Cover = Param(model.Days, model.Shifts, within=Binary)  # Coverage matrix (1 if shift j covers day i)

# Variables
model.x = Var(model.Shifts, domain=NonNegativeReals)

# Objective: Minimize total employees hired
def obj_rule(model):
    return sum(model.x[s] for s in model.Shifts)
model.OBJ = Objective(rule=obj_rule, sense=minimize)

# Constraints: Cover daily demand
def demand_rule(model, d):
    return sum(model.Cover[d, s] * model.x[s] for s in model.Shifts) >= model.Demand[d]
model.DemandConstraint = Constraint(model.Days, rule=demand_rule)

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