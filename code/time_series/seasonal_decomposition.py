import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from statsmodels.tsa.seasonal import seasonal_decompose

# Parameters
T = 1000
date_range = pd.date_range(start='2020-01-01', periods=T, freq='M')

# Components
level = 10
trend = np.linspace(0, 10, T)
seasonality = 5 * np.sin(np.linspace(0, 2 * np.pi * (T / 12), T))  # 1-year seasonality
noise = np.random.normal(loc=0, scale=2, size=T)  # zero-mean noise

# Final time series
data = level + trend + seasonality + noise
ts = pd.Series(data, index=date_range)

# Plot components
plt.figure(figsize=(12, 8))

plt.subplot(4, 1, 1)
plt.plot(trend, label='Trend')
plt.title('Trend')
plt.legend()

plt.subplot(4, 1, 2)
plt.plot(seasonality, label='Seasonality', color='orange')
plt.title('Seasonality')
plt.legend()

plt.subplot(4, 1, 3)
plt.plot(noise, label='Noise', color='green')
plt.title('Noise')
plt.legend()

plt.subplot(4, 1, 4)
plt.plot(data, label='Time Series Data', color='red')
plt.title('Final Time Series Data')
plt.legend()

plt.tight_layout()
plt.show()

# Decomposition
result = seasonal_decompose(ts, model='additive', period=12)
result.plot()
plt.show()
