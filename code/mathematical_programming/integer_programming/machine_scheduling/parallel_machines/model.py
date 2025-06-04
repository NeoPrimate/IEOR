from pyomo.environ import *
from pyomo.dataportal import DataPortal

# Define model
model = AbstractModel()

model.MACHINES = Set()
model.JOBS = Set()

model.p = Param(model.JOBS, within=PositiveReals)

model.x = Var(model.MACHINES, model.JOBS, domain=Binary)
model.w = Var(domain=NonNegativeReals)

def obj_rule(m):
    return m.w
model.Obj = Objective(rule=obj_rule, sense=minimize)

def job_assignment_rule(m, j):
    return sum(m.x[i, j] for i in m.MACHINES) == 1
model.JobAssignment = Constraint(model.JOBS, rule=job_assignment_rule)

def machine_completion_rule(m, i):
    return sum(m.p[j] * m.x[i, j] for j in m.JOBS) <= m.w
model.MachineCompletion = Constraint(model.MACHINES, rule=machine_completion_rule)

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