import scipy
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns

def gaussian(x, mu=0, sigma=1):
    return (1 / (sigma * np.sqrt(2 * np.pi))) * np.exp(-0.5 * ((x - mu) / sigma) ** 2)

mu = 0
sigma = 2
x_values = np.linspace(-5, 5, 1000)
y_values = gaussian(x_values, mu=mu, sigma=sigma)

x_line = 2
y_line = gaussian(x_line, mu=mu, sigma=sigma)

plt.figure(figsize=(10, 6))

sns.lineplot(x=x_values, y=y_values, color="grey")

plt.plot([x_line, x_line], [0, y_line], color='red', linestyle='--')

plt.scatter([x_line], [y_line], color='red', s=100, zorder=5)

plt.gca().axes.get_yaxis().set_visible(False)
plt.gca().axes.get_xaxis().set_ticks([])
plt.gca().axes.get_yaxis().set_ticks([])
sns.despine(left=True, bottom=True)

plt.savefig('../content/vis/likelihood.png', dpi=300)

plt.show()