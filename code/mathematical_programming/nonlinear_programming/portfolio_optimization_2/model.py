import polars as pl
import gurobipy as gp

df_stocks = pl.read_csv("")

stocks = df_stocks['stocks'].to_list()
prices = df_stocks['prices'].to_list()
expected_prices = df_stocks['expected_prices'].to_list()
variances = df_stocks['variances'].to_list()

df_budget = pl.read_csv("")
budget = df_stocks['budget'].to_list()
minimum_expected_revenue = df_stocks['minimum_expected_revenue'].to_list()

model = gp.Model("portfolio_optimization")

x = []

for stock in stocks:
    x.append(model.addVar(lb=0, vtypse=gp.CONTINUOUS, name=stock))

model.setObjective(gp.quicksum([variances[i] * x[i] * x[i] for i in stocks]), gp.MINIMIZE)

model.addConstr(gp.quicksum(prices[i] * x[i] for i in stocks) <= budget)
model.addConstr(gp.quicksum(expected_prices[i] * x[i] for i in stocks) >= minimum_expected_revenue)

model.optimize()

for i in stocks:
    print(f"{x[i].varName}: {x[i].x}")

print(f"Z: {model.objVal}")
print(f"Expected Value: {sum(expected_prices[i] * x[i].x for i in stocks)}")
print(f"Total Spending: {sum(prices[i] * x[i].x for i in stocks)}")