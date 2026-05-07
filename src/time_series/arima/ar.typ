#import "/lib/imports.typ": *

#import "./summary.typ": cAR
#import "../_data.typ" as data

Autoregressive

$
  "AR"(p)
$

$
  cAR(phi(B)) x_t = c + epsilon_t
$

$
  cAR(phi(B)) = 1 - cAR(phi_1) B - cAR(phi_2) B^2 - dots - cAR(phi_p) B^p
$

i.e.,

$
  x_t = c + cAR(phi_1) x_(t-1) + dots + cAR(phi_p) x_(t-p) + epsilon_t
$

Stationary if all roots of $cAR(phi(B)) = 0$ lie outside the unit circle


*Parameters:* #cAR[$phi_1, ..., phi_p$], $c$, $sigma^2$ \
*Orders:* #cAR[$p$]


#example(title: $"AR"(1)$)[
  *Given*
  - Order: #cAR[$p = 1$]
  - Parameters: #cAR[$phi_1 = 0.5$], $c = 0$
  - Data:

  #data.show-table(data.x)

  *Step 1 — formula*

  Substitute #cAR[$p = 1$] into the AR$(p)$ recursion:
  $ x_t = c + cAR(phi_1) x_(t-1) + epsilon_t $
  Forecast (set $epsilon_t = 0$):
  $ hat(x)_t = c + cAR(phi_1) x_(t-1) $
  Innovation:
  $ epsilon_t = x_t - hat(x)_t $

  *Step 2 — apply at $t = 2$*

  Plug in $c = 0$, #cAR[$phi_1 = 0.5$], and $x_1 = 12$:
  $ hat(x)_2 = 0 + cAR(0.5) dot 12 = 6 $
  $ epsilon_2 = x_2 - hat(x)_2 = 10 - 6 = 4 $

  *Step 3 — iterate*

  #align(center)[
    #table(
      columns: 4,
      inset: 0.55em,
      align: center,
      [$t$], [$x_t$], [$hat(x)_t = cAR(0.5) dot x_(t-1)$], [$epsilon_t = x_t - hat(x)_t$],
      [2], [10], [$cAR(0.5) dot 12 = 6$], [$10 - 6 = 4$],
      [3], [8], [$cAR(0.5) dot 10 = 5$], [$8 - 5 = 3$],
      [4], [11], [$cAR(0.5) dot 8 = 4$], [$11 - 4 = 7$],
      [5], [14], [$cAR(0.5) dot 11 = 5.5$], [$14 - 5.5 = 8.5$],
      [6], [12], [$cAR(0.5) dot 14 = 7$], [$12 - 7 = 5$],
      [7], [9], [$cAR(0.5) dot 12 = 6$], [$9 - 6 = 3$],
      [8], [13], [$cAR(0.5) dot 9 = 4.5$], [$13 - 4.5 = 8.5$],
      [9], [16], [$cAR(0.5) dot 13 = 6.5$], [$16 - 6.5 = 9.5$],
      [10], [14], [$cAR(0.5) dot 16 = 8$], [$14 - 8 = 6$],
      [11], [11], [$cAR(0.5) dot 14 = 7$], [$11 - 7 = 4$],
      [12], [15], [$cAR(0.5) dot 11 = 5.5$], [$15 - 5.5 = 9.5$],
      [13], [18], [$cAR(0.5) dot 15 = 7.5$], [$18 - 7.5 = 10.5$],
      [14], [16], [$cAR(0.5) dot 18 = 9$], [$16 - 9 = 7$],
      [15], [13], [$cAR(0.5) dot 16 = 8$], [$13 - 8 = 5$],
      [16], [17], [$cAR(0.5) dot 13 = 6.5$], [$17 - 6.5 = 10.5$],
      [17], [—], [$cAR(0.5) dot 17 = 8.5$], [—],
    )
  ]

  Residuals are large because AR(1) cannot capture the trend or seasonality
  in $x$ — that is the role of ARIMA / SARIMA / ETS, applied to the *same*
  data in their own examples.
]
