#import "/lib/imports.typ": *
#show: formatting

== MPE (Mean Percent Error)

Signed-percentage version of MD. Captures *relative bias* — whether the forecast over- or under-shoots in percentage terms.

$
  "MPE" = 1/n sum_(t=1)^n e_t / x_t = 1/n sum_(t=1)^n (x_t - hat(x)_t) / x_t
$

- $"MPE" approx 0$: forecast is unbiased on a percentage scale
- $"MPE" > 0$: under-prediction (actuals exceed forecast)
- $"MPE" < 0$: over-prediction

*Caveats.*
- Positive and negative errors cancel — same warning as MD. Pair with MAPE to separate bias from accuracy.
- Undefined / unstable when any $x_t = 0$ or $x_t$ is small relative to the error.
