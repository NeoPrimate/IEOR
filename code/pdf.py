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

plt.figure(figsize=(10, 6))

plt.plot(x_values, y_values, color="red", linewidth=10, alpha=0.25)
plt.plot(x_values, y_values, color="grey", linewidth=1.5)

plt.gca().axes.get_yaxis().set_visible(False)
plt.gca().axes.get_xaxis().set_ticks([])
plt.gca().axes.get_yaxis().set_ticks([])
sns.despine(left=True, bottom=True)

plt.savefig('../content/vis/pdf.png', dpi=300)

plt.show()