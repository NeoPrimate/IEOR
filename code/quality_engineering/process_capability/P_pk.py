import matplotlib.pyplot as plt
import numpy as np

# Specifications
USL = 10.2  # Upper Specification Limit
LSL = 9.8   # Lower Specification Limit
mu_overall = 10.1  # Overall process mean
sigma_overall = 0.06  # Overall standard deviation

p_pk = min((USL - mu_overall) / (3 * sigma_overall), (mu_overall - LSL) / (3 * sigma_overall))
print(f'P_pk: {p_pk:0.2f}')

# X values (range around the process mean)
x = np.linspace(9.7, 10.5, 1000)

# Normal distribution curve
y = (1 / (sigma_overall * np.sqrt(2 * np.pi))) * np.exp(-0.5 * ((x - mu_overall) / sigma_overall)**2)

plt.figure(figsize=(12, 6))

# Plot the normal distribution curve
plt.plot(x, y, label='Process Distribution', color='blue')

# Highlight the USL and LSL
plt.axvline(USL, color='red', linestyle='--', label='USL (10.2 mm)')
plt.axvline(LSL, color='green', linestyle='--', label='LSL (9.8 mm)')

# Fill the area beyond specification limits
plt.fill_between(x, y, where=(x > USL), color='red', alpha=0.3)
plt.fill_between(x, y, where=(x < LSL), color='red', alpha=0.3)

# Highlight the process mean
plt.axvline(mu_overall, color='purple', linestyle='-', label='Process Mean (10.1 mm)')

# Title and labels
plt.title('Process Performance with USL, LSL, and Process Mean')
plt.xlabel('Diameter (mm)')
plt.ylabel('Probability Density')

# Show legend
plt.legend()

# Show plot
plt.grid(True)

plt.savefig('../content/vis/p_pk.png', dpi=300)
plt.show()
