== Safety Stock

Additional quantity of inventory kept on hand to protect against uncertainties in demand or supply. buffer to prevent stockouts due to unexpected variations in demand or delays in supply.

*1. Constant Demand & Constant Lead Time*

$
"SS" = Z times sigma_D
$

Where:

- $Z$: Z-score corresponding to the desired service level
- $sigma$: standard deviation of demand


*2. Variable Demand & Constant Lead Time*


$
"SS" = Z times sigma_D times sqrt(L)
$

Where:

- $Z$: Z-score corresponding to the desired service level
- $sigma_D$: Standard deviation of demand per unit of time
- $L$: Lead time

*3. Variable Lead Time & Constant Demand*

$
"SS" = Z times overline(D) times sigma_L
$

Where:

- $Z$: Z-score corresponding to the desired service level
- $overline(D)$: Average demand
- $sigma_L$: Standard deviation of lead time

*4. Variable Demand & Variable Lead Time*

$
"SS" = Z times sqrt((overline(D)^2 times sigma_L^2) + (L times sigma_D^2))
$

Where:

- $overline(L)$: Average Lead Time (average time it takes to receive inventory after placing an order)
- $sigma_D^2$: Demand Variance (variability in demand during the lead time)
- $overline(D)$: Average Demand (mean quantity of demand per time period)
- $sigma_L^2$: Lead Time Variance (variability in lead time)
