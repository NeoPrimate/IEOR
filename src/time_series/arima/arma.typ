#import "/lib/imports.typ": *
#show: formatting

#import "./summary.typ": cAR, cMA
#import "../_data.typ" as data

Autoregressive moving average

$ "ARMA"(p, q) $

$ cAR(phi(B)) x_t = c + cMA(theta(B)) epsilon_t $

$ cAR(phi(B)) = 1 - cAR(phi_1) B - dots - cAR(phi_p) B^p $ \
$ cMA(theta(B)) = 1 + cMA(theta_1) B + dots + cMA(theta_q) B^q $ \
Combines AR and MA structure. Requires stationary input series.

*Parameters:* #cAR[$phi_1, ..., phi_p$], #cMA[$theta_1, ..., theta_q$], $c$, $sigma^2$ \
*Orders:* #cAR[$p$], #cMA[$q$]


#example(title: $"ARMA"(1, 1)$)[
  *Given*
  - Orders: #cAR[$p = 1$], #cMA[$q = 1$]
  - Parameters: #cAR[$phi_1 = 0.5$], #cMA[$theta_1 = 0.5$], $c = 0$
  - Initial conditions: $x_0 = 0$, $epsilon_0 = 0$
  - Data:

  #data.show-table(data.x)

  *Step 1 — formula*

  Substitute #cAR[$p = 1$], #cMA[$q = 1$] into the ARMA$(p, q)$ recursion:
  $ x_t = c + cAR(phi_1) x_(t-1) + epsilon_t + cMA(theta_1) epsilon_(t-1) $
  Forecast (set $epsilon_t = 0$):
  $ hat(x)_t = c + cAR(phi_1) x_(t-1) + cMA(theta_1) epsilon_(t-1) $
  Innovation:
  $ epsilon_t = x_t - hat(x)_t $

  *Step 2 — apply at $t = 1$*

  Plug in $c = 0$, #cAR[$phi_1 = 0.5$], #cMA[$theta_1 = 0.5$], $x_0 = 0$, $epsilon_0 = 0$:
  $ hat(x)_1 = 0 + cAR(0.5) dot 0 + cMA(0.5) dot 0 = 0 $
  $ epsilon_1 = x_1 - hat(x)_1 = 12 - 0 = 12 $

  *Step 3 — iterate*

  Each row uses the *previous* observation $x_(t-1)$ and the *previous* innovation $epsilon_(t-1)$. Values rounded to 4 decimal places.

  #align(center)[
    #table(
      columns: 4,
      inset: 0.55em,
      align: center,
      [$t$], [$x_t$], [$hat(x)_t = cAR(0.5) x_(t-1) + cMA(0.5) epsilon_(t-1)$], [$epsilon_t = x_t - hat(x)_t$],
      [1], [12], [$cAR(0.5) dot 0 + cMA(0.5) dot 0 = 0$], [$12 - 0 = 12$],
      [2], [10], [$cAR(0.5) dot 12 + cMA(0.5) dot 12 = 6 + 6 = 12$], [$10 - 12 = -2$],
      [3], [8], [$cAR(0.5) dot 10 + cMA(0.5) dot (-2) = 5 - 1 = 4$], [$8 - 4 = 4$],
      [4], [11], [$cAR(0.5) dot 8 + cMA(0.5) dot 4 = 4 + 2 = 6$], [$11 - 6 = 5$],
      [5], [14], [$cAR(0.5) dot 11 + cMA(0.5) dot 5 = 5.5 + 2.5 = 8$], [$14 - 8 = 6$],
      [6], [12], [$cAR(0.5) dot 14 + cMA(0.5) dot 6 = 7 + 3 = 10$], [$12 - 10 = 2$],
      [7], [9], [$cAR(0.5) dot 12 + cMA(0.5) dot 2 = 6 + 1 = 7$], [$9 - 7 = 2$],
      [8], [13], [$cAR(0.5) dot 9 + cMA(0.5) dot 2 = 4.5 + 1 = 5.5$], [$13 - 5.5 = 7.5$],
      [9], [16], [$cAR(0.5) dot 13 + cMA(0.5) dot 7.5 = 6.5 + 3.75 = 10.25$], [$16 - 10.25 = 5.75$],
      [10], [14], [$cAR(0.5) dot 16 + cMA(0.5) dot 5.75 = 8 + 2.875 = 10.875$], [$14 - 10.875 = 3.125$],
      [11], [11], [$cAR(0.5) dot 14 + cMA(0.5) dot 3.125 = 7 + 1.5625 = 8.5625$], [$11 - 8.5625 = 2.4375$],
      [12], [15], [$cAR(0.5) dot 11 + cMA(0.5) dot 2.4375 = 5.5 + 1.2188 = 6.7188$], [$15 - 6.7188 = 8.2813$],
      [13], [18], [$cAR(0.5) dot 15 + cMA(0.5) dot 8.2813 = 7.5 + 4.1406 = 11.6406$], [$18 - 11.6406 = 6.3594$],
      [14], [16], [$cAR(0.5) dot 18 + cMA(0.5) dot 6.3594 = 9 + 3.1797 = 12.1797$], [$16 - 12.1797 = 3.8203$],
      [15], [13], [$cAR(0.5) dot 16 + cMA(0.5) dot 3.8203 = 8 + 1.9102 = 9.9102$], [$13 - 9.9102 = 3.0898$],
      [16], [17], [$cAR(0.5) dot 13 + cMA(0.5) dot 3.0898 = 6.5 + 1.5449 = 8.0449$], [$17 - 8.0449 = 8.9551$],
      [17], [—], [$cAR(0.5) dot 17 + cMA(0.5) dot 8.9551 = 8.5 + 4.4775 = 12.9775$], [—],
    )
  ]
]
