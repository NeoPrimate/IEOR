import numpy as np
import polars as pl
from datetime import datetime, timedelta
import matplotlib.pyplot as plt
from xgboost import XGBRegressor
from sklearn.metrics import mean_squared_error

# Generate synthetic data
np.random.seed(42)
n_periods = 120
seasonal_period = 12
time = np.arange(n_periods)
seasonal = 10 * np.sin(2 * np.pi * time / seasonal_period)
trend = 0.2 * time
noise = np.random.normal(scale=2.0, size=n_periods)
data = seasonal + trend + noise

# Create date range
start_date = datetime(2010, 1, 1)
dates = [start_date + timedelta(days=30 * i) for i in range(n_periods)]

# Create Polars DataFrame
df = pl.DataFrame({
    "date": dates,
    "value": data
})

# Extract time features
df = df.with_columns([
    pl.col("date").dt.year().alias("year"),
    pl.col("date").dt.month().alias("month"),
    pl.col("date").dt.day().alias("day"),
    pl.col("date").dt.weekday().alias("weekday"),
    pl.arange(0, df.height).alias("time_index")
])

# Convert to pandas for XGBoost
df_pd = df.to_pandas()

# Split features and target
features = ["year", "month", "day", "weekday", "time_index"]
X = df_pd[features]
y = df_pd["value"]

# Train-test split (e.g., last 24 points for test)
split_index = n_periods - 24
X_train, X_test = X[:split_index], X[split_index:]
y_train, y_test = y[:split_index], y[split_index:]

# Train XGBoost model
model = XGBRegressor(n_estimators=100, max_depth=3, learning_rate=0.1)
model.fit(X_train, y_train)

# Predict and evaluate
y_pred = model.predict(X_test)
rmse = mean_squared_error(y_test, y_pred)
print(f"RMSE: {rmse:.2f}")

# Plot
plt.figure(figsize=(12, 5))
plt.plot(df_pd["date"], y, label="Observed")
plt.plot(df_pd["date"].iloc[split_index:], y_pred, label="XGBoost Forecast", color="orange")
plt.axvline(df_pd["date"].iloc[split_index], color="gray", linestyle="--", label="Train/Test Split")
plt.title("XGBoost Forecast with Time Features")
plt.xlabel("Date")
plt.ylabel("Value")
plt.legend()
plt.tight_layout()
plt.grid(True)
plt.show()
