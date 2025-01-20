import matplotlib.pyplot as plt
import numpy as np

# # Specifications and Process Parameters for Pp illustration
# sigma_pp = 0.06  # Same overall standard deviation used for Pp

# # Process mean centered for Pp example (to compare with Ppk)
# mu_pp = 10.0  # Centered between USL and LSL

# Specifications
USL = 10.2  # Upper Specification Limit
LSL = 9.8   # Lower Specification Limit
mu_overall = 10.1  # Overall process mean
sigma_overall = 0.06  # Overall standard deviation

x = np.linspace(9.7, 10.3, 1000)

# Normal distribution curve with centered mean
y_pp = (1 / (sigma_overall * np.sqrt(2 * np.pi))) * np.exp(-0.5 * ((x - mu_overall) / sigma_overall)**2)

plt.figure(figsize=(12, 6))

# Plot the normal distribution curve for Pp
plt.plot(x, y_pp, label='Process Distribution', color='blue')

# Highlight the USL and LSL
plt.axvline(USL, color='red', linestyle='--', label='USL (10.2 mm)')
plt.axvline(LSL, color='green', linestyle='--', label='LSL (9.8 mm)')

# Fill the area beyond specification limits
plt.fill_between(x, y_pp, where=(x > USL), color='red', alpha=0.3)
plt.fill_between(x, y_pp, where=(x < LSL), color='green', alpha=0.3)

# Highlight the process mean
plt.axvline(mu_overall, color='purple', linestyle='-', label='Process Mean (10.0 mm)')

# Title and labels
plt.title('Process Performance (Pp) with Centered Mean')
plt.xlabel('Diameter (mm)')
plt.ylabel('Probability Density')

# Show legend
plt.legend()

# Show plot
plt.grid(True)

plt.savefig('../content/vis/p_p.png', dpi=300)
plt.show()
