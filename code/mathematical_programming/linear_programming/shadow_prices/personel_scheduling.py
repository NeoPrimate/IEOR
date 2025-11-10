from gurobipy import *
import pandas as pd

df = pd.DataFrame({
    "weekday": ["mon", "tue", "wed", "thu", "fri", "sat", "sun"],
    "people_needed": [110, 80, 150, 30, 70, 160, 120],
})

def personnel_scheduling(day_limitations):
    people = range(7)
    days = range(7)

    m = Model("Personnel_Scheduling")

    x = [m.addVar(lb=0, vtype=GRB.CONTINUOUS, name=f"x_{i}") for i in people]

    m.setObjective(quicksum(x[i] for i in people), GRB.MINIMIZE)

    m.addConstrs((quicksum(x[i + j - 7] for i in range(3, 8))  
                  >= day_limitations[j] for j in days), "Resource_Limitation")

    m.optimize()

    for var in m.getVars():
        print(f"{var.VarName} = {round(var.x, 2)}")

    print(f"Objective Value = {round(m.objVal, 2)}")

    return m

constrs = df["people_needed"]
m1 = personnel_scheduling(constrs)
for i in range(len(constrs)):
    print(f"Shadow price of C_{i}: {m1.Pi[i]}")