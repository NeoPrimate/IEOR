from gurobipy import *

def shadow_prices(resource_limitation):
    products = range(2)
    resources = range(3)

    prices = [700, 900]
    resource_consumption = [
        [3, 5],
        [1, 2],
        [50, 20],
    ]

    m = Model("LP")

    x = [m.addVar(lb=0, vtype=GRB.CONTINUOUS, name=f'x_{i}') for i in products]

    m.setObjective(quicksum(prices[i] * x[i] for i in products), GRB.MAXIMIZE)

    m.addConstrs((quicksum(resource_consumption[j][i] * x[i] for i in products) <= resource_limitation[j] for j in resources), "resource_limitation")

    m.optimize()

    for var in m.getVars():
        print(f"{var.varName} = {round(var.x, 2)}")

    print(f"Obj Value = {round(m.objVal, 2)}")

    return m

resource_limitation = [3600, 1600, 48000]
m1 = shadow_prices(resource_limitation)
print(f"Shadow price of C_1: {m1.Pi[0]}")
print(f"Shadow price of C_2: {m1.Pi[1]}")
print(f"Shadow price of C_3: {m1.Pi[2]}")
