import numpy as np
import matplotlib.pyplot as plt

# Sample data: number of defects
np.random.seed(0)  # For reproducibility
num_points = 20
defects = np.random.randint(0, 10, num_points)  # Number of defects in each sample

# Calculate aggregate statistics for control limits
c_bar = np.mean(defects)
sigma = np.sqrt(c_bar)  # Standard deviation for the Poisson distribution
upper_limit = c_bar + 3 * sigma
lower_limit = max(c_bar - 3 * sigma, 0)  # Ensure LCL is not less than 0

# Plotting the C-chart
plt.figure(figsize=(12, 6))
plt.plot(defects, marker='o', linestyle='-', color='b', label='Number of Defects')
plt.axhline(c_bar, color='g', linestyle='--', label='Center Line (c-bar)')
plt.axhline(upper_limit, color='r', linestyle='--', label='Upper Control Limit (UCL)')
plt.axhline(lower_limit, color='r', linestyle='--', label='Lower Control Limit (LCL)')
plt.fill_between(range(num_points), upper_limit, lower_limit, color='red', alpha=0.1)

plt.gca().xaxis.set_major_locator(MaxNLocator(integer=True))

plt.xlabel('Sample Number')
plt.ylabel('Number of Defects')
plt.title('C-Chart')
plt.legend()
plt.grid(True)

plt.savefig('../content/vis/c_chart.png', dpi=300)
plt.show()
