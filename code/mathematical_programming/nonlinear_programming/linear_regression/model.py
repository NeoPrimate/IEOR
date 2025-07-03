from pyomo.environ import *

model = AbstractModel()

# Index set for data points
model.I = Set()

# Parameters: input x and output y
model.x = Param(model.I)
model.y = Param(model.I)

# Decision variables: intercept and slope
model.beta0 = Var()
model.beta1 = Var()

# Expression for predicted value
def prediction_expr(model, i):
    return model.beta0 + model.beta1 * model.x[i]
model.yhat = Expression(model.I, rule=prediction_expr)

# Expression for squared error
def squared_error_expr(model, i):
    return (model.y[i] - model.yhat[i])**2
model.sq_error = Expression(model.I, rule=squared_error_expr)

# Objective: minimize sum of squared errors
def obj_rule(model):
    return sum(model.sq_error[i] for i in model.I)
model.obj = Objective(rule=obj_rule, sense=minimize)

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