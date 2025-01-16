#import "../../utils/examples.typ": eg
#import "../../utils/code.typ": code

== WMA (Weighted Moving Average)

Each data point in the window is assigned a specific weight (usually decrease linearly)

$
"WMA" = (sum_(i=1)^n (x_i w_i)) / (sum_(i=1)^n w_i)
$

#eg[

Data

- Day 1: \$10
- Day 2: \$12
- Day 3: \$14
- Day 4: \$13
- Day 5: \$15

Weights

- 1st most recent: 3
- 2nd most recent: 2
- 3rd most recent: 1

$
"WMA for Day 3" &= ((14 times 3) + (12 times 2) + (10 times 1)) / (3 + 2 + 1) = 12.67
\
"WMA for Day 4" &= ((13 times 3) + (14 times 2) + (12 times 1)) / (3 + 2 + 1) = 13.17
\
"WMA for Day 5" &= ((15 times 3) + (13 times 2) + (14 times 1)) / (3 + 2 + 1) = 14.7
\
$
]

#code[
  ```py

  ```
]