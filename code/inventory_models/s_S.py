import numpy as np
import matplotlib.pyplot as plt

# Parameters for the (s, S) model
initial_inventory = 100   # Starting inventory
reorder_point = 20        # Reorder point (s)
order_up_to_level = 80    # Order-up-to level (S)
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
        current_inventory = order_up_to_level  # Set inventory to S after order arrives
        outstanding_order = 0
        order_arrival_time = -1  # Reset
    
    # Review inventory only at periods that are multiples of the review period R
    # if period % review_period == 0:
    if current_inventory <= reorder_point and outstanding_order == 0:
        # Order enough to bring inventory up to the order-up-to level S
        order_quantity = order_up_to_level - current_inventory
        outstanding_order = order_quantity
        order_arrival_time = period + lead_time  # Order arrives after lead time
        orders.append((period, order_quantity))
    
    # Append current inventory level
    inventory_levels.append(current_inventory)

# Plot the inventory levels over time
plt.figure(figsize=(10, 6))
plt.plot(inventory_levels, label='Inventory Level', marker='o', color='black')
plt.axhline(reorder_point, color='red', linestyle='--', label=f'Reorder Point (s={reorder_point})')
plt.axhline(order_up_to_level, color='green', linestyle='--', label=f'Order-up-to Level (S={order_up_to_level})')

# Mark the periods when orders were placed
for order in orders:
    plt.annotate(f'Order {order[1]}', xy=(order[0], reorder_point), xytext=(order[0], reorder_point + 10),
                 arrowprops=dict(facecolor='blue', shrink=0.05))

# plt.title('(s, S) Inventory Model Simulation')
plt.xlabel('Time Period')
plt.ylabel('Inventory Level')
plt.legend()
# plt.grid(True)
plt.tight_layout()

plt.savefig('../content/vis/s_S.png', dpi=300)

plt.show()
