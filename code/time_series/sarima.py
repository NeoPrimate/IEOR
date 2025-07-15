import polars as pl
import numpy as np
from datetime import datetime, timedelta
from statsmodels.tsa.statespace.sarimax import SARIMAX
import matplotlib.pyplot as plt
import pandas as pd  # still needed for compatibility with statsmodels

# Generate synthetic time series data
np.random.seed(42)
n_periods = 120
seasonal_period = 12
time = np.arange(n_periods)
seasonal_pattern = 10 * np.sin(2 * np.pi * time / seasonal_period)
trend = 0.2 * time
noise = np.random.normal(scale=2.0, size=n_periods)
data = seasonal_pattern + trend + noise

# Create date range
start_date = datetime(2010, 1, 31)
dates = [start_date + timedelta(days=30 * i) for i in range(n_periods)]

# Create Polars DataFrame
df = pl.DataFrame({
    "date": dates,
    "value": data
})

# Convert to pandas Series for SARIMAX
ts = df.sort("date").to_pandas().set_index("date")["value"]

# Fit SARIMA model
model = SARIMAX(ts, order=(1, 1, 1), seasonal_order=(1, 1, 1, seasonal_period))
results = model.fit(disp=False)

# Forecast
forecast_steps = 24
forecast = results.get_forecast(steps=forecast_steps)
forecast_index = pd.date_range(start=ts.index[-1] + pd.offsets.MonthEnd(1), periods=forecast_steps, freq="ME")
forecast_series = forecast.predicted_mean
conf_int = forecast.conf_int()
conf_int.index = forecast_index

# Plot results
plt.figure(figsize=(12, 5))
plt.plot(ts, label="Observed")
plt.plot(forecast_index, forecast_series, label="Forecast", color="orange")
plt.fill_between(forecast_index, conf_int.iloc[:, 0].values, conf_int.iloc[:, 1].values, color="orange", alpha=0.3)
plt.title("SARIMA Forecast Using Polars DataFrame")
plt.xlabel("Date")
plt.ylabel("Value")
plt.legend()
plt.grid(True)
plt.tight_layout()
plt.show()
