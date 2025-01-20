import numpy as np
import matplotlib.pyplot as plt

# Function and gradient
def f(theta1, theta2):
    return theta1**2 + theta2**2

def gradient(theta1, theta2):
    return np.array([2*theta1, 2*theta2])

# Gradient descent parameters
alpha = 0.1
iterations = 10
theta = np.array([1.0, 2.0])  # Initial values
history = [theta.copy()]  # To store the history of theta values

# Gradient descent algorithm
for _ in range(iterations):
    grad = gradient(theta[0], theta[1])
    theta -= alpha * grad
    history.append(theta.copy())

# Convert history to numpy array for easier plotting
history = np.array(history)

# Create a grid of points for contour plot
theta1_vals = np.linspace(-2.1, 2.1, 100)
theta2_vals = np.linspace(-2.1, 2.1, 100)
Theta1, Theta2 = np.meshgrid(theta1_vals, theta2_vals)
Z = f(Theta1, Theta2)

# Plotting
plt.figure(figsize=(10, 6))

# Contour plot of the function
plt.contourf(Theta1, Theta2, Z, levels=50, cmap='viridis', alpha=0.6)
# plt.colorbar(label='f(theta1, theta2)')

# Plot the path of gradient descent
plt.plot(history[:, 0], history[:, 1], 'ro-', markersize=8, label='Gradient Descent Path')

# Mark the start and end points
plt.plot(history[0, 0], history[0, 1], 'go', markersize=10, label='Start Point')
plt.plot(history[-1, 0], history[-1, 1], 'bo', markersize=10, label='End Point')

# plt.title('Gradient Descent Visualization')
plt.xlabel('theta1')
plt.ylabel('theta2')
plt.tight_layout()

plt.grid(True)

plt.savefig('../content/vis/gradient_descent_example.png', dpi=300, transparent=True)

plt.show()
