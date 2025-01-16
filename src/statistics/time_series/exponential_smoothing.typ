#import "../../utils/examples.typ": eg
#import "../../utils/code.typ": code

== Exponential Smoothing

Gives more weight to recent data points (more responsive to new information)

$
"EMA"_t = alpha X_t + (1 - alpha) "EMA"_(t-1)
$

Where

- $alpha$: smoothing factor

$
alpha = 2 / (N + 1)
$

- $N$: Period (i.e., window size) of the EMA 

#figure(image("../../vis/exponential_moving_average.png", width: 80%))

#eg[
Data

- Day 1: \$10
- Day 2: \$12
- Day 3: \$14
- Day 4: \$13
- Day 5: \$15

Calculate Smoothing Factor

$
alpha = 2 / (3 + 1) = 0.5
$

Calculate SMA for First Value

$
"SMA for Day 3" &= (10 + 12 + 14) / 3
$

Calculate EMA

$
"EMA for Day 4" &= (0.5 times 13) + (12 times 0.5) = 12.5
\
\
"EMA for Day 5" &= (0.5 times 15) + (12.5 times 0.5) = 13.75
$

]

#code[
  ```py
  pl.col("X").ewm_mean(span=window_size, adjust=False)
  ```
]