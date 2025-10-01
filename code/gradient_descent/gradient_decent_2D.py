import numpy as np
import matplotlib.pyplot as plt

# Define the function to minimize
def f(x):
    return (x - 3) ** 2

# Define the gradient of the function
def grad_f(x):
    return 2 * (x - 3)

# Gradient Descent Algorithm
def gradient_descent(starting_point, learning_rate, num_iterations):
    x = starting_point
    history = [x]
    
    for _ in range(num_iterations):
        gradient = grad_f(x)
        x = x - learning_rate * gradient
        history.append(x)
    
    return x, history

# Parameters
starting_point = 0.0  # Initial guess
learning_rate = 0.1    # Step size
num_iterations = 20   # Number of iterations

# Perform Gradient Descent
final_x, history = gradient_descent(starting_point, learning_rate, num_iterations)

# Plotting
x_values = np.linspace(-1, 7, 400)
y_values = f(x_values)
grad_values = grad_f(x_values)

plt.figure(figsize=(12, 8))

# Plot the function f(x)
plt.plot(x_values, y_values, label='$f(x) = (x - 3)^2$')

# Plot the gradient of the function
plt.plot(x_values, grad_values, label="Gradient of $f(x)$", linestyle='--')

# Plot the gradient descent steps
plt.plot(history, [f(x) for x in history], 'ro-', label='Gradient Descent Path')

# Annotate the final point
# plt.annotate(f'Final x: {final_x:.2f}', xy=(final_x, f(final_x)), xytext=(final_x + 1, f(final_x) + 5),
#              arrowprops=dict(facecolor='black', shrink=0.05))

plt.xlabel('x')
plt.ylabel('Value')
plt.title('Gradient Descent Optimization with Gradient Visualization')
plt.legend()
plt.grid(True)
plt.show()