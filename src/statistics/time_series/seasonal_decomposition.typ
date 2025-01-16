#import "../../utils/examples.typ": eg
#import "../../utils/code.typ": code

== Seasonal Decomposition

- Level: baseline value around which the time series fluctuates

- Trend: ong-term progression or direction of the time series

- Seasonality: regular, repeating patterns or cycles in the time series

- Noise: random fluctuations or irregular variations (cannot be explained by the trend, seasonality, or other components)

*Additive Decomposition*

When the magnitude of seasonal fluctuations and trend does not change over time

$
Y_t = L_t + T_t + S_t + N_t
$

Where 

- $L_t$: Level at time $t$

- $T_t$: Trent at time $t$

- $S_t$: Seasonal component at time $t$

- $N_t$: Noise (residuals) at time $t$

*Multiplicative Decomposition*

When the magnitude of seasonal fluctuations and trend change proportionally over time

$
Y_t = L_t times T_t times S_t times N_t
$

Where 

- $L_t$: Level at time $t$

- $T_t$: Trent at time $t$

- $S_t$: Seasonal component at time $t$

- $N_t$: Noise (residuals) at time $t$
