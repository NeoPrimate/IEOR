import numpy as np
import matplotlib.pyplot as plt
import polars as pl

# Parameters
λ = 0.3  # Average arrival rate (customers per unit time)
simulation_time = 10  # Total time to run the simulation
num_simulations = 1000  # Number of trials to observe Poisson arrivals

# Data storage
inter_arrival_times = []
arrival_counts = []

# Simulate multiple trials
for _ in range(num_simulations):
    current_time = 0
    arrivals = 0
    
    while current_time < simulation_time:
        # Generate inter-arrival time (exponentially distributed)
        inter_arrival_time = np.random.exponential(1 / λ)
        inter_arrival_times.append(inter_arrival_time)
        
        current_time += inter_arrival_time
        
        if current_time <= simulation_time:
            arrivals += 1
    
    # Record the number of arrivals for Poisson distribution
    arrival_counts.append(arrivals)

# Plotting the results
fig, axes = plt.subplots(1, 2, figsize=(14, 6))

# Plot the histogram for Exponential distribution (inter-arrival times)
axes[0].hist(inter_arrival_times, bins=30, edgecolor='black', alpha=0.7)
axes[0].set_title('Distribution of Inter-Arrival Times (Exponential)')
axes[0].set_xlabel('Inter-Arrival Time')
axes[0].set_ylabel('Frequency')

# Plot the histogram for Poisson distribution (number of arrivals)
axes[1].hist(arrival_counts, bins=range(min(arrival_counts), max(arrival_counts) + 1), edgecolor='black', alpha=0.7)
axes[1].set_title(f'Number of Arrivals (Poisson)')
axes[1].set_xlabel('Number of Arrivals')
axes[1].set_ylabel('Frequency')

# Show the plots
plt.tight_layout()

plt.savefig('../content/vis/exponential_interarrival_times_poisson_number_arrivals.png', dpi=300)

plt.show()
