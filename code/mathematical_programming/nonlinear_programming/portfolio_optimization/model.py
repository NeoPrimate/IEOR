from pyomo.environ import *
from pyomo.dataportal import DataPortal

model = AbstractModel()

# Sets
model.Assets = Set()

# Parameters
model.p = Param(model.Assets)       # Current price per asset
model.mu = Param(model.Assets)      # Expected future price
model.sigma2 = Param(model.Assets)  # Variance of return per share
model.B = Param()                   # Total budget
model.R = Param()                   # Minimum expected return

# Decision variables
model.x = Var(model.Assets, domain=NonNegativeReals)

# Objective: Minimize total variance (risk)
def risk_objective(model):
    return sum(model.sigma2[i] * model.x[i]**2 for i in model.Assets)
model.Obj = Objective(rule=risk_objective, sense=minimize)

# Budget constraint
def budget_constraint(model):
    return sum(model.p[i] * model.x[i] for i in model.Assets) <= model.B
model.BudgetConstraint = Constraint(rule=budget_constraint)

# Expected return constraint
def return_constraint(model):
    return sum(model.mu[i] * model.x[i] for i in model.Assets) >= model.R
model.ReturnConstraint = Constraint(rule=return_constraint)

# Load data from .dat file
data = DataPortal()
data.load(filename='data.dat', model=model)

# Create an instance of the model
instance = model.create_instance(data)

# Create solver
solver = SolverFactory('ipopt')

# Solve with solver timeout (optional)
results = solver.solve(instance, tee=True, timelimit=60)


# Display results
instance.display()