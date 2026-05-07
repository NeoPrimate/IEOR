#import "/lib/imports.typ": *

#import "./summary.typ": cAR, cDiff, cMA
#import "../_data.typ" as data

Seasonal ARIMA

$"SARIMA"(p,d,q)(P,D,Q)_m$

$
  cAR(phi(B)) cAR(Phi(B^m)) cDiff((1-B)^d) cDiff((1-B^m)^D) x_t
  = c + cMA(theta(B)) cMA(Theta(B^m)) epsilon_t
$
$ cAR(Phi(B^m)) = 1 - cAR(Phi_1) B^m - dots - cAR(Phi_P) B^(P m) $
$ cMA(Theta(B^m)) = 1 + cMA(Theta_1) B^m + dots + cMA(Theta_Q) B^(Q m) $

Seasonal differencing $cDiff((1-B^m)) y_t = y_t - y_(t-m)$ removes annual/periodic patterns. Period $m$ (e.g., 12 for monthly).

*Parameters:*
#cAR[$phi_1, ..., phi_p$, $Phi_1, ..., Phi_P$],
#cMA[$theta_1, ..., theta_q$, $Theta_1, ..., Theta_Q$],
$c$, $sigma^2$ \
*Orders:* #cAR[$p$, $P$], #cDiff[$d$, $D$], #cMA[$q$, $Q$], $m$


#example(title: $"SARIMA"(1, 0, 0)(1, 0, 0)_4$)[
  *Given*
  - Orders: #cAR[$p = 1$, $P = 1$], #cDiff[$d = 0$, $D = 0$], #cMA[$q = 0$, $Q = 0$], $m = 4$
  - Parameters: #cAR[$phi_1 = 0.5$, $Phi_1 = 0.5$], $c = 0$
  - Data:

  #data.show-table(data.x)

  *Step 1 — formula*

  Substitute orders into the SARIMA recursion. With $d = D = 0$ and $q = Q = 0$:
  $ cAR((1 - phi_1 B)) cAR((1 - Phi_1 B^m)) x_t = c + epsilon_t $

  Expand the operator product:
  $ cAR((1 - phi_1 B - Phi_1 B^m + phi_1 Phi_1 B^(m+1))) x_t = c + epsilon_t $
  $ x_t - cAR(phi_1) x_(t-1) - cAR(Phi_1) x_(t-m) + cAR(phi_1 Phi_1) x_(t-m-1) = c + epsilon_t $

  Forecast (set $epsilon_t = 0$):
  $ hat(x)_t = c + cAR(phi_1) x_(t-1) + cAR(Phi_1) x_(t-m) - cAR(phi_1 Phi_1) x_(t-m-1) $

  Innovation:
  $ epsilon_t = x_t - hat(x)_t $

  Pre-compute the cross term: #cAR[$phi_1 Phi_1 = 0.5 dot 0.5 = 0.25$].

  *Step 2 — apply at $t = 6$* (first usable step: needs $x_(t-m-1) = x_1$)

  Plug in #cAR[$phi_1 = 0.5$], #cAR[$Phi_1 = 0.5$], $x_5 = 14$, $x_2 = 10$, $x_1 = 12$:
  $ hat(x)_6 = cAR(0.5) dot 14 + cAR(0.5) dot 10 - cAR(0.25) dot 12 = 7 + 5 - 3 = 9 $
  $ epsilon_6 = x_6 - hat(x)_6 = 12 - 9 = 3 $

  *Step 3 — iterate*

  Each row uses lag-1 ($x_(t-1)$), lag-$m$ ($x_(t-4)$), and lag-$(m+1)$ ($x_(t-5)$).

  #align(center)[
    #table(
      columns: 6,
      inset: 0.45em,
      align: center,
      [$t$],
      [$x_t$],
      [$x_(t-1)$, $x_(t-4)$, $x_(t-5)$],
      [$hat(x)_t = cAR(0.5) x_(t-1) + cAR(0.5) x_(t-4) - cAR(0.25) x_(t-5)$],
      [$hat(x)_t$],
      [$epsilon_t$],

      [6], [12], [$14, 10, 12$], [$cAR(0.5)(14) + cAR(0.5)(10) - cAR(0.25)(12) = 7 + 5 - 3$], [$9$], [$3$],
      [7], [9], [$12, 8, 10$], [$cAR(0.5)(12) + cAR(0.5)(8) - cAR(0.25)(10) = 6 + 4 - 2.5$], [$7.5$], [$1.5$],
      [8], [13], [$9, 11, 8$], [$cAR(0.5)(9) + cAR(0.5)(11) - cAR(0.25)(8) = 4.5 + 5.5 - 2$], [$8$], [$5$],
      [9], [16], [$13, 14, 11$], [$cAR(0.5)(13) + cAR(0.5)(14) - cAR(0.25)(11) = 6.5 + 7 - 2.75$], [$10.75$], [$5.25$],
      [10], [14], [$16, 12, 14$], [$cAR(0.5)(16) + cAR(0.5)(12) - cAR(0.25)(14) = 8 + 6 - 3.5$], [$10.5$], [$3.5$],
      [11], [11], [$14, 9, 12$], [$cAR(0.5)(14) + cAR(0.5)(9) - cAR(0.25)(12) = 7 + 4.5 - 3$], [$8.5$], [$2.5$],
      [12], [15], [$11, 13, 9$], [$cAR(0.5)(11) + cAR(0.5)(13) - cAR(0.25)(9) = 5.5 + 6.5 - 2.25$], [$9.75$], [$5.25$],
      [13], [18], [$15, 16, 13$], [$cAR(0.5)(15) + cAR(0.5)(16) - cAR(0.25)(13) = 7.5 + 8 - 3.25$], [$12.25$], [$5.75$],
      [14], [16], [$18, 14, 16$], [$cAR(0.5)(18) + cAR(0.5)(14) - cAR(0.25)(16) = 9 + 7 - 4$], [$12$], [$4$],
      [15], [13], [$16, 11, 14$], [$cAR(0.5)(16) + cAR(0.5)(11) - cAR(0.25)(14) = 8 + 5.5 - 3.5$], [$10$], [$3$],
      [16],
      [17],
      [$13, 15, 11$],
      [$cAR(0.5)(13) + cAR(0.5)(15) - cAR(0.25)(11) = 6.5 + 7.5 - 2.75$],
      [$11.25$],
      [$5.75$],

      [17], [—], [$17, 18, 15$], [$cAR(0.5)(17) + cAR(0.5)(18) - cAR(0.25)(15) = 8.5 + 9 - 3.75$], [$13.75$], [—],
    )
  ]

  Forecasts now sit much closer to the data than AR(1) — the seasonal lag $x_(t-4)$ tracks the within-cycle pattern, and lag-1 picks up the trend.
]
