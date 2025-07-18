import numpy as np
import matplotlib.pyplot as plt

# Parameters for the (R, s, Q) model
initial_inventory = 100   # Starting inventory level
reorder_point = 20        # Reorder point (s)
order_quantity = 50       # Order quantity (Q)
review_period = 5         # Review period (R)
demand_rate = 5           # Average demand per period
lead_time = 2             # Time delay for receiving orders
time_periods = 50         # Number of time periods to simulate

# Variables to track inventory over time
inventory_levels = [initial_inventory]
orders = []
outstanding_order = 0
order_arrival_time = -1

# Simulate the inventory system
for period in range(1, time_periods + 1):
    # Generate random demand for the period (using Poisson distribution)
    demand = np.random.poisson(demand_rate)
    
    # Reduce inventory by demand
    current_inventory = inventory_levels[-1] - demand
    
    # Check if order is due to arrive
    if period == order_arrival_time:
        current_inventory += outstanding_order
        outstanding_order = 0
        order_arrival_time = -1  # Reset
    
    # Review inventory only at periods that are multiples of the review period R
    if period % review_period == 0:
        if current_inventory <= reorder_point and outstanding_order == 0:
            # Place an order of fixed quantity Q
            outstanding_order = order_quantity
            order_arrival_time = period + lead_time  # Order arrives after lead time
            orders.append((period, order_quantity))
    
    # Append current inventory level
    inventory_levels.append(current_inventory)

# Plot the inventory levels over time
plt.figure(figsize=(10, 6))
plt.plot(inventory_levels, label='Inventory Level', marker='o', color='black')
plt.axhline(reorder_point, color='red', linestyle='--', label=f'Reorder Point (s={reorder_point})')

for period in range(0, time_periods + 1, review_period):
    plt.axvline(x=period, color='grey', linestyle=':', label='Review Period' if period == 0 else "")


# Mark the periods when orders were placed
for order in orders:
    plt.annotate(f'Order {order[1]}', xy=(order[0], reorder_point), xytext=(order[0], reorder_point + 10),
                 arrowprops=dict(facecolor='blue', shrink=0.05))

# plt.title('(R, s, Q) Inventory Model Simulation')
plt.xlabel('Time Period')
plt.ylabel('Inventory Level')
plt.legend()
# plt.grid(True)
plt.tight_layout()

plt.savefig('../content/vis/R_s_Q.png', dpi=300)

plt.show()