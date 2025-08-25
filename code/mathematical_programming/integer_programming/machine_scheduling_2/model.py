from gurobipy import Model, GRB, quicksum

# Fifteen jobs, each with its processing time, should be scheduled on three machines. 
# If two jobs cannot be scheduled on the same machine, they are called conflicting jobs. 
# Table 1 lists the job IDs, processing times, and sets of conflicting jobs. 
# For example, we cannot schedule any pair of jobs out of jobs 2, 5, 8 on the same machine. 
# Note that a job may have no conflicting jobs. 

# We want to schedule the jobs to minimize makespan. 
# For example, we may schedule jobs 1, 4, 7, 8, and 13 to machine 1, 
# jobs 2, 6, 10, 11, and 14 to machine 2, 
# and jobs 3, 5, 9, 12, and 15 to machine 3. 
# The total processing times on the three machines are 52, 39, and 37, respectively. 
# The makespan is thus 52. While this is a feasible schedule, this may or may not be an optimal schedule. 
# When we try to improve the schedule, be careful about conflicting jobs. 
# For example, we cannot exchange jobs 8 and 11 (even though this reduces the makespan) 
# because that will result in machine 2 processing conflicting jobs 2 and 8, which is infeasible. 

# Data
jobs = list(range(1, 16))
p = {1:7, 2:4, 3:6, 4:9, 5:12, 6:8, 7:10, 8:11, 9:8, 10:7, 11:6, 12:8, 13:15, 14:14, 15:3}
conflicts = {
    2: [5, 8],
    5: [2, 8],
    6: [9],
    7: [10],
    8: [2, 5],
    9: [6],
    10: [7],
    11: [15],
    15: [11]
}

machines = [1,2,3]

# Create model
m = Model("job_scheduling")

# Decision variables
x = m.addVars(jobs, machines, vtype=GRB.BINARY, name="x")
makespan = m.addVar(lb=0, vtype=GRB.CONTINUOUS, name="makespan")

# Objective
m.setObjective(makespan, GRB.MINIMIZE)

# Each job assigned to exactly one machine
for i in jobs:
    m.addConstr(quicksum(x[i,j] for j in machines) == 1)

# Machine load constraints
for j in machines:
    m.addConstr(quicksum(p[i]*x[i,j] for i in jobs) <= makespan)

# Conflict constraints
for i in conflicts:
    for k in conflicts[i]:
        if i < k:  # avoid duplicates
            for j in machines:
                m.addConstr(x[i,j] + x[k,j] <= 1)

# Optimize
m.optimize()

# Print solution
if m.status == GRB.OPTIMAL:
    print("Minimized makespan:", makespan.X)
    for j in machines:
        assigned_jobs = [i for i in jobs if x[i,j].X > 0.5]
        print(f"Machine {j}: Jobs {assigned_jobs}, Load = {sum(p[i] for i in assigned_jobs)}")
