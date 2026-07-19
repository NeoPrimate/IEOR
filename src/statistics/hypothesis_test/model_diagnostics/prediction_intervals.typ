#import "/lib/imports.typ": *
#show: formatting

$
  x plus.minus t dot s sqrt(1 + (1 / n))
$

#code[
  ```py
  from scipy.stats import t
  import numpy as np

  xbar = 10
  s = 5
  n = 1000

  conf = 0.99

  p = 1 - ((1 - conf) / 2)
  crit = t.ppf(p, df=n-1)

  se_pred = s * np.sqrt(1 + (1 / n))

  print(f"Standard Error Prediction: {se_pred:.2f}")

  lower = xbar - crit * se_pred
  upper = xbar + crit * se_pred

  print(f"Prediction Interval: [{lower:.2f}, {upper:.2f}]")
  ```
]