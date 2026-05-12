#import "/lib/imports.typ": *
#show: formatting

== MD (Mean Deviation / Bias)

Average of the signed forecast errors $e_t = x_t - hat(x)_t$. Captures *bias* — whether the forecast systematically over- or under-shoots.

$
  "MD" = 1/n sum_(t=1)^n e_t = 1/n sum_(t=1)^n (x_t - hat(x)_t)
$

- $"MD" approx 0$: forecast is unbiased on average
- $"MD" > 0$: forecast under-predicts (actuals exceed forecast)
- $"MD" < 0$: forecast over-predicts

*Caveat.* Positive and negative errors cancel out, so MD says nothing about *accuracy* — a forecast that alternates wildly between $+100$ and $-100$ has MD $= 0$. Pair MD with MAE / RMSE to separate bias from accuracy.
