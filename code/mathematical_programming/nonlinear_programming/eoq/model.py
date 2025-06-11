from pyomo.environ import *
from pyomo.dataportal import DataPortal

model = AbstractModel()

# Parameters
model.D = Param(within=NonNegativeReals)   # Annual demand
model.K = Param(within=NonNegativeReals)   # Ordering cost per order
model.h = Param(within=NonNegativeReals)   # Holding cost per unit per year
model.p = Param(within=NonNegativeReals)   # Purchasing cost per unit

# Decision variable
model.Q = Var(within=NonNegativeReals, bounds=(1e-6, None))  # Order quantity (positive to avoid division by zero)

# Objective: Minimize total annual cost
def total_cost_rule(m):
    return (m.K * m.D) / m.Q + m.p * m.D + (m.h * m.Q) / 2
model.TotalCost = Objective(rule=total_cost_rule, sense=minimize)

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