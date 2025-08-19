import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
from mpl_toolkits.mplot3d.art3d import Poly3DCollection

# Define the function f(x, y) = x^2 + y^2 (simple paraboloid)
def f(x, y):
    return x**2 + y**2

# Define integration bounds (square region)
x_min, x_max = -0.5, 0.5
y_min, y_max = -0.5, 0.5

# Create meshgrid for the function surface (keeping plot size same)
x = np.linspace(-1, 1, 30)  # Keep full plot range
y = np.linspace(-1, 1, 30)  # Keep full plot range
X, Y = np.meshgrid(x, y)
Z = f(X, Y)

# Create figure and 3D axis
fig = plt.figure(figsize=(12, 8))
ax = fig.add_subplot(111, projection='3d')

# Plot the function surface
surf = ax.plot_surface(X, Y, Z, alpha=0.3, cmap='viridis', 
                       linewidth=0, antialiased=True)

# Create the base square on xy-plane
base_x = [x_min, x_max, x_max, x_min, x_min]
base_y = [y_min, y_min, y_max, y_max, y_min]
base_z = [0, 0, 0, 0, 0]
ax.plot(base_x, base_y, base_z, 'r-', linewidth=3, label='Integration region')

# Create semi-transparent walls from xy-plane to function surface
# We'll create walls at the boundaries of our integration region

# Wall 1: x = x_min
y_wall = np.linspace(y_min, y_max, 20)
x_wall = np.full_like(y_wall, x_min)
z_wall_bottom = np.zeros_like(y_wall)
z_wall_top = f(x_wall, y_wall)

for i in range(len(y_wall)-1):
    # Create rectangular patches for the wall
    vertices = [
        [x_wall[i], y_wall[i], z_wall_bottom[i]],      # bottom left
        [x_wall[i+1], y_wall[i+1], z_wall_bottom[i+1]], # bottom right
        [x_wall[i+1], y_wall[i+1], z_wall_top[i+1]],    # top right
        [x_wall[i], y_wall[i], z_wall_top[i]]           # top left
    ]
    ax.add_collection3d(Poly3DCollection([vertices], alpha=0.3, facecolor='red', edgecolor='darkred'))

# Wall 2: x = x_max
x_wall = np.full_like(y_wall, x_max)
z_wall_top = f(x_wall, y_wall)

for i in range(len(y_wall)-1):
    vertices = [
        [x_wall[i], y_wall[i], z_wall_bottom[i]],
        [x_wall[i+1], y_wall[i+1], z_wall_bottom[i+1]],
        [x_wall[i+1], y_wall[i+1], z_wall_top[i+1]],
        [x_wall[i], y_wall[i], z_wall_top[i]]
    ]
    ax.add_collection3d(Poly3DCollection([vertices], alpha=0.3, facecolor='red', edgecolor='darkred'))

# Wall 3: y = y_min
x_wall = np.linspace(x_min, x_max, 20)
y_wall = np.full_like(x_wall, y_min)
z_wall_top = f(x_wall, y_wall)

for i in range(len(x_wall)-1):
    vertices = [
        [x_wall[i], y_wall[i], z_wall_bottom[i]],
        [x_wall[i+1], y_wall[i+1], z_wall_bottom[i+1]],
        [x_wall[i+1], y_wall[i+1], z_wall_top[i+1]],
        [x_wall[i], y_wall[i], z_wall_top[i]]
    ]
    ax.add_collection3d(Poly3DCollection([vertices], alpha=0.3, facecolor='red', edgecolor='darkred'))

# Wall 4: y = y_max
y_wall = np.full_like(x_wall, y_max)
z_wall_top = f(x_wall, y_wall)

for i in range(len(x_wall)-1):
    vertices = [
        [x_wall[i], y_wall[i], z_wall_bottom[i]],
        [x_wall[i+1], y_wall[i+1], z_wall_bottom[i+1]],
        [x_wall[i+1], y_wall[i+1], z_wall_top[i+1]],
        [x_wall[i], y_wall[i], z_wall_top[i]]
    ]
    ax.add_collection3d(Poly3DCollection([vertices], alpha=0.3, facecolor='red', edgecolor='darkred'))

# Add some sample vertical lines to show dx, dy concept
sample_points_x = np.linspace(x_min + 0.1, x_max - 0.1, 5)
sample_points_y = np.linspace(y_min + 0.1, y_max - 0.1, 5)

for i in range(0, len(sample_points_x), 2):
    for j in range(0, len(sample_points_y), 2):
        x_pt = sample_points_x[i]
        y_pt = sample_points_y[j]
        z_pt = f(x_pt, y_pt)
        ax.plot([x_pt, x_pt], [y_pt, y_pt], [0, z_pt], 
               'b--', alpha=0.6, linewidth=1)

# Calculate and display the double integral
# ∫∫ (x² + y²) dx dy over the square [-0.5,0.5] × [-0.5,0.5]
# Analytical result: ∫∫ (x² + y²) dx dy = ∫[-0.5,0.5] ∫[-0.5,0.5] (x² + y²) dy dx
# = ∫[-0.5,0.5] [x²y + y³/3][-0.5,0.5] dx = ∫[-0.5,0.5] (x² + 1/12) dx
# = [x³/3 + x/12][-0.5,0.5] = (1/24 + 1/24) + (1/24 + 1/24) = 1/6

analytical_result = 1/6

# Numerical integration for verification (only over integration region)
x_int = np.linspace(x_min, x_max, 15)  # Points in integration region
y_int = np.linspace(y_min, y_max, 15)  # Points in integration region
X_int, Y_int = np.meshgrid(x_int, y_int)
Z_int = f(X_int, Y_int)
dx_int = 1/(len(x_int)-1)
dy_int = 1/(len(y_int)-1)
numerical_result = np.sum(Z_int) * dx_int * dy_int

# Labels and formatting
ax.set_xlabel('x', fontsize=12)
ax.set_ylabel('y', fontsize=12)
ax.set_zlabel('f(x,y) = x² + y²', fontsize=12)
ax.set_title('Double Integral Visualization\n∫∫ (x² + y²) dx dy over [-0.5,0.5] × [-0.5,0.5]', 
             fontsize=14, pad=20)

# Add text box with results
textstr = f'Analytical Result: {analytical_result:.3f}\nNumerical Approx: {numerical_result:.3f}'
props = dict(boxstyle='round', facecolor='wheat', alpha=0.8)
ax.text2D(0.02, 0.98, textstr, transform=ax.transAxes, fontsize=10,
          verticalalignment='top', bbox=props)

# Add colorbar
fig.colorbar(surf, ax=ax, shrink=0.5, aspect=5)

# Remove tick labels and add custom ones
ax.set_xticks([x_min, x_max])
ax.set_xticklabels(['a', 'b'])
ax.set_yticks([y_min, y_max])
ax.set_yticklabels(['c', 'd'])
ax.set_zticklabels([])

# Set viewing angle for better visualization
ax.view_init(elev=25, azim=45)

# Add grid
ax.grid(True, alpha=0.3)

plt.tight_layout()
plt.show()

print(f"Double Integral Visualization")
print(f"Function: f(x,y) = x² + y²")
print(f"Region: Square [-0.5,0.5] × [-0.5,0.5]")
print(f"Integral: ∫∫ (x² + y²) dx dy")
print(f"Analytical result: {analytical_result:.6f}")
print(f"Numerical approximation: {numerical_result:.6f}")
print(f"Error: {abs(analytical_result - numerical_result):.6f}")