import numpy as np
import matplotlib.pyplot as plt

# Sample data: number of items inspected and number of defective items
np.random.seed(0)  # For reproducibility
num_points = 20
sample_size = np.random.randint(50, 100, num_points)
defective = np.random.randint(0, 10, num_points)

# Calculate proportions
proportions = defective / sample_size

# Calculate aggregate statistics for control limits
p_bar = np.mean(proportions)
sigma = np.sqrt(p_bar * (1 - p_bar) / np.mean(sample_size))
upper_limit = p_bar + 3 * sigma
lower_limit = p_bar - 3 * sigma
lower_limit = max(lower_limit, 0)

# Plotting the p-chart
plt.figure(figsize=(12, 6))
plt.plot(proportions, marker='o', linestyle='-', color='b', label='Proportion Defective')
plt.axhline(p_bar, color='g', linestyle='--', label='Center Line (p-bar)')
plt.axhline(upper_limit, color='r', linestyle='--', label='Upper Control Limit (UCL)')
plt.axhline(lower_limit, color='r', linestyle='--', label='Lower Control Limit (LCL)')
plt.fill_between(range(num_points), upper_limit, lower_limit, color='red', alpha=0.1)

plt.gca().xaxis.set_major_locator(MaxNLocator(integer=True))

plt.xlabel('Sample Number')
plt.ylabel('Proportion Defective')
plt.title('P-Chart')
plt.legend()
plt.grid(True)

plt.savefig('../content/vis/p_chart.png', dpi=300)

plt.show()

