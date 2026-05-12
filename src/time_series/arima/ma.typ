#import "/lib/imports.typ": *
#show: formatting

#import "./summary.typ": cMA
#import "../_data.typ" as data

Moving average

$ "MA"(q) $

$ x_t = c + cMA(theta(B)) epsilon_t $

$
  cMA(theta(B)) = 1 + cMA(theta_1) B + cMA(theta_2) B^2 + dots + cMA(theta_q) B^q
$

i.e.,

$
  x_t = c + epsilon_t + cMA(theta_1) epsilon_(t-1) + dots + cMA(theta_q) epsilon_(t-q)
$

Always stationary. Invertible if roots of $cMA(theta(B)) = 0$ lie outside the unit circle.

*Parameters:* #cMA[$theta_1, ..., theta_q$], $c$, $sigma^2$ \
*Orders:* #cMA[$q$]


#example(title: $"MA"(1)$)[
  *Given*
  - Order: #cMA[$q = 1$]
  - Parameters: #cMA[$theta_1 = 0.5$], $c = 0$
  - Initial innovation: $epsilon_0 = 0$
  - Data:

  #data.show-table(data.x)

  *Step 1 — formula*

  Substitute #cMA[$q = 1$] into the MA$(q)$ recursion:
  $ x_t = c + epsilon_t + cMA(theta_1) epsilon_(t-1) $
  Forecast (set $epsilon_t = 0$):
  $ hat(x)_t = c + cMA(theta_1) epsilon_(t-1) $
  Innovation:
  $ epsilon_t = x_t - hat(x)_t $

  *Step 2 — apply at $t = 1$*

  Plug in $c = 0$, #cMA[$theta_1 = 0.5$], and $epsilon_0 = 0$:
  $ hat(x)_1 = 0 + cMA(0.5) dot 0 = 0 $
  $ epsilon_1 = x_1 - hat(x)_1 = 12 - 0 = 12 $

  *Step 3 — iterate*

  Each row uses the *previous* innovation $epsilon_(t-1)$. Values rounded to 4 decimal places.

  #align(center)[
    #table(
      columns: 4,
      inset: 0.55em,
      align: center,
      [$t$], [$x_t$], [$hat(x)_t = cMA(0.5) dot epsilon_(t-1)$], [$epsilon_t = x_t - hat(x)_t$],
      [1], [12], [$cMA(0.5) dot 0 = 0$], [$12 - 0 = 12$],
      [2], [10], [$cMA(0.5) dot 12 = 6$], [$10 - 6 = 4$],
      [3], [8], [$cMA(0.5) dot 4 = 2$], [$8 - 2 = 6$],
      [4], [11], [$cMA(0.5) dot 6 = 3$], [$11 - 3 = 8$],
      [5], [14], [$cMA(0.5) dot 8 = 4$], [$14 - 4 = 10$],
      [6], [12], [$cMA(0.5) dot 10 = 5$], [$12 - 5 = 7$],
      [7], [9], [$cMA(0.5) dot 7 = 3.5$], [$9 - 3.5 = 5.5$],
      [8], [13], [$cMA(0.5) dot 5.5 = 2.75$], [$13 - 2.75 = 10.25$],
      [9], [16], [$cMA(0.5) dot 10.25 = 5.125$], [$16 - 5.125 = 10.875$],
      [10], [14], [$cMA(0.5) dot 10.875 = 5.4375$], [$14 - 5.4375 = 8.5625$],
      [11], [11], [$cMA(0.5) dot 8.5625 = 4.2813$], [$11 - 4.2813 = 6.7188$],
      [12], [15], [$cMA(0.5) dot 6.7188 = 3.3594$], [$15 - 3.3594 = 11.6406$],
      [13], [18], [$cMA(0.5) dot 11.6406 = 5.8203$], [$18 - 5.8203 = 12.1797$],
      [14], [16], [$cMA(0.5) dot 12.1797 = 6.0898$], [$16 - 6.0898 = 9.9102$],
      [15], [13], [$cMA(0.5) dot 9.9102 = 4.9551$], [$13 - 4.9551 = 8.0449$],
      [16], [17], [$cMA(0.5) dot 8.0449 = 4.0225$], [$17 - 4.0225 = 12.9775$],
      [17], [—], [$cMA(0.5) dot 12.9775 = 6.4888$], [—],
    )
  ]

  Like AR(1), MA(1) cannot capture the trend or seasonality in $x$.
]
