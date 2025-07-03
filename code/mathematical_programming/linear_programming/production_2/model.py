from pyomo.environ import *
from pyomo.dataportal import DataPortal

model = AbstractModel()

# Sets
model.Products = Set()
model.Materials = Set()

# Parameters
model.Profit = Param(model.Products)
model.Supply = Param(model.Materials)
model.Consumption = Param(model.Materials, model.Products)

# Variables
model.x = Var(model.Products, domain=NonNegativeReals)

# Objective: Maximize profit
def objective_rule(model):
    return sum(model.Profit[j] * model.x[j] for j in model.Products)
model.OBJ = Objective(rule=objective_rule, sense=maximize)

# Constraints: Do not exceed resource supply
def constraint_rule(model, i):
    return sum(model.Consumption[i, j] * model.x[j] for j in model.Products) <= model.Supply[i]
model.ResourceConstraint = Constraint(model.Materials, rule=constraint_rule)

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