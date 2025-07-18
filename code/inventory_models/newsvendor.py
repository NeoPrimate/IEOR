import numpy as np
import scipy.stats as stats
import matplotlib.pyplot as plt

# Parameters for the newsvendor example
selling_price = 3  # Selling price per newspaper
purchase_cost = 1   # Purchase cost per newspaper
unsold_value = 0    # Value of unsold newspapers

# Calculate underage and overage costs
C_u = selling_price - purchase_cost  # Underage cost
C_o = purchase_cost - unsold_value    # Overage cost

# Calculate the critical ratio
CR = C_u / (C_u + C_o)

# Assume a normal distribution for demand
mu = 50    # Mean demand
sigma = 10 # Standard deviation of demand

# Calculate the optimal order quantity (Q*)
z_star = stats.norm.ppf(CR)  # z-score corresponding to the critical ratio
Q_star = mu + z_star * sigma  # Optimal order quantity

# Create a range of demand values for visualization
demand_range = np.arange(20, 81, 1)
demand_distribution = stats.norm.pdf(demand_range, mu, sigma)

# Plotting the demand distribution and the optimal order quantity
plt.figure(figsize=(10, 6))
plt.plot(demand_range, demand_distribution, label='Demand Distribution', color='blue')
plt.axvline(Q_star, color='red', linestyle='--', label=f'Optimal Order Quantity (Q* = {Q_star:.2f})')
# plt.title('Newsvendor Model: Demand Distribution and Optimal Order Quantity')
plt.xlabel('Demand')
plt.ylabel('Probability Density')
plt.legend()
# plt.grid()
plt.xlim(20, 80)
plt.ylim(0, max(demand_distribution) * 1.1)
plt.show()

Q_star
