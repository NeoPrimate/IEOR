#import "/lib/imports.typ": *
#show: formatting

#import "./summary.typ": cAR, cDiff, cMA
#import "../_data.typ" as data

Seasonal ARIMA with exogenous regressors

$"SARIMAX"(p,d,q)(P,D,Q)_m$

$
  cAR(phi(B)) cAR(Phi(B^m)) cDiff((1-B)^d) cDiff((1-B^m)^D) y_t = c + sum_(i=1)^k beta_i x_(i,t) + cMA(theta(B)) cMA(Theta(B^m)) epsilon_t
$

- $y_t$ = endogenous (target) series
- $x_(i,t)$ = exogenous regressors, $i = 1, dots, k$
- $beta_i$ = regression coefficients on exogenous variables
- The $X$ adds linear regression on external predictors to SARIMA.

*Parameters:*
#cAR[$phi_1, ..., phi_p$, $Phi_1, ..., Phi_P$],
#cMA[$theta_1, ..., theta_q$, $Theta_1, ..., Theta_Q$],
$beta_1, ..., beta_k$, $c$, $sigma^2$ \
*Orders:* #cAR[$p$, $P$], #cDiff[$d$, $D$], #cMA[$q$, $Q$], $m$, $k$ (regressors)


#example(title: $"SARIMAX"(1, 0, 0)(1, 0, 0)_4 + 1 "exog"$)[
  *Given*
  - Orders: #cAR[$p = 1$, $P = 1$], #cDiff[$d = 0$, $D = 0$], #cMA[$q = 0$, $Q = 0$], $m = 4$, $k = 1$
  - Parameters: #cAR[$phi_1 = 0.5$, $Phi_1 = 0.5$], $beta_1 = 0.5$, $c = 0$
  - Endogenous data $y_t = x_t$:

  #data.show-table(data.x, name: "y")

  - Exogenous regressor $z_t$:

  #data.show-table(data.z, name: "z")

  *Step 1 — formula*

  Substitute orders into the SARIMAX recursion. With $d = D = 0$ and $q = Q = 0$:
  $ cAR((1 - phi_1 B)) cAR((1 - Phi_1 B^m)) y_t = c + beta_1 z_t + epsilon_t $

  Expand the operator product (same as SARIMA, plus the exogenous term):
  $ y_t - cAR(phi_1) y_(t-1) - cAR(Phi_1) y_(t-m) + cAR(phi_1 Phi_1) y_(t-m-1) = c + beta_1 z_t + epsilon_t $

  Forecast (set $epsilon_t = 0$):
  $ hat(y)_t = c + beta_1 z_t + cAR(phi_1) y_(t-1) + cAR(Phi_1) y_(t-m) - cAR(phi_1 Phi_1) y_(t-m-1) $

  Innovation:
  $ epsilon_t = y_t - hat(y)_t $

  Pre-compute the cross term: #cAR[$phi_1 Phi_1 = 0.5 dot 0.5 = 0.25$].

  *Step 2 — apply at $t = 6$* (first usable step: needs $y_(t-m-1) = y_1$)

  Plug in $beta_1 = 0.5$, #cAR[$phi_1 = 0.5$], #cAR[$Phi_1 = 0.5$], $z_6 = 6$, $y_5 = 14$, $y_2 = 10$, $y_1 = 12$:
  $ hat(y)_6 = 0 + 0.5 dot 6 + cAR(0.5)(14) + cAR(0.5)(10) - cAR(0.25)(12) $
  $ hat(y)_6 = 3 + 7 + 5 - 3 = 12 $
  $ epsilon_6 = y_6 - hat(y)_6 = 12 - 12 = 0 $

  *Step 3 — iterate*

  Each row adds the exogenous contribution $beta_1 z_t$ on top of the SARIMA forecast.

  #align(center)[
    #table(
      columns: 6,
      inset: 0.45em,
      align: center,
      [$t$],
      [$y_t$],
      [$beta_1 z_t$],
      [SARIMA part: $cAR(0.5) y_(t-1) + cAR(0.5) y_(t-4) - cAR(0.25) y_(t-5)$],
      [$hat(y)_t$],
      [$epsilon_t$],

      [6], [12], [$0.5(6) = 3$], [$cAR(0.5)(14) + cAR(0.5)(10) - cAR(0.25)(12) = 9$], [$3 + 9 = 12$], [$0$],
      [7], [9], [$0.5(7) = 3.5$], [$cAR(0.5)(12) + cAR(0.5)(8) - cAR(0.25)(10) = 7.5$], [$3.5 + 7.5 = 11$], [$-2$],
      [8], [13], [$0.5(8) = 4$], [$cAR(0.5)(9) + cAR(0.5)(11) - cAR(0.25)(8) = 8$], [$4 + 8 = 12$], [$1$],
      [9],
      [16],
      [$0.5(9) = 4.5$],
      [$cAR(0.5)(13) + cAR(0.5)(14) - cAR(0.25)(11) = 10.75$],
      [$4.5 + 10.75 = 15.25$],
      [$0.75$],

      [10],
      [14],
      [$0.5(10) = 5$],
      [$cAR(0.5)(16) + cAR(0.5)(12) - cAR(0.25)(14) = 10.5$],
      [$5 + 10.5 = 15.5$],
      [$-1.5$],

      [11], [11], [$0.5(11) = 5.5$], [$cAR(0.5)(14) + cAR(0.5)(9) - cAR(0.25)(12) = 8.5$], [$5.5 + 8.5 = 14$], [$-3$],
      [12],
      [15],
      [$0.5(12) = 6$],
      [$cAR(0.5)(11) + cAR(0.5)(13) - cAR(0.25)(9) = 9.75$],
      [$6 + 9.75 = 15.75$],
      [$-0.75$],

      [13],
      [18],
      [$0.5(13) = 6.5$],
      [$cAR(0.5)(15) + cAR(0.5)(16) - cAR(0.25)(13) = 12.25$],
      [$6.5 + 12.25 = 18.75$],
      [$-0.75$],

      [14], [16], [$0.5(14) = 7$], [$cAR(0.5)(18) + cAR(0.5)(14) - cAR(0.25)(16) = 12$], [$7 + 12 = 19$], [$-3$],
      [15],
      [13],
      [$0.5(15) = 7.5$],
      [$cAR(0.5)(16) + cAR(0.5)(11) - cAR(0.25)(14) = 10$],
      [$7.5 + 10 = 17.5$],
      [$-4.5$],

      [16],
      [17],
      [$0.5(16) = 8$],
      [$cAR(0.5)(13) + cAR(0.5)(15) - cAR(0.25)(11) = 11.25$],
      [$8 + 11.25 = 19.25$],
      [$-2.25$],

      [17],
      [—],
      [$0.5(17) = 8.5$],
      [$cAR(0.5)(17) + cAR(0.5)(18) - cAR(0.25)(15) = 13.75$],
      [$8.5 + 13.75 = 22.25$],
      [—],
    )
  ]

  Here $z_t = t$ is collinear with $y$'s linear trend, so $beta_1 z_t$ adds an *extra* drift on top of the AR/seasonal structure — forecasts now overshoot. With a less collinear regressor, $beta_1$ would correct part of $y$ that AR/seasonal lags miss.
]
