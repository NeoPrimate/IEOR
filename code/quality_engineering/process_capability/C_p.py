import numpy as np
import matplotlib.pyplot as plt

# Specifications
USL = 10.2  # Upper Specification Limit
LSL = 9.8   # Lower Specification Limit
sigma_overall = 0.05  # Overall standard deviation

# Calculate C_p
c_p = (USL - LSL) / (6 * sigma_overall)
print(f'C_p: {c_p:0.2f}')

x = np.linspace(9.7, 10.3, 1000)

# Process mean (assuming it's centered within the specification limits)
mu_process = (USL + LSL) / 2  # Midpoint between USL and LSL

plt.figure(figsize=(12, 6))

# Normal distribution curve for C_p
y_cp = (1 / (sigma_overall * np.sqrt(2 * np.pi))) * np.exp(-0.5 * ((x - mu_process) / sigma_overall)**2)

# Plot the normal distribution curve for C_p
plt.plot(x, y_cp, label='Process Distribution (Cp)', color='blue')

# Highlight the USL and LSL
plt.axvline(USL, color='red', linestyle='--', label='USL (10.2 mm)')
plt.axvline(LSL, color='green', linestyle='--', label='LSL (9.8 mm)')

# Fill the area beyond specification limits
plt.fill_between(x, y_cp, where=(x > USL), color='red', alpha=0.3)
plt.fill_between(x, y_cp, where=(x < LSL), color='green', alpha=0.3)

# Highlight the process mean for Cp
plt.axvline(mu_process, color='purple', linestyle='-', label='Process Mean (10.0 mm)')

# Title and labels
plt.title('Process Capability with USL, LSL, and Process Mean (Cp)')
plt.xlabel('Diameter (mm)')
plt.ylabel('Probability Density')

# Show legend
plt.legend()

# Show plot
plt.grid(True)

plt.savefig('../content/vis/c_p.png', dpi=300)
plt.show()
