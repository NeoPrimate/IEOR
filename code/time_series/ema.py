import polars as pl
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns

# Step 1: Generate Random Data
np.random.seed(42)  # For reproducibility
days = 100  # Number of days
data = np.round(np.random.normal(loc=100, scale=5, size=days), 2)

# Step 2: Create a Polars DataFrame
df = pl.DataFrame({
    "t": pl.Series(range(1, days + 1)),
    'X': pl.Series(data),
})

# Step 3: Calculate the 3-day Exponential Moving Average (EMA)
# Define the smoothing factor alpha
N = 10
alpha = 2 / (N + 1)

# Calculate EMA using a rolling_apply function
df = df.with_columns(
    pl.col("X").ewm_mean(span=N, adjust=False).alias(f'{N}-Day EMA')
)

plt.figure(figsize=(10, 6))

plt.plot(df['t'], df['X'], marker='o', color='lightgray', label='Closing Price')

plt.plot(df['t'], df[f'{N}-Day EMA'], marker='', linestyle='--', color='red', label=f'{N}-Day EMA')

plt.gca().axes.get_yaxis().set_visible(False)
plt.gca().axes.get_xaxis().set_ticks([])
plt.gca().axes.get_yaxis().set_ticks([])
sns.despine(left=True, bottom=True)

plt.grid(True)

plt.savefig('../content/vis/exponential_moving_average.png', dpi=300)

plt.show()