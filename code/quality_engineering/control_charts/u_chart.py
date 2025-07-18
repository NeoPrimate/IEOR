import numpy as np
import matplotlib.pyplot as plt

# Sample data: number of defects and number of units inspected
np.random.seed(0) # For reproducibility
num_points = 20
sample_size = np.random.randint(50, 100, num_points)
defects = np.random.randint(0, 10, num_points)

# Calculate proportions (number of defects per unit)
u_values = defects / sample_size

# Calculate aggregate statistics for control limits
u_bar = np.mean(u_values)
sigma = np.sqrt(u_bar / np.mean(sample_size)) # Standard deviation calculation
upper_limit = u_bar + 3 * sigma
lower_limit = max(u_bar - 3 * sigma, 0) # Ensure LCL is not less than 0

# Plotting the U-chart
plt.figure(figsize=(12, 6))
plt.plot(u_values, marker='o', linestyle='-', color='b', label='Defects per Unit')
plt.axhline(u_bar, color='g', linestyle='--', label='Center Line (u-bar)')
plt.axhline(upper_limit, color='r', linestyle='--', label='Upper Control Limit (UCL)')
plt.axhline(lower_limit, color='r', linestyle='--', label='Lower Control Limit (LCL)')
plt.fill_between(range(num_points), upper_limit, lower_limit, color='red', alpha=0.1)

plt.gca().xaxis.set_major_locator(MaxNLocator(integer=True))

plt.xlabel('Sample Number')
plt.ylabel('Defects per Unit')
plt.title('U-Chart')
plt.legend()
plt.grid(True)

plt.savefig('../content/vis/u_chart.png', dpi=300)
plt.show()
