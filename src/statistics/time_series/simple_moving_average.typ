#import "../../utils/examples.typ": eg
#import "../../utils/code.typ": code

== SMA (Simple Moving Averages)

Creating a series of averages of different subsets (i.e., window) of the full data set

Minimize impact of short-term fluctuations

#figure(image("../../vis/simple_moving_average.png", width: 80%))

#eg[
  3-Day Simple Moving Average for the 7 Day Time Series

  Data

  - Day 1: \$10
  - Day 2: \$12
  - Day 3: \$14
  - Day 4: \$16
  - Day 5: \$18
  - Day 6: \$20
  - Day 7: \$22

  $
  "SMA for Day 3" = ("Day 1" + "Day 2" + "Day 3") / 3
  $

  $
  "SMA for Day 4" = ("Day 2" + "Day 3" + "Day 4") / 3
  $

  $
  "SMA for Day 5" = ("Day 3" + "Day 4" + "Day 5") / 3
  $

  $
  "SMA for Day 6" = ("Day 4" + "Day 5" + "Day 6") / 3
  $

  $
  "SMA for Day 7" = ("Day 5" + "Day 6" + "Day 7") / 3
  $
]

#code[
```py
pl.col('X').rolling_mean(window_size)
```
]