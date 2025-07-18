import numpy as np
import matplotlib.pyplot as plt

# Sample data: number of items inspected and number of defective items
np.random.seed(0)  # For reproducibility
num_points = 20
sample_size = np.random.randint(50, 100, num_points)
defective = np.random.randint(0, 10, num_points)

# Calculate aggregate statistics for control limits
np_bar = np.mean(defective)
sigma = np.sqrt(np.mean(sample_size))
upper_limit = np_bar + 3 * sigma
lower_limit = np_bar - 3 * sigma
lower_limit = max(lower_limit, 0)

# Plotting the NP-chart
plt.figure(figsize=(12, 6))
plt.plot(defective, marker='o', linestyle='-', color='b', label='Number of Defectives')
plt.axhline(np_bar, color='g', linestyle='--', label='Center Line (np-bar)')
plt.axhline(upper_limit, color='r', linestyle='--', label='Upper Control Limit (UCL)')
plt.axhline(lower_limit, color='r', linestyle='--', label='Lower Control Limit (LCL)')
plt.fill_between(range(num_points), upper_limit, lower_limit, color='red', alpha=0.1)

plt.gca().xaxis.set_major_locator(MaxNLocator(integer=True))

plt.xlabel('Sample Number')
plt.ylabel('Number of Defectives')
plt.title('NP-Chart')
plt.legend()
plt.grid(True)

plt.savefig('../content/vis/np_chart.png', dpi=300)
plt.show()
