import matplotlib.pyplot as plt
import numpy as np

# Specifications
USL = 10.2  # Upper Specification Limit
LSL = 9.8   # Lower Specification Limit
mu_overall = 10.  # Overall process mean
sigma_overall = 0.05  # Overall standard deviation

c_pk = min((USL - mu_overall) / (3 * sigma_overall), (mu_overall - LSL) / (3 * sigma_overall))
print(f'C_pk: {c_pk:0.2f}')

x = np.linspace(9.7, 10.3, 1000)

# New values for illustration of Cpk (short-term capability)
mu_process = 10.0  # Process mean (assuming it's more centered)

plt.figure(figsize=(12, 6))

# Normal distribution curve for Cpk
y_cpk = (1 / (sigma_overall * np.sqrt(2 * np.pi))) * np.exp(-0.5 * ((x - mu_overall) / sigma_overall)**2)

# Plot the normal distribution curve for Cpk
plt.plot(x, y_cpk, label='Process Distribution (Cpk)', color='blue')

# Highlight the USL and LSL
plt.axvline(USL, color='red', linestyle='--', label='USL (10.2 mm)')
plt.axvline(LSL, color='green', linestyle='--', label='LSL (9.8 mm)')

# Fill the area beyond specification limits
plt.fill_between(x, y_cpk, where=(x > USL), color='red', alpha=0.3)
plt.fill_between(x, y_cpk, where=(x < LSL), color='green', alpha=0.3)

# Highlight the process mean for Cpk
plt.axvline(mu_overall, color='purple', linestyle='-', label='Process Mean (10.0 mm)')

# Title and labels
plt.title('Process Capability with USL, LSL, and Process Mean (Cpk)')
plt.xlabel('Diameter (mm)')
plt.ylabel('Probability Density')

# Show legend
plt.legend()

# Show plot
plt.grid(True)

plt.savefig('../content/vis/c_pk.png', dpi=300)
plt.show()
