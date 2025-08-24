import numpy as np
import matplotlib.pyplot as plt
import polars as pl

# Parameters
lmbda = 3  # arrival rate
mu = 5     # service rate
c = 2      # number of servers
simulation_time = 10  # simulate for 10 time units

# Time intervals for arrivals (exponentially distributed)
np.random.seed(42)  # For reproducibility
arrival_times = np.cumsum(np.random.exponential(1/lmbda, 50))
arrival_times = arrival_times[arrival_times <= simulation_time]  # limit arrivals to simulation time

# Service times (exponentially distributed)
service_times = np.random.exponential(1/mu, len(arrival_times))

# Initialize lists for tracking
start_service_times = np.zeros_like(arrival_times)
end_service_times = np.zeros_like(arrival_times)
wait_times = np.zeros_like(arrival_times)

# Queue system simulation
servers = [0] * c  # server end times
for i, arrival in enumerate(arrival_times):
    next_available_server = min(servers)  # when the next server becomes available
    if arrival >= next_available_server:  # customer arrives after the server is free
        start_service_times[i] = arrival
    else:  # customer waits for the server
        start_service_times[i] = next_available_server
    
    end_service_times[i] = start_service_times[i] + service_times[i]
    wait_times[i] = start_service_times[i] - arrival
    servers[servers.index(next_available_server)] = end_service_times[i]

# Plotting
fig, ax = plt.subplots(figsize=(10, 6))

for i in range(len(arrival_times)):
    # Arrival time bar
    ax.barh(i, start_service_times[i] - arrival_times[i], left=arrival_times[i], color='red', label='Wait Time' if i == 0 else "")
    # Service time bar
    ax.barh(i, service_times[i], left=start_service_times[i], color='green', label='Service Time' if i == 0 else "")

ax.set_xlabel('Time')
ax.set_ylabel('Customer')
# ax.set_title(f'M/M/{c} Queue System Simulation')
ax.legend()
plt.tight_layout()

# plt.savefig('../content/vis/queuing.png', dpi=300)

plt.show()
